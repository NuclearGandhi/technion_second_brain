clc;
clear;
close all;

% Define the range of Omega and zeta values
Omega = linspace(0, 2, 1000);
zeta_values = [0.01, 0.05, 0.1, 0.5];

% Initialize figures
figure;

% Plot |v| by Omega for different zeta values
subplot(2, 1, 1);
hold on;
for zeta = zeta_values
    v_magnitude = Omega ./ sqrt((1 - Omega.^2).^2 + (2 * zeta * Omega).^2);
    plot(Omega, v_magnitude, 'DisplayName', ['$\zeta$ = ', num2str(zeta)]);
end
ylabel('$|v|$');
title('Magnitude of $v$ for different $\zeta$ values');
legend;
grid on;
set(gca, 'XTickLabel', []); % Remove x-axis tick labels
hold off;

% Plot \varphi_v by Omega for different zeta values
subplot(2, 1, 2);
hold on;
for zeta = zeta_values
    phi_v = atan((1 - Omega.^2) ./ (2 * zeta * Omega)) * (180 / pi); % Convert to degrees
    plot(Omega, phi_v, 'DisplayName', ['$\zeta$ = ', num2str(zeta)]);
end
xlabel('$\Omega$');
ylabel('$\varphi_v$ (degrees)');
title('Phase of $v$ for different $\zeta$ values');
yticks([-180, -90, 0, 90, 180]); % Set y-axis ticks
legend;
grid on;
hold off;


set(gcf, 'units', 'points', 'position', [250, 250 600 400]);

% Save the figure
exportgraphics(gcf, 'graph_output/q1pd.png', 'Resolution', 300);
