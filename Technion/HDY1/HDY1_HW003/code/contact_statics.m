% Housekeeping
close all;
clear;
clc;

% Test with example: r1 = (-1,1), r2 = (2,2), alpha1 = 45°, alpha2 = 135°
% Note: each column of r is a contact point position
r = [-1, 2; 1, 2];
alpha = [pi/4, 3*pi/4];

% Case (a): mu = 0.4
fprintf('Case (a): mu = 0.4\n');
[x_min_a, x_max_a] = fric_eq(r, alpha, [0.4, 0.4]);
fprintf('x_min = %.4f, x_max = %.4f\n\n', x_min_a, x_max_a);

saveas(gcf, '../contact_statics_a.png');

% Case (b): mu = 0.8
fprintf('Case (b): mu = 0.8\n');
[x_min_b, x_max_b] = fric_eq(r, alpha, [0.8, 0.8]);
fprintf('x_min = %.4f, x_max = %.4f\n\n', x_min_b, x_max_b);

saveas(gcf, '../contact_statics_b.png');
% Assignment 1
function [x_min, x_max] = fric_eq(r, alpha, mu)
    % Input arguments:
    %   r     - 2x2 matrix, each column is a contact point position [x; y]
    %   alpha - 1x2 or 2x1 vector of contact normal angles (rad)
    %   mu    - 1x2 or 2x1 vector of friction coefficients
    %
    % Output arguments:
    %   x_min - minimal x-component of COM position
    %   x_max - maximal x-component of COM position

    % Extract contact positions
    r1 = r(:, 1);
    r2 = r(:, 2);
    x1 = r1(1); y1 = r1(2);
    x2 = r2(1); y2 = r2(2);

    % Compute normal and tangent vectors
    % Normal: n = [cos(alpha); sin(alpha)]
    % Tangent: t = [-sin(alpha); cos(alpha)] (90° CCW from normal)
    n1 = [cos(alpha(1)); sin(alpha(1))];
    t1 = [-sin(alpha(1)); cos(alpha(1))];
    n2 = [cos(alpha(2)); sin(alpha(2))];
    t2 = [-sin(alpha(2)); cos(alpha(2))];

    % Decision variables: x = [f1x, f1y, f2x, f2y, xc]' ∈ R^5
    % where fi = [fix, fiy] are contact force components, xc is COM x-position

    % Friction cone inequalities: A*x <= b
    % For each contact i:
    %   1. Normal force non-negative: -fi·ni <= 0
    %   2. Friction bound (+): fi·ti - μi(fi·ni) <= 0
    %   3. Friction bound (-): -fi·ti - μi(fi·ni) <= 0
    
    A = [
        % Contact 1 constraints (columns: f1x, f1y, f2x, f2y, xc)
        -n1(1), -n1(2), 0, 0, 0;                                    % -f1·n1 <= 0
        t1(1) - mu(1)*n1(1), t1(2) - mu(1)*n1(2), 0, 0, 0;          % f1·t1 - μ1(f1·n1) <= 0
        -t1(1) - mu(1)*n1(1), -t1(2) - mu(1)*n1(2), 0, 0, 0;        % -f1·t1 - μ1(f1·n1) <= 0
        % Contact 2 constraints
        0, 0, -n2(1), -n2(2), 0;                                    % -f2·n2 <= 0
        0, 0, t2(1) - mu(2)*n2(1), t2(2) - mu(2)*n2(2), 0;          % f2·t2 - μ2(f2·n2) <= 0
        0, 0, -t2(1) - mu(2)*n2(1), -t2(2) - mu(2)*n2(2), 0;        % -f2·t2 - μ2(f2·n2) <= 0
    ];
    b = zeros(6, 1);

    % Static equilibrium equalities: Aeq*x = beq
    % Force balance: f1 + f2 = [0; mg], normalize mg = 1
    % Moment balance about origin: r1×f1 + r2×f2 = mg*xc
    %   In 2D: (x1*f1y - y1*f1x) + (x2*f2y - y2*f2x) = xc
    Aeq = [
        1, 0, 1, 0, 0;           % f1x + f2x = 0
        0, 1, 0, 1, 0;           % f1y + f2y = 1
        -y1, x1, -y2, x2, -1;    % moment balance
    ];
    beq = [0; 1; 0];

    % Objective: minimize/maximize xc (5th component)
    f_obj = [0; 0; 0; 0; 1];

    % LP options
    options = optimoptions('linprog', 'Display', 'off');

    % Find x_min (minimize xc)
    [~, x_min, exitflag_min] = linprog(f_obj, A, b, Aeq, beq, [], [], options);

    % Find x_max (maximize xc = minimize -xc)
    [~, neg_x_max, exitflag_max] = linprog(-f_obj, A, b, Aeq, beq, [], [], options);
    x_max = -neg_x_max;

    % Handle special cases
    if exitflag_min == -3
        x_min = -inf;
    elseif exitflag_min == -2
        x_min = NaN;
    end

    if exitflag_max == -3
        x_max = inf;
    elseif exitflag_max == -2
        x_max = NaN;
    end

    % Friction cone edge directions (for plotting)
    e11 = n1 + mu(1) * t1;  % Left edge of cone 1
    e12 = n1 - mu(1) * t1;  % Right edge of cone 1
    e21 = n2 + mu(2) * t2;  % Left edge of cone 2
    e22 = n2 - mu(2) * t2;  % Right edge of cone 2

    % ==================== Plotting ====================
    figure; set(gcf, 'Position', [100, 100, 800, 600]); hold on;

    % Get color order from defaults (Set1 colormap)
    colors = get(gca, 'ColorOrder');

    % Plot settings: center at (0, 2), fixed scale
    center = [0, 2];
    half_width = 6;
    line_length = 10;

    x_plot_min = center(1) - half_width;
    x_plot_max = center(1) + half_width;
    y_plot_min = center(2) - half_width;
    y_plot_max = center(2) + half_width;

    % Plot contact normals (dashed lines)
    plot([x1, x1 + n1(1)*line_length], [y1, y1 + n1(2)*line_length], ...
         'k--', 'DisplayName', 'Contact normals');
    plot([x2, x2 + n2(1)*line_length], [y2, y2 + n2(2)*line_length], ...
         'k--', 'HandleVisibility', 'off');

    % Plot friction cone boundaries (solid lines)
    % Normalize edge directions for consistent line length
    e11_norm = e11 / norm(e11);
    e12_norm = e12 / norm(e12);
    e21_norm = e21 / norm(e21);
    e22_norm = e22 / norm(e22);

    % Positive direction (solid)
    plot([x1, x1 + e11_norm(1)*line_length], [y1, y1 + e11_norm(2)*line_length], ...
         'Color', colors(1,:), 'DisplayName', 'Friction cone 1');
    plot([x1, x1 + e12_norm(1)*line_length], [y1, y1 + e12_norm(2)*line_length], ...
         'Color', colors(1,:), 'HandleVisibility', 'off');
    plot([x2, x2 + e21_norm(1)*line_length], [y2, y2 + e21_norm(2)*line_length], ...
         'Color', colors(2,:), 'DisplayName', 'Friction cone 2');
    plot([x2, x2 + e22_norm(1)*line_length], [y2, y2 + e22_norm(2)*line_length], ...
         'Color', colors(2,:), 'HandleVisibility', 'off');
    % Negative direction (dotted)
    plot([x1, x1 - e11_norm(1)*line_length], [y1, y1 - e11_norm(2)*line_length], ...
         ':', 'Color', colors(1,:), 'HandleVisibility', 'off');
    plot([x1, x1 - e12_norm(1)*line_length], [y1, y1 - e12_norm(2)*line_length], ...
         ':', 'Color', colors(1,:), 'HandleVisibility', 'off');
    plot([x2, x2 - e21_norm(1)*line_length], [y2, y2 - e21_norm(2)*line_length], ...
         ':', 'Color', colors(2,:), 'HandleVisibility', 'off');
    plot([x2, x2 - e22_norm(1)*line_length], [y2, y2 - e22_norm(2)*line_length], ...
         ':', 'Color', colors(2,:), 'HandleVisibility', 'off');

    % Plot COM equilibrium region boundaries (thick lines)
    if isfinite(x_min)
        plot([x_min, x_min], [y_plot_min, y_plot_max], ...
             'Color', colors(3,:), 'LineWidth', 3, 'DisplayName', 'COM region boundary');
    end
    if isfinite(x_max)
        plot([x_max, x_max], [y_plot_min, y_plot_max], ...
             'Color', colors(3,:), 'LineWidth', 3, 'HandleVisibility', 'off');
    end

    % Shade the permissible region
    if isfinite(x_min) && isfinite(x_max)
        fill([x_min, x_max, x_max, x_min], ...
             [y_plot_min, y_plot_min, y_plot_max, y_plot_max], ...
             colors(3,:), 'FaceAlpha', 0.2, 'EdgeColor', 'none', ...
             'DisplayName', 'Permissible COM region');
    end

    % Plot contact points (on top)
    plot(x1, y1, 'ko', 'MarkerSize', 10, 'MarkerFaceColor', 'k', ...
         'DisplayName', 'Contact points');
    plot(x2, y2, 'ko', 'MarkerSize', 10, 'MarkerFaceColor', 'k', ...
         'HandleVisibility', 'off');

    % Formatting
    axis equal;
    xlim([x_plot_min, x_plot_max]);
    ylim([y_plot_min, y_plot_max]);
    xlabel('$x$');
    ylabel('$y$');
    title(sprintf('$\\mu_1 = %.2f, \\mu_2 = %.2f$', mu(1), mu(2)));
    legend('Location', 'southwest');
    grid on;
    hold off;

end
