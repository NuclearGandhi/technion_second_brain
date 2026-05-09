%% MCS2 HW001 - Cantilever Beam Voltage Iteration and DIPIE
% Normalized governing equation:
%   y'''' = 0.5 * V^2 / (1 - y)^2
%
% Boundary conditions:
%   y(0) = 0, y'(0) = 0, y''(1) = 0, y'''(1) = 0

clear; close all; clc;

set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
set(groot, 'defaultTextInterpreter', 'latex');
set(groot, 'defaultLegendInterpreter', 'latex');

outputDir = fileparts(mfilename('fullpath'));

n = 1023;                 % number of unknown nodes, including the free tip
h = 1/n;
x = (h:h:1)';
K = cantileverStiffnessMatrix(n);

%% Voltage iteration - stable branch only
voltageList = [0.2:0.1:1.6, 1.65:0.025:1.825];
maxVoltageIterations = 500;
tolerance = 1e-10;

y = zeros(n, 1);
tipVoltageIteration = nan(size(voltageList));
convergedVoltageIteration = false(size(voltageList));

for i = 1:numel(voltageList)
    [y, ~, converged] = voltageIteration( ...
        K, voltageList(i), y, maxVoltageIterations, tolerance);

    tipVoltageIteration(i) = y(end);
    convergedVoltageIteration(i) = converged;

    if ~converged
        fprintf('Voltage iteration stopped converging near V = %.4f\n', voltageList(i));
        break;
    end
end

%% DIPIE - full voltage and charge equilibrium curves
tipDisplacementList = 0.01:0.01:0.99;
maxDipieIterations = 80;

voltageDipie = nan(size(tipDisplacementList));
chargeDipie = nan(size(tipDisplacementList));
dipieConvergence = nan(maxDipieIterations, numel(tipDisplacementList));

for i = 1:numel(tipDisplacementList)
    [yDipie, convergenceHistory, voltageDipie(i)] = dipieCantilever( ...
        K, tipDisplacementList(i), maxDipieIterations);

    chargeDipie(i) = normalizedCharge(x, yDipie, voltageDipie(i));
    dipieConvergence(:, i) = convergenceHistory;
end

[pullInVoltage, voltagePullInIndex] = max(voltageDipie);
tipAtVoltagePullIn = tipDisplacementList(voltagePullInIndex);

[pullInCharge, chargePullInIndex] = max(chargeDipie);
tipAtChargePullIn = tipDisplacementList(chargePullInIndex);

fprintf('\nDIPIE pull-in estimates with n = %d nodes\n', n);
fprintf('Voltage actuation: V_PI = %.6f at y_tip = %.6f\n', ...
    pullInVoltage, tipAtVoltagePullIn);
fprintf('Charge actuation:  Q_PI = %.6f at y_tip = %.6f\n', ...
    pullInCharge, tipAtChargePullIn);

%% Figures
fig1 = figure('Position', [100, 100, 600, 400]);
plot(tipVoltageIteration(convergedVoltageIteration), ...
    voltageList(convergedVoltageIteration), 'o-', 'LineWidth', 1.8);
grid on;
xlabel('tip displacement $\tilde{y}(1)$', 'FontSize', 13);
ylabel('$\tilde{V}$', 'FontSize', 13, 'Rotation', 0);
title('Voltage iteration equilibrium branch', 'FontSize', 13);
exportgraphics(fig1, fullfile(outputDir, 'cantilever_vi_equilibrium.png'), 'Resolution', 150);

fig2 = figure('Position', [100, 100, 600, 400]);
hold on;
plot(tipDisplacementList(1:voltagePullInIndex), ...
    voltageDipie(1:voltagePullInIndex), 'b-', 'LineWidth', 2.2);
plot(tipDisplacementList(voltagePullInIndex:end), ...
    voltageDipie(voltagePullInIndex:end), 'r--', 'LineWidth', 2.2);
plot(tipAtVoltagePullIn, pullInVoltage, 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 8);
grid on;
xlabel('tip displacement $\tilde{y}(1)$', 'FontSize', 13);
ylabel('$\tilde{V}$', 'FontSize', 13, 'Rotation', 0);
title('DIPIE voltage equilibrium curve', 'FontSize', 13);
legend({'stable branch', 'unstable branch', 'pull-in'}, 'Location', 'best');
exportgraphics(fig2, fullfile(outputDir, 'cantilever_dipie_voltage.png'), 'Resolution', 150);

fig3 = figure('Position', [100, 100, 600, 400]);
hold on;
plot(tipDisplacementList(1:chargePullInIndex), ...
    chargeDipie(1:chargePullInIndex), 'b-', 'LineWidth', 2.2);
plot(tipDisplacementList(chargePullInIndex:end), ...
    chargeDipie(chargePullInIndex:end), 'r--', 'LineWidth', 2.2);
plot(tipAtChargePullIn, pullInCharge, 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 8);
grid on;
xlabel('tip displacement $\tilde{y}(1)$', 'FontSize', 13);
ylabel('$\tilde{Q}$', 'FontSize', 13, 'Rotation', 0);
title('DIPIE charge equilibrium curve', 'FontSize', 13);
legend({'stable branch', 'unstable branch', 'pull-in'}, 'Location', 'best');
exportgraphics(fig3, fullfile(outputDir, 'cantilever_dipie_charge.png'), 'Resolution', 150);

%% Local functions

function K = cantileverStiffnessMatrix(n)
    % Build the finite-difference fourth-derivative matrix for a cantilever.
    %
    % Unknowns are y_1, ..., y_n, where y_n is the free tip and y_0 = 0 is
    % the clamped displacement. The stencil is [1 -4 6 -4 1].
    %
    % Boundary conditions are enforced by eliminating ghost nodes:
    %   y_{-1} = y_1                                  from y'(0) = 0
    %   y_{n+1} = 2*y_n - y_{n-1}                    from y''(1) = 0
    %   y_{n+2} = y_{n-2} - 4*y_{n-1} + 4*y_n        from y'''(1) = 0

    c = ones(n, 1);
    D4 = [c, -4*c, 6*c, -4*c, c];
    K = spdiags(D4, -2:2, n, n)';

    % Left clamp: first row contains y_{-1}; replace it by y_1.
    K(1, 1) = K(1, 1) + 1;

    % Free tip: eliminate y_{n+1} from row n-1.
    K(n - 1, n - 1) = K(n - 1, n - 1) - 1;
    K(n - 1, n) = K(n - 1, n) + 2;

    % Free tip: eliminate y_{n+1} and y_{n+2} from row n.
    K(n, n - 2) = K(n, n - 2) + 1;
    K(n, n) = K(n, n) - 4;
end

function [y, convergenceHistory, converged] = voltageIteration( ...
        K, voltage, initialGuess, maxIterations, tolerance)
    % Fixed-point voltage iteration for a prescribed voltage.
    %
    % This traces only the stable branch. Near pull-in, convergence slows
    % down; past pull-in, the voltage-controlled equilibrium disappears.

    n = size(K, 1);
    h = 1/n;
    y = initialGuess;
    convergenceHistory = nan(maxIterations, 1);
    converged = false;

    for iter = 1:maxIterations
        previousY = y;
        rhs = 0.5*h^4*voltage^2 ./ (1 - previousY).^2;
        y = K \ rhs;

        relativeChange = norm(y - previousY, inf) / max(norm(y, inf), eps);
        convergenceHistory(iter) = relativeChange;

        if relativeChange < tolerance && all(isfinite(y)) && max(y) < 1
            converged = true;
            return;
        end

        if any(~isfinite(y)) || max(y) >= 1
            return;
        end
    end
end

function [y, convergenceHistory, voltage] = dipieCantilever( ...
        K, prescribedTipDisplacement, maxIterations)
    % DIPIE iteration for a cantilever with prescribed tip displacement.
    %
    % The tip displacement is fixed. The remaining nodal displacements are
    % updated by repeatedly estimating a uniform voltage from the current
    % local nodal voltages, following the lecture DIPIE scheme.

    n = size(K, 1);
    h = 1/n;
    tipNode = n;
    freeNodes = 1:n-1;

    y = zeros(n, 1);
    y(tipNode) = prescribedTipDisplacement;

    rhs = -K(:, tipNode)*prescribedTipDisplacement;
    y(freeNodes) = K(freeNodes, freeNodes) \ rhs(freeNodes);

    convergenceHistory = nan(maxIterations, 1);
    voltageSquared = 0;

    for iter = 1:maxIterations
        previousY = y;

        localVoltageSquared = 2*(K*y)/h^4 .* (1 - y).^2;
        voltageSquared = mean(localVoltageSquared);

        forcingScale = 0.5*h^4*voltageSquared;
        rhs = forcingScale ./ (1 - y).^2 - K(:, tipNode)*prescribedTipDisplacement;

        y(freeNodes) = K(freeNodes, freeNodes) \ rhs(freeNodes);
        y(tipNode) = prescribedTipDisplacement;

        convergenceHistory(iter) = norm(y - previousY, inf) / max(norm(y, inf), eps);
    end

    voltage = sqrt(max(voltageSquared, 0));
end

function charge = normalizedCharge(x, y, voltage)
    % Normalized charge:
    %   Q = V * integral_0^1 1/(1-y(x)) dx

    xWithClamp = [0; x];
    yWithClamp = [0; y];
    capacitanceShapeFactor = trapz(xWithClamp, 1 ./ (1 - yWithClamp));
    charge = voltage * capacitanceShapeFactor;
end
