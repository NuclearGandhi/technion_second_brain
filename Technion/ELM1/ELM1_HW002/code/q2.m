% DC Motor with Series Excitation Calculations
% Given parameters
V = 220;        % Terminal voltage [V]
Ra = 0.6;       % Armature resistance [Ohm]
Rf = 0.4;       % Field resistance [Ohm]
nm = 300;       % Motor speed [rpm]
I = 25;         % Current [A]

% Convert speed from rpm to rad/s
omega_m = nm * 2 * pi / 60;

% Part a: Calculate back EMF and Ka*phi
Ea = V - I*(Ra + Rf);
Ka_phi = Ea / omega_m;

% Part b: Calculate developed torque
Td = Ka_phi * I;

% Part c: Calculate developed power
Pd = Td * omega_m;

% Part d: Calculate losses
Ploss = Rf*I^2 + Ra*I^2;

% Part e: Calculate efficiency
eta = Pd / (Pd + Ploss);

% Display results
fprintf('Back EMF (Ea): %.2f V\n', Ea);
fprintf('Ka*phi: %.4f V/(rad/s)\n', Ka_phi);
fprintf('Developed Torque (Td): %.2f N⋅m\n', Td);
fprintf('Developed Power (Pd): %.2f W\n', Pd);
fprintf('Total Losses: %.2f W\n', Ploss);
fprintf('Efficiency (η): %.2f%%\n', eta*100);
