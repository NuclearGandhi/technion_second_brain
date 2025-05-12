% Script to calculate Ktg and its error for specific values of d and H.
% Formula for Ktg:
% Ktg = 0.284 + 2*(1 - d/H)^(-1) - 0.6*(1 - d/H) + 1.32*(1 - d/H)^2

clearvars;
clc;

% Given values
H_val = 48;         % mm
delta_H_val = 0.1;  % mm
d_val = 14;         % mm
delta_d_val = 0.1;  % mm

% Ensure inputs are treated as floating point numbers for calculations
H = double(H_val);
delta_H = double(delta_H_val);
d = double(d_val);
delta_d = double(delta_d_val);

% Define X for simplicity
X = 1 - d/H;

% Calculate Ktg
Ktg = 0.284 + 2*X^(-1) - 0.6*X + 1.32*X^2;

% Calculate partial derivative of Ktg with respect to X
dKtg_dX = -2*X^(-2) - 0.6 + 2.64*X;

% Calculate partial derivatives of X with respect to d and H
dX_dd = -1/H;
dX_dH = d/H^2;

% Calculate partial derivative of Ktg with respect to d
dKtg_dd = dKtg_dX * dX_dd;

% Calculate partial derivative of Ktg with respect to H
dKtg_dH = dKtg_dX * dX_dH;

% Calculate squared error components
err_comp_d_squared = (dKtg_dd * delta_d)^2;
err_comp_H_squared = (dKtg_dH * delta_H)^2;

% Calculate total error in Ktg
delta_Ktg = sqrt(err_comp_d_squared + err_comp_H_squared);

% Display the results
fprintf('Given values:\n');
fprintf('H = %.1f +/- %.1f mm\n', H_val, delta_H_val);
fprintf('d = %.1f +/- %.1f mm\n', d_val, delta_d_val);
fprintf('\nCalculated values:\n');
fprintf('Ktg = %.4f\n', Ktg);
fprintf('delta_Ktg = %.4f\n', delta_Ktg);
fprintf('Ktg = %.4f +/- %.4f\n', Ktg, delta_Ktg);

% Calculate Student's t-test (η) to compare experimental results with the theoretical value
% η = |K_theo - K_result| / sqrt((δK_theo)^2 + (δK_result)^2)

% Experimental values from the lab report
K_DIC = 1.6842;
delta_K_DIC = 0.0017;

K_PE = 2.0625;
delta_K_PE = 0.8104;

K_SG = 1.5530;
delta_K_SG = 0.0220;

% Calculate η for each experimental method compared to K_tg
eta_DIC = abs(Ktg - K_DIC) / sqrt(delta_Ktg^2 + delta_K_DIC^2);
eta_PE = abs(Ktg - K_PE) / sqrt(delta_Ktg^2 + delta_K_PE^2);
eta_SG = abs(Ktg - K_SG) / sqrt(delta_Ktg^2 + delta_K_SG^2);

fprintf('\nStudent''s t-test (η) results:\n');
fprintf('η(DIC) = %.4f\n', eta_DIC);
fprintf('η(PE)  = %.4f\n', eta_PE);
fprintf('η(SG)  = %.4f\n', eta_SG);

% Interpretation guidance
fprintf('\nInterpretation:\n');
fprintf('- η > 2 indicates statistically significant difference\n');
fprintf('- η < 2 suggests measurements are consistent within error margins\n');

% Example from a known source if available to verify (replace with actual values)
% For d/H = 0.5 (X=0.5)
% Ktg_expected = 0.284 + 2*(0.5)^(-1) - 0.6*(0.5) + 1.32*(0.5)^2
% Ktg_expected = 0.284 + 4 - 0.3 + 1.32*0.25
% Ktg_expected = 0.284 + 4 - 0.3 + 0.33 = 4.314
% To test with d/H = 0.5, you could set:
% H_test = 20; delta_H_test = 0; d_test = 10; delta_d_test = 0;
% And re-run the calculation section or adapt it into a function for easy testing.
