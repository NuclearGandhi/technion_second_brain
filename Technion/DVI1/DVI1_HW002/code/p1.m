clc; clear; close all;

%% Question 4

% Define the parameter lambda values
lambda_values = [0, 0.01, 0.05];

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
        cos(2*pi*sqrt(delta - lambda^2/4 - epsilon)) - 2;

    Gamma_2 = @(delta, epsilon) ...
        (2*cos(pi*sqrt(delta - lambda^2/4 + epsilon)).*sin(pi*sqrt(delta - lambda^2/4 - epsilon)) - ...
        (sqrt(delta - lambda^2/4 + epsilon)./sqrt(delta - lambda^2/4 - epsilon) + sqrt(delta - lambda^2/4 - epsilon)./sqrt(delta - lambda^2/4 + epsilon)).* ...
        cos(pi*sqrt(delta - lambda^2/4 - epsilon)).*sin(pi*sqrt(delta - lambda^2/4 + epsilon))).* ...
        sin(2*pi*sqrt(delta - lambda^2/4 - epsilon)) + ...
        (2*cos(pi*sqrt(delta - lambda^2/4 + epsilon)).*cos(pi*sqrt(delta - lambda^2/4 - epsilon)) + ...
        (sqrt(delta - lambda^2/4 + epsilon)./sqrt(delta - lambda^2/4 - epsilon) + sqrt(delta - lambda^2/4 - epsilon)./sqrt(delta - lambda^2/4 + epsilon)).* ...
        sin(pi*sqrt(delta - lambda^2/4 - epsilon)).*sin(pi*sqrt(delta - lambda^2/4 + epsilon))).* ...
        cos(2*pi*sqrt(delta - lambda^2/4 - epsilon)) + 2;

    % Create a subplot for each lambda
    subplot(1, length(lambda_values), i);
    % Plot the implicit functions
    fimplicit(Gamma_1, [0 3 0 2], 'LineWidth', 1.5);
    hold on;
    fimplicit(Gamma_2, [0 3 0 2], 'LineWidth', 1.5);
    hold off;

    % Add labels and title
    xlabel('$\delta$');
    ylabel('$\varepsilon$');
    title(['$\lambda = ', num2str(lambda), '$']);
    legend('$\Gamma_1$', '$\Gamma_2$');
    grid on;

    set(gcf, 'Units', 'pixels', 'Position', [300, 300, 1200, 400]); % Set figure size and position
end

% Add a main title for the figure
sgtitle('Unstable Boundary Lines of the Parametric Resonance System');
exportgraphics(gcf, 'q4.png', 'Resolution', 300);

%% Question 5

% Define the delta and epsilon values for the additional graph
delta_values = [9/4, 1.5];
epsilon_values = [0.7, 0.5];

T = 2 * pi;

% Define the time vector
tau = linspace(0, 15 * T, 1000);

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

    % Plot the response
    figure;
    plot(t, u(:, 1), 'LineWidth', 1.5);
    xlabel('$\tau$');
    ylabel('$u(\tau)$');
    title(['Response of $u$ in terms of $\tau$ for $\epsilon = ', num2str(epsilon), '$ and $\delta = ', num2str(delta), '$']);
    grid on;

    set(gcf, 'Units', 'pixels', 'Position', [300, 300, 600, 400]); % Set figure size and position
    % Remove scientific notation from y-axis
    ax = gca;
    ax.YAxis.Exponent = 0;
    ytickformat('%.2f'); % Adjust the format as needed

    exportgraphics(gcf, ['q5_', num2str(j), '.png'], 'Resolution', 300);
end
