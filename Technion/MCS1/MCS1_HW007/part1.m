close all;
clear;
clc;

%% Material Properties - PZT-5A (from equation 9.9)
% Stiffness matrix elements [Pa]
c_E_11 = 120.3e9;
c_E_12 = 75.18e9;
c_E_13 = 75.09e9;
c_E_33 = 110.8e9;
c_E_44 = 21.52e9;
c_E_66 = 22.57e9;

% Piezoelectric coupling coefficients [C/m^2]
e_31 = -5.351;
e_33 = 15.78;
e_15 = 12.29;

% Permittivity at constant strain [F/m]
eps_0 = 8.85e-12;  % vacuum permittivity
varepsilon_S_11 = 919.1 * eps_0;
varepsilon_S_33 = 826.6 * eps_0;

% Layer thickness [m]
h = 2e-6;

%% Applied Load
T_3_applied = -0.1e6;  % Applied pressure [Pa] (compression)

%% Question 1: Open Circuit Voltage
fprintf('=== Question 1: Open Circuit Voltage ===\n\n');

% Stiffened stiffness for open circuit
c_E_33_bar_open = c_E_33 + e_33^2 / varepsilon_S_33;
fprintf('Stiffened stiffness c_E_33_bar = c_E_33 + e_33^2/eps_S_33\n');
fprintf('  = %.3e + (%.3f)^2 / %.3e\n', c_E_33, e_33, varepsilon_S_33);
fprintf('  = %.4e Pa = %.2f GPa\n\n', c_E_33_bar_open, c_E_33_bar_open/1e9);

S_3_open = T_3_applied / c_E_33_bar_open;
fprintf('Strain S_3 = T_3 / c_E_33_bar\n');
fprintf('  = %.3e / %.4e\n', T_3_applied, c_E_33_bar_open);
fprintf('  = %.6e\n\n', S_3_open);

E_3_open = -(e_33 / varepsilon_S_33) * S_3_open;
fprintf('Electric field E_3 = -(e_33/eps_S_33) * S_3\n');
fprintf('  = -(%.3f / %.3e) * %.6e\n', e_33, varepsilon_S_33, S_3_open);
fprintf('  = %.4e V/m\n\n', E_3_open);

% Voltage across the layer
V_open = -E_3_open * h;
fprintf('Voltage V = -E_3 * h\n');
fprintf('  = -%.4e * %.3e\n', E_3_open, h);
fprintf('  = %.6e V = %.4f mV\n\n', V_open, V_open*1000);

% Verify D_3 = 0
D_3_verify = e_33 * S_3_open + varepsilon_S_33 * E_3_open;
fprintf('Verification: D_3 = e_33*S_3 + eps_S_33*E_3 = %.3e C/m^2 (should be ~0)\n\n', D_3_verify);

%% Question 2: Apparent Stiffness (Open Circuit)
fprintf('=== Question 2: Apparent Stiffness (Open Circuit) ===\n\n');
fprintf('c_E_33_bar = %.4e Pa = %.2f GPa\n\n', c_E_33_bar_open, c_E_33_bar_open/1e9);

%% Question 3: Poisson Response
fprintf('=== Question 3: Poisson Response ===\n\n');
fprintf('In plane strain: S_1 = S_2 = 0 (by constraint)\n\n');

%% Question 4: Apparent Stiffness (Short Circuit)
fprintf('=== Question 4: Apparent Stiffness (Short Circuit) ===\n\n');

% For short circuit: E_3 = 0
c_E_33_bar_short = c_E_33;
fprintf('For short circuit (E_3 = 0):\n');
fprintf('  c_E_33_bar = c_E_33 = %.4e Pa = %.2f GPa\n\n', c_E_33_bar_short, c_E_33_bar_short/1e9);

S_3_short = T_3_applied / c_E_33_bar_short;
fprintf('Strain S_3 = T_3 / c_E_33 = %.6e\n\n', S_3_short);

%% Question 5: Charge Transfer (Short Circuit)
fprintf('=== Question 5: Charge Transfer (Short Circuit) ===\n\n');

% For short circuit: E_3 = 0
D_3_short = e_33 * S_3_short;
fprintf('D_3 = e_33 * S_3 (since E_3 = 0)\n');
fprintf('  = %.3f * %.6e\n', e_33, S_3_short);
fprintf('  = %.6e C/m^2\n\n', D_3_short);

%% Question 6: Electromechanical Coupling Factor (Pressure Loading)
fprintf('=== Question 6: Electromechanical Coupling Factor (Pressure) ===\n\n');

% For plane strain with open circuit:
% Input mechanical energy density: (1/2) * T_3 * S_3 = (1/2) * T_3^2 / c_bar
% Stored electrical energy density: (1/2) * eps_S_33 * E_3^2

% Using S_3 and E_3 from open circuit case
U_mech_input = 0.5 * T_3_applied * S_3_open;  % Note: T_3 * S_3 is negative (compression)
U_elec_stored = 0.5 * varepsilon_S_33 * E_3_open^2;

fprintf('Input mechanical energy density: U_mech = (1/2)*T_3*S_3 = %.6e J/m^3\n', U_mech_input);
fprintf('Stored electrical energy density: U_elec = (1/2)*eps_S_33*E_3^2 = %.6e J/m^3\n\n', U_elec_stored);

% k^2 = |U_elec / U_mech|
k_squared = abs(U_elec_stored / U_mech_input);
k = sqrt(k_squared);
fprintf('k^2 = |U_elec / U_mech| = %.6f\n', k_squared);
fprintf('k = %.4f\n\n', k);

% Alternative formula: k^2 = e_33^2 / (c_E_33 * eps_S_33 + e_33^2) for plane strain
k_squared_formula = e_33^2 / (c_E_33 * varepsilon_S_33 + e_33^2);
fprintf('Alternative formula: k^2 = e_33^2 / (c_E_33*eps_S_33 + e_33^2) = %.6f\n', k_squared_formula);
fprintf('(Should match the energy ratio)\n\n');

%% Question 7: Strain from Applied Voltage
fprintf('=== Question 7: Strain from Applied Voltage (1V) ===\n\n');

V_applied = 1;  % [V]
E_3_voltage = -V_applied / h;
fprintf('Applied voltage: V = %.1f V\n', V_applied);
fprintf('Electric field: E_3 = -V/h = %.4e V/m\n\n', E_3_voltage);

% For plane strain with T_3 = 0 (no external mechanical load):
% T_3 = c_E_33 * S_3 - e_33 * E_3 = 0
% => S_3 = e_33 * E_3 / c_E_33
S_3_voltage = (e_33 / c_E_33) * E_3_voltage;
fprintf('With T_3 = 0 (no external load):\n');
fprintf('  S_3 = (e_33/c_E_33) * E_3\n');
fprintf('  = (%.3f / %.4e) * %.4e\n', e_33, c_E_33, E_3_voltage);
fprintf('  = %.6e\n\n', S_3_voltage);

% Physical displacement
delta_h = S_3_voltage * h;
fprintf('Thickness change: delta_h = S_3 * h = %.4e m = %.4f nm\n\n', delta_h, delta_h*1e9);

%% Question 8: Charge from Applied Voltage
fprintf('=== Question 8: Charge from Applied Voltage ===\n\n');

D_3_voltage = e_33 * S_3_voltage + varepsilon_S_33 * E_3_voltage;
fprintf('D_3 = e_33*S_3 + eps_S_33*E_3\n');
fprintf('  = %.3f * %.6e + %.4e * %.4e\n', e_33, S_3_voltage, varepsilon_S_33, E_3_voltage);

% Show individual terms
term1 = e_33 * S_3_voltage;
term2 = varepsilon_S_33 * E_3_voltage;
fprintf('  = %.6e + %.6e\n', term1, term2);
fprintf('  = %.6e C/m^2\n\n', D_3_voltage);

%% Question 9: Electromechanical Coupling Factor (Voltage Loading)
fprintf('=== Question 9: Electromechanical Coupling Factor (Voltage) ===\n\n');

% Input electrical energy density: (1/2) * D_3 * E_3 = (1/2) * eps_eff * E_3^2
% Stored mechanical energy density: (1/2) * T_3 * S_3 (but T_3 = 0 externally)

% For plane strain, the strain energy is stored against the stiffness
% U_mech = (1/2) * c_E_33 * S_3^2 (since T_1, T_2 are reactive and S_1=S_2=0)
U_mech_stored = 0.5 * c_E_33 * S_3_voltage^2;
U_elec_input = 0.5 * abs(D_3_voltage * E_3_voltage);

fprintf('Input electrical energy density: U_elec = (1/2)*|D_3*E_3| = %.6e J/m^3\n', U_elec_input);
fprintf('Stored mechanical energy density: U_mech = (1/2)*c_E_33*S_3^2 = %.6e J/m^3\n\n', U_mech_stored);

k_squared_voltage = U_mech_stored / U_elec_input;
k_voltage = sqrt(k_squared_voltage);
fprintf('k^2 = U_mech / U_elec = %.6f\n', k_squared_voltage);
fprintf('k = %.4f\n\n', k_voltage);

%% Summary
fprintf('=== SUMMARY ===\n\n');
fprintf('Q1: Voltage (open circuit)     = %.4f mV\n', V_open*1000);
fprintf('Q2: Stiffness (open circuit)   = %.2f GPa\n', c_E_33_bar_open/1e9);
fprintf('Q3: S_1 = S_2 = 0 (plane strain constraint)\n');
fprintf('Q4: Stiffness (short circuit)  = %.2f GPa\n', c_E_33_bar_short/1e9);
fprintf('Q5: D_3 (short circuit)        = %.4e C/m^2\n', D_3_short);
fprintf('Q6: k^2 (pressure loading)     = %.4f, k = %.4f\n', k_squared, k);
fprintf('Q7: S_3 (1V applied)           = %.4e\n', S_3_voltage);
fprintf('Q8: D_3 (1V applied)           = %.4e C/m^2\n', D_3_voltage);
fprintf('Q9: k^2 (voltage loading)      = %.4f, k = %.4f\n', k_squared_voltage, k_voltage);
