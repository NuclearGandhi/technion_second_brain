clc; clear; close all;

%% Question 4

% Define the parameter lambda values
lambda_values = [0, 0.01, 0.05];
% Define the delta and epsilon values for the additional graph
delta_values = [2.3, 1.5];
epsilon_values = [0.7, 0.5];

% Create a figure with subplots
figure;
for i = 1:length(lambda_values)
    lambda = lambda_values(i);
    
    % Define the equations for Gamma_1 and Gamma_2 using \tilde{\delta}
    Gamma_1 = @(delta, epsilon) ...
        (2*cos(pi*sqrt(delta - lambda^2/4 + epsilon)).*sin(pi*sqrt(delta - lambda^2/4 - epsilon)) - ...
        (sqrt(delta - lambda^2/4 + epsilon)./sqrt(delta - lambda^2/4 - epsilon) + sqrt(delta - lambda^2/4 - epsilon)./sqrt(delta - lambda^2/4 + epsilon)).* ...
        cos(pi*sqrt(delta - lambda^2/4 - epsilon)).*sin(pi*sqrt(delta - lambda^2/4 + epsilon))).* ...
        sin(2*pi*sqrt(delta - lambda^2/4 - epsilon)) + ...
        (2*cos(pi*sqrt(delta - lambda^2/4 + epsilon)).*cos(pi*sqrt(delta - lambda^2/4 - epsilon)) + ...
        (sqrt(delta - lambda^2/4 + epsilon)./sqrt(delta - lambda^2/4 - epsilon) + sqrt(delta - lambda^2/4 - epsilon)./sqrt(delta - lambda^2/4 + epsilon)).* ...
        sin(pi*sqrt(delta - lambda^2/4 - epsilon)).*sin(pi*sqrt(delta - lambda^2/4 + epsilon))).* ...
        cos(2*pi*sqrt(delta - lambda^2/4 - epsilon)) - (1+exp(lambda*2*pi)) ./ (exp(lambda*pi) );

    Gamma_2 = @(delta, epsilon) ...
        (2*cos(pi*sqrt(delta - lambda^2/4 + epsilon)).*sin(pi*sqrt(delta - lambda^2/4 - epsilon)) - ...
        (sqrt(delta - lambda^2/4 + epsilon)./sqrt(delta - lambda^2/4 - epsilon) + sqrt(delta - lambda^2/4 - epsilon)./sqrt(delta - lambda^2/4 + epsilon)).* ...
        cos(pi*sqrt(delta - lambda^2/4 - epsilon)).*sin(pi*sqrt(delta - lambda^2/4 + epsilon))).* ...
        sin(2*pi*sqrt(delta - lambda^2/4 - epsilon)) + ...
        (2*cos(pi*sqrt(delta - lambda^2/4 + epsilon)).*cos(pi*sqrt(delta - lambda^2/4 - epsilon)) + ...
        (sqrt(delta - lambda^2/4 + epsilon)./sqrt(delta - lambda^2/4 - epsilon) + sqrt(delta - lambda^2/4 - epsilon)./sqrt(delta - lambda^2/4 + epsilon)).* ...
        sin(pi*sqrt(delta - lambda^2/4 - epsilon)).*sin(pi*sqrt(delta - lambda^2/4 + epsilon))).* ...
        cos(2*pi*sqrt(delta - lambda^2/4 - epsilon)) + (1+exp(lambda*2*pi)) ./ (exp(lambda*pi) );

    % Create a subplot for each lambda
    subplot(1, length(lambda_values), i);
    % Plot the curves using fimplicit
    plotcolors = get(gca, 'ColorOrder');

    fimplicit(Gamma_1, [0 3 0 2], 'LineWidth', 1.5, 'Color', plotcolors(1, :), 'MeshDensity', 600);
    hold on;
    fimplicit(Gamma_2, [0 3 0 2], 'LineWidth', 1.5, 'Color', plotcolors(1, :), 'MeshDensity', 600);
    hold off;

    % Only to the first graph, add two points of interest
    if i == 1
        hold on;
        plot(delta_values(1), epsilon_values(1), 'o', 'MarkerSize', 8, 'MarkerEdgeColor', plotcolors(2, :), 'MarkerFaceColor', plotcolors(2, :));
        plot(delta_values(2), epsilon_values(2), 'o', 'MarkerSize', 8, 'MarkerEdgeColor', plotcolors(3, :), 'MarkerFaceColor', plotcolors(3, :));
        hold off;
    end

    % Add labels and title
    xlabel('$\delta$');
    ylabel('$\varepsilon$');
    title(['$\lambda = ', num2str(lambda), '$']);
    grid on;

    set(gcf, 'Units', 'pixels', 'Position', [300, 300, 1200, 400]); % Set figure size and position
end

% Add a main title for the figure
sgtitle('Unstable Boundary Lines of the Parametric Resonance System');
exportgraphics(gcf, 'q4.png', 'Resolution', 300);

%% Question 5

T = 2 * pi;

% Define the time vector
tau = linspace(0, 15 * T, 1000);

% Create a figure with subplots
figure;
for j = 1:length(delta_values)
    delta = delta_values(j);
    epsilon = epsilon_values(j);

    % Define the piecewise function k(tau)
    k = @(tau) (mod(tau, T) <= T/2) * (delta + epsilon) + (mod(tau, T) > T/2) * (delta - epsilon);

    % Define the ODE system
    ode_system = @(t, u) [u(2); -k(t) * u(1)];

    % Initial conditions
    u0 = [0.1; 0]; % Assuming initial displacement of 1 and initial velocity of 0

    % Solve the ODE
    [t, u] = ode45(ode_system, tau, u0);

    % Create a subplot for each delta and epsilon
    subplot(1, length(delta_values), j);
    plot(t, u(:, 1), 'LineWidth', 1.5, 'Color', plotcolors(1 + j, :));
    xlabel('$\tau$');
    ylabel('$u(\tau)$');
    title(['$\epsilon = ', num2str(epsilon), '$ and $\delta = ', num2str(delta), '$']);
    grid on;

    % Remove scientific notation from y-axis
    ax = gca;
    ax.YAxis.Exponent = 0;
    ytickformat('%.2f'); % Adjust the format as needed
end

% Set figure size and position
set(gcf, 'Units', 'pixels', 'Position', [300, 300, 1200, 400]);

% Add a main title for the figure
sgtitle('Response of $u$ in terms of $\tau$ for different $\epsilon$ and $\delta$ values');
exportgraphics(gcf, 'q5.png', 'Resolution', 300);
