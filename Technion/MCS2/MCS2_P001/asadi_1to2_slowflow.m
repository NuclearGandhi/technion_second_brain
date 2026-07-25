%% Asadi et al. (2021): 1:2 internal resonance, low-mode excitation
% Educational reconstruction of Fig. 4(a,b) using the four-state slow flow.
% Figure 4 reports only |alpha1| and |alpha2|. The opposite relative sign
% used below recovers the published M-shaped branch topology. This choice is
% not compatible with treating Eq. (8) literally as one common conservative
% interaction numerator; the ambiguity is documented in the master note.
%
% State convention:
%   z_j = p_j + i*q_j = a_j*exp(i*beta_j), theta = 2*beta1-beta2.
% The Cartesian equations used for stability are regular when an amplitude
% vanishes and are algebraically equivalent to the polar slow flow.

close all; clc;

set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
set(groot, 'defaultTextInterpreter', 'latex');
set(groot, 'defaultLegendInterpreter', 'latex');
set(groot, 'defaultAxesToolbarVisible', 'off');

out_dir = fileparts(mfilename('fullpath'));

%% Figure 4 parameters
par.omega1 = 1;
par.omega2 = 2;
par.zeta1 = 1e-3;
par.zeta2 = 1e-3;
par.alpha1 = -0.87;
par.alpha2 = 0.25;
par.lambda = 0.1;
par.sigma1 = 0.01;

detuning = linspace(-0.03, 0.03, 601);
wF_frequency = 5e-4;
frequency = solve_frequency_family(detuning, wF_frequency, par);

force_values = linspace(0, 6e-3, 601);
sigma2_force = -0.015;
force_sweep = solve_force_family(force_values, sigma2_force, par);

validate_family(frequency, 'LME frequency family');
validate_family(force_sweep, 'LME force family');

plot_frequency_response(frequency, out_dir);
plot_amplitude_phase_response(frequency, out_dir);
plot_force_response(force_sweep, out_dir);
plot_energy_fraction(force_sweep, par, out_dir);

fprintf('Saved 1:2 slow-flow SVG figures in:\n  %s\n', out_dir);

%% Families of equilibria
function family = solve_frequency_family(detuning, wF, par)
    family = empty_family(detuning);
    for idx = 1:numel(detuning)
        states = steady_states(detuning(idx), wF, par);
        family = insert_states(family, idx, states, detuning(idx), wF, par);
    end
end

function family = solve_force_family(force_values, sigma2, par)
    family = empty_family(force_values);
    for idx = 1:numel(force_values)
        states = steady_states(sigma2, force_values(idx), par);
        family = insert_states(family, idx, states, sigma2, force_values(idx), par);
    end
end

function family = empty_family(parameter)
    n = numel(parameter);
    max_branches = 3; % cubic in a1^2
    family.parameter = parameter;
    family.a1 = nan(max_branches, n);
    family.a2 = nan(max_branches, n);
    family.state = nan(4, max_branches, n);
    family.max_real_eigenvalue = nan(max_branches, n);
    family.stable = false(max_branches, n);
    family.residual = nan(max_branches, n);
end

function family = insert_states(family, idx, states, sigma2, wF, par)
    for branch = 1:size(states, 2)
        x = states(:, branch);
        eig_values = eig(numerical_jacobian( ...
            @(state) slow_flow(state, sigma2, wF, par), x));
        max_real = max(real(eig_values));

        family.a1(branch, idx) = hypot(x(1), x(2));
        family.a2(branch, idx) = hypot(x(3), x(4));
        family.state(:, branch, idx) = x;
        family.max_real_eigenvalue(branch, idx) = max_real;
        family.stable(branch, idx) = max_real < -1e-8;
        family.residual(branch, idx) = norm(slow_flow(x, sigma2, wF, par), inf);
    end
end

function states = steady_states(sigma2, wF, par)
    % Eliminating phases gives the cubic in x=a1^2 from Eq. (11).
    Lambda = par.lambda * wF;
    Delta = (par.omega2 / par.omega1) * ...
        (sigma2 - par.sigma1 / 2);
    D2 = par.zeta2^2 + Delta^2;

    coefficients = [ ...
        par.alpha1^2 * par.alpha2^2 / D2, ...
        2 * par.alpha1 * par.alpha2 * ...
            (-par.zeta1 * par.zeta2 + sigma2 * Delta) / D2, ...
        par.zeta1^2 + sigma2^2, ...
        -Lambda^2];

    x_roots = real_nonnegative_roots(coefficients);
    states = nan(4, numel(x_roots));

    for idx = 1:numel(x_roots)
        x = x_roots(idx);
        a1 = sqrt(x);
        a2 = abs(par.alpha2) * x / sqrt(D2);

        if a1 < 1e-12
            states(:, idx) = zeros(4, 1);
            continue;
        end

        % Mode 2 fixes theta; mode 1 then fixes the force-relative phase.
        theta = atan2(par.zeta2 / par.alpha2, Delta / par.alpha2);
        sin_beta1 = a1 * (-par.zeta1 + ...
            par.alpha1 * a2 * sin(theta)) / max(Lambda, eps);
        cos_beta1 = a1 * (sigma2 + ...
            par.alpha1 * a2 * cos(theta)) / max(Lambda, eps);
        beta1 = atan2(sin_beta1, cos_beta1);
        beta2 = 2 * beta1 - theta;

        states(:, idx) = [a1 * cos(beta1); a1 * sin(beta1); ...
            a2 * cos(beta2); a2 * sin(beta2)];
    end

    [~, order] = sort(hypot(states(1, :), states(2, :)));
    states = states(:, order);
end

function values = real_nonnegative_roots(coefficients)
    first = find(coefficients ~= 0, 1, 'first');
    if isempty(first)
        values = [];
        return;
    end

    candidate = roots(coefficients(first:end));
    tolerance = 1e-8 * max(1, max(abs(candidate)));
    candidate = real(candidate(abs(imag(candidate)) <= tolerance));
    candidate = candidate(candidate >= -tolerance);
    if isempty(candidate)
        values = [];
        return;
    end
    candidate = sort(max(candidate(:), 0));
    keep = [true; diff(candidate) > ...
        1e-9 * max(1e-12, abs(candidate(2:end)))];
    values = candidate(keep).';
end

%% Corrected four-dimensional slow flow
function dx = slow_flow(x, sigma2, wF, par)
    p1 = x(1); q1 = x(2); p2 = x(3); q2 = x(4);
    Lambda = par.lambda * wF;
    Delta = (par.omega2 / par.omega1) * ...
        (sigma2 - par.sigma1 / 2);

    dx = zeros(4, 1);
    dx(1) = -par.zeta1 * p1 - sigma2 * q1 ...
        - par.alpha1 * (p1 * q2 - p2 * q1);
    dx(2) = sigma2 * p1 - par.zeta1 * q1 ...
        + par.alpha1 * (p1 * p2 + q1 * q2) - Lambda;
    dx(3) = -par.zeta2 * p2 - Delta * q2 ...
        + 2 * par.alpha2 * p1 * q1;
    dx(4) = Delta * p2 - par.zeta2 * q2 ...
        - par.alpha2 * (p1^2 - q1^2);
end

function J = numerical_jacobian(fun, x)
    n = numel(x);
    J = zeros(n);
    for idx = 1:n
        step = 1e-6 * max(1, abs(x(idx)));
        offset = zeros(n, 1);
        offset(idx) = step;
        J(:, idx) = (fun(x + offset) - fun(x - offset)) / (2 * step);
    end
end

function validate_family(family, label)
    residuals = family.residual(isfinite(family.residual));
    if isempty(residuals)
        error('asadiLME:noStates', '%s contains no finite states.', label);
    end

    maximum_residual = max(residuals);
    if maximum_residual > 1e-8
        error('asadiLME:invalidEquilibrium', ...
            '%s has maximum slow-flow residual %.3e.', ...
            label, maximum_residual);
    end

    fprintf('PASS: %s residual <= %.3e\n', label, maximum_residual);
end

%% Figures
function plot_frequency_response(family, out_dir)
    fig = new_figure();
    tiledlayout(2, 1, 'TileSpacing', 'compact');

    ax1 = nexttile;
    plot_branches(ax1, family.parameter, family.a1, family.stable, [0.80, 0.12, 0.12]);
    ylabel(ax1, '$a_1$ (driven LM)');
    title(ax1, '1:2 internal resonance: detuning response');

    ax2 = nexttile;
    plot_branches(ax2, family.parameter, family.a2, family.stable, [0.10, 0.35, 0.85]);
    xlabel(ax2, 'External detuning $\sigma_2$');
    ylabel(ax2, '$a_2$ (IRM)');

    add_stability_legend(ax1);
    export_svg(fig, out_dir, 'p001_asadi_1to2_detuning_response.svg');
end

function plot_amplitude_phase_response(family, out_dir)
    beta1 = squeeze(atan2(family.state(2, :, :), family.state(1, :, :)));
    beta2 = squeeze(atan2(family.state(4, :, :), family.state(3, :, :)));
    beta2(family.a2 < 1e-10) = NaN;

    fig = figure('Position', [100, 100, 900, 650], 'Color', 'w');
    tiledlayout(2, 2, 'TileSpacing', 'compact');

    ax1 = nexttile;
    plot_branches(ax1, family.parameter, family.a1, family.stable, [0.80, 0.12, 0.12]);
    ylabel(ax1, '$a_1$ (driven LM)');
    title(ax1, 'Dimensionless LME amplitude');

    ax2 = nexttile;
    plot_branches(ax2, family.parameter, family.a2, family.stable, [0.10, 0.35, 0.85]);
    ylabel(ax2, '$a_2$ (partner HM)');
    title(ax2, 'Partner activation');

    ax3 = nexttile;
    plot_phase_branches(ax3, family.parameter, beta1, family.stable, [0.80, 0.12, 0.12]);
    xlabel(ax3, 'External detuning $\sigma_2$');
    ylabel(ax3, '$\beta_1/\pi$');
    title(ax3, 'LM phase relative to drive');

    ax4 = nexttile;
    plot_phase_branches(ax4, family.parameter, beta2, family.stable, [0.10, 0.35, 0.85]);
    xlabel(ax4, 'External detuning $\sigma_2$');
    ylabel(ax4, '$\beta_2/\pi$');
    title(ax4, 'HM phase at $2\Omega$');

    add_stability_legend(ax1);
    export_svg(fig, out_dir, 'p001_quadratic_spring_lme.svg');
end

function plot_force_response(family, out_dir)
    fig = new_figure();
    hold on; box on; grid on;
    plot_branches(gca, family.parameter, family.a1, family.stable, [0.80, 0.12, 0.12]);
    plot_branches(gca, family.parameter, family.a2, family.stable, [0.10, 0.35, 0.85]);
    xlabel('Drive amplitude $w_F$');
    ylabel('Steady-state amplitude');
    title('1:2 force sweep at $\sigma_2=-0.015$');
    legend({...
        '$a_1$ stable', '$a_1$ unstable', ...
        '$a_2$ stable', '$a_2$ unstable'}, 'Location', 'northwest');
    export_svg(fig, out_dir, 'p001_asadi_1to2_force_activation.svg');
end

function plot_energy_fraction(family, par, out_dir)
    denominator = par.omega1^2 * family.a1.^2 + ...
        par.omega2^2 * family.a2.^2;
    fraction = par.omega2^2 * family.a2.^2 ./ denominator;

    fig = new_figure();
    plot_branches(gca, family.parameter, fraction, family.stable, [0.20, 0.55, 0.25]);
    xlabel('Drive amplitude $w_F$');
    ylabel('$E_2/(E_1+E_2)$');
    title('1:2 harmonic modal-energy fraction');
    ylim([0, 1]);
    add_stability_legend(gca);
    export_svg(fig, out_dir, 'p001_asadi_1to2_energy_fraction.svg');
end

function handles = plot_branches(ax, parameter, amplitude, stable, color)
    hold(ax, 'on'); box(ax, 'on'); grid(ax, 'on');
    handles = gobjects(2, 1);
    for branch = 1:size(amplitude, 1)
        stable_data = amplitude(branch, :);
        stable_data(~stable(branch, :)) = NaN;
        unstable_data = amplitude(branch, :);
        unstable_data(stable(branch, :)) = NaN;
        stable_data = break_discontinuous_connections(stable_data);
        unstable_data = break_discontinuous_connections(unstable_data);
        h1 = plot(ax, parameter, stable_data, '-', 'Color', color, 'LineWidth', 2.2);
        h2 = plot(ax, parameter, unstable_data, '--', 'Color', color, 'LineWidth', 1.8);
        if branch == 1
            handles = [h1; h2];
        else
            set([h1, h2], 'HandleVisibility', 'off');
        end
    end
end

function plot_phase_branches(ax, parameter, phase, stable, color)
    hold(ax, 'on'); box(ax, 'on'); grid(ax, 'on');
    for branch = 1:size(phase, 1)
        stable_data = phase(branch, :) / pi;
        stable_data(~stable(branch, :)) = NaN;
        unstable_data = phase(branch, :) / pi;
        unstable_data(stable(branch, :)) = NaN;
        stable_data = break_phase_connections(stable_data);
        unstable_data = break_phase_connections(unstable_data);
        h1 = plot(ax, parameter, stable_data, '-', 'Color', color, 'LineWidth', 2.2);
        h2 = plot(ax, parameter, unstable_data, '--', 'Color', color, 'LineWidth', 1.8);
        if branch > 1
            set([h1, h2], 'HandleVisibility', 'off');
        end
    end
    ylim(ax, [-1, 1]);
end

function data = break_discontinuous_connections(data)
    finite_values = data(isfinite(data));
    if numel(finite_values) < 3
        return;
    end
    span = max(finite_values) - min(finite_values);
    steps = abs(diff(data));
    finite_steps = steps(isfinite(steps) & steps > 0);
    if isempty(finite_steps)
        return;
    end
    threshold = max(0.08 * span, 20 * median(finite_steps));
    data([false, steps > threshold]) = NaN;
end

function data = break_phase_connections(data)
    steps = abs(diff(data));
    data([false, steps > 0.75]) = NaN;
    data = break_discontinuous_connections(data);
end

function add_stability_legend(ax)
    legend(ax, {'Stable', 'Unstable'}, 'Location', 'best');
end

function fig = new_figure()
    fig = figure('Position', [100, 100, 700, 520], 'Color', 'w');
end

function export_svg(fig, out_dir, filename)
    drawnow;
    print(fig, fullfile(out_dir, filename), '-dsvg', '-painters');
    close(fig);
end
