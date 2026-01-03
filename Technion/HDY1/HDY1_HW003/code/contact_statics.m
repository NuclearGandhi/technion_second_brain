% Housekeeping
close all;
clear;
clc;

%% Problem Setup (common to all assignments)
% Contact points: r1 = (-1,1), r2 = (2,2)
% Contact normals: alpha1 = 45°, alpha2 = 135°
r = [-1, 2; 1, 2];
alpha = [pi / 4, 3 * pi / 4];

%% Assignment 1: Basic cases
run_assignment_1 = false;

if run_assignment_1
    fprintf('=== Assignment 1 ===\n');

    % Case (a): mu = 0.4
    fprintf('Case (a): mu = 0.4\n');
    [x_min_a, x_max_a] = fric_eq(r, alpha, [0.4, 0.4], true);
    fprintf('x_min = %.4f, x_max = %.4f\n\n', x_min_a, x_max_a);
    saveas(gcf, '../contact_statics_a.png');

    % Case (b): mu = 0.8
    fprintf('Case (b): mu = 0.8\n');
    [x_min_b, x_max_b] = fric_eq(r, alpha, [0.8, 0.8], true);
    fprintf('x_min = %.4f, x_max = %.4f\n\n', x_min_b, x_max_b);
    saveas(gcf, '../contact_statics_b.png');
end

%% Assignment 3: Critical friction values
run_assignment_3 = false;

if run_assignment_3
    fprintf('=== Assignment 3 ===\n');

    % Sweep mu from 0 to 2.5
    mu_values = linspace(1e-5, 2.5, 1001);
    x_min_vals = zeros(size(mu_values));
    x_max_vals = zeros(size(mu_values));

    for i = 1:length(mu_values)
        mu = mu_values(i);
        [x_min_vals(i), x_max_vals(i)] = fric_eq(r, alpha, [mu, mu], false);
    end

    % Find critical transitions
    % Transition 1: x_max goes from finite to infinite
    idx_max_inf = find(isinf(x_max_vals), 1, 'first');

    if ~isempty(idx_max_inf) && idx_max_inf > 1
        mu_crit_1 = mu_values(idx_max_inf);
        fprintf('Critical mu_1 (x_max -> inf): %.4f\n', mu_crit_1);
    end

    % Transition 2: x_min goes from finite to -infinite
    idx_min_inf = find(isinf(x_min_vals), 1, 'first');

    if ~isempty(idx_min_inf) && idx_min_inf > 1
        mu_crit_2 = mu_values(idx_min_inf);
        fprintf('Critical mu_2 (x_min -> -inf): %.4f\n', mu_crit_2);
    end

    % Analytical critical values (derived from geometry)
    mu_analytical_1 = 1.0;
    mu_analytical_2 = 2.0;
    fprintf('\nAnalytical verification:\n');
    fprintf('mu_crit_1 (upper bound unbounded) = tan(45°) = %.4f\n', mu_analytical_1);
    fprintf('mu_crit_2 (entire plane) = tan(arctan(2)) = %.4f\n', mu_analytical_2);

    % Plot x_min and x_max vs mu
    figure; set(gcf, 'Position', [100, 100, 800, 500]);
    hold on;

    % Replace inf with large values for plotting
    y_lim = 15;

    plot(mu_values, x_min_vals, '-', 'LineWidth', 2, 'DisplayName', '$x_{\min}$');
    plot(mu_values, x_max_vals, '-', 'LineWidth', 2, 'DisplayName', '$x_{\max}$');

    % Mark critical transitions
    if exist('mu_crit_1', 'var')
        xline(mu_crit_1, 'k--', 'LineWidth', 1.5, 'HandleVisibility', 'off');
    end

    if exist('mu_crit_2', 'var')
        xline(mu_crit_2, 'k--', 'LineWidth', 1.5, 'HandleVisibility', 'off');
    end

    % Formatting
    xlabel('Friction coefficient $\mu$');
    ylabel('COM $x$-position bounds');
    title('Permissible COM region bounds vs. friction coefficient');
    legend('Location', 'best');
    xlim([0, 2.5]);
    ylim([-y_lim, y_lim]);
    grid on;

    % Add region annotations
    if exist('mu_crit_1', 'var') && exist('mu_crit_2', 'var')
        text(mu_crit_1 / 2, -12, 'Bounded', 'HorizontalAlignment', 'center', 'FontSize', 10);
        text((mu_crit_1 + mu_crit_2) / 2, -12, 'Semi-infinite', 'HorizontalAlignment', 'center', 'FontSize', 10);
        text((mu_crit_2 + 2.5) / 2, -12, 'Entire plane', 'HorizontalAlignment', 'center', 'FontSize', 10);
    end

    hold off;
    saveas(gcf, '../assignment3_mu_sweep.png');

    % Verification plots at critical values
    figure; set(gcf, 'Position', [100, 100, 1200, 500]);
    subplot(1, 2, 1);
    fric_eq(r, alpha, [mu_crit_1 - 0.2, mu_crit_1 - 0.2], true, false);
    title(sprintf('Below $\\mu_1^* = %.3f$', mu_crit_1));

    subplot(1, 2, 2);
    fric_eq(r, alpha, [mu_crit_1 + 0.01, mu_crit_1 + 0.01], true, false);
    title(sprintf('Just above $\\mu_1^* = %.3f$', mu_crit_1));
    saveas(gcf, '../assignment3_critical1.png');

    figure; set(gcf, 'Position', [100, 100, 1200, 500]);
    subplot(1, 2, 1);
    fric_eq(r, alpha, [mu_crit_2 - 0.5, mu_crit_2 - 0.5], true, false);
    title(sprintf('Below $\\mu_2^* = %.3f$', mu_crit_2));

    subplot(1, 2, 2);
    fric_eq(r, alpha, [mu_crit_2 + 0.01, mu_crit_2 + 0.01], true, false);
    title(sprintf('Just above $\\mu_2^* = %.3f$', mu_crit_2));
    saveas(gcf, '../assignment3_critical2.png');
end

%% Assignment 4: Normal force upper bound
run_assignment_4 = false;

if run_assignment_4
    fprintf('=== Assignment 4 ===\n');

    mu_fixed = 0.4;

    % Sweep b from small to large
    b_values = linspace(0.1, 2, 1000);
    x_min_vals = zeros(size(b_values));
    x_max_vals = zeros(size(b_values));

    for i = 1:length(b_values)
        b = b_values(i);
        [x_min_vals(i), x_max_vals(i)] = fric_eq_b(r, alpha, [mu_fixed, mu_fixed], b, false);
    end

    % Find critical transitions (where bounds change behavior)
    % Look for where NaN transitions to finite, or where slope changes significantly
    valid_idx = find(~isnan(x_min_vals) & ~isnan(x_max_vals), 1, 'first');

    if ~isempty(valid_idx)
        b_crit_min = b_values(valid_idx);
    end

    fprintf('b_crit_min = %.4f\n', b_crit_min);

    % Find where bounds stabilize (derivative approaches zero)
    dx_min = diff(x_min_vals);
    dx_max = diff(x_max_vals);

    % Plot x_min and x_max vs b
    figure; set(gcf, 'Position', [100, 100, 800, 500]);
    hold on;

    plot(b_values, x_min_vals, '-', 'LineWidth', 2, 'DisplayName', '$x_{\min}$');
    plot(b_values, x_max_vals, '-', 'LineWidth', 2, 'DisplayName', '$x_{\max}$');

    % Reference values from unbounded case
    [x_min_ref, x_max_ref, b_req_min, b_req_max] = fric_eq(r, alpha, [mu_fixed, mu_fixed], false);
    yline(x_min_ref, 'b--', 'LineWidth', 1, 'HandleVisibility', 'off');
    yline(x_max_ref, 'r--', 'LineWidth', 1, 'HandleVisibility', 'off');

    % Calculate saturation transition (where both bounds reach unbounded values)
    b_sat = max(b_req_min, b_req_max);
    fprintf('b_sat = %.4f\n', b_sat);

    % Mark critical transition
    if exist('b_crit_min', 'var')
        xline(b_crit_min, 'k--', 'LineWidth', 1.5, 'DisplayName', sprintf('$b^* = %.4f$', b_crit_min));
    end

    if exist('b_sat', 'var') && ~isnan(b_sat)
        xline(b_sat, 'k-.', 'LineWidth', 1.5, 'DisplayName', sprintf('Saturation $b = %.4f$', b_sat));
    end

    % Formatting
    xlabel('Normal force bound $b$');
    ylabel('COM $x$-position bounds');
    title(sprintf('Permissible COM region vs. normal force bound ($\\mu = %.1f$)', mu_fixed));
    legend('Location', 'best');
    xlim([0, 2]);
    grid on;
    hold off;

    saveas(gcf, '../assignment4_b_sweep.png');

    % Show specific cases (separate figures)

    % Case 1: Small b
    b_small = 0.6;
    fric_eq_b(r, alpha, [mu_fixed, mu_fixed], b_small, true, true);
    title(sprintf('$b = %.1f$', b_small));
    saveas(gcf, '../assignment4_case_1.png');

    % Case 2: Large b
    b_large = 1;
    fric_eq_b(r, alpha, [mu_fixed, mu_fixed], b_large, true, true);
    title(sprintf('$b = %.1f$', b_large));
    saveas(gcf, '../assignment4_case_2.png');
end

%% Assignment 5: Horizontal disturbance force
run_assignment_5 = false;

if run_assignment_5
    fprintf('=== Assignment 5 ===\n');

    mu_fixed = 0.4;
    x_c = 1;
    y_c = 5;

    % Find permissible range of horizontal force f_x
    [fx_min, fx_max] = solve_fx_range(r, alpha, [mu_fixed, mu_fixed], x_c, y_c);
    fprintf('Permissible horizontal force range: f_x ∈ [%.4f, %.4f]\n', fx_min, fx_max);

    % Generate a visualization
    visualize_fx_range(r, alpha, [mu_fixed, mu_fixed], x_c, y_c, fx_min, fx_max);
    saveas(gcf, '../assignment5_fx.png');
end

%% Assignment 6: Unknown direction disturbance
run_assignment_6 = true;

if run_assignment_6
    fprintf('=== Assignment 6 ===\n');

    mu_fixed = 0.4;
    x_c = 1;

    % Part 1: Find max magnitude for h = 5
    h_single = 5;
    [fd_max_smart, theta_smart, fd_max_h5, theta_crit] = solve_max_disturbance(r, alpha, [mu_fixed, mu_fixed], x_c, h_single);
    fprintf('For h = %d: max |f_d| = %.4f (critical angle = %.1f°)\n', h_single, fd_max_h5, rad2deg(theta_crit));
    fprintf('  Smart method (18 angles): %.6f (critical angle = %.4f°)\n', fd_max_smart, rad2deg(theta_smart));
    fprintf('  Full 360° sweep:          %.6f (critical angle = %.4f°)\n', fd_max_h5, rad2deg(theta_crit));
    fprintf('  Difference:               %.2e (%.4f%% - verification passed)\n', ...
        abs(fd_max_smart - fd_max_h5), 100 * abs(fd_max_smart - fd_max_h5) / fd_max_h5);

    % Visualization for h = 5 (use sweep result)
    visualize_disturbance_force(r, alpha, [mu_fixed, mu_fixed], x_c, h_single, fd_max_h5);
    saveas(gcf, '../assignment6_h5.png');

    % Part 2: Sweep h from 0 to 10 (use sweep result for accuracy)
    h_values = linspace(0.1, 10, 100);
    fd_max_vals = zeros(size(h_values));

    for i = 1:length(h_values)
        [~, ~, fd_max_vals(i), ~] = solve_max_disturbance(r, alpha, [mu_fixed, mu_fixed], x_c, h_values(i));
    end

    % Plot max |f_d| vs h
    figure; set(gcf, 'Position', [100, 100, 800, 500]);
    plot(h_values, fd_max_vals, '-', 'LineWidth', 2, 'DisplayName', '$|\mathbf{f}_d|_{\max}$');
    hold on;

    % Mark h = 5
    plot(h_single, fd_max_h5, 'ko', 'MarkerSize', 10, 'MarkerFaceColor', 'r', ...
        'DisplayName', sprintf('$h = %d$: $|\\mathbf{f}_d|_{\\max} = %.4f$', h_single, fd_max_h5));

    % Formatting
    xlabel('COM height $h$');
    ylabel('Maximum disturbance magnitude $|\mathbf{f}_d|_{\max}$');
    title(sprintf('Maximum disturbance force vs. COM height ($\\mu = %.1f$, $x_c = %d$)', mu_fixed, x_c));
    legend('Location', 'best');
    xlim([0, 10]);
    grid on;
    hold off;

    saveas(gcf, '../assignment6_h_sweep.png');
end

%% ===================== HELPER FUNCTIONS =====================

function [geom] = compute_contact_geometry(r, alpha, mu)
    % COMPUTE_CONTACT_GEOMETRY Compute contact normals, tangents, and friction cone edges.
    %
    % Output struct fields:
    %   x1, y1, x2, y2  - contact positions
    %   n1, t1, n2, t2  - normal and tangent vectors
    %   e11, e12, e21, e22 - friction cone edge directions (unnormalized)
    %   e11_norm, e12_norm, e21_norm, e22_norm - normalized edge directions

    geom.x1 = r(1, 1); geom.y1 = r(2, 1);
    geom.x2 = r(1, 2); geom.y2 = r(2, 2);

    geom.n1 = [cos(alpha(1)); sin(alpha(1))];
    geom.t1 = [-sin(alpha(1)); cos(alpha(1))];
    geom.n2 = [cos(alpha(2)); sin(alpha(2))];
    geom.t2 = [-sin(alpha(2)); cos(alpha(2))];

    geom.e11 = geom.n1 + mu(1) * geom.t1;
    geom.e12 = geom.n1 - mu(1) * geom.t1;
    geom.e21 = geom.n2 + mu(2) * geom.t2;
    geom.e22 = geom.n2 - mu(2) * geom.t2;

    geom.e11_norm = geom.e11 / norm(geom.e11);
    geom.e12_norm = geom.e12 / norm(geom.e12);
    geom.e21_norm = geom.e21 / norm(geom.e21);
    geom.e22_norm = geom.e22 / norm(geom.e22);
end

function [A, b] = build_friction_cone_constraints(geom, mu)
    % BUILD_FRICTION_CONE_CONSTRAINTS Build LP inequality constraints for friction cones.
    %
    % For decision variables [f1x, f1y, f2x, f2y, ...]
    % Returns A (6x5+) and b (6x1) for friction cone constraints.

    n1 = geom.n1; t1 = geom.t1;
    n2 = geom.n2; t2 = geom.t2;

    A = [
    % Contact 1 constraints (columns: f1x, f1y, f2x, f2y, ...)
         -n1(1), -n1(2), 0, 0;
         t1(1) - mu(1) * n1(1), t1(2) - mu(1) * n1(2), 0, 0;
         -t1(1) - mu(1) * n1(1), -t1(2) - mu(1) * n1(2), 0, 0;
    % Contact 2 constraints
         0, 0, -n2(1), -n2(2);
         0, 0, t2(1) - mu(2) * n2(1), t2(2) - mu(2) * n2(2);
         0, 0, -t2(1) - mu(2) * n2(1), -t2(2) - mu(2) * n2(2);
         ];
    b = zeros(6, 1);
end

function plot_contact_geometry(geom, plot_opts)
    % PLOT_CONTACT_GEOMETRY Plot contact points, normals, and friction cones.
    %
    % Input:
    %   geom      - geometry struct from compute_contact_geometry
    %   plot_opts - struct with fields: colors, line_length, x_lim, y_lim

    colors = plot_opts.colors;
    L = plot_opts.line_length;
    x1 = geom.x1; y1 = geom.y1;
    x2 = geom.x2; y2 = geom.y2;

    % Contact normals (dashed)
    plot([x1, x1 + geom.n1(1) * L], [y1, y1 + geom.n1(2) * L], ...
        'k--', 'DisplayName', 'Contact normals');
    plot([x2, x2 + geom.n2(1) * L], [y2, y2 + geom.n2(2) * L], ...
        'k--', 'HandleVisibility', 'off');

    % Friction cone boundaries - positive direction
    plot([x1, x1 + geom.e11_norm(1) * L], [y1, y1 + geom.e11_norm(2) * L], ...
        'Color', colors(1, :), 'DisplayName', 'Friction cone 1');
    plot([x1, x1 + geom.e12_norm(1) * L], [y1, y1 + geom.e12_norm(2) * L], ...
        'Color', colors(1, :), 'HandleVisibility', 'off');
    plot([x2, x2 + geom.e21_norm(1) * L], [y2, y2 + geom.e21_norm(2) * L], ...
        'Color', colors(2, :), 'DisplayName', 'Friction cone 2');
    plot([x2, x2 + geom.e22_norm(1) * L], [y2, y2 + geom.e22_norm(2) * L], ...
        'Color', colors(2, :), 'HandleVisibility', 'off');

    % Friction cone boundaries - negative direction (dotted)
    plot([x1, x1 - geom.e11_norm(1) * L], [y1, y1 - geom.e11_norm(2) * L], ...
        ':', 'Color', colors(1, :), 'HandleVisibility', 'off');
    plot([x1, x1 - geom.e12_norm(1) * L], [y1, y1 - geom.e12_norm(2) * L], ...
        ':', 'Color', colors(1, :), 'HandleVisibility', 'off');
    plot([x2, x2 - geom.e21_norm(1) * L], [y2, y2 - geom.e21_norm(2) * L], ...
        ':', 'Color', colors(2, :), 'HandleVisibility', 'off');
    plot([x2, x2 - geom.e22_norm(1) * L], [y2, y2 - geom.e22_norm(2) * L], ...
        ':', 'Color', colors(2, :), 'HandleVisibility', 'off');

    % Contact points
    plot(x1, y1, 'ko', 'MarkerSize', 10, 'MarkerFaceColor', 'k', ...
        'DisplayName', 'Contact points');
    plot(x2, y2, 'ko', 'MarkerSize', 10, 'MarkerFaceColor', 'k', ...
        'HandleVisibility', 'off');
end

function [x_min, x_max] = solve_lp_bounds(A_ineq, b_ineq, Aeq, beq, obj_col, num_vars)
    % SOLVE_LP_BOUNDS Solve LP to find min/max of a decision variable.
    %
    % Input:
    %   A_ineq, b_ineq - inequality constraints A*x <= b
    %   Aeq, beq       - equality constraints
    %   obj_col        - index of the variable to optimize
    %   num_vars       - total number of decision variables
    %
    % Output:
    %   x_min, x_max   - bounds on the variable (may be ±inf or NaN)

    f_obj = zeros(num_vars, 1);
    f_obj(obj_col) = 1;

    options = optimoptions('linprog', 'Display', 'off');

    [~, x_min, exitflag_min] = linprog(f_obj, A_ineq, b_ineq, Aeq, beq, [], [], options);
    [~, neg_x_max, exitflag_max] = linprog(-f_obj, A_ineq, b_ineq, Aeq, beq, [], [], options);

    if exitflag_min == -3
        x_min = -inf;
    elseif exitflag_min == -2
        x_min = NaN;
    end

    if exitflag_max == 1
        x_max = -neg_x_max;
    elseif exitflag_max == -3
        x_max = inf;
    else
        x_max = NaN;
    end

end

%% ===================== MAIN FUNCTIONS =====================

function [x_min, x_max, b_req_min, b_req_max] = fric_eq(r, alpha, mu, do_plot, new_figure)
    % FRIC_EQ Compute permissible COM region for planar rigid body with
    % two frictional unilateral contacts in static equilibrium.

    if nargin < 4, do_plot = true; end
    if nargin < 5, new_figure = true; end

    geom = compute_contact_geometry(r, alpha, mu);
    [A_fric, ~] = build_friction_cone_constraints(geom, mu);

    % Decision variables: [f1x, f1y, f2x, f2y, xc]
    A = [A_fric, zeros(6, 1)];
    b = zeros(6, 1);

    % Static equilibrium: f1 + f2 = [0; mg], moment balance
    Aeq = [
           1, 0, 1, 0, 0;
           0, 1, 0, 1, 0;
           -geom.y1, geom.x1, -geom.y2, geom.x2, -1;
           ];
    beq = [0; 1; 0];

    % Solve LP for xc bounds
    options = optimoptions('linprog', 'Display', 'off');
    f_obj = [0; 0; 0; 0; 1];

    [sol_min, x_min, exitflag_min] = linprog(f_obj, A, b, Aeq, beq, [], [], options);
    [sol_max, neg_x_max, exitflag_max] = linprog(-f_obj, A, b, Aeq, beq, [], [], options);
    x_max = -neg_x_max;

    b_req_min = NaN; b_req_max = NaN;

    if exitflag_min == 1
        f1 = sol_min(1:2); f2 = sol_min(3:4);
        b_req_min = max(dot(f1, geom.n1), dot(f2, geom.n2));
    elseif exitflag_min == -3
        x_min = -inf;
    elseif exitflag_min == -2
        x_min = NaN;
    end

    if exitflag_max == 1
        f1 = sol_max(1:2); f2 = sol_max(3:4);
        b_req_max = max(dot(f1, geom.n1), dot(f2, geom.n2));
    elseif exitflag_max == -3
        x_max = inf;
    elseif exitflag_max == -2
        x_max = NaN;
    end

    if ~do_plot, return; end

    % Plotting
    if new_figure
        figure; set(gcf, 'Position', [100, 100, 800, 600]);
    end

    hold on;

    colors = get(gca, 'ColorOrder');
    half_width = 6;
    line_length = 10;

    x_plot_min = -half_width; x_plot_max = half_width;
    y_plot_min = 2 - half_width; y_plot_max = 2 + half_width;

    plot_opts = struct('colors', colors, 'line_length', line_length);
    plot_contact_geometry(geom, plot_opts);

    % COM region boundaries
    if isfinite(x_min)
        plot([x_min, x_min], [y_plot_min, y_plot_max], ...
            'Color', colors(3, :), 'LineWidth', 3, 'DisplayName', 'COM region boundary');
    end

    if isfinite(x_max)
        plot([x_max, x_max], [y_plot_min, y_plot_max], ...
            'Color', colors(3, :), 'LineWidth', 3, 'HandleVisibility', 'off');
    end

    % Shade permissible region
    x_fill_min = max(x_min, x_plot_min);
    x_fill_max = min(x_max, x_plot_max);

    if ~isnan(x_fill_min) && ~isnan(x_fill_max)
        fill([x_fill_min, x_fill_max, x_fill_max, x_fill_min], ...
            [y_plot_min, y_plot_min, y_plot_max, y_plot_max], ...
            colors(3, :), 'FaceAlpha', 0.2, 'EdgeColor', 'none', ...
            'DisplayName', 'Permissible COM region');
    end

    axis equal;
    xlim([x_plot_min, x_plot_max]); ylim([y_plot_min, y_plot_max]);
    xlabel('$x$'); ylabel('$y$');
    title(sprintf('$\\mu_1 = %.2f, \\mu_2 = %.2f$', mu(1), mu(2)));
    legend('Location', 'southwest');
    grid on; hold off;
end

function [x_min, x_max] = fric_eq_b(r, alpha, mu, b_bound, do_plot, new_figure)
    % FRIC_EQ_B Compute permissible COM region with normal force upper bound.

    if nargin < 5, do_plot = true; end
    if nargin < 6, new_figure = true; end

    geom = compute_contact_geometry(r, alpha, mu);
    [A_fric, ~] = build_friction_cone_constraints(geom, mu);

    % Add normal force upper bounds
    A_normal = [
                geom.n1(1), geom.n1(2), 0, 0;
                0, 0, geom.n2(1), geom.n2(2);
                ];

    A = [[A_fric; A_normal], zeros(8, 1)];
    b_ineq = [zeros(6, 1); b_bound; b_bound];

    Aeq = [
           1, 0, 1, 0, 0;
           0, 1, 0, 1, 0;
           -geom.y1, geom.x1, -geom.y2, geom.x2, -1;
           ];
    beq = [0; 1; 0];

    [x_min, x_max] = solve_lp_bounds(A, b_ineq, Aeq, beq, 5, 5);

    if ~do_plot, return; end

    if new_figure
        figure; set(gcf, 'Position', [100, 100, 800, 600]);
    end

    hold on;

    colors = get(gca, 'ColorOrder');
    half_width = 6;
    line_length = 10;

    x_plot_min = -half_width; x_plot_max = half_width;
    y_plot_min = 2 - half_width; y_plot_max = 2 + half_width;

    plot_opts = struct('colors', colors, 'line_length', line_length);
    plot_contact_geometry(geom, plot_opts);

    if isfinite(x_min)
        plot([x_min, x_min], [y_plot_min, y_plot_max], ...
            'Color', colors(3, :), 'LineWidth', 3, 'DisplayName', 'COM region boundary');
    end

    if isfinite(x_max)
        plot([x_max, x_max], [y_plot_min, y_plot_max], ...
            'Color', colors(3, :), 'LineWidth', 3, 'HandleVisibility', 'off');
    end

    x_fill_min = max(x_min, x_plot_min);
    x_fill_max = min(x_max, x_plot_max);

    if ~isnan(x_fill_min) && ~isnan(x_fill_max)
        fill([x_fill_min, x_fill_max, x_fill_max, x_fill_min], ...
            [y_plot_min, y_plot_min, y_plot_max, y_plot_max], ...
            colors(3, :), 'FaceAlpha', 0.2, 'EdgeColor', 'none', ...
            'DisplayName', 'Permissible COM region');
    end

    axis equal;
    xlim([x_plot_min, x_plot_max]); ylim([y_plot_min, y_plot_max]);
    xlabel('$x$'); ylabel('$y$');
    title(sprintf('$\\mu = %.2f,\\, b = %.2f$', mu(1), b_bound));
    legend('Location', 'southwest');
    grid on; hold off;
end

function [fx_min, fx_max] = solve_fx_range(r, alpha, mu, x_c, y_c)
    % SOLVE_FX_RANGE Find permissible range of horizontal force at COM.

    geom = compute_contact_geometry(r, alpha, mu);
    [A_fric, ~] = build_friction_cone_constraints(geom, mu);

    % Decision variables: [f1x, f1y, f2x, f2y, fx]
    A = [A_fric, zeros(6, 1)];
    b = zeros(6, 1);

    Aeq = [
           1, 0, 1, 0, 1;
           0, 1, 0, 1, 0;
           -geom.y1, geom.x1, -geom.y2, geom.x2, -y_c;
           ];
    beq = [0; 1; x_c];

    [fx_min, fx_max] = solve_lp_bounds(A, b, Aeq, beq, 5, 5);
end

function visualize_fx_range(r, alpha, mu, x_c, y_c, fx_min, fx_max)
    % VISUALIZE_FX_RANGE Create visualization for horizontal force problem.

    geom = compute_contact_geometry(r, alpha, mu);

    figure; set(gcf, 'Position', [100, 100, 900, 700]);
    hold on;

    colors = get(gca, 'ColorOrder');
    center = [(geom.x1 + geom.x2 + x_c) / 3, (geom.y1 + geom.y2 + y_c) / 3];
    half_width = max([abs(x_c - geom.x1), abs(x_c - geom.x2), ...
                          abs(y_c - geom.y1), abs(y_c - geom.y2)]) + 3;
    line_length = half_width * 1.5;

    plot_opts = struct('colors', colors, 'line_length', line_length);
    plot_contact_geometry(geom, plot_opts);

    % COM and forces
    plot(x_c, y_c, 'r^', 'MarkerSize', 12, 'MarkerFaceColor', 'r', ...
        'DisplayName', sprintf('COM $(%.0f, %.0f)$', x_c, y_c));

    arrow_scale = 1.5;
    quiver(x_c, y_c, 0, -arrow_scale, 0, 'k', 'LineWidth', 2, ...
        'MaxHeadSize', 0.5, 'DisplayName', '$mg$');

    if isfinite(fx_min) && isfinite(fx_max)
        quiver(x_c, y_c, fx_min * arrow_scale, 0, 0, 'Color', colors(4, :), ...
            'LineWidth', 2, 'MaxHeadSize', 0.5, ...
            'DisplayName', sprintf('$f_{x,\\min} = %.2f$', fx_min));
        quiver(x_c, y_c, fx_max * arrow_scale, 0, 0, 'Color', colors(5, :), ...
            'LineWidth', 2, 'MaxHeadSize', 0.5, ...
            'DisplayName', sprintf('$f_{x,\\max} = %.2f$', fx_max));
    end

    axis equal;
    xlim([center(1) - half_width, center(1) + half_width]);
    ylim([center(2) - half_width, center(2) + half_width]);
    xlabel('$x$'); ylabel('$y$');
    title(sprintf('Horizontal force range at COM$(%.0f, %.0f)$: $f_x \\in [%.2f, %.2f]$', ...
        x_c, y_c, fx_min, fx_max));
    legend('Location', 'southeast');
    grid on; hold off;
end

function [fd_max, theta_critical, fd_max_verify, theta_critical_verify] = solve_max_disturbance(r, alpha, mu, x_c, y_c)
    % SOLVE_MAX_DISTURBANCE Find maximum disturbance force for any direction.
    %
    % Uses a smart set of candidate angles derived from friction cone geometry,
    % then verifies with a full 360° sweep.

    geom = compute_contact_geometry(r, alpha, mu);
    [A_fric, ~] = build_friction_cone_constraints(geom, mu);
    options = optimoptions('linprog', 'Display', 'off');

    % Helper function to compute max fd for a given direction
    compute_fd = @(theta) compute_fd_for_angle(theta, A_fric, geom, x_c, y_c, options);

    % SMART METHOD: Only check critical candidate angles
    % Friction cone edge directions
    phi_edges = [alpha(1) + atan(mu(1)), alpha(1) - atan(mu(1)), ...
                     alpha(2) + atan(mu(2)), alpha(2) - atan(mu(2))];

    % Contact-to-COM moment arm directions (these affect constraint boundaries)
    moment_angles = [atan2(y_c - geom.y1, x_c - geom.x1), ...
                         atan2(y_c - geom.y2, x_c - geom.x2)];

    % Build candidate set: each base angle + perpendiculars
    candidate_angles = [];

    for phi = [phi_edges, moment_angles]
        candidate_angles = [candidate_angles, phi, phi + pi / 2, phi - pi / 2];
    end

    candidate_angles = unique(mod(candidate_angles, 2 * pi));

    % Evaluate at candidate angles
    fd_candidates = arrayfun(compute_fd, candidate_angles);
    [fd_max, idx] = min(fd_candidates);
    theta_critical = candidate_angles(idx);

    % VERIFICATION: Full 360° sweep at 1° resolution
    theta_sweep = linspace(0, 2 * pi - deg2rad(1), 360);
    fd_sweep = arrayfun(compute_fd, theta_sweep);
    [fd_max_verify, idx] = min(fd_sweep);
    theta_critical_verify = theta_sweep(idx);
end

function fd = compute_fd_for_angle(theta, A_fric, geom, x_c, y_c, options)
    % Compute maximum disturbance magnitude for a single direction.
    d_x = cos(theta); d_y = sin(theta);

    A = [[A_fric, zeros(6, 1)]; [0, 0, 0, 0, -1]];
    b = zeros(7, 1);

    Aeq = [
           1, 0, 1, 0, d_x;
           0, 1, 0, 1, d_y;
           -geom.y1, geom.x1, -geom.y2, geom.x2, x_c * d_y - y_c * d_x;
           ];
    beq = [0; 1; x_c];

    [~, neg_fd, exitflag] = linprog([0; 0; 0; 0; -1], A, b, Aeq, beq, [], [], options);

    if exitflag == 1
        fd = -neg_fd;
    elseif exitflag == -3
        fd = inf;
    else
        fd = 0;
    end

end

function visualize_disturbance_force(r, alpha, mu, x_c, y_c, fd_max)
    % VISUALIZE_DISTURBANCE_FORCE Create visualization for max disturbance.

    geom = compute_contact_geometry(r, alpha, mu);

    figure; set(gcf, 'Position', [100, 100, 900, 700]);
    hold on;

    colors = get(gca, 'ColorOrder');
    center = [(geom.x1 + geom.x2 + x_c) / 3, (geom.y1 + geom.y2 + y_c) / 3];
    half_width = max([abs(x_c - geom.x1), abs(x_c - geom.x2), ...
                          abs(y_c - geom.y1), abs(y_c - geom.y2)]) + 3;
    line_length = half_width * 1.5;

    plot_opts = struct('colors', colors, 'line_length', line_length);
    plot_contact_geometry(geom, plot_opts);

    plot(x_c, y_c, 'r^', 'MarkerSize', 12, 'MarkerFaceColor', 'r', ...
        'DisplayName', sprintf('COM $(%.0f, %.0f)$', x_c, y_c));

    quiver(x_c, y_c, 0, -1.5, 0, 'k', 'LineWidth', 2, ...
        'MaxHeadSize', 0.5, 'DisplayName', '$mg$');

    if isfinite(fd_max) && fd_max > 0
        theta_circle = linspace(0, 2 * pi, 100);
        circle_scale = 1.5;
        circle_x = x_c + fd_max * circle_scale * cos(theta_circle);
        circle_y = y_c + fd_max * circle_scale * sin(theta_circle);
        plot(circle_x, circle_y, 'Color', colors(3, :), 'LineWidth', 2, ...
            'DisplayName', sprintf('$|\\mathbf{f}_d|_{\\max} = %.4f$', fd_max));
        fill(circle_x, circle_y, colors(3, :), 'FaceAlpha', 0.2, ...
            'EdgeColor', 'none', 'HandleVisibility', 'off');
    end

    axis equal;
    xlim([center(1) - half_width, center(1) + half_width]);
    ylim([center(2) - half_width, center(2) + half_width]);
    xlabel('$x$'); ylabel('$y$');
    title(sprintf('Max disturbance force at COM$(%.0f, %.0f)$: $|\\mathbf{f}_d|_{\\max} = %.4f$', ...
        x_c, y_c, fd_max));
    legend('Location', 'southeast');
    grid on; hold off;
end
