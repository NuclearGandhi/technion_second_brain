%% Part A - Falling Pencil Problem with Frictionless Contact
% Symbolic verification of all derivations
% HW4 - Hybrid Dynamics in Mechanical Systems

clear; clc;

%% Define symbolic variables
syms m l I_c g theta theta_dot real positive
syms omega_0 v_0 real positive
syms x y x_dot y_dot x_ddot y_ddot theta_ddot real
syms lambda_n real
syms beta gamma real positive

%% Question 1: Kinetic and Potential Energy
fprintf('=== Question 1: Kinetic and Potential Energy ===\n');

% COM position is (x, y)
% Contact point position
x_p = x + l * sin(theta);
y_p = y - l * cos(theta);

fprintf('Contact point position:\n');
fprintf('  x_p = x + l*sin(theta)\n');
fprintf('  y_p = y - l*cos(theta)\n\n');

% Kinetic energy (unconstrained)
T = (1/2) * m * (x_dot ^ 2 + y_dot ^ 2) + (1/2) * I_c * theta_dot ^ 2;
fprintf('Kinetic energy: T = (1/2)*m*(x_dot^2 + y_dot^2) + (1/2)*I_c*theta_dot^2\n');

% Potential energy
V = m * g * y;
fprintf('Potential energy: V = m*g*y\n\n');

%% Question 2: Constrained Equations of Motion
fprintf('=== Question 2: Constrained Equations of Motion ===\n');

% Constraint: y_p = 0 => y - l*cos(theta) = 0
d_constraint = y - l * cos(theta);
fprintf('Holonomic constraint: d = y - l*cos(theta) = 0\n');

% Gradient of constraint (w_n)
q = [x; y; theta];
w_n = jacobian(d_constraint, q);
fprintf('Constraint gradient w_n:\n');
disp(w_n);

% Mass matrix (diagonal since we're using COM coordinates)
M = diag([m, m, I_c]);
fprintf('Mass matrix M:\n');
disp(M);

% Gravity vector (appears on LHS as +G, so G = [0; mg; 0])
G = [0; m * g; 0];
fprintf('Gravity vector G:\n');
disp(G);

% Equations of motion: M*q_ddot + G = w_n^T * lambda_n
fprintf('Equations of motion: M*q_ddot + G = w_n^T * lambda_n\n\n');

%% Question 3: Normal Contact Force lambda_n(theta, theta_dot)
fprintf('=== Question 3: Normal Contact Force ===\n');

% Differentiate constraint twice
d_dot = diff(d_constraint, y) * y_dot + diff(d_constraint, theta) * theta_dot;
d_dot = simplify(d_dot);
fprintf('First derivative of constraint (d_dot):\n');
disp(d_dot);

% For second derivative, we need to express y_dot in terms of theta, theta_dot
% From d_dot = 0: y_dot + l*sin(theta)*theta_dot = 0
% => y_dot = -l*sin(theta)*theta_dot

% d_ddot = y_ddot + l*cos(theta)*theta_dot^2 + l*sin(theta)*theta_ddot = 0
d_ddot = y_ddot + l * cos(theta) * theta_dot ^ 2 + l * sin(theta) * theta_ddot;
fprintf('Second derivative of constraint (d_ddot):\n');
disp(d_ddot);

% From equations of motion:
% m*x_ddot = 0
% m*y_ddot + m*g = lambda_n  =>  y_ddot = (lambda_n - m*g)/m
% I_c*theta_ddot = lambda_n*l*sin(theta)  =>  theta_ddot = lambda_n*l*sin(theta)/I_c

y_ddot_expr = (lambda_n - m * g) / m;
theta_ddot_expr = lambda_n * l * sin(theta) / I_c;

% Substitute into d_ddot = 0
d_ddot_substituted = subs(d_ddot, [y_ddot, theta_ddot], [y_ddot_expr, theta_ddot_expr]);
d_ddot_substituted = simplify(d_ddot_substituted);
fprintf('d_ddot after substitution:\n');
disp(d_ddot_substituted);

% Solve for lambda_n
lambda_n_sol = solve(d_ddot_substituted == 0, lambda_n);
lambda_n_sol = simplify(lambda_n_sol);
fprintf('Lambda_n(theta, theta_dot):\n');
disp(lambda_n_sol);

% Verify the form: lambda_n = I_c*(m*g - m*l*theta_dot^2*cos(theta)) / (I_c + m*l^2*sin^2(theta))
lambda_n_expected = I_c * (m * g - m * l * theta_dot ^ 2 * cos(theta)) / (I_c + m * l ^ 2 * sin(theta) ^ 2);
diff_check = simplify(lambda_n_sol - lambda_n_expected);
fprintf('Difference from expected form (should be 0):\n');
disp(diff_check);

%% Question 4: Using Energy Conservation
fprintf('=== Question 4: Energy Conservation ===\n');

% Under constraint: y = l*cos(theta), y_dot = -l*sin(theta)*theta_dot
y_constrained = l * cos(theta);
y_dot_constrained = -l * sin(theta) * theta_dot;

% Kinetic energy under constraint (x_dot = v_0 = const)
T_constrained = (1/2) * m * (v_0 ^ 2 + (l * sin(theta) * theta_dot) ^ 2) + (1/2) * I_c * theta_dot ^ 2;
T_constrained = simplify(T_constrained);
fprintf('Kinetic energy under constraint:\n');
disp(T_constrained);

% Potential energy under constraint
V_constrained = m * g * l * cos(theta);
fprintf('Potential energy under constraint: V = m*g*l*cos(theta)\n\n');

% Total energy
E = T_constrained + V_constrained;
E = simplify(E);
fprintf('Total energy E:\n');
disp(E);

% Initial energy (at theta = 0, theta_dot = omega_0)
E_0 = subs(E, [theta, theta_dot], [0, omega_0]);
E_0 = simplify(E_0);
fprintf('Initial energy E_0:\n');
disp(E_0);

% Energy conservation: E = E_0
% Solve for theta_dot^2
energy_eq = E - E_0;
energy_eq = simplify(energy_eq);
fprintf('Energy equation (E - E_0 = 0):\n');
disp(energy_eq);

% Manually rearrange: collect terms with theta_dot^2
% E = (1/2)*m*l^2*sin^2(theta)*theta_dot^2 + (1/2)*I_c*theta_dot^2 + m*g*l*cos(theta) + (1/2)*m*v_0^2
% E_0 = (1/2)*I_c*omega_0^2 + m*g*l + (1/2)*m*v_0^2
% E - E_0 = 0 =>
% (1/2)*(I_c + m*l^2*sin^2(theta))*theta_dot^2 = (1/2)*I_c*omega_0^2 + m*g*l*(1 - cos(theta))
% theta_dot^2 = (I_c*omega_0^2 + 2*m*g*l*(1 - cos(theta))) / (I_c + m*l^2*sin^2(theta))

theta_dot_sq_expected = (I_c * omega_0 ^ 2 + 2 * m * g * l * (1 - cos(theta))) / (I_c + m * l ^ 2 * sin(theta) ^ 2);
fprintf('Expected theta_dot^2 from energy conservation:\n');
disp(theta_dot_sq_expected);

% Verify by substitution back into energy equation
energy_check = subs(energy_eq, theta_dot ^ 2, theta_dot_sq_expected);
energy_check = simplify(energy_check);
fprintf('Energy equation after substitution (should be 0):\n');
disp(energy_check);

% Use this for lambda_n
theta_dot_sq_sol = theta_dot_sq_expected;

% Substitute into lambda_n
lambda_n_theta_only = subs(lambda_n_sol, theta_dot ^ 2, theta_dot_sq_sol);
lambda_n_theta_only = simplify(lambda_n_theta_only);
fprintf('Lambda_n(theta) using energy conservation:\n');
disp(lambda_n_theta_only);

%% Question 5: Dimensionless Form
fprintf('=== Question 5: Dimensionless Form ===\n');

% Substitutions: I_c = beta*m*l^2, omega_0^2 = gamma^2*g^2/l^2
lambda_n_dimensionless = subs(lambda_n_theta_only, I_c, beta * m * l ^ 2);
lambda_n_dimensionless = subs(lambda_n_dimensionless, omega_0 ^ 2, gamma ^ 2 * g ^ 2 / l ^ 2);
lambda_n_dimensionless = simplify(lambda_n_dimensionless);
fprintf('Lambda_n in terms of beta, gamma, theta:\n');
disp(lambda_n_dimensionless);

% Factor out m*g
f_beta_gamma_theta = simplify(lambda_n_dimensionless / (m * g));
fprintf('f(beta, gamma, theta) = lambda_n/(m*g):\n');
disp(f_beta_gamma_theta);

% Verify form at theta = 0
f_at_0 = subs(f_beta_gamma_theta, theta, 0);
f_at_0 = simplify(f_at_0);
fprintf('f(beta, gamma, 0) = lambda_n(0)/(m*g):\n');
disp(f_at_0);

%% Question 6: Check singularity and parameter constraints
fprintf('=== Question 6: Parameter Constraints ===\n');

% Denominator of lambda_n
denominator = I_c + m * l ^ 2 * sin(theta) ^ 2;
fprintf('Denominator of lambda_n: I_c + m*l^2*sin^2(theta)\n');
fprintf('This is zero only when I_c = 0 AND theta = 0 (degenerate case)\n\n');

% Initial contact force (lambda_n at theta = 0)
lambda_n_initial = subs(lambda_n_sol, theta, 0);
lambda_n_initial = simplify(lambda_n_initial);
fprintf('Lambda_n at theta = 0:\n');
disp(lambda_n_initial);
fprintf('For lambda_n(0) > 0: omega_0^2 < g/l, i.e., gamma^2 < 1\n\n');

%% Question 7: Verify lambda_n > 0 for theta in [0, pi/2)
fprintf('=== Question 7: Check lambda_n at pi/2 ===\n');

% Lambda_n at theta = pi/2
lambda_n_at_pi2 = subs(lambda_n_sol, theta, sym(pi) / 2);
lambda_n_at_pi2 = simplify(lambda_n_at_pi2);
fprintf('Lambda_n at theta = pi/2:\n');
disp(lambda_n_at_pi2);

% In terms of beta
lambda_n_at_pi2_beta = subs(lambda_n_at_pi2, I_c, beta * m * l ^ 2);
lambda_n_at_pi2_beta = simplify(lambda_n_at_pi2_beta);
fprintf('Lambda_n at theta = pi/2 in terms of beta:\n');
disp(lambda_n_at_pi2_beta);
fprintf('This equals beta*m*g/(beta + 1) > 0 for beta > 0\n');

fprintf('\n=== All symbolic verifications complete ===\n');
