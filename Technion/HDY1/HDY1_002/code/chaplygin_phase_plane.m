% Chaplygin's Sleigh Phase Plane Analysis
% This script plots the phase plane trajectories and equilibrium points
% for the Chaplygin's Sleigh nonholonomic system.

clear; close all; clc;

%% Parameters
m = 1.0;       % Mass [kg]
b = 0.5;       % Distance from CM to contact point [m]
Ic = 1;      % Moment of inertia [kg*m^2]

beta = (m*b) / (m*b^2 + Ic);

%% Grid Definition
u1_range = linspace(-3, 3, 25);
w_range = linspace(-3, 3, 25);
[U1, W] = meshgrid(u1_range, w_range);

%% Vector Field Calculation
% Equations of motion:
% dot_u1 = b * w^2
% dot_w = -beta * u1 * w

dU1 = b .* W.^2;
dW = -beta .* U1 .* W;

%% Plotting
figure('Color', 'w'); hold on; grid on;
set(gca, 'FontSize', 12);
xlabel('$u_1$ [m/s]', 'FontSize', 14, 'Interpreter', 'latex');
ylabel('$\omega$ [rad/s]', 'FontSize', 14, 'Interpreter', 'latex');
title('Phase Plane of Chaplygin''s Sleigh', 'FontSize', 16, 'Interpreter', 'latex');

% 1. Plot Trajectories (Energy Contours)
% T = 0.5 * (m*u1^2 + (m*b^2 + Ic)*w^2) = const
% These are ellipses.
u1_fine = linspace(-3, 3, 100);
w_fine = linspace(-3, 3, 100);
[U1_fine, W_fine] = meshgrid(u1_fine, w_fine);
Energy = 0.5 * (m * U1_fine.^2 + (m*b^2 + Ic) * W_fine.^2);

contour(U1_fine, W_fine, Energy, 15, 'LineWidth', 1.5, 'HandleVisibility', 'off');

% 2. Plot Vector Field
quiver(U1, W, dU1, dW, 'k', 'LineWidth', 1, 'HandleVisibility', 'off');

% 3. Plot Equilibrium Points (omega = 0)
% Stable equilibria: u1 > 0 (Solid Red)
plot([0, 2.5], [0, 0], 'r-', 'LineWidth', 3, 'DisplayName', 'Stable Equilibria');

% Unstable equilibria: u1 < 0 (Dashed Red)
plot([-2.5, 0], [0, 0], 'r--', 'LineWidth', 3, 'DisplayName', 'Unstable Equilibria');

legend('show', 'Location', 'southeast');

axis([-2.5 2.5 -2.5 2.5]);
axis square;
box on;

% Save figure
saveas(gcf, '../chaplygin_phase_plane.png');
disp('Plot generated and saved.');

