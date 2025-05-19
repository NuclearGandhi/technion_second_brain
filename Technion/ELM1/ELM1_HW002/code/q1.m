% Solution for ELM1_HW002 Question 1
% Verification and completion of calculations from the provided markdown.

% --- Constants and Given Parameters ---
mu0 = 4*pi*1e-7; % Permeability of free space (H/m)
F_given = 204;   % Given force (N)
mu_r = 1273;     % Relative permeability of core material

% Dimensions:
% L_g from markdown (matches image)
% L_yoke, L_plunger from image (corrected from initial markdown interpretation)
L_g_md = 4e-3;      % Length of one air gap (m) from markdown/image (0.4cm = 4mm)
L_yoke_md = 0.2;    % Effective length of one side of the yoke (m) from image
L_plunger_md = 0.1; % Effective length of the plunger (m) from image

I_val = 2.5; % Given current (A)

A_c_val = (25e-3)^2;       % Cross-sectional area of the core (m^2)
A_f_val = (20e-3)*(25e-3); % Cross-sectional area of the plunger (m^2)

fprintf('--- Verification of Parameters (using image values for L_yoke, L_plunger) ---\n');
fprintf('mu0 = %e H/m\n', mu0);
fprintf('F_given = %d N\n', F_given);
fprintf('mu_r = %d\n', mu_r);
fprintf('L_g = %.3f m\n', L_g_md);
fprintf('L_yoke (image) = %.1f m\n', L_yoke_md);
fprintf('L_plunger (image) = %.1f m\n', L_plunger_md);
fprintf('A_c = %.2e m^2\n', A_c_val);
fprintf('A_f = %.2e m^2\n', A_f_val);
fprintf('I = %.1f A\n\n', I_val);

fprintf('--- Part A: Calculation of Flux (phi) ---\n');
% The agreed force formula is F = phi^2 / (mu0 * A_c)
% So, phi = sqrt(F * mu0 * A_c)

phi_calculated = sqrt(F_given * mu0 * A_c_val);
fprintf('Based on the agreed force formula F = phi^2 / (mu0 * A_c):\n');
fprintf('phi_calculated = sqrt(F_given * mu0 * A_c_val) = %.6e Wb\n', phi_calculated);

fprintf('\nFor subsequent calculations in Part B, phi_calculated = %.6e Wb will be used.\n', phi_calculated);

fprintf('\n--- Part B: Calculation of Number of Turns (N) ---\n');
% Reluctance components at x=0, using L_yoke_md, L_plunger_md from image.
% R_c = L_yoke_md / (mu_r * mu0 * A_c)
% R_g0 = L_g_md / (mu0 * A_c)  (for one gap at x=0)
% R_f = L_plunger_md / (mu_r * mu0 * A_f)
% R_T0 = 2*R_c + 2*R_g0 + R_f

R_c_calc = L_yoke_md / (mu_r * mu0 * A_c_val);
R_g0_calc = L_g_md / (mu0 * A_c_val); % Reluctance of one air gap at x=0
R_f_calc = L_plunger_md / (mu_r * mu0 * A_f_val);

R_T0_calc = R_c_calc + 2*R_g0_calc + R_f_calc;

fprintf('Calculated reluctance components (using image lengths L_yoke=%.1fm, L_plunger=%.1fm):\n', L_yoke_md, L_plunger_md);
fprintf('R_c (one side of yoke) = %.4e A-turns/Wb\n', R_c_calc);
fprintf('R_g0 (one air gap at x=0) = %.4e A-turns/Wb\n', R_g0_calc);
fprintf('R_f (plunger reluctance) = %.4e A-turns/Wb\n', R_f_calc);
fprintf('Total reluctance R_T(0) = 2*R_c + 2*R_g0 + R_f = %.4e A-turns/Wb\n', R_T0_calc);

% The formula for N in the markdown is N = I / (R_T(0) * phi), which is incorrect.
% The correct formula from phi = (N * I) / R_T(0) is N = (phi * R_T(0)) / I.
fprintf('\nThe number of turns N is given by the corrected formula: N = (phi * R_T(0)) / I.\n');

N_calc = (phi_calculated * R_T0_calc) / I_val;
fprintf('Using phi_calculated = %.6e Wb, R_T(0) = %.4e A-turns/Wb, and I = %.1f A:\n', phi_calculated, R_T0_calc, I_val);
fprintf('N = (phi_calculated * R_T(0)) / I = %.2f turns\n', N_calc);

fprintf('\n--- Summary for filling in the markdown (Part B) ---\n');
fprintf('1. The value for R_T(0) (using L_yoke=%.1f m, L_plunger=%.1f m from image) is %.4e A-turns/Wb.\n', L_yoke_md, L_plunger_md, R_T0_calc);
fprintf('2. The formula for N should be N = (phi * R_T(0)) / I.\n');
fprintf('3. Using phi_calculated = %.6e Wb, I = %.1f A, and reluctances based on L_yoke=%.1f m, L_plunger=%.1f m (from image), N = %.2f turns.\n', phi_calculated, I_val, L_yoke_md, L_plunger_md, N_calc);