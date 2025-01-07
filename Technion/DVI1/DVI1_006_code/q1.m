clc; clear; close all;

% Define system parameters
m3 = 1;
l1 = 1; % Length of the first rod
l2 = 1; % Length of the second rod
l3 = 1;
omega_0 = 1;
natural_frequencies = [omega_0, 2*omega_0, 3*omega_0, 4*omega_0, 5*omega_0]; % Natural frequencies

m1 = 10/7*m3*(l3/l1)^2;
m2 = 15/14*m3*(l3/l2)^2;

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
for mode_idx = 4:5
    % Initial conditions in modal coordinates to excite only one mode
    eta0 = zeros(10, 1);
    eta0(mode_idx) = 0.5; % Excite only the current mode

    % Time span for 10 cycles of the current natural frequency
    tspan = linspace(0, 1 * (2 * pi / natural_frequencies(mode_idx)), 100);

    % Solve the differential equations
    [t, eta] = ode45(dynamics, tspan, eta0);

    % Convert modal coordinates to physical coordinates
    theta = (modes * eta(:, 1:5)')';

    % Create the 3D animation for the current mode
    figure('Color', 'w'); % Set figure background to white
    axis equal;
    view(3); % Set the view to 3D
    hold on;
    set(gca, 'Color', [1 1 1]); % Set 3D plot background to white
    masses = gobjects(5, 2);
    rods = gobjects(5, 1);
    colors = ['b', 'r', 'g', 'm', 'c'];

    for i = 1:5
        masses(i, 1) = animatedline('Marker', 'o', 'MarkerSize', 8, 'MarkerFaceColor', colors(i), 'Color', colors(i));
        masses(i, 2) = animatedline('Marker', 'o', 'MarkerSize', 8, 'MarkerFaceColor', colors(i), 'Color', colors(i));
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

        % Capture the plot as an image
        frame = getframe(gcf);
        im = frame2im(frame);
        [imind, cm] = rgb2ind(im, 256);

        % Write to the GIF File
        if i == 1
            imwrite(imind, cm, filename, 'gif', 'Loopcount', inf, 'DelayTime', 0.05);
        else
            imwrite(imind, cm, filename, 'gif', 'WriteMode', 'append', 'DelayTime', 0.05);
        end
    end
end
