% MATLAB Script for Dynamic Thermocouple Analysis

clear;
clc;
close all;

% --- Configuration ---
% Data files are now in .m format with naming pattern: data_dy_X_TYY.m
% where X is the run number and YY is the temperature
data_folder = 'dynamic/';

% Extract temperature information from available data files
data_files = dir(fullfile(data_folder, 'data_dy_*_T*.m'));
temperatures_infinity_runs = [];
run_numbers = [];

% Parse filenames to extract temperatures and run numbers
for i = 1:length(data_files)
    filename = data_files(i).name;
    % Extract temperature and run number from filename pattern data_dy_X_TYY.m
    temp_match = regexp(filename, 'data_dy_(\d+)_T(\d+)\.m', 'tokens');
    if ~isempty(temp_match)
        run_num = str2double(temp_match{1}{1});
        temp = str2double(temp_match{1}{2});
        run_numbers(end+1) = run_num;
        temperatures_infinity_runs(end+1) = temp;
    end
end

% Sort by temperature
[temperatures_infinity_runs, sort_idx] = sort(temperatures_infinity_runs);
run_numbers = run_numbers(sort_idx);
num_runs = length(temperatures_infinity_runs);

fprintf('Found %d dynamic runs: ', num_runs);
for i = 1:num_runs
    fprintf('Run %d at %.0f°C ', run_numbers(i), temperatures_infinity_runs(i));
end
fprintf('\n');

% Thermocouple configurations (Updated with calibrated values from static analysis)
% TC1: Sensitivity (S_tc1) = 3.9917e-05 V/°C, Offset (V0_tc1) = -8.1431e-04 V, Measured Diameter = 1.4mm
% TC5: Sensitivity (S_tc5) = 4.1845e-05 V/°C, Offset (V0_tc5) = -6.0133e-05 V, Measured Diameter = 0.9mm (caliper measurement)
% TC7: Sensitivity (S_tc7) = 4.2038e-05 V/°C, Offset (V0_tc7) = -5.9380e-05 V, Measured Diameter = 1.3mm

thermocouples_config = struct(...
    'name',            {'TC1', 'TC5', 'TC7'}, ...
    'column',          {1, 5, 7}, ...
    'sensitivity',     {3.9917e-05, 4.1845e-05, 4.2038e-05}, ... % V/°C (calibrated values)
    'offset_voltage',  {-8.1431e-04, -6.0133e-05, -5.9380e-05}, ... % V (calibrated values)
    'measured_diameter_m', {1.4e-3, 0.9e-3, 1.3e-3} ... % m (caliper measurements)
);
num_thermocouples = length(thermocouples_config);

% Physical constants
rho_material = 8666; % kg/m³
cp_material = 410;   % J/(kg·°C)

% Time configuration
dt = 0.01; % seconds per data point
N_t0_points = 20; % Number of initial points to average for T0

% Process start times for each temperature (in seconds)
start_times = containers.Map({59, 60, 62}, {2.8, 4.16, 4.42});

% Fitting time limits for each temperature (in seconds after process start)
% These limits avoid noisy data at the end of measurements
fitting_time_limits = containers.Map({59, 60, 62}, {0.3, 0.3, 0.2});

% Results storage
all_time_constants = NaN(num_thermocouples, num_runs); 

disp('--- Starting Dynamic Thermocouple Analysis ---');

% --- Main Loop: Process each dynamic run ---
for run_idx = 1:num_runs
    T_infinity = temperatures_infinity_runs(run_idx);
    current_run_num = run_numbers(run_idx);
    run_filename = sprintf('%sdata_dy_%d_T%.0f.m', data_folder, current_run_num, T_infinity);
    
    fprintf('\nProcessing Run: T_∞ = %.1f°C (Run %d)\n', T_infinity, current_run_num);
    
    % Load data
    if ~exist(run_filename, 'file')
        fprintf('  File not found. Skipping.\n');
        continue;
    end
    
    try
        % Load the .m data file using load with -mat flag
        % The data is stored in a variable called 'data'
        loaded_data = load(run_filename, '-mat');
        
        if isfield(loaded_data, 'data')
            full_data = loaded_data.data;
            fprintf('  Loaded data matrix: %dx%d\n', size(full_data, 1), size(full_data, 2));
        else
            error('Data variable not found in loaded file');
        end
    catch ME
        fprintf('  ERROR loading file %s: %s\n', run_filename, ME.message);
        continue;
    end
    
    num_data_points = size(full_data, 1);
    full_time_vector = (0:num_data_points-1)' * dt;
    
    % Determine process start time and trim data accordingly
    if isKey(start_times, T_infinity)
        process_start_time = start_times(T_infinity);
        start_index = round(process_start_time / dt) + 1;
        
        if start_index <= num_data_points
            % Trim data to start from process beginning
            full_data = full_data(start_index:end, :);
            time_vector = (0:size(full_data, 1)-1)' * dt; % Reset time to start from 0
            num_data_points = size(full_data, 1);
            
            fprintf('  Process starts at t=%.2fs, trimmed %d initial data points\n', ...
                    process_start_time, start_index-1);
        else
            fprintf('  Warning: Start time %.2fs exceeds data length, using full data\n', process_start_time);
            time_vector = full_time_vector;
        end
    else
        fprintf('  Warning: No start time defined for T=%.0f°C, using full data\n', T_infinity);
        time_vector = full_time_vector;
    end
    
    % Create figures for this run
    figure_run = figure;
    hold on;
    legend_entries_run = {};
    
    figure_ln = figure;
    hold on;
    legend_entries_ln = {};
    
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
        
        % Plot T(t) vs. time on first figure
        figure(figure_run);
        plot(time_vector, temperature_tc_t, 'DisplayName', sprintf('%s ($T_0=%.1f^\\circ$C)', tc_name, T0_tc));
        legend_entries_run{end+1} = sprintf('%s ($T_0=%.1f^\\circ$C)', tc_name, T0_tc);
        
        % Calculate time constant
        % Apply time limit for fitting if specified
        if isKey(fitting_time_limits, T_infinity)
            max_fit_time = fitting_time_limits(T_infinity);
            time_limited_indices = find(time_vector <= max_fit_time);
            if tc_idx == 1 % Print only once per run
                fprintf('  Using fitting time range: 0 to %.2fs\n', max_fit_time);
            end
        else
            time_limited_indices = 1:length(time_vector);
            if tc_idx == 1 % Print only once per run
                fprintf('  Using full time range for fitting\n');
            end
        end
        
        % Find valid data range for exponential fit within time limits
        if T_infinity > T0_tc % Heating
            valid_indices = find(temperature_tc_t > T0_tc & temperature_tc_t < T_infinity);
        else % Cooling
            valid_indices = find(temperature_tc_t < T0_tc & temperature_tc_t > T_infinity);
        end
        
        % Combine time limit with valid temperature range
        valid_indices = intersect(valid_indices, time_limited_indices);
        
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
            
            % Plot ln plot on second figure
            figure(figure_ln);
            h_data = plot(selected_time, y_transform, 'o-', 'DisplayName', sprintf('%s (\\tau=%.3fs)', tc_name, tau_tc_run));
            legend_entries_ln{end+1} = sprintf('%s (\\tau=%.3fs)', tc_name, tau_tc_run);
            
            % Plot fitted line with same color as data
            fitted_line = polyval(p_fit, selected_time);
            plot(selected_time, fitted_line, '--', 'Color', h_data.Color, 'DisplayName', sprintf('%s fit', tc_name));
        else
            all_time_constants(tc_idx, run_idx) = NaN;
        end
    end
    
    % Format and save temperature figure
    figure(figure_run);
    xlabel('Time (s)');
    ylabel('Temperature ($^\circ$C)');
    title(sprintf('Dynamic Response at $T_{\\infty} = %d^\\circ$C', T_infinity));
    legend('Location', 'best');
    grid on;
    
    % Set figure size and export at high quality
    set(figure_run, 'Position', [100, 100, 800, 600]);
    fig_filename = sprintf('dynamic_response_T%dC_run%d', T_infinity, current_run_num);
    print(figure_run, fig_filename, '-dpng', '-r300');
    fprintf('  Temperature figure saved as %s.png (800x600, 300 DPI)\n', fig_filename);
    
    % Format and save ln figure
    figure(figure_ln);
    xlabel('Time (s)');
    ylabel('$\ln\left(\frac{T(t) - T_\infty}{T_0 - T_\infty}\right)$');
    title(sprintf('Natural Log Plot at $T_{\\infty} = %d^\\circ$C', T_infinity));
    legend('Location', 'best');
    grid on;
    
    % Set figure size and export at high quality
    set(figure_ln, 'Position', [900, 100, 800, 600]);
    fig_ln_filename = sprintf('ln_plot_T%dC_run%d', T_infinity, current_run_num);
    print(figure_ln, fig_ln_filename, '-dpng', '-r300');
    fprintf('  Ln plot figure saved as %s.png (800x600, 300 DPI)\n', fig_ln_filename);
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
fprintf('TC  | Measured (mm) | Calculated (mm) | Difference (mm) | Uncertainty (mm)\n');
fprintf('----|--------------|-----------------|-----------------|------------------\n');

% Measurement uncertainties
caliper_uncertainty_mm = 0.05; % Typical caliper uncertainty ±0.05 mm
material_prop_uncertainty = 0.05; % 5% uncertainty in material properties
tau_relative_uncertainty = 0.10; % 10% uncertainty in time constant measurement

if ~isnan(h_convection)
    for tc_idx = 1:num_thermocouples
        tc_name = thermocouples_config(tc_idx).name;
        measured_d_mm = thermocouples_config(tc_idx).measured_diameter_m * 1000;
        
        if ~isnan(avg_time_constants(tc_idx))
            tau_tc_avg = avg_time_constants(tc_idx);
            r_tc_calc = (3 * h_convection * tau_tc_avg) / (rho_material * cp_material);
            d_tc_calc_mm = r_tc_calc * 2 * 1000;
            diff_mm = d_tc_calc_mm - measured_d_mm;
            
            % Calculate uncertainty in calculated diameter
            % δd_calc = d_calc * sqrt((δτ/τ)² + (δρ/ρ)² + (δcp/cp)²)
            relative_uncertainty_calc = sqrt(tau_relative_uncertainty^2 + ...
                                           material_prop_uncertainty^2 + ...
                                           material_prop_uncertainty^2);
            calc_d_uncertainty_mm = d_tc_calc_mm * relative_uncertainty_calc;
            
            fprintf('%-3s | %12.2f | %15.2f | %15.2f | ±%.2f / ±%.2f\n', ...
                    tc_name, measured_d_mm, d_tc_calc_mm, diff_mm, ...
                    caliper_uncertainty_mm, calc_d_uncertainty_mm);
        else
            fprintf('%-3s | %12.2f | %15s | %15s | %16s\n', tc_name, measured_d_mm, 'N/A', 'N/A', 'N/A');
        end
    end
end

% Statistical analysis of diameter differences
fprintf('\n--- Statistical Analysis of Diameter Differences ---\n');
if ~isnan(h_convection)
    differences = [];
    relative_errors = [];
    
    for tc_idx = 1:num_thermocouples
        if ~isnan(avg_time_constants(tc_idx))
            measured_d_mm = thermocouples_config(tc_idx).measured_diameter_m * 1000;
            tau_tc_avg = avg_time_constants(tc_idx);
            r_tc_calc = (3 * h_convection * tau_tc_avg) / (rho_material * cp_material);
            d_tc_calc_mm = r_tc_calc * 2 * 1000;
            diff_mm = d_tc_calc_mm - measured_d_mm;
            rel_error = abs(diff_mm) / measured_d_mm * 100;
            
            differences(end+1) = diff_mm;
            relative_errors(end+1) = rel_error;
        end
    end
    
    if ~isempty(differences)
        mean_diff = mean(abs(differences));
        std_diff = std(differences);
        max_rel_error = max(relative_errors);
        
        fprintf('Mean absolute difference: %.2f mm\n', mean_diff);
        fprintf('Standard deviation of differences: %.2f mm\n', std_diff);
        fprintf('Maximum relative error: %.1f%%\n', max_rel_error);
        
        fprintf('\nAnalysis:\n');
        if max_rel_error < 10
            fprintf('- The differences are relatively small (< 10%% relative error)\n');
            fprintf('- These differences can likely be attributed to random measurement errors\n');
        elseif max_rel_error < 20
            fprintf('- The differences are moderate (10-20%% relative error)\n');
            fprintf('- Some systematic effects may be present in addition to random errors\n');
        else
            fprintf('- The differences are large (> 20%% relative error)\n');
            fprintf('- Systematic effects likely dominate over random measurement errors\n');
        end
        
        fprintf('- Typical caliper measurement uncertainty: ±0.02-0.05 mm\n');
        fprintf('- Heat transfer measurement uncertainties may also contribute\n');
    end
end

% Welch's t-test analysis for diameter comparison
fprintf('\n--- Welch''s t-test Analysis ---\n');
if ~isnan(h_convection)
    for tc_idx = 1:num_thermocouples
        tc_name = thermocouples_config(tc_idx).name;
        
        if ~isnan(avg_time_constants(tc_idx))
            % Measured diameter and uncertainty
            d_measured_mm = thermocouples_config(tc_idx).measured_diameter_m * 1000;
            delta_d_measured_mm = caliper_uncertainty_mm;
            
            % Calculated diameter and uncertainty
            tau_tc_avg = avg_time_constants(tc_idx);
            r_tc_calc = (3 * h_convection * tau_tc_avg) / (rho_material * cp_material);
            d_calculated_mm = r_tc_calc * 2 * 1000;
            
            % Calculate uncertainty in calculated diameter
            relative_uncertainty_calc = sqrt(tau_relative_uncertainty^2 + ...
                                           material_prop_uncertainty^2 + ...
                                           material_prop_uncertainty^2);
            delta_d_calculated_mm = d_calculated_mm * relative_uncertainty_calc;
            
            % Welch's t-test statistic: t = |d_calc - d_meas| / sqrt(δd_calc² + δd_meas²)
            numerator_t = abs(d_calculated_mm - d_measured_mm);
            denominator_t = sqrt(delta_d_calculated_mm^2 + delta_d_measured_mm^2);
            
            if denominator_t > 0
                t_statistic = numerator_t / denominator_t;
                
                fprintf('\n%s Welch''s t-test:\n', tc_name);
                fprintf('  Measured diameter: %.2f ± %.2f mm\n', d_measured_mm, delta_d_measured_mm);
                fprintf('  Calculated diameter: %.2f ± %.2f mm\n', d_calculated_mm, delta_d_calculated_mm);
                fprintf('  Difference: %.2f mm\n', d_calculated_mm - d_measured_mm);
                fprintf('  t-statistic: %.3f\n', t_statistic);
                
                % Interpretation
                if t_statistic < 1
                    fprintf('  Interpretation: Small difference (t < 1), measurements are consistent\n');
                elseif t_statistic < 2
                    fprintf('  Interpretation: Moderate difference (1 ≤ t < 2), some disagreement\n');
                else
                    fprintf('  Interpretation: Large difference (t ≥ 2), significant disagreement\n');
                end
                
                % Rough p-value estimation (assuming normal distribution)
                p_value_approx = 2 * (1 - normcdf(t_statistic)); % Two-tailed test
                fprintf('  Approximate p-value: %.3f\n', p_value_approx);
                
                if p_value_approx < 0.05
                    fprintf('  Result: Significant difference (p < 0.05)\n');
                else
                    fprintf('  Result: No significant difference (p ≥ 0.05)\n');
                end
            else
                fprintf('\n%s: Cannot calculate t-statistic (zero combined uncertainty)\n', tc_name);
            end
        else
            fprintf('\n%s: No valid time constant data for t-test\n', tc_name);
        end
    end
end

disp('Analysis complete.');

% ==================== FORMULA EXPLANATION ====================
% התפלגות הטמפרטורה כפונקציה של הזמן:
% T(t) = T_∞ + (T0 - T_∞) * exp(-t/τ)
%
% משמעות האיברים:
% T(t): טמפרטורת המדיד בזמן t
% T_∞: טמפרטורת הנוזל הסובב (מים חמים) - הטמפרטורה הסופית במצב יציב  
% T0: הטמפרטורה הראשונית של המדיד (טמפרטורת האוויר)
% τ: קבוע הזמן של המדיד - מאפיין את מהירות התגובה התרמית
%    זהו הזמן הנדרש לשינוי של (1 - 1/e) ≈ 63.2% מההפרש הכולל (T_∞ - T0)
% e: בסיס הלוגריתם הטבעי
% t: הזמן
%
% הגרף הלוגריתמי:
% ln((T(t) - T_∞)/(T0 - T_∞)) = -t/τ
% גרף זה יראה קו ישר עם שיפוע -1/τ
% מהשיפוע ניתן לחשב את קבוע הזמן: τ = -1/slope
%
% חישוב מקדם ההסעה:
% τ = (ρ*V*cp)/(h*A) = (ρ*r*cp)/(3*h) (עבור כדור)
% לכן: h = (ρ*r*cp)/(3*τ)
% כאשר:
% ρ = 8666 kg/m³ - צפיפות החומר
% cp = 410 J/(kg·°C) - החום הסגולי
% r - רדיוס המדיד
% h - מקדם ההסעה
% ============================================================ 