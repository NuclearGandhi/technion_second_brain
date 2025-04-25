clc; clear; close all

%% Parameters
m = 32.74e-3;
delta_m = 0.01e-3; % kg

d = 20e-3; % m
delta_d = 0.1e-3; % m

l = [0.2]; % m

%% deg_var
initial_deg = linspace(90, 10, 9); % deg
Total_T_deg_var = [10.31, 9.94, 9.76, 9.52, 9.28, 9.07, 9.03, 8.95, 8.9]; % s
delta_Total_T = 0.3; %s

N = 10; % Number of periods
T_deg_var = Total_T_deg_var / N;

% Plot T_deg_var vs initial_deg
figure(1)
plot(initial_deg, T_deg_var, 'o-')
xlabel('Initial Angle [deg]', 'Interpreter', 'latex')
ylabel('Period $T\,[\mathrm{s}]$', 'Interpreter', 'latex')
title('Period vs Initial Angle', 'Interpreter', 'latex')
grid on
% Legend on the bottom right
legend({'$T$'}, 'Interpreter', 'latex', 'Location', 'southeast')
hold on

% Customize x-axis to show degree symbol
xticks(0:10:100)
xticklabels(arrayfun(@(x) sprintf('%d°', x), 0:10:100, 'UniformOutput', false))

%% length variation
l = linspace(0.2, 0.47, 10); % m 
delta_l = 1e-3; % m
initial_deg = 30; % deg

T_len_var = [9.13, 9.63, 10.25, 10.64, 11.41, 11.94, 12.4, 12.81, 13.54, 13.83]; % s

% Plot ln(l / l(end)) vs ln(T_len_var / T_len_var(end))
figure(2)
x = log(T_len_var / T_len_var(end));
y = log(l / l(end));
% Swap x and y for the new plot
plot(y, x, 'o-')
hold on

% Linear regression using Curve Fitting Toolbox (swapped axes)
fitresult = fit(y', x', 'poly1');
plot(fitresult, 'k--');

% Display the the fit equation on the graph
slope = fitresult.p1;
intercept = fitresult.p2;
text(-0.9, -0.1, sprintf('linear fit: $y = %.4fx + (%.4f)$', slope, intercept), 'FontSize', 12, 'Color', 'k', 'Interpreter', 'latex')

% Calculate confidence intervals for the slope
ci = confint(fitresult);
lower_bound = ci(1, 1); % Lower bound of the slope
upper_bound = ci(2, 1); % Upper bound of the slope

% Display the slope and its confidence intervals in the terminal
fprintf('Slope: %.6f\n', slope);
fprintf('Confidence Interval for Slope: [%.6f, %.6f]\n', lower_bound, upper_bound);

grid on
legend({'$\ln(T / T^*)$', 'Linear Fit'}, 'Interpreter', 'latex', 'Location', 'southeast')
axis([-1 0.1 -0.5 0.1])
xlabel('$\ln(\ell / \ell^*)$', 'Interpreter', 'latex')
ylabel('$\ln(T / T^*)$', 'Interpreter', 'latex')
title('Plot of $\frac{\ln(T/T^{*})}{\ln(\ell /{\ell}^{*})}$', 'Interpreter', 'latex')
hold off


% Set figure size and export Figure 1
figure(1)
set(gcf, 'Position', [100, 100, 600, 480]); % [x, y, width, height]
saveas(gcf, 'degree-variation.png'); % Save as PNG

% Set figure size and export Figure 2
figure(2)
set(gcf, 'Position', [100, 100, 600, 480]); % [x, y, width, height]
saveas(gcf, 'length-variation.png'); % Save as PNG