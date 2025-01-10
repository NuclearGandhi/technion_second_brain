clc;
clear;
close all;

% Define the range of Omega and zeta values
plotRange = [0.01, 2, 0, 7];
zeta_values = [0.05, 0.1, 0.2, 0.3, 0.5, 1.0]; % Example values for zeta
beta = 0.1; % Example value for beta

% Initialize figure
figure;
set(gcf, 'units', 'points', 'position', [250, 250 600 400]);

% Plot |A|/F for different zeta values using fimplicit
hold on;
F = 1;
for zeta = zeta_values
    A_F_implicit_eq = @(Omega, A_F) (A_F.^2) .* ((-Omega.^2 + 1 + (3/4) * beta * (A_F * F).^2).^2 + (2 * zeta * Omega).^2) - 1;
    fimplicit(A_F_implicit_eq, plotRange, 'DisplayName', ['$\zeta$ = ', num2str(zeta)], 'LineWidth', 1.5);
end

% Plot |A| as a function of Omega according to the given equation
fimplicit(@(Omega, A) Omega.^2 - 1 - (3/4) * beta * A.^2, plotRange, 'k--', 'HandleVisibility', 'off');
text(1.3, 6.2, sprintf('$\\Omega^{2}=1+\\frac{3}{4}\\beta |A|^{2}$'),...
    'Color', 'k',...
    'FontSize', 14, ...
    'Interpreter', 'latex');

xlabel('$\Omega$');
ylabel('$|A|$');
title('Frequency Response Ratio for different $\zeta$ values');
legend('Location', 'northwest'); % Move legend to top left
set(gcf, 'units', 'pixels', 'position', [300 300 600 400]);
grid on;
hold off;

% Save the figure
exportgraphics(gcf, 'graph_output/q2pb.png', 'Resolution', 300);
