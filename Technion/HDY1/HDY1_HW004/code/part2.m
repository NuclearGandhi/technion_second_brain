function part2()
    %% Part B - Rocking Horse Toy: Numerical Simulations
    % HW4 - Hybrid Dynamics in Mechanical Systems

    close all;

    %% Parameters
    global m1 m2 J1 J2 R h l g mu sgn_slip

    m1 = 5; % Horse body mass [kg]
    m2 = 15; % Pendulum mass [kg]
    g = 10; % Gravity [m/s^2]
    R = 0.6; % Arc radius [m]
    h = 0.4; % Distance from B to horse COM [m]
    l = 0.2; % Distance from B to pendulum COM [m]
    J1 = 0.1 * m1 * R ^ 2; % Horse moment of inertia [kg*m^2]
    J2 = 0.5 * m2 * l ^ 2; % Pendulum moment of inertia [kg*m^2]
    mu = 0.05; % Friction coefficient

    T_sim = 10; % Simulation time [s]

    print_parameters();

    %% Question 5: Find omega_slip
    fprintf('=== Question 5: Finding omega_slip ===\n\n');
    omega_slip = bisection_search(@(w) check_slip(w, T_sim), 0, 10, 1e-4, 'omega_slip');

    fprintf('\nGenerating plots for Question 5...\n\n');
    generate_q5_plots(omega_slip, T_sim);
    fprintf('=== Question 5 Complete ===\n');

    %% Question 6: Find omega_sep
    fprintf('\n=== Question 6: Finding omega_sep ===\n\n');
    omega_sep = bisection_search(@(w) check_separation(w, T_sim), omega_slip, 50, 1e-3, 'omega_sep');

    fprintf('\nGenerating plots for Question 6...\n\n');
    generate_q6_plots(omega_sep, T_sim);
    fprintf('=== Question 6 Complete ===\n');

    %% Question 7: Weighted Average Simulation
    fprintf('\n=== Question 7: Simulation at weighted average ===\n\n');
    omega_q7 = 0.75 * omega_slip + 0.25 * omega_sep;
    generate_q7_plots(omega_q7, T_sim);
    fprintf('=== Question 7 Complete ===\n');

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

    %% Bisection search (generic)
    function result = bisection_search(condition_fn, low, high, tol, name)
        fprintf('Bisection search for %s:\n', name);

        for iter = 1:50
            mid = (low + high) / 2;

            if condition_fn(mid)
                high = mid;
            else
                low = mid;
            end

            fprintf('  Iter %2d: omega in [%.6f, %.6f], diff = %.2e\n', iter, low, high, high - low);
            if (high - low) < tol, break; end
        end

        result = high;
        fprintf('\nFound %s = %.6f rad/s\n', name, result);
    end

    %% Condition functions for bisection
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
        [x_ddot, theta_ddot, phi_ddot, ~] = slip_accelerations(X(2), X(3), X(4), X(5), X(6), m1, m2, J1, J2, R, h, l, g, mu, sgn_slip);
        dXdt = [X(4); X(5); X(6); x_ddot; theta_ddot; phi_ddot];
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

    %% Hybrid Simulation
    function [separated, T_seg, X_seg, mode_seg, ln_seg, lt_seg, vt_seg] = simulate_hybrid(omega_0, T_max)
        T_seg = {}; X_seg = {}; mode_seg = {};
        ln_seg = {}; lt_seg = {}; vt_seg = {};

        t = 0; x = 0;
        X_stick = [0; 0; 0; omega_0];
        mode = 'stick';
        separated = false;

        for iter = 1:100
            if t >= T_max, break; end

            if strcmp(mode, 'stick')
                % Check friction cone
                [ln, lt] = stick_forces(X_stick(1), X_stick(2), X_stick(3), X_stick(4), m1, m2, J1, J2, R, h, l, g);

                if lt > mu * ln
                    sgn_slip = -1; mode = 'slip'; continue;
                elseif lt < -mu * ln
                    sgn_slip = 1; mode = 'slip'; continue;
                end

                % Integrate
                opts = odeset('RelTol', 1e-8, 'AbsTol', 1e-10, 'Events', @events_stick);
                [T, X, ~, ~, Ie] = ode45(@sys_stick, [t, T_max], X_stick, opts);

                % Store segment
                [ln_out, lt_out] = compute_stick_forces(X);
                x_traj = x - R * (X(:, 1) - X(1, 1));
                X_full = [x_traj, X(:, 1), X(:, 2), -R * X(:, 3), X(:, 3), X(:, 4)];
                T_seg{end + 1} = T; X_seg{end + 1} = X_full; mode_seg{end + 1} = 'stick';
                ln_seg{end + 1} = ln_out; lt_seg{end + 1} = lt_out; vt_seg{end + 1} = zeros(size(T));

                if isempty(Ie), break; end

                % Transition to slip
                t = T(end); x = x_traj(end);
                sgn_slip = -2 * (Ie(end) == 1) + 1; % -1 if event 1, +1 if event 2
                X_stick = X(end, :)';
                mode = 'slip';

            else % slip mode
                % Convert to slip state
                X_slip = [x; X_stick(1); X_stick(2); -R * X_stick(3); X_stick(3); X_stick(4)];

                % Anti-chatter: small time step
                dt = 1e-6;
                if t + dt >= T_max, break; end
                [~, X_init] = ode45(@sys_slip, [t, t + dt], X_slip, odeset('RelTol', 1e-10, 'AbsTol', 1e-12));
                X_slip = X_init(end, :)'; t = t + dt;

                % Integrate
                opts = odeset('RelTol', 1e-8, 'AbsTol', 1e-10, 'Events', @events_slip);
                [T, X, ~, ~, Ie] = ode45(@sys_slip, [t, T_max], X_slip, opts);

                % Store segment
                [ln_out, lt_out, vt_out] = compute_slip_forces(X);
                T_seg{end + 1} = T; X_seg{end + 1} = X; mode_seg{end + 1} = 'slip';
                ln_seg{end + 1} = ln_out; lt_seg{end + 1} = lt_out; vt_seg{end + 1} = vt_out;

                if isempty(Ie), break; end

                if Ie(end) == 2 % Separation
                    separated = true; break;
                end

                % v_t = 0: check stick feasibility
                t = T(end); x = X(end, 1);
                [ln_test, lt_test] = stick_forces(X(end, 2), X(end, 3), X(end, 5), X(end, 6), m1, m2, J1, J2, R, h, l, g);
                ratio = lt_test / ln_test;

                if abs(ratio) < mu
                    X_stick = [X(end, 2); X(end, 3); X(end, 5); X(end, 6)];
                    mode = 'stick';
                else
                    sgn_slip = -2 * (ratio > mu) + 1; % -1 if ratio > mu, +1 otherwise
                    X_stick = [X(end, 2); X(end, 3); X(end, 5); X(end, 6)];
                end

            end

        end

    end

    %% Force computation
    function [ln, lt] = compute_stick_forces(X)
        N = size(X, 1);
        ln = zeros(N, 1); lt = zeros(N, 1);

        for i = 1:N
            [ln(i), lt(i)] = stick_forces(X(i, 1), X(i, 2), X(i, 3), X(i, 4), m1, m2, J1, J2, R, h, l, g);
        end

    end

    function [ln, lt, vt] = compute_slip_forces(X)
        N = size(X, 1);
        ln = zeros(N, 1); lt = zeros(N, 1); vt = zeros(N, 1);

        for i = 1:N
            [~, ~, ~, ln(i)] = slip_accelerations(X(i, 2), X(i, 3), X(i, 4), X(i, 5), X(i, 6), m1, m2, J1, J2, R, h, l, g, mu, sgn_slip);
            lt(i) = -sgn_slip * mu * ln(i);
            vt(i) = X(i, 4) + R * X(i, 5);
        end

    end

    %% Plot generation
    function generate_q5_plots(omega_slip, T_sim_local)
        setup_plot_defaults();
        output_dir = fileparts(mfilename('fullpath'));

        % Safely get default colors
        fig_temp = figure('Visible', 'off');
        colors = get(gca, 'ColorOrder');
        close(fig_temp);

        for case_num = 1:2
            omega = omega_slip * (0.9 + 0.1 * (case_num - 1));
            name = sprintf('case%d_%s', case_num, ternary(case_num == 1, '0p9_omega_slip', 'omega_slip'));
            fprintf('Case %d: omega_0 = %.6f rad/s\n', case_num, omega);

            X0 = [0; 0; 0; omega];
            opts = odeset('RelTol', 1e-8, 'AbsTol', 1e-10, 'Events', @events_stick);
            [T, X] = ode45(@sys_stick, [0, T_sim_local], X0, opts);
            [ln, lt] = compute_stick_forces(X);

            % (a) Angles
            fig = figure('Position', [100, 100, 800, 500]);
            plot(T, rad2deg(X(:, 1)), 'DisplayName', '$\theta$'); hold on;
            plot(T, rad2deg(X(:, 2)), 'DisplayName', '$\phi$'); hold off;
            xlabel('Time $t$ [s]'); ylabel('Angle [deg]');
            title(sprintf('(a) Angles vs Time ($\\omega_0 = %.4f$ rad/s)', omega));
            legend('Location', 'best'); grid on;
            print(fig, fullfile(output_dir, sprintf('q5_%s_a_angles.png', name)), '-dpng', '-r300');

            % (c) Normal force
            fig = figure('Position', [100, 100, 800, 500]);
            plot(T, ln); hold on; yline(0, 'k--', 'LineWidth', 1); hold off;
            xlabel('Time $t$ [s]'); ylabel('$\lambda_n$ [N]');
            title(sprintf('(c) Normal Contact Force vs Time ($\\omega_0 = %.4f$ rad/s)', omega));
            grid on;
            print(fig, fullfile(output_dir, sprintf('q5_%s_c_lambda_n.png', name)), '-dpng', '-r300');

            % (d) Force ratio
            fig = figure('Position', [100, 100, 800, 500]);
            plot(T, lt ./ ln, 'DisplayName', 'Force ratio'); hold on;
            yline(mu, '--', 'Color', colors(2, :), 'LineWidth', 1, 'DisplayName', '$+\mu$');
            yline(-mu, '--', 'Color', colors(2, :), 'LineWidth', 1, 'DisplayName', '$-\mu$');
            hold off;
            xlabel('Time $t$ [s]'); ylabel('$\lambda_t / \lambda_n$');
            title(sprintf('(d) Force Ratio vs Time ($\\omega_0 = %.4f$ rad/s)', omega));
            legend('Location', 'best'); grid on; ylim([-mu - 0.01, mu + 0.01]);
            print(fig, fullfile(output_dir, sprintf('q5_%s_d_force_ratio.png', name)), '-dpng', '-r300');

            fprintf('  Saved plots for %s\n', name);
        end

    end

    function generate_q6_plots(omega_sep, T_sim_local)
        setup_plot_defaults();
        output_dir = fileparts(mfilename('fullpath'));

        % Safely get default colors
        fig_temp = figure('Visible', 'off');
        colors = get(gca, 'ColorOrder');
        close(fig_temp);

        fprintf('omega_0 = omega_sep = %.6f rad/s\n', omega_sep);
        [~, T_seg, X_seg, mode_seg, ln_seg, lt_seg, vt_seg] = simulate_hybrid(omega_sep, T_sim_local);

        % (a) Angles
        fig = figure('Position', [100, 100, 800, 500]); hold on;
        plot_segments(T_seg, X_seg, mode_seg, [2 3], colors(1:2, :), true);
        add_legend({'$\theta$', '$\phi$'}, colors(1:2, :));
        hold off; xlabel('Time $t$ [s]'); ylabel('Angle [deg]');
        title(sprintf('(a) Angles vs Time ($\\omega_0 = %.4f$ rad/s)', omega_sep));
        legend('Location', 'best'); grid on;
        print(fig, fullfile(output_dir, 'q6_omega_sep_a_angles.png'), '-dpng', '-r300');

        % (b) Slip velocity
        fig = figure('Position', [100, 100, 800, 500]); hold on;
        plot_data_segments(T_seg, vt_seg, mode_seg, colors(1, :));
        add_legend_single(colors(1, :));
        yline(0, 'k--', 'LineWidth', 1, 'HandleVisibility', 'off');
        hold off; xlabel('Time $t$ [s]'); ylabel('$v_t$ [m/s]');
        title(sprintf('(b) Slip Velocity vs Time ($\\omega_0 = %.4f$ rad/s)', omega_sep));
        legend('Location', 'best'); grid on;
        print(fig, fullfile(output_dir, 'q6_omega_sep_b_slip_velocity.png'), '-dpng', '-r300');

        % (c) Normal force
        fig = figure('Position', [100, 100, 800, 500]); hold on;
        plot_data_segments(T_seg, ln_seg, mode_seg, colors(1, :));
        add_legend_single(colors(1, :));
        yline(0, 'k--', 'LineWidth', 1, 'HandleVisibility', 'off');
        hold off; xlabel('Time $t$ [s]'); ylabel('$\lambda_n$ [N]');
        title(sprintf('(c) Normal Contact Force vs Time ($\\omega_0 = %.4f$ rad/s)', omega_sep));
        legend('Location', 'best'); grid on;
        print(fig, fullfile(output_dir, 'q6_omega_sep_c_lambda_n.png'), '-dpng', '-r300');

        % (d) Force ratio
        fig = figure('Position', [100, 100, 800, 500]); hold on;

        for s = 1:length(T_seg)
            style = ternary(strcmp(mode_seg{s}, 'stick'), '-', '--');
            plot(T_seg{s}, lt_seg{s} ./ ln_seg{s}, style, 'Color', colors(1, :), 'HandleVisibility', 'off');
        end

        add_legend_single(colors(1, :));
        yline(mu, '--', 'Color', colors(2, :), 'LineWidth', 1, 'DisplayName', '$+\mu$');
        yline(-mu, '--', 'Color', colors(2, :), 'LineWidth', 1, 'DisplayName', '$-\mu$');
        hold off; xlabel('Time $t$ [s]'); ylabel('$\lambda_t / \lambda_n$');
        title(sprintf('(d) Force Ratio vs Time ($\\omega_0 = %.4f$ rad/s)', omega_sep));
        legend('Location', 'best'); grid on;
        print(fig, fullfile(output_dir, 'q6_omega_sep_d_force_ratio.png'), '-dpng', '-r300');

        fprintf('  Saved plots for omega_sep\n');
    end

    function generate_q7_plots(omega_0, T_sim_local)
        setup_plot_defaults();
        output_dir = fileparts(mfilename('fullpath'));

        % Safely get default colors
        fig_temp = figure('Visible', 'off');
        colors = get(gca, 'ColorOrder');
        close(fig_temp);

        fprintf('omega_0 = %.6f rad/s\n', omega_0);
        [~, T_seg, X_seg, mode_seg, ln_seg, lt_seg, vt_seg] = simulate_hybrid(omega_0, T_sim_local);

        % (a) Angles
        fig = figure('Position', [100, 100, 800, 500]); hold on;
        plot_segments(T_seg, X_seg, mode_seg, [2 3], colors(1:2, :), true);
        add_legend({'$\theta$', '$\phi$'}, colors(1:2, :));
        hold off; xlabel('Time $t$ [s]'); ylabel('Angle [deg]');
        title(sprintf('(a) Angles vs Time ($\\omega_0 = %.4f$ rad/s)', omega_0));
        legend('Location', 'best'); grid on;
        print(fig, fullfile(output_dir, 'q7_angles.png'), '-dpng', '-r300');

        % (b) Slip velocity
        fig = figure('Position', [100, 100, 800, 500]); hold on;
        plot_data_segments(T_seg, vt_seg, mode_seg, colors(1, :));
        add_legend_single(colors(1, :));
        yline(0, 'k--', 'LineWidth', 1, 'HandleVisibility', 'off');
        hold off; xlabel('Time $t$ [s]'); ylabel('$v_t$ [m/s]');
        title(sprintf('(b) Slip Velocity vs Time ($\\omega_0 = %.4f$ rad/s)', omega_0));
        legend('Location', 'best'); grid on;
        print(fig, fullfile(output_dir, 'q7_slip_velocity.png'), '-dpng', '-r300');

        % (c) Normal force
        fig = figure('Position', [100, 100, 800, 500]); hold on;
        plot_data_segments(T_seg, ln_seg, mode_seg, colors(1, :));
        add_legend_single(colors(1, :));
        yline(0, 'k--', 'LineWidth', 1, 'HandleVisibility', 'off');
        hold off; xlabel('Time $t$ [s]'); ylabel('$\lambda_n$ [N]');
        title(sprintf('(c) Normal Contact Force vs Time ($\\omega_0 = %.4f$ rad/s)', omega_0));
        legend('Location', 'best'); grid on;
        print(fig, fullfile(output_dir, 'q7_lambda_n.png'), '-dpng', '-r300');

        % (d) Force ratio
        fig = figure('Position', [100, 100, 800, 500]); hold on;

        for s = 1:length(T_seg)
            style = ternary(strcmp(mode_seg{s}, 'stick'), '-', '--');
            plot(T_seg{s}, lt_seg{s} ./ ln_seg{s}, style, 'Color', colors(1, :), 'HandleVisibility', 'off');
        end

        add_legend_single(colors(1, :));
        yline(mu, '--', 'Color', colors(2, :), 'LineWidth', 1, 'DisplayName', '$+\mu$');
        yline(-mu, '--', 'Color', colors(2, :), 'LineWidth', 1, 'DisplayName', '$-\mu$');
        hold off; xlabel('Time $t$ [s]'); ylabel('$\lambda_t / \lambda_n$');
        title(sprintf('(d) Force Ratio vs Time ($\\omega_0 = %.4f$ rad/s)', omega_0));
        legend('Location', 'best'); grid on;
        print(fig, fullfile(output_dir, 'q7_force_ratio.png'), '-dpng', '-r300');

        % (e) Horizontal displacement
        fig = figure('Position', [100, 100, 800, 500]); hold on;
        plot_segments(T_seg, X_seg, mode_seg, [1], colors(1, :), false);
        add_legend_single(colors(1, :));
        hold off; xlabel('Time $t$ [s]'); ylabel('$x$ [m]');
        title(sprintf('(e) Horizontal Displacement vs Time ($\\omega_0 = %.4f$ rad/s)', omega_0));
        legend('Location', 'best'); grid on;
        print(fig, fullfile(output_dir, 'q7_x_displacement.png'), '-dpng', '-r300');

        fprintf('  Saved plots for Question 7\n');
    end

    %% Plotting helpers
    function setup_plot_defaults()

        if ~strcmp(get(groot, 'defaultTextInterpreter'), 'latex')
            set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
            set(groot, 'defaultTextInterpreter', 'latex');
            set(groot, 'defaultLegendInterpreter', 'latex');
            set(groot, 'DefaultLineLineWidth', 2);
            set(groot, 'defaultAxesFontSize', 14);
        end

    end

    function plot_segments(T_seg, X_seg, mode_seg, cols, colors, to_deg)

        for s = 1:length(T_seg)
            style = ternary(strcmp(mode_seg{s}, 'stick'), '-', '--');

            for k = 1:length(cols)
                y = X_seg{s}(:, cols(k));
                if to_deg, y = rad2deg(y); end
                plot(T_seg{s}, y, style, 'Color', colors(k, :), 'HandleVisibility', 'off');
            end

        end

    end

    function plot_data_segments(T_seg, data_seg, mode_seg, color)

        for s = 1:length(T_seg)
            style = ternary(strcmp(mode_seg{s}, 'stick'), '-', '--');
            plot(T_seg{s}, data_seg{s}, style, 'Color', color, 'HandleVisibility', 'off');
        end

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
    end

    function result = ternary(cond, true_val, false_val)
        if cond, result = true_val; else, result = false_val; end
    end

end
