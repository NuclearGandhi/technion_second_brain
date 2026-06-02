%% Experimental Validation of Electromechanical Buckling
% Generates normalized EMB response plots for Lecture 4.

clear; close all; clc;

set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
set(groot, 'defaultTextInterpreter', 'latex');
set(groot, 'defaultLegendInterpreter', 'latex');

out_dir = fileparts(mfilename('fullpath'));

%% Critical EMB curve
n_points = 240;
lambda = linspace(1e-4, 8.0, n_points);
Lambda = zeros(size(lambda));

Lambda_guess = 2*pi;
for i = 1:numel(lambda)
    Lambda(i) = solve_Lambda(lambda(i), Lambda_guess);
    Lambda_guess = Lambda(i);
end

Vcr = lambda .* Lambda;
p_tilde = lambda.^2 - Lambda.^2;
p_norm = p_tilde / (2*pi)^2;

%% Figure 1: Critical EMB curve
fig1 = figure('Position', [100, 100, 600, 400]);
hold on;

plot(p_norm, Vcr, 'b-', 'LineWidth', 2.8);
plot([-1.1 1.15], [0 0], 'k-', 'LineWidth', 1.0);
plot([-1 -1], [0 max(Vcr)*0.18], 'k:', 'LineWidth', 1.0);

xlabel('$p_{cr}/|p_{Eu}|$', 'FontSize', 15);
ylabel('$\tilde{V}_{cr}$', 'FontSize', 15, 'Rotation', 0);
title('critical EMB curve', 'FontSize', 14, 'FontWeight', 'bold');
grid on;
set(gca, 'FontSize', 12);
xlim([-1.1 1.15]);
ylim([0 34]);

text(-0.94, 29.0, 'ElectroMechanical', ...
    'FontSize', 13, 'FontWeight', 'bold', 'FontAngle', 'italic');
text(-0.68, 24.8, 'Buckling', ...
    'FontSize', 13, 'FontWeight', 'bold', 'FontAngle', 'italic');
text(0.05, 11.0, 'No buckling', ...
    'FontSize', 13, 'FontWeight', 'bold', 'FontAngle', 'italic');

exportgraphics(fig1, fullfile(out_dir, 'emb_critical_curve.svg'), ...
    'ContentType', 'vector');

%% Critical gap curve
gcr_over_L = zeros(size(lambda));
x = linspace(0, 1, 1200);

for i = 1:numel(lambda)
    mode = buckling_mode(lambda(i), Lambda(i));
    [y, dy, d2y] = evaluate_mode(mode, lambda(i), Lambda(i), x);

    numerator = Vcr(i)^2 * trapz(x, y.^4);
    denominator = trapz(x, d2y.^2 .* dy.^2) ...
        + 0.25 * p_tilde(i) * trapz(x, dy.^4);

    if denominator > 0
        gcr_over_L(i) = sqrt(numerator / denominator);
    else
        gcr_over_L(i) = NaN;
    end
end

%% Figure 2: Critical gap for unstable post-EMB
fig2 = figure('Position', [100, 100, 600, 400]);
hold on;

plot(p_norm, gcr_over_L, 'b-', 'LineWidth', 2.8);
plot([-1.1 1.15], [0 0], 'k-', 'LineWidth', 1.0);

xlabel('$p_{cr}/|p_{Eu}|$', 'FontSize', 15);
ylabel('$g_{cr}/L$', 'FontSize', 15, 'Rotation', 0);
title('critical gap for post-EMB stability', ...
    'FontSize', 14, 'FontWeight', 'bold');
grid on;
set(gca, 'FontSize', 12);
xlim([-1.1 1.1]);
ylim([0 0.8]);

text(-0.55, 0.68, 'Stable post-EMB', ...
    'FontSize', 13, 'FontWeight', 'bold', 'FontAngle', 'italic');
text(0.25, 0.19, 'Unstable post-EMB', ...
    'FontSize', 13, 'FontWeight', 'bold', 'FontAngle', 'italic');

exportgraphics(fig2, fullfile(out_dir, 'emb_critical_gap.svg'), ...
    'ContentType', 'vector');

fprintf('Saved figures to: %s\n', out_dir);

%% Local functions
function Lambda = solve_Lambda(lambda, Lambda_guess)
    F = @(Lam) emb_characteristic(lambda, Lam);

    bracket_width = 0.35;
    bracket = [max(1e-6, Lambda_guess - bracket_width), ...
        Lambda_guess + bracket_width];

    while sign(F(bracket(1))) == sign(F(bracket(2)))
        bracket_width = 1.5 * bracket_width;
        bracket = [max(1e-6, Lambda_guess - bracket_width), ...
            Lambda_guess + bracket_width];

        if bracket_width > 8
            Lambda = fzero(F, Lambda_guess);
            return;
        end
    end

    Lambda = fzero(F, bracket);
end

function value = emb_characteristic(lambda, Lambda)
    value = sin(Lambda) .* sinh(lambda) .* (lambda.^2 - Lambda.^2) ...
        + 2 .* lambda .* Lambda .* ...
        (1 - cos(Lambda) .* cosh(lambda));
end

function mode = buckling_mode(lambda, Lambda)
    A = [ ...
        1, 1, 1, 0; ...
        exp(lambda), exp(-lambda), cos(Lambda), sin(Lambda); ...
        lambda, -lambda, 0, Lambda; ...
        lambda*exp(lambda), -lambda*exp(-lambda), ...
            -Lambda*sin(Lambda), Lambda*cos(Lambda)];

    [~, ~, V] = svd(A);
    mode = V(:, end).';

    if real(evaluate_mode(mode, lambda, Lambda, 0.5)) < 0
        mode = -mode;
    end
end

function [y, dy, d2y] = evaluate_mode(mode, lambda, Lambda, x)
    c1 = mode(1);
    c2 = mode(2);
    c3 = mode(3);
    c4 = mode(4);

    exp_pos = exp(lambda .* x);
    exp_neg = exp(-lambda .* x);
    sin_part = sin(Lambda .* x);
    cos_part = cos(Lambda .* x);

    y = c1 .* exp_pos + c2 .* exp_neg ...
        + c3 .* cos_part + c4 .* sin_part;

    dy = lambda .* c1 .* exp_pos - lambda .* c2 .* exp_neg ...
        - Lambda .* c3 .* sin_part + Lambda .* c4 .* cos_part;

    d2y = lambda.^2 .* c1 .* exp_pos + lambda.^2 .* c2 .* exp_neg ...
        - Lambda.^2 .* c3 .* cos_part - Lambda.^2 .* c4 .* sin_part;
end
