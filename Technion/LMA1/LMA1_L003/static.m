% MATLAB Script for Thermocouple Calibration Analysis

clear;
clc;
close all;

% --- Configuration ---
% List of temperatures (from filenames like '22.csv', '25.csv', etc.)
temperatures_celsius = [22, 25, 30, 35, 45, 55, 60, 71, 75];
num_temperatures = length(temperatures_celsius);
data_folder = 'static/';

% Define the thermocouples and their corresponding column numbers
thermocouples_config = struct(...  
    'name', {'TC1', 'TC5', 'TC7'}, ...
    'column', {1, 5, 7} ...
);
num_thermocouples = length(thermocouples_config);

% Prepare for plotting
figure;
hold on;
colors = lines(num_thermocouples); % Get distinct colors for plotting
legend_entries = cell(num_thermocouples * 2, 1); % For data points and fit lines
legend_idx = 1;

all_results = cell(num_thermocouples, 1); % To store results for each TC

disp('--- Starting Thermocouple Calibration Analysis ---');

% --- Main Loop: Iterate through each thermocouple ---
for tc_idx = 1:num_thermocouples
    current_tc_name = thermocouples_config(tc_idx).name;
    current_tc_column = thermocouples_config(tc_idx).column;
    
    fprintf('\nProcessing Thermocouple: %s (Column %d)\n', current_tc_name, current_tc_column);
    
    mean_voltages_for_current_tc = zeros(num_temperatures, 1);
    
    % --- Inner Loop: Iterate through each temperature file ---
    for temp_idx = 1:num_temperatures
        current_temp = temperatures_celsius(temp_idx);
        tc_filename = sprintf('%s%d.csv', data_folder, current_temp);
        
        fprintf('  Processing file: %s for temperature: %.1f°C\n', tc_filename, current_temp);
        
        if exist(tc_filename, 'file')
            try
                % Read the whole CSV, then select the column
                full_data = readmatrix(tc_filename);
                if size(full_data, 2) >= current_tc_column
                    voltages_for_tc = full_data(:, current_tc_column);
                    mean_voltages_for_current_tc(temp_idx) = mean(voltages_for_tc(~isnan(voltages_for_tc))); % Handle potential NaNs in data
                    fprintf('    Mean voltage for %s: %.6f V (from %d measurements)\n', ...
                            current_tc_name, mean_voltages_for_current_tc(temp_idx), length(voltages_for_tc(~isnan(voltages_for_tc))));
                else
                    fprintf('    WARNING: File %s has fewer than %d columns. Skipping TC %s for this temp.\n', ...
                            tc_filename, current_tc_column, current_tc_name);
                    mean_voltages_for_current_tc(temp_idx) = NaN;
                end
            catch ME
                fprintf('    ERROR reading or processing file %s for column %d: %s\n', ...
                        tc_filename, current_tc_column, ME.message);
                mean_voltages_for_current_tc(temp_idx) = NaN;
            end
        else
            fprintf('    WARNING: File %s not found. Skipping TC %s for this temp.\n', tc_filename, current_tc_name);
            mean_voltages_for_current_tc(temp_idx) = NaN;
        end
    end % End of temperature loop
    
    % --- Data Cleaning and Fitting for the current thermocouple ---
    valid_indices = ~isnan(mean_voltages_for_current_tc);
    if sum(valid_indices) < 2
        fprintf('  WARNING: Thermocouple %s has fewer than 2 valid data points. Cannot perform fit.\n', current_tc_name);
        all_results{tc_idx} = struct('name', current_tc_name, 'error', 'Insufficient data for fit');
        continue; % Skip to the next thermocouple
    end
    
    processed_temperatures_tc = temperatures_celsius(valid_indices)'; % Ensure column vector
    processed_mean_voltages_tc = mean_voltages_for_current_tc(valid_indices); % Ensure column vector
    
    % Perform linear regression
    tbl_tc = table(processed_temperatures_tc, processed_mean_voltages_tc, ...
                   'VariableNames', {'Temperature', 'MeanVoltage'});
    lm_tc = fitlm(tbl_tc, 'MeanVoltage ~ Temperature');
    
    % Extract coefficients and errors
    coeffs_tc = lm_tc.Coefficients;
    seeback_tc = coeffs_tc.Estimate('Temperature');
    offset_tc = coeffs_tc.Estimate('(Intercept)');
    std_error_seeback_tc = coeffs_tc.SE('Temperature');
    std_error_offset_tc = coeffs_tc.SE('(Intercept)');
    rsquared_tc = lm_tc.Rsquared.Ordinary;

    % Store results
    results_current_tc = struct();
    results_current_tc.name = current_tc_name;
    results_current_tc.seeback_coefficient = seeback_tc;
    results_current_tc.offset_voltage = offset_tc;
    results_current_tc.std_error_seeback = std_error_seeback_tc;
    results_current_tc.std_error_offset = std_error_offset_tc;
    results_current_tc.rsquared = rsquared_tc;
    all_results{tc_idx} = results_current_tc;
    
    % --- Plotting for the current thermocouple ---
    plot(processed_temperatures_tc, processed_mean_voltages_tc, 'o', ...
         'MarkerFaceColor', colors(tc_idx,:), 'MarkerEdgeColor', colors(tc_idx,:), ...
         'DisplayName', sprintf('%s Data', current_tc_name));
    legend_entries{legend_idx} = sprintf('%s Data', current_tc_name);
    legend_idx = legend_idx + 1;

    temp_fit_tc = linspace(min(processed_temperatures_tc), max(processed_temperatures_tc), 100)';
    voltage_fit_tc = predict(lm_tc, table(temp_fit_tc, 'VariableNames', {'Temperature'}));
    plot(temp_fit_tc, voltage_fit_tc, '-', 'Color', colors(tc_idx,:), 'LineWidth', 1.5, ...
         'DisplayName', sprintf('%s Fit: V = %.2e*T + %.2e', current_tc_name, seeback_tc, offset_tc));
    legend_entries{legend_idx} = sprintf('%s Fit', current_tc_name);
    legend_idx = legend_idx + 1;

end % End of thermocouple loop

% Finalize plot
hold off;
xlabel('Temperature (°C)');
ylabel('Mean Thermocouple Voltage (V)');
title('Thermocouple Calibration Curves (TC1, TC5, TC7)');
legend(legend_entries(1:legend_idx-1), 'Location', 'best'); % Filter out unused legend entries if any TC failed
grid on;

% Save the figure
saveas(gcf, 'calibration_curves.png');
fprintf('\n--- Calibration Plot Generated and Saved as calibration_curves.png ---\n');

% --- Reporting Results --- 
disp('--- Part A: Calibration Results and Error Analysis ---');
temp_range_overall = max(temperatures_celsius) - min(temperatures_celsius);

for i = 1:num_thermocouples
    res = all_results{i};
    fprintf('\nResults for Thermocouple: %s\n', res.name);
    if isfield(res, 'error')
        fprintf('  Error: %s\n', res.error);
        continue;
    end
    
    fprintf('  Seebeck Coefficient (Sensitivity, S): %.4e V/°C\n', res.seeback_coefficient);
    fprintf('  Offset Voltage (V0): %.4e V\n', res.offset_voltage);
    fprintf('  R-squared for the fit: %.4f\n', res.rsquared);
    
    fprintf('  Error Analysis for %s:\n', res.name);
    fprintf('    Sensitivity Standard Error (StdError_S): %.4e V/°C\n', res.std_error_seeback);
    if temp_range_overall > 0
        sensitivity_error_vs_temp_range_tc = (res.std_error_seeback / temp_range_overall) * 100;
        fprintf('    Sensitivity Error (%% of total temp range, (StdError_S / DeltaT_total_range) * 100): %.4e (V/°C^2 * 100)\n', sensitivity_error_vs_temp_range_tc);
    else
        fprintf('    Sensitivity Error (%% of total temp range): Cannot calculate, temperature range is zero.\n');
    end
    fprintf('    Offset Error (StdError_V0): %.4e V\n', res.std_error_offset);
end

% --- Part B: Comparison with Seebeck Coefficients ---
disp('\n--- Part B: Student t-test Comparison ---');
S2_literature = 41.5e-6; % V/°C (Literature Seebeck coefficient for Copper-Constantan)
delta_S2_literature_error = 2.5e-6; % V/°C (Given error for the literature Seebeck coefficient)

fprintf('Literature Seebeck Coefficient (S2): %.4e V/°C\n', S2_literature);
fprintf('Literature Seebeck Error (delta_S2): %.4e V/°C\n', delta_S2_literature_error);

for i = 1:num_thermocouples
    res = all_results{i};
    fprintf('\nComparing results for Thermocouple: %s\n', res.name);
    if isfield(res, 'error')
        fprintf('  Cannot compare: %s\n', res.error);
        continue;
    end
    
    S1_experimental = res.seeback_coefficient;
    delta_S1_experimental_error = res.std_error_seeback;
    
    fprintf('  Experimental Seebeck Coefficient (S1): %.4e V/°C\n', S1_experimental);
    fprintf('  Standard Error of S1 (delta_S1): %.4e V/°C\n', delta_S1_experimental_error);
    
    % Calculate eta using the provided formula: eta = |S1 - S2| / sqrt(deltaS1 + deltaS2)
    % NOTE: This formula for the denominator (sqrt(deltaS1 + deltaS2)) is non-standard
    % for combining standard errors. Standard error of (S1-S2) is typically sqrt(deltaS1^2 + deltaS2^2).
    % Using the formula as provided by the user.
    numerator_eta = abs(S1_experimental - S2_literature);
    denominator_eta = sqrt(delta_S1_experimental_error^2 + delta_S2_literature_error^2);
    
    if denominator_eta == 0
        fprintf('  Cannot calculate eta: Denominator is zero (sum of errors is zero or negative).\n');
        eta = NaN;
    elseif (delta_S1_experimental_error + delta_S2_literature_error) < 0
        fprintf('  Cannot calculate eta: Sum of errors (delta_S1 + delta_S2) is negative, cannot take square root.\n');
        eta = NaN;
    else
        eta = numerator_eta / denominator_eta;
        fprintf('  Calculated Student t-test statistic (eta): %.4f\n', eta);
    end
    
    % Further interpretation of eta (e.g., p-value or comparison with critical t-value)
    % would require degrees of freedom from the fit (res.rsquared is available, lm_tc.DFE was used internally)
    % and a chosen significance level (alpha).
    % For now, we just report eta.
    if ~isnan(eta)
        if eta < 2 % Example threshold, not a formal critical value comparison
            fprintf('  The calculated eta (%.2f) is relatively small. The difference between S1 and S2 might not be highly significant relative to the combined (summed) errors as per the formula.\n', eta);
        else
            fprintf('  The calculated eta (%.2f) is relatively large. The difference between S1 and S2 appears more significant relative to the combined (summed) errors as per the formula.\n', eta);
        end
        fprintf('  Consider comparing eta to a critical t-value based on degrees of freedom and desired alpha level for a formal hypothesis test.\n');
    end

end

% --- Part C: Thermocouple Selection ---
disp('--- Part C: Thermocouple Selection (TODO) ---');
% Now you have results for TC1, TC5, TC7 stored in 'all_results'.
% To determine which is best for small temperature changes:
%   Compare their 'seeback_coefficient' values. Higher absolute value means more sensitive.
% To determine which is most accurate:
%   Consider:
%     - R-squared values (closer to 1 is better fit).
%     - Relative Sensitivity Error (smaller is better).
%     - Offset Error (smaller is better).
%     - How close their Seebeck coefficients are to expected literature values (Part B).
% No single thermocouple might be "best" in all aspects. You might need to weigh these factors.

disp('Script execution complete.');
