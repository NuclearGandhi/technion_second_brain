% MATLAB Script for Dynamic Thermocouple Analysis

clear;
clc;
close all;

% --- Configuration ---
temperatures_infinity_runs = [65, 70, 78]; % °C
num_runs = length(temperatures_infinity_runs);
data_folder = 'dynamic/';

% Thermocouple configurations
% TC1: Sensitivity (S_tc1) = 3.8009e-05 V/°C, Offset (V0_tc1) = -8.4696e-04 V, Measured Diameter = 1.4mm
% TC5: Sensitivity (S_tc5) = 2.9971e-05 V/°C, Offset (V0_tc5) = -1.7305e-03 V, Measured Diameter = 0.7mm
% TC7: Sensitivity (S_tc7) = 2.8579e-05 V/°C, Offset (V0_tc7) = -1.7186e-03 V, Measured Diameter = 1.3mm

thermocouples_config = struct(...
    'name',            {'TC1', 'TC5', 'TC7'}, ...
    'column',          {1, 5, 7}, ...
    'sensitivity',     {3.8009e-05, 2.9971e-05, 2.8579e-05}, ... % V/°C
    'offset_voltage',  {-8.4696e-04, -1.7305e-03, -1.7186e-03}, ... % V
    'measured_diameter_m', {1.4e-3, 0.7e-3, 1.3e-3} ... % m
);
num_thermocouples = length(thermocouples_config);

% Physical constants
rho_material = 8666; % kg/m³
cp_material = 410;   % J/(kg·°C)

% Time configuration
dt = 0.01; % seconds per data point
N_t0_points = 20; % Number of initial points to average for T0

% Results storage
all_time_constants = NaN(num_thermocouples, num_runs); 

disp('--- Starting Dynamic Thermocouple Analysis ---');

% --- Main Loop: Process each dynamic run ---
for run_idx = 1:num_runs
    T_infinity = temperatures_infinity_runs(run_idx);
    run_filename = sprintf('%s%d.csv', data_folder, T_infinity);
    
    fprintf('\nProcessing Run: T_∞ = %.1f°C\n', T_infinity);
    
    % Load data
    if ~exist(run_filename, 'file')
        fprintf('  File not found. Skipping.\n');
        continue;
    end
    
    full_data = readmatrix(run_filename);
    num_data_points = size(full_data, 1);
    time_vector = (0:num_data_points-1)' * dt;
    
    % Create figure for this run
    figure_run = figure;
    hold on;
    legend_entries_run = {};
    
    % --- Process each thermocouple ---
    for tc_idx = 1:num_thermocouples
        tc_name = thermocouples_config(tc_idx).name;
        tc_col = thermocouples_config(tc_idx).column;
        S_tc = thermocouples_config(tc_idx).sensitivity;
        V0_tc = thermocouples_config(tc_idx).offset_voltage;
        
        % Skip if column doesn't exist
        if size(full_data, 2) < tc_col
            continue;
        end
        
        voltage_tc = full_data(:, tc_col);
        temperature_tc_t = (voltage_tc - V0_tc) / S_tc;
        
        % Estimate T0 (initial temperature)
        T0_tc = mean(temperature_tc_t(1:min(N_t0_points, num_data_points)));
        
        % Plot T(t) vs. time
        plot(time_vector, temperature_tc_t, 'DisplayName', sprintf('%s ($T_0=%.1f^\\circ$C)', tc_name, T0_tc));
        legend_entries_run{end+1} = sprintf('%s ($T_0=%.1f^\\circ$C)', tc_name, T0_tc);
        
        % Calculate time constant
        % Find valid data range for exponential fit
        if T_infinity > T0_tc % Heating
            valid_indices = find(temperature_tc_t > T0_tc & temperature_tc_t < T_infinity);
        else % Cooling
            valid_indices = find(temperature_tc_t < T0_tc & temperature_tc_t > T_infinity);
        end
        
        if length(valid_indices) < 2
            all_time_constants(tc_idx, run_idx) = NaN;
            continue;
        end
        
        % Prepare ln plot data
        numerator_ln = temperature_tc_t(valid_indices) - T_infinity;
        denominator_ln = T0_tc - T_infinity;
        ratio_for_ln = numerator_ln ./ denominator_ln;
        
        % Filter valid points for fitting
        fit_indices = valid_indices(ratio_for_ln > 1e-6);
        
        if length(fit_indices) < 2
            all_time_constants(tc_idx, run_idx) = NaN;
            continue;
        end
        
        selected_time = time_vector(fit_indices);
        selected_ratio = ratio_for_ln(ratio_for_ln > 1e-6);
        y_transform = log(selected_ratio);
        
        % Linear fit to find time constant
        p_fit = polyfit(selected_time, y_transform, 1);
        slope_ln_plot = p_fit(1);
        
        if slope_ln_plot < 0
            tau_tc_run = -1 / slope_ln_plot;
            all_time_constants(tc_idx, run_idx) = tau_tc_run;
            fprintf('  %s: τ = %.3f s\n', tc_name, tau_tc_run);
        else
            all_time_constants(tc_idx, run_idx) = NaN;
        end
    end
    
    % Format and save figure
    xlabel('Time (s)');
    ylabel('Temperature ($^\circ$C)');
    title(sprintf('Dynamic Response at $T_{\\infty} = %d^\\circ$C', T_infinity));
    legend('Location', 'best');
    grid on;
    
    % Set figure size and export at high quality
    set(figure_run, 'Position', [100, 100, 800, 600]);
    fig_filename = sprintf('dynamic_response_T%dC', T_infinity);
    print(figure_run, fig_filename, '-dpng', '-r300');
    fprintf('  Figure saved as %s.png (800x600, 300 DPI)\n', fig_filename);
end

% --- Post-Analysis: Calculate averages and convection coefficient ---
disp('--- Results Summary ---');

% Calculate average time constants
avg_time_constants = NaN(num_thermocouples, 1);
fprintf('\nAverage Time Constants:\n');
for tc_idx = 1:num_thermocouples
    valid_taus = all_time_constants(tc_idx, ~isnan(all_time_constants(tc_idx, :)));
    if ~isempty(valid_taus)
        avg_time_constants(tc_idx) = mean(valid_taus);
        fprintf('  %s: %.3f s\n', thermocouples_config(tc_idx).name, avg_time_constants(tc_idx));
    end
end

% Calculate convection coefficient using TC5 (smallest diameter)
tc5_idx = find(strcmp({thermocouples_config.name}, 'TC5'));
if ~isempty(tc5_idx) && ~isnan(avg_time_constants(tc5_idx))
    r_tc5 = thermocouples_config(tc5_idx).measured_diameter_m / 2;
    tau_tc5_avg = avg_time_constants(tc5_idx);
    h_convection = (rho_material * r_tc5 * cp_material) / (3 * tau_tc5_avg);
    fprintf('\nConvection Coefficient: h = %.1f W/(m²·°C)\n', h_convection);
else
    h_convection = NaN;
    fprintf('\nCould not calculate convection coefficient.\n');
end

% Compare calculated vs measured diameters
fprintf('\nDiameter Comparison:\n');
fprintf('TC  | Measured (mm) | Calculated (mm) | Difference (mm)\n');
fprintf('----|--------------|-----------------|-----------------\n');

if ~isnan(h_convection)
    for tc_idx = 1:num_thermocouples
        tc_name = thermocouples_config(tc_idx).name;
        measured_d_mm = thermocouples_config(tc_idx).measured_diameter_m * 1000;
        
        if ~isnan(avg_time_constants(tc_idx))
            tau_tc_avg = avg_time_constants(tc_idx);
            r_tc_calc = (3 * h_convection * tau_tc_avg) / (rho_material * cp_material);
            d_tc_calc_mm = r_tc_calc * 2 * 1000;
            diff_mm = d_tc_calc_mm - measured_d_mm;
            fprintf('%-3s | %12.2f | %15.2f | %15.2f\n', tc_name, measured_d_mm, d_tc_calc_mm, diff_mm);
        else
            fprintf('%-3s | %12.2f | %15s | %15s\n', tc_name, measured_d_mm, 'N/A', 'N/A');
        end
    end
end

    % Create summary figure
    figure_summary = figure;
    if any(~isnan(avg_time_constants))
        diameters_mm = [thermocouples_config.measured_diameter_m] * 1000;
        valid_idx = ~isnan(avg_time_constants);
        
        scatter(diameters_mm(valid_idx), avg_time_constants(valid_idx), 100, 'filled');
        xlabel('Diameter (mm)');
        ylabel('Time Constant $\\tau$ (s)');
        title('Time Constant vs Thermocouple Diameter');
        grid on;
        
        % Add labels for each point
        for tc_idx = find(valid_idx)
            text(diameters_mm(tc_idx), avg_time_constants(tc_idx), ...
                 sprintf('  %s', thermocouples_config(tc_idx).name), ...
                 'VerticalAlignment', 'middle');
        end
        
        % Set figure size and export at high quality
        set(figure_summary, 'Position', [100, 100, 800, 600]);
        print(figure_summary, 'tau_vs_diameter', '-dpng', '-r300');
        fprintf('\nSummary plot saved as tau_vs_diameter.png (800x600, 300 DPI)\n');
    end

disp('Analysis complete.');

% Explanation of the formula (Part B of instructions)
% T(t) = T_infinity + (T0 - T_infinity) * exp(-t/tau)
% T(t): Temperature of the thermocouple at time t.
% T_infinity: Temperature of the surrounding fluid (hot water), the steady-state temperature.
% T0: Initial temperature of the thermocouple (air temperature).
% tau: Time constant of the thermocouple, characterizing its response speed.
%      It's the time taken for the temperature to change by (1 - 1/e) or ~63.2% of the total difference (T_infinity - T0).
% e: Base of the natural logarithm.
% t: Time.
% The term (T(t) - T_infinity) / (T0 - T_infinity) represents the non-dimensionalized temperature.
% Taking the natural log: ln((T(t) - T_infinity) / (T0 - T_infinity)) = -t/tau.
% This shows a linear relationship between the logged term and time, with a slope of -1/tau.
