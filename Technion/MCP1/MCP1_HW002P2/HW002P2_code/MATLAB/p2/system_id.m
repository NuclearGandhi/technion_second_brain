%% system_id.m
% Motor System Identification and PI Controller Design
% MCP1 Lab 2 Part 2 - Assignment 1
%
% This script:
% 1. Loads recorded motor response data from Part 1
% 2. Fits a first-order transfer function model
% 3. Designs a PI controller for specified performance
% 4. Compares simulation vs actual step response
%
% Usage:
%   Run after recording data with record.m from Part 1
%   Outputs PI gains (kp, ki) for firmware

clear; close all; clc;

%% Configuration
% Sampling parameters
Ts = 0.01; % Sample time [s] (100 Hz control loop)
ENCODER_CPR = 1320; % Encoder counts per revolution (x4 mode: 4 * 330 lines)

% Design specifications
rise_time_spec = 0.15; % Desired rise time [s]
settling_time_max = 0.5; % Maximum settling time [s]
overshoot_max = 10; % Maximum overshoot [ %]

% Voltage to PWM conversion (0-9999 PWM = 0-12V)
PWM_MAX = 9999;
V_MAX = 12;
pwm_to_volt = V_MAX / PWM_MAX;

%% Load Data
fprintf('=== Motor System Identification ===\n\n');

% Try to load data from Part 1
data_file = '../p2/record_data.mat';

if exist(data_file, 'file')
    load(data_file);
    fprintf('Loaded data from: %s\n', data_file);
else
    % Generate synthetic test data for demonstration
    warning('Data file not found. Using synthetic data for demonstration.');

    % Synthetic motor parameters (typical DC motor)
    K_true = 15; % Gain [rad/s per V]
    tau_true = 0.08; % Time constant [s]

    t = (0:999)' * Ts;
    N_samples = length(t);

    % Generate step response with noise
    step_size = 4400; % PWM step size
    t_step = 0.1; % Step time

    pwm = zeros(N_samples, 1);
    pwm(t > t_step) = step_size;

    % Simulate motor response
    volt = pwm * pwm_to_volt;
    omega_ss = K_true * volt;
    omega = omega_ss .* (1 - exp(- (t - t_step) / tau_true));
    omega(t <= t_step) = 0;
    omega = omega + 0.5 * randn(size(omega)); % Add noise

    % Convert to encoder counts
    enc_diff = omega * Ts / (2 * pi) * ENCODER_CPR;

    % Structure data like recorded format
    REC = [pwm, cumsum(enc_diff), cumsum(enc_diff), cumsum(enc_diff), cumsum(enc_diff)];
    time = t;
end

%% Process Data
% Extract from REC array [PWM, Enc1, Enc2, Enc3, Enc4]
if exist('REC', 'var')
    pwm_data = REC(:, 1);
    enc_data = REC(:, 2:5);

    N = size(REC, 1);
    time = (0:N - 1)' * Ts;

    % Compute velocities (encoder counts per sample -> rad/s)
    % Handle 16-bit wraparound first
    raw_diff = diff(double(enc_data));
    raw_diff(raw_diff > 32767) = raw_diff(raw_diff > 32767) - 65536;
    raw_diff(raw_diff < -32767) = raw_diff(raw_diff < -32767) + 65536;
    omega_data = [zeros(1, 4); raw_diff] / Ts * (2 * pi / ENCODER_CPR);

    % Convert PWM to voltage
    volt_data = pwm_data * pwm_to_volt;

    % Trim data to remove edge artifacts
    % Start: remove first 15 samples (~150ms)
    % End: trim at t=6s to avoid end-of-recording artifacts
    TRIM_START = 15; % First sample to keep
    TRIM_END = 600; % Last sample to keep (t=6s at 100Hz)

    if N > TRIM_END
        time = time(TRIM_START:TRIM_END);
        omega_data = omega_data(TRIM_START:TRIM_END, :);
        volt_data = volt_data(TRIM_START:TRIM_END);
        pwm_data = pwm_data(TRIM_START:TRIM_END);
        N = length(time);
        fprintf('Trimmed data to samples %d-%d (t=%.2fs to t=%.2fs)\n', ...
            TRIM_START, TRIM_END, time(1), time(end));
    end

end

%% System Identification for Each Motor
fprintf('\n--- Fitting First-Order Models ---\n');

% The recording uses a SQUARE WAVE: PWM alternates between +4400 and -4400
% every 100 samples (1 second). We need to extract a single step transition.

% Find step transitions in voltage
du = diff(volt_data);
pos_step_indices = find(du > 2); % Positive step (voltage goes up)
neg_step_indices = find(du < -2); % Negative step (voltage goes down)

% Use the first positive step for identification
if ~isempty(pos_step_indices)
    step_idx = pos_step_indices(1);
    step_type = 'positive';
elseif ~isempty(neg_step_indices)
    step_idx = neg_step_indices(1);
    step_type = 'negative';
else
    step_idx = 10;
    step_type = 'unknown';
end

fprintf('Using %s step at sample %d (t=%.2fs)\n', step_type, step_idx, time(step_idx));

% Extract a segment around this step: from step to before next transition
if strcmp(step_type, 'positive') && ~isempty(neg_step_indices)
    next_step = neg_step_indices(neg_step_indices > step_idx);

    if ~isempty(next_step)
        segment_end = next_step(1) - 5; % Stop before next transition
    else
        segment_end = min(step_idx + 90, N);
    end

else
    segment_end = min(step_idx + 90, N); % Default: ~0.9s segment
end

% Storage for identified models
models = cell(1, 4);
K_est = zeros(1, 4);
tau_est = zeros(1, 4);

for motor = 1:4
    fprintf('\nMotor %d:\n', motor);

    % Extract segment data for this motor
    seg_y = omega_data(step_idx:segment_end, motor);
    seg_u = volt_data(step_idx:segment_end);
    seg_t = (0:length(seg_y) - 1)' * Ts;

    % Voltage before and after step
    u_before = mean(volt_data(max(1, step_idx - 10):step_idx - 1));
    u_after = mean(seg_u(end - 20:end));
    delta_u = u_after - u_before;

    % Velocity before and after step
    y_before = mean(omega_data(max(1, step_idx - 10):step_idx - 1, motor));
    y_after = mean(seg_y(end - 20:end));
    delta_y = y_after - y_before;

    % DC Gain: K = delta_omega / delta_voltage
    if abs(delta_u) > 0.1
        K_est(motor) = abs(delta_y / delta_u); % Use absolute value
    else
        K_est(motor) = 15; % Default
    end

    % Time constant: find when response reaches 63.2% of final value
    y_normalized = (seg_y - y_before) / (y_after - y_before + eps);
    tau_idx = find(abs(y_normalized) >= 0.632, 1);

    if ~isempty(tau_idx) && tau_idx > 1
        tau_est(motor) = tau_idx * Ts;
    else
        tau_est(motor) = 0.08; % Default
    end

    % Ensure reasonable bounds
    K_est(motor) = max(min(K_est(motor), 50), 1);
    tau_est(motor) = max(min(tau_est(motor), 0.5), 0.01);

    fprintf('  K = %.2f rad/s/V\n', K_est(motor));
    fprintf('  tau = %.3f s\n', tau_est(motor));

    % Create transfer function model
    models{motor} = tf(K_est(motor), [tau_est(motor), 1]);
end

% Store step segment info for plotting
step_segment.idx = step_idx;
step_segment.end = segment_end;

% Use average parameters for unified controller
K_avg = mean(K_est);
tau_avg = mean(tau_est);
fprintf('\n--- Average Parameters ---\n');
fprintf('K_avg = %.2f rad/s/V\n', K_avg);
fprintf('tau_avg = %.3f s\n', tau_avg);

%% PI Controller Design
fprintf('\n--- PI Controller Design ---\n');

% Plant transfer function: G(s) = K / (tau*s + 1)
G = tf(K_avg, [tau_avg, 1]);

% Design using pole placement for desired rise time
% For first-order system with PI: closed-loop is second order
% Desired characteristics based on rise time spec

% Natural frequency from rise time (approximation)
wn = 1.8 / rise_time_spec; % rad/s

% Damping ratio for acceptable overshoot
if overshoot_max <= 5
    zeta = 0.9;
elseif overshoot_max <= 10
    zeta = 0.7;
else
    zeta = 0.6;
end

% PI gains calculation
% Open-loop: L(s) = C(s)*G(s) = (kp + ki/s) * K/(tau*s + 1)
% For desired closed-loop poles: s = -zeta*wn ± wn*sqrt(1-zeta^2)*j

% Desired characteristic equation: s^2 + 2*zeta*wn*s + wn^2 = 0
% Closed-loop with PI: (tau*s^2 + s + K*kp*s + K*ki) / (tau*s^2 + s*(1+K*kp) + K*ki)
% Comparing: 2*zeta*wn = (1 + K*kp)/tau, wn^2 = K*ki/tau

ki_calc = wn ^ 2 * tau_avg / K_avg;
kp_calc = (2 * zeta * wn * tau_avg - 1) / K_avg;

% Ensure positive gains
kp_calc = max(kp_calc, 0.1);
ki_calc = max(ki_calc, 0.01);

fprintf('Calculated PI gains:\n');
fprintf('  kp = %.3f\n', kp_calc);
fprintf('  ki = %.3f\n', ki_calc);

% Convert to discrete incremental form for firmware
% Incremental PI: du[k] = ki*Ts*e[k] + kp*(e[k] - e[k-1])
% In firmware: du = ki*E[q] + kp*(E[q]-E1[q])
% where ki_fw = ki*Ts, but we absorb Ts into units

% For firmware (encoder counts error -> PWM):
% Scale factor: (PWM/V) * (V/(rad/s)) = PWM/(rad/s)
pwm_per_rad_s = PWM_MAX / (K_avg * V_MAX);

kp_fw = kp_calc * pwm_per_rad_s / 10; % Scaled for encoder counts
ki_fw = ki_calc * pwm_per_rad_s * Ts / 10;

fprintf('\nFirmware PI gains (scaled for encoder counts):\n');
fprintf('  kp = %.2f\n', kp_fw);
fprintf('  ki = %.4f\n', ki_fw);

%% Simulation vs Design Verification
fprintf('\n--- Step Response Simulation ---\n');

% Create PI controller
C = pid(kp_calc, ki_calc);

% Closed-loop system
T = feedback(C * G, 1);

% Simulate step response
t_sim = 0:Ts:1;
[y_sim, t_sim] = step(T, t_sim);

% Calculate actual performance metrics
info = stepinfo(T);
fprintf('Simulated step response:\n');
fprintf('  Rise time: %.3f s (spec: %.3f s)\n', info.RiseTime, rise_time_spec);
fprintf('  Settling time: %.3f s\n', info.SettlingTime);
fprintf('  Overshoot: %.1f%%\n', info.Overshoot);

%% Plotting
figure('Position', [100, 100, 1200, 800]);

% Plot 1: Open-loop step response (measured data)
subplot(2, 2, 1);
hold on;

for motor = 1:4
    plot(time, omega_data(:, motor), 'LineWidth', 1.5, 'DisplayName', sprintf('Motor %d', motor));
end

xlabel('Time [s]');
ylabel('$\omega$ [rad/s]');
title('Measured Open-Loop Response');
legend('Location', 'best');
grid on;

% Plot 2: Input voltage
subplot(2, 2, 2);
plot(time, volt_data, 'b', 'LineWidth', 2);
xlabel('Time [s]');
ylabel('Voltage [V]');
title('Input Voltage (from PWM)');
grid on;

% Plot 3: Model fit comparison (Option A: Full -5V to +5V step)
subplot(2, 2, 3);
hold on;

% Extract the step segment for comparison
seg_time = time(step_segment.idx:step_segment.end) - time(step_segment.idx);
seg_omega = omega_data(step_segment.idx:step_segment.end, 1);

% Get the voltage values before and after step
V_before = mean(volt_data(max(1, step_segment.idx - 10):step_segment.idx - 1));
V_after = mean(volt_data(step_segment.idx + 50:min(step_segment.end, step_segment.idx + 80)));
V_step = V_after - V_before; % Full voltage step (e.g., -5V to +5V = 10V)

% Get the initial velocity (before step)
omega_initial = mean(omega_data(max(1, step_segment.idx - 10):step_segment.idx - 1, 1));

% Shift measured data to start from 0
seg_omega_shifted = seg_omega - omega_initial;

% Simulate model response to the full voltage step
% Model output represents delta_omega for delta_V
[y_model, t_model] = step(G * abs(V_step), seg_time);

% Plot both starting from 0
plot(seg_time, seg_omega_shifted, 'b', 'LineWidth', 1.5, 'DisplayName', 'Measured (Motor 1)');
plot(t_model, y_model, 'r--', 'LineWidth', 2, 'DisplayName', 'Model');
xlabel('Time [s]');
ylabel('$\Delta\omega$ [rad/s]');
title(sprintf('Model vs Measured (Step: %.1fV to %.1fV)', V_before, V_after));
legend('Location', 'best');
grid on;

% Plot 4: Closed-loop simulation
subplot(2, 2, 4);
plot(t_sim, y_sim, 'b', 'LineWidth', 2);
hold on;
yline(1, 'k--', 'LineWidth', 1);
yline(0.9, 'g--', 'LineWidth', 1); % 90 % rise
yline(1.1, 'r--', 'LineWidth', 1); % 10 % overshoot band
xlabel('Time [s]');
ylabel('Normalized Response');
title(sprintf('Simulated Closed-Loop (kp=%.2f, ki=%.3f)', kp_calc, ki_calc));
legend('Response', 'Setpoint', '90% Rise', '10% Overshoot', 'Location', 'best');
grid on;

sgtitle('Motor System Identification and PI Controller Design');

% Save figure
saveas(gcf, 'system_id_results.png');
fprintf('\nFigure saved to: system_id_results.png\n');

%% Export Results
results.K_est = K_est;
results.tau_est = tau_est;
results.K_avg = K_avg;
results.tau_avg = tau_avg;
results.kp = kp_calc;
results.ki = ki_calc;
results.kp_fw = kp_fw;
results.ki_fw = ki_fw;
results.performance = info;

save('system_id_results.mat', 'results');
fprintf('Results saved to: system_id_results.mat\n');

%% Summary
fprintf('\n========================================\n');
fprintf('SUMMARY - Copy these to STM32 firmware:\n');
fprintf('========================================\n');
fprintf('float kp = %.2f;\n', kp_fw);
fprintf('float ki = %.4f;\n', ki_fw);
fprintf('========================================\n');
