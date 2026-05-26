%% Floating Electrode Actuator: Charge and Voltage Actuation
% Generates normalized response plots for Lecture 3.

clear; close all; clc;

set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
set(groot, 'defaultTextInterpreter', 'latex');
set(groot, 'defaultLegendInterpreter', 'latex');

out_dir = fileparts(mfilename('fullpath'));

%% Normalized parameters
Cp = 8;                 % normalized parasitic capacitance, \tilde{C}_p
Q = 0.35;               % normalized trapped charge, \tilde{Q}
a = 1 + 1/Cp;           % effective normalized gap parameter
x_max = min(1, 0.995*a);
x = linspace(0, x_max, 1200);

Vstar = sqrt(2*x).*(a - x);
x_pi = a/3;
Vstar_pi = sqrt(8*a^3/27);

V_plus = Q + Vstar;
V_minus = Q - Vstar;

stable = x <= x_pi;
unstable = x > x_pi;

x0 = initial_displacement(Q, a);

%% Figure 1: Static response in the voltage-displacement plane
fig1 = figure('Position', [100, 100, 600, 400]);
hold on;

plot_masked(x, V_plus, stable, 'r-', 2.4);
plot_masked(x, V_plus, unstable, 'r--', 2.4);
plot_masked(x, V_minus, stable, 'b-', 2.4);
plot_masked(x, V_minus, unstable, 'b--', 2.4);

plot(x_pi, Q + Vstar_pi, 'rd', 'MarkerSize', 9, 'LineWidth', 1.8);
plot(x_pi, Q - Vstar_pi, 'bo', 'MarkerSize', 9, 'LineWidth', 1.8);
plot(x0, 0, 'go', 'MarkerSize', 10, 'LineWidth', 2.0, 'MarkerFaceColor', 'w');

plot([0 1.05], [0 0], 'k-', 'LineWidth', 1.0);
plot([0 0], [-1.1*Vstar_pi + Q, 1.18*Vstar_pi + Q], 'k-', 'LineWidth', 1.0);
plot([1 1], [-0.05, 0.05], 'k-', 'LineWidth', 1.0);

xlabel('$\tilde{x}$', 'FontSize', 15);
ylabel('$\tilde{V}$', 'FontSize', 15, 'Rotation', 0);
title('floating electrode actuator response', 'FontSize', 14, 'FontWeight', 'bold');
axis([0 1.05, Q - 1.15*Vstar_pi, Q + 1.25*Vstar_pi]);
grid on;
set(gca, 'FontSize', 12);

text(0.38, 1.09, 'Positive pull-in', ...
    'Color', 'r', 'FontSize', 12, 'FontWeight', 'bold');
text(0.38, -0.14, 'Negative pull-in', ...
    'Color', 'b', 'FontSize', 12, 'FontWeight', 'bold');
text(0.14, 0.07 , 'Initial state', ...
    'Color', [0.00 0.45 0.00], 'FontSize', 12, 'FontWeight', 'bold');
text(0.045, Q + 0.055, '$\tilde{Q}$', 'FontSize', 13, 'FontWeight', 'bold');
text(0.25, 1.10, '$\tilde{V}_{PI}^{+}$', ...
    'Color', 'r', 'FontSize', 14, 'FontWeight', 'bold');
text(0.27, -0.14, '$\tilde{V}_{PI}^{-}$', ...
    'Color', 'b', 'FontSize', 14, 'FontWeight', 'bold');
text(x0 + 0.015, 0.09, '$\tilde{x}_{0}$', 'Color', [0.00 0.45 0.00], ...
    'FontSize', 13, 'FontWeight', 'bold');

exportgraphics(fig1, fullfile(out_dir, 'floating_electrode_static_response.svg'), ...
    'ContentType', 'vector');

%% Figure 2: Equilibrium stiffness
K_eq = 1 - 2*x./(a - x);

fig2 = figure('Position', [100, 100, 600, 400]);
hold on;
plot_masked(x, K_eq, stable, '-', 2.4, [0.00 0.35 0.85]);
plot_masked(x, K_eq, unstable, '--', 2.4, [0.85 0.20 0.00]);
plot(x_pi, 0, 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'k');
plot([0 x_max], [0 0], 'k-', 'LineWidth', 1.0);
plot([x_pi x_pi], [min(K_eq) 1], 'k:', 'LineWidth', 1.0);

xlabel('$\tilde{x}$', 'FontSize', 15);
ylabel('$\tilde{K}_{\mathrm{eq}}$', 'FontSize', 15, 'Rotation', 0);
title('equilibrium stiffness', 'FontSize', 14, 'FontWeight', 'bold');
grid on;
set(gca, 'FontSize', 12);
xlim([0 x_max]);
ylim([max(min(K_eq), -4), 1.1]);
text(0.03, 0.35, 'stable branch', 'Color', [0.00 0.35 0.85], ...
    'FontSize', 12, 'FontWeight', 'bold');
text(0.64, -1.31, 'unstable branch', 'Color', [0.85 0.20 0.00], ...
    'FontSize', 12, 'FontWeight', 'bold');
text(0.39, 0.26, '$\tilde{x}_{SPI}$', 'FontSize', 12, 'FontWeight', 'bold');
text(0.62, 0.38, '$\tilde{K}_{eq}=0$', 'FontSize', 11, 'FontWeight', 'bold');

exportgraphics(fig2, fullfile(out_dir, 'floating_electrode_equilibrium_stiffness.svg'), ...
    'ContentType', 'vector');

fprintf('Saved figures to: %s\n', out_dir);

%% Local functions
function x0 = initial_displacement(Q, a)
    if Q == 0
        x0 = 0;
        return;
    end

    f = @(x) sqrt(2*x).*(a - x) - abs(Q);
    x_pi = a/3;
    x0 = fzero(f, [0, x_pi]);
end

function plot_masked(x, y, mask, line_spec, line_width, color)
    y_masked = y;
    y_masked(~mask) = NaN;

    if nargin < 6
        plot(x, y_masked, line_spec, 'LineWidth', line_width);
    else
        plot(x, y_masked, line_spec, 'LineWidth', line_width, 'Color', color);
    end
end

function plot_response_arrow(x, y, x_start, x_end, color)
    mask = x >= x_start & x <= x_end;
    x_path = x(mask);
    y_path = y(mask);

    plot(x_path, y_path, ':', 'Color', color, 'LineWidth', 1.4);

    arrow_idx = max(numel(x_path) - 14, 2);
    dx = x_path(arrow_idx + 1) - x_path(arrow_idx - 1);
    dy = y_path(arrow_idx + 1) - y_path(arrow_idx - 1);
    quiver(x_path(arrow_idx), y_path(arrow_idx), dx, dy, 0, ...
        'Color', color, 'LineWidth', 1.4, 'MaxHeadSize', 1.5);
end
