function run_simulation()
    % RUN_SIMULATION Run numerical simulation for HDY1 Homework 2 Assignment 4
    % Solves the dynamics of the wave-board system and saves results.

    %% 1. Simulation Parameters
    p.b = 0.2;      % m
    p.d = 0.05;     % m
    p.m1 = 5;       % kg
    p.m2 = 40;      % kg
    p.J1 = (1/3) * p.m1 * p.b^2; % kg*m^2
    p.J2 = (1/8) * p.m2 * p.b^2; % kg*m^2
    p.k = 0.05;     % N*m
    p.c = 0.01;     % N*m*s
    p.cw = 0.5;     % N*s/m
    p.beta = 0.4;   % rad
    p.omega = 1;    % rad/s

    t_span = [0, 150]; % sec

    %% 2. Initial Conditions
    % q = [x, y, theta, phi1, phi2, psi]
    % Initial conditions are all zero, except psi(0) = beta
    % We simulate passive coordinates q_p = [x, y, theta, phi1, phi2]
    % State z = [q_p; dq_p] (10x1 vector)
    
    q_p0 = zeros(5, 1);
    dq_p0 = zeros(5, 1);
    z0 = [q_p0; dq_p0];

    %% 3. Run Simulation
    options = odeset('RelTol', 1e-6, 'AbsTol', 1e-8);
    [t_out, z_out] = ode45(@(t, z) system_dynamics(t, z, p), t_span, z0, options);

    %% 4. Post-Process Results
    % Reconstruct full state history including actuated coordinate psi and constraints
    num_steps = length(t_out);
    
    % Preallocate
    q_full = zeros(6, num_steps);
    dq_full = zeros(6, num_steps);
    lambda_out = zeros(2, num_steps);
    tau_psi_out = zeros(1, num_steps);
    F_ext_out = zeros(2, num_steps);
    Mc_out = zeros(1, num_steps);
    
    for i = 1:num_steps
        t = t_out(i);
        z = z_out(i, :).';
        
        % Solve algebraic part (lambda, tau) again for storage
        [~, algebraic_vars, F_ext, M_c] = solve_algebraic(t, z, p);
        
        % Store
        tau_psi_out(i) = algebraic_vars(1);
        lambda_out(:, i) = algebraic_vars(2:3);
        F_ext_out(:, i) = F_ext;
        Mc_out(i) = M_c;
        
        % Full coordinates
        [psi_val, dpsi_val, ~] = get_actuation(t, p);
        q_p = z(1:5);
        dq_p = z(6:10);
        
        q_full(:, i) = [q_p; psi_val];
        dq_full(:, i) = [dq_p; dpsi_val];
    end

    %% 5. Save Results
    results.t = t_out;
    results.q = q_full;
    results.dq = dq_full;
    results.lambda = lambda_out;
    results.tau_psi = tau_psi_out;
    results.F_ext = F_ext_out;
    results.Mc = Mc_out;
    results.params = p;
    
    save('simulation_results.mat', '-struct', 'results');
    fprintf('Simulation completed and results saved to simulation_results.mat\n');
end

function dz = system_dynamics(t, z, p)
    % Extract state
    q_p = z(1:5);   % [x; y; theta; phi1; phi2]
    dq_p = z(6:10); % [dx; dy; dtheta; dphi1; dphi2]
    
    % Actuation
    [psi_val, dpsi_val, ddpsi_val] = get_actuation(t, p);
    
    % Full configuration for matrix function
    % q vector order: [x, y, theta, phi1, phi2, psi]
    q_full = [q_p; psi_val];
    dq_full = [dq_p; dpsi_val];
    
    % Get Matrices from generated function
    % Vars: q, dq, m1, m2, J1, J2, b, d, k, c, cw, ddpsi, tau_psi, lambda1, lambda2
    % Note: The generated function 'get_EOM_matrices' expects symbolic variables as arguments
    % if generated naively, but since we generated it with 'Vars', it expects numeric values.
    % However, tau_psi and lambda are UNKNOWNS in the dynamics solve.
    % The generated function returns LHS and RHS matrices. 
    % The matrices L and R should NOT depend on tau_psi or lambda if we formulated Eq 2.16 correctly.
    % Let's check the export in derive_equations.m.
    % It exports LHS_Matrix and RHS_Vector.
    % In form 2.16: LHS * [ddq_p; tau_psi; lambda] = RHS
    % The LHS and RHS should depend on q, dq, and known inputs (ddpsi).
    % They should NOT depend on the unknowns [ddq_p; tau_psi; lambda].
    % Wait, the 'Vars' list in derive_equations included tau_psi, lambda1, lambda2?
    % If so, the generated function expects them. But they are unknowns!
    % We need to confirm if LHS/RHS contain these variables.
    % Looking at the symbolic derivation:
    % LHS_Matrix contains M, W terms. NO tau_psi or lambda.
    % RHS_Vector contains Coriolis, Gravity, Friction. NO tau_psi or lambda.
    % The tau_psi term was moved to LHS (element -1 in the matrix).
    % The lambda terms were moved to LHS (W^T).
    % So passing 0 for tau_psi and lambda to get_EOM_matrices is safe/correct,
    % assuming the symbolic expression doesn't have residual terms.
    
    % Calculate Matrices
    % Pass 0 for the unknowns tau_psi and lambdas since they are not in the coefficients matrices
    [LHS, RHS, ~, ~] = get_EOM_matrices(q_full, dq_full, p.m1, p.m2, p.J1, p.J2, ...
                                        p.b, p.d, p.k, p.c, p.cw, ddpsi_val, 0, 0, 0);
    
    % Solve linear system X = LHS \ RHS
    % X = [ddq_p (5x1); tau_psi (1x1); lambda (2x1)]
    X = LHS \ RHS;
    
    ddq_p = X(1:5);
    
    dz = [dq_p; ddq_p];
end

function [ddq_p, algebraic_vars, F_ext, M_c] = solve_algebraic(t, z, p)
    % Same as dynamics but returns extra info
    q_p = z(1:5);
    dq_p = z(6:10);
    [psi_val, dpsi_val, ddpsi_val] = get_actuation(t, p);
    q_full = [q_p; psi_val];
    dq_full = [dq_p; dpsi_val];
    
    % We need lambda for F_ext calc.
    % We need to call get_EOM_matrices with dummy 0s for unknowns to get LHS/RHS,
    % solve for unknowns (including lambda), then call it again with REAL lambdas to get F_ext?
    % No, get_EOM_matrices returns F_ext as 3rd output.
    % Does F_ext symbolic expression depend on lambda? Yes.
    % So we must solve first.
    
    [LHS, RHS, ~, ~] = get_EOM_matrices(q_full, dq_full, p.m1, p.m2, p.J1, p.J2, ...
                                        p.b, p.d, p.k, p.c, p.cw, ddpsi_val, 0, 0, 0);
    X = LHS \ RHS;
    
    ddq_p = X(1:5);
    tau_val = X(6);
    lambda_val = X(7:8);
    
    algebraic_vars = [tau_val; lambda_val];
    
    % Now compute F_ext and M_c using the found lambdas
    [~, ~, F_ext, M_c] = get_EOM_matrices(q_full, dq_full, p.m1, p.m2, p.J1, p.J2, ...
                                          p.b, p.d, p.k, p.c, p.cw, ddpsi_val, tau_val, lambda_val(1), lambda_val(2));
end

function [psi, dpsi, ddpsi] = get_actuation(t, p)
    psi = p.beta * cos(p.omega * t);
    dpsi = -p.beta * p.omega * sin(p.omega * t);
    ddpsi = -p.beta * p.omega^2 * cos(p.omega * t);
end

