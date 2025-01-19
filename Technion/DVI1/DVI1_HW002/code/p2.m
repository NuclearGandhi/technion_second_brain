clc; clear; close all;

%% Question 6

% Define symbolic variables
syms a b mu1 mu2 X nu real

% Define the matrices M and K
M = eye(2);
K = [a*mu1/X^2 + 1, -b*mu1/X^2; -a*mu2/X^2, b*mu2/X^2 + nu];

% Solve the eigenvalue problem
[eigenvectors, eigenvalues] = eig(K);

% Display the natural frequencies and modal vectors
natural_frequencies = simplify(sqrt(diag(eigenvalues)));
modal_vectors = simplify(eigenvectors);

disp('Natural Frequencies:');
disp(latex(natural_frequencies));
disp('Modal Vectors:');
disp(latex(modal_vectors));

%% Question 7

% Find the modal mass and modal stiffness matrices
modal_mass = eigenvectors' * M * eigenvectors;
modal_stiffness = eigenvectors' * K * eigenvectors;

disp('Modal Mass Matrix:');
disp(modal_mass);
disp('Modal Stiffness Matrix:');
disp(modal_stiffness);

% Find the normalized modal vector matrix
normalized_modal_vectors = eigenvectors * diag(1./sqrt(diag(modal_mass)));

disp('Normalized Modal Vectors:');
disp(normalized_modal_vectors);

%% Question 9

% Calculate the natural frequencies if nu = 1
nu_param = 1;
K_nu1 = subs(K, nu, nu_param);

[eigenvectors_nu1, eigenvalues_nu1] = eig(K_nu1);
natural_frequencies_nu1 = sqrt(diag(eigenvalues_nu1));
natural_frequencies_nu1 = simplify(natural_frequencies_nu1);


disp('Natural Frequencies for nu = 1:');
disp(latex(natural_frequencies_nu1));

% Define symbolic variables for the expressions
syms theta10 theta20 omega1 omega2 tau psi real

% Define the expressions
theta1_expr = (b/(a*(b^2/a^2 + 1)) * (b/a*theta10 + theta20) * cos(omega1 * tau - psi)) - ...
              (mu1/(mu2*(mu1^2/mu2^2 + 1)) * (-mu1/mu2*theta10 + theta20) * cos(omega2 * tau - psi));

theta2_expr = (1/(b^2/a^2 + 1) * (b/a*theta10 + theta20) * cos(omega1 * tau - psi)) + ...
              (1/(mu1^2/mu2^2 + 1) * (-mu1/mu2*theta10 + theta20) * cos(omega2 * tau - psi));

% Simplify the expressions
theta1_simplified = simplify(theta1_expr);
theta2_simplified = simplify(theta2_expr);

% Display the simplified expressions in LaTeX format
disp('Simplified Expression for theta1:');
disp(latex(theta1_simplified));
disp('Simplified Expression for theta2:');
disp(latex(theta2_simplified));

%% Question 11

% Define parameters for the system
a_param = 0.5;
b_param = 0.5;
k_param = 10;
g_param = 9.81;
m1_param = 1;
m2_param = b_param^2 * m1_param / a_param^2;
L_param = 1;
l0_param = 10;
l1_param = 0.1;
l2_param = l1_param;
chi_param = l0_param / L_param;
a_tilde_param = a_param / L_param;
b_tilde_param = b_param / L_param;
v_param = 1;
mu1_param = k_param * l1_param * L_param * a_param / (m1_param * l1_param^2 * g_param);
mu2_param = k_param * l1_param * L_param * b_param / (m2_param * l2_param^2 * g_param);
frac_condition = (a_tilde_param * mu1_param + b_tilde_param * mu2_param) / chi_param^2;
disp(frac_condition);
% Define the physical system dynamics
A = [0, 0, 1, 0;
     0, 0, 0, 1;
     -a_tilde_param * mu1_param / chi_param^2 - 1, b_tilde_param * mu1_param / chi_param^2, 0, 0;
     a_tilde_param * mu2_param / chi_param^2, -b_tilde_param * mu2_param / chi_param^2 - v_param, 0, 0] * sqrt(g_param / l1_param);

B = zeros(4, 1);
C = [1, 0, 0, 0;
     0, 1, 0, 0];
D = zeros(2, 1);

sys = ss(A, B, C, D);

theta0 = [deg2rad(10); 0; 0; 0];
t = linspace(0, 100, 1000);

theta_num = lsim(sys, zeros(1, length(t)), t, theta0);

omega_1 = 1;
omega_2 = sqrt((a_tilde_param * mu1_param + b_tilde_param * mu2_param) / chi_param^2 + 1);
omega_B = omega_2 - omega_1;
omega_avg = (omega_1 + omega_2) / 2;
tau = sqrt(g_param / l1_param) * t;
theta1_theo = theta0(1) * cos((omega_B / 2) * tau) .* cos((omega_avg / 2) * tau);
theta2_theo = theta0(1) * sin((omega_B / 2) * tau) .* sin((omega_avg / 2) * tau);

figure;
subplot(2, 1, 1);
plot(t, rad2deg(theta_num(:, 1)));
hold on;
plot(t, rad2deg(theta1_theo));
title('Response of $\theta_1$');
xlabel('$t$');
ylabel('$\theta_1$');
legend('Numerical', 'Linearized Analytical');
grid on;

subplot(2, 1, 2);
plot(t, rad2deg(theta_num(:, 2)));
hold on;
plot(t, rad2deg(theta2_theo));
title('Response of $\theta_2$');
xlabel('$t$');
ylabel('$\theta_2$');
legend('Numerical', 'Linearized Analytical');
grid on;

set(gcf, 'Units', 'pixels', 'Position', [100, 100, 1200, 600]); % Set figure size and position
exportgraphics(gcf, 'q11.png', 'Resolution', 300);