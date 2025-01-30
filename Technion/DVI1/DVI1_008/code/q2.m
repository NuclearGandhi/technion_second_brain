clc; clear; close all;

%% Solve the characteristic equation for beta

syms beta L EI k kt

% Boundary conditions
% X(0) = 0
% X''(0) = 0
% EI * X'''(L) - k * X(L) = 0
% EI * X''(L) + kt * X'(L) = 0
BCM = @(beta) [1, 0, 1, 0;
    -beta^2, 0, beta^2, 0;
    beta^3 * EI * sin(beta * L) - k * cos(beta * L),...
    -beta^3 * EI * cos(beta * L) - k * sin(beta * L),...
    beta^3 * EI * sinh(beta * L) - k * cosh(beta * L),...
    beta^3 * EI * cosh(beta * L) - k * sinh(beta * L);

    -beta^2 * EI * cos(beta * L) - beta * kt * sin(beta * L),...
    -beta^2 * EI * sin(beta * L) + beta * kt * cos(beta * L),...
    beta^2 * EI * cosh(beta * L) + beta * kt * sinh(beta * L),...
    beta^2 * EI * sinh(beta * L) + beta * kt * cosh(beta * L)];

characteristic_eq = @(beta) det(BCM(beta));

% Solve the characteristic equation for given values of EI, k, kt, and L
EI_val = 41.67; % N/m^2
k_val = 100; % N/m
kt_val = 100; % N*m/rad
L_val = 1; % m

% Substitute the values into the characteristic equation
characteristic_eq_numeric = @(beta) arrayfun(@(b) double(subs(characteristic_eq(b), {EI, k, kt, L}, {EI_val, k_val, kt_val, L_val})), beta);

% Find the first 6 roots
beta_roots = NaN(6, 1);
root_count = 0;
for beta0 = linspace(0, 15, 100)
    try
        root = fzero(characteristic_eq_numeric, beta0);
        if root >= 0 && all(abs(beta_roots(1:root_count) - root) > 1e-3)
            root_count = root_count + 1;
            beta_roots(root_count) = root;
        end
        if root_count >= 6
            break;
        end
    catch
        % Ignore errors due to fzero not converging
    end
end
beta_roots = unique(beta_roots(~isnan(beta_roots)));
beta_roots = beta_roots(1:min(6, length(beta_roots)));

% Display the roots
disp('Beta roots:');
disp(beta_roots);

%% Plot the function and the roots

beta_range = linspace(0, 15, 1000);
colors = get(groot, 'DefaultAxesColorOrder');
semilogy(beta_range, abs(characteristic_eq_numeric(beta_range)), 'LineWidth', 2);
hold on;
for i = 1:length(beta_roots)
    xline(beta_roots(i), 'k--', 'LineWidth', 1);
end
grid on;
xlabel('$\beta$');
ylabel('$f(\beta)$');
title('Roots of the implicit equation for $\beta$');

set(gcf, 'units', 'pixels', 'position', [100, 100, 600, 300]);
exportgraphics(gcf, 'q2.png', 'Resolution', 300);

% Display the roots
disp('Beta roots:');
disp(beta_roots);

%% Calculate the natural frequencies and mode shapes

% Parameters
rho_val = 8000; % kg/m^3
A_val = 0.0001; % m^2
c = sqrt(EI_val / (rho_val * A_val));

BCM_num = @(beta) double(subs(BCM(beta), {EI, k, kt, L}, {EI_val, k_val, kt_val, L_val}));

% Ignore roots that are too close to zero
beta_roots = beta_roots(beta_roots > 1e-3);

% Calculate the natural frequencies
natural_frequencies = beta_roots.^2 * c;
disp('Natural frequencies:');
disp(natural_frequencies);

for i = 1:length(beta_roots)
    beta = beta_roots(i);
    bcm_matrix = BCM_num(beta);
    disp(['BCM for beta = ', num2str(beta)]);
    disp(bcm_matrix);
    disp(['Rank: ', num2str(rank(bcm_matrix))]);
end

% Solve BCM * C = 0
C = ones(4, length(beta_roots));
for i = 1:length(beta_roots)
    beta = beta_roots(i);
    % i
    % null(BCM(beta))
    null_space = null(BCM_num(beta));
    C(:, i) = null_space(:, 1);
end

% Plot the mode shapes
figure;
for i = 1:length(beta_roots)
    beta = beta_roots(i);
    x = linspace(0, L_val, 100);
    y = C(1, i) * cos(beta .* x) + C(2, i) * sin(beta .* x) + C(3, i) * cosh(beta .* x) + C(4, i) * sinh(beta .* x);
    subplot(2, 3, i);
    plot(x, y, 'LineWidth', 2);
    grid on;
    xlabel('$x$');
    ylabel(['$X_', num2str(i), '(x)$']);
    title(['$\omega_{', num2str(i), '} = ', num2str(natural_frequencies(i), '%.5g'), '$ rad/s'], 'Interpreter', 'latex');
end

set(gcf, 'units', 'pixels', 'position', [100, 100, 1200, 600]);
exportgraphics(gcf, 'q2_modes.png', 'Resolution', 300);
