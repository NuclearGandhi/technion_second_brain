% FEM solution for 1D heat equation with variable area and source

clear; clc; close all;

% Problem parameters
k = 15; % W/m/K
A = @(x) 50e-4 * exp(x); % m^2
L = 1; % m
qdot = 2.5; % W/m
T0 = 50; % K
qL = 1.5e3; % W/m^2

% 2-point Gauss quadrature points and weights (for use in main script)
xi_q = [-1/sqrt(3), 1/sqrt(3)];
w_q = [1, 1];

% Exact solution (symbolic or analytical)
syms x T(x)
A_x = 50e-4 * exp(x);
ODE = diff(A_x*k*diff(T,x),x) + A_x*qdot == 0;
conds = [T(0)==T0, -k*subs(diff(T,x),x,L)==qL];
Tsol = dsolve(ODE, conds);
T_exact = matlabFunction(Tsol, 'Vars', x);

% FEM solver function
function [x_nodes, T_num] = fem1d(n, k, A, L, qdot, T0, qL)
    % Mesh
    x_nodes = linspace(0, L, n+1)';
    h = diff(x_nodes);
    K = zeros(n+1);
    F = zeros(n+1,1);
    % 2-point Gauss quadrature
    xi_q = [-1/sqrt(3), 1/sqrt(3)];
    w_q = [1, 1];
    for e = 1:n
        x1 = x_nodes(e); x2 = x_nodes(e+1);
        he = x2 - x1;
        Ke = zeros(2);
        Fe = zeros(2,1);
        for q = 1:2
            xi = xi_q(q);
            w = w_q(q);
            % Local coordinate
            xq = 0.5*(x2-x1)*xi + 0.5*(x2+x1);
            J = he/2;
            N = [(1-xi)/2, (1+xi)/2];
            dNdxi = [-0.5, 0.5];
            dNdx = dNdxi * (2/he);
            Aq = A(xq);
            % Stiffness
            Ke = Ke + (k*Aq)*(dNdx'*dNdx)*J*w;
            % Load
            Fe = Fe + (Aq*qdot)*N'*J*w;
        end
        % Assembly
        K(e:e+1,e:e+1) = K(e:e+1,e:e+1) + Ke;
        F(e:e+1) = F(e:e+1) + Fe;
    end
    % Apply Dirichlet BC at x=0
    K(1,:) = 0; K(1,1) = 1; F(1) = T0;
    % Apply Neumann BC at x=L
    F(end) = F(end) - qL * A(x_nodes(end));
    % Solve
    T_num = K\F;
end

% Plot exact and FEM solutions for n = 1, 5, 10, 100
figure; hold on;
colors = lines(5);
ns = [1,5,10,100];
for i = 1:length(ns)
    n = ns(i);
    [x_nodes, T_num] = fem1d(n, k, A, L, qdot, T0, qL);
    plot(x_nodes, T_num, '-o', 'Color', colors(i,:), 'DisplayName', sprintf('FEM n=%d',n));
end
fplot(@(x) T_exact(x), [0 L], 'k--', 'LineWidth',1.5, 'DisplayName','Exact');
xlabel('$x$ [m]','Interpreter','latex'); ylabel('$T(x)$ [K]','Interpreter','latex');
title('FEM and Exact Solution'); legend('show','Location','best'); grid on;
set(gcf, 'Position', [100, 100, 600, 400]);
exportgraphics(gcf, 'q7_fem_vs_exact.png', 'Resolution', 150);

% Error analysis for L2 and H1 norms
ns = [1,5,10,50,100,500,1000];
L2err = zeros(size(ns)); H1err = zeros(size(ns)); hvals = L./ns;
for j = 1:length(ns)
    n = ns(j);
    [x_nodes, T_num] = fem1d(n, k, A, L, qdot, T0, qL);
    % Compute error using Gauss quadrature
    L2e = 0; H1e = 0;
    for e = 1:n
        x1 = x_nodes(e); x2 = x_nodes(e+1);
        he = x2 - x1;
        T1 = T_num(e); T2 = T_num(e+1);
        for q = 1:2
            xi = xi_q(q);
            w = w_q(q);
            xq = 0.5*(x2-x1)*xi + 0.5*(x2+x1);
            J = he/2;
            N = [(1-xi)/2, (1+xi)/2];
            dNdxi = [-0.5, 0.5];
            dNdx = dNdxi * (2/he);
            T_h = N*[T1;T2];
            dT_h = dNdx*[T1;T2];
            T_ex = T_exact(xq);
            dT_ex = (T_exact(xq+1e-6)-T_exact(xq-1e-6))/2e-6; % numerical derivative
            L2e = L2e + (T_h-T_ex)^2 * J * w;
            H1e = H1e + (dT_h-dT_ex)^2 * J * w;
        end
    end
    L2err(j) = sqrt(L2e);
    H1err(j) = sqrt(H1e);
end

% Plot error convergence
figure;
loglog(hvals, L2err, '-o', 'DisplayName','$L^2$ error'); hold on;
loglog(hvals, H1err, '-s', 'DisplayName','$H^1$ error');
xlabel('Element size $h$','Interpreter','latex'); ylabel('Error norm','Interpreter','latex');
title('Error convergence'); legend('show','Location','best'); grid on;
% Compute and annotate slopes
pL2 = polyfit(log(hvals), log(L2err), 1);
pH1 = polyfit(log(hvals), log(H1err), 1);
xlims = xlim;
ylims = ylim;
text(xlims(1) * (xlims(2)/xlims(1))^0.3, ylims(1) * (ylims(2)/ylims(1))^0.8, ...
    sprintf('Slope $L^2$: %.2f', pL2(1)), 'FontSize',12);
text(xlims(1) * (xlims(2)/xlims(1))^0.5, ylims(1) * (ylims(2)/ylims(1))^0.4, ...
    sprintf('Slope $H^1$: %.2f', pH1(1)), 'FontSize',12);

set(gcf, 'Position', [100, 100, 600, 400]);
exportgraphics(gcf, 'q7_error_convergence.png', 'Resolution', 150);