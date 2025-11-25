% Quick solution for Question 6
clear; clc;

% Characteristic equation for gamma=1
f = @(lam) (cos(lam)*cosh(lam) + 1) + lam*(cos(lam)*sinh(lam) - sin(lam)*cosh(lam));

% Find first root
lambda_PI = fzero(f, 2.0);
V_tilde_PI = lambda_PI^2;

% Write to file
fid = fopen('q6_result.txt', 'w');
fprintf(fid, 'lambda_PI = %.6f\n', lambda_PI);
fprintf(fid, 'V_tilde_PI = %.6f\n', V_tilde_PI);
fprintf(fid, 'f(lambda_PI) = %.2e\n', f(lambda_PI));
fclose(fid);

% Also display
fprintf('lambda_PI = %.6f\n', lambda_PI);
fprintf('V_tilde_PI = %.6f\n', V_tilde_PI);
