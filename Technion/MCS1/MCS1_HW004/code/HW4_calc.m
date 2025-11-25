%% MCS1 HW004 - Side Pull-In Analysis
% Symbolic verification and solution

clear; clc; close all;

disp('=== MCS1 HW004 - Side Pull-In Analysis ===')
disp(' ')

%% Define symbolic variables
syms c_0 c_1 c_2 c_3 lambda gamma

disp('Question 4: Coefficient Matrix')
disp('--------------------------------')
disp(' ')

disp('General solution:')
disp('y_tilde = c_0*exp(-lambda*x_tilde) + c_1*exp(lambda*x_tilde) +')
disp('          c_2*sin(lambda*x_tilde) + c_3*cos(lambda*x_tilde)')
disp('where lambda^2 = V_tilde')
disp(' ')

disp('Applying boundary conditions...')
disp(' ')

% Coefficients for BC1: y_tilde(0) = 0
% c_0 + c_1 + c_3 = 0
disp('BC1: y_tilde(0) = 0')
disp('Equation: c_0 + c_1 + c_3 = 0')
disp(' ')

% Coefficients for BC2: y_tilde'(0) = y_tilde''(0)/gamma
% y'(0) = -lambda*c_0 + lambda*c_1 + lambda*c_2
% y''(0) = lambda^2*c_0 + lambda^2*c_1 - lambda^2*c_3
% BC: -lambda*c_0 + lambda*c_1 + lambda*c_2 = (lambda^2*c_0 + lambda^2*c_1 - lambda^2*c_3)/gamma
% Rearranging: (-lambda - lambda^2/gamma)*c_0 + (lambda - lambda^2/gamma)*c_1 + lambda*c_2 + (lambda^2/gamma)*c_3 = 0
disp('BC2: y_tilde''(0) = y_tilde''''(0)/gamma')
disp('After simplification (dividing by lambda):')
disp('(-1 - lambda/gamma)*c_0 + (1 - lambda/gamma)*c_1 + c_2 + (lambda/gamma)*c_3 = 0')
disp(' ')

% Coefficients for BC3: y_tilde''(1) = 0
% lambda^2*exp(-lambda)*c_0 + lambda^2*exp(lambda)*c_1 - lambda^2*sin(lambda)*c_2 - lambda^2*cos(lambda)*c_3 = 0
disp('BC3: y_tilde''''(1) = 0')
disp('After dividing by lambda^2:')
disp('exp(-lambda)*c_0 + exp(lambda)*c_1 - sin(lambda)*c_2 - cos(lambda)*c_3 = 0')
disp(' ')

% Coefficients for BC4: y_tilde'''(1) = 0
% -lambda^3*exp(-lambda)*c_0 + lambda^3*exp(lambda)*c_1 - lambda^3*cos(lambda)*c_2 + lambda^3*sin(lambda)*c_3 = 0
disp('BC4: y_tilde''''''(1) = 0')
disp('After dividing by lambda^3:')
disp('-exp(-lambda)*c_0 + exp(lambda)*c_1 - cos(lambda)*c_2 + sin(lambda)*c_3 = 0')
disp(' ')

% Build coefficient matrix
A = sym(zeros(4,4));

% Row 1: BC1
A(1,1) = 1;
A(1,2) = 1;
A(1,3) = 0;
A(1,4) = 1;

% Row 2: BC2
A(2,1) = -1 - lambda/gamma;
A(2,2) = 1 - lambda/gamma;
A(2,3) = 1;
A(2,4) = lambda/gamma;

% Row 3: BC3 (after dividing by lambda^2)
A(3,1) = exp(-lambda);
A(3,2) = exp(lambda);
A(3,3) = -sin(lambda);
A(3,4) = -cos(lambda);

% Row 4: BC4 (after dividing by lambda^3)
A(4,1) = -exp(-lambda);
A(4,2) = exp(lambda);
A(4,3) = -cos(lambda);
A(4,4) = sin(lambda);

disp('Coefficient Matrix A:')
disp(A)
disp(' ')

%% Question 5: Characteristic Equation
disp('Question 5: Characteristic Equation')
disp('--------------------------------------')
disp(' ')

disp('Computing determinant of coefficient matrix...')
det_A = det(A);
disp('Determinant:')
disp(det_A)
disp(' ')

try
    det_A_simp = simplify(det_A);
    disp('Simplified determinant:')
    disp(det_A_simp)
    disp(' ')
catch
    disp('(Simplification skipped due to version compatibility)')
    disp(' ')
    det_A_simp = det_A;
end

disp('For non-trivial solution, det(A) = 0')
disp(' ')

%% Question 6: Numerical Solution for gamma=1
disp('Question 6: Finding critical lambda for gamma=1')
disp('-------------------------------------------------------------')
disp(' ')

% Substitute gamma=1
A_gamma1 = subs(A, gamma, 1);
det_gamma1 = det(A_gamma1);

try
    det_gamma1_simp = simplify(det_gamma1);
    disp('Characteristic equation for gamma=1:')
    disp(det_gamma1_simp)
    disp(' ')
    det_func = matlabFunction(det_gamma1_simp);
catch
    disp('(Using unsimplified form for numerical computation)')
    disp(' ')
    det_func = matlabFunction(det_gamma1);
end

% Search for roots
lambda_range = linspace(0.1, 10, 2000);
det_values = arrayfun(det_func, lambda_range);

% Plot
figure(1);
plot(lambda_range, det_values, 'LineWidth', 2);
grid on;
xlabel('lambda');
ylabel('det(A)');
title('Characteristic Equation for gamma=1');
yline(0, 'r--', 'LineWidth', 1.5);

% Find sign changes (roots)
sign_changes = [];
for i = 1:length(det_values)-1
    if det_values(i) * det_values(i+1) < 0
        sign_changes = [sign_changes, i];
    end
end

disp('Roots found:')
roots_found = [];
for i = 1:min(5, length(sign_changes))  % Find first 5 roots
    idx = sign_changes(i);
    lambda_guess = lambda_range(idx);
    try
        lambda_root = fzero(det_func, lambda_guess);
        roots_found = [roots_found, lambda_root];
        fprintf('  lambda_%d = %.6f,  V_tilde = %.6f\n', i, lambda_root, lambda_root^2);
    catch
        % Skip if fzero fails
    end
end

disp(' ')
disp(['First critical value (pull-in): lambda = ', num2str(roots_found(1), '%.6f')])
disp(['Therefore: V_tilde_PI = lambda^2 = ', num2str(roots_found(1)^2, '%.6f')])

disp(' ')
disp('=== Analysis Complete ===')
