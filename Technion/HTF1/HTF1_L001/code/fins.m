clc; clear; close all;

% Parameters
start_pixels = [11, 9, 9]; % Example start pixels for each graph
end_pixels = [59, 113, 232]; % Example end pixels for each graph
pixels_to_mm = 190 / 107;
y_margin = 10; % Margin for y-axis

% Read the CSV files
data1 = readtable('../data/fins1.csv');
data2 = readtable('../data/fins2.csv');

% Number of fins
num_fins = length(start_pixels);

% Initialize matrices to store average temperatures and lengths
avg_temp = zeros(max(end_pixels - start_pixels + 1), num_fins);
length_mm = zeros(max(end_pixels - start_pixels + 1), num_fins);

for i = 1:num_fins
    % Extract the temperature data for the specified range and calculate averages
    temp1 = data1.(sprintf('Li%d', i))(start_pixels(i):end_pixels(i));
    temp2 = data2.(sprintf('Li%d', i))(start_pixels(i):end_pixels(i));
    avg_temp(1:length(temp1), i) = (temp1 + temp2) / 2;
    
    % Generate the length data for the specified range and convert to mm
    length_pixels = (start_pixels(i):end_pixels(i))' - start_pixels(i);
    length_mm(1:length(length_pixels), i) = length_pixels * pixels_to_mm;

    % Remove zero values
    avg_temp(avg_temp == 0) = NaN;
    length_mm(length_mm == 0) = NaN;
end

length_m = length_mm / 1000;

L = [0.1, 0.2, 0.4]; % Length of the fins in meters
h = [10, 5, 3]; % Convection heat transfer coefficient (W/m^2K)
k = 18; % Thermal conductivity (W/mK)
t = 0.01; % Thickness of the fin (m)
w = 0.03; % Width of the fin (m)
P = 2 * t + 2 * w; % Perimeter of the fin (m)
A = t * w; % Cross-sectional area of the fin (m^2)
m = sqrt((h * P) / (k * A)); % Fin parameter
T_b = 250; % Base temperature (C)
T_inf = 25; % Ambient temperature (C)

% Define the theoretical temperature function for curve fitting
theoretical_temp = @(h, length_m, L, T_b, T_inf, P, k, A) T_inf + (T_b - T_inf) * ((cosh(sqrt((h * P) / (k * A)) * (L - length_m)) + (h / (sqrt((h * P) / (k * A)) * k)) * sinh(sqrt((h * P) / (k * A)) * (L - length_m))) ./ (cosh(sqrt((h * P) / (k * A)) * L) + (h / (sqrt((h * P) / (k * A)) * k)) * sinh(sqrt((h * P) / (k * A)) * L)));

% Initialize array to store fitted h values
fitted_h = zeros(1, num_fins);

for i = 1:num_fins
    % Filter out non-finite values
    finite_idx = isfinite(length_m(:, i)) & isfinite(avg_temp(:, i));
    length_m_finite = length_m(finite_idx, i);
    avg_temp_finite = avg_temp(finite_idx, i);
    
    % Perform curve fitting to find h using lsqcurvefit
    fit_func = @(h, length_m) theoretical_temp(h, length_m, L(i), T_b, T_inf, P, k, A);
    h_initial = 10; % Initial guess for h
    h_lb = 0; % Lower bound for h
    h_ub = 100; % Upper bound for h
    fitted_h(i) = lsqcurvefit(fit_func, h_initial, length_m_finite, avg_temp_finite, h_lb, h_ub);
    
    % Create a new figure for each fin
    figure;
    plot(length_mm(:, i), avg_temp(:, i), '-x');
    hold on;
    
    % Calculate the theoretical temperature using the fitted h
    m_fitted = sqrt((fitted_h(i) * P) / (k * A));
    theta_b = T_b - T_inf;
    theta_conv = theta_b * ((cosh(m_fitted * (L(i) - length_m(:, i))) + (fitted_h(i) / (m_fitted * k)) * sinh(m_fitted * (L(i) - length_m(:, i)))) ./ (cosh(m_fitted * L(i)) + (fitted_h(i) / (m_fitted * k)) * sinh(m_fitted * L(i))));
    T_conv = T_inf + theta_conv;

    theta_adiab = theta_b * cosh(m_fitted * (L(i) - length_m(:, i))) ./ cosh(m_fitted * L(i));
    T_adiabatic = T_inf + theta_adiab;

    theta_infty = theta_b * exp(-m_fitted * length_m(:, i));
    T_infty = T_inf + theta_infty;

    plot(length_mm(:, i), T_conv, '--');
    plot(length_mm(:, i), T_adiabatic, '--');
    plot(length_mm(:, i), T_infty, '--');
    title(sprintf('Temperature vs Distance (Fin %d)', i), "FontSize", 14);
    xlabel('$x$ (mm)');
    ylabel('$T$ ($^\circ$C)');
    grid on;
    legend('Measured', ['Fitted Convection Tip for $h = $', num2str(fitted_h(i)), ' W/m$^2$K'], ...
        'Adiabatic Tip', 'Infinite Fin Tip', 'Location', 'northwest');
    xlim([min(length_mm(:, 1)), max(length_mm(:, end))]);
    ylim([min(avg_temp(:)) - y_margin, max(avg_temp(:)) + y_margin + 50]);

    set(gcf, 'Units', 'pixels', 'Position', [-50, -100, 600, 600]);
    % exportgraphics(gcf, sprintf('fins%d.png', i), 'Resolution', 300);
end

% Plot the theoretical T vs L for all 3 boundary conditions with the fitted h and an 80cm fin
L_long = 0.8; % New length of the fin in meters
m_long = sqrt((fitted_h(3) * P) / (k * A));
length_m_80 = linspace(0, 0.8, 1000)';
T_conv_80 = T_inf + theta_b * (cosh(m_long * (L_long - length_m_80)) + (fitted_h(3) / (m_long * k)) * sinh(m_long * (L_long - length_m_80))) ./ (cosh(m_long * L_long) + (fitted_h(3) / (m_long * k)) * sinh(m_long * L_long));
T_adiabatic_80 = T_inf + theta_b * cosh(m_long * (L_long - length_m_80)) ./ cosh(m_long * L_long);
T_infty_80 = T_inf + theta_b * exp(-m_long * length_m_80);

figure;
plot(length_m_80 * 1000, T_conv_80, '.-');
hold on;
plot(length_m_80 * 1000, T_adiabatic_80, ':');
plot(length_m_80 * 1000, T_infty_80, '--');
title(['Temperature vs Distance for 80cm Fin and $h = $', num2str(fitted_h(3)), ' W/m$^2$K'], "FontSize", 14);
xlabel('$x$ (mm)');
ylabel('$T$ ($^\circ$C)');
grid on;
legend('Convection Tip', 'Adiabatic Tip', 'Infinite Fin Tip', 'Location', 'northeast');
xlim([0, 800]);
ylim([T_inf - y_margin, T_b + y_margin]);

set(gcf, 'Units', 'pixels', 'Position', [-50, -100, 600, 600]);
exportgraphics(gcf, sprintf('fins_80.png'), 'Resolution', 300);