clc; clear; close all;

%% Part a

% Parameters
d = 0.1; % m
L = 1; % m
J = pi * d^4 / 32; % m^4
G = 80 * 10^9; % Pa
k_N = 10^6; % N/m
rho = 7850; % kg/m^3
I = rho * pi * d^4 /32; % kg/m^2

c = sqrt(G/rho);

% Find numeric solutions for the following implicit equations and show the roots - the intersection points \kappa G{J}_{p}\cos(\kappa L)+{k}_{N}\sin(\kappa L)=0

% Define the function
f = @(kappa) kappa * G * J * cos(kappa * L) + k_N * sin(kappa * L);

% Find the first 6 roots
roots = [];
for kappa0 = linspace(0, 15, 100)
    try
        root = fzero(f, kappa0);
        if isempty(roots) || all(abs(roots - root) > 1e-3)
            roots = [roots; root];
        end
        if length(roots) >= 6
            break;
        end
    catch
        % Ignore errors due to fzero not converging
    end
end
roots = unique(roots);
roots = roots(1:min(6, length(roots)));


colors = get(groot, 'DefaultAxesColorOrder');
fplot(f, [0, 15], 'LineWidth', 2);
hold on;
plot(roots, zeros(1, length(roots)), 'o', 'MarkerSize', 6, 'MarkerFaceColor', colors(2, :), 'MarkerEdgeColor', colors(2, :));
grid on;
xlabel('$\kappa$');
ylabel('$f(\kappa)$');
title('Roots of the implicit equation');

set(gcf, 'units', 'pixels', 'position', [100, 100, 600, 200]);
exportgraphics(gcf, 'q1.png', 'Resolution', 300);

% Calculate the natural frequencies
omega = roots * c;
disp(omega);

% Plot the mode shapes
figure;
for i = 1:length(roots)
    kappa = roots(i);
    x = linspace(0, L, 100);
    y = sin(kappa * x);
    subplot(2, 3, i);
    plot(x, y, 'LineWidth', 2);
    grid on;
    xlabel('$x$');
    ylabel(['$X_', num2str(i), '(x)$']);
    title(['Mode shape for $\omega = ', num2str(omega(i), '%.5g'), '$ rad/s']);
end

set(gcf, 'units', 'pixels', 'position', [100, 100, 1200, 600]);
exportgraphics(gcf, 'q1_modes.png', 'Resolution', 300);

%% Part b

% Calculate B_n
B_n = zeros(length(roots), 1);
for i = 1:length(roots)
    kappa = roots(i);
    B_n(i) = sqrt(2/(rho * J)) * (L - (1/(kappa)) * sin(kappa * L) * cos(kappa * L))^(-0.5)
end

disp('B_n values:');
disp(B_n);