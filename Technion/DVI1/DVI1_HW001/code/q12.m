clc;
clear;


%% B

% Define constants
c1 = 0.1; % Example value for c1
c3 = 0.001; % Example value for c3
k = 4;
l0 = 5;
a = 1;
m = 1;
x_eq = 6.162;

% Define the range for Omega
Omega = linspace(0.1, 4, 1000);

% Calculate k_eq
k_eq = k * (1 - l0 / sqrt(a^2 + x_eq^2));

omega_n = sqrt(k_eq / m);

A = ones(size(Omega)); 

% Iterate to solve for A and delta
c_eq = c1 + (3/4) * c3 * Omega.^2 .* A.^2;
delta = c_eq ./ (omega_n^2 * m);
A = sqrt(1 ./ ((1 - Omega.^2).^2 + (delta .* Omega).^2));
% Copy A
A_analytical = A; 
% Plot |A| as a function of Omega
figure;
plot(Omega, A, 'LineWidth', 2);
xlabel('Omega');
ylabel('|A|');
title('Plot of |A| as a function of Omega');
grid on;

%% C

% Define constants
M0_values = [0.1, 10];
omega_values = [0.1 * omega_n, 5 * omega_n];
num_cycles = 100;

% Initialize cell array to store the last 10 cycles
last_10_cycles = cell(length(M0_values), length(omega_values));

% Define the differential equation
differential_eq = @(t, y, M0, omega) [
    y(2);
    (M0 * cos(omega * t) * a / (a^2 + x_eq^2) - c1 * y(2) - c3 * y(2)^3 - k * y(1) * (1 - l0 / sqrt(a^2 + x_eq^2))) / m
];

% Solve the differential equation for each combination of M0 and omega
figure;
for i = 1:length(M0_values)
    for j = 1:length(omega_values)
        M0 = M0_values(i);
        omega = omega_values(j);
        
        % Define the time span for 100 cycles of the input frequency
        tspan = linspace(0, 2 * pi * num_cycles / omega, 1000);

        % Initial conditions [x(0), x_dot(0)]
        y0 = [0.1, 0];
        
        % Solve the differential equation
        [t, y] = ode45(@(t, y) differential_eq(t, y, M0, omega), tspan, y0);
        
        % Save the time and x of the last 10 cycles
        last_10_cycles{i, j} = [t(end - 10 * length(t) / num_cycles + 1:end, :), y(end - 10 * length(t) / num_cycles + 1:end, :)];
        
        % Plot the results
        subplot(length(M0_values), length(omega_values), (i-1)*length(omega_values) + j);
        plot(t, y(:, 1), 'LineWidth', 2);
        xlabel('Time (s)');
        ylabel('Displacement (x)');
        title(['M0 = ', num2str(M0), ', \omega = ', num2str(omega)]);
        grid on;
    end
end

%% D

figure;
for i = 1:length(M0_values)
    for j = 1:length(omega_values)
        omega = omega_values(j);
        data = last_10_cycles{i, j};
        t_last_10 = data(:, 1);
        x_last_10 = data(:, 2);
        
        % Normalize x_last_10
        x_norm = (x_last_10 - mean(x_last_10)) / std(x_last_10);
        
        % Function to fit the data to a sinusoidal curve using lsqcurvefit
        residuals = @(params) x_norm - params(1) * cos(omega * t_last_10 - params(2));
        fit_sinusoid = lsqnonlin(residuals, [0.0001, pi/2], [0, -pi], [Inf, pi], optimset('Display', 'none'));

        % Generate the fitted curve
        fitted_curve = fit_sinusoid(1) * std(x_last_10) * cos(omega * t_last_10 - fit_sinusoid(2));
        
        % Plot the last 10 cycles and the fitted curve
        subplot(length(M0_values), length(omega_values), (i-1)*length(omega_values) + j);
        plot(t_last_10, x_last_10, 'LineWidth', 2);
        hold on;
        plot(t_last_10, fitted_curve, 'r--');
        xlabel('Time (s)');
        ylabel('Displacement (x)');
        title(['M0 = ', num2str(M0_values(i)), ', \omega = ', num2str(omega)]);
        legend('Last 10 cycles', 'Fitted curve');
        grid on;
        hold off;
        
        % Print the parameters
        fprintf('For M0 = %.2f and omega = %.2f:\n', M0_values(i), omega);
        fprintf('Amplitude: %f\n', fit_sinusoid(1));
        fprintf('Phase: %f\n', rad2deg(fit_sinusoid(2)));
    end
end

%% E
% Define the range for Omega
Omega = linspace(0.1, 4, 1000);

% Initialize array to store the amplitude in steady state
A_steady_state = zeros(size(Omega));
M_0 = @(F)(F * m * omega_n^2 * (x_eq^2 + a^2)) / a;

% Solve the differential equation for each Omega
for i = 1:length(Omega)
    omega = Omega(i) * omega_n;
    M0 = M_0(1); % Assuming F is 1 for simplicity
    num_cycles = 300;
    tspan = linspace(0, 2 * pi * num_cycles / omega, 1000);
    y0 = [0.0, 0]; % Initial conditions [x(0), x_dot(0)]
    
    % Solve the differential equation
    [t, y] = ode45(@(t, y) differential_eq(t, y, M0, omega), tspan, y0);
    
    % Measure the amplitude in the last 10 cycles
    last_10_cycles = y(end - 10 * length(t) / num_cycles + 1:end, 1);
    A_steady_state(i) = max(last_10_cycles);
end

% Plot the amplitude in steady state A and Omega
% Plot the amplitude in steady state A and Omega
figure;
plot(Omega, A_steady_state, 'LineWidth', 2);
hold on;
plot(Omega, A_analytical, '--', 'LineWidth', 2, 'Color', [0.8500, 0.3250, 0.0980]); % Default orange color
xlabel('\Omega');
ylabel('Amplitude in steady state A');
title('Amplitude in steady state A vs \Omega');
legend('Numerical', 'Analytical');
grid on;
hold off;