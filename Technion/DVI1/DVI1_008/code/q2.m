clc; clear; close all;

% Parameters
EI = 41.67; % N/m^2
rho = 8000; % kg/m^3
A = 0.0001; % m^2
L = 1; % m
k = 100; % N/m
kt = 100; % N*m/rad

c = sqrt(EI / (rho * A));

% Define the function for finding roots
f = @(beta) -2 * beta.^3 .* (beta * EI .* cos(beta * L) + kt * sin(beta * L)) .* (beta.^3 * EI .* cos(beta * L) + beta.^3 * EI .* cosh(beta * L) + k * sin(beta * L));

% Find the first 6 roots
beta_roots = [];
for beta0 = linspace(0, 15, 100)
    try
        root = fzero(f, beta0);
        if isempty(beta_roots) || all(abs(beta_roots - root) > 1e-3)
            beta_roots = [beta_roots; root];
        end
        if length(beta_roots) >= 6
            break;
        end
    catch
        % Ignore errors due to fzero not converging
    end
end
beta_roots = unique(beta_roots);
beta_roots = beta_roots(1:min(6, length(beta_roots)));

% Plot the function and the roots
colors = get(groot, 'DefaultAxesColorOrder');
fplot(f, [0, 15], 'LineWidth', 2);
hold on;
plot(beta_roots, zeros(1, length(beta_roots)), 'o', 'MarkerSize', 6, 'MarkerFaceColor', colors(2, :), 'MarkerEdgeColor', colors(2, :));
grid on;
xlabel('$\beta$');
ylabel('$f(\beta)$');
title('Roots of the implicit equation for $\beta$');

set(gcf, 'units', 'pixels', 'position', [100, 100, 600, 200]);
% exportgraphics(gcf, 'q2.png', 'Resolution', 300);

% Display the roots
disp('Beta roots:');
disp(beta_roots);

% Calculate the natural frequencies
natural_frequencies = beta_roots.^2 * c;
disp('Natural frequencies:');
disp(natural_frequencies);

BCM = @(beta) [1, 0, 1, 0;
    -beta^2, 0, beta^2, 0;
    beta^3 * EI * sin(beta * L) - k * cos(beta * L), -beta^3 * EI * cos(beta * L) - k * sin(beta * L), beta^3 * EI * sinh(beta * L) - k * cosh(beta * L), -beta^3 * EI * cosh(beta * L) - k * sinh(beta * L);
    -beta^2 * EI * cos(beta * L) - beta * kt * sin(beta * L), -beta^2 * EI * cos(beta * L) - beta * kt * sin(beta * L), -beta^2 * EI * cosh(beta * L) - beta * kt * sin(beta * L), -beta^2 * EI * cosh(beta * L) - kt * sinh(beta * L)];

BCM(beta_roots(3))

% Solve BCM * C = 0
C = zeros(4, length(beta_roots));
for i = 1:length(beta_roots)
    beta = beta_roots(i);
    C(:, i) = null(BCM(beta));
end

% Plot the mode shapes
figure;
for i = 1:length(beta_roots)
    beta = beta_roots(i);
    x = linspace(0, L, 100);
    y = C(1, i) * cos(beta .* x) + C(2, i) * sin(beta .* x) + C(3, i) * cosh(beta .* x) + C(4, i) * sinh(beta .* x);
    subplot(2, 3, i);
    plot(x, y, 'LineWidth', 2);
    grid on;
    xlabel('x');
    ylabel(['$\phi_', num2str(i), '(x)$']);
    title(['$\omega = ', num2str(natural_frequencies(i), '%.5g'), '$ rad/s']);
end

set(gcf, 'units', 'pixels', 'position', [100, 100, 1200, 600]);
% exportgraphics(gcf, 'q2_modes.png', 'Resolution', 300);
