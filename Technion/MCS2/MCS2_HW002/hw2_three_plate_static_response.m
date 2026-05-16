%% Homework 2: Three-Plate Static Response
% Generates the displacement-space stability projection and the
% voltage-charge projection for kappa = 1.

clear; close all; clc;

set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
set(groot, 'defaultTextInterpreter', 'latex');
set(groot, 'defaultLegendInterpreter', 'latex');

out_dir = fileparts(mfilename('fullpath'));

kappa = 1;
n_grid = 900;
n_boundary = 600;
figure_position = [100, 100, 600, 400];
isoV_values = [0, 0.6, 1.2];
isoQ_values = [0, 0.6, 1.2];

colors.stableFill = [0.90 0.96 1.00];
colors.unstableFill = [1.00 0.94 0.86];
colors.equilibriumFill = [0.90 0.90 0.90];
colors.stableText = [0.12 0.45 0.70];
colors.unstableText = [0.80 0.45 0.00];
colors.pullIn = [0.85 0.00 0.00];
colors.contact = [0.00 0.00 0.00];
colors.zeroVoltage = [0.00 0.38 0.85];
colors.zeroCharge = [0.00 0.55 0.15];

styles.domainLineWidth = 1.4;
styles.isoLineWidth = 1.1;
styles.stableLineStyle = '-';
styles.unstableLineStyle = ':';
styles.pullInLineWidth = 2.2;
styles.contactLineWidth = 1.4;

bounds = domain_bounds(kappa);
curves = domain_curves(kappa, bounds, n_boundary);
control_envelope = control_space_envelope(kappa, bounds, n_boundary);
control_bounds = control_domain_bounds(control_envelope);

%% Displacement-space projection
x2_grid = linspace(bounds.x2_min, bounds.x2_max, n_grid + 1);
x2 = x2_grid(1:end - 1);
x1 = linspace(bounds.x1_min, bounds.x1_max, n_grid);
[X2, X1] = meshgrid(x2, x1);

physical = physical_mask(X2, X1, kappa);
K22eq = (kappa*(1 - 3*X2) - 2*X1)./(1 - X2);
stable = physical & K22eq > 0;
unstable = physical & K22eq < 0;

K22eqPlot = K22eq;
K22eqPlot(~physical) = NaN;

V = (1 - X2).*sqrt(max(2*(X1 + kappa*X2), 0));
Q = sqrt(max(2*X1, 0));
V(~physical) = NaN;
Q(~physical) = NaN;

VStable = V;
VUnstable = V;
QStable = Q;
QUnstable = Q;
VStable(~stable) = NaN;
VUnstable(~unstable) = NaN;
QStable(~stable) = NaN;
QUnstable(~unstable) = NaN;
isoV_contours = nonzero_levels(isoV_values);
isoQ_contours = nonzero_levels(isoQ_values);

fig1 = figure('Position', figure_position);
hold on;

contourf(X2, X1, double(stable), [1 1], ...
    'FaceColor', colors.stableFill, 'EdgeColor', 'none', 'FaceAlpha', 0.90);
contourf(X2, X1, double(unstable), [1 1], ...
    'FaceColor', colors.unstableFill, 'EdgeColor', 'none', 'FaceAlpha', 0.55);

plot_curve(curves.zeroVoltage, styles.stableLineStyle, colors.zeroVoltage, styles.domainLineWidth);
plot_curve(curves.zeroChargeStable, styles.stableLineStyle, colors.zeroCharge, styles.domainLineWidth);
plot_curve(curves.zeroChargeUnstable, styles.unstableLineStyle, colors.zeroCharge, styles.domainLineWidth);

if ~isempty(isoV_contours)
    contour(X2, X1, VStable, contour_level_vector(isoV_contours), ...
        'Color', colors.zeroVoltage, ...
        'LineStyle', styles.stableLineStyle, ...
        'LineWidth', styles.isoLineWidth);
    contour(X2, X1, VUnstable, contour_level_vector(isoV_contours), ...
        'Color', colors.zeroVoltage, ...
        'LineStyle', styles.unstableLineStyle, ...
        'LineWidth', styles.isoLineWidth);
end

if ~isempty(isoQ_contours)
    contour(X2, X1, QStable, contour_level_vector(isoQ_contours), ...
        'Color', colors.zeroCharge, ...
        'LineStyle', styles.stableLineStyle, ...
        'LineWidth', styles.isoLineWidth);
    contour(X2, X1, QUnstable, contour_level_vector(isoQ_contours), ...
        'Color', colors.zeroCharge, ...
        'LineStyle', styles.unstableLineStyle, ...
        'LineWidth', styles.isoLineWidth);
end

plot_curve(curves.topContact, '-', colors.contact, styles.contactLineWidth);
plot_curve(curves.bottomContact, ':', colors.contact, styles.contactLineWidth);
contour(X2, X1, K22eqPlot, contour_level_vector(0), ...
    'Color', colors.pullIn, ...
    'LineStyle', '-', ...
    'LineWidth', styles.pullInLineWidth);

xlabel('$\tilde{x}_2$', 'FontSize', 15);
ylabel('$\tilde{x}_1$', 'FontSize', 15, 'Rotation', 0);
title('three-plate actuator stability projection', 'FontSize', 14, 'FontWeight', 'bold');
axis equal;
xlim([bounds.x2_min bounds.x2_max]);
ylim([bounds.x1_min bounds.x1_max]);
grid on;
set(gca, 'FontSize', 12);

text(-0.18, 1.55, 'electrode contact', 'FontSize', 11, 'FontWeight', 'bold', 'Color', colors.contact);
text(-0.43, 0.14, '$\tilde{V}=0$', 'FontSize', 11, 'FontWeight', 'bold', 'Color', colors.zeroVoltage);
text(0.55, 0.06, '$\tilde{Q}=0$', 'FontSize', 11, 'FontWeight', 'bold', 'Color', colors.zeroCharge);
text(0.14, 0.35, 'Pull-In', 'FontSize', 11, 'FontWeight', 'bold', 'Color', colors.pullIn);
text(-0.33, 0.47, 'stable', 'FontSize', 12, 'FontWeight', 'bold', 'Color', colors.stableText);
text(0.29, 0.94, 'unstable', 'FontSize', 12, 'FontWeight', 'bold', 'Color', colors.unstableText);
text(-0.43, 1.9, 'non-equilibrium', 'FontSize', 12, 'FontWeight', 'bold');

exportgraphics(fig1, fullfile(out_dir, 'hw2_displacement_stability.svg'), 'ContentType', 'vector');

%% Voltage-charge projection
fig2 = figure('Position', figure_position);
hold on;

fill_control_envelope(control_envelope, colors.equilibriumFill, 0.80);

plot_control_curve(curves.pullIn, kappa, '-', colors.pullIn, styles.pullInLineWidth);
plot_control_curve(curves.topContact, kappa, '-', colors.contact, styles.contactLineWidth);
plot_control_curve(curves.bottomContact, kappa, ':', colors.contact, styles.contactLineWidth);

xlabel('$\tilde{V}$', 'FontSize', 15);
ylabel('$\tilde{Q}$', 'FontSize', 15, 'Rotation', 0);
title('control-space equilibrium projection', 'FontSize', 14, 'FontWeight', 'bold');
axis equal;
xlim([0 control_bounds.v_max]);
ylim([0 control_bounds.q_max]);
grid on;
set(gca, 'FontSize', 12);

text(0.1, 0.57, 'equilibrium', 'FontSize', 12, 'FontWeight', 'bold');
text(0.84, 0.67, 'Pull-In line', 'FontSize', 12, 'FontWeight', 'bold', 'Color', colors.pullIn);
text(0.6, 1.95, 'electrode contact', 'FontSize', 11, 'FontWeight', 'bold', 'Color', colors.contact);
text(0.7, 0.1, ...
    'non-equilibrium', 'FontSize', 12, 'FontWeight', 'bold');

exportgraphics(fig2, fullfile(out_dir, 'hw2_voltage_charge_projection.svg'), 'ContentType', 'vector');

fprintf('Saved figures to: %s\n', out_dir);

%% Local functions
function bounds = domain_bounds(kappa)
    bounds.x2_min = -1/(1 + kappa);
    bounds.x2_max = 1;
    bounds.x1_min = 0;
    bounds.x1_max = 1 + bounds.x2_max;

    bounds.pull_in_contact_x2 = (kappa - 2)/(3*kappa + 2);
    bounds.pull_in_charge_zero_x2 = 1/3;

end

function curves = domain_curves(kappa, bounds, n)
    curves.zeroVoltage = make_curve( ...
        linspace(bounds.x2_min, 0, n), ...
        @(x2) -kappa*x2);

    curves.zeroCharge = make_curve( ...
        linspace(0, bounds.x2_max, n), ...
        @(x2) zeros(size(x2)));

    curves.zeroChargeStable = make_curve( ...
        linspace(0, bounds.pull_in_charge_zero_x2, n), ...
        @(x2) zeros(size(x2)));

    curves.zeroChargeUnstable = make_curve( ...
        linspace(bounds.pull_in_charge_zero_x2, bounds.x2_max, n), ...
        @(x2) zeros(size(x2)));

    curves.pullIn = make_curve( ...
        linspace(bounds.pull_in_contact_x2, bounds.pull_in_charge_zero_x2, n), ...
        @(x2) kappa*(1 - 3*x2)/2);

    curves.topContact = make_curve( ...
        linspace(bounds.x2_min, bounds.x2_max, n), ...
        @(x2) 1 + x2);

    curves.topContactStable = make_curve( ...
        linspace(bounds.pull_in_contact_x2, bounds.x2_min, n), ...
        @(x2) 1 + x2);

    curves.topContactUnstable = make_curve( ...
        linspace(bounds.x2_max, bounds.pull_in_contact_x2, n), ...
        @(x2) 1 + x2);

    curves.bottomContact = make_curve( ...
        bounds.x2_max*ones(1, n), ...
        linspace(bounds.x1_min, bounds.x1_max, n));

    curves.stableBoundary = join_curves( ...
        curves.zeroVoltage, ...
        curves.zeroChargeStable, ...
        reverse_curve(curves.pullIn), ...
        curves.topContactStable);

    curves.unstableBoundary = join_curves( ...
        curves.zeroChargeUnstable, ...
        curves.bottomContact, ...
        curves.topContactUnstable, ...
        curves.pullIn);

end

function curve = make_curve(x2, x1)
    curve.x2 = x2;
    if isa(x1, 'function_handle')
        curve.x1 = x1(x2);
    else
        curve.x1 = x1;
    end
end

function curve = reverse_curve(curve)
    curve.x2 = fliplr(curve.x2);
    curve.x1 = fliplr(curve.x1);
end

function curve = join_curves(varargin)
    curve.x2 = [];
    curve.x1 = [];
    for i = 1:nargin
        curve.x2 = [curve.x2, varargin{i}.x2]; %#ok<AGROW>
        curve.x1 = [curve.x1, varargin{i}.x1]; %#ok<AGROW>
    end
end

function mask = physical_mask(x2, x1, kappa)
    mask = x1 >= 0 ...
        & x2 < 1 ...
        & x1 < 1 + x2 ...
        & x1 + kappa*x2 >= 0;
end

function levels = contour_level_vector(levels)
    % MATLAB interprets a scalar as the number of contour levels.
    % Repeating the scalar forces one contour at exactly that value.
    if isscalar(levels)
        levels = [levels levels];
    end
end

function levels = nonzero_levels(levels)
    levels = levels(levels ~= 0);
end

function plot_curve(curve, line_style, color, line_width)
    plot(curve.x2, curve.x1, line_style, 'Color', color, 'LineWidth', line_width);
end

function [V, Q] = control_projection(x2, x1, kappa)
    Q = sqrt(max(2*x1, 0));
    V = (1 - x2).*sqrt(max(2*(x1 + kappa*x2), 0));
end

function envelope = control_space_envelope(kappa, bounds, n)
    x1 = linspace(bounds.x1_min, bounds.x1_max, n);
    envelope.Q = sqrt(2*x1);
    envelope.V = zeros(size(x1));

    for i = 1:numel(x1)
        x2_lower = max(-x1(i)/kappa, x1(i) - 1);
        x2_upper = bounds.x2_max;
        x2_pullin = (kappa - 2*x1(i))/(3*kappa);
        candidates = [x2_lower, x2_upper];

        if x2_pullin >= x2_lower && x2_pullin <= x2_upper
            candidates(end + 1) = x2_pullin; %#ok<AGROW>
        end

        [V_candidates, ~] = control_projection( ...
            candidates, x1(i)*ones(size(candidates)), kappa);
        envelope.V(i) = max(V_candidates);
    end
end

function bounds = control_domain_bounds(envelope)
    bounds.v_max = 1.05*max(envelope.V);
    bounds.q_max = 1.05*max(envelope.Q);
end

function fill_control_envelope(envelope, color, face_alpha)
    V_boundary = [zeros(size(envelope.V)), fliplr(envelope.V)];
    Q_boundary = [envelope.Q, fliplr(envelope.Q)];

    patch(V_boundary, Q_boundary, color, ...
        'EdgeColor', [0.65 0.65 0.65], ...
        'LineWidth', 1.0, ...
        'FaceAlpha', face_alpha);
end

function plot_control_curve(curve, kappa, line_style, color, line_width)
    [V, Q] = control_projection(curve.x2, curve.x1, kappa);
    plot(V, Q, line_style, 'Color', color, 'LineWidth', line_width);
end
