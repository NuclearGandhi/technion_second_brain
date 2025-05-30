% DC Motor with Series Excitation Calculations

% Given parameters from Markdown Question 2
V = 220;        % Terminal voltage [V]
Ra = 0.6;       % Armature resistance [Ohm]
Rfw = 0.4;      % Field winding resistance (R_fw) [Ohm]
nm = 300;       % Motor speed [rpm]
I = 25;         % Current [A]

% Convert speed from rpm to rad/s
omega_m = nm * 2 * pi / 60; % Initial angular speed

% --- Calculations for Initial Conditions (Markdown Q2, Parts a-d) ---

% Part a (Markdown): Back EMF (Ea) and Ka*phi
Ea = V - I*(Ra + Rfw); % Ea = V_s - I*(R_a + R_fw)
Ka_phi = Ea / omega_m;   % Ka*phi = Ea / omega_m

% Part b (Markdown): Developed Torque (Td_original)
Td_original = Ka_phi * I; % Td = Ka*phi * I

% Part a (Markdown): Developed Power (Pd_original)
% Pd = Td * omega_m, which is also Ea * I
Pd_original = Td_original * omega_m;

% Part c (Markdown): Losses (Ploss_initial)
% Ploss = I^2 * (R_a + R_fw)
Ploss_initial = Rfw*I^2 + Ra*I^2;

% Part d (Markdown): Efficiency (eta_initial)
% eta = Pd_original / (Pd_original + Ploss_initial)
eta_initial = Pd_original / (Pd_original + Ploss_initial);

% --- Calculations for New Conditions (Markdown Q2, Parts e-f) ---

% Part e (Markdown): Calculate External Field Resistance (R_fx)
% Given P_d_new = (8/27) * Pd_original
% R_fx = (V_s / I) - (R_a + R_fw) - (8/27) * (Pd_original / I^2)
Rfx = (V / I) - (Ra + Rfw) - (8/27) * (Pd_original / (I^2));

% Part f (Markdown): Calculate New Developed Power (Pd_new)
% P_d_new = (8/27) * Pd_original
Pd_new = (8/27) * Pd_original;

% --- Display Results ---
fprintf('--- Initial Conditions (Corresponds to Markdown Q2, Parts a-d)---');
fprintf('Back EMF (Ea): %.2f V', Ea);
fprintf('Ka*phi: %.4f V/(rad/s)', Ka_phi);
fprintf('Developed Torque (Td_original): %.2f N⋅m', Td_original);
fprintf('Developed Power (Pd_original): %.2f W', Pd_original);
fprintf('Total Initial Losses (Ploss_initial): %.2f W', Ploss_initial);
fprintf('Initial Efficiency (η_initial): %.2f%%', eta_initial*100);

fprintf('--- New Conditions (Corresponds to Markdown Q2, Parts e-f) ---');
fprintf('External Field Resistance (R_fx): %.2f Ohm', Rfx);
fprintf('New Developed Power (Pd_new): %.2f W', Pd_new);
