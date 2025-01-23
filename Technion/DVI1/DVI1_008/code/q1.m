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
kappa_roots = [];
for kappa0 = linspace(0, 15, 100)
    try
        root = fzero(f, kappa0);
        if isempty(kappa_roots) || all(abs(kappa_roots - root) > 1e-3)
            kappa_roots = [kappa_roots; root];
        end
        if length(kappa_roots) >= 6
            break;
        end
    catch
        % Ignore errors due to fzero not converging
    end
end
kappa_roots = unique(kappa_roots);
kappa_roots = kappa_roots(1:min(6, length(kappa_roots)));


colors = get(groot, 'DefaultAxesColorOrder');
fplot(f, [0, 15], 'LineWidth', 2);
hold on;
plot(kappa_roots, zeros(1, length(kappa_roots)), 'o', 'MarkerSize', 6, 'MarkerFaceColor', colors(2, :), 'MarkerEdgeColor', colors(2, :));
grid on;
xlabel('$\kappa$');
ylabel('$f(\kappa)$');
title('Roots of the implicit equation');

set(gcf, 'units', 'pixels', 'position', [100, 100, 600, 200]);
% exportgraphics(gcf, 'q1.png', 'Resolution', 300);

% Calculate the natural frequencies
natural_frequencies = kappa_roots * c;
disp(natural_frequencies);

% Plot the mode shapes
figure;
for i = 1:length(kappa_roots)
    kappa = kappa_roots(i);
    x = linspace(0, L, 100);
    y = sin(kappa * x);
    subplot(2, 3, i);
    plot(x, y, 'LineWidth', 2);
    grid on;
    xlabel('$x$');
    ylabel(['$X_', num2str(i), '(x)$']);
    title(['Mode shape for $\omega = ', num2str(natural_frequencies(i), '%.5g'), '$ rad/s']);
end

set(gcf, 'units', 'pixels', 'position', [100, 100, 1200, 600]);
% exportgraphics(gcf, 'q1_modes.png', 'Resolution', 300);

%% Part b

% Calculate B_n
B_n = zeros(length(kappa_roots), 1);
for i = 1:length(kappa_roots)
    kappa = kappa_roots(i);
    B_n(i) = sqrt(2/(rho * J)) * (L - (1/(kappa)) * sin(kappa * L) * cos(kappa * L))^(-0.5);
end

disp('B_n values:');
disp(B_n);

%% Part f

zeta = 0.03;
B_n(1) = 0; % Set B_1 to 0
M_L = 1;

% Analytical frequency response at x = L
omega_values = linspace(min(natural_frequencies), max(natural_frequencies), 1000);

figure;
for i = 3:length(kappa_roots)
    X_L = B_n(1:i) .* sin(kappa_roots(1:i) .* L);
    theta_0 = @(omega) sum((M_L .* X_L ./ (natural_frequencies(1:i).^2 - omega.^2 + 2i*zeta*omega.*natural_frequencies(1:i))) .* X_L .* M_L );

    theta_0_values = abs(arrayfun(theta_0, omega_values));
    semilogy(omega_values, theta_0_values, 'LineWidth', 2, 'DisplayName', ['Summing $N=', num2str(i), '$ modes']);
    hold on;
end
% Plot vertical line at omega = 22 * 10^3
yLimits = ylim;
plot([22 * 10^3, 22 * 10^3], yLimits, '--', 'LineWidth', 1, 'Color', 'k', 'DisplayName', '$\omega = 22 \times 10^3$ rad/s');

grid on;
xlabel('$\omega$ (rad/s)');
ylabel('$\theta_0$');
title('Frequency Response at $x = L$');
legend('Location', 'best');

set(gcf, 'units', 'pixels', 'position', [100, 100, 600, 400]);
exportgraphics(gcf, 'q1f.png', 'Resolution', 300);
