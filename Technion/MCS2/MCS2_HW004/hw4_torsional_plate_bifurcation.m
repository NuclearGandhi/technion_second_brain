%% Homework 4: Torsional Plate Between Symmetric Electrodes
% Generates normalized stability plots for the vertical plate problem.

clear; close all; clc;

set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
set(groot, 'defaultTextInterpreter', 'latex');
set(groot, 'defaultLegendInterpreter', 'latex');

out_dir = fileparts(mfilename('fullpath'));

%% Normalized critical condition
% mu = m*g0*L/(2*k_theta)
% nu^2 = 2*eps0*b*L^3*V^2/(3*k_theta*gap^3)
% Stable upright equilibrium: mu + nu^2 < 1

mu = linspace(0, 1.25, 600);
nu_cr = sqrt(max(0, 1 - mu));

%% Figure 1: normalized stability map
fig1 = figure('Position', [100, 100, 600, 400]);
hold on;

mu_fill = linspace(0, 1, 300);
nu_fill = sqrt(1 - mu_fill);
fill([mu_fill fliplr(mu_fill)], [zeros(size(nu_fill)) fliplr(nu_fill)], ...
    [0.82 0.90 1.00], 'EdgeColor', 'none', 'FaceAlpha', 0.85);
fill([mu_fill fliplr(mu_fill)], [nu_fill 1.25*ones(size(nu_fill))], ...
    [1.00 0.86 0.86], 'EdgeColor', 'none', 'FaceAlpha', 0.85);
fill([1 1.25 1.25 1], [0 0 1.25 1.25], ...
    [1.00 0.86 0.86], 'EdgeColor', 'none', 'FaceAlpha', 0.85);

plot(mu, nu_cr, 'b-', 'LineWidth', 2.8);
plot([1 1], [0 1.25], 'k:', 'LineWidth', 1.0);
xline(0, 'k-', 'LineWidth', 0.8);
yline(0, 'k-', 'LineWidth', 0.8);

xlabel('$\mu=m g_0 L/(2k_\theta)$', 'FontSize', 15);
ylabel('$\nu$', 'FontSize', 15, 'Rotation', 0);
title('normalized stability threshold', 'FontSize', 14, ...
    'FontWeight', 'bold');
grid on;
set(gca, 'FontSize', 12);
xlim([0 1.25]);
ylim([0 1.25]);

text(0.17, 0.28, 'stable', 'Color', [0.00 0.22 0.65], ...
    'FontSize', 13, 'FontWeight', 'bold');
text(0.55, 0.98, 'unstable', 'Color', [0.70 0.00 0.00], ...
    'FontSize', 13, 'FontWeight', 'bold');
text(1.03, 0.16, 'gravity alone', 'Color', [0.35 0.00 0.00], ...
    'FontSize', 11, 'FontWeight', 'bold');

exportgraphics(fig1, fullfile(out_dir, ...
    'hw4_torsional_plate_stability_map.svg'), ...
    'ContentType', 'vector');

%% Figure 2: normalized voltage threshold versus normalized mass
mu_voltage = linspace(0, 1.05, 600);
nu_voltage = sqrt(max(0, 1 - mu_voltage));

fig2 = figure('Position', [100, 100, 600, 400]);
hold on;

plot(mu_voltage, nu_voltage, 'b-', 'LineWidth', 2.8);
plot([0 1.05], [0 0], 'k-', 'LineWidth', 0.8);
plot([1 1], [0 1], 'k:', 'LineWidth', 1.0);

xlabel('$\mu$', 'FontSize', 15);
ylabel('$\nu_{cr}$', 'FontSize', 15);
title('dimensionless critical voltage', ...
    'FontSize', 14, 'FontWeight', 'bold');
grid on;
set(gca, 'FontSize', 12);
xlim([0 1.05]);
ylim([0 1.05]);

text(0.10, 0.72, '$\nu_{cr}=\sqrt{1-\mu}$', ...
    'FontSize', 12, 'FontWeight', 'bold');

exportgraphics(fig2, fullfile(out_dir, ...
    'hw4_torsional_plate_critical_voltage.svg'), ...
    'ContentType', 'vector');

%% Figure 3: examples of the normalized potential near the upright state
gap_over_L = 0.05;
u = linspace(-0.85, 0.85, 1600);

cases = [ ...
    0.20, 0.45; ...
    0.50, sqrt(0.50); ...
    0.50, 0.90];
case_labels = { ...
    '$\mu+\nu^2<1$', ...
    '$\mu+\nu^2=1$', ...
    '$\mu+\nu^2>1$'};
case_colors = [ ...
    0.00 0.35 0.85; ...
    0.25 0.25 0.25; ...
    0.85 0.10 0.10];

fig3 = figure('Position', [100, 100, 600, 400]);
hold on;

for i = 1:size(cases, 1)
    mu_i = cases(i, 1);
    nu_i = cases(i, 2);
    psi = normalized_potential(u, mu_i, nu_i, gap_over_L);
    plot(u, psi, 'LineWidth', 2.4, 'Color', case_colors(i, :), ...
        'DisplayName', case_labels{i});
end

xline(0, 'k:', 'LineWidth', 1.0, 'HandleVisibility', 'off');
yline(0, 'k-', 'LineWidth', 0.8, 'HandleVisibility', 'off');
xlabel('$\tilde{\theta}=L\theta/g$', 'FontSize', 15);
ylabel('$\Delta\tilde{\psi}$', 'FontSize', 15, 'Rotation', 0);
title('potential near the vertical equilibrium', ...
    'FontSize', 14, 'FontWeight', 'bold');
legend('Location', 'north');
grid on;
set(gca, 'FontSize', 12);
xlim([-0.85 0.85]);

exportgraphics(fig3, fullfile(out_dir, ...
    'hw4_torsional_plate_potential_examples.svg'), ...
    'ContentType', 'vector');

fprintf('Saved figures to: %s\n', out_dir);

%% Local functions
function psi = normalized_potential(u, mu, nu, gap_over_L)
    delta = gap_over_L;
    log_term = log((1 + u) ./ (1 - u)) ./ u;
    log_term(abs(u) < 1e-8) = 2;

    psi = 0.5 .* u.^2 ...
        + (mu / delta^2) .* (cos(delta .* u) - 1) ...
        - 0.75 .* nu.^2 .* (log_term - 2);
end
