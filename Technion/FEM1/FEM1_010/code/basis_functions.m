function basis_functions()
% BASIS_FUNCTIONS - Euler-Bernoulli Beam Shape Functions
% Generates and plots the four shape functions for Euler-Bernoulli beam element
% Using φ(x) and h^e notation as defined in equations OA5.60-OA5.63

%% Parameters
he = 1;                    % Element length h^e (normalized to 1)
x = linspace(0, he, 100);  % Position vector from 0 to h^e

%% Shape Functions φ_i(x) - Equations OA5.60-OA5.63
% φ₁(x) = 1 - 3(x/h^e)² + 2(x/h^e)³
phi1 = 1 - 3*(x/he).^2 + 2*(x/he).^3;

% φ₂(x) = x - 2x²/h^e + x³/(h^e)²  
phi2 = x - 2*x.^2/he + x.^3/(he^2);

% φ₃(x) = 3(x/h^e)² - 2(x/h^e)³
phi3 = 3*(x/he).^2 - 2*(x/he).^3;

% φ₄(x) = -x²/h^e + x³/(h^e)²
phi4 = -x.^2/he + x.^3/(he^2);

%% First Derivatives dφ_i/dx - Equations OA5.74-OA5.77
% dφ₁/dx = -6x/(h^e)² + 6x²/(h^e)³
dphi1_dx = -6*x/(he^2) + 6*x.^2/(he^3);

% dφ₂/dx = 1 - 4x/h^e + 3x²/(h^e)²
dphi2_dx = 1 - 4*x/he + 3*x.^2/(he^2);

% dφ₃/dx = 6x/(h^e)² - 6x²/(h^e)³
dphi3_dx = 6*x/(he^2) - 6*x.^2/(he^3);

% dφ₄/dx = -2x/h^e + 3x²/(h^e)²
dphi4_dx = -2*x/he + 3*x.^2/(he^2);

%% Second Derivatives d²φ_i/dx² - Equations OA5.78-OA5.81
% d²φ₁/dx² = -6/(h^e)² + 12x/(h^e)³
d2phi1_dx2 = -6/(he^2) + 12*x/(he^3);

% d²φ₂/dx² = -4/h^e + 6x/(h^e)²
d2phi2_dx2 = -4/he + 6*x/(he^2);

% d²φ₃/dx² = 6/(h^e)² - 12x/(h^e)³
d2phi3_dx2 = 6/(he^2) - 12*x/(he^3);

% d²φ₄/dx² = -2/h^e + 6x/(h^e)²
d2phi4_dx2 = -2/he + 6*x/(he^2);

%% Plotting - 4 subplots for individual shape functions
figure('Position', [100, 100, 1000, 800]);

% φ₁(x)
subplot(2, 2, 1);
plot(x, phi1, 'b-', 'LineWidth', 2);
grid on;
xlabel('$x/h^e$');
ylabel('$\phi_1(x)$');
title('Shape Function $\phi_1(x)$');
xlim([0, 1]);
ylim([-0.1, 1.1]);

% φ₂(x) 
subplot(2, 2, 2);
plot(x, phi2, 'b-', 'LineWidth', 2);
grid on;
xlabel('$x/h^e$');
ylabel('$\phi_2(x)$');
title('Shape Function $\phi_2(x)$');
xlim([0, 1]);

% φ₃(x)
subplot(2, 2, 3);
plot(x, phi3, 'b-', 'LineWidth', 2);
grid on;
xlabel('$x/h^e$');
ylabel('$\phi_3(x)$');
title('Shape Function $\phi_3(x)$');
xlim([0, 1]);
ylim([-0.1, 1.1]);

% φ₄(x)
subplot(2, 2, 4);
plot(x, phi4, 'b-', 'LineWidth', 2);
grid on;
xlabel('$x/h^e$');
ylabel('$\phi_4(x)$');
title('Shape Function $\phi_4(x)$');
xlim([0, 1]);

% Add overall title
sgtitle('Euler-Bernoulli Beam Shape Functions', 'FontSize', 16, 'FontWeight', 'bold');

%% Display Key Properties
fprintf('\n=== Euler-Bernoulli Beam Shape Functions Properties ===\n');
fprintf('Element length h^e = %.1f\n', he);
fprintf('\nNodal Values:\n');
fprintf('φ₁(0) = %.3f, φ₁(h^e) = %.3f\n', phi1(1), phi1(end));
fprintf('φ₂(0) = %.3f, φ₂(h^e) = %.3f\n', phi2(1), phi2(end));
fprintf('φ₃(0) = %.3f, φ₃(h^e) = %.3f\n', phi3(1), phi3(end));
fprintf('φ₄(0) = %.3f, φ₄(h^e) = %.3f\n', phi4(1), phi4(end));

fprintf('\nFirst Derivatives at Nodes:\n');
fprintf('dφ₁/dx(0) = %.3f, dφ₁/dx(h^e) = %.3f\n', dphi1_dx(1), dphi1_dx(end));
fprintf('dφ₂/dx(0) = %.3f, dφ₂/dx(h^e) = %.3f\n', dphi2_dx(1), dphi2_dx(end));
fprintf('dφ₃/dx(0) = %.3f, dφ₃/dx(h^e) = %.3f\n', dphi3_dx(1), dphi3_dx(end));
fprintf('dφ₄/dx(0) = %.3f, dφ₄/dx(h^e) = %.3f\n', dphi4_dx(1), dphi4_dx(end));

%% Verification - Partition of Unity
sum_phi = phi1 + phi2 + phi3 + phi4;
fprintf('\nPartition of Unity Check:\n');
fprintf('φ₁ + φ₂ + φ₃ + φ₄ = %.6f (should be 1.0)\n', sum_phi(50)); % Check at midpoint

%% Save plot
saveas(gcf, 'euler_bernoulli_shape_functions.png');
fprintf('\nPlot saved as: euler_bernoulli_shape_functions.png\n');

end
