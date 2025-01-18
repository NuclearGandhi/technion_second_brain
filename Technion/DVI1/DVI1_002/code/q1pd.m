clc;
clear;
close all;

% Define the differential equation
function dydt = pendulum_system(t, y, gamma)
    theta = y(1);
    theta_dot = y(2);
    dtheta_dt = theta_dot;
    dtheta_dot_dt = -sin(theta) + gamma^2 * sin(2 * theta);
    dydt = [dtheta_dt; dtheta_dot_dt];
end

% Find equilibrium points
function equilibrium_points = find_equilibrium_points(gamma)
    theta_vals = linspace(-2*pi, 2*pi, 1000);
    equilibrium_points = [];
    for theta = theta_vals
        if abs(sin(theta) - gamma^2 * sin(2*theta)) < 1e-2
            equilibrium_points = [equilibrium_points, theta];
        end
    end
end

% Plot the equilibrium points and system behavior
function plot_system_behavior(gamma_values)
    t_span = [0, 100];
    initial_conditions = [(-10:10)' * pi/4, zeros(21, 1); ...
                          -2*pi * ones(10, 1), (2 + (1:10)' * 0.2); ...
                          2*pi * ones(10, 1), -(2 + (1:10)' * 0.2)];
    

    colorOrder = get(gca, 'colororder');
    for i = 1:length(gamma_values)
        gamma = gamma_values(i);
        subplot(length(gamma_values), 1, i);
        hold on;
        for j = 1:size(initial_conditions, 1)
            y0 = initial_conditions(j, :);
            [t, z] = ode45(@(t, y) pendulum_system(t, y, gamma), t_span, y0);
            plot(z(:, 1), z(:, 2), ...
             "Color", colorOrder(1, :), ...
             "DisplayName", "Trajectory");
        end

        equilibrium_points = find_equilibrium_points(gamma);
        plot(equilibrium_points, 0, ...
            "Color", colorOrder(2, :), ...
            "Marker", "o", ...
            "LineStyle", "none", ...
            "DisplayName", "Equilibrium points");

        title(['Phase plot for $\gamma$ = ', num2str(gamma)]);
        xlabel('$\theta$');
        ylabel('$\theta$''');
        axis equal;
        xlim([-2*pi, 2*pi]);
        ylim([-3, 3]);
        legendUnq;
        legend;
        hold off;
    end

    set(gcf, 'units', 'pixels', 'position', [0, 0 600 600]);

    exportgraphics(gcf, 'graph_output/q1pd.png', ...
        'Resolution', 300);
end

% Define gamma values to visualize
gamma_values = [0.2, 1.0];

% Plot the system behavior for different gamma values
plot_system_behavior(gamma_values);
