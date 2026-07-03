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
    config.q3.t_end_scale = 15;
    config.q3.min_t_end = 200;
    config.q3.example_cases = [ ...
        20, 0.05; ...
        20, 0.10; ...
        10, 0.10; ...
        5,  0.20];
    config.q3.freq_response_case = [20, 0.10];
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

    for q_idx = 1:n_q
        for f_idx = 1:n_f
            Q = q3.Q_values(q_idx);
            f0_tilde = q3.f0_values(f_idx);
            t_end = max(q3.min_t_end, q3.t_end_scale * Q);

            fprintf('Q = %g, f0_tilde = %.5g, t_end = %.0f\n', ...
                Q, f0_tilde, t_end);

            response = simulate_autoresonance(Q, f0_tilde, q3.y0, t_end, ...
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
        'Q_values', 'f0_values', 'results', 'amp_x', 'amp_v', 'omega_inst');

    plot_q3_time_examples(config, out_dir, results);
    plot_q3_parameter_sweeps(config, out_dir, amp_x);
    plot_q3_frequency_response(config, out_dir, results);
end

function plot_q3_time_examples(config, out_dir, results)
    q3 = config.q3;
    fig = new_figure();
    tiledlayout(2, 1, 'TileSpacing', 'compact');

    nexttile;
    hold on; box on; grid on;
    for idx = 1:size(q3.example_cases, 1)
        response = find_autoresonance_response(results, ...
            q3.example_cases(idx, 1), q3.example_cases(idx, 2));
        plot(response.t, response.y(:, 1), 'LineWidth', 2.0, ...
            'DisplayName', sprintf('$Q=%g,\\ \\tilde{f}_0=%.2g$', ...
            q3.example_cases(idx, 1), q3.example_cases(idx, 2)));
    end
    ylabel('$\tilde{x}$', 'FontSize', 14);
    legend('Location', 'northwest');

    nexttile;
    hold on; box on; grid on;
    for idx = 1:size(q3.example_cases, 1)
        response = find_autoresonance_response(results, ...
            q3.example_cases(idx, 1), q3.example_cases(idx, 2));
        plot(response.t, response.y(:, 2), 'LineWidth', 2.0, ...
            'DisplayName', sprintf('$Q=%g,\\ \\tilde{f}_0=%.2g$', ...
            q3.example_cases(idx, 1), q3.example_cases(idx, 2)));
    end
    xlabel('$\tilde{t}$', 'FontSize', 15);
    ylabel('$\tilde{v}$', 'FontSize', 14);
    export_figure(fig, out_dir, 'hw6_q3_time_examples.svg');
end

function plot_q3_parameter_sweeps(config, out_dir, amp_x)
    q3 = config.q3;
    colors = lines(numel(q3.Q_values));

    fig = new_figure();
    hold on; box on; grid on;
    for q_idx = 1:numel(q3.Q_values)
        plot(q3.f0_values, amp_x(q_idx, :), '-o', 'Color', colors(q_idx, :), ...
            'LineWidth', 2.0, 'DisplayName', sprintf('$Q=%g$', q3.Q_values(q_idx)));
    end
    xlabel('$\tilde{f}_0$', 'FontSize', 15);
    ylabel('$A_{\tilde{x}}$', 'FontSize', 15);
    legend('Location', 'northwest');
    export_figure(fig, out_dir, 'hw6_q3_autoresonance_force_sweep.svg');

    fig = new_figure();
    hold on; box on; grid on;
    for f_idx = 1:numel(q3.f0_values)
        plot(q3.Q_values, amp_x(:, f_idx), '-o', 'Color', colors(f_idx, :), ...
            'LineWidth', 2.0, ...
            'DisplayName', sprintf('$\\tilde{f}_0=%.2g$', q3.f0_values(f_idx)));
    end
    xlabel('$Q$', 'FontSize', 15);
    ylabel('$A_{\tilde{x}}$', 'FontSize', 15);
    legend('Location', 'northwest');
    export_figure(fig, out_dir, 'hw6_q3_autoresonance_q_sweep.svg');

    fig = new_figure();
    imagesc(q3.f0_values, q3.Q_values, amp_x);
    set(gca, 'YDir', 'normal');
    colorbar;
    xlabel('$\tilde{f}_0$', 'FontSize', 15);
    ylabel('$Q$', 'FontSize', 15);
    title('Final displacement amplitude', 'FontSize', 14);
    export_figure(fig, out_dir, 'hw6_q3_autoresonance_final_amplitude.svg');

end

function plot_q3_frequency_response(config, out_dir, results)
    q3 = config.q3;
    response = find_autoresonance_response(results, ...
        q3.freq_response_case(1), q3.freq_response_case(2));
    trajectory = peak_frequency_trajectory(response);

    [omega_backbone, amp_x_backbone, amp_v_backbone] = duffing_backbone_curve();

    fig = new_figure();
    hold on; box on; grid on;
    plot(trajectory.omega_x, trajectory.amp_x, 'b-', 'LineWidth', 2.2, ...
        'DisplayName', 'Autoresonance trajectory');
    plot(omega_backbone, amp_x_backbone, 'k--', 'LineWidth', 1.8, ...
        'DisplayName', 'Backbone');
    xlabel('$\tilde{\omega}$', 'FontSize', 15);
    ylabel('$A_{\tilde{x}}$', 'FontSize', 15);
    title(sprintf('$Q=%g,\\ \\tilde{f}_0=%.2g$', ...
        q3.freq_response_case(1), q3.freq_response_case(2)), 'FontSize', 14);
    legend('Location', 'northwest');
    export_figure(fig, out_dir, 'hw6_q3_displacement_frequency_response.svg');

    fig = new_figure();
    hold on; box on; grid on;
    plot(trajectory.omega_v, trajectory.amp_v, 'r-', 'LineWidth', 2.2, ...
        'DisplayName', 'Autoresonance trajectory');
    plot(omega_backbone, amp_v_backbone, 'k--', 'LineWidth', 1.8, ...
        'DisplayName', 'Backbone');
    xlabel('$\tilde{\omega}$', 'FontSize', 15);
    ylabel('$A_{\tilde{v}}$', 'FontSize', 15);
    title(sprintf('$Q=%g,\\ \\tilde{f}_0=%.2g$', ...
        q3.freq_response_case(1), q3.freq_response_case(2)), 'FontSize', 14);
    legend('Location', 'northwest');
    export_figure(fig, out_dir, 'hw6_q3_velocity_frequency_response.svg');
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

function trajectory = peak_frequency_trajectory(response)
    min_peaks = 4;
    trajectory.omega_x = mean_instantaneous_frequency_series(response.t_x);
    trajectory.amp_x = response.x_peaks(2:end);
    trajectory.omega_v = mean_instantaneous_frequency_series(response.t_v);
    trajectory.amp_v = response.v_peaks(2:end);

    if numel(trajectory.omega_x) < min_peaks
        trajectory.omega_x = response.omega;
        trajectory.amp_x = response.amp_x;
    end

    if numel(trajectory.omega_v) < min_peaks
        trajectory.omega_v = response.omega;
        trajectory.amp_v = response.amp_v;
    end
end

function [omega_backbone, amp_x_backbone, amp_v_backbone] = duffing_backbone_curve()
    amp_x_backbone = linspace(0.01, 3.0, 300);
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

function omega_series = mean_instantaneous_frequency_series(peak_times)
    if numel(peak_times) < 3
        omega_series = NaN;
        return;
    end

    omega_series = 2 * pi ./ diff(peak_times);
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
    fig = figure('Position', [100, 100, 600, 400]);
    set(gca, 'FontSize', 12);
end

function export_figure(fig, out_dir, filename)
    exportgraphics(fig, fullfile(out_dir, filename), 'ContentType', 'vector');
    close(fig);
end
