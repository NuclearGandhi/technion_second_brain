function my_part2()
    close all;

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

    omega_slip

    function result = bisection_search(condition_fn, low, high, tol, name)

        for iter = 1:50
            mid = (low + high) / 2;
            if condition_fn(mid), high = mid; else, low = mid; end;
            if (high - low) < tol, break; end
        end

        result = high;
    end

    function slipped = check_slip(omega_0, T_max)
        X0 = [0; 0; 0; omega_0];
        opts = odeset('RelTol', 1e-8, 'AbsTol', 1e-10, 'Events', @events_stick);
        [~, ~, ~, ~, Ie] = ode45(@sys_stick, [0, T_max], X0, opts);
        slipped = ~isempty(Ie);
    end

    function [value, isterminal, direction] = events_stick(~, X)
        [lamnbda_n, lambda_t] = stick_forces(X(1), X(2), X(3), X(4), m1, m2, J1, J2, R, h, l, g);
        value = [lambda_t - mu * lambda_n; lambda_t + mu * lambda_n];
        isterminal = [1; 1];
        direction = [0; 0];
    end

    function dXdt = sys_stick(~, X);
        [theta_ddot, phi_ddot] = stick_accelerations(X(1), X(2), X(3), X(4), m1, m2, J1, J2, R, h, l, g)
        dXdt = [X(3); X(4); theta_ddot; phi_ddot];
    end

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

                    if (lt > mu * ln)
                        sgn_slip = -1; mode = 'slip'; continue;
                    elseif (lt < -mu * ln)
                        sgn_slip = 1; mode = 'slip'; continue;
                    end

                    opts = odeset('RelTol', 1e-8, 'AbsTol', 1e-10, 'Events', @events_stick);
                    [T, X, ~, ~, Ie] = ode45(@sys_stick, [t, T_max], X_stick, opts);

                    [ln_out, lt_out] = compute_stick_forces(X);
                    x_traj = x - R * (X(:, 1) - X(1, 1));
                    x_full = [x_traj, X(:, 1), X(:, 2), -R * X(:, 3), X(:, 3), X(:, 4)];
                    T_seg{end + 1} = T; X_seg{end + 1} = X_full; mode_seg{end + 1} = 'stick';
                    ln_seg{end + 1} = ln_out; lt_seg{end + 1} = lt_out; vt_seg{end + 1} = zeros(size(T));

                    if isempty(Ie), break; end
                    t = T(end); x = x_traj(end);
                    sgn_slip = ternary(Ie(end) == 1, -1, 1);
                    X_stick = X(end, :)';
                    mode = 'slip';
            end

        end

    end

end

function solve_q9()
end
