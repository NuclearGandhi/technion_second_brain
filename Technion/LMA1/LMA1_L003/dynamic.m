% MATLAB Script for Dynamic Thermocouple Analysis

clear;
clc;
close all;

% --- Configuration ---
% Dynamic run temperatures (from filenames like '65.csv')
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
rho_material = 8666; % kg/m^3 (density of thermocouple material)
cp_material = 410;   % J/(kg*°C) (specific heat capacity of thermocouple material)

% Time configuration
dt = 0.01; % seconds per data point (15s / 1500 points)
N_t0_points = 20; % Number of initial points to average for T0

% To store results (e.g., time constants for each TC for each run)
all_time_constants = NaN(num_thermocouples, num_runs); 

disp('--- Starting Dynamic Thermocouple Analysis ---');

% --- Main Loop: Iterate through each dynamic run ---
for run_idx = 1:num_runs
    T_infinity = temperatures_infinity_runs(run_idx);
    run_filename = sprintf('%s%d.csv', data_folder, T_infinity);
    
    fprintf('\nProcessing Run: %s (T_infinity = %.1f°C)\n', run_filename, T_infinity);
    
    if ~exist(run_filename, 'file')
        fprintf('  WARNING: File %s not found. Skipping this run.\n', run_filename);
        continue;
    end
    
    try
        full_data = readmatrix(run_filename);
    catch ME
        fprintf('  ERROR reading file %s: %s. Skipping this run.\n', run_filename, ME.message);
        continue;
    end
    
    num_data_points = size(full_data, 1);
    time_vector = (0:num_data_points-1)' * dt; % seconds
    
    figure_run = figure; % Create a new figure for each run
    hold on;
    legend_entries_run = cell(num_thermocouples, 1);
    
    % --- Inner Loop: Iterate through each thermocouple ---
    for tc_idx = 1:num_thermocouples
        tc_name = thermocouples_config(tc_idx).name;
        tc_col = thermocouples_config(tc_idx).column;
        S_tc = thermocouples_config(tc_idx).sensitivity;
        V0_tc = thermocouples_config(tc_idx).offset_voltage;
        
        fprintf('  Processing Thermocouple: %s (Column %d)\n', tc_name, tc_col);
        
        if size(full_data, 2) < tc_col
            fprintf('    WARNING: File %s has fewer than %d columns. Skipping TC %s for this run.\n', ...
                    run_filename, tc_col, tc_name);
            continue;
        end
        
        voltage_tc = full_data(:, tc_col);
        
        % Convert voltage to temperature
        temperature_tc_t = (voltage_tc - V0_tc) / S_tc;
        
        % Estimate T0 (initial temperature)
        if num_data_points >= N_t0_points
            T0_tc = mean(temperature_tc_t(1:N_t0_points));
        else
            T0_tc = mean(temperature_tc_t); % Use all points if fewer than N_t0_points
        end
        fprintf('    Estimated T0 for %s: %.2f°C\n', tc_name, T0_tc);
        
        % --- A. Plot T(t) vs. time ---
        plot(time_vector, temperature_tc_t, 'DisplayName', [num2str(tc_name), ' (T_0=', num2str(T0_tc), '°C)']);
        legend_entries_run{tc_idx} = sprintf('%s (T0=%.1f°C)', tc_name, T0_tc);
        
        % --- C. Prepare for ln plot and find tau ---
        % We need to select the relevant part of the data for the exponential fit
        % Condition: T0 < T(t) < T_infinity (for heating) or T0 > T(t) > T_infinity (for cooling)
        % and avoid division by zero or log of non-positive
        
        valid_indices_for_ln = [];
        if T_infinity > T0_tc % Heating
            valid_indices_for_ln = find(temperature_tc_t > T0_tc & temperature_tc_t < T_infinity & (T_infinity - T0_tc) ~= 0);
        else % Cooling (or T_infinity == T0_tc, though less likely for this experiment)
            valid_indices_for_ln = find(temperature_tc_t < T0_tc & temperature_tc_t > T_infinity & (T_infinity - T0_tc) ~= 0);
        end
        
        % Further refine to select a segment where the exponential decay/rise is prominent
        % This might involve selecting data up to where T(t) reaches, e.g., 95% of (T_infinity - T0_tc)
        if isempty(valid_indices_for_ln)
             fprintf('    WARNING for %s: No valid data points found for ln plot after initial filtering. Tau cannot be calculated for this run.\n', tc_name);
             all_time_constants(tc_idx, run_idx) = NaN;
             continue; % Skip to next thermocouple if no valid data for ln plot
        end

        % Select a segment of the data for fitting tau.
        % Heuristic: from the point T(t) has changed by 10% of total change,
        % up to the point T(t) has achieved 63% of total change (approx 1 tau)
        % or up to 95% of total change for a more robust fit if data is clean.
        
        % Let's define a range for fitting. For heating (T_inf > T0):
        % Start when T(t) is slightly above T0. End before T(t) gets too close to T_inf.
        % (T(t) - T_inf) / (T0 - T_inf)
        
        % Ensure (temperature_tc_t(valid_indices_for_ln) - T_infinity) and (T0_tc - T_infinity) are not zero
        numerator_ln = temperature_tc_t(valid_indices_for_ln) - T_infinity;
        denominator_ln = T0_tc - T_infinity;

        % Filter out points where numerator is zero (T(t) == T_inf) or has wrong sign relative to (T0-T_inf)
        % This implies (T(t)-T_inf)/(T0-T_inf) should be positive
        ratio_for_ln = numerator_ln ./ denominator_ln;
        fit_indices = valid_indices_for_ln(ratio_for_ln > 1e-6); % Must be positive for log, avoid zero
                                                              % and typically < 1 for decay towards T_inf

        if length(fit_indices) < 2 % Need at least 2 points for polyfit
            fprintf('    WARNING for %s: Not enough valid data points for ln plot fitting after filtering. Tau cannot be calculated for this run.\n', tc_name);
            all_time_constants(tc_idx, run_idx) = NaN;
            continue;
        end
        
        selected_time = time_vector(fit_indices);
        selected_ratio = ratio_for_ln(ratio_for_ln > 1e-6); % Corresponding ratios
        
        y_transform = log(selected_ratio); 
        
        % Fit: y_transform = m * selected_time + c (ideally c is 0)
        % We want to fit y = (-1/tau) * t
        % Using polyfit for y = slope * t
        % To ensure it goes through origin, we can formulate as A*x = B where x = [-1/tau]
        % Here, A = selected_time, B = y_transform. x = A\\B;
        
        if isempty(selected_time) || isempty(y_transform)
             fprintf('    WARNING for %s: selected_time or y_transform is empty. Tau cannot be calculated for this run.\n', tc_name);
             all_time_constants(tc_idx, run_idx) = NaN;
             continue;
        end

        p_fit = polyfit(selected_time, y_transform, 1);
        slope_ln_plot = p_fit(1);
        
        if slope_ln_plot >= 0 % Slope should be negative
            fprintf('    WARNING for %s: Slope of ln plot is non-negative (%.4f). Check data or T0/T_inf. Tau cannot be reliably calculated.\n', tc_name, slope_ln_plot);
            all_time_constants(tc_idx, run_idx) = NaN;
        else
            tau_tc_run = -1 / slope_ln_plot;
            all_time_constants(tc_idx, run_idx) = tau_tc_run;
            fprintf('    Calculated Time Constant (tau) for %s: %.4f s\n', tc_name, tau_tc_run);
            
            % Optional: Plot for verification (can be many plots)
            % figure;
            % plot(selected_time, y_transform, 'bo', 'DisplayName', 'Transformed Data');
            % hold on;
            % plot(selected_time, polyval(p_fit, selected_time), 'r-', 'DisplayName', sprintf('Fit (slope=%.2f)', slope_ln_plot));
            % xlabel('Time (s)');
            % ylabel('ln((T(t)-Tinf)/(T0-Tinf))');
            % title(sprintf('Ln Plot for %s, Run Tinf=%.0fC', tc_name, T_infinity));
            % legend show; grid on;
        end

    end % End of thermocouple loop for the current run
    
    hold off;
    xlabel('Time (s)', 'Interpreter', 'latex');
    ylabel('Temperature ($^{\circ}$C)', 'Interpreter', 'latex');
    title(['Dynamic Response at $T_{\infty} = ', num2str(T_infinity), '^{\circ}$C']);
    legend(legend_entries_run(~cellfun('isempty',legend_entries_run)), 'Location', 'best', 'Interpreter', 'latex');
    grid on;
    saveas(figure_run, sprintf('dynamic_response_run_%.0fC.png', T_infinity));
    fprintf('  Dynamic response plot saved as dynamic_response_run_%.0fC.png\n', T_infinity);

end % End of dynamic run loop

% --- Post-run Analysis (Average Tau, Calculate h, Calculate radii) ---
disp('--- Post-Run Analysis ---');

% Calculate average time constants for each thermocouple
avg_time_constants = NaN(num_thermocouples, 1);
fprintf('\nAverage Time Constants:\n');
for tc_idx = 1:num_thermocouples
    valid_taus = all_time_constants(tc_idx, ~isnan(all_time_constants(tc_idx, :)));
    if ~isempty(valid_taus)
        avg_time_constants(tc_idx) = mean(valid_taus);
        fprintf('  %s: %.4f s (from %d valid runs)\n', thermocouples_config(tc_idx).name, avg_time_constants(tc_idx), length(valid_taus));
    else
        fprintf('  %s: No valid time constants calculated.\n', thermocouples_config(tc_idx).name);
    end
end

% E. Find the Convection Coefficient (h) using the smallest thermocouple (TC5)
tc5_idx = find(strcmp({thermocouples_config.name}, 'TC5'));
if ~isempty(tc5_idx) && ~isnan(avg_time_constants(tc5_idx))
    r_tc5 = thermocouples_config(tc5_idx).measured_diameter_m / 2;
    tau_tc5_avg = avg_time_constants(tc5_idx);
    
    h_convection = (rho_material * r_tc5 * cp_material) / (3 * tau_tc5_avg);
    fprintf('\nCalculated Convection Coefficient (h) using TC5 (d=%.1fmm, tau=%.3fs): %.2f W/(m^2*°C)\n', ...
        thermocouples_config(tc5_idx).measured_diameter_m*1000, tau_tc5_avg, h_convection);
else
    fprintf('\nCould not calculate convection coefficient (h): Missing data for TC5 or its time constant.\n');
    h_convection = NaN; % Set to NaN if cannot be calculated
end

% F. Calculate Radii of Other Thermocouples and Compare
fprintf('\nCalculated vs. Measured Diameters (assuming constant h=%.2f W/(m^2*°C)):\n', h_convection);
fprintf('-------------------------------------------------------------------------------------\n');
fprintf('TC  | Measured Diameter (mm) | Calculated Diameter (mm) | Difference (mm) | Tau_avg (s)\n');
fprintf('-------------------------------------------------------------------------------------\n');

if ~isnan(h_convection)
    for tc_idx = 1:num_thermocouples
        tc_name = thermocouples_config(tc_idx).name;
        measured_d_mm = thermocouples_config(tc_idx).measured_diameter_m * 1000;
        
        if ~isnan(avg_time_constants(tc_idx))
            tau_tc_avg = avg_time_constants(tc_idx);
            % r_calc = (3 * h * tau) / (rho * cp)
            r_tc_calc = (3 * h_convection * tau_tc_avg) / (rho_material * cp_material);
            d_tc_calc_mm = r_tc_calc * 2 * 1000;
            diff_mm = d_tc_calc_mm - measured_d_mm;
            fprintf('%-3s | %22.2f | %24.2f | %15.2f | %.3f\n', ...
                    tc_name, measured_d_mm, d_tc_calc_mm, diff_mm, tau_tc_avg);
        else
            fprintf('%-3s | %22.2f | %24s | %15s | N/A\n', ...
                    tc_name, measured_d_mm, 'N/A (no tau)', 'N/A');
        end
    end
else
    fprintf('Cannot calculate diameters as convection coefficient (h) was not determined.\n');
end
fprintf('-------------------------------------------------------------------------------------\n');
disp('Discussion for Part F:');
disp('  - Compare the calculated diameters to the caliper measurements.');
disp('  - Can differences be explained by random errors? Consider uncertainties in:');
disp('    - Time constant (tau) determination (sensitive to fit range, noise).');
disp('    - Measured diameter (caliper accuracy).');
disp('    - Assumption of constant ''h'' for all thermocouples (shape differences, flow variations).');
disp('    - Uniformity of thermocouple material properties (rho, cp).');
disp('    - Accuracy of T0 and T_infinity estimation.');

disp('Script execution complete.');

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
