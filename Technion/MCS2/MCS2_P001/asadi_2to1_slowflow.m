%% Asadi et al. (2021): 2:1 internal resonance, high-mode excitation
% Educational reconstruction of Fig. 4(c,d) from Supplementary Eqs.
% (S4)-(S8). The barred HME coefficients used below satisfy
% alpha_bar_i=2*alpha_i and lambda_bar=2*lambda relative to LME.
%
% Starting model and normalization:
%   q1dd + 2*zeta1*q1d + omega1^2*q1 + 2*kappa*q1*q2 = 0
%   q2dd + 2*zeta2*q2d + omega2^2*q2 + kappa*q1^2 = F*cos(Omega*t)
% follow from the common interaction potential V_int=kappa*q1^2*q2 before
% the paper's modal and slow-time scaling. Figure 4 reports only coefficient
% magnitudes. The opposite relative sign used below recovers its published
% branch and saturation topology, but is not compatible with interpreting
% Eq. (8) literally as one common conservative interaction numerator. This
% unresolved sign ambiguity is documented in the master note.
%
% State convention: z_j=p_j+i*q_j=a_j*exp(i*beta_j),
% theta=2*beta1-beta2. Cartesian variables avoid the phase singularity of
% the unactivated a1=0 branch and permit a regular numerical Jacobian.

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
par.alpha1 = -1.74;
par.alpha2 = 0.5;
par.lambda = 0.2;
par.sigma1 = 0.01;

detuning = linspace(-0.15, 0.15, 1201);
wF_frequency = 5e-4;
frequency = solve_frequency_family(detuning, wF_frequency, par);

force_values = linspace(0, 1e-3, 601);
sigma2_force = -0.02;
force_sweep = solve_force_family(force_values, sigma2_force, par);

validate_family(frequency, 'HME frequency family');
validate_family(force_sweep, 'HME force family');

plot_frequency_response(frequency, out_dir);
plot_amplitude_phase_response(frequency, par, out_dir);
plot_velocity_amplitude_phase_response(frequency, par, out_dir);
plot_force_response(force_sweep, out_dir);
plot_energy_fraction(force_sweep, par, out_dir);

fprintf('Saved 2:1 slow-flow SVG figures in:\n  %s\n', out_dir);

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
    max_branches = 3; % trivial branch plus at most two activated roots
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
    Lambda = par.lambda * wF;
    delta1 = (par.omega1 / par.omega2) * (par.sigma1 + sigma2);

    % The a1=0 linear response exists for every forcing level.
    linear_denominator = par.zeta2^2 + sigma2^2;
    p2 = sigma2 * Lambda / linear_denominator;
    q2 = -par.zeta2 * Lambda / linear_denominator;
    states = [0; 0; p2; q2];

    % Activated response: Eq. (14), written as a quadratic in x=a1^2.
    a2_squared = (par.zeta1^2 + delta1^2) / par.alpha1^2;
    a2 = sqrt(a2_squared);
    coefficients = [ ...
        (par.alpha1 * par.alpha2)^2, ...
        -2 * par.alpha1 * par.alpha2 * ...
            (par.zeta1 * par.zeta2 - sigma2 * delta1), ...
        (par.zeta2^2 + sigma2^2) * ...
            (par.zeta1^2 + delta1^2) - par.alpha1^2 * Lambda^2];
    x_roots = real_nonnegative_roots(coefficients);

    for idx = 1:numel(x_roots)
        x = x_roots(idx);
        if x < 1e-12
            continue;
        end

        % Low-mode equations fix theta. The driven high-mode equations
        % then fix beta2, leaving the equivalent beta1 and beta1+pi pair.
        theta = atan2(par.zeta1 / par.alpha1, ...
            -delta1 / par.alpha1);
        sin_beta2 = (-par.zeta2 * a2 + ...
            par.alpha2 * x * sin(theta)) / max(Lambda, eps);
        cos_beta2 = (sigma2 * a2 - ...
            par.alpha2 * x * cos(theta)) / max(Lambda, eps);
        beta2 = atan2(sin_beta2, cos_beta2);
        beta1 = (theta + beta2) / 2;
        a1 = sqrt(x);

        activated = [a1 * cos(beta1); a1 * sin(beta1); ...
            a2 * cos(beta2); a2 * sin(beta2)];
        states(:, end + 1) = activated; %#ok<AGROW>
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

%% Averaged Cartesian model derived from V_int=kappa*q1^2*q2
function dx = slow_flow(x, sigma2, wF, par)
    p1 = x(1); q1 = x(2); p2 = x(3); q2 = x(4);
    delta1 = (par.omega1 / par.omega2) * (par.sigma1 + sigma2);
    Lambda = par.lambda * wF;

    % Complex form:
    % z1dot=(-zeta1+i*delta1)z1+i*alpha1*conj(z1)*z2
    % z2dot=(-zeta2+i*sigma2)z2-i*alpha2*z1^2-i*Lambda
    dx = zeros(4, 1);
    dx(1) = -par.zeta1 * p1 - delta1 * q1 ...
        - par.alpha1 * (p1 * q2 - q1 * p2);
    dx(2) = delta1 * p1 - par.zeta1 * q1 ...
        + par.alpha1 * (p1 * p2 + q1 * q2);
    dx(3) = -par.zeta2 * p2 - sigma2 * q2 ...
        + 2 * par.alpha2 * p1 * q1;
    dx(4) = sigma2 * p2 - par.zeta2 * q2 ...
        - par.alpha2 * (p1^2 - q1^2) - Lambda;
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
        error('asadiHME:noStates', '%s contains no finite states.', label);
    end

    maximum_residual = max(residuals);
    if maximum_residual > 1e-8
        error('asadiHME:invalidEquilibrium', ...
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
    plot_branches(ax1, family.parameter, family.a2, family.stable, [0.80, 0.12, 0.12]);
    ylabel(ax1, '$a_2$ (driven HM)');
    title(ax1, '2:1 internal resonance: detuning response');

    ax2 = nexttile;
    plot_branches(ax2, family.parameter, family.a1, family.stable, [0.10, 0.35, 0.85]);
    xlabel(ax2, 'External detuning $\sigma_2$');
    ylabel(ax2, '$a_1$ (IRM)');

    add_stability_legend(ax1);
    export_svg(fig, out_dir, 'p001_asadi_2to1_detuning_response.svg');
end

function plot_amplitude_phase_response(family, par, out_dir)
    [freq_lm, freq_hm, beta1_deg, beta2_deg] = ...
        hme_response_coordinates(family, par);

    fig = figure('Position', [100, 100, 900, 650], 'Color', 'w');
    tiledlayout(2, 2, 'TileSpacing', 'compact');

    ax1 = nexttile;
    plot_branches(ax1, freq_hm, family.a2, family.stable, [0.80, 0.12, 0.12]);
    ylabel(ax1, '$a_2$ (driven HM)');
    title(ax1, 'HME displacement amplitude');

    ax2 = nexttile;
    plot_branches(ax2, freq_lm, family.a1, family.stable, [0.10, 0.35, 0.85]);
    ylabel(ax2, '$a_1$ (partner LM)');
    title(ax2, 'Partner activation at $\Omega/2$');

    ax3 = nexttile;
    plot_phase_branches(ax3, freq_hm, beta2_deg, family.stable, ...
        [0.80, 0.12, 0.12], [-90, 90]);
    xlabel(ax3, 'HM response frequency $\Omega/\omega_1$');
    ylabel(ax3, '$\beta_2$ (deg)');
    title(ax3, 'HM displacement phase');

    ax4 = nexttile;
    plot_phase_branches(ax4, freq_lm, beta1_deg, family.stable, ...
        [0.10, 0.35, 0.85], [-90, 90]);
    xlabel(ax4, 'LM response frequency $(\Omega/2)/\omega_1$');
    ylabel(ax4, '$\beta_1$ (deg)');
    title(ax4, 'LM displacement phase');

    add_stability_legend(ax1);
    export_svg(fig, out_dir, 'p001_quadratic_spring_hme.svg');
end

function plot_velocity_amplitude_phase_response(family, par, out_dir)
    [freq_lm, freq_hm, beta1_deg, beta2_deg] = ...
        hme_response_coordinates(family, par);
    Omega = par.omega2 + family.parameter;

    v2 = Omega .* family.a2;
    v1 = (Omega / 2) .* family.a1;
    phi2_deg = wrap_to_pm90(beta2_deg - 90);
    phi1_deg = wrap_to_pm90(beta1_deg - 90);
    phi1_deg(family.a1 < 1e-10) = NaN;

    fig = figure('Position', [100, 100, 900, 650], 'Color', 'w');
    tiledlayout(2, 2, 'TileSpacing', 'compact');

    ax1 = nexttile;
    plot_branches(ax1, freq_hm, v2, family.stable, [0.80, 0.12, 0.12]);
    ylabel(ax1, '$\Omega a_2$ (driven HM)');
    title(ax1, 'HME velocity amplitude');

    ax2 = nexttile;
    plot_branches(ax2, freq_lm, v1, family.stable, [0.10, 0.35, 0.85]);
    ylabel(ax2, '$(\Omega/2)a_1$ (partner LM)');
    title(ax2, 'Partner velocity at $\Omega/2$');

    ax3 = nexttile;
    plot_phase_branches(ax3, freq_hm, phi2_deg, family.stable, ...
        [0.80, 0.12, 0.12], [-90, 90]);
    xlabel(ax3, 'HM response frequency $\Omega/\omega_1$');
    ylabel(ax3, '$\phi_2$ (deg)');
    title(ax3, 'HM velocity phase');

    ax4 = nexttile;
    plot_phase_branches(ax4, freq_lm, phi1_deg, family.stable, ...
        [0.10, 0.35, 0.85], [-90, 90]);
    xlabel(ax4, 'LM response frequency $(\Omega/2)/\omega_1$');
    ylabel(ax4, '$\phi_1$ (deg)');
    title(ax4, 'LM velocity phase');

    add_stability_legend(ax1);
    export_svg(fig, out_dir, 'p001_quadratic_spring_hme_velocity.svg');
end

function [freq_lm, freq_hm, beta1_deg, beta2_deg] = ...
        hme_response_coordinates(family, par)
    Omega = par.omega2 + family.parameter;
    freq_hm = Omega;
    freq_lm = Omega / 2;
    beta1_deg = rad2deg(squeeze(atan2( ...
        family.state(2, :, :), family.state(1, :, :))));
    beta2_deg = rad2deg(squeeze(atan2( ...
        family.state(4, :, :), family.state(3, :, :))));
    beta1_deg(family.a1 < 1e-10) = NaN;
end

function phase = wrap_to_pm90(phase)
    phase = mod(phase + 90, 180) - 90;
end

function plot_force_response(family, out_dir)
    fig = new_figure();
    hold on; box on; grid on;
    plot_branches(gca, family.parameter, family.a2, family.stable, [0.80, 0.12, 0.12]);
    plot_branches(gca, family.parameter, family.a1, family.stable, [0.10, 0.35, 0.85]);
    xlabel('Drive amplitude $w_F$');
    ylabel('Steady-state amplitude');
    title('2:1 force sweep and saturation at $\sigma_2=-0.02$');
    legend({...
        '$a_2$ stable', '$a_2$ unstable', ...
        '$a_1$ stable', '$a_1$ unstable'}, 'Location', 'northwest');
    export_svg(fig, out_dir, 'p001_asadi_2to1_force_saturation.svg');
end

function plot_energy_fraction(family, par, out_dir)
    denominator = par.omega1^2 * family.a1.^2 + ...
        par.omega2^2 * family.a2.^2;
    fraction = par.omega1^2 * family.a1.^2 ./ denominator;

    fig = new_figure();
    plot_branches(gca, family.parameter, fraction, family.stable, [0.20, 0.55, 0.25]);
    xlabel('Drive amplitude $w_F$');
    ylabel('$E_1/(E_1+E_2)$');
    title('2:1 harmonic modal-energy fraction');
    ylim([0, 1]);
    add_stability_legend(gca);
    export_svg(fig, out_dir, 'p001_asadi_2to1_energy_fraction.svg');
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

function plot_phase_branches(ax, parameter, phase_deg, stable, color, phase_limits)
    if nargin < 6
        phase_limits = [-90, 90];
    end
    hold(ax, 'on'); box(ax, 'on'); grid(ax, 'on');
    for branch = 1:size(phase_deg, 1)
        stable_data = phase_deg(branch, :);
        stable_data(~stable(branch, :)) = NaN;
        unstable_data = phase_deg(branch, :);
        unstable_data(stable(branch, :)) = NaN;
        stable_data = break_phase_connections(stable_data);
        unstable_data = break_phase_connections(unstable_data);
        h1 = plot(ax, parameter, stable_data, '-', 'Color', color, 'LineWidth', 2.2);
        h2 = plot(ax, parameter, unstable_data, '--', 'Color', color, 'LineWidth', 1.8);
        if branch > 1
            set([h1, h2], 'HandleVisibility', 'off');
        end
    end
    ylim(ax, phase_limits);
    yticks(ax, phase_limits(1):45:phase_limits(2));
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
    data([false, steps > 75]) = NaN;
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
