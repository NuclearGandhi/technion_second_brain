%% Voltage-Free Pull-In and Alpha Lines
% Recreates analytic plots from Lecture 2. Figures are exported as SVG so
% Obsidian can render text and curves sharply.

clear; close all; clc;

set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
set(groot, 'defaultTextInterpreter', 'latex');
set(groot, 'defaultLegendInterpreter', 'latex');

out_dir = fileparts(mfilename('fullpath'));

isoV1Color = [0.00 0.38 0.85];
isoV2Color = [0.00 0.55 0.15];
isoPsiColor = [0.85 0.45 0.00];

%% Coupled parallel-plate actuator
% Normalized equilibrium equations:
%   V1^2 = (2*q1 - q2)*(1 - q1)^2
%   V2^2 = (2*q2 - q1)*(1 - q2)^2
%
% The stability matrix after substituting the voltages is:
%   K = [2 - 2*(2*q1 - q2)/(1-q1), -1;
%        -1, 2 - 2*(2*q2 - q1)/(1-q2)]

n = 900;
q = linspace(0, 0.9, n);
[q1, q2] = meshgrid(q, q);

V1sq = (2*q1 - q2) .* (1 - q1).^2;
V2sq = (2*q2 - q1) .* (1 - q2).^2;
phyiscal_mask = V1sq >= 0 & V2sq >= 0 & q1 < 1 & q2 < 1;

K11 = 2 - 2*(2*q1 - q2)./(1 - q1);
K22 = 2 - 2*(2*q2 - q1)./(1 - q2);
traceK = K11 + K22;
lambda_min = 0.5*(traceK - sqrt((K11 - K22).^2 + 4));
lambda_max = 0.5*(traceK + sqrt((K11 - K22).^2 + 4));

stable = phyiscal_mask & lambda_min > 0;
unstable = phyiscal_mask & lambda_min < 0;

lambda_min_plot = lambda_min;
lambda_max_plot = lambda_max;
lambda_min_plot(~phyiscal_mask) = NaN;
lambda_max_plot(~phyiscal_mask) = NaN;
pi_segments = contour_segments(q, q, lambda_min_plot, 0);
max_segments = contour_segments(q, q, lambda_max_plot, 0);

psi_eq = q1.^2 - q1.*q2 + q2.^2 ...
    - V1sq./(1 - q1) - V2sq./(1 - q2);
psi_eq(~phyiscal_mask) = NaN;
V1_plot = sqrt(max(V1sq, 0));
V2_plot = sqrt(max(V2sq, 0));
V1_plot(~phyiscal_mask) = NaN;
V2_plot(~phyiscal_mask) = NaN;

%% Figure 1: displacement projection
fig1 = figure('Position', [100, 100, 600, 400]);
hold on;

stable_patch = phyiscal_mask & stable;
unstable_patch = phyiscal_mask & unstable;
contourf(q1, q2, double(stable_patch), [1 1], ...
    'FaceColor', [0.90 0.96 1.00], 'EdgeColor', 'none', 'FaceAlpha', 0.85);
contourf(q1, q2, double(unstable_patch), [1 1], ...
    'FaceColor', [1.00 0.94 0.86], 'EdgeColor', 'none', 'FaceAlpha', 0.45);

q_upper = q(q <= 0.45);
plot(q_upper, 2*q_upper, 'k-', 'LineWidth', 1.2);
plot(q, 0.5*q, 'k-', 'LineWidth', 1.2);
plot_q_segments(pi_segments, 'r-', 2);
plot_q_segments(max_segments, 'm-', 2);

isoV = [0.31 0.35];
isoPsi = [-0.315 -0.8];

contour(q1, q2, V1_plot, isoV, ...
    'Color', isoV1Color, 'LineWidth', 1.25, 'LineStyle', '--');
contour(q1, q2, V2_plot, isoV, ...
    'Color', isoV2Color, 'LineWidth', 1.25, 'LineStyle', '--');
contour(q1, q2, psi_eq, isoPsi, ...
    'Color', isoPsiColor, 'LineWidth', 1.35, 'LineStyle', '-');

plot([0.07 0.70], [0.10 0.47], '-', 'Color', [0.55 0.86 0.95], 'LineWidth', 3);

xlabel('$\tilde{q}_1$', 'FontSize', 15);
ylabel('$\tilde{q}_2$', 'FontSize', 15, 'Rotation', 0);
title('coupled parallel-plate actuator', 'FontSize', 14, 'FontWeight', 'bold');
axis equal;
xlim([0 0.9]);
ylim([0 0.9]);
grid on;
set(gca, 'FontSize', 12);

text(0.05, 0.83, 'non-equilibrium', 'FontSize', 13, 'FontWeight', 'bold');
text(0.58, 0.08, 'non-equilibrium', 'FontSize', 13, 'FontWeight', 'bold');
text(0.25,0.07, {'Pull-In', '$(\lambda_{\min}=0)$'}, 'FontSize', 12, 'FontWeight', 'bold', 'Color', 'red');
text(0.69, 0.76, '$\lambda_{\max}=0$', 'FontSize', 12, 'FontWeight', 'bold');
text(0.17, 0.70, 'equi-$\tilde{V}_2$', 'FontSize', 12, 'FontWeight', 'bold', 'Color', isoV2Color);
text(0.62, 0.27, 'equi-$\tilde{V}_1$', 'FontSize', 12, 'FontWeight', 'bold', 'Color', isoV1Color);
text(0.11, 0.56, 'equi-$\tilde{\psi}$', 'FontSize', 12, 'FontWeight', 'bold', 'Color', isoPsiColor);
text(0.42, 0.19, '$\tilde{V}_2=0$', 'FontSize', 11);
text(0.03, 0.39, '$\tilde{V}_1=0$', 'FontSize', 11);
text(0.66, 0.54, {'admissible', 'loading direction'}, 'Color', [0.10 0.55 0.70], ...
    'FontSize', 9, 'FontWeight', 'bold');

exportgraphics(fig1, fullfile(out_dir, 'coupled_parallel_plate_q_domain.svg'), 'ContentType', 'vector');

%% Figure 2: voltage projection
fig2 = figure('Position', [100, 100, 600, 400]);
hold on;
fill_voltage_projection(pi_segments, [0.90 0.90 0.90], 0.75);
plot_voltage_segments(pi_segments, 'r-', 2.5);

xlabel('$\tilde{V}_1$', 'FontSize', 14);
ylabel('$\tilde{V}_2$', 'FontSize', 14, 'Rotation', 0);
title('folded equilibrium projection in voltage space', 'FontSize', 14, 'FontWeight', 'bold');
axis equal;
xlim([0 0.52]);
ylim([0 0.52]);
grid on;
set(gca, 'FontSize', 12);
text(0.16, 0.48, 'non-equilibrium', 'FontSize', 12, 'FontWeight', 'bold');
text(0.15,0.23, 'equilibrium', 'Color', [0.2 0.35 0.85], 'FontSize', 12, 'FontWeight', 'bold');
text(0.38,0.42, 'Pull-In line', 'Color', 'r', 'FontSize', 12, 'FontWeight', 'bold');
exportgraphics(fig2, fullfile(out_dir, 'coupled_parallel_plate_voltage_projection.svg'), 'ContentType', 'vector');

%% Figure 3: alpha lines in voltage space
fig3 = figure('Position', [100, 100, 600, 400]);
hold on;
fill_voltage_projection(pi_segments, [0.90 0.90 0.90], 0.75);
plot_voltage_segments(pi_segments, 'r-', 2.5);

alpha_values = [0, 0.5, 1, 2, inf];
alpha_text_pos = [0.39,0.03;
    0.31 0.20;
    0.22 0.3;
    0.08 0.32;
    0.01 0.44];
line_styles = {'-', '--', '-.', ':', '-'};
for i = 1:numel(alpha_values)
    alpha = alpha_values(i);
    if isinf(alpha)
        plot([0 0], [0 0.5], 'k-', 'LineWidth', 1.4);
        text(alpha_text_pos(i, 1), alpha_text_pos(i, 2), '$\alpha=\infty$', 'FontSize', 10);
    else
        v = linspace(0, 0.5, 100);
        plot(v, alpha*v, ['k' line_styles{i}], 'LineWidth', 1.2);
        label_x = 0.33/(max(alpha, 0.15) + 0.6);
        label_y = alpha*label_x;
        text(alpha_text_pos(i, 1), alpha_text_pos(i, 2), sprintf('$\\alpha=%g$', alpha), 'FontSize', 10);
    end
end

xlabel('$\tilde{V}_1$', 'FontSize', 14);
ylabel('$\tilde{V}_2$', 'FontSize', 14, 'Rotation', 0);
title('$\alpha$-lines as one-parameter voltage slices', 'FontSize', 14, 'FontWeight', 'bold');
axis equal;
xlim([0 0.52]);
ylim([0 0.52]);
grid on;
set(gca, 'FontSize', 12);
text(0.3,0.47, 'Pull-In line', 'Color', 'r', 'FontSize', 12, 'FontWeight', 'bold');
exportgraphics(fig3, fullfile(out_dir, 'alpha_lines_voltage_projection.svg'), 'ContentType', 'vector');

%% Figure 4: interdigitated-fingers actuator displacement projection
kappa = 1000;
q1_f = linspace(0, 25, 2500);       % axial overlap displacement
q2_f = linspace(-1, 1, 2000);   % transverse gap displacement
[Q2, Q1] = meshgrid(q2_f, q1_f);

V1sq_f = (1 - Q2).^2 .* (Q1.^2 + Q1 + kappa*Q2.^2 + kappa*Q2) ./ (2*(1 + Q1));
V2sq_f = (1 + Q2).^2 .* (Q1.^2 + Q1 + kappa*Q2.^2 - kappa*Q2) ./ (2*(1 + Q1));
physical_f = V1sq_f >= 0 & V2sq_f >= 0;

K11_f = ones(size(Q1));
K12_f = -V1sq_f./(1 - Q2).^2 + V2sq_f./(1 + Q2).^2;
K22_f = kappa ...
    - 2*(1 + Q1).*V1sq_f./(1 - Q2).^3 ...
    - 2*(1 + Q1).*V2sq_f./(1 + Q2).^3;
trace_f = K11_f + K22_f;
lambda_min_f = 0.5*(trace_f - sqrt((K11_f - K22_f).^2 + 4*K12_f.^2));
stable_f = physical_f & lambda_min_f > 0;
unstable_f = physical_f & lambda_min_f < 0;
lambda_min_f_plot = lambda_min_f;
lambda_min_f_plot(~physical_f) = NaN;
pi_f_segments = contour_segments(q2_f, q1_f, lambda_min_f_plot, 0);

V1_f = sqrt(max(V1sq_f, 0));
V2_f = sqrt(max(V2sq_f, 0));
V1_f(~physical_f) = NaN;
V2_f(~physical_f) = NaN;

V1_f_stable = V1_f;
V2_f_stable = V2_f;
V1_f_unstable = V1_f;
V2_f_unstable = V2_f;
V1_f_stable(~stable_f) = NaN;
V2_f_stable(~stable_f) = NaN;
V1_f_unstable(~unstable_f) = NaN;
V2_f_unstable(~unstable_f) = NaN;

isoV = [1 2 3 4];
isoVLevels = contour_level_vector(isoV);

fig4 = figure('Position', [100, 100, 600, 400]);
hold on;
contourf(Q2, Q1, double(stable_f), [1 1], ...
    'FaceColor', [0.90 0.96 1.00], 'EdgeColor', 'none', 'FaceAlpha', 0.90);
contourf(Q2, Q1, double(unstable_f), [1 1], ...
    'FaceColor', [1.00 0.94 0.86], 'EdgeColor', 'none', 'FaceAlpha', 0.50);
plot_point_segments(pi_f_segments, 'r', 2);
plot_zero_voltage_boundaries(kappa, 25, isoV1Color, isoV2Color);

contour(Q2, Q1, V1_f_unstable - V2_f_unstable, contour_level_vector(0), 'k:', 'LineWidth', 2);
contour(Q2, Q1, V1_f_stable - V2_f_stable, contour_level_vector(0), 'k-', 'LineWidth', 2);

contour(Q2, Q1, V1_f_stable, isoVLevels, ...
    'Color', isoV1Color, 'LineStyle', '-', 'LineWidth', 1.2);
contour(Q2, Q1, V1_f_unstable, isoVLevels, ...
    'Color', isoV1Color, 'LineStyle', ':', 'LineWidth', 1.2);
contour(Q2, Q1, V2_f_stable, isoVLevels, ...
    'Color', isoV2Color, 'LineStyle', '-', 'LineWidth', 1.2);
contour(Q2, Q1, V2_f_unstable, isoVLevels, ...
    'Color', isoV2Color, 'LineStyle', ':', 'LineWidth', 1.2);

xlabel('$\tilde{q}_2$', 'FontSize', 15);
ylabel('$\tilde{q}_1$', 'FontSize', 15, 'Rotation', 0);
title('interdigitated-fingers actuator', 'FontSize', 14, 'FontWeight', 'bold');
xlim([-1 1]);
ylim([0 25]);
grid on;
set(gca, 'FontSize', 12);

text(-0.72, 1.32, 'non equilibrium', 'FontSize', 12, 'FontWeight', 'bold');
text(0.3, 1.32, 'non equilibrium', 'FontSize', 12, 'FontWeight', 'bold');
% text(-0.72, 1.0, 'non equilibrium', 'FontSize', 12, 'FontWeight', 'bold');
% text(0.55, 1.0, 'non equilibrium', 'FontSize', 12, 'FontWeight', 'bold');
text(0.17, 9.50, {'stable', 'equilibrium'}, 'FontSize', 11, 'FontWeight', 'bold', 'Color', [0.18 0.75 0.94]);
text(0.46, 12.54, {'unstable', 'equilibrium'}, 'FontSize', 11, 'FontWeight', 'bold', 'Color', [0.93 0.69 0.13]);
text(-0.57, 12.30, 'Pull-In line', 'Color', 'r', 'FontSize', 12, 'FontWeight', 'bold');
text(0.041, 23.72, '$\tilde{V}_1=\tilde{V}_2$', 'FontSize', 11, 'FontWeight', 'bold');
text(-0.34, 6.94, '$\tilde{V}_1=0$', 'FontSize', 11, 'FontWeight', 'bold', 'Color', isoV1Color);
text(0.1, 6.74, '$\tilde{V}_2=0$', 'FontSize', 11, 'FontWeight', 'bold', 'Color', isoV2Color);
% text(-0.48, 12.3, '$\beta_{PI}$', 'FontSize', 11);

exportgraphics(fig4, fullfile(out_dir, 'interdigitated_fingers_q_domain.svg'), 'ContentType', 'vector');
fprintf('Saved figures to: %s\n', out_dir);

%% Local functions
function segments = contour_segments(x, y, z, level)
    raw = contourc(x, y, z, [level level]);
    segments = {};
    idx = 1;

    while idx < size(raw, 2)
        n_points = raw(2, idx);
        xy = raw(:, idx + 1:idx + n_points);
        if n_points > 2
            segments{end + 1} = xy; %#ok<AGROW>
        end
        idx = idx + n_points + 1;
    end
end

function plot_q_segments(segments, line_spec, line_width)
    for i = 1:numel(segments)
        xy = segments{i};
        plot(xy(1, :), xy(2, :), line_spec, 'LineWidth', line_width);
    end
end

function plot_point_segments(segments, color, marker_size)
    for i = 1:numel(segments)
        xy = segments{i};
        plot(xy(1, :), xy(2, :), '.', 'Color', color, 'MarkerSize', marker_size);
    end
end

function plot_voltage_segments(segments, line_spec, line_width)
    for i = 1:numel(segments)
        xy = segments{i};
        q1 = xy(1, :);
        q2 = xy(2, :);
        [V1, V2] = parallel_plate_voltage(q1, q2);
        plot(V1, V2, line_spec, 'LineWidth', line_width);
    end
end

function levels = contour_level_vector(levels)
    % MATLAB interprets a scalar level as "number of contour levels".
    % Repeating the value forces one contour at exactly that level.
    if isscalar(levels)
        levels = [levels levels];
    end
end

function plot_zero_voltage_boundaries(kappa, q1_max, v1_color, v2_color)
    q2_left = linspace(-1, 0, 1000);
    q1_v1_zero = (-1 + sqrt(1 - 4*kappa*q2_left.*(q2_left + 1)))/2;
    keep_left = q1_v1_zero >= 0 & q1_v1_zero <= q1_max;
    q2_left = q2_left(keep_left);
    q1_v1_zero = q1_v1_zero(keep_left);
    lambda_left = interdigitated_lambda_min(q1_v1_zero, q2_left, kappa);
    plot_stable_unstable_curve(q2_left, q1_v1_zero, lambda_left, v1_color, 1.4);

    q2_right = linspace(0, 1, 1000);
    q1_v2_zero = (-1 + sqrt(1 - 4*kappa*q2_right.*(q2_right - 1)))/2;
    keep_right = q1_v2_zero >= 0 & q1_v2_zero <= q1_max;
    q2_right = q2_right(keep_right);
    q1_v2_zero = q1_v2_zero(keep_right);
    lambda_right = interdigitated_lambda_min(q1_v2_zero, q2_right, kappa);
    plot_stable_unstable_curve(q2_right, q1_v2_zero, lambda_right, v2_color, 1.4);
end

function plot_stable_unstable_curve(x, y, lambda_min, color, line_width)
    stable = lambda_min > 0;

    y_stable = y;
    y_stable(~stable) = NaN;
    plot(x, y_stable, '-', 'Color', color, 'LineWidth', line_width);

    y_unstable = y;
    y_unstable(stable) = NaN;
    plot(x, y_unstable, ':', 'Color', color, 'LineWidth', line_width);
end

function lambda_min = interdigitated_lambda_min(q1, q2, kappa)
    W1 = (1 - q2).^2 .* (q1.^2 + q1 + kappa*q2.^2 + kappa*q2) ./ (2*(1 + q1));
    W2 = (1 + q2).^2 .* (q1.^2 + q1 + kappa*q2.^2 - kappa*q2) ./ (2*(1 + q1));

    K11 = ones(size(q1));
    K12 = -W1./(1 - q2).^2 + W2./(1 + q2).^2;
    K22 = kappa ...
        - 2*(1 + q1).*W1./(1 - q2).^3 ...
        - 2*(1 + q1).*W2./(1 + q2).^3;

    traceK = K11 + K22;
    lambda_min = 0.5*(traceK - sqrt((K11 - K22).^2 + 4*K12.^2));
end

function fill_voltage_projection(pi_segments, color, alpha)
    pull_in = longest_segment(pi_segments);
    q1_pi = pull_in(1, :);
    [V1_pi, V2_pi] = parallel_plate_voltage(q1_pi, pull_in(2, :));

    % Orient the pull-in curve from the V2=0 boundary to the V1=0 boundary.
    if V2_pi(1) > V2_pi(end)
        q1_pi = fliplr(q1_pi);
        V1_pi = fliplr(V1_pi);
        V2_pi = fliplr(V2_pi);
    end

    q1_v2_zero = linspace(0, q1_pi(1), 200);
    q2_v2_zero = 0.5*q1_v2_zero;
    [V1_v2_zero, V2_v2_zero] = parallel_plate_voltage(q1_v2_zero, q2_v2_zero);

    q1_v1_zero = linspace(q1_pi(end), 0, 200);
    q2_v1_zero = 2*q1_v1_zero;
    [V1_v1_zero, V2_v1_zero] = parallel_plate_voltage(q1_v1_zero, q2_v1_zero);

    V1_boundary = [V1_v2_zero, V1_pi, V1_v1_zero];
    V2_boundary = [V2_v2_zero, V2_pi, V2_v1_zero];

    patch(V1_boundary, V2_boundary, color, ...
        'EdgeColor', [0.55 0.55 0.55], ...
        'LineWidth', 1.0, ...
        'FaceAlpha', alpha);
end

function segment = longest_segment(segments)
    lengths = cellfun(@(xy) size(xy, 2), segments);
    [~, idx] = max(lengths);
    segment = segments{idx};
end

function [V1, V2] = parallel_plate_voltage(q1, q2)
    V1 = sqrt(max((2*q1 - q2).*(1 - q1).^2, 0));
    V2 = sqrt(max((2*q2 - q1).*(1 - q2).^2, 0));
end
