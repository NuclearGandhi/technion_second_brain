clc; clear; close all;

% MATLAB script to analyze strain gauge data in relation to load
% Parameters:
% - Gauge Factor: 2.12 +- 1.0%
% - Gauge Resistance: 119.8 Ohm +- 0.2%

% Set up LaTeX interpreter for plots
set(0, 'DefaultTextInterpreter', 'latex');
set(0, 'DefaultAxesTickLabelInterpreter', 'latex');
set(0, 'DefaultLegendInterpreter', 'latex');

% Read data from the raw.txt file
data = readtable('raw.txt', 'Delimiter', '\t');

% Extract relevant columns
sg1_mV = data.SG1_mV_;
sg3_mV = data.SG3_mV_;
load_N = data.Load_N_;

% Define gauge parameters
gauge_factor = 2.12;  % GF: 2.12 ± 1.0%
delta_gauge_factor = 0.01 * gauge_factor;  % ±1.0%

gauge_resistance = 119.8;  % R: 119.8 Ω ± 0.2%

% For a Wheatstone bridge with strain gauge:
% Strain (ε) = (-4*ΔV/V)/(GF*(1+2*ΔV/V))
% For small strains, this can be approximated as:
% Strain (ε) ≈ (-4*ΔV/V)/GF
% Where ΔV is measured in mV and V is the excitation voltage

% Assuming a standard excitation voltage of 5V
excitation_voltage = 2.5; % V

% Calculate strain for SG1 (converting mV to V)
strain_sg1 = (-4 * (sg1_mV/1000) / excitation_voltage) / gauge_factor;

% Calculate strain for SG3 (converting mV to V)
strain_sg3 = (-4 * (sg3_mV/1000) / excitation_voltage) / gauge_factor;

% Normalize SG1 to start at 0
strain_sg1 = strain_sg1 - strain_sg1(1);

% Invert SG3 (negate) because it was connected in wrong direction
% Also normalize SG3 to start at 0
strain_sg3 = -strain_sg3;
strain_sg3 = strain_sg3 - strain_sg3(1);

% Create figure with specified size (600x400)
figure('Position', [100, 100, 600, 400]);

% Define colors
color_sg1 = [0, 0.4470, 0.7410];  % Blue
color_sg3 = [0.8500, 0.3250, 0.0980];  % Orange

% Plot strain vs load for both strain gauges with defined colors
plot(load_N, strain_sg1, 'o', 'LineWidth', 1, 'MarkerSize', 5, 'Color', color_sg1, 'DisplayName', 'Strain Gauge 1');
hold on;
plot(load_N, strain_sg3, 's', 'LineWidth', 1, 'MarkerSize', 5, 'Color', color_sg3, 'DisplayName', 'Strain Gauge 3');

% Calculate and plot the linear fits
p1 = polyfit(load_N, strain_sg1, 1);
p3 = polyfit(load_N, strain_sg3, 1);
fit_sg1 = polyval(p1, load_N);
fit_sg3 = polyval(p3, load_N);

% strain gauge errors
delta_strain_sg1 = p1(1) * delta_gauge_factor / gauge_factor;
delta_strain_sg3 = p3(1) * delta_gauge_factor / gauge_factor;

% Plot fit lines with the same colors as their data points
plot(load_N, fit_sg1, '-', 'LineWidth', 1.5, 'Color', color_sg1, 'DisplayName', ['SG1 Fit']);
plot(load_N, fit_sg3, '-', 'LineWidth', 1.5, 'Color', color_sg3, 'DisplayName', ['SG3 Fit']);
hold off;

% Add grid and formatting
grid on;
xlabel('Load $F$ [N]', 'FontSize', 12);
ylabel('Strain $\varepsilon$', 'FontSize', 12);
title('Strain vs. Load for Strain Gauges', 'FontSize', 14);
legend('Location', 'best', 'FontSize', 9);

% Calculate R-squared for SG1
SSresid = sum((strain_sg1 - fit_sg1).^2);
SStotal = sum((strain_sg1 - mean(strain_sg1)).^2);
rsq_sg1 = 1 - SSresid/SStotal;

% Calculate R-squared for SG3
SSresid = sum((strain_sg3 - fit_sg3).^2);
SStotal = sum((strain_sg3 - mean(strain_sg3)).^2);
rsq_sg3 = 1 - SSresid/SStotal;

% Display last strain values in command window
disp(['Last strain value for SG1: ' num2str(strain_sg1(end))]);
disp(['Last strain value for SG3: ' num2str(strain_sg3(end))]);

% Display fit equations with R-squared values in command window
disp(['SG1 strain linear fit: ε = ' num2str(p1(1)) ' * Load + ' num2str(p1(2)), ' (R² = ', num2str(rsq_sg1), ')']);
disp(['SG3 strain linear fit: ε = ' num2str(p3(1)) ' * Load + ' num2str(p3(2)), ' (R² = ', num2str(rsq_sg3), ')']);

disp(['SG1 strain gauge error: ', num2str(delta_strain_sg1 / p1(1))]);
disp(['SG3 strain gauge error: ', num2str(delta_strain_sg3 / p3(1))]);

% Calculate stress concentration factor K
% K is the ratio of strains measured by the two gauges
% In this case, we calculate it from the slopes of the linear fits
K = abs(p3(1) / p1(1));

delta_K = K * sqrt((delta_strain_sg1 / p1(1))^2 + (delta_strain_sg3 / p3(1))^2);

% Display the stress concentration factor
disp(['Stress Concentration Factor K = ' num2str(K, '%.4f')]);

disp(['Stress concentration error: ', num2str(delta_K / K)]);

% Save the figure
print('strain_vs_load', '-dpng', '-r300');