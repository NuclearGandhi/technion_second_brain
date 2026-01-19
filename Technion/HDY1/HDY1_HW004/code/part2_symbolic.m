%% Part B - Rocking Horse Toy: Symbolic Derivations
% This script derives the equations of motion symbolically and exports
% numerical functions using matlabFunction for use in simulations.
% HW4 - Hybrid Dynamics in Mechanical Systems

clear; clc;

%% Define symbolic variables
syms m1 m2 J1 J2 R h l g mu real positive
syms x y theta phi real
syms x_dot y_dot theta_dot phi_dot real
syms x_ddot y_ddot theta_ddot phi_ddot real
syms lambda_n lambda_t sigma real

% Shorthand notation
s_theta = sin(theta);
c_theta = cos(theta);
s_theta_phi = sin(theta - phi);
c_theta_phi = cos(theta - phi);

fprintf('=== Part B: Rocking Horse Toy - Symbolic Derivations ===\n\n');

%% Question 1: Verify Constraints and Kinematics
fprintf('--- Verifying Question 1 ---\n\n');

% Holonomic constraint (contact with ground)
d = y - R;
fprintf('Holonomic constraint: d = y - R = 0\n');

% Constraint gradient
q = [x; y; theta; phi];
q_dot = [x_dot; y_dot; theta_dot; phi_dot];
q_ddot = [x_ddot; y_ddot; theta_ddot; phi_ddot];

w_n = jacobian(d, q);
fprintf('Normal constraint gradient w_n:\n');
disp(w_n);

% Velocity of contact point P
v_t = x_dot + R * theta_dot;
fprintf('Tangential velocity: v_t = x_dot + R*theta_dot\n');

% No-slip constraint
W_t = jacobian(v_t, q_dot);
fprintf('Tangential constraint gradient W_t:\n');
disp(W_t);

% Combined constraint matrix
W = [w_n; W_t];
fprintf('Combined constraint matrix W:\n');
disp(W);

%% Kinematics and Energy
fprintf('--- Kinematics ---\n\n');

% Position of horse body COM
r_1c = [x + h * s_theta; y - h * c_theta];
v_1c = jacobian(r_1c, q) * q_dot;
v_1c = simplify(v_1c);
fprintf('Horse COM velocity v_1c:\n');
disp(v_1c);

% Position of pendulum COM
r_2c = [x + l * s_theta_phi; y - l * c_theta_phi];
v_2c = jacobian(r_2c, q) * q_dot;
v_2c = simplify(v_2c);
fprintf('Pendulum COM velocity v_2c:\n');
disp(v_2c);

% Kinetic energy
T = (1/2) * m1 * (v_1c.' * v_1c) + (1/2) * J1 * theta_dot ^ 2 + ...
    (1/2) * m2 * (v_2c.' * v_2c) + (1/2) * J2 * (theta_dot - phi_dot) ^ 2;
T = simplify(T);
fprintf('Kinetic energy T:\n');
disp(T);

% Potential energy
V = m1 * g * (y - h * c_theta) + m2 * g * (y - l * c_theta_phi);
V = simplify(V);
fprintf('Potential energy V:\n');
disp(V);

%% Derive Equations of Motion using Lagrangian Mechanics
fprintf('--- Deriving EoM ---\n\n');

% Lagrangian
L = T - V;

% Compute mass matrix M from kinetic energy
M = hessian(T, q_dot);

M = simplify(M);
fprintf('Mass matrix M:\n');
disp(M);

% Compute B (Coriolis/centrifugal terms) and G (gravity)
% EoM: M*q_ddot + B + G = W^T * lambda
% B_i = sum_j sum_k (dM_ij/dq_k - 0.5*dM_jk/dq_i) * q_dot_j * q_dot_k

B = sym(zeros(4, 1));

for i = 1:4

    for j = 1:4

        for k = 1:4
            Christoffel = (1/2) * (diff(M(i, j), q(k)) + diff(M(i, k), q(j)) - diff(M(j, k), q(i)));
            B(i) = B(i) + Christoffel * q_dot(j) * q_dot(k);
        end

    end

end

B = simplify(B);
fprintf('Coriolis/centrifugal vector B:\n');
disp(B);

% Gravity vector
G = jacobian(V, q).';
G = simplify(G);
fprintf('Gravity vector G:\n');
disp(G);

%% Solve for Constrained Dynamics (No-Slip Case)
fprintf('--- No-Slip Constrained Dynamics ---\n\n');

% Under no-slip: y = R, y_dot = 0, y_ddot = 0, x_dot = -R*theta_dot, x_ddot = -R*theta_ddot
% The constraints reduce the system to 2 DOF: (theta, phi)

% Apply constraints to find reduced EoM
% From W*q_ddot = -W_dot*q_dot (differentiated constraint)

% Full EoM: M*q_ddot + B + G = W^T * [lambda_n; lambda_t]
% With constraints: q_ddot = [-R*theta_ddot; 0; theta_ddot; phi_ddot]

% Substitute constraint into EoM
q_ddot_constrained = [-R * theta_ddot; 0; theta_ddot; phi_ddot];
q_dot_constrained = [-R * theta_dot; 0; theta_dot; phi_dot];

% Substitute into EoM
M_sub = subs(M, [y, y_dot], [R, 0]);
B_sub = subs(B, [y, y_dot, x_dot], [R, 0, -R * theta_dot]);
G_sub = subs(G, y, R);

EoM_lhs = M_sub * q_ddot_constrained + B_sub + G_sub;
EoM_rhs = W.' * [lambda_n; lambda_t];

% This gives 4 equations:
% Row 1: ... = lambda_t
% Row 2: ... = lambda_n
% Row 3: ... = R*lambda_t
% Row 4: ... = 0

EoM = simplify(EoM_lhs - EoM_rhs);

fprintf('EoM under no-slip constraint (should equal 0):\n');

for i = 1:4
    fprintf('Row %d: ', i);
    disp(EoM(i));
end

% Solve all 4 equations directly for all 4 unknowns
sol_stick = solve(EoM_lhs == EoM_rhs, [theta_ddot, phi_ddot, lambda_n, lambda_t]);

theta_ddot_sol = simplify(sol_stick.theta_ddot);
phi_ddot_sol = simplify(sol_stick.phi_ddot);
lambda_n_sol_stick = simplify(sol_stick.lambda_n);
lambda_t_sol_stick = simplify(sol_stick.lambda_t);

fprintf('theta_ddot (no-slip):\n');
disp(theta_ddot_sol);
fprintf('phi_ddot (no-slip):\n');
disp(phi_ddot_sol);
fprintf('lambda_n (no-slip):\n');
disp(lambda_n_sol_stick);
fprintf('lambda_t (no-slip):\n');
disp(lambda_t_sol_stick);

%% Solve for Slipping Dynamics
fprintf('\n--- Slipping Contact Dynamics ---\n\n');

% Under slipping: lambda_t = -sigma*mu*lambda_n
% Constraint: y = R (normal contact), but x is free (no tangential constraint)
% q_ddot = [x_ddot; 0; theta_ddot; phi_ddot] with x_ddot free

% EoM: M*q_ddot + B + G = (w_n - sigma*mu*W_t)^T * lambda_n
w_combined_slip = (w_n - sigma * mu * W_t).';
fprintf('Combined constraint vector for slip:\n');
disp(w_combined_slip);

% Substitute y = R, y_dot = 0, y_ddot = 0
M_slip = subs(M, [y, y_dot], [R, 0]);
B_slip = subs(B, [y, y_dot], [R, 0]);
G_slip = subs(G, y, R);

q_ddot_slip = [x_ddot; 0; theta_ddot; phi_ddot];

EoM_slip_lhs = M_slip * q_ddot_slip + B_slip + G_slip;
EoM_slip_rhs = w_combined_slip * lambda_n;

EoM_slip = simplify(EoM_slip_lhs - EoM_slip_rhs);

fprintf('EoM under slipping (4 equations, 4 unknowns: x_ddot, theta_ddot, phi_ddot, lambda_n):\n');

for i = 1:4
    fprintf('Row %d: ', i);
    disp(EoM_slip(i));
end

% Solve the 4x4 system
sol_slip = solve([EoM_slip(1) == 0, EoM_slip(2) == 0, EoM_slip(3) == 0, EoM_slip(4) == 0], ...
    [x_ddot, theta_ddot, phi_ddot, lambda_n]);

x_ddot_sol_slip = simplify(sol_slip.x_ddot);
theta_ddot_sol_slip = simplify(sol_slip.theta_ddot);
phi_ddot_sol_slip = simplify(sol_slip.phi_ddot);
lambda_n_sol_slip = simplify(sol_slip.lambda_n);

fprintf('x_ddot (slipping):\n');
disp(x_ddot_sol_slip);
fprintf('theta_ddot (slipping):\n');
disp(theta_ddot_sol_slip);
fprintf('phi_ddot (slipping):\n');
disp(phi_ddot_sol_slip);
fprintf('lambda_n (slipping):\n');
disp(lambda_n_sol_slip);

%% Solve for Separation Dynamics (Free Flight)
fprintf('\n--- Separation Dynamics (Free Flight) ---\n\n');

% No constraints: lambda_n = 0, lambda_t = 0
% EoM: M*q_ddot + B + G = 0
% q = [x; y; theta; phi]

rhs_sep = -B - G;
q_ddot_sol_sep = M \ rhs_sep;
q_ddot_sol_sep = simplify(q_ddot_sol_sep);

x_ddot_sep = q_ddot_sol_sep(1);
y_ddot_sep = q_ddot_sol_sep(2);
theta_ddot_sep = q_ddot_sol_sep(3);
phi_ddot_sep = q_ddot_sol_sep(4);

fprintf('x_ddot (separation):\n');
disp(x_ddot_sep);
fprintf('y_ddot (separation):\n');
disp(y_ddot_sep);
fprintf('theta_ddot (separation):\n');
disp(theta_ddot_sep);
fprintf('phi_ddot (separation):\n');
disp(phi_ddot_sep);

%% Export Numerical Functions
fprintf('\n--- Exporting Numerical Functions ---\n\n');

output_dir = fileparts(mfilename('fullpath'));

% For no-slip (stick) dynamics: need theta_ddot, phi_ddot, lambda_n, lambda_t
% State is X = [theta; phi; theta_dot; phi_dot]
% Note: x is determined by x = -R*theta (integrated separately if needed)

% Create function for stick dynamics accelerations
fprintf('Exporting stick_accelerations.m...\n');
matlabFunction(theta_ddot_sol, phi_ddot_sol, ...
    'File', fullfile(output_dir, 'stick_accelerations.m'), ...
    'Vars', {theta, phi, theta_dot, phi_dot, m1, m2, J1, J2, R, h, l, g}, ...
    'Outputs', {'theta_ddot', 'phi_ddot'});

% Create function for stick constraint forces
fprintf('Exporting stick_forces.m...\n');
matlabFunction(lambda_n_sol_stick, lambda_t_sol_stick, ...
    'File', fullfile(output_dir, 'stick_forces.m'), ...
    'Vars', {theta, phi, theta_dot, phi_dot, m1, m2, J1, J2, R, h, l, g}, ...
    'Outputs', {'lambda_n', 'lambda_t'});

% For slipping dynamics: need x_ddot, theta_ddot, phi_ddot, lambda_n
% State is X = [x; theta; phi; x_dot; theta_dot; phi_dot]

fprintf('Exporting slip_accelerations.m...\n');
matlabFunction(x_ddot_sol_slip, theta_ddot_sol_slip, phi_ddot_sol_slip, lambda_n_sol_slip, ...
    'File', fullfile(output_dir, 'slip_accelerations.m'), ...
    'Vars', {theta, phi, x_dot, theta_dot, phi_dot, m1, m2, J1, J2, R, h, l, g, mu, sigma}, ...
    'Outputs', {'x_ddot', 'theta_ddot', 'phi_ddot', 'lambda_n'});

% For separation dynamics: need x_ddot, y_ddot, theta_ddot, phi_ddot
% State is X = [x; y; theta; phi; x_dot; y_dot; theta_dot; phi_dot]

fprintf('Exporting sep_accelerations.m...\n');
matlabFunction(x_ddot_sep, y_ddot_sep, theta_ddot_sep, phi_ddot_sep, ...
    'File', fullfile(output_dir, 'sep_accelerations.m'), ...
    'Vars', {theta, phi, theta_dot, phi_dot, m1, m2, J1, J2, R, h, l, g}, ...
    'Outputs', {'x_ddot', 'y_ddot', 'theta_ddot', 'phi_ddot'});

fprintf('\nAll functions exported successfully!\n');
fprintf('=== Symbolic Derivations Complete ===\n');
