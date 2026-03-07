function compass_biped()
    %% Compass Biped - Numerical Simulations
    % Run compass_biped_symbolic.m first to generate required functions.

    close all; clc;

    %% Parameters
    params.m = 4;
    params.m_h = 1.8;
    params.I_c = 0;
    params.l = 0.8;
    params.g = 10;
    params.alpha = deg2rad(1.5);
    params.mu = 0.5;

    print_params(params);
    setup_plots();

    %% Task 5: Find Fixed Point
    fprintf('=== Finding Fixed Point ===\n\n');
    
    % Initial guess (adjust based on Gamus thesis page 35)
    z0 = [-0.149; 0.733; -0.501];
    
    opts = optimoptions('fsolve', 'Display', 'iter', 'TolFun', 1e-10, 'TolX', 1e-10);
    G = @(z) poincare_residual(z, params);
    [z_star, fval, exitflag] = fsolve(G, z0, opts);
    
    if exitflag > 0
        fprintf('\nFixed point found:\n');
        fprintf('  theta_c = %.6f rad (%.4f deg)\n', z_star(1), rad2deg(z_star(1)));
        fprintf('  theta1_dot = %.6f rad/s\n', z_star(2));
        fprintf('  theta2_dot = %.6f rad/s\n', z_star(3));
        fprintf('  Residual norm = %.2e\n', norm(fval));
        
        % Plot periodic solution
        % plot_periodic_solution(z_star, params);
    else
        fprintf('Failed to find fixed point (exitflag = %d)\n', exitflag);
    end
    plot_periodic_solution(z_star, params);

    %% Task 6: Minimum Friction Coefficient
    fprintf('\n=== Task 6: Minimum Friction ===\n\n');
    mu_min = find_mu_min(z_star, params);
end

function print_params(p)
    fprintf('=== Compass Biped ===\n\n');
    fprintf('m = %.2f kg, m_h = %.2f kg, l = %.2f m\n', p.m, p.m_h, p.l);
    fprintf('g = %.2f m/s^2, alpha = %.2f deg, mu = %.3f\n\n', p.g, rad2deg(p.alpha), p.mu);
end

function setup_plots()
    set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
    set(groot, 'defaultTextInterpreter', 'latex');
    set(groot, 'defaultLegendInterpreter', 'latex');
    set(groot, 'DefaultLineLineWidth', 2);
    set(groot, 'defaultAxesFontSize', 14);
end

function colors = get_colors()
    co = get(groot, 'DefaultAxesColorOrder');
    if isempty(co) || ischar(co)
        co = [0 0.4470 0.7410; 0.8500 0.3250 0.0980; 0.9290 0.6940 0.1250];
    end
    colors.c1 = co(1,:);
    colors.c2 = co(2,:);
    colors.c3 = co(3,:);
end

function [lambda_n, lambda_t] = compute_forces(X, params)
    N = size(X, 1);
    lambda_n = zeros(N, 1);
    lambda_t = zeros(N, 1);
    for i = 1:N
        [lambda_n(i), lambda_t(i)] = stick_forces(X(i,1), X(i,2), X(i,3), X(i,4), ...
            params.m, params.m_h, params.I_c, params.l, params.g, params.alpha);
    end
end

%% Task 6: Minimum friction coefficient
function mu_min = find_mu_min(z_star, params)
    [T, X, Lambda_impact] = simulate_one_period(z_star, params);
    [lambda_n, lambda_t] = compute_forces(X, params);
    
    ratio_continuous = abs(lambda_t ./ lambda_n);
    mu_continuous = max(ratio_continuous);
    [~, idx_max] = max(ratio_continuous);
    
    fprintf('Continuous phase:\n');
    fprintf('  max |lambda_t / lambda_n| = %.6f  at t = %.4f s\n', mu_continuous, T(idx_max));
    
    mu_impact = 0;
    if ~isempty(Lambda_impact)
        mu_impact = abs(Lambda_impact(1) / Lambda_impact(2));
        fprintf('Impact:\n');
        fprintf('  |Lambda_t / Lambda_n| = %.6f\n', mu_impact);
    end
    
    mu_min = max(mu_continuous, mu_impact);
    
    if mu_impact >= mu_continuous
        fprintf('\nmu_min = %.6f  (determined by impact)\n', mu_min);
    else
        fprintf('\nmu_min = %.6f  (determined by continuous phase at t = %.4f s)\n', mu_min, T(idx_max));
    end
end

%% Task 5: Residual for fsolve
function G = poincare_residual(z, params)
    [z_new, status] = poincare_map(z, params);
    if status ~= 0
        G = 1e6 * ones(3, 1);
    else
        G = z_new - z;
    end
end

%% Task 5: Plot periodic solution
function plot_periodic_solution(z_star, params)
    [T, X, Lambda_impact] = simulate_one_period(z_star, params);
    l = params.l;
    colors = get_colors();
    c1 = colors.c1;
    c2 = colors.c2;
    
    [lambda_n, lambda_t] = compute_forces(X, params);
    y_swing = 2*l*cos(X(:,1)) - 2*l*cos(X(:,2));
    scuff_idx = find(y_swing < 0);
    
    fig_dir = fullfile(fileparts(mfilename('fullpath')), 'figures');
    if ~exist(fig_dir, 'dir'), mkdir(fig_dir); end
    
    % (a) Angles vs time
    fig_a = figure('Position', [100, 100, 600, 400]);
    plot(T, rad2deg(X(:,1)), '-', 'Color', c1, 'DisplayName', '$\theta_1$'); hold on;
    plot(T, rad2deg(X(:,2)), '-', 'Color', c2, 'DisplayName', '$\theta_2$');
    if ~isempty(scuff_idx)
        xline(T(scuff_idx(1)), 'k--', 'HandleVisibility', 'off');
        xline(T(scuff_idx(end)), 'k--', 'HandleVisibility', 'off');
        text(T(scuff_idx(1)), max(rad2deg(X(:,1))), ' scuffing', 'FontSize', 10);
    end
    xlabel('Time [s]', 'Interpreter', 'latex'); 
    ylabel('Angle [deg]', 'Interpreter', 'latex');
    title('(a) Angles vs Time', 'Interpreter', 'latex'); 
    legend('Interpreter', 'latex', 'Location', 'best'); grid on;
    exportgraphics(fig_a, fullfile(fig_dir, 'task5_a_angles.png'), 'Resolution', 300);
    
    % (b) Phase portrait
    fig_b = figure('Position', [150, 150, 600, 400]);
    plot(rad2deg(X(:,1)), X(:,3), '-', 'Color', c1, 'DisplayName', '$\theta_1$'); hold on;
    plot(rad2deg(X(:,2)), X(:,4), '-', 'Color', c2, 'DisplayName', '$\theta_2$');
    plot(rad2deg(X(1,1)), X(1,3), 'x', 'Color', c1, 'MarkerSize', 10, 'LineWidth', 2, 'HandleVisibility', 'off');
    plot(rad2deg(X(1,2)), X(1,4), 'x', 'Color', c2, 'MarkerSize', 10, 'LineWidth', 2, 'HandleVisibility', 'off');
    plot(rad2deg(X(end,1)), X(end,3), 'x', 'Color', c1, 'MarkerSize', 10, 'LineWidth', 2, 'HandleVisibility', 'off');
    plot(rad2deg(X(end,2)), X(end,4), 'x', 'Color', c2, 'MarkerSize', 10, 'LineWidth', 2, 'HandleVisibility', 'off');
    plot([rad2deg(X(end,1)), rad2deg(X(1,2))], [X(end,3), X(1,4)], ':', 'Color', c1, 'LineWidth', 1.5, 'HandleVisibility', 'off');
    plot([rad2deg(X(end,2)), rad2deg(X(1,1))], [X(end,4), X(1,3)], ':', 'Color', c2, 'LineWidth', 1.5, 'HandleVisibility', 'off');
    if ~isempty(scuff_idx)
        plot(rad2deg(X(scuff_idx(1),1)), X(scuff_idx(1),3), 'o', 'Color', c1, 'MarkerSize', 8, 'LineWidth', 2, ...
            'DisplayName', 'Scuffing');
        plot(rad2deg(X(scuff_idx(1),2)), X(scuff_idx(1),4), 'o', 'Color', c2, 'MarkerSize', 8, 'LineWidth', 2, ...
            'HandleVisibility', 'off');
    end
    xlabel('$\theta$ [deg]', 'Interpreter', 'latex'); 
    ylabel('$\dot{\theta}$ [rad/s]', 'Interpreter', 'latex');
    title('(b) Phase Portrait', 'Interpreter', 'latex');
    legend('Interpreter', 'latex', 'Location', 'best'); grid on;
    exportgraphics(fig_b, fullfile(fig_dir, 'task5_b_phase.png'), 'Resolution', 300);
    
    % (c) Normal force
    fig_c = figure('Position', [200, 200, 600, 400]);
    plot(T, lambda_n, '-', 'Color', c1); hold on;
    yline(0, 'k--', 'HandleVisibility', 'off');
    xlabel('Time [s]', 'Interpreter', 'latex'); 
    ylabel('$\lambda_n$ [N]', 'Interpreter', 'latex');
    title('(c) Normal Contact Force', 'Interpreter', 'latex'); grid on;
    exportgraphics(fig_c, fullfile(fig_dir, 'task5_c_normal_force.png'), 'Resolution', 300);
    
    % (d) Force ratio
    fig_d = figure('Position', [250, 250, 600, 400]);
    ratio = lambda_t ./ lambda_n;
    plot(T, ratio, '-', 'Color', c1, 'DisplayName', '$\lambda_t / \lambda_n$'); hold on;
    yline(params.mu, '--', 'Color', c2, 'DisplayName', '$\pm \mu$');
    yline(-params.mu, '--', 'Color', c2, 'HandleVisibility', 'off');
    if ~isempty(Lambda_impact)
        impulse_ratio = Lambda_impact(1) / Lambda_impact(2);
        plot(T(end), impulse_ratio, 'kx', 'MarkerSize', 12, 'LineWidth', 2, ...
            'DisplayName', sprintf('Impact: $\\Lambda_t/\\Lambda_n = %.3f$', impulse_ratio));
    end
    xlabel('Time [s]', 'Interpreter', 'latex'); 
    ylabel('$\lambda_t / \lambda_n$', 'Interpreter', 'latex');
    title('(d) Force Ratio', 'Interpreter', 'latex');
    legend('Interpreter', 'latex', 'Location', 'best'); grid on;
    ylim([-1, 1]);
    exportgraphics(fig_d, fullfile(fig_dir, 'task5_d_force_ratio.png'), 'Resolution', 300);
    
    % (e) Swing foot height
    fig_e = figure('Position', [300, 300, 600, 400]);
    plot(T, y_swing, '-', 'Color', c1); hold on;
    yline(0, 'k--', 'HandleVisibility', 'off');
    if ~isempty(scuff_idx)
        xline(T(scuff_idx(1)), 'k--', 'HandleVisibility', 'off');
        xline(T(scuff_idx(end)), 'k--', 'HandleVisibility', 'off');
        text(T(scuff_idx(1)), max(y_swing)*0.8, ' scuffing', 'FontSize', 10);
    end
    xlabel('Time [s]', 'Interpreter', 'latex'); 
    ylabel('$\tilde{y}$ [m]', 'Interpreter', 'latex');
    title('(e) Swing Foot Height', 'Interpreter', 'latex'); grid on;
    exportgraphics(fig_e, fullfile(fig_dir, 'task5_e_swing_height.png'), 'Resolution', 300);
    
    fprintf('Figures saved to: %s\n', fig_dir);
end

function [T, X, Lambda_impact] = simulate_one_period(z_star, params)
    theta_c = z_star(1);
    theta1_dot = z_star(2);
    theta2_dot = z_star(3);
    
    X0 = [theta_c; theta_c; theta1_dot; theta2_dot];
    
    opts = odeset('RelTol', 1e-10, 'AbsTol', 1e-12, ...
        'Events', @(t, X) events_poincare(t, X, params));
    [T, X, ~, Xe, Ie] = ode45(@(t, X) sys_stick(t, X, params), [0, 10], X0, opts);
    
    Lambda_impact = [];
    if ~isempty(Ie) && Ie(end) == 1
        [~, ~, Lambda_impact] = impact_law(Xe(end,:)', params);
    end
end

%% Poincare Map
% Z = [theta_c; theta1_dot; theta2_dot] - reduced state at post-impact
% Status: 0=success, 1=falling, 2=double-foot impact, 3=slip onset
function [Znew, status] = poincare_map(Zold, params)
    theta_c = Zold(1);
    theta1_dot = Zold(2);
    theta2_dot = Zold(3);

    % Convert to full state (at post-impact, theta1 = theta2 = theta_c)
    X0 = [theta_c; theta_c; theta1_dot; theta2_dot];

    % Integrate until next event
    T_max = 10;
    opts = odeset('RelTol', 1e-10, 'AbsTol', 1e-12, ...
        'Events', @(t, X) events_poincare(t, X, params));
    [~, ~, Te, Xe, Ie] = ode45(@(t, X) sys_stick(t, X, params), [0, T_max], X0, opts);

    % Check termination
    if isempty(Ie)
        status = 1;
        Znew = [];
        return;
    end

    event = Ie(end);
    if event == 2
        status = 1;  % Falling
        Znew = [];
        return;
    elseif event == 3 || event == 4
        status = 3;  % Slip onset
        Znew = [];
        return;
    end

    % Event 1: Impact
    Xpre = Xe(end, :)';
    [Xpost, impact_status, ~] = impact_law(Xpre, params);
    
    if impact_status ~= 0
        status = 2;  % Double-foot impact
        Znew = [];
        return;
    end

    % Extract reduced state
    theta_c_new = (Xpost(1) + Xpost(2)) / 2;
    Znew = [theta_c_new; Xpost(3); Xpost(4)];
    status = 0;
end

function dXdt = sys_stick(~, X, params)
    [th1_ddot, th2_ddot] = stick_accelerations(X(1), X(2), X(3), X(4), ...
        params.m, params.m_h, params.I_c, params.l, params.g, params.alpha);
    dXdt = [X(3); X(4); th1_ddot; th2_ddot];
end

function [value, isterminal, direction] = events_poincare(~, X, params)
    theta1 = X(1);
    theta2 = X(2);
    theta1_dot = X(3);
    theta2_dot = X(4);
    l = params.l;
    mu = params.mu;

    % Swing foot height and relative position
    y_swing = 2*l*cos(theta1) - 2*l*cos(theta2);
    x_swing_rel = 2*l*(sin(theta1) + sin(theta2));
    
    % Impact: swing foot at ground AND ahead
    scuff_threshold = 0.3 * l;
    if x_swing_rel > scuff_threshold
        swing_collision = y_swing;
    else
        swing_collision = 1;
    end

    % Falling
    hip_height = cos(theta1);

    % Slip detection
    [lambda_n, lambda_t] = stick_forces(theta1, theta2, theta1_dot, theta2_dot, ...
        params.m, params.m_h, params.I_c, params.l, params.g, params.alpha);
    slip_fwd = lambda_t - mu * lambda_n;
    slip_bwd = lambda_t + mu * lambda_n;

    value = [swing_collision; hip_height; slip_fwd; slip_bwd];
    isterminal = [1; 1; 1; 1];
    direction = [-1; -1; 1; -1];
end

function [Xnew, status, Lambda] = impact_law(Xold, params)
    theta1 = Xold(1);
    theta2 = Xold(2);
    theta1_dot = Xold(3);
    theta2_dot = Xold(4);
    
    theta_c = (theta1 + theta2) / 2;
    q_dot = [0; 0; theta1_dot; theta2_dot];

    % Collision matrix
    W_tilde = swing_foot_jacobian(theta1, theta2, params.l);
    M = mass_matrix(theta1, theta2, params.m, params.m_h, params.I_c, params.l);
    M_inv = inv(M);
    A_c = W_tilde * M_inv * W_tilde';
    M_inv_W_T = M_inv * W_tilde';

    v_minus = W_tilde * q_dot;

    % Fully-plastic impulse
    Lambda = -A_c \ v_minus;
    Lambda_t = Lambda(1);
    Lambda_n = Lambda(2);

    % Friction bound check
    if abs(Lambda_t) > params.mu * Lambda_n
        sigma = sign(Lambda_t);
        Lambda_n = -v_minus(2) / (A_c(2,2) + sigma * params.mu * A_c(1,2));
        Lambda_t = sigma * params.mu * Lambda_n;
        Lambda = [Lambda_t; Lambda_n];
    end

    q_dot_plus = q_dot + M_inv_W_T * Lambda;
    theta1_dot_plus = q_dot_plus(3);
    theta2_dot_plus = q_dot_plus(4);

    % Relabel: swap and negate angles/velocities
    theta1_new = -theta2;
    theta2_new = -theta1;
    theta1_dot_new = -theta2_dot_plus;
    theta2_dot_new = -theta1_dot_plus;

    % Rear foot lift-off check
    rear_vel = 2 * params.l * sin(theta_c) * (theta1_dot_new - theta2_dot_new);
    
    if rear_vel <= 0
        status = 1;
        Xnew = [];
        Lambda = [];
        return;
    end

    status = 0;
    Xnew = [theta1_new; theta2_new; theta1_dot_new; theta2_dot_new];
end
