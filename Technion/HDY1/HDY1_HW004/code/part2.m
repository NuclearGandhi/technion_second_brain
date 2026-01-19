function part2()
    %% Part B - Rocking Horse Toy: Numerical Simulations
    % HW4 - Hybrid Dynamics in Mechanical Systems

    close all;

    %% Parameters
    global m1 m2 J1 J2 R h l g mu sgn_slip

    m1 = 5;    % Horse body mass [kg]
    m2 = 15;   % Pendulum mass [kg]
    g = 10;    % Gravity [m/s^2]
    R = 0.6;   % Arc radius [m]
    h = 0.4;   % Distance from B to horse COM [m]
    l = 0.2;   % Distance from B to pendulum COM [m]
    J1 = 0.1 * m1 * R^2;   % Horse moment of inertia [kg*m^2]
    J2 = 0.5 * m2 * l^2;   % Pendulum moment of inertia [kg*m^2]
    mu = 0.05; % Friction coefficient

    T_sim = 10; % Simulation time [s]

    print_parameters();
    setup_plot_defaults();
    colors = get_default_colors();

    %% Question 5: Find omega_slip
    fprintf('=== Question 5: Finding omega_slip ===\n\n');
    omega_slip = bisection_search(@(w) check_slip(w, T_sim), 0, 10, 1e-4, 'omega_slip');
    fprintf('\nGenerating plots for Question 5...\n\n');
    generate_q5_plots(omega_slip, T_sim, colors);
    fprintf('=== Question 5 Complete ===\n');

    %% Question 6: Find omega_sep
    fprintf('\n=== Question 6: Finding omega_sep ===\n\n');
    omega_sep = bisection_search(@(w) check_separation(w, T_sim), omega_slip, 50, 1e-3, 'omega_sep');
    fprintf('\nGenerating plots for Question 6...\n\n');
    generate_q6_plots(omega_sep, T_sim, colors);
    fprintf('=== Question 6 Complete ===\n');

    %% Question 7: Weighted Average Simulation
    fprintf('\n=== Question 7: Simulation at weighted average ===\n\n');
    omega_q7 = 0.75 * omega_slip + 0.25 * omega_sep;
    generate_q7_plots(omega_q7, T_sim, colors);
    fprintf('=== Question 7 Complete ===\n');

    %% Question 8: Separation Simulation
    fprintf('\n=== Question 8: Simulation with separation ===\n\n');
    omega_q8 = 1.2 * omega_sep;
    generate_q8_plots(omega_q8, T_sim, colors);
    fprintf('=== Question 8 Complete ===\n');

    %% Question 9: Painlevé Paradox
    solve_q9();

    %% ========================================================================
    %                           NESTED FUNCTIONS
    %% ========================================================================

    function print_parameters()
        fprintf('=== Part B: Rocking Horse Toy - Numerical Simulations ===\n\n');
        fprintf('Parameters:\n');
        fprintf('  m1 = %.2f kg, m2 = %.2f kg\n', m1, m2);
        fprintf('  J1 = %.4f kg*m^2, J2 = %.4f kg*m^2\n', J1, J2);
        fprintf('  R = %.2f m, h = %.2f m, l = %.2f m\n', R, h, l);
        fprintf('  g = %.2f m/s^2, mu = %.3f\n\n', g, mu);
    end

    function setup_plot_defaults()
        set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
        set(groot, 'defaultTextInterpreter', 'latex');
        set(groot, 'defaultLegendInterpreter', 'latex');
        set(groot, 'DefaultLineLineWidth', 2);
        set(groot, 'defaultAxesFontSize', 14);
    end

    function colors = get_default_colors()
        fig_temp = figure('Visible', 'off');
        colors = get(gca, 'ColorOrder');
        close(fig_temp);
    end

    %% Bisection Search
    function result = bisection_search(condition_fn, low, high, tol, name)
        fprintf('Bisection search for %s:\n', name);
        for iter = 1:50
            mid = (low + high) / 2;
            if condition_fn(mid), high = mid; else, low = mid; end
            fprintf('  Iter %2d: omega in [%.6f, %.6f], diff = %.2e\n', iter, low, high, high - low);
            if (high - low) < tol, break; end
        end
        result = high;
        fprintf('\nFound %s = %.6f rad/s\n', name, result);
    end

    function slipped = check_slip(omega_0, T_max)
        X0 = [0; 0; 0; omega_0];
        opts = odeset('RelTol', 1e-8, 'AbsTol', 1e-10, 'Events', @events_stick);
        [~, ~, ~, ~, Ie] = ode45(@sys_stick, [0, T_max], X0, opts);
        slipped = ~isempty(Ie);
    end

    function separated = check_separation(omega_0, T_max)
        [separated, ~, ~, ~, ~, ~, ~] = simulate_hybrid(omega_0, T_max);
    end

    %% ODE Systems
    function dXdt = sys_stick(~, X)
        [theta_ddot, phi_ddot] = stick_accelerations(X(1), X(2), X(3), X(4), m1, m2, J1, J2, R, h, l, g);
        dXdt = [X(3); X(4); theta_ddot; phi_ddot];
    end

    function dXdt = sys_slip(~, X)
        [x_dd, th_dd, ph_dd, ~] = slip_accelerations(X(2), X(3), X(4), X(5), X(6), m1, m2, J1, J2, R, h, l, g, mu, sgn_slip);
        dXdt = [X(4); X(5); X(6); x_dd; th_dd; ph_dd];
    end

    function dXdt = sys_sep(~, X)
        [x_dd, y_dd, th_dd, ph_dd] = sep_accelerations(X(3), X(4), X(7), X(8), m1, m2, J1, J2, R, h, l, g);
        dXdt = [X(5); X(6); X(7); X(8); x_dd; y_dd; th_dd; ph_dd];
    end

    %% Event Functions
    function [value, isterminal, direction] = events_stick(~, X)
        [lambda_n, lambda_t] = stick_forces(X(1), X(2), X(3), X(4), m1, m2, J1, J2, R, h, l, g);
        value = [lambda_t - mu * lambda_n; lambda_t + mu * lambda_n];
        isterminal = [1; 1];
        direction = [0; 0];
    end

    function [value, isterminal, direction] = events_slip(~, X)
        v_t = X(4) + R * X(5);
        [~, ~, ~, lambda_n] = slip_accelerations(X(2), X(3), X(4), X(5), X(6), m1, m2, J1, J2, R, h, l, g, mu, sgn_slip);
        value = [v_t; lambda_n];
        isterminal = [1; 1];
        direction = [0; -1];
    end

    function [value, isterminal, direction] = events_sep(~, X)
        value = X(2) - R;
        isterminal = 1;
        direction = -1;
    end

    %% Hybrid Simulation
    function [separated, T_seg, X_seg, mode_seg, ln_seg, lt_seg, vt_seg] = simulate_hybrid(omega_0, T_max)
        T_seg = {}; X_seg = {}; mode_seg = {};
        ln_seg = {}; lt_seg = {}; vt_seg = {};

        t = 0; x = 0;
        X_stick = [0; 0; 0; omega_0];
        mode = 'stick';
        separated = false;
        X_sep = [];

        for iter = 1:100
            if t >= T_max, break; end

            switch mode
                case 'stick'
                    [ln, lt] = stick_forces(X_stick(1), X_stick(2), X_stick(3), X_stick(4), m1, m2, J1, J2, R, h, l, g);
                    if lt > mu * ln
                        sgn_slip = -1; mode = 'slip'; continue;
                    elseif lt < -mu * ln
                        sgn_slip = 1; mode = 'slip'; continue;
                    end

                    opts = odeset('RelTol', 1e-8, 'AbsTol', 1e-10, 'Events', @events_stick);
                    [T, X, ~, ~, Ie] = ode45(@sys_stick, [t, T_max], X_stick, opts);

                    [ln_out, lt_out] = compute_stick_forces(X);
                    x_traj = x - R * (X(:, 1) - X(1, 1));
                    X_full = [x_traj, X(:, 1), X(:, 2), -R * X(:, 3), X(:, 3), X(:, 4)];
                    T_seg{end+1} = T; X_seg{end+1} = X_full; mode_seg{end+1} = 'stick';
                    ln_seg{end+1} = ln_out; lt_seg{end+1} = lt_out; vt_seg{end+1} = zeros(size(T));

                    if isempty(Ie), break; end

                    t = T(end); x = x_traj(end);
                    sgn_slip = ternary(Ie(end) == 1, -1, 1);
                    X_stick = X(end, :)';
                    mode = 'slip';

                case 'slip'
                    X_slip = [x; X_stick(1); X_stick(2); -R * X_stick(3); X_stick(3); X_stick(4)];

                    % Anti-chatter step
                    dt = 1e-6;
                    if t + dt >= T_max, break; end
                    [~, X_init] = ode45(@sys_slip, [t, t + dt], X_slip, odeset('RelTol', 1e-10, 'AbsTol', 1e-12));
                    X_slip = X_init(end, :)'; t = t + dt;

                    opts = odeset('RelTol', 1e-8, 'AbsTol', 1e-10, 'Events', @events_slip);
                    [T, X, ~, ~, Ie] = ode45(@sys_slip, [t, T_max], X_slip, opts);

                    [ln_out, lt_out, vt_out] = compute_slip_forces(X);
                    T_seg{end+1} = T; X_seg{end+1} = X; mode_seg{end+1} = 'slip';
                    ln_seg{end+1} = ln_out; lt_seg{end+1} = lt_out; vt_seg{end+1} = vt_out;

                    if isempty(Ie), break; end

                    if Ie(end) == 2 % Separation
                        separated = true;
                        mode = 'separated';
                        t = T(end);
                        X_end = X(end, :);
                        X_sep = [X_end(1); R; X_end(2); X_end(3); X_end(4); 0; X_end(5); X_end(6)];
                        continue;
                    end

                    % Check stick feasibility
                    t = T(end); x = X(end, 1);
                    [ln_test, lt_test] = stick_forces(X(end, 2), X(end, 3), X(end, 5), X(end, 6), m1, m2, J1, J2, R, h, l, g);
                    ratio = lt_test / ln_test;

                    X_stick = [X(end, 2); X(end, 3); X(end, 5); X(end, 6)];
                    if abs(ratio) < mu
                        mode = 'stick';
                    else
                        sgn_slip = ternary(ratio > mu, -1, 1);
                    end

                case 'separated'
                    opts = odeset('RelTol', 1e-8, 'AbsTol', 1e-10, 'Events', @events_sep);
                    [T, X, ~, ~, Ie] = ode45(@sys_sep, [t, T_max], X_sep, opts);

                    T_seg{end+1} = T; X_seg{end+1} = X; mode_seg{end+1} = 'separated';
                    ln_seg{end+1} = zeros(size(T)); lt_seg{end+1} = zeros(size(T)); vt_seg{end+1} = zeros(size(T));

                    if ~isempty(Ie)
                        separated = true;
                        break;
                    end

                    if T(end) >= T_max, break; end
                    t = T(end); X_sep = X(end, :)';
            end
        end
    end

    %% Force Computation
    function [ln, lt] = compute_stick_forces(X)
        N = size(X, 1);
        ln = zeros(N, 1); lt = zeros(N, 1);
        parfor i = 1:N
            [ln(i), lt(i)] = stick_forces(X(i, 1), X(i, 2), X(i, 3), X(i, 4), m1, m2, J1, J2, R, h, l, g);
        end
    end

    function [ln, lt, vt] = compute_slip_forces(X)
        N = size(X, 1);
        ln = zeros(N, 1); lt = zeros(N, 1); vt = zeros(N, 1);
        sgn_local = sgn_slip;  % Local copy for parfor
        parfor i = 1:N
            [~, ~, ~, ln(i)] = slip_accelerations(X(i, 2), X(i, 3), X(i, 4), X(i, 5), X(i, 6), m1, m2, J1, J2, R, h, l, g, mu, sgn_local);
            lt(i) = -sgn_local * mu * ln(i);
            vt(i) = X(i, 4) + R * X(i, 5);
        end
    end

    %% Plot Generation - Question 5
    function generate_q5_plots(omega_slip, T_sim_local, colors)
        output_dir = fileparts(mfilename('fullpath'));

        for case_num = 1:2
            omega = omega_slip * (0.9 + 0.1 * (case_num - 1));
            name = ternary(case_num == 1, 'case1_0p9_omega_slip', 'case2_omega_slip');
            fprintf('Case %d: omega_0 = %.6f rad/s\n', case_num, omega);

            X0 = [0; 0; 0; omega];
            opts = odeset('RelTol', 1e-8, 'AbsTol', 1e-10, 'Events', @events_stick);
            [T, X, ~, ~, Ie] = ode45(@sys_stick, [0, T_sim_local], X0, opts);
            [ln, lt] = compute_stick_forces(X);
            has_event = ~isempty(Ie);

            % Cross check
            x_traj = -R * (X(:, 1) - X(1, 1));
            X_full = [x_traj, X(:, 1), X(:, 2), -R * X(:, 3), X(:, 3), X(:, 4)];
            run_cross_checks({T}, {X_full}, {'stick'}, {ln}, {lt}, {zeros(size(T))}, omega, name);

            % (a) Angles
            fig = figure('Position', [100, 100, 800, 500]);
            plot(T, rad2deg(X(:, 1)), 'DisplayName', '$\theta$'); hold on;
            plot(T, rad2deg(X(:, 2)), 'DisplayName', '$\phi$');
            if has_event
                add_marker(T(end), rad2deg(X(end, 1)));
                add_marker(T(end), rad2deg(X(end, 2)));
            end
            hold off; xlabel('Time $t$ [s]'); ylabel('Angle [deg]');
            title(sprintf('(a) Angles vs Time ($\\omega_0 = %.4f$ rad/s)', omega));
            legend('Location', 'best'); grid on;
            save_figure(fig, output_dir, sprintf('q5_%s_a_angles.png', name));

            % (c) Normal force
            fig = figure('Position', [100, 100, 800, 500]);
            plot(T, ln); hold on; yline(0, 'k--', 'LineWidth', 1);
            if has_event, add_marker(T(end), ln(end)); end
            hold off; xlabel('Time $t$ [s]'); ylabel('$\lambda_n$ [N]');
            title(sprintf('(c) Normal Contact Force vs Time ($\\omega_0 = %.4f$ rad/s)', omega));
            grid on;
            save_figure(fig, output_dir, sprintf('q5_%s_c_lambda_n.png', name));

            % (d) Force ratio
            fig = figure('Position', [100, 100, 800, 500]);
            ratio = lt ./ ln;
            plot(T, ratio, 'DisplayName', 'Force ratio'); hold on;
            plot_friction_bounds(colors);
            if has_event, add_marker(T(end), ratio(end)); end
            hold off; xlabel('Time $t$ [s]'); ylabel('$\lambda_t / \lambda_n$');
            title(sprintf('(d) Force Ratio vs Time ($\\omega_0 = %.4f$ rad/s)', omega));
            legend('Location', 'best'); grid on; ylim([-mu - 0.01, mu + 0.01]);
            save_figure(fig, output_dir, sprintf('q5_%s_d_force_ratio.png', name));

            fprintf('  Saved plots for %s\n', name);
        end
    end

    %% Plot Generation - Question 6
    function generate_q6_plots(omega_sep, T_sim_local, colors)
        output_dir = fileparts(mfilename('fullpath'));
        fprintf('omega_0 = omega_sep = %.6f rad/s\n', omega_sep);

        [~, T_seg, X_seg, mode_seg, ln_seg, lt_seg, vt_seg] = simulate_hybrid(omega_sep, T_sim_local);
        run_cross_checks(T_seg, X_seg, mode_seg, ln_seg, lt_seg, vt_seg, omega_sep, 'omega_sep');

        % Compute consistent xlim for all Q6 plots (end time + 5% margin)
        t_end = T_seg{end}(end);
        x_lim = [0, t_end * 1.05];

        % (a) Angles
        fig = figure('Position', [100, 100, 800, 500]); hold on;
        plot_segments(T_seg, X_seg, mode_seg, [2 3], colors(1:2, :), true, false, {'separated'});
        add_legend({'$\theta$', '$\phi$'}, colors(1:2, :));
        hold off; xlabel('Time $t$ [s]'); ylabel('Angle [deg]');
        title(sprintf('(a) Angles vs Time ($\\omega_0 = %.4f$ rad/s)', omega_sep));
        legend('Location', 'best'); grid on; xlim(x_lim);
        save_figure(fig, output_dir, 'q6_omega_sep_a_angles.png');

        % (b) Slip velocity
        fig = figure('Position', [100, 100, 800, 500]); hold on;
        plot_data_segments(T_seg, vt_seg, mode_seg, colors(1, :), {'separated'});
        add_legend_single(colors(1, :));
        yline(0, 'k--', 'LineWidth', 1, 'HandleVisibility', 'off');
        hold off; xlabel('Time $t$ [s]'); ylabel('$v_t$ [m/s]');
        title(sprintf('(b) Slip Velocity vs Time ($\\omega_0 = %.4f$ rad/s)', omega_sep));
        legend('Location', 'best'); grid on; xlim(x_lim);
        save_figure(fig, output_dir, 'q6_omega_sep_b_slip_velocity.png');

        % (c) Normal force
        fig = figure('Position', [100, 100, 800, 500]); hold on;
        plot_data_segments(T_seg, ln_seg, mode_seg, colors(1, :), {'separated'});
        add_legend_single(colors(1, :));
        yline(0, 'k--', 'LineWidth', 1, 'HandleVisibility', 'off');
        hold off; xlabel('Time $t$ [s]'); ylabel('$\lambda_n$ [N]');
        title(sprintf('(c) Normal Contact Force vs Time ($\\omega_0 = %.4f$ rad/s)', omega_sep));
        legend('Location', 'best'); grid on; xlim(x_lim);
        save_figure(fig, output_dir, 'q6_omega_sep_c_lambda_n.png');

        % (d) Force ratio
        fig = figure('Position', [100, 100, 800, 500]); hold on;
        plot_force_ratio(T_seg, ln_seg, lt_seg, mode_seg, colors(1, :), {'separated'});
        add_legend_single(colors(1, :));
        plot_friction_bounds(colors);
        hold off; xlabel('Time $t$ [s]'); ylabel('$\lambda_t / \lambda_n$');
        title(sprintf('(d) Force Ratio vs Time ($\\omega_0 = %.4f$ rad/s)', omega_sep));
        legend('Location', 'best'); grid on; xlim(x_lim);
        save_figure(fig, output_dir, 'q6_omega_sep_d_force_ratio.png');

        fprintf('  Saved plots for omega_sep\n');
    end

    %% Plot Generation - Question 7
    function generate_q7_plots(omega_0, T_sim_local, colors)
        output_dir = fileparts(mfilename('fullpath'));
        fprintf('omega_0 = %.6f rad/s\n', omega_0);

        [~, T_seg, X_seg, mode_seg, ln_seg, lt_seg, vt_seg] = simulate_hybrid(omega_0, T_sim_local);
        run_cross_checks(T_seg, X_seg, mode_seg, ln_seg, lt_seg, vt_seg, omega_0, 'q7');

        % (a) Angles
        fig = figure('Position', [100, 100, 800, 500]); hold on;
        plot_segments(T_seg, X_seg, mode_seg, [2 3], colors(1:2, :), true);
        add_legend({'$\theta$', '$\phi$'}, colors(1:2, :));
        hold off; xlabel('Time $t$ [s]'); ylabel('Angle [deg]');
        title(sprintf('(a) Angles vs Time ($\\omega_0 = %.4f$ rad/s)', omega_0));
        legend('Location', 'best'); grid on;
        save_figure(fig, output_dir, 'q7_angles.png');

        % (b) Slip velocity
        fig = figure('Position', [100, 100, 800, 500]); hold on;
        plot_data_segments(T_seg, vt_seg, mode_seg, colors(1, :));
        add_legend_single(colors(1, :));
        yline(0, 'k--', 'LineWidth', 1, 'HandleVisibility', 'off');
        hold off; xlabel('Time $t$ [s]'); ylabel('$v_t$ [m/s]');
        title(sprintf('(b) Slip Velocity vs Time ($\\omega_0 = %.4f$ rad/s)', omega_0));
        legend('Location', 'best'); grid on;
        save_figure(fig, output_dir, 'q7_slip_velocity.png');

        % (c) Normal force
        fig = figure('Position', [100, 100, 800, 500]); hold on;
        plot_data_segments(T_seg, ln_seg, mode_seg, colors(1, :));
        add_legend_single(colors(1, :));
        yline(0, 'k--', 'LineWidth', 1, 'HandleVisibility', 'off');
        hold off; xlabel('Time $t$ [s]'); ylabel('$\lambda_n$ [N]');
        title(sprintf('(c) Normal Contact Force vs Time ($\\omega_0 = %.4f$ rad/s)', omega_0));
        legend('Location', 'best'); grid on;
        save_figure(fig, output_dir, 'q7_lambda_n.png');

        % (d) Force ratio
        fig = figure('Position', [100, 100, 800, 500]); hold on;
        plot_force_ratio(T_seg, ln_seg, lt_seg, mode_seg, colors(1, :));
        add_legend_single(colors(1, :));
        plot_friction_bounds(colors);
        hold off; xlabel('Time $t$ [s]'); ylabel('$\lambda_t / \lambda_n$');
        title(sprintf('(d) Force Ratio vs Time ($\\omega_0 = %.4f$ rad/s)', omega_0));
        legend('Location', 'best'); grid on;
        save_figure(fig, output_dir, 'q7_force_ratio.png');

        % (e) Horizontal displacement
        fig = figure('Position', [100, 100, 800, 500]); hold on;
        plot_segments(T_seg, X_seg, mode_seg, 1, colors(1, :), false);
        add_legend_single(colors(1, :));
        hold off; xlabel('Time $t$ [s]'); ylabel('$x$ [m]');
        title(sprintf('(e) Horizontal Displacement vs Time ($\\omega_0 = %.4f$ rad/s)', omega_0));
        legend('Location', 'best'); grid on;
        save_figure(fig, output_dir, 'q7_x_displacement.png');

        fprintf('  Saved plots for Question 7\n');
    end

    %% Plot Generation - Question 8
    function generate_q8_plots(omega_0, T_sim_local, colors)
        output_dir = fileparts(mfilename('fullpath'));
        fprintf('omega_0 = %.6f rad/s\n', omega_0);

        [~, T_seg, X_seg, mode_seg, ln_seg, lt_seg, vt_seg] = simulate_hybrid(omega_0, T_sim_local);
        run_cross_checks(T_seg, X_seg, mode_seg, ln_seg, lt_seg, vt_seg, omega_0, 'q8');

        % Compute consistent xlim for all Q8 plots (end time + 5% margin)
        t_end = T_seg{end}(end);
        x_lim = [0, t_end * 1.05];

        % (a) Angles
        fig = figure('Position', [100, 100, 800, 500]); hold on;
        plot_segments(T_seg, X_seg, mode_seg, [2 3], colors(1:2, :), true);
        add_legend({'$\theta$', '$\phi$'}, colors(1:2, :));
        hold off; xlabel('Time $t$ [s]'); ylabel('Angle [deg]');
        title(sprintf('(a) Angles vs Time ($\\omega_0 = %.4f$ rad/s)', omega_0));
        legend('Location', 'best'); grid on; xlim(x_lim);
        save_figure(fig, output_dir, 'q8_angles.png');

        % (b) Slip velocity
        fig = figure('Position', [100, 100, 800, 500]); hold on;
        plot_data_segments(T_seg, vt_seg, mode_seg, colors(1, :), {'separated'});
        add_legend_single(colors(1, :));
        yline(0, 'k--', 'LineWidth', 1, 'HandleVisibility', 'off');
        hold off; xlabel('Time $t$ [s]'); ylabel('$v_t$ [m/s]');
        title(sprintf('(b) Slip Velocity vs Time ($\\omega_0 = %.4f$ rad/s)', omega_0));
        legend('Location', 'best'); grid on; xlim(x_lim);
        save_figure(fig, output_dir, 'q8_slip_velocity.png');

        % (c) Normal force
        fig = figure('Position', [100, 100, 800, 500]); hold on;
        plot_data_segments(T_seg, ln_seg, mode_seg, colors(1, :));
        add_legend_single(colors(1, :));
        yline(0, 'k--', 'LineWidth', 1, 'HandleVisibility', 'off');
        hold off; xlabel('Time $t$ [s]'); ylabel('$\lambda_n$ [N]');
        title(sprintf('(c) Normal Contact Force vs Time ($\\omega_0 = %.4f$ rad/s)', omega_0));
        legend('Location', 'best'); grid on; xlim(x_lim);
        save_figure(fig, output_dir, 'q8_lambda_n.png');

        % (d) Force ratio
        fig = figure('Position', [100, 100, 800, 500]); hold on;
        plot_force_ratio(T_seg, ln_seg, lt_seg, mode_seg, colors(1, :), {'separated'});
        add_legend_single(colors(1, :));
        plot_friction_bounds(colors);
        hold off; xlabel('Time $t$ [s]'); ylabel('$\lambda_t / \lambda_n$');
        title(sprintf('(d) Force Ratio vs Time ($\\omega_0 = %.4f$ rad/s)', omega_0));
        legend('Location', 'best'); grid on; xlim(x_lim);
        save_figure(fig, output_dir, 'q8_force_ratio.png');

        % (e) Horizontal displacement
        fig = figure('Position', [100, 100, 800, 500]); hold on;
        plot_segments(T_seg, X_seg, mode_seg, 1, colors(1, :), false);
        add_legend_single(colors(1, :));
        hold off; xlabel('Time $t$ [s]'); ylabel('$x$ [m]');
        title(sprintf('(e) Horizontal Displacement vs Time ($\\omega_0 = %.4f$ rad/s)', omega_0));
        legend('Location', 'best'); grid on; xlim(x_lim);
        save_figure(fig, output_dir, 'q8_x_displacement.png');

        % (f) Separation height
        fig = figure('Position', [100, 100, 800, 500]); hold on;
        plot_segments(T_seg, X_seg, mode_seg, 2, colors(1, :), false, true);
        yline(0, 'k--', 'LineWidth', 1, 'HandleVisibility', 'off');
        hold off; xlabel('Time $t$ [s]'); ylabel('Separation Height $y-R$ [m]');
        title(sprintf('Separation Height vs Time ($\\omega_0 = %.4f$ rad/s)', omega_0));
        grid on; xlim(x_lim);
        save_figure(fig, output_dir, 'q8_separation.png');

        fprintf('  Saved plots for Question 8\n');
    end

    %% Cross Checks
    function run_cross_checks(T_seg, X_seg, mode_seg, ln_seg, lt_seg, vt_seg, ~, case_name)
        fprintf('  Running cross-checks for %s...\n', case_name);

        T_all = []; E_all = []; Px_all = []; Py_all = [];
        W_nc_all = []; F_ext_x_all = []; F_ext_y_all = [];

        for s = 1:length(T_seg)
            T = T_seg{s}; X = X_seg{s};
            is_sep = strcmp(mode_seg{s}, 'separated');

            if s > 1 && length(T) > 1
                T = T(2:end); X = X(2:end, :);
                ln_seg{s} = ln_seg{s}(2:end);
                lt_seg{s} = lt_seg{s}(2:end);
                vt_seg{s} = vt_seg{s}(2:end);
            elseif s > 1
                continue;
            end

            % Extract state based on mode
            if is_sep
                x = X(:, 1); y = X(:, 2); theta = X(:, 3); phi = X(:, 4);
                x_dot = X(:, 5); y_dot = X(:, 6); theta_dot = X(:, 7); phi_dot = X(:, 8);
            else
                x = X(:, 1); y = R * ones(size(X, 1), 1); theta = X(:, 2); phi = X(:, 3);
                x_dot = X(:, 4); y_dot = zeros(size(X, 1), 1); theta_dot = X(:, 5); phi_dot = X(:, 6);
            end
            ln = ln_seg{s}; lt = lt_seg{s}; vt = vt_seg{s};

            % Potential energy
            V = m1 * g * (y - h * cos(theta)) + m2 * g * (y - l * cos(theta - phi));

            % Kinetic energy
            Kin = zeros(size(T));
            for i = 1:length(T)
                q_d = [x_dot(i); y_dot(i); theta_dot(i); phi_dot(i)];
                M = build_mass_matrix(theta(i), phi(i), m1, m2, J1, J2, h, l);
                Kin(i) = 0.5 * q_d' * M * q_d;
            end

            E_all = [E_all; Kin + V];

            % Momentum
            Px = (m1 + m2) * x_dot + (h * m1 * cos(theta) + l * m2 * cos(theta - phi)) .* theta_dot - l * m2 .* cos(theta - phi) .* phi_dot;
            Py = (m1 + m2) * y_dot + (h * m1 * sin(theta) + l * m2 * sin(theta - phi)) .* theta_dot - l * m2 .* sin(theta - phi) .* phi_dot;

            Px_all = [Px_all; Px];
            Py_all = [Py_all; Py];
            T_all = [T_all; T];

            % External forces
            if is_sep
                W_nc_all = [W_nc_all; zeros(size(T))];
                F_ext_x_all = [F_ext_x_all; zeros(size(T))];
                F_ext_y_all = [F_ext_y_all; -(m1 + m2) * g * ones(size(T))];
            else
                W_nc_all = [W_nc_all; lt .* vt];
                F_ext_x_all = [F_ext_x_all; lt];
                F_ext_y_all = [F_ext_y_all; ln - (m1 + m2) * g];
            end
        end

        % Compute residuals
        dt = max(diff(T_all), 1e-9);
        dE = diff(E_all) ./ dt;
        dPx = diff(Px_all) ./ dt;
        dPy = diff(Py_all) ./ dt;

        T_mid = T_all(1:end-1) + dt / 2;
        W_nc = interp1(T_all, W_nc_all, T_mid);
        Fx = interp1(T_all, F_ext_x_all, T_mid);
        Fy = interp1(T_all, F_ext_y_all, T_mid);

        % Plot
        figure('Name', ['Cross Checks: ' case_name], 'NumberTitle', 'off', 'Position', [100, 100, 1000, 600]);
        subplot(2, 2, 1); plot(T_all, E_all); title('Total Energy [J]'); grid on; xlabel('t');
        subplot(2, 2, 2); plot(T_mid, dE - W_nc); title('dE/dt - Power Residual [W]'); grid on; xlabel('t');
        subplot(2, 2, 3); plot(T_mid, dPx - Fx); title('dPx/dt - Fx Residual [N]'); grid on; xlabel('t');
        subplot(2, 2, 4); plot(T_mid, dPy - Fy); title('dPy/dt - Fy Residual [N]'); grid on; xlabel('t');
    end

    %% Plotting Helpers
    function plot_segments(T_seg, X_seg, mode_seg, cols, colors, to_deg, shift_y_by_R, ignored_modes)
        if nargin < 7, shift_y_by_R = false; end
        if nargin < 8, ignored_modes = {}; end

        for s = 1:length(T_seg)
            if any(strcmp(mode_seg{s}, ignored_modes)), continue; end

            is_sep = strcmp(mode_seg{s}, 'separated');
            style = get_line_style(mode_seg{s});
            X = X_seg{s}; T = T_seg{s};

            for k = 1:length(cols)
                idx = cols(k);
                val = extract_value(X, idx, is_sep, shift_y_by_R);

                if ~isempty(val)
                    if shift_y_by_R
                        val = val - R;
                    elseif to_deg
                        val = rad2deg(val);
                    end

                    plot(T, val, style, 'Color', colors(min(k, size(colors, 1)), :), 'HandleVisibility', 'off');
                    if s < length(T_seg) || is_sep
                        add_marker(T(end), val(end));
                    end
                end
            end
        end
    end

    function plot_data_segments(T_seg, data_seg, mode_seg, color, ignored_modes)
        if nargin < 5, ignored_modes = {}; end

        for s = 1:length(T_seg)
            if any(strcmp(mode_seg{s}, ignored_modes)), continue; end

            is_sep = strcmp(mode_seg{s}, 'separated');
            style = get_line_style(mode_seg{s});
            T = T_seg{s}; val = data_seg{s};

            plot(T, val, style, 'Color', color, 'HandleVisibility', 'off');
            if s < length(T_seg) || is_sep
                add_marker(T(end), val(end));
            end
        end
    end

    function plot_force_ratio(T_seg, ln_seg, lt_seg, mode_seg, color, ignored_modes)
        if nargin < 6, ignored_modes = {}; end

        for s = 1:length(T_seg)
            if any(strcmp(mode_seg{s}, ignored_modes)), continue; end

            is_sep = strcmp(mode_seg{s}, 'separated');
            style = get_line_style(mode_seg{s});
            T = T_seg{s};
            ratio = lt_seg{s} ./ ln_seg{s};

            plot(T, ratio, style, 'Color', color, 'HandleVisibility', 'off');
            if s < length(T_seg) || is_sep
                add_marker(T(end), ratio(end));
            end
        end
    end

    function val = extract_value(X, idx, is_sep, shift_y_by_R)
        if is_sep
            switch idx
                case 1, val = X(:, 1);           % x
                case 2, val = ternary(shift_y_by_R, X(:, 2), X(:, 3)); % y or theta
                case 3, val = X(:, 4);           % phi
                otherwise, val = [];
            end
        else
            if shift_y_by_R
                val = R * ones(size(X, 1), 1);
            else
                val = X(:, idx);
            end
        end
    end

    function style = get_line_style(mode)
        switch mode
            case 'stick', style = '-';
            case 'slip', style = '--';
            case 'separated', style = ':';
            otherwise, style = '-';
        end
    end

    function add_marker(t, val)
        plot(t, val, 'xk', 'MarkerSize', 10, 'LineWidth', 2, 'HandleVisibility', 'off');
    end

    function plot_friction_bounds(colors)
        yline(mu, '--', 'Color', colors(2, :), 'LineWidth', 1, 'DisplayName', '$+\mu$');
        yline(-mu, '--', 'Color', colors(2, :), 'LineWidth', 1, 'DisplayName', '$-\mu$');
    end

    function add_legend(labels, colors)
        for k = 1:length(labels)
            plot(NaN, NaN, '-', 'Color', colors(k, :), 'DisplayName', [labels{k} ' (stick)']);
            plot(NaN, NaN, '--', 'Color', colors(k, :), 'DisplayName', [labels{k} ' (slip)']);
        end
    end

    function add_legend_single(color)
        plot(NaN, NaN, '-', 'Color', color, 'DisplayName', 'stick');
        plot(NaN, NaN, '--', 'Color', color, 'DisplayName', 'slip');
        plot(NaN, NaN, ':', 'Color', color, 'DisplayName', 'sep');
    end

    function save_figure(fig, output_dir, filename)
        print(fig, fullfile(output_dir, filename), '-dpng', '-r300');
    end

end

%% External Functions (outside main function scope for solve_q9)
function solve_q9()
    global m1 m2 J1 J2 R h l mu

    fprintf('\n=== Question 9: Painlevé Paradox Analysis ===\n\n');

    %% Analytical Derivation
    fprintf('--- Analytical Derivation ---\n\n');
    fprintf('The Painlevé paradox occurs when alpha < 0, where:\n');
    fprintf('  alpha = w_n * M^(-1) * (w_n - sigma*mu*w_t)^T\n\n');
    fprintf('For the rocking horse:\n');
    fprintf('  w_n = [0, 1, 0, 0]  (normal constraint)\n');
    fprintf('  w_t = [1, 0, R, 0]  (tangential constraint)\n\n');

    fprintf('Expanding alpha:\n');
    fprintf('  alpha = w_n*M^(-1)*w_n^T - sigma*mu*w_n*M^(-1)*w_t^T\n');
    fprintf('        = a - sigma*mu*c\n');
    fprintf('where:\n');
    fprintf('  a = (M^(-1))_22 > 0  (positive definite)\n');
    fprintf('  c = (M^(-1))_21 + R*(M^(-1))_23\n\n');

    fprintf('For NO paradox, we need alpha > 0 for both sigma = +/-1:\n');
    fprintf('  sigma = +1: a - mu*c > 0\n');
    fprintf('  sigma = -1: a + mu*c > 0\n\n');
    fprintf('This requires: mu < a/|c| = mu_crit(theta, phi)\n\n');
    fprintf('The maximum safe friction coefficient is:\n');
    fprintf('  mu_max = min_{theta,phi} mu_crit(theta, phi)\n\n');

    %% Numerical Computation - Multi-start optimization
    fprintf('--- Numerical Computation (Multi-Start fmincon) ---\n\n');

    % Objective function (cap inf at large value for optimizer)
    obj_fun = @(x) min(compute_mu_crit(x(1), x(2), m1, m2, J1, J2, R, h, l), 1e10);

    % Bounds
    lb = [-pi/6, -pi];
    ub = [pi/6, pi];

    % Multi-start from corners, edges, and center of the domain
    start_points = [
        0, 0;                   % Center
        -pi/6, 0;               % Left edge
        pi/6, 0;                % Right edge
        0, -pi;                 % Bottom edge
        0, pi;                  % Top edge
        -pi/6, -pi;             % Corners
        -pi/6, pi;
        pi/6, -pi;
        pi/6, pi;
    ];

    opts = optimoptions('fmincon', 'Display', 'off', 'OptimalityTolerance', 1e-12, ...
        'StepTolerance', 1e-12, 'MaxFunctionEvaluations', 5000);

    best_mu = inf;
    best_loc = [0, 0];

    for k = 1:size(start_points, 1)
        [x_opt, mu_opt] = fmincon(obj_fun, start_points(k, :), [], [], [], [], lb, ub, [], opts);

        % Keep phi in [-pi, pi]
        x_opt(2) = mod(x_opt(2) + pi, 2*pi) - pi;

        if mu_opt < best_mu
            best_mu = mu_opt;
            best_loc = x_opt;
        end
    end

    mu_crit_min = best_mu;
    min_loc = best_loc;

    fprintf('Result: mu_max = %.10f\n', mu_crit_min);
    fprintf('Critical configuration: theta = %.6f deg, phi = %.6f deg\n', ...
        rad2deg(min_loc(1)), rad2deg(min_loc(2)));

    % Evaluate at critical point
    M_crit = build_mass_matrix(min_loc(1), min_loc(2), m1, m2, J1, J2, h, l);
    Minv_crit = inv(M_crit);
    a_crit = Minv_crit(2, 2);
    c_crit = Minv_crit(2, 1) + R * Minv_crit(2, 3);
    fprintf('At critical point: a = %.10f, c = %.10f\n', a_crit, c_crit);
    fprintf('Verification: a/|c| = %.10f\n', a_crit / abs(c_crit));
    fprintf('Sign of c: %s (slip direction sigma = %d triggers paradox first)\n', ...
        ternary(c_crit > 0, 'positive', 'negative'), ternary(c_crit > 0, 1, -1));

    fprintf('\nCurrent mu = %.4f\n', mu);
    fprintf('Paradox possible? %s\n', ternary(mu > mu_crit_min, 'YES', 'NO'));
    fprintf('Safety margin: mu_max/mu = %.4f\n\n', mu_crit_min / mu);

    %% Generate Contour Plot
    output_dir = fileparts(mfilename('fullpath'));

    % Compute grid for visualization
    N_theta = 100;
    N_phi = 200;
    theta_vec = linspace(-pi/6, pi/6, N_theta);
    phi_vec = linspace(-pi, pi, N_phi);
    [THETA, PHI] = meshgrid(theta_vec, phi_vec);
    MU_CRIT = zeros(size(THETA));

    parfor i = 1:N_phi
        for j = 1:N_theta
            MU_CRIT(i, j) = compute_mu_crit(theta_vec(j), phi_vec(i), m1, m2, J1, J2, R, h, l);
        end
    end

    fig = figure('Position', [100, 100, 900, 600]);

    % Contour plot of mu_crit
    MU_CRIT_plot = min(MU_CRIT, 2);  % Cap at 2 for visualization
    contourf(rad2deg(THETA), rad2deg(PHI), MU_CRIT_plot, 20);
    colorbar;
    hold on;

    % Mark critical point (optimized)
    plot(rad2deg(min_loc(1)), rad2deg(min_loc(2)), 'rx', 'MarkerSize', 15, 'LineWidth', 3);

    % Mark current mu level
    contour(rad2deg(THETA), rad2deg(PHI), MU_CRIT, [mu mu], 'r--', 'LineWidth', 2);

    hold off;
    xlabel('$\theta$ [deg]', 'Interpreter', 'latex');
    ylabel('$\phi$ [deg]', 'Interpreter', 'latex');
    title(sprintf('Critical Friction Coefficient $\\mu_{crit}(\\theta, \\phi)$ - Min = %.6f', mu_crit_min), ...
        'Interpreter', 'latex');
    cb = colorbar;
    ylabel(cb, '$\mu_{crit}$', 'Interpreter', 'latex');

    % Add text annotation
    text(rad2deg(min_loc(1)) + 3, rad2deg(min_loc(2)) + 20, ...
        sprintf('$\\mu_{max} = %.6f$', mu_crit_min), ...
        'Interpreter', 'latex', 'FontSize', 12, 'Color', 'r');

    print(fig, fullfile(output_dir, 'q9_mu_crit_contour.png'), '-dpng', '-r300');
    fprintf('Saved contour plot: q9_mu_crit_contour.png\n');

    %% Plot alpha vs mu at critical configuration
    fig2 = figure('Position', [100, 100, 800, 500]);

    mu_range = linspace(0, 1.5 * mu_crit_min, 100);
    alpha_plus = a_crit - mu_range * c_crit;   % sigma = +1
    alpha_minus = a_crit + mu_range * c_crit;  % sigma = -1

    plot(mu_range, alpha_plus, '-', 'LineWidth', 2, 'DisplayName', '$\alpha(\sigma=+1)$');
    hold on;
    plot(mu_range, alpha_minus, '-', 'LineWidth', 2, 'DisplayName', '$\alpha(\sigma=-1)$');
    yline(0, 'k--', 'LineWidth', 1, 'HandleVisibility', 'off');
    xline(mu_crit_min, '--', 'LineWidth', 2, 'DisplayName', sprintf('$\\mu_{crit} = %.6f$', mu_crit_min));
    xline(mu, ':', 'LineWidth', 2, 'DisplayName', sprintf('$\\mu = %.3f$', mu));
    hold off;

    xlabel('Friction coefficient $\mu$', 'Interpreter', 'latex');
    ylabel('$\alpha$', 'Interpreter', 'latex');
    title(sprintf('$\\alpha$ vs $\\mu$ at critical configuration ($\\theta = %.4f^\\circ$, $\\phi = %.4f^\\circ$)', ...
        rad2deg(min_loc(1)), rad2deg(min_loc(2))), 'Interpreter', 'latex');
    legend('Location', 'best', 'Interpreter', 'latex');
    grid on;
    xlim([0, 1.5 * mu_crit_min]);

    print(fig2, fullfile(output_dir, 'q9_alpha_vs_mu.png'), '-dpng', '-r300');
    fprintf('Saved alpha plot: q9_alpha_vs_mu.png\n');

    fprintf('\n=== Question 9 Complete ===\n');
end

function mu_c = compute_mu_crit(theta, phi, m1, m2, J1, J2, R, h, l)
    % Compute mu_crit = a/|c| at given configuration
    M = build_mass_matrix(theta, phi, m1, m2, J1, J2, h, l);
    Minv = inv(M);
    a = Minv(2, 2);
    c = Minv(2, 1) + R * Minv(2, 3);

    if abs(c) > 1e-14
        mu_c = a / abs(c);
    else
        mu_c = inf;
    end
end

function M = build_mass_matrix(theta_val, phi_val, m1, m2, J1, J2, h, l)
    % Build mass matrix consistent with simulation (verified via symbolic derivation)
    c_th = cos(theta_val); s_th = sin(theta_val);
    c_tp = cos(theta_val - phi_val); s_tp = sin(theta_val - phi_val);

    M = zeros(4, 4);
    M(1, 1) = m1 + m2;
    M(1, 3) = h * m1 * c_th + l * m2 * c_tp;
    M(1, 4) = -l * m2 * c_tp;
    M(2, 2) = m1 + m2;
    M(2, 3) = h * m1 * s_th + l * m2 * s_tp;
    M(2, 4) = -l * m2 * s_tp;  % Corrected sign (matches symbolic derivation)
    M(3, 1) = M(1, 3); M(3, 2) = M(2, 3);
    M(3, 3) = J1 + J2 + h^2 * m1 + l^2 * m2;
    M(3, 4) = -J2 - l^2 * m2;
    M(4, 1) = M(1, 4); M(4, 2) = M(2, 4);
    M(4, 3) = M(3, 4);
    M(4, 4) = J2 + l^2 * m2;
end

function out = ternary(cond, a, b)
    if cond, out = a; else, out = b; end
end
