%% Dynamic Pull-In
% Generates supporting SVG figures for Lecture 6.

clear; close all; clc;

set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
set(groot, 'defaultTextInterpreter', 'latex');
set(groot, 'defaultLegendInterpreter', 'latex');

out_dir = fileparts(mfilename('fullpath'));

%% Figure 1: One-DOF equilibrium and stagnation curves
x = linspace(0, 0.999, 1400);
V_eq = sqrt(2 .* x .* (1 - x).^2);
V_stag = sqrt(x .* (1 - x));

x_spi = 1/3;
V_spi = sqrt(8/27);
x_dpi = 1/2;
V_dpi = 1/2;

stable_eq = x <= x_spi;
unstable_eq = x >= x_spi;
stable_stag = x <= x_dpi;
unphysical_stag = x >= x_dpi;

fig1 = figure('Position', [100, 100, 600, 400]);
hold on;

plot_masked(x, V_eq, stable_eq, '-', 2.6, [0.00 0.35 0.85]);
plot_masked(x, V_eq, unstable_eq, '--', 2.6, [0.85 0.20 0.00]);
plot_masked(x, V_stag, stable_stag, '-', 2.8, [0.00 0.55 0.20]);
plot_masked(x, V_stag, unphysical_stag, ':', 2.8, [0.00 0.55 0.20]);

plot(x_spi, V_spi, 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 8);
plot(x_dpi, V_dpi, 'kd', 'MarkerFaceColor', 'w', 'MarkerSize', 9, ...
    'LineWidth', 1.8);

xlabel('$\tilde{x}$', 'FontSize', 15);
ylabel('$\tilde{V}$', 'FontSize', 15, 'Rotation', 0);
title('one-DOF dynamic pull-in', 'FontSize', 14, 'FontWeight', 'bold');
grid on;
set(gca, 'FontSize', 12);
xlim([0 1]);
ylim([0 0.58]);

text(0.02,0.55, 'stable equilibrium', 'Color', [0.00 0.35 0.85], ...
    'FontSize', 11, 'FontWeight', 'bold');
text(0.46,0.29, 'unstable equilibrium', 'Color', [0.85 0.20 0.00], ...
    'FontSize', 11, 'FontWeight', 'bold');
text(0.2,0.36, 'stagnation', 'Color', [0.00 0.55 0.20], ...
    'FontSize', 12, 'FontWeight', 'bold');
text(x_spi + 0.02, V_spi + 0.015, 'static pull-in', ...
    'FontSize', 10, 'FontWeight', 'bold');
text(x_dpi - 0.15, V_dpi - 0.035, 'dynamic pull-in', ...
    'FontSize', 10, 'FontWeight', 'bold');

exportgraphics(fig1, fullfile(out_dir, 'dynamic_pullin_1dof.svg'), ...
    'ContentType', 'vector');

%% Figure 2: Two-DOF static and dynamic pull-in lines
n_grid = 600;
x1 = linspace(0.001, 0.999, n_grid);
x2 = linspace(0.001, 0.999, n_grid);
[X1, X2] = meshgrid(x1, x2);

% With the 1/2 kept in the electrostatic co-energy term, the equilibrium
% voltages are larger by sqrt(2) than the lecture's absorbed-1/2 convention.
V1_sq_2dof = 2 .* (2 .* X1 - X2) .* (1 - X1).^2;
V2_sq_2dof = 2 .* (2 .* X2 - X1) .* (1 - X2).^2;
physical_mask_2dof = V1_sq_2dof >= 0 & V2_sq_2dof >= 0;

K11 = 2 - V1_sq_2dof ./ (1 - X1).^3;
K22 = 2 - V2_sq_2dof ./ (1 - X2).^3;
traceK = K11 + K22;
lambda_min = 0.5 .* (traceK - sqrt((K11 - K22).^2 + 4));
lambda_max = 0.5 .* (traceK + sqrt((K11 - K22).^2 + 4));

F_dynamic = 2.*X1.^3 + 2.*X2.^3 - X1.^2 - X2.^2 ...
    + X1.*X2 - X1.^2.*X2 - X1.*X2.^2;

lambda_min_plot = lambda_min;
lambda_max_plot = lambda_max;
F_dynamic_plot = F_dynamic;
lambda_min_plot(~physical_mask_2dof) = NaN;
lambda_max_plot(~physical_mask_2dof) = NaN;
F_dynamic_plot(~physical_mask_2dof) = NaN;

static_segments = contour_segments(x1, x2, lambda_min_plot, 0);
second_eigen_segments = contour_segments(x1, x2, lambda_max_plot, 0);
dynamic_segments = contour_segments(x1, x2, F_dynamic_plot, 0);

static_curve = augment_curve_endpoints(longest_segment(static_segments), ...
    [1/6; 1/3], [1/3; 1/6]);
dynamic_curve = augment_curve_endpoints(longest_segment(dynamic_segments), ...
    [1/4; 1/2], [1/2; 1/4]);
static_segments = {static_curve};
dynamic_segments = {dynamic_curve};

fig2 = figure('Position', [100, 100, 900, 380]);
tiledlayout(1, 2, 'Padding', 'compact', 'TileSpacing', 'compact');

nexttile;
hold on;
plot_segments(second_eigen_segments, @(a, b) deal(a, b), '--', 1.8, [0 0 0]);
plot_segments(dynamic_segments, @(a, b) deal(a, b), '-', 3.0, [0.00 0.20 0.95]);
plot_segments(static_segments, @(a, b) deal(a, b), '-', 2.6, [0 0 0]);
plot([0 0.5], [0 1], 'k-', 'LineWidth', 0.9);
plot([0 1], [0 0.5], 'k-', 'LineWidth', 0.9);
xlabel('$\tilde{x}_{1}$', 'FontSize', 14);
ylabel('$\tilde{x}_{2}$', 'FontSize', 14, 'Rotation', 0);
title('displacement domain', 'FontSize', 13, 'FontWeight', 'bold');
grid on;
axis equal;
xlim([0 1]);
ylim([0 1]);
set(gca, 'FontSize', 11);
text(0.63, 0.73, {'second', 'eigenvalue', 'vanishes'}, ...
    'FontSize', 11, 'FontWeight', 'bold');
text(0.55, 0.45, {'dynamic', 'pull-in line'}, ...
    'Color', [0.00 0.20 0.95], 'FontSize', 12, 'FontWeight', 'bold');
text(0.35, 0.1, {'static', 'pull-in line'}, ...
    'FontSize', 12, 'FontWeight', 'bold');

nexttile;
hold on;
plot_segments(static_segments, @map_to_voltage, '-', 2.4, [0 0 0]);
plot_segments(dynamic_segments, @map_to_voltage, '-', 3.0, [0.00 0.20 0.95]);
v_alpha = linspace(0, 0.75, 200);
plot(v_alpha, 0.5 .* v_alpha, 'k-.', 'LineWidth', 1.0);
xlabel('$\tilde{V}_{1}$', 'FontSize', 14);
ylabel('$\tilde{V}_{2}$', 'FontSize', 14, 'Rotation', 0);
title('voltage domain', 'FontSize', 13, 'FontWeight', 'bold');
grid on;
axis equal;
xlim([0 0.75]);
ylim([0 0.75]);
set(gca, 'FontSize', 11);
text(0.52, 0.65, {'static', 'pull-in line'}, ...
    'FontSize', 12, 'FontWeight', 'bold');
text(0.32, 0.39, {'dynamic', 'pull-in line'}, ...
    'Color', [0.00 0.20 0.95], 'FontSize', 12, 'FontWeight', 'bold');
text(0.41, 0.15, '$\alpha=1/2$', 'FontSize', 11, 'FontWeight', 'bold');

exportgraphics(fig2, fullfile(out_dir, 'dynamic_pullin_2dof_lines.svg'), ...
    'ContentType', 'vector');

%% Figure 3: Two-DOF alpha-line stagnation map
alpha = 0.5;
x1_alpha = linspace(-0.2, 0.999, 420);
x2_alpha = linspace(-0.2, 0.999, 420);
[X1a, X2a] = meshgrid(x1_alpha, x2_alpha);

M_alpha = 0.5 .* X1a.^2 + 0.5 .* X2a.^2 + 0.5 .* (X1a - X2a).^2;
A_alpha = X1a ./ (1 - X1a) + alpha^2 .* X2a ./ (1 - X2a);
V_sq_alpha = 2 .* M_alpha ./ A_alpha;
valid_alpha = isfinite(V_sq_alpha) & V_sq_alpha > 0 & X1a < 1 & X2a < 1;
V_alpha = NaN(size(V_sq_alpha));
V_alpha(valid_alpha) = sqrt(V_sq_alpha(valid_alpha));

[x_dpi_alpha, V_dpi_alpha] = alpha_dynamic_pullin_point(alpha, [0.55, 0.30]);

fig3 = figure('Position', [100, 100, 600, 460]);
hold on;

V_display_max = 1;
V_alpha_plot = V_alpha;
V_alpha_plot(V_alpha_plot > V_display_max) = NaN;
levels_alpha = linspace(0.05, V_display_max, 24);
contourf(X1a, X2a, V_alpha_plot, levels_alpha, 'LineStyle', 'none');
apply_default_colormap();
colorbar('TickLabelInterpreter', 'latex');
clim([0 V_display_max]);
contour(X1a, X2a, V_alpha_plot, levels_alpha, 'k-', 'LineWidth', 0.45);
contour(X1a, X2a, V_alpha, [V_dpi_alpha V_dpi_alpha], ...
    'Color', [0.00 0.20 0.95], 'LineWidth', 2.6);
plot(x_dpi_alpha(1), x_dpi_alpha(2), 'ko', 'MarkerSize', 7, ...
    'MarkerFaceColor', 'k');

xlabel('$\tilde{x}_{1}$', 'FontSize', 15);
ylabel('$\tilde{x}_{2}$', 'FontSize', 15, 'Rotation', 0);
title('$\alpha=1/2$ stagnation voltage map', ...
    'FontSize', 14, 'FontWeight', 'bold');
grid on;
axis equal;
xlim([-0.2 1]);
ylim([-0.2 1]);
set(gca, 'FontSize', 12);
if exist('disableDefaultInteractivity', 'file')
    disableDefaultInteractivity(gca);
end

exportgraphics(fig3, fullfile(out_dir, 'dynamic_pullin_2dof_alpha_stagnation.svg'), ...
    'ContentType', 'vector');

%% Figure 4: Clamped beam equilibrium and stagnation schematic
yc = linspace(0.001, 0.999, 1400);

V_spi_beam = 8.2406;
V_dpi_beam = 7.5194;

shape_eq = sqrt(yc .* (1 - yc).^2);
shape_stag = sqrt(yc .* (1 - yc));
V_beam_eq = V_spi_beam * shape_eq / max(shape_eq);
V_beam_stag = V_dpi_beam * shape_stag / max(shape_stag);

[~, idx_spi_beam] = max(V_beam_eq);
[~, idx_dpi_beam] = max(V_beam_stag);

fig4 = figure('Position', [100, 100, 600, 400]);
hold on;

plot(yc, V_beam_eq, 'Color', [0.00 0.35 0.85], 'LineWidth', 2.6);
plot(yc, V_beam_stag, 'Color', [0.00 0.55 0.20], 'LineWidth', 2.8);
plot(yc(idx_spi_beam), V_beam_eq(idx_spi_beam), 'ko', ...
    'MarkerFaceColor', 'k', 'MarkerSize', 8);
plot(yc(idx_dpi_beam), V_beam_stag(idx_dpi_beam), 'kd', ...
    'MarkerFaceColor', 'w', 'MarkerSize', 9, 'LineWidth', 1.8);

xlabel('$\tilde{y}_{c}$', 'FontSize', 15);
ylabel('$\tilde{V}$', 'FontSize', 15, 'Rotation', 0);
title('clamped-clamped beam response schematic', ...
    'FontSize', 14, 'FontWeight', 'bold');
grid on;
set(gca, 'FontSize', 12);
xlim([0 1]);
ylim([0 9.2]);

text(0.02,8.48, 'equilibrium curve', 'Color', [0.00 0.35 0.85], ...
    'FontSize', 12, 'FontWeight', 'bold');
text(0.74,7.02,0, 'stagnation curve', 'Color', [0.00 0.55 0.20], ...
    'FontSize', 12, 'FontWeight', 'bold');
text(0.42,8.6, ...
    '$\tilde{V}_{SPI}=8.2406$', 'FontSize', 11, 'FontWeight', 'bold');
text(0.36,6.5, ...
    '$\tilde{V}_{DPI}=7.5194$', 'FontSize', 11, 'FontWeight', 'bold');

exportgraphics(fig4, fullfile(out_dir, 'clamped_beam_equilibrium_stagnation.svg'), ...
    'ContentType', 'vector');

fprintf('Saved dynamic pull-in figures to: %s\n', out_dir);

%% Local functions
function plot_masked(x, y, mask, line_style, line_width, color)
    y_masked = y;
    y_masked(~mask) = NaN;
    plot(x, y_masked, line_style, 'LineWidth', line_width, 'Color', color);
end

function apply_default_colormap()
    if exist('viridis', 'file')
        colormap(viridis(256));
    else
        colormap(get(groot, 'DefaultFigureColorMap'));
    end
end

function segments = contour_segments(x, y, z, level)
    raw = contourc(x, y, z, [level level]);
    segments = {};
    idx = 1;
    while idx < size(raw, 2)
        n = raw(2, idx);
        pts = raw(:, idx + 1:idx + n);
        segments{end + 1} = pts; %#ok<AGROW>
        idx = idx + n + 1;
    end
end

function segment = longest_segment(segments)
    lengths = cellfun(@(pts) size(pts, 2), segments);
    [~, idx] = max(lengths);
    segment = segments{idx};
end

function curve = augment_curve_endpoints(curve, first_endpoint, last_endpoint)
    if norm(curve(:, 1) - first_endpoint) > norm(curve(:, end) - first_endpoint)
        curve = fliplr(curve);
    end

    if norm(curve(:, 1) - first_endpoint) > 1e-6
        curve = [first_endpoint, curve]; %#ok<AGROW>
    end

    if norm(curve(:, end) - last_endpoint) > 1e-6
        curve = [curve, last_endpoint]; %#ok<AGROW>
    end
end

function plot_segments(segments, transform_fn, line_style, line_width, color)
    for i = 1:numel(segments)
        pts = segments{i};
        [u, v] = transform_fn(pts(1, :), pts(2, :));
        valid = isfinite(u) & isfinite(v) & u >= 0 & v >= 0;
        u(~valid) = NaN;
        v(~valid) = NaN;
        plot(u, v, line_style, 'LineWidth', line_width, 'Color', color);
    end
end

function [V1, V2] = map_to_voltage(x1, x2)
    V1_sq = 2 .* (2 .* x1 - x2) .* (1 - x1).^2;
    V2_sq = 2 .* (2 .* x2 - x1) .* (1 - x2).^2;

    V1_sq(V1_sq < 0) = NaN;
    V2_sq(V2_sq < 0) = NaN;

    V1 = sqrt(V1_sq);
    V2 = sqrt(V2_sq);
end

function [x_star, V_star] = alpha_dynamic_pullin_point(alpha, x0)
    options = optimset('Display', 'off', 'TolX', 1e-12, ...
        'TolFun', 1e-12, 'MaxIter', 1000);
    objective = @(x) alpha_voltage_gradient_norm(x, alpha);
    x_star = fminsearch(objective, x0, options);
    V_star = alpha_stagnation_voltage(x_star(1), x_star(2), alpha);
end

function value = alpha_voltage_gradient_norm(x, alpha)
    x1 = x(1);
    x2 = x(2);

    if x1 <= -0.3 || x2 <= -0.3 || x1 >= 0.98 || x2 >= 0.98
        value = 1e6;
        return;
    end

    h = 1e-6;
    dV2_dx1 = (alpha_stagnation_voltage_sq(x1 + h, x2, alpha) ...
        - alpha_stagnation_voltage_sq(x1 - h, x2, alpha)) / (2*h);
    dV2_dx2 = (alpha_stagnation_voltage_sq(x1, x2 + h, alpha) ...
        - alpha_stagnation_voltage_sq(x1, x2 - h, alpha)) / (2*h);

    if ~isfinite(dV2_dx1) || ~isfinite(dV2_dx2)
        value = 1e6;
    else
        value = dV2_dx1.^2 + dV2_dx2.^2;
    end
end

function V = alpha_stagnation_voltage(x1, x2, alpha)
    V_sq = alpha_stagnation_voltage_sq(x1, x2, alpha);
    V = sqrt(V_sq);
end

function V_sq = alpha_stagnation_voltage_sq(x1, x2, alpha)
    M = 0.5*x1.^2 + 0.5*x2.^2 + 0.5*(x1 - x2).^2;
    A = x1./(1 - x1) + alpha.^2*x2./(1 - x2);
    V_sq = 2*M./A;

    if any(~isfinite(V_sq(:))) || any(V_sq(:) <= 0)
        V_sq = NaN;
    end
end
