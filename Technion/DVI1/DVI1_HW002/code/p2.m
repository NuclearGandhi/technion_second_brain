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
% exportgraphics(gcf, 'q11.png', 'Resolution', 300);

%% Question 12

% Define symbolic variables for damping coefficients
syms lambda real
syms alpha beta mtilde1 mtilde2


% Define the modal matrix using alpha and beta
modal_matrix = [(alpha+beta)/sqrt(mtilde1), (alpha-beta)/sqrt(mtilde2);
     1/sqrt(mtilde1), 1/sqrt(mtilde2)];


% Define the damping matrix C
C = diag([lambda, lambda]);

% Calculate the modal damping matrix Gamma
Gamma = modal_matrix^-1 * C *  modal_matrix;

% % Display the modal damping matrix in LaTeX format
disp('Modal Damping Matrix Gamma:');
disp(latex(simplify(Gamma)));

%% Question 13

modal_matrix = [1/sqrt(2), -1/sqrt(2);
     1/sqrt(2), 1/sqrt(2)];

% Define parameters
omega1 = 1;
a_tilde = 1;
b_tilde = 1;

mu = 1;
mu1 = mu;
mu2 = mu;
chi = 0.5;

omega2 = sqrt((a_tilde * mu1 + b_tilde * mu2) / chi^2 + 1);
zeta1 = 0.1;
zeta2 = 0;


Gamma = [2 * zeta1 * omega1, 0; 0, 2 * zeta2 * omega2];

% Define the frequency range
omega_range = linspace(0, omega2 * 1.3, 1000);

% Define the modal vectors
phi1 = [1/sqrt(2); 1/sqrt(2)];
phi2 = [-1/sqrt(2); 1/sqrt(2)];

% Define the force vector
Q0 = [1; 0];

% Calculate the frequency response

% Preallocate theta_response matrix
theta_response = zeros(2, length(omega_range));

% Loop over frequency range
for i = 1:length(omega_range)
     omega = omega_range(i);
     Z = -omega^2 * eye(2) + 1i * Gamma * omega * eye(2) + [omega1^2, 0; 0, omega2^2];
     H_modal = Z \ eye(size(Z));
     H = modal_matrix * H_modal * modal_matrix';
     
     % Calculate the response for theta_1 and theta_2
     theta_response(:, i) = abs(H * Q0);
 end

% Plot the frequency response
figure;
semilogy(omega_range, theta_response(1, :), 'LineWidth', 2);
hold on;
semilogy(omega_range, theta_response(2, :), 'LineWidth', 2);

% Plot vertical lines for the natural frequencies, and add to legend
xline(omega1, '--', 'LineWidth', 1, 'Color', 'k', 'Label', '$\omega_1$', 'Interpreter', 'latex', 'FontSize', 14);
xline(omega2, '--', 'LineWidth', 1, 'Color', 'k', 'Label', '$\omega_2$', 'Interpreter', 'latex', 'FontSize', 14);

title(['Frequency Response for $\zeta_1 = ', num2str(zeta1), '$ and $\zeta_2 = ', num2str(zeta2), '$']);
xlabel('$\omega$');
ylabel('$\theta_0$');
legend('$\theta_1$', '$\theta_2$');
grid on;

% Move legend to the top left corner
legend('Location', 'NorthWest');

set(gcf, 'Units', 'pixels', 'Position', [100, 100, 600, 400]); % Set figure size and position
exportgraphics(gcf, 'q13.png', 'Resolution', 300);

% Plot 3 graphs on the same figure of the frequency response for different mu values
mu_values = [0.1, 1, 10];
theta_response = zeros(2, length(omega_range));

figure;
% Loop over mu values
omega2_max = sqrt((a_tilde * mu_values(3) + b_tilde * mu_values(3)) / chi^2 + 1);
omega_range = linspace(0, omega2_max * 1.3, 1000);

for mu = mu_values
     mu1 = mu;
     mu2 = mu;
     omega2 = sqrt((a_tilde * mu1 + b_tilde * mu2) / chi^2 + 1);
     % Recalculate Gamma for the new mu value
     Gamma = [2 * zeta1 * omega1, 0; 0, 2 * zeta2 * omega2];


     % Loop over frequency range
     for i = 1:length(omega_range)
          omega = omega_range(i);
          Z = -omega^2 * eye(2) + 1i * Gamma * omega * eye(2) + [omega1^2, 0; 0, omega2^2];
          H_modal = Z \ eye(size(Z));
          H = modal_matrix * H_modal * modal_matrix';
          
          % Calculate the response for theta_1 and theta_2
          theta_response(:, i) = abs(H * Q0);
     end
     
     % Plot the frequency response
     semilogy(omega_range, theta_response(1, :), 'LineWidth', 2, 'DisplayName', ['$\mu = ', num2str(mu), '$']);
     hold on;
end

% Plot vertical lines for the natural frequencies, and add to legend
xline(omega1, '--', 'LineWidth', 1, 'Color', 'k', 'Label', '$\omega_1$', 'LabelHorizontalAlignment', 'left', 'Interpreter', 'latex', 'FontSize', 14);

title(['Frequency Response of $\theta_1$ for $\zeta_1 = ', num2str(zeta1), '$ and $\zeta_2 = ', num2str(zeta2), '$']);
xlabel('$\omega$');
ylabel('$\theta_0$');
grid on;

% Move legend to the top left corner
legend('Location', 'SouthEast');
legend('$\mu = 0.1$', '$\mu = 1$', '$\mu = 10$');

set(gcf, 'Units', 'pixels', 'Position', [100, 100, 600, 400]); % Set figure size and position
exportgraphics(gcf, 'q13_mu.png', 'Resolution', 300);