%% Part c

% Constants
D = 0.001; % Diameter in meters
k_f = 0.05; % Fluid thermal conductivity in W/m.K
k = 100; % Thermocouple thermal conductivity in W/m.K
Pr = 0.69; % Prandtl number
nu = 50e-6; % Kinematic viscosity in m^2/s
rho = 8920; % Density in kg/m^3
cp = 385; % Specific heat capacity in J/kg.K
T_inf = 1000; % Ambient temperature in K
T_c = 400; % Cold temperature in K
epsilon = 0.5; % Emissivity
sigma = 5.67e-8; % Stefan-Boltzmann constant

% Velocity range
V = linspace(1, 25, 100); % Velocity in m/s

% Calculate h and T for each velocity
h = zeros(size(V));
T = zeros(size(V));
for i = 1:length(V)
    Re_D = V(i) * D / nu;
    Nu_D = 2 + (0.4 * Re_D^0.5 + 0.06 * Re_D^0.67) * Pr^0.4;
    h(i) = Nu_D * k_f / D;
    % Solve for T using the steady-state energy balance equation
    syms T_sym
    eqn = h(i) * (T_sym - T_inf) + epsilon * sigma * (T_sym^4 - T_c^4) == 0;
    T_sol = vpasolve(eqn, T_sym, [0, T_inf]);
    T(i) = double(T_sol);
end

% Plot the results
figure;
plot(V, T, 'LineWidth', 2);
xlabel('$V$ (m/s)');
ylabel('$T$ (K)');
set(gca, 'units', 'pixels', 'position', [100, 100, 600, 400]);
grid on;
exportgraphics(gcf, 'q4_c.png', 'Resolution', 300);

%% Part d

V = 5; % Constant velocity in m/s

% Emissivity range
epsilon = linspace(0.1, 1, 100);

% Calculate h and T for each emissivity
h = zeros(size(epsilon));
T = zeros(size(epsilon));
Re_D = V * D / nu;
Nu_D = 2 + (0.4 * Re_D^0.5 + 0.06 * Re_D^0.67) * Pr^0.4;
h = Nu_D * k_f / D;
for i = 1:length(epsilon)
    % Solve for T using the steady-state energy balance equation
    syms T_sym
    eqn = h * (T_sym - T_inf) + epsilon(i) * sigma * (T_sym^4 - T_c^4) == 0;
    T_sol = vpasolve(eqn, T_sym, [0, T_inf]);
    T(i) = double(T_sol);
end

% Plot the results
figure;
plot(epsilon, T, 'LineWidth', 2);
xlabel('$\epsilon$');
ylabel('$T$ (K)');
set(gca, 'units', 'pixels', 'position', [100, 100, 600, 400]);
grid on;
exportgraphics(gcf, 'q4_d.png', 'Resolution', 300);

