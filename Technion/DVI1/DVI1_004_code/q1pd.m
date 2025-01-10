clc;
clear;
close all;

% Define the range of Omega and A/F values
OmegaStep = 0.01;
OmegaRange = 0.01:OmegaStep:2;
A_F_Range = linspace(0, 6, 200);
delta_values = [0.01, 0.1, 0.5, 1.0]; % Example values for delta
F = 1; % Example value for F

% Initialize figure
figure;
set(gcf, 'units', 'points', 'position', [250, 250 600 400]);

% Plot |A|/F for different delta values using meshgrid
hold on;
[Omega, A_F] = meshgrid(OmegaRange, A_F_Range);
colors = lines(length(delta_values)); % Get a set of colors
for idx = 1:length(delta_values)
    delta = delta_values(idx);
    Z = (A_F.^2) .* ((-Omega.^2 + 1).^2 + ((3/4) * delta * Omega.^3 .* (abs(A_F) * F).^2).^2) - 1;
    [C, h] = contour(Omega, abs(A_F), Z, [0 0], 'DisplayName', ['Equivalent damping'], 'LineColor', colors(1, :), 'LineWidth', 1.5);
end

% Add delta values text to the plot
text(1.1, 5, '$\delta = 0.01$', 'Color', colors(1, :), 'FontSize', 14);
text(0.97, 2.6, '$\delta = 0.1$', 'Color', colors(1, :), 'FontSize', 14);
text(0.85, 1.75, '$\delta = 0.5$', 'Color', colors(1, :), 'FontSize', 14);
text(0.7, 1, '$\delta = 1.0$', 'Color', colors(1, :), 'FontSize', 14);


% Calculate numerically the amplitude ratio (in steady state) for y'' + delta y'^3 + y = cos(Omega * tau)
options = odeset('RelTol', 1e-8, 'AbsTol', 1e-10); % Set tighter tolerances
for idx = 1:length(delta_values)
    delta = delta_values(idx);
    A_num = zeros(size(OmegaRange));
    for i = 1:length(OmegaRange)
        Omega = OmegaRange(i);
        % Define the differential equation
        dydt = @(t, y) [y(2); cos(Omega * t) - y(1) - delta * y(2)^3];
        % Solve the differential equation
        cycle = (2 * pi / Omega);
        [t, y] = ode45(dydt, [0, round(200 * cycle)], [0, 0]);
        % Calculate the amplitude in steady state
        A_num(i) = max(y(end-round(20 * cycle):end, 1)) / F;
    end
    plot(OmegaRange, A_num, '--', 'DisplayName', ['Numerical'], 'Color', colors(2, :));
end

xlabel('$\Omega$');
ylabel('$\frac{|A|}{F}$');
title('Frequency Response Ratio for different $\delta$ values');
legendUnq;
legend('Location', 'northwest'); % Move legend to top left
set(gcf, 'units', 'pixels', 'position', [300 300 600 400]);
grid on;
hold off;

% Save the figure
exportgraphics(gcf, 'graph_output/q1pd.png', 'Resolution', 300);

