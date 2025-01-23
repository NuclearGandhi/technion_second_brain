clc; clear; close all;

%% Without damping

% Define system parameters
m3 = 1;
l3 = 1;
l1 = (10/7)^(1/2);
l2 = (15/7)^(1/2);
omega_0 = 1;
natural_frequencies = [omega_0, 2*omega_0, 3*omega_0, 4*omega_0, 5*omega_0]; % Natural frequencies

m1 = (7/10)*m3*(l3/l1)^2;
m2 = (14/15)*m3*(l3/l2)^2;

m = [m1 m2 m3 m2 m1]; % Masses
l = [l1 l2 l3 l2 l1]; % Lengths
k = [50/7, 90/7, 15, 90/7, 50/7] * (l3^2 * m3) * omega_0^2; % Torsional spring constants

% Define the differential equations in modal coordinates
dynamics = @(t, eta) [eta(6:10);
    -natural_frequencies(1)^2 * eta(1);
    -natural_frequencies(2)^2 * eta(2);
    -natural_frequencies(3)^2 * eta(3);
    -natural_frequencies(4)^2 * eta(4);
    -natural_frequencies(5)^2 * eta(5)];

% Define the modes
unnormalized_modes = [1 -1 1 -1 1;
    4/3 -2/3 -4/9 2 -4;
    10/7 0 -10/9 0 6;
    4/3 2/3 -4/9 -2 -4;
    1 1 1 1 1];

% Calculate modal mass
modal_mass = diag(unnormalized_modes' * diag(m) * unnormalized_modes);
alpha = 1 ./ sqrt(modal_mass);

% Calculate natural modes
modes = unnormalized_modes * diag(alpha);

% Create the 3D animation for each mode separately
for mode_idx = 1:5
% for mode_idx = 2:1
    % Initial conditions in modal coordinates to excite only one mode
    eta0 = zeros(10, 1);
    eta0(mode_idx) = 1; % Excite only the current mode

    % Time span for 10 cycles of the current natural frequency
    tspan = linspace(0, 1 * (2 * pi / natural_frequencies(mode_idx)), 100);

    % Solve the differential equations
    [t, eta] = ode45(dynamics, tspan, eta0);

    % Convert modal coordinates to physical coordinates
    theta = (modes * eta(:, 1:5)')';

    % Create the 3D animation for the current mode
    figure('Color', 'w'); % Set figure background to white
    set(gcf, 'Units', 'pixels', 'Position', [300, 300, 600, 400]); % Set figure size and position
    axis equal;
    view(3); % Set the view to 3D
    hold on;
    set(gca, 'Color', [1 1 1]); % Set 3D plot background to white
    masses = gobjects(5, 2);
    rods = gobjects(5, 1);
    % matlab default colors
    colors = get(gca, 'ColorOrder');

    for i = 1:5
        masses(i, 1) = animatedline('Marker', 'o', 'MarkerSize', 5 * log(10 * m(i)), 'MarkerFaceColor', colors(i, :), 'Color', colors(i, :));
        masses(i, 2) = animatedline('Marker', 'o', 'MarkerSize', 5 * log(10 * m(i)), 'MarkerFaceColor', colors(i, :), 'Color', colors(i, :));
        rods(i) = animatedline('LineWidth', 2, 'Color', 'k');
    end

    xlabel('X Position');
    ylabel('Y Position');
    zlabel('Rod Index');
    title(['3D Physical Animation of Mode ', num2str(mode_idx)]);
    grid on;
    axis manual; % Fix the axes limits
    xlim([-2 2]);
    ylim([-2 2]);
    zlim([0.5 5.5]);

    % Create GIF
    filename = ['mode_', num2str(mode_idx), '.gif'];
    for i = 1:length(t)
        for j = 1:5
            clearpoints(masses(j, 1));
            clearpoints(masses(j, 2));
            clearpoints(rods(j));

            addpoints(masses(j, 1), l(j)*cos(theta(i, j)), l(j)*sin(theta(i, j)), j);
            addpoints(masses(j, 2), -l(j)*cos(theta(i, j)), -l(j)*sin(theta(i, j)), j);
            addpoints(rods(j), l(j)*cos(theta(i, j)), l(j)*sin(theta(i, j)), j);
            addpoints(rods(j), -l(j)*cos(theta(i, j)), -l(j)*sin(theta(i, j)), j);
        end
        drawnow; % Update the animation

        % % Capture the plot as an image
        % frame = getframe(gcf);
        % im = frame2im(frame);
        % [imind, cm] = rgb2ind(im, 256);

        % % Write to the GIF File
        % if i == 1
        %     imwrite(imind, cm, filename, 'gif', 'Loopcount', inf, 'DelayTime', 0.02);
        % else
        %     imwrite(imind, cm, filename, 'gif', 'WriteMode', 'append', 'DelayTime', 0.02);
        % end
    end
end

%% With damping

modal_zeta = [0.1 0.1 0.1 0.1 0.1]; % Modal damping ratios

% Define the differential equations in modal coordinates
dynamics = @(t, eta) [eta(6:10);
    -natural_frequencies(1)^2 * eta(1) - 2 * modal_zeta(1) * natural_frequencies(1) * eta(6);
    -natural_frequencies(2)^2 * eta(2) - 2 * modal_zeta(2) * natural_frequencies(2) * eta(7);
    -natural_frequencies(3)^2 * eta(3) - 2 * modal_zeta(3) * natural_frequencies(3) * eta(8);
    -natural_frequencies(4)^2 * eta(4) - 2 * modal_zeta(4) * natural_frequencies(4) * eta(9);
    -natural_frequencies(5)^2 * eta(5) - 2 * modal_zeta(5) * natural_frequencies(5) * eta(10)];

% Initial conditions in modal coordinates
theta0 = [10 0 10 0 10;
    0 10 0 -10 0]';
theta0 = deg2rad(theta0); % Convert initial conditions to radians
eta0 = modes^(-1) * theta0; % Convert initial conditions to modal coordinates
% add zero velocities
eta0 = [eta0; zeros(5, 2)]';

tspan = linspace(0, 15, 1000);

plot_title = {'Free Vibration with Symmetric initial conditions', 'Free Vibration with Anti-Symmetric initial conditions'};
line_style = {'-', ':', ':', ':', ':', ':'};
for i = 1:size(eta0, 1)
    figure;
    set(gcf, 'Units', 'pixels', 'Position', [300, 300, 800, 400]); % Set figure size and position
    % Solve the differential equations
    [t, eta] = ode45(dynamics, tspan, eta0(i, :));

    % Convert modal coordinates to physical coordinates
    theta = (modes * eta(:, 1:5)')';
    
    theta = rad2deg(theta); % Convert back to degrees for plotting

    % Plot the physical coordinates
    for j = 1:5
        plot(t, theta(:, j), 'LineWidth', 2, 'LineStyle', line_style{j});
        hold on;
    end

    title(plot_title{i}, 'Interpreter', 'latex');
    xlabel('$t$ (s)', 'Interpreter', 'latex');
    ylabel('$\theta$ (degrees)', 'Interpreter', 'latex');
    legend(arrayfun(@(x) ['$\theta_', num2str(x), '$'], 1:5, 'UniformOutput', false), 'Interpreter', 'latex');
    grid on;
    % exportgraphics(gcf, ['q1_free_vibration_', num2str(i), '.png'], 'Resolution', 300);
end


%% Bode magnitude plot for theta_1 and theta_3

% Define system parameters
zeta_values = [0, 0.03]; % Damping ratios
omega_range = linspace(0, 6 * omega_0, 1000); % Frequency range

% Define the input moment
M3 = 1; % Amplitude of the harmonic moment input

% Loop over damping ratios
figure;
for idx = 1:length(zeta_values)
    zeta = zeta_values(idx);
    % Define the modal damping matrix
    modal_zeta = zeta * ones(1, 5);
    Gamma = diag(2 * modal_zeta .* natural_frequencies);

    % Initialize response arrays
    theta_1_response = zeros(size(omega_range));
    theta_3_response = zeros(size(omega_range));

    % Loop over frequency range
    for i = 1:length(omega_range)
        omega = omega_range(i);
        Z = -omega^2 * eye(5) + 1i * omega * Gamma + diag(natural_frequencies.^2);
        H_modal = Z \ eye(5);
        H = modes * H_modal * modes';
        % Calculate the response for theta_1 and theta_3
        theta_1_response(i) = abs(H(1, 3) * M3);
        theta_3_response(i) = abs(H(3, 3) * M3);
    end

    % Plot the Bode magnitude plot
    subplot(2, 1, idx);
    semilogy(omega_range, theta_1_response, 'LineWidth', 2);
    hold on;
    semilogy(omega_range, theta_3_response, 'LineWidth', 2);
    title(['Bode Magnitude Plot for $\zeta = ', num2str(zeta), '$']);
    xlabel('$\omega / \omega_0$', 'Interpreter', 'latex');
    ylabel('$|\theta|$', 'Interpreter', 'latex');
    legend('$\theta_1$', '$\theta_3$');
    grid on;
    hold off;
end

set(gcf, 'Units', 'pixels', 'Position', [0, 0, 800, 600]); % Set figure size and position
% exportgraphics(gcf, 'q1_bode_magnitude.png', 'Resolution', 300);

