%% Homework 6: Duffing resonator simulations (Questions 1-3)
% To run one question only, edit default_config():
%   config.run_q1 = false; config.run_q2 = false; config.run_q3 = true;

clear; close all; clc;

config = default_config();
out_dir = fileparts(mfilename('fullpath'));
setup_plotting();

if config.run_q1
    run_question_1(config, out_dir);
end

if config.run_q2
    run_question_2(config, out_dir);
end

if config.run_q3
    run_question_3(config, out_dir);
end

fprintf('\nFinished selected Homework 6 simulations.\n');

%% Configuration
function config = default_config()
    config.run_q1 = true;
    config.run_q2 = true;
    config.run_q3 = true;

    config.n_peaks = 10;
    config.peak_tol = 1e-3;
    config.max_cycles = 260;
    config.cycles_per_chunk = 20;
    config.backward_seed = "rest"; % "rest" or "forward_endpoint"

    config.q1.Q = 20;
    config.q1.f_tilde = 0.12;
    config.q1.omega = linspace(0.05, 2.5, 140);

    config.q2.Q_values = [5, 10, 20, 40];
    config.q2.fQ = 1;
    config.q2.omega = linspace(0.05, 2.5, 120);

    config.q3.Q_values = [5, 10, 20, 40];
    config.q3.f0_values = [0.02, 0.05, 0.1, 0.2];
    config.q3.y0 = [1e-3; 0];
    config.q3.t_end = 600;
    config.q3.peak_window = 5;
    config.q3.freq_response_case = [20, 0.20];
    config.q3.freq_response_t_end = 1500;
    config.q3.freq_response_peak_skip = 2;
    config.q3.example_cases = [ ...
        5,  0.20; ...
        10, 0.10; ...
        20, 0.05; ...
        40, 0.025];
end

function setup_plotting()
    set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
    set(groot, 'defaultTextInterpreter', 'latex');
    set(groot, 'defaultLegendInterpreter', 'latex');
end

%% Question 1
function run_question_1(config, out_dir)
    fprintf('\n=== Question 1 ===\n');
    fprintf('Q = %g, f_tilde = %.5g\n', config.q1.Q, config.q1.f_tilde);

    [forward, backward] = run_forward_backward_sweeps( ...
        config.q1.omega, config.q1.Q, config.q1.f_tilde, config);

    Q = config.q1.Q;
    f_tilde = config.q1.f_tilde;
    omega = config.q1.omega;
    save(fullfile(out_dir, 'hw6_q1_duffing_sweep.mat'), ...
        'Q', 'f_tilde', 'omega', 'forward', 'backward');

    fig = new_figure();
    hold on; box on; grid on;
    plot(omega, forward.amp_x / Q, 'b-', 'LineWidth', 2.4);
    plot(omega, backward.amp_x / Q, 'r--', 'LineWidth', 2.4);
    xlabel('$\tilde{\omega}$', 'FontSize', 15);
    ylabel('$A_{\tilde{x}}/Q$', 'FontSize', 15);
    title(sprintf('$Q=%g,\\ \\tilde{f}=%.3g$', Q, f_tilde), 'FontSize', 14);
    legend({'Forward sweep', 'Backward sweep'}, 'Location', 'northwest');
    export_figure(fig, out_dir, 'hw6_q1_displacement_amplitude.svg');

    fig = new_figure();
    hold on; box on; grid on;
    plot(omega, forward.amp_v / Q, 'b-', 'LineWidth', 2.4);
    plot(omega, backward.amp_v / Q, 'r--', 'LineWidth', 2.4);
    xlabel('$\tilde{\omega}$', 'FontSize', 15);
    ylabel('$A_{\tilde{v}}/Q$', 'FontSize', 15);
    title(sprintf('$Q=%g,\\ \\tilde{f}=%.3g$', Q, f_tilde), 'FontSize', 14);
    legend({'Forward sweep', 'Backward sweep'}, 'Location', 'northwest');
    export_figure(fig, out_dir, 'hw6_q1_velocity_amplitude.svg');

    fig = new_figure();
    tiledlayout(2, 1, 'TileSpacing', 'compact');

    nexttile;
    hold on; box on; grid on;
    plot(omega, rad2deg(forward.phase_x), 'b-', 'LineWidth', 2.0);
    plot(omega, rad2deg(backward.phase_x), 'r--', 'LineWidth', 2.0);
    ylabel('$\phi_{\tilde{x}}$ [deg]', 'FontSize', 14);
    legend({'Forward sweep', 'Backward sweep'}, 'Location', 'southwest');

    nexttile;
    hold on; box on; grid on;
    plot(omega, rad2deg(forward.phase_v), 'b-', 'LineWidth', 2.0);
    plot(omega, rad2deg(backward.phase_v), 'r--', 'LineWidth', 2.0);
    xlabel('$\tilde{\omega}$', 'FontSize', 15);
    ylabel('$\phi_{\tilde{v}}$ [deg]', 'FontSize', 14);
    export_figure(fig, out_dir, 'hw6_q1_phase_response.svg');
end

%% Question 2
function run_question_2(config, out_dir)
    fprintf('\n=== Question 2 ===\n');

    q2 = config.q2;
    colors = lines(numel(q2.Q_values));
    results = struct([]);

    for q_idx = 1:numel(q2.Q_values)
        Q = q2.Q_values(q_idx);
        f_tilde = q2.fQ / Q;
        fprintf('Q = %g, f_tilde = %.5g\n', Q, f_tilde);

        [forward, backward] = run_forward_backward_sweeps( ...
            q2.omega, Q, f_tilde, config);

        results(q_idx).Q = Q;
        results(q_idx).f_tilde = f_tilde;
        results(q_idx).forward = forward;
        results(q_idx).backward = backward;
    end

    Q_values = q2.Q_values;
    fQ = q2.fQ;
    omega = q2.omega;
    save(fullfile(out_dir, 'hw6_q2_duffing_sweep.mat'), ...
        'Q_values', 'fQ', 'omega', 'results');

    fig = new_figure();
    hold on; box on; grid on;
    for q_idx = 1:numel(q2.Q_values)
        scale = results(q_idx).f_tilde * results(q_idx).Q;
        color = colors(q_idx, :);
        plot(omega, results(q_idx).forward.amp_x / scale, '-', ...
            'Color', color, 'LineWidth', 2.1, ...
            'DisplayName', sprintf('$Q=%g$ forward', results(q_idx).Q));
        plot(omega, results(q_idx).backward.amp_x / scale, '--', ...
            'Color', color, 'LineWidth', 2.1, ...
            'DisplayName', sprintf('$Q=%g$ backward', results(q_idx).Q));
    end
    xlabel('$\tilde{\omega}$', 'FontSize', 15);
    ylabel('$A_{\tilde{x}}/(\tilde{f}Q)$', 'FontSize', 15);
    title('$\tilde{f}Q=1$', 'FontSize', 14);
    legend('Location', 'northeast', 'NumColumns', 1);
    export_figure(fig, out_dir, 'hw6_q2_displacement_amplitude_by_q.svg');

    fig = new_figure();
    hold on; box on; grid on;
    for q_idx = 1:numel(q2.Q_values)
        scale = results(q_idx).f_tilde * results(q_idx).Q;
        color = colors(q_idx, :);
        plot(omega, results(q_idx).forward.amp_v / scale, '-', ...
            'Color', color, 'LineWidth', 2.1, ...
            'DisplayName', sprintf('$Q=%g$ forward', results(q_idx).Q));
        plot(omega, results(q_idx).backward.amp_v / scale, '--', ...
            'Color', color, 'LineWidth', 2.1, ...
            'DisplayName', sprintf('$Q=%g$ backward', results(q_idx).Q));
    end
    xlabel('$\tilde{\omega}$', 'FontSize', 15);
    ylabel('$A_{\tilde{v}}/(\tilde{f}Q)$', 'FontSize', 15);
    title('$\tilde{f}Q=1$', 'FontSize', 14);
    legend('Location', 'northeast', 'NumColumns', 1);
    export_figure(fig, out_dir, 'hw6_q2_velocity_amplitude_by_q.svg');

    fig = new_figure();
    hold on; box on; grid on;
    for q_idx = 1:numel(q2.Q_values)
        color = colors(q_idx, :);
        plot(omega, rad2deg(results(q_idx).forward.phase_v), '-', ...
            'Color', color, 'LineWidth', 2.1, ...
            'DisplayName', sprintf('$Q=%g$ forward', results(q_idx).Q));
        plot(omega, rad2deg(results(q_idx).backward.phase_v), '--', ...
            'Color', color, 'LineWidth', 2.1, ...
            'DisplayName', sprintf('$Q=%g$ backward', results(q_idx).Q));
    end
    xlabel('$\tilde{\omega}$', 'FontSize', 15);
    ylabel('$\phi_{\tilde{v}}$ [deg]', 'FontSize', 15);
    title('$\tilde{f}Q=1$', 'FontSize', 14);
    legend('Location', 'northeast', 'NumColumns', 1);
    export_figure(fig, out_dir, 'hw6_q2_phase_by_q.svg');
end

%% Question 3
function run_question_3(config, out_dir)
    fprintf('\n=== Question 3: autoresonance ===\n');

    q3 = config.q3;
    n_q = numel(q3.Q_values);
    n_f = numel(q3.f0_values);
    results = repmat(struct('Q', [], 'f0_tilde', [], 'response', []), n_q, n_f);
    amp_x = nan(n_q, n_f);
    amp_v = nan(n_q, n_f);
    omega_inst = nan(n_q, n_f);
    Qf0 = nan(n_q, n_f);

    for q_idx = 1:n_q
        for f_idx = 1:n_f
            Q = q3.Q_values(q_idx);
            f0_tilde = q3.f0_values(f_idx);
            Qf0(q_idx, f_idx) = Q * f0_tilde;

            fprintf('Q = %g, f0_tilde = %.5g, Qf0 = %.3g, t_end = %.0f\n', ...
                Q, f0_tilde, Qf0(q_idx, f_idx), q3.t_end);

            response = simulate_autoresonance(Q, f0_tilde, q3.y0, q3.t_end, ...
                config.n_peaks, config.peak_tol);

            results(q_idx, f_idx).Q = Q;
            results(q_idx, f_idx).f0_tilde = f0_tilde;
            results(q_idx, f_idx).response = response;

            amp_x(q_idx, f_idx) = response.amp_x;
            amp_v(q_idx, f_idx) = response.amp_v;
            omega_inst(q_idx, f_idx) = response.omega;
        end
    end

    Q_values = q3.Q_values;
    f0_values = q3.f0_values;
    save(fullfile(out_dir, 'hw6_q3_autoresonance.mat'), ...
        'Q_values', 'f0_values', 'Qf0', 'results', 'amp_x', 'amp_v', 'omega_inst');

    plot_q3_time_examples(config, out_dir);
    plot_q3_amplitude_summary(config, out_dir, amp_v, amp_x, Qf0);
    plot_q3_frequency_response(config, out_dir, results);
end

function plot_q3_time_examples(config, out_dir)
    q3 = config.q3;
    n_cases = size(q3.example_cases, 1);
    responses = cell(n_cases, 1);
    plot_handles = gobjects(n_cases, 1);
    legend_labels = cell(n_cases, 1);

    for idx = 1:n_cases
        Q = q3.example_cases(idx, 1);
        f0_tilde = q3.example_cases(idx, 2);
        responses{idx} = simulate_autoresonance(Q, f0_tilde, q3.y0, q3.t_end, ...
            config.n_peaks, config.peak_tol);
        legend_labels{idx} = sprintf('$Q=%g,\\ \\tilde{f}_0=%.3g$', Q, f0_tilde);
    end

    fig = new_figure();
    tlo = tiledlayout(2, 1, 'TileSpacing', 'compact');

    ax1 = nexttile(tlo);
    hold(ax1, 'on'); box(ax1, 'on'); grid(ax1, 'on');
    for idx = 1:n_cases
        plot_handles(idx) = plot(ax1, responses{idx}.t, responses{idx}.y(:, 1), ...
            'LineWidth', 2.0);
    end
    ylabel(ax1, '$\tilde{x}$', 'FontSize', 14);

    ax2 = nexttile(tlo);
    hold(ax2, 'on'); box(ax2, 'on'); grid(ax2, 'on');
    for idx = 1:n_cases
        plot(ax2, responses{idx}.t, responses{idx}.y(:, 2), ...
            'LineWidth', 2.0, 'HandleVisibility', 'off');
    end
    xlabel(ax2, '$\tilde{t}$', 'FontSize', 15);
    ylabel(ax2, '$\tilde{v}$', 'FontSize', 14);

    lgd = legend(ax1, plot_handles, legend_labels, 'Interpreter', 'latex');
    lgd.Orientation = 'vertical';
    lgd.Position = [0.36, 0.34, 0.32, 0.30];

    export_figure(fig, out_dir, 'hw6_q3_time_examples.svg');
end

function plot_q3_amplitude_summary(config, out_dir, amp_v, amp_x, Qf0)
    q3 = config.q3;
    Qf0_vec = Qf0(:);
    amp_v_vec = amp_v(:);
    amp_x_vec = amp_x(:);

    fig = new_figure();
    hold on; box on; grid on;
    plot(Qf0_vec, amp_v_vec, 'ro', 'MarkerSize', 7, 'LineWidth', 1.5, ...
        'DisplayName', '$A_{\tilde{v}}$');
    plot(Qf0_vec, amp_x_vec, 'bs', 'MarkerSize', 7, 'LineWidth', 1.5, ...
        'DisplayName', '$A_{\tilde{x}}$');
    plot([0, max(Qf0_vec)], [0, max(Qf0_vec)], 'k--', 'LineWidth', 1.5, ...
        'DisplayName', '$A_{\tilde{v}}=Q\tilde{f}_0$');
    xlabel('$Q\tilde{f}_0$', 'FontSize', 15);
    ylabel('Final amplitude', 'FontSize', 15);
    legend('Location', 'northwest');
    export_figure(fig, out_dir, 'hw6_q3_autoresonance_qf0_collapse.svg');

    fig = new_figure();
    imagesc(q3.f0_values, q3.Q_values, amp_v);
    set(gca, 'YDir', 'normal');
    colorbar;
    xlabel('$\tilde{f}_0$', 'FontSize', 15);
    ylabel('$Q$', 'FontSize', 15);
    title('$A_{\tilde{v}}$', 'FontSize', 14);
    export_figure(fig, out_dir, 'hw6_q3_autoresonance_final_amplitude.svg');
end

function plot_q3_frequency_response(config, out_dir, ~)
    q3 = config.q3;
    Q = q3.freq_response_case(1);
    f0_tilde = q3.freq_response_case(2);
    t_end = q3.freq_response_t_end;

    fprintf('Frequency-response figure: Q=%g, f0=%g, t_end=%g\n', Q, f0_tilde, t_end);
    response = simulate_autoresonance(Q, f0_tilde, q3.y0, t_end, ...
        config.n_peaks, config.peak_tol);
    trajectory = peak_frequency_trajectory( ...
        response, q3.peak_window, q3.freq_response_peak_skip);

    amp_x_lo = max(0.01, min(trajectory.amp_x) * 0.9);
    amp_x_hi = max(trajectory.amp_x) * 1.05;
    [omega_backbone, amp_x_backbone, amp_v_backbone] = ...
        duffing_backbone_curve(amp_x_lo, amp_x_hi);

    omega_lo = min([trajectory.omega_v(:); trajectory.omega_x(:); omega_backbone(1)]);
    omega_hi = max([trajectory.omega_v(:); trajectory.omega_x(:); omega_backbone(end)]);

    fig = new_figure();
    yyaxis left;
    hold on; box on; grid on;
    plot(trajectory.omega_v, trajectory.amp_v, 'r-', 'LineWidth', 2.4, ...
        'DisplayName', 'Autoresonance, $A_{\tilde{v}}$');
    plot(omega_backbone, amp_v_backbone, 'r--', 'LineWidth', 1.8, ...
        'DisplayName', 'Backbone, $A_{\tilde{v}}$');
    ylabel('$A_{\tilde{v}}$', 'FontSize', 15);

    yyaxis right;
    plot(trajectory.omega_x, trajectory.amp_x, 'b-', 'LineWidth', 2.0, ...
        'DisplayName', 'Autoresonance, $A_{\tilde{x}}$');
    plot(omega_backbone, amp_x_backbone, 'b--', 'LineWidth', 1.8, ...
        'DisplayName', 'Backbone, $A_{\tilde{x}}$');
    ylabel('$A_{\tilde{x}}$', 'FontSize', 15);

    xlabel('$\tilde{\omega}$', 'FontSize', 15);
    xlim([omega_lo - 0.04, omega_hi + 0.04]);
    title(sprintf('$Q=%g,\\ Q\\tilde{f}_0=%.2g$', Q, Q * f0_tilde), 'FontSize', 14);
    legend('Location', 'northwest');
    export_figure(fig, out_dir, 'hw6_q3_frequency_response.svg');
end

function response = find_autoresonance_response(results, Q, f0_tilde)
    mask = arrayfun(@(entry) entry.Q == Q && entry.f0_tilde == f0_tilde, results);
    idx = find(mask, 1, 'first');

    if isempty(idx)
        error('No autoresonance result for Q=%g, f0_tilde=%g.', Q, f0_tilde);
    end

    response = results(idx).response;
end

%% Shared sweep utilities
function [forward, backward] = run_forward_backward_sweeps( ...
    omega_values, Q, f_tilde, config)

    forward = run_sweep(omega_values, [0; 0], Q, f_tilde, config);

    y0_backward = choose_backward_seed(config.backward_seed, forward);
    backward_reversed = run_sweep(fliplr(omega_values), y0_backward, ...
        Q, f_tilde, config);
    backward = reverse_sweep(backward_reversed);
end

function result = run_sweep(omega_values, y0, Q, f_tilde, config)
    n_freq = numel(omega_values);
    result.amp_x = nan(1, n_freq);
    result.amp_v = nan(1, n_freq);
    result.phase_x = nan(1, n_freq);
    result.phase_v = nan(1, n_freq);
    result.converged = false(1, n_freq);
    result.cycles = zeros(1, n_freq);
    result.final_state = nan(2, n_freq);

    y_initial = y0(:);

    for idx = 1:n_freq
        w = omega_values(idx);
        fprintf('Frequency %3d/%3d: omega = %.4f\n', idx, n_freq, w);

        point = simulate_forced_frequency(w, y_initial, Q, f_tilde, config);

        result.amp_x(idx) = point.amp_x;
        result.amp_v(idx) = point.amp_v;
        result.phase_x(idx) = point.phase_x;
        result.phase_v(idx) = point.phase_v;
        result.converged(idx) = point.converged;
        result.cycles(idx) = point.cycles;
        result.final_state(:, idx) = point.final_state;

        y_initial = point.final_state;
    end
end

function point = simulate_forced_frequency(w, y0, Q, f_tilde, config)
    period = 2 * pi / w;
    options = odeset('Events', @(t, y) forced_peak_events(t, y, Q, f_tilde, w), ...
        'RelTol', 1e-7, 'AbsTol', 1e-9, 'MaxStep', period / 200);

    t0 = 0;
    y_initial = y0(:);
    total_cycles = 0;
    t_x = [];
    x_peaks = [];
    t_v = [];
    v_peaks = [];
    converged = false;

    while total_cycles < config.max_cycles && ~converged
        t_end = t0 + config.cycles_per_chunk * period;
        fun = @(t, y) forced_duffing_equation(t, y, Q, f_tilde, w);
        [t, y, te, ye, ie] = ode113(fun, [t0, t_end], y_initial, options);

        [t_x, x_peaks, t_v, v_peaks] = append_peak_events( ...
            t_x, x_peaks, t_v, v_peaks, te, ye, ie);

        total_cycles = total_cycles + config.cycles_per_chunk;
        t0 = t(end);
        y_initial = y(end, :).';

        converged = peaks_converged(x_peaks, config.n_peaks, config.peak_tol) && ...
            peaks_converged(v_peaks, config.n_peaks, config.peak_tol);
    end

    point.amp_x = mean_last_peaks(x_peaks, config.n_peaks);
    point.amp_v = mean_last_peaks(v_peaks, config.n_peaks);
    point.phase_x = mean_peak_phase(t_x, w, config.n_peaks);
    point.phase_v = mean_peak_phase(t_v, w, config.n_peaks);
    point.converged = converged;
    point.cycles = total_cycles;
    point.final_state = y_initial;
end

function response = simulate_autoresonance(Q, f0_tilde, y0, t_end, n_peaks, peak_tol)
    options = odeset('Events', @(t, y) autoresonance_peak_events(t, y, Q, f0_tilde), ...
        'RelTol', 1e-7, 'AbsTol', 1e-9, 'MaxStep', 0.05);

    fun = @(t, y) autoresonance_equation(t, y, Q, f0_tilde);
    [t, y, te, ye, ie] = ode113(fun, [0, t_end], y0(:), options);

    t_x = te(ie == 1);
    x_peaks = ye(ie == 1, 1);
    t_v = te(ie == 2);
    v_peaks = ye(ie == 2, 2);

    response.t = t;
    response.y = y;
    response.amp_x = mean_last_peaks(x_peaks, n_peaks);
    response.amp_v = mean_last_peaks(v_peaks, n_peaks);
    response.omega = mean_instantaneous_frequency(t_x, n_peaks);
    response.converged = peaks_converged(x_peaks, n_peaks, peak_tol) && ...
        peaks_converged(v_peaks, n_peaks, peak_tol);
    response.final_state = y(end, :).';
    response.t_x = t_x;
    response.x_peaks = x_peaks;
    response.t_v = t_v;
    response.v_peaks = v_peaks;
end

function trajectory = peak_frequency_trajectory(response, window, skip)
    if nargin < 3
        skip = max(3, window);
    end
    [trajectory.omega_v, trajectory.amp_v] = peak_amplitude_frequency( ...
        response.t_v, response.v_peaks, skip, window);
    [trajectory.omega_x, trajectory.amp_x] = peak_amplitude_frequency( ...
        response.t_x, response.x_peaks, skip, window);
    [trajectory.omega_x, trajectory.amp_x] = trim_frequency_plateau( ...
        trajectory.omega_x, trajectory.amp_x);
end

function [omega, amp] = peak_amplitude_frequency(t_peaks, a_peaks, skip, window)
    n = numel(t_peaks);
    if n <= skip + window
        omega = mean(2 * pi ./ diff(t_peaks));
        amp = a_peaks(end);
        return;
    end

    idx = (skip + window):n;
    omega = zeros(numel(idx), 1);
    amp = a_peaks(idx);

    for k = 1:numel(idx)
        i = idx(k);
        omega(k) = 2 * pi * window / (t_peaks(i) - t_peaks(i - window));
    end
end

function [omega, amp] = trim_frequency_plateau(omega, amp, tol)
    if nargin < 3
        tol = 1e-3;
    end

    if numel(omega) < 2
        return;
    end

    last_increasing = find(diff(omega) > tol, 1, 'last');
    if isempty(last_increasing)
        keep = numel(omega);
    else
        keep = last_increasing + 1;
    end

    omega = omega(1:keep);
    amp = amp(1:keep);
end

function [omega_backbone, amp_x_backbone, amp_v_backbone] = duffing_backbone_curve(amp_x_min, amp_x_max)
    if nargin < 1
        amp_x_min = 0.01;
    end
    if nargin < 2
        amp_x_max = 3.0;
    end

    amp_x_backbone = linspace(amp_x_min, amp_x_max, 200);
    amp_v_backbone = amp_x_backbone .* sqrt(1 + 0.5 * amp_x_backbone.^2);
    omega_backbone = zeros(size(amp_x_backbone));

    for idx = 1:numel(amp_x_backbone)
        A = amp_x_backbone(idx);
        m = A^2 / (2 * (A^2 + 1));
        K_m = ellipke(m);
        omega_backbone(idx) = pi * sqrt(A^2 + 1) / (2 * K_m);
    end
end

%% Model equations
function dy = forced_duffing_equation(t, y, Q, f_tilde, w)
    dy = zeros(2, 1);
    dy(1) = y(2);
    dy(2) = f_tilde * sin(w * t) - y(1) - y(1)^3 - y(2) / Q;
end

function dy = autoresonance_equation(~, y, Q, f0_tilde)
    x = y(1);
    v = y(2);
    energy = max(v^2 + x^2 + 0.5 * x^4, 1e-12);
    pump = f0_tilde * v / sqrt(energy);

    dy = zeros(2, 1);
    dy(1) = v;
    dy(2) = pump - x - x^3 - v / Q;
end

function [check, isterminal, direction] = forced_peak_events(t, y, Q, f_tilde, w)
    a = forced_duffing_acceleration(t, y, Q, f_tilde, w);
    [check, isterminal, direction] = peak_events_from_state(y, a);
end

function [check, isterminal, direction] = autoresonance_peak_events(~, y, Q, f0_tilde)
    a = autoresonance_acceleration(y, Q, f0_tilde);
    [check, isterminal, direction] = peak_events_from_state(y, a);
end

function a = forced_duffing_acceleration(t, y, Q, f_tilde, w)
    a = f_tilde * sin(w * t) - y(1) - y(1)^3 - y(2) / Q;
end

function a = autoresonance_acceleration(y, Q, f0_tilde)
    x = y(1);
    v = y(2);
    energy = max(v^2 + x^2 + 0.5 * x^4, 1e-12);
    pump = f0_tilde * v / sqrt(energy);
    a = pump - x - x^3 - v / Q;
end

function [check, isterminal, direction] = peak_events_from_state(y, a)
    check = [y(2); a];
    isterminal = [0; 0];
    direction = [-1; -1];
end

%% Peak and phase utilities
function [t_x, x_peaks, t_v, v_peaks] = append_peak_events( ...
    t_x, x_peaks, t_v, v_peaks, te, ye, ie)

    t_x = [t_x; te(ie == 1)];
    x_peaks = [x_peaks; ye(ie == 1, 1)];
    t_v = [t_v; te(ie == 2)];
    v_peaks = [v_peaks; ye(ie == 2, 2)];
end

function tf = peaks_converged(peaks, n_peaks, peak_tol)
    if numel(peaks) < 2 * n_peaks
        tf = false;
        return;
    end

    recent = peaks(end - n_peaks + 1:end);
    previous = peaks(end - 2 * n_peaks + 1:end - n_peaks);
    scale = max(1, abs(mean(recent)));
    tf = abs(mean(recent) - mean(previous)) / scale < peak_tol;
end

function value = mean_last_peaks(peaks, n_peaks)
    if numel(peaks) < n_peaks
        value = NaN;
        return;
    end

    value = mean(peaks(end - n_peaks + 1:end));
end

function phase = mean_peak_phase(peak_times, w, n_peaks)
    if numel(peak_times) < n_peaks
        phase = NaN;
        return;
    end

    recent_times = peak_times(end - n_peaks + 1:end);
    phases = wrap_to_pi(pi / 2 - w * recent_times);
    phase = atan2(mean(sin(phases)), mean(cos(phases)));
end

function omega = mean_instantaneous_frequency(peak_times, n_peaks)
    if numel(peak_times) < n_peaks + 1
        omega = NaN;
        return;
    end

    recent_times = peak_times(end - n_peaks:end);
    omega = mean(2 * pi ./ diff(recent_times));
end

function angle = wrap_to_pi(angle)
    angle = mod(angle + pi, 2 * pi) - pi;
end

function sweep = reverse_sweep(sweep)
    names = fieldnames(sweep);

    for idx = 1:numel(names)
        name = names{idx};
        if isvector(sweep.(name)) || ismatrix(sweep.(name))
            sweep.(name) = fliplr(sweep.(name));
        end
    end
end

function y0_backward = choose_backward_seed(backward_seed, forward)
    switch backward_seed
        case "rest"
            y0_backward = [0; 0];
        case "forward_endpoint"
            y0_backward = forward.final_state(:, end);
        otherwise
            error('Unknown backward_seed value: %s', backward_seed);
    end
end

%% Plot utilities
function fig = new_figure()
    fig = figure('Position', [100, 100, 700, 400]);
    set(gca, 'FontSize', 12);
end

function export_figure(fig, out_dir, filename)
    prepare_figure_for_export(fig);
    filepath = fullfile(out_dir, filename);
    fig.PaperPositionMode = 'auto';
    print(fig, filepath, '-dsvg', '-painters');
    close(fig);
end

function prepare_figure_for_export(fig)
    drawnow;
    lgds = findobj(fig, 'Type', 'Legend');
    for idx = 1:numel(lgds)
        fit_legend_box(lgds(idx));
    end
    drawnow;
end

function fit_legend_box(lgd)
    lgd.Interpreter = 'latex';
    lgd.ItemTokenSize = [45, 18];
    lgd.Units = 'normalized';
    pos = lgd.Position;
    if pos(3) < 0.28
        lgd.Position = [pos(1), pos(2), pos(3) * 1.55, pos(4)];
    end
end
