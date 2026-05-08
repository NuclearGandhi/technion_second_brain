%% MCS2 HW001 - Cantilever beam voltage iteration and DIPIE
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

n = 511;
h = 1/n;
x = (h:h:1)';
K = cantileverFourthDerivativeMatrix(n);

%% Voltage iteration - stable branch only
voltageList = [0.2:0.1:1.6, 1.65:0.025:1.825];
y = zeros(n, 1);
tipVoltageIteration = nan(size(voltageList));
convergedVoltageIteration = false(size(voltageList));

for i = 1:numel(voltageList)
    [y, info] = voltageIteration(K, voltageList(i), y, 500, 1e-10);
    tipVoltageIteration(i) = y(end);
    convergedVoltageIteration(i) = info.converged;

    if ~info.converged
        fprintf('Voltage iteration stopped converging near V = %.4f\n', voltageList(i));
        break;
    end
end

%% DIPIE - full voltage and charge equilibrium curves
tipDisplacementList = linspace(0.01, 0.98, 250);
voltageDipie = nan(size(tipDisplacementList));
chargeDipie = nan(size(tipDisplacementList));
reactionTip = nan(size(tipDisplacementList));

for i = 1:numel(tipDisplacementList)
    [yDipie, voltageDipie(i), info] = dipieCantilever(K, tipDisplacementList(i), 700, 1e-11);
    chargeDipie(i) = normalizedCharge(x, yDipie, voltageDipie(i));
    reactionTip(i) = info.reaction(end);
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
fprintf('Max absolute DIPIE tip reaction residual: %.3e\n', max(abs(reactionTip)));

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
function K = cantileverFourthDerivativeMatrix(n)
    % Unknowns are y_1, ..., y_n. The clamped node y_0 is eliminated.
    % Free-end ghost nodes are eliminated using y''_n = 0 and y'''_n = 0.
    K = spalloc(n, n, 5*n);

    for i = 1:n
        indices = i + (-2:2);
        values = [1, -4, 6, -4, 1];
        row = containers.Map('KeyType', 'double', 'ValueType', 'double');

        for j = 1:numel(indices)
            row(indices(j)) = getOrZero(row, indices(j)) + values(j);
        end

        if isKey(row, -1)
            row(1) = getOrZero(row, 1) + row(-1);
            remove(row, -1);
        end

        if isKey(row, 0)
            remove(row, 0);
        end

        if isKey(row, n + 1)
            c = row(n + 1);
            row(n) = getOrZero(row, n) + 2*c;
            row(n - 1) = getOrZero(row, n - 1) - c;
            remove(row, n + 1);
        end

        if isKey(row, n + 2)
            c = row(n + 2);
            row(n - 2) = getOrZero(row, n - 2) + c;
            row(n - 1) = getOrZero(row, n - 1) - 4*c;
            row(n) = getOrZero(row, n) + 4*c;
            remove(row, n + 2);
        end

        keysInRow = cell2mat(keys(row));
        for j = 1:numel(keysInRow)
            col = keysInRow(j);
            if col >= 1 && col <= n
                K(i, col) = row(col);
            end
        end
    end
end

function value = getOrZero(mapObject, key)
    if isKey(mapObject, key)
        value = mapObject(key);
    else
        value = 0;
    end
end

function [y, info] = voltageIteration(K, voltage, initialGuess, maxIterations, tolerance)
    n = size(K, 1);
    h = 1/n;
    y = initialGuess;
    info.converged = false;
    info.iterations = maxIterations;

    for iter = 1:maxIterations
        previousY = y;
        rhs = 0.5*h^4*voltage^2 ./ (1 - previousY).^2;
        y = K \ rhs;

        relativeChange = norm(y - previousY, inf) / max(norm(y, inf), eps);
        if relativeChange < tolerance && all(isfinite(y)) && max(y) < 1
            info.converged = true;
            info.iterations = iter;
            return;
        end

        if any(~isfinite(y)) || max(y) >= 1
            return;
        end
    end
end

function [y, voltage, info] = dipieCantilever(K, prescribedTipDisplacement, maxIterations, tolerance)
    n = size(K, 1);
    h = 1/n;
    tipNode = n;
    activeNodes = 1:n-1;

    y = zeros(n, 1);
    y(tipNode) = prescribedTipDisplacement;
    y(activeNodes) = K(activeNodes, activeNodes) \ ...
        (-K(activeNodes, tipNode)*prescribedTipDisplacement);

    localVoltageSquared = 2*(K*y)/h^4 .* (1 - y).^2;
    voltageSquared = max(mean(localVoltageSquared), eps);
    info.converged = false;
    info.iterations = maxIterations;

    for iter = 1:maxIterations
        residual = K*y - 0.5*h^4*voltageSquared ./ (1 - y).^2;

        if norm(residual, inf) < tolerance
            info.converged = true;
            info.iterations = iter;
            break;
        end

        diagonalCorrection = -h^4*voltageSquared ./ (1 - y).^3;
        displacementJacobian = K(:, activeNodes) + ...
            sparse(activeNodes, activeNodes, diagonalCorrection(activeNodes), n, n-1);
        voltageJacobian = -0.5*h^4 ./ (1 - y).^2;
        jacobian = [displacementJacobian, voltageJacobian];

        step = -jacobian \ residual;

        stepScale = 1;
        for lineSearchIter = 1:12
            trialY = y;
            trialY(activeNodes) = y(activeNodes) + stepScale*step(1:end-1);
            trialY(tipNode) = prescribedTipDisplacement;
            trialVoltageSquared = voltageSquared + stepScale*step(end);

            if trialVoltageSquared > 0 && max(trialY) < 1
                trialResidual = K*trialY ...
                    - 0.5*h^4*trialVoltageSquared ./ (1 - trialY).^2;
                if norm(trialResidual, inf) < norm(residual, inf)
                    y = trialY;
                    voltageSquared = trialVoltageSquared;
                    break;
                end
            end

            stepScale = 0.5*stepScale;
        end
    end

    voltage = sqrt(max(voltageSquared, 0));
    rhs = 0.5*h^4*voltage^2 ./ (1 - y).^2;
    info.reaction = (K*y - rhs)/h^4;
end

function charge = normalizedCharge(x, y, voltage)
    xWithClamp = [0; x];
    yWithClamp = [0; y];
    capacitanceShapeFactor = trapz(xWithClamp, 1 ./ (1 - yWithClamp));
    charge = voltage * capacitanceShapeFactor;
end
