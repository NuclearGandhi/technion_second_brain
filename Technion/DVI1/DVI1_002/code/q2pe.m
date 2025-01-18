clc;
clear;
close all;

% Parameters
delta = 1;
beta = 0.1;
gamma = 0.01;

initial_conditions = [1, 0];
A0 = initial_conditions(1);

% Define the differential equation
dzdt = @(t, z) [z(2); 
                -delta * (z(1)^2 / (1 + z(1)^2)) * z(2) - (1 - beta / sqrt(1 + z(1)^2)) * z(1) - gamma];


z0 = initial_conditions;

% Time span
tspan = [0 100];

% Solve the differential equation
[t, z] = ode45(dzdt, tspan, z0);

% Calculate the amplitude envelope
A = @(tau) 2 * A0 ./ sqrt(delta * A0^2 * tau + 1);
envelope = A(t);

% Plot the response
figure;
plot(t, z(:, 1), 'DisplayName', 'Response');
hold on;
plot(t, envelope, '--', 'DisplayName', 'Amplitude Envelope');
xlabel('$\tau$');
ylabel('z($\tau$)');
title('Response and Amplitude Envelope');
legend;
grid on;

set(gcf, 'units', 'points', 'position', [250, 250 600 400]);
exportgraphics(gcf, 'graph_output/q2pe.png', 'Resolution', 300);    