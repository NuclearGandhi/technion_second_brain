clc; clear; close all;

% Define the functions for the curves
Gamma1 = @(delta, epsilon) (2*cos(pi*sqrt(delta+epsilon)).*sin(pi*sqrt(delta-epsilon)) - ...
    (sqrt(delta+epsilon)./sqrt(delta-epsilon) + sqrt(delta-epsilon)./sqrt(delta+epsilon)).* ...
    cos(pi*sqrt(delta-epsilon)).*sin(pi*sqrt(delta+epsilon))).*sin(2*pi*sqrt(delta-epsilon)) + ...
    (2*cos(pi*sqrt(delta+epsilon)).*cos(pi*sqrt(delta-epsilon)) + ...
    (sqrt(delta+epsilon)./sqrt(delta-epsilon) + sqrt(delta-epsilon)./sqrt(delta+epsilon)).* ...
    sin(pi*sqrt(delta-epsilon)).*sin(pi*sqrt(delta+epsilon))).*cos(2*pi*sqrt(delta-epsilon)) - 2;

Gamma2 = @(delta, epsilon) (2*cos(pi*sqrt(delta+epsilon)).*sin(pi*sqrt(delta-epsilon)) - ...
    (sqrt(delta+epsilon)./sqrt(delta-epsilon) + sqrt(delta-epsilon)./sqrt(delta+epsilon)).* ...
    cos(pi*sqrt(delta-epsilon)).*sin(pi*sqrt(delta+epsilon))).*sin(2*pi*sqrt(delta-epsilon)) + ...
    (2*cos(pi*sqrt(delta+epsilon)).*cos(pi*sqrt(delta-epsilon)) + ...
    (sqrt(delta+epsilon)./sqrt(delta-epsilon) + sqrt(delta-epsilon)./sqrt(delta+epsilon)).* ...
    sin(pi*sqrt(delta-epsilon)).*sin(pi*sqrt(delta+epsilon))).*cos(2*pi*sqrt(delta-epsilon)) + 2;

% Plot the curves using fimplicit
plotcolors = get(gca, 'ColorOrder');

fimplicit(Gamma1, [0 3 0 1], 'LineWidth', 1.5, 'Color', plotcolors(1, :), 'MeshDensity', 600);
hold on;
fimplicit(Gamma2, [0 3 0 1], 'LineWidth', 1.5, 'Color', plotcolors(1, :), 'MeshDensity', 600);

% Plot 6 points with different colors
epsilon = 0.5;
delta_values = [0.25, 0.75, 1.05, 1.5, 2.27, 2.75];
for i = 1:length(delta_values)
    plot(delta_values(i), epsilon, 'o', 'MarkerSize', 8, 'MarkerEdgeColor', plotcolors(mod(i, size(plotcolors, 1)) + 1, :), 'MarkerFaceColor', plotcolors(mod(i, size(plotcolors, 1)) + 1, :));
end

xlabel('$\delta$', 'Interpreter', 'latex');
ylabel('$\epsilon$', 'Interpreter', 'latex');
title('Strutt Diagram', 'Interpreter', 'latex');
legend({'$\Gamma_1$', '$\Gamma_2$'}, 'Interpreter', 'latex');
grid on;
hold off;
set(gcf, 'Position', [100, 100, 600, 400]);

% Save the plot
exportgraphics(gcf, 'q1.png', 'Resolution', 300);

% Time domain response for the 6 points
figure;
tspan = linspace(0, 300, 1000);

T = 2 * pi;
u0 = [0.1; 0]; % Assuming initial displacement of 1 and initial velocity of 0


for i = 1:length(delta_values)
    delta = delta_values(i);
    k = @(t) (mod(t, T) <= T/2) * (delta + epsilon) + (mod(t, T) > T/2) * (delta - epsilon);
        % Define the ODE system
    ode_system = @(t, u) [u(2); -k(t) * u(1)];

    % Solve the ODE
    [t, u] = ode45(ode_system, tspan, u0);
    subplot(3, 2, i);
    plot(t, u, 'Color', plotcolors(mod(i, size(plotcolors, 1)) + 1, :), 'LineWidth', 1.5);
    xlabel('$t$', 'Interpreter', 'latex');
    ylabel('$u$', 'Interpreter', 'latex');
    title(['$\delta = ', num2str(delta), '$'], 'Interpreter', 'latex');
    grid on;
end

% Adjust figure size and save
set(gcf, 'Position', [100, 100, 600, 600]);
exportgraphics(gcf, 'q1_responses.png', 'Resolution', 300);