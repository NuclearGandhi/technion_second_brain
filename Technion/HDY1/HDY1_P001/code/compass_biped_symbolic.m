%% Compass Biped - Symbolic Derivations
% Derives equations of motion and exports numerical functions.
%
% Coordinates: q = [x, y, theta1, theta2]
%   theta1: stance leg angle (CW positive from vertical)
%   theta2: swing leg angle (CCW positive from vertical)

clear; clc;
fprintf('=== Compass Biped: Symbolic Derivations ===\n\n');

%% Symbolic Variables
syms m m_h I_c l g alpha mu real positive
syms x y theta1 theta2 real
syms x_dot y_dot theta1_dot theta2_dot real
syms x_ddot y_ddot theta1_ddot theta2_ddot real
syms lambda_n lambda_t sigma real

q = [x; y; theta1; theta2];
q_dot = [x_dot; y_dot; theta1_dot; theta2_dot];
q_ddot = [x_ddot; y_ddot; theta1_ddot; theta2_ddot];

%% Kinematics
fprintf('=== Kinematics ===\n\n');

r_foot = [x; y];
r_1c = [x + l*sin(theta1); y + l*cos(theta1)];
r_h = [x + 2*l*sin(theta1); y + 2*l*cos(theta1)];
r_2c = simplify([r_h(1) + l*sin(theta2); r_h(2) - l*cos(theta2)]);
r_swing = simplify([r_h(1) + 2*l*sin(theta2); r_h(2) - 2*l*cos(theta2)]);

fprintf('r_foot: '); disp(r_foot.');
fprintf('r_1c: '); disp(r_1c.');
fprintf('r_h: '); disp(r_h.');
fprintf('r_2c: '); disp(r_2c.');
fprintf('r_swing: '); disp(r_swing.');

%% Velocities
fprintf('\n=== Velocities ===\n\n');

v_1c = simplify(jacobian(r_1c, q) * q_dot);
v_h = simplify(jacobian(r_h, q) * q_dot);
v_2c = simplify(jacobian(r_2c, q) * q_dot);
W_tilde = simplify(jacobian(r_swing, q));

fprintf('v_1c: '); disp(v_1c.');
fprintf('v_h: '); disp(v_h.');
fprintf('v_2c: '); disp(v_2c.');
fprintf('W_tilde:\n'); disp(W_tilde);

%% Energies
fprintf('\n=== Energy ===\n\n');

T_1 = (1/2)*m*(v_1c.'*v_1c) + (1/2)*I_c*theta1_dot^2;
T_h = (1/2)*m_h*(v_h.'*v_h);
T_2 = (1/2)*m*(v_2c.'*v_2c) + (1/2)*I_c*theta2_dot^2;
T = simplify(T_1 + T_h + T_2);

V_1 = m*g*cos(alpha)*r_1c(2) - m*g*sin(alpha)*r_1c(1);
V_h = m_h*g*cos(alpha)*r_h(2) - m_h*g*sin(alpha)*r_h(1);
V_2 = m*g*cos(alpha)*r_2c(2) - m*g*sin(alpha)*r_2c(1);
V = simplify(V_1 + V_h + V_2);

fprintf('T: '); disp(T);
fprintf('V: '); disp(V);

%% Lagrangian Dynamics
fprintf('\n=== Dynamics Matrices ===\n\n');

M = simplify(hessian(T, q_dot));
G = simplify(jacobian(V, q).');

B = sym(zeros(4, 1));
for i = 1:4
    for j = 1:4
        for k = 1:4
            Gamma = (1/2)*(diff(M(i,j), q(k)) + diff(M(i,k), q(j)) - diff(M(j,k), q(i)));
            B(i) = B(i) + Gamma * q_dot(j) * q_dot(k);
        end
    end
end
B = simplify(B);

fprintf('M:\n'); disp(M);
fprintf('G:\n'); disp(G);
fprintf('B:\n'); disp(B);

%% Constraints
w_n = jacobian(y, q);
w_t = [1, 0, 0, 0];
W = [w_n; w_t];

fprintf('\nW (constraint matrix):\n'); disp(W);
fprintf('W_tilde (swing foot Jacobian):\n'); disp(W_tilde);

%% Formatted Output
fprintf('\n=== Formatted Output ===\n\n');
for i = 1:4
    fprintf('M(%d,:) = [%s, %s, %s, %s]\n', i, char(M(i,1)), char(M(i,2)), char(M(i,3)), char(M(i,4)));
end
fprintf('\n');
for i = 1:4, fprintf('G(%d) = %s\n', i, char(G(i))); end
fprintf('\n');
for i = 1:4, fprintf('B(%d) = %s\n', i, char(B(i))); end
fprintf('\n');
for i = 1:2
    fprintf('W_tilde(%d,:) = [%s, %s, %s, %s]\n', i, char(W_tilde(i,1)), char(W_tilde(i,2)), char(W_tilde(i,3)), char(W_tilde(i,4)));
end

%% Export Functions
fprintf('\n=== Exporting Functions ===\n\n');
output_dir = fileparts(mfilename('fullpath'));

fprintf('mass_matrix.m\n');
matlabFunction(M, 'File', fullfile(output_dir, 'mass_matrix.m'), ...
    'Vars', {theta1, theta2, m, m_h, I_c, l}, 'Outputs', {'M'});

fprintf('gravity_vector.m\n');
matlabFunction(G, 'File', fullfile(output_dir, 'gravity_vector.m'), ...
    'Vars', {theta1, theta2, m, m_h, l, g, alpha}, 'Outputs', {'G'});

fprintf('coriolis_vector.m\n');
matlabFunction(B, 'File', fullfile(output_dir, 'coriolis_vector.m'), ...
    'Vars', {theta1, theta2, theta1_dot, theta2_dot, m, m_h, l}, 'Outputs', {'B'});

fprintf('swing_foot_position.m\n');
matlabFunction(r_swing(1), r_swing(2), 'File', fullfile(output_dir, 'swing_foot_position.m'), ...
    'Vars', {x, y, theta1, theta2, l}, 'Outputs', {'x_swing', 'y_swing'});

fprintf('swing_foot_jacobian.m\n');
matlabFunction(W_tilde, 'File', fullfile(output_dir, 'swing_foot_jacobian.m'), ...
    'Vars', {theta1, theta2, l}, 'Outputs', {'W_tilde'});

%% No-Slip Dynamics
fprintf('\n=== No-Slip Dynamics ===\n\n');

q_ddot_stick = [0; 0; theta1_ddot; theta2_ddot];
M_stick = subs(M, [y, y_dot, x_dot], [0, 0, 0]);
B_stick = subs(B, [y, y_dot, x_dot], [0, 0, 0]);
G_stick = subs(G, y, 0);

EoM_lhs = M_stick * q_ddot_stick + B_stick + G_stick;
EoM_rhs = W.' * [lambda_n; lambda_t];

sol = solve(EoM_lhs == EoM_rhs, [theta1_ddot, theta2_ddot, lambda_n, lambda_t]);
theta1_ddot_stick = simplify(sol.theta1_ddot);
theta2_ddot_stick = simplify(sol.theta2_ddot);
lambda_n_stick = simplify(sol.lambda_n);
lambda_t_stick = simplify(sol.lambda_t);

fprintf('stick_accelerations.m\n');
matlabFunction(theta1_ddot_stick, theta2_ddot_stick, ...
    'File', fullfile(output_dir, 'stick_accelerations.m'), ...
    'Vars', {theta1, theta2, theta1_dot, theta2_dot, m, m_h, I_c, l, g, alpha}, ...
    'Outputs', {'theta1_ddot', 'theta2_ddot'});

fprintf('stick_forces.m\n');
matlabFunction(lambda_n_stick, lambda_t_stick, ...
    'File', fullfile(output_dir, 'stick_forces.m'), ...
    'Vars', {theta1, theta2, theta1_dot, theta2_dot, m, m_h, I_c, l, g, alpha}, ...
    'Outputs', {'lambda_n', 'lambda_t'});

%% Slip Dynamics
fprintf('\n=== Slip Dynamics ===\n\n');

w_slip = (w_n - sigma*mu*w_t).';
q_ddot_slip = [x_ddot; 0; theta1_ddot; theta2_ddot];
M_slip = subs(M, [y, y_dot], [0, 0]);
B_slip = subs(B, [y, y_dot], [0, 0]);
G_slip = subs(G, y, 0);

EoM_slip = M_slip * q_ddot_slip + B_slip + G_slip - w_slip * lambda_n;
sol_slip = solve([EoM_slip(1)==0, EoM_slip(2)==0, EoM_slip(3)==0, EoM_slip(4)==0], ...
    [x_ddot, theta1_ddot, theta2_ddot, lambda_n]);

fprintf('slip_accelerations.m\n');
matlabFunction(simplify(sol_slip.x_ddot), simplify(sol_slip.theta1_ddot), ...
    simplify(sol_slip.theta2_ddot), simplify(sol_slip.lambda_n), ...
    'File', fullfile(output_dir, 'slip_accelerations.m'), ...
    'Vars', {theta1, theta2, x_dot, theta1_dot, theta2_dot, m, m_h, I_c, l, g, alpha, mu, sigma}, ...
    'Outputs', {'x_ddot', 'theta1_ddot', 'theta2_ddot', 'lambda_n'});

%% Impact (at theta1 = theta2 = theta_c)
fprintf('\n=== Impact ===\n\n');

syms theta_c real
M_c = subs(M, [theta1, theta2], [theta_c, theta_c]);
M_c = simplify(M_c);
W_tilde_c = subs(W_tilde, [theta1, theta2], [theta_c, theta_c]);
W_tilde_c = simplify(W_tilde_c);

A_c = simplify(W_tilde_c * (M_c \ W_tilde_c.'));
M_inv_W_T = simplify(M_c \ W_tilde_c.');

fprintf('M_c:\n'); disp(M_c);
fprintf('W_tilde_c:\n'); disp(W_tilde_c);
fprintf('A_c:\n'); disp(A_c);

fprintf('collision_matrix.m\n');
matlabFunction(A_c, 'File', fullfile(output_dir, 'collision_matrix.m'), ...
    'Vars', {theta_c, m, m_h, I_c, l}, 'Outputs', {'A_c'});

fprintf('impulse_to_velocity.m\n');
matlabFunction(M_inv_W_T, 'File', fullfile(output_dir, 'impulse_to_velocity.m'), ...
    'Vars', {theta_c, m, m_h, I_c, l}, 'Outputs', {'M_inv_W_T'});

fprintf('\n=== Complete ===\n');
