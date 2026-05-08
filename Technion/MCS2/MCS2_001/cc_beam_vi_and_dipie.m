%% Clamped-Clamped Beam Actuator: Voltage Iteration and DIPIE
% Solves the normalized governing equation:
%   y'''' = (1/2) * V^2 / (1 - y)^2
% using two methods: Voltage Iteration (VI) and DIPIE.

clear; close all; clc;

set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
set(groot, 'defaultTextInterpreter', 'latex');
set(groot, 'defaultLegendInterpreter', 'latex');

n = 1023;
h = 1/(n+1);
x = (h:h:1-h)';
nn = (n+1)/2;

c = x*0 + 1;
D4 = [c  -4*c  6*c  -4*c  c];
D4(1,3) = D4(1,3) + D4(1,1);
D4(n,3) = D4(n,3) + D4(n,5);
K = spdiags(D4, -2:2, n, n)';

%% Figure 1: VI Convergence
V_list = [1:11, 11.5, 11.8, 11.85];
iter_max = 30;
y_conv = zeros(iter_max, length(V_list));
y = x*0;

for i = 1:length(V_list)
    [y, y_conv(:,i)] = voltage_actuation(K, n, V_list(i), iter_max, y);
end

fig1 = figure('Position', [100, 100, 600, 400]);
semilogy(y_conv, '-*', 'LineWidth', 1.5);
grid on;
axis([1 30 1e-9 1]);
xlabel('iteration', 'FontSize', 14);
ylabel('absolute relative error', 'FontSize', 14);
title('convergence of midpoint displacement', 'FontSize', 14, 'FontWeight', 'bold');
set(gca, 'FontSize', 12);
text(18, 2e-4, '$\tilde{V}=[1{:}11,\; 11.5,\; 11.8,\; 11.85]$', 'FontSize', 11);
exportgraphics(fig1, 'vi_convergence.png', 'Resolution', 150);
fprintf('Saved: vi_convergence.png\n');

%% Figure 2: VI Equilibrium Curve
y = x*0;
V_scan = [0.5:0.5:10, 10.5:0.25:11.5, 11.6:0.05:11.85];
y_mid_vi = zeros(size(V_scan));

for i = 1:length(V_scan)
    [y, ~] = voltage_actuation(K, n, V_scan(i), 60, y);
    y_mid_vi(i) = y(nn);
end

fig2 = figure('Position', [100, 100, 600, 400]);
plot(y_mid_vi, V_scan, '*-', 'LineWidth', 2, 'MarkerSize', 4);
grid on;
xlabel('mid point normalized displacement', 'FontSize', 14);
ylabel('$\tilde{V}$', 'FontSize', 14, 'Rotation', 0);
title('equilibrium curve (VI)', 'FontSize', 14, 'FontWeight', 'bold');
set(gca, 'FontSize', 12);
xlim([0 0.5]);
ylim([0 12]);
exportgraphics(fig2, 'vi_equilibrium.png', 'Resolution', 150);
fprintf('Saved: vi_equilibrium.png\n');

%% Figure 3: DIPIE Equilibrium Curve (full)
y_mid_list = 0.01:0.01:0.99;
V_dipie = zeros(size(y_mid_list));
Q_dipie = zeros(size(y_mid_list));

for i = 1:length(y_mid_list)
    [y_sol, ~, V_dipie(i)] = dipie_cc_beam(K, n, 10, y_mid_list(i));
    Q_dipie(i) = V_dipie(i) * (sum(1./(1-y_sol)) + 1) / (n+1);
end

[~, pi_idx] = max(V_dipie);

fig3 = figure('Position', [100, 100, 600, 400]);
hold on;
plot(y_mid_list(1:pi_idx), V_dipie(1:pi_idx), 'b-', 'LineWidth', 2.5);
plot(y_mid_list(pi_idx:end), V_dipie(pi_idx:end), 'r--', 'LineWidth', 2.5);
plot(y_mid_list(pi_idx), V_dipie(pi_idx), 'ko', 'MarkerSize', 10, ...
    'MarkerFaceColor', 'k');
grid on;
xlabel('mid point normalized displacement', 'FontSize', 14);
ylabel('$\tilde{V}$', 'FontSize', 14, 'Rotation', 0);
title('equilibrium curve (DIPIE)', 'FontSize', 14, 'FontWeight', 'bold');
legend({'stable', 'unstable', 'pull-in'}, 'Location', 'northeast', 'FontSize', 12);
set(gca, 'FontSize', 12);
xlim([0 1]);
ylim([0 14]);
exportgraphics(fig3, 'dipie_equilibrium.png', 'Resolution', 150);
fprintf('Saved: dipie_equilibrium.png\n');
fprintf('Pull-in: y_mid = %.4f, V = %.4f\n', y_mid_list(pi_idx), V_dipie(pi_idx));

%% Figure 4: Convergence comparison (VI vs DIPIE iterations needed)
y_mid_scan = 0.01:0.01:0.50;
vi_iters = zeros(size(y_mid_scan));
dipie_iters = zeros(size(y_mid_scan));
tol = 1e-6;

for i = 1:length(y_mid_scan)
    [~, ~, V_eq] = dipie_cc_beam(K, n, 10, y_mid_scan(i));
    
    % VI: count iterations to converge at this voltage
    y_vi = x*0;
    fac = h^4/2 * V_eq^2;
    y_prev_norm = 0;
    for iter = 1:400
        rhs = fac ./ (1 - y_vi).^2;
        y_vi = K \ rhs;
        y_curr_norm = (sum(y_vi.^2)/n)^0.5;
        if abs(y_curr_norm - y_prev_norm) / max(y_curr_norm, 1e-15) < tol
            vi_iters(i) = iter;
            break;
        end
        y_prev_norm = y_curr_norm;
        if iter == 400
            vi_iters(i) = 400;
        end
    end
    
    % DIPIE: count iterations to converge for this midpoint displacement
    y_dp = x*0;
    y_dp(nn) = y_mid_scan(i);
    indx = [1:nn-1, nn+1:n];
    rhs_dp = -K(:,nn) * y_mid_scan(i);
    y_dp(indx) = K(indx,indx) \ rhs_dp(indx);
    y_prev_norm = 0;
    for iter = 1:400
        V2_i = 2*(K*y_dp)/h^4 .* (1-y_dp).^2;
        V2 = sum(V2_i)/n;
        fac_dp = h^4/2 * V2;
        rhs_dp = fac_dp ./ (1-y_dp).^2 - K(:,nn)*y_mid_scan(i);
        y_dp(indx) = K(indx,indx) \ rhs_dp(indx);
        y_curr_norm = (sum(y_dp.^2)/n)^0.5;
        if abs(y_curr_norm - y_prev_norm) / max(y_curr_norm, 1e-15) < tol
            dipie_iters(i) = iter;
            break;
        end
        y_prev_norm = y_curr_norm;
        if iter == 400
            dipie_iters(i) = 400;
        end
    end
end

fig4 = figure('Position', [100, 100, 600, 400]);
hold on;
plot(y_mid_scan, vi_iters, 'b-o', 'LineWidth', 2, 'MarkerSize', 4);
plot(y_mid_scan, dipie_iters, 'r-s', 'LineWidth', 2, 'MarkerSize', 4);
grid on;
xlabel('mid point normalized displacement', 'FontSize', 14);
ylabel('number of iterations', 'FontSize', 14);
title('convergence comparison: VI vs. DIPIE', 'FontSize', 14, 'FontWeight', 'bold');
legend({'VI', 'DIPIE'}, 'Location', 'northwest', 'FontSize', 12);
set(gca, 'FontSize', 12);
ylim([0 min(max(vi_iters)*1.1, 400)]);
exportgraphics(fig4, 'convergence_comparison.png', 'Resolution', 150);
fprintf('Saved: convergence_comparison.png\n');

fprintf('\nAll figures saved.\n');

%% ==================== Functions ====================

function [y, y_norm] = voltage_actuation(K, n, V, iter_max, y)
    h = 1/(n+1);
    fac = h^4/2 * V^2;
    nn = (n+1)/2;
    y_norm = zeros(iter_max, 1);
    
    for iter = 1:iter_max
        rhs = fac ./ (1 - y).^2;
        y = K \ rhs;
        y_norm(iter) = (sum(y.^2)/n)^0.5;
    end
    
    final_val = y_norm(iter_max);
    if final_val > 0
        y_norm = 1 - y_norm / final_val;
    end
end

function [y, y_norm, V] = dipie_cc_beam(K, n, iter_max, y_mid)
    h = 1/(n+1);
    nn = (n+1)/2;
    indx = [1:nn-1, nn+1:n];
    x = (h:h:1-h)';
    y = x*0;
    y(nn) = y_mid;
    
    rhs = -K(:,nn) * y_mid;
    y(indx) = K(indx,indx) \ rhs(indx);
    
    y_norm = zeros(iter_max, 1);
    for iter = 1:iter_max
        V2_i = 2*(K*y)/h^4 .* (1-y).^2;
        V2 = sum(V2_i)/n;
        fac = h^4/2 * V2;
        rhs = fac ./ (1-y).^2 - K(:,nn)*y_mid;
        y(indx) = K(indx,indx) \ rhs(indx);
        y_norm(iter) = (sum(y.^2)/n)^0.5;
    end
    
    final_val = y_norm(iter_max);
    if final_val > 0
        y_norm = 1 - y_norm / final_val;
    end
    V = sqrt(abs(V2));
end
