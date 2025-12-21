%% Duffing Equation Analysis
% Generates backbone curve and frequency response for nonlinear resonator
% Equations reference: MCS1_008

clear; close all; clc;

%% Parameters
Q = 10;                     % Quality factor
f0_values = [0.02, 0.05, 0.1, 0.15, 0.2];  % Multiple forcing amplitudes
omega_range = [0.5, 1.5];   % Frequency range
n_freq = 150;               % Number of frequency points

%% Figure 1: Backbone Curve (Undamped Duffing)
A_vals = linspace(0.01, 2.5, 300);
omega_backbone = zeros(size(A_vals));
v_max_backbone = zeros(size(A_vals));

for i = 1:length(A_vals)
    A = A_vals(i);
    m = A^2 / (2*(A^2 + 1));
    K_m = ellipke(m);
    omega_backbone(i) = pi * sqrt(A^2 + 1) / (2 * K_m);
    v_max_backbone(i) = A * sqrt(1 + A^2/2);
end

fig1 = figure('Position', [100, 100, 600, 400]);
plot(omega_backbone, v_max_backbone, '-'); hold on;
plot(omega_backbone, A_vals, '--');
xlabel('$\tilde{\omega}$');
ylabel('$A$');
legend({'$|\tilde{v}|$', '$|\tilde{x}|$'}, 'Location', 'northwest');
grid on;
xlim([0.5, 1.5]);
saveas(fig1, 'duffing_backbone.png');
fprintf('Saved: duffing_backbone.png\n');

%% Frequency Response with Multiple Forcing Amplitudes
% Using frequency sweep algorithm: for each f0, we perform two sweeps:
% 1. Forward sweep: start from low frequency, use end state as IC for next
% 2. Backward sweep: start from high frequency, use end state as IC for next
% This captures the hysteresis behavior in the nonlinear response.

omega_vals = linspace(omega_range(1), omega_range(2), n_freq);
n_cycles = 300;
n_steady = 50;
opts = odeset('RelTol', 1e-6, 'AbsTol', 1e-8);

% Storage for all f0 values
all_amp_v_fwd = zeros(length(f0_values), n_freq);
all_amp_v_bwd = zeros(length(f0_values), n_freq);
all_phase_fwd = zeros(length(f0_values), n_freq);
all_phase_bwd = zeros(length(f0_values), n_freq);

for f_idx = 1:length(f0_values)
    f0_tilde = f0_values(f_idx);
    fprintf('Computing f0 = %.3g (%d/%d)...\n', f0_tilde, f_idx, length(f0_values));
    
    amp_v_fwd = zeros(1, n_freq);
    amp_v_bwd = zeros(1, n_freq);
    phase_fwd = zeros(1, n_freq);
    phase_bwd = zeros(1, n_freq);
    
    % --- Forward sweep (ascending frequency) ---
    % Start from rest at lowest frequency
    y0_fwd = [0; 0];
    for i = 1:n_freq
        omega = omega_vals(i);
        T = 2*pi/omega;
        tspan = [0, n_cycles*T];
        
        ode_func = @(t, y) [y(2); 
            -y(1) - y(1)^3 - y(2)/Q + f0_tilde*sin(omega*t)];
        
        [t, y] = ode45(ode_func, tspan, y0_fwd, opts);
        
        % Extract steady state
        t_steady = t(end) - n_steady*T;
        idx = t > t_steady;
        t_s = t(idx); v_s = y(idx, 2);
        
        amp_v_fwd(i) = (max(v_s) - min(v_s)) / 2;
        phase_fwd(i) = compute_phase(t_s, v_s, omega);
        
        % Use final state as IC for next frequency
        y0_fwd = y(end, :)';
    end
    
    % --- Backward sweep (descending frequency) ---
    % Start from final state of forward sweep at highest frequency
    y0_bwd = y0_fwd;
    for i = n_freq:-1:1
        omega = omega_vals(i);
        T = 2*pi/omega;
        tspan = [0, n_cycles*T];
        
        ode_func = @(t, y) [y(2); 
            -y(1) - y(1)^3 - y(2)/Q + f0_tilde*sin(omega*t)];
        
        [t, y] = ode45(ode_func, tspan, y0_bwd, opts);
        
        % Extract steady state
        t_steady = t(end) - n_steady*T;
        idx = t > t_steady;
        t_s = t(idx); v_s = y(idx, 2);
        
        amp_v_bwd(i) = (max(v_s) - min(v_s)) / 2;
        phase_bwd(i) = compute_phase(t_s, v_s, omega);
        
        % Use final state as IC for next frequency
        y0_bwd = y(end, :)';
    end
    
    all_amp_v_fwd(f_idx, :) = amp_v_fwd;
    all_amp_v_bwd(f_idx, :) = amp_v_bwd;
    all_phase_fwd(f_idx, :) = phase_fwd;
    all_phase_bwd(f_idx, :) = phase_bwd;
end

fprintf('Done.\n');

%% Figure 2: Amplitude Response
fig2 = figure('Position', [100, 100, 600, 400]);
hold on;
colors = lines(length(f0_values));

for f_idx = 1:length(f0_values)
    plot(omega_vals, all_amp_v_fwd(f_idx, :), '-', 'Color', colors(f_idx,:));
    plot(omega_vals, all_amp_v_bwd(f_idx, :), '-', 'Color', colors(f_idx,:), ...
        'HandleVisibility', 'off');
end

plot(omega_backbone, v_max_backbone, 'k--');

xlabel('$\tilde{\omega}$');
ylabel('$|\tilde{v}|$');
legend_str = arrayfun(@(x) sprintf('$\\tilde{f}_0=%.2g$', x), f0_values, ...
    'UniformOutput', false);
legend_str{end+1} = 'Backbone';
legend(legend_str, 'Location', 'northwest');
title(sprintf('$Q=%d$', Q));
grid on;
xlim(omega_range);
saveas(fig2, 'duffing_frequency_response.png');
fprintf('Saved: duffing_frequency_response.png\n');

%% Figure 3: Phase Response (Velocity)
fig3 = figure('Position', [100, 100, 600, 400]);
hold on;

for f_idx = 1:length(f0_values)
    plot(omega_vals, all_phase_fwd(f_idx, :), '-', 'Color', colors(f_idx,:));
    plot(omega_vals, all_phase_bwd(f_idx, :), '-', 'Color', colors(f_idx,:), ...
        'HandleVisibility', 'off');
end

xlabel('$\tilde{\omega}$');
ylabel('$\phi_v$ [deg]');
legend_str = arrayfun(@(x) sprintf('$\\tilde{f}_0=%.2g$', x), f0_values, ...
    'UniformOutput', false);
legend(legend_str, 'Location', 'southwest');
title(sprintf('$Q=%d$', Q));
grid on;
xlim(omega_range);
ylim([-100, 100]);
yticks([-90, -45, 0, 45, 90]);
saveas(fig3, 'duffing_phase_response.png');
fprintf('Saved: duffing_phase_response.png\n');

fprintf('\nAll figures saved to current directory.\n');

%% Helper function: compute phase lag
function phi = compute_phase(t, x, omega)
    % Compute phase lag between forcing sin(omega*t) and response x(t)
    % Using cross-correlation with reference signals
    
    % Reference signals
    sin_ref = sin(omega * t);
    cos_ref = cos(omega * t);
    
    % Remove DC component
    x = x - mean(x);
    
    % Compute Fourier coefficient at driving frequency
    dt = mean(diff(t));
    a = 2 * mean(x .* cos_ref);  % cosine component
    b = 2 * mean(x .* sin_ref);  % sine component
    
    % Phase: x ≈ A*sin(omega*t + phi) = A*cos(phi)*sin + A*sin(phi)*cos
    % So b = A*cos(phi), a = A*sin(phi)
    phi = atan2d(a, b);  % Phase in degrees
    
    % Ensure phase is 90 degrees to -90 degrees
    if phi > 90
        phi = phi - 180;
    elseif phi < -90
        phi = phi + 180;
    end
end
