clc; close all; clear;


% Define the dynamics of the undamped system
dynamics = @(t, phi, alpha) [phi(2);
    (-3+alpha) * phi(1) + (2-alpha) * phi(3);
    phi(4);
    (5 - alpha) * phi(1) + (-4 + alpha) * phi(3)];

% Create a figure with three subplots side by side

f_values = [3, 2.7, -3];
alpha_values = 3.5 - 0.5 * f_values;

plot_titles_f = {'$f > 2\sqrt{2}$', '$f < 2\sqrt{2}$', '$f < -2\sqrt{2}$'};

tspans = {[0, 100], [0,100], [0, 10]};
initial_conditions = [1, 0, -1, 0];

figure;
for i = 1:3
    alpha = alpha_values(i);
    [t, phi] = ode45(@(t, phi) dynamics(t, phi, alpha), tspans{i}, initial_conditions);

    for j = 1:2
        subplot(2, 3, i + 3 * (j - 1));
        if j == 1
            plot(t, phi(:, 1));
        else
            plot(t, phi(:, 3));
        end
        xlabel('$t$');
        ylabel(['$\varphi_', num2str(j), '$'], 'Interpreter', 'latex');
        if j == 1
            title(['Response for ', plot_titles_f{i}], 'Interpreter', 'latex');
        end
    end
end

set(gcf, 'Units', 'pixels', 'Position', [100, 100, 1400, 400]);

% Save the figure
exportgraphics(gcf, 'time_domain_response.png', 'Resolution', 300);