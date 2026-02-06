%% Shared Physics Functions for Compass Biped
% Contains simulation, event detection, and impact law functions.

function funcs = biped_physics()
    funcs.simulate = @simulate_walking;
    funcs.sys_stick = @sys_stick;
    funcs.sys_slip = @sys_slip;
    funcs.events_stick = @events_stick;
    funcs.events_slip = @events_slip;
    funcs.impact_law = @impact_law;
end

%% Simulation
function [T_seg, X_seg, x_stance_seg, swap_count_seg] = simulate_walking(X0, T_max, max_steps, params)
    T_seg = {};
    X_seg = {};
    x_stance_seg = {};
    swap_count_seg = [];

    t = 0;
    X = X0;
    x_stance = 0;
    swap_count = 0;
    step_count = 0;

    while t < T_max && step_count < max_steps
        opts = odeset('RelTol', 1e-8, 'AbsTol', 1e-10, ...
            'Events', @(t, X) events_stick(t, X, params));
        [T, Xout, Te, Xe, Ie] = ode45(@(t, X) sys_stick(t, X, params), [t, T_max], X, opts);

        T_seg{end+1} = T;
        X_seg{end+1} = Xout;
        x_stance_seg{end+1} = x_stance * ones(length(T), 1);
        swap_count_seg(end+1) = swap_count;

        if isempty(Ie), break; end

        event = Ie(end);
        if event == 1
            fprintf('  t = %.3f s: Impact (step %d)\n', Te(end), step_count + 1);
            [X_new, status, ~] = impact_law(Xe(end, :)', params);
            if status ~= 0
                fprintf('    Impact failed\n');
                break;
            end
            
            theta1 = Xe(end, 1);
            theta2 = Xe(end, 2);
            x_swing = x_stance + 2*params.l*sin(theta1) + 2*params.l*sin(theta2);
            x_stance = x_swing;
            swap_count = swap_count + 1;
            X = X_new;
            t = Te(end);
            step_count = step_count + 1;
        elseif event == 2
            fprintf('  t = %.3f s: Falling\n', Te(end));
            break;
        elseif event == 3
            fprintf('  t = %.3f s: Forward slip\n', Te(end));
            break;
        elseif event == 4
            fprintf('  t = %.3f s: Backward slip\n', Te(end));
            break;
        end
    end
end

%% Dynamics
function dXdt = sys_stick(~, X, params)
    [th1_ddot, th2_ddot] = stick_accelerations(X(1), X(2), X(3), X(4), ...
        params.m, params.m_h, params.I_c, params.l, params.g, params.alpha);
    dXdt = [X(3); X(4); th1_ddot; th2_ddot];
end

function dXdt = sys_slip(~, X, params)
    [x_ddot, th1_ddot, th2_ddot, ~] = slip_accelerations(X(2), X(3), X(4), X(5), X(6), ...
        params.m, params.m_h, params.I_c, params.l, params.g, params.alpha, params.mu, params.sgn_slip);
    dXdt = [X(4); X(5); X(6); x_ddot; th1_ddot; th2_ddot];
end

%% Events
function [value, isterminal, direction] = events_stick(~, X, params)
    theta1 = X(1);
    theta2 = X(2);
    theta1_dot = X(3);
    theta2_dot = X(4);
    l = params.l;
    mu = params.mu;

    % Swing foot height and position
    y_swing = 2*l*cos(theta1) - 2*l*cos(theta2);
    x_swing_rel = 2*l*(sin(theta1) + sin(theta2));
    
    % Impact: swing foot at ground AND ahead of stance foot
    scuff_threshold = 0.3 * l;
    if x_swing_rel > scuff_threshold
        swing_collision = y_swing;
    else
        swing_collision = 1;
    end

    % Falling: hip at ground
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

function [value, isterminal, direction] = events_slip(~, X, params)
    theta1 = X(2);
    theta2 = X(3);
    x_dot = X(4);
    theta1_dot = X(5);
    theta2_dot = X(6);

    % Slip stops
    slip_velocity = x_dot;

    % Separation
    [~, ~, ~, lambda_n] = slip_accelerations(theta1, theta2, x_dot, theta1_dot, theta2_dot, ...
        params.m, params.m_h, params.I_c, params.l, params.g, params.alpha, params.mu, params.sgn_slip);

    % Falling
    hip_height = cos(theta1);

    value = [slip_velocity; lambda_n; hip_height];
    isterminal = [1; 1; 1];
    direction = [0; -1; -1];
end

%% Impact Law
function [Xnew, status, Lambda] = impact_law(Xold, params)
    theta1 = Xold(1);
    theta2 = Xold(2);
    theta1_dot = Xold(3);
    theta2_dot = Xold(4);
    
    % At impact, theta1 ≈ theta2 = theta_c
    theta_c = (theta1 + theta2) / 2;
    
    q_dot = [0; 0; theta1_dot; theta2_dot];

    % Collision matrix at impact
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

    % Friction bound
    if abs(Lambda_t) > params.mu * Lambda_n
        sigma = sign(Lambda_t);
        Lambda_n = -v_minus(2) / (A_c(2,2) + sigma * params.mu * A_c(1,2));
        Lambda_t = sigma * params.mu * Lambda_n;
        Lambda = [Lambda_t; Lambda_n];
    end

    q_dot_plus = q_dot + M_inv_W_T * Lambda;
    theta1_dot_plus = q_dot_plus(3);
    theta2_dot_plus = q_dot_plus(4);

    % Relabel: swap and negate angles/velocities (geometric reference changes)
    theta1_new = -theta2;
    theta2_new = -theta1;
    theta1_dot_new = -theta2_dot_plus;
    theta2_dot_new = -theta1_dot_plus;

    % Rear foot lift-off check: y_dot_rear = 2l*sin(theta_c)*(theta1_dot - theta2_dot) > 0
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
