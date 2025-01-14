% filepath: /c:/Users/Ido/Documents/Obsidian/quartz_fangia/content/Technion/DVI1/DVI1_007_code/q1.m
clc; close all; clear;

% Create a figure with three subplots side by side
figure;

for i = 1:3
    alpha = alpha_values(i);
    [t, y] = ode45(@(t, y) ode_func(t, y, alpha), tspan, initial_conditions);
    
    subplot(1, 3, i);
    plot(t, y(:, 1));
    title(['Response for \alpha = ', num2str(alpha)]);
    xlabel('Time');
    ylabel('Response y(t)');
end

set(gcf, 'Position', [100, 100, 1800, 400]);

% Save the figure
exportgraphics(gcf, 'time_domain_response.png', 'Resolution', 300);
