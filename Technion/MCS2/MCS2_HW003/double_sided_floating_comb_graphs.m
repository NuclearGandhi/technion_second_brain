%% Double-Sided Floating Comb-Drive: Charge and Voltage Actuation
% Generates normalized response plots for Homework 3.

clear; close all; clc;

set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
set(groot, 'defaultTextInterpreter', 'latex');
set(groot, 'defaultLegendInterpreter', 'latex');

out_dir = fileparts(mfilename('fullpath'));

%% Normalized parameters
Cp = 8;                   % normalized parasitic capacitance, \tilde{C}_p
Q = 1.0;                  % normalized trapped charge, \tilde{Q}
a = Cp + 2;

Vs_lim = 3.0 * sqrt(a) / 2;
Vs = linspace(-Vs_lim, Vs_lim, 1600);

x_eq = 2 * Q .* Vs ./ (a + 4 * Vs.^2);
K_eq = 1 + 4 * Vs.^2 ./ a;

Vs_ext = sqrt(a) / 2;
x_ext = Q / (2 * sqrt(a));

%% Figure 1: Static response
fig1 = figure('Position', [100, 100, 600, 400]);
hold on;

plot(x_eq, Vs, 'b-', 'LineWidth', 2.4);
plot(x_ext, Vs_ext, 'ro', 'MarkerSize', 8, 'LineWidth', 1.8);
plot(-x_ext, -Vs_ext, 'ro', 'MarkerSize', 8, 'LineWidth', 1.8);
plot(0, 0, 'ko', 'MarkerSize', 7, 'MarkerFaceColor', 'w', 'LineWidth', 1.5);

xlabel('$\tilde{x}$', 'FontSize', 15);
ylabel('$\tilde{V}_{S}$', 'FontSize', 15, 'Rotation', 0);
title('double-sided floating comb-drive response', ...
    'FontSize', 14, 'FontWeight', 'bold');
grid on;
xline(0);
yline(0);
set(gca, 'FontSize', 12);

text(0.17, 1.61, '$\tilde{x}_{\max}$', ...
    'Color', 'r', 'FontSize', 13, 'FontWeight', 'bold');
text(-0.2, -2.11, '$-\tilde{x}_{\max}$', ...
    'Color', 'r', 'FontSize', 13, 'FontWeight', 'bold');
text(0.02, 0.18 * Vs_lim, '$\tilde{Q}\tilde{V}_{S}>0$', ...
    'Color', 'b', 'FontSize', 12, 'FontWeight', 'bold');
text(-0.45 * x_ext, -0.18 * Vs_lim, '$\tilde{Q}\tilde{V}_{S}<0$', ...
    'Color', 'b', 'FontSize', 12, 'FontWeight', 'bold');

exportgraphics(fig1, fullfile(out_dir, ...
    'double_sided_floating_comb_static_response.svg'), ...
    'ContentType', 'vector');

%% Figure 2: Equilibrium stiffness
fig2 = figure('Position', [100, 100, 600, 400]);
hold on;

plot(Vs, K_eq, 'Color', [0.00 0.35 0.85], 'LineWidth', 2.4);
plot(0, 1, 'ko', 'MarkerSize', 7, 'MarkerFaceColor', 'k');
plot([-Vs_lim Vs_lim], [1 1], 'k--', 'LineWidth', 1.0);
xline(0);
yline(0);

xlabel('$\tilde{V}_{S}$', 'FontSize', 15);
ylabel('$\tilde{K}_{\mathrm{eq}}$', 'FontSize', 15, 'Rotation', 0);
title('equilibrium stiffness', 'FontSize', 14, 'FontWeight', 'bold');
grid on;
set(gca, 'FontSize', 12);
xlim([-Vs_lim Vs_lim]);
ylim([-1 max(K_eq) * 1.05]);

text(2.89, 1.83, '$\tilde{K}_{\mathrm{eq},\min}=1$', ...
    'FontSize', 12, 'FontWeight', 'bold');
text(-0.85 * Vs_lim, 0.92 * max(K_eq), 'always stable', ...
    'Color', [0.00 0.35 0.85], 'FontSize', 12, 'FontWeight', 'bold');

exportgraphics(fig2, fullfile(out_dir, ...
    'double_sided_floating_comb_stiffness.svg'), ...
    'ContentType', 'vector');

fprintf('Saved figures to: %s\n', out_dir);
