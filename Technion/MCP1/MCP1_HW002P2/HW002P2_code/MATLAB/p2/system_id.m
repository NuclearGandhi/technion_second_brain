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
Ts = 0.01;          % Sample time [s] (100 Hz control loop)
ENCODER_CPR = 630;  % Encoder counts per revolution

% Design specifications
rise_time_spec = 0.15;    % Desired rise time [s]
settling_time_max = 0.5;  % Maximum settling time [s]
overshoot_max = 10;       % Maximum overshoot [%]

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
    K_true = 15;      % Gain [rad/s per V]
    tau_true = 0.08;  % Time constant [s]
    
    t = (0:999)' * Ts;
    N_samples = length(t);
    
    % Generate step response with noise
    step_size = 4400;  % PWM step size
    t_step = 0.1;      % Step time
    
    pwm = zeros(N_samples, 1);
    pwm(t > t_step) = step_size;
    
    % Simulate motor response
    volt = pwm * pwm_to_volt;
    omega_ss = K_true * volt;
    omega = omega_ss .* (1 - exp(-(t - t_step) / tau_true));
    omega(t <= t_step) = 0;
    omega = omega + 0.5 * randn(size(omega));  % Add noise
    
    % Convert to encoder counts
    enc_diff = omega * Ts / (2*pi) * ENCODER_CPR;
    
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
    time = (0:N-1)' * Ts;
    
    % Compute velocities (encoder counts per sample -> rad/s)
    omega_data = diff(enc_data) / Ts * (2*pi / ENCODER_CPR);
    omega_data = [zeros(1, 4); omega_data];  % Pad first sample
    
    % Convert PWM to voltage
    volt_data = pwm_data * pwm_to_volt;
end

%% System Identification for Each Motor
fprintf('\n--- Fitting First-Order Models ---\n');

% Storage for identified models
models = cell(1, 4);
K_est = zeros(1, 4);
tau_est = zeros(1, 4);

for motor = 1:4
    fprintf('\nMotor %d:\n', motor);
    
    % Extract data for this motor
    y = omega_data(:, motor);
    u = volt_data;
    
    % Find steady-state regions for positive and negative steps
    % Look for regions where velocity is relatively constant
    
    % Simple estimation: find step changes in input
    du = diff(u);
    step_indices = find(abs(du) > 1);  % Voltage step threshold
    
    if isempty(step_indices)
        % Use entire dataset
        step_idx = find(abs(u) > 0.1, 1);
        if isempty(step_idx), step_idx = 10; end
    else
        step_idx = step_indices(1);
    end
    
    % Estimate steady-state gain
    % Find steady-state velocity after step
    ss_start = min(step_idx + round(0.5/Ts), N);  % 0.5s after step
    ss_end = min(ss_start + round(0.3/Ts), N);
    
    if ss_end > ss_start
        y_ss = mean(y(ss_start:ss_end));
        u_ss = mean(u(ss_start:ss_end));
        
        if abs(u_ss) > 0.1
            K_est(motor) = y_ss / u_ss;
        else
            K_est(motor) = 15;  % Default
        end
    else
        K_est(motor) = 15;  % Default
    end
    
    % Estimate time constant from rise time
    % Find 63.2% of steady-state
    y_target = 0.632 * y_ss;
    tau_idx = find(abs(y(step_idx:end)) >= abs(y_target), 1) + step_idx - 1;
    
    if ~isempty(tau_idx) && tau_idx > step_idx
        tau_est(motor) = (tau_idx - step_idx) * Ts;
    else
        tau_est(motor) = 0.08;  % Default
    end
    
    % Ensure reasonable bounds
    K_est(motor) = max(min(K_est(motor), 50), 5);
    tau_est(motor) = max(min(tau_est(motor), 0.3), 0.02);
    
    fprintf('  K = %.2f rad/s/V\n', K_est(motor));
    fprintf('  tau = %.3f s\n', tau_est(motor));
    
    % Create transfer function model
    models{motor} = tf(K_est(motor), [tau_est(motor), 1]);
end

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
wn = 1.8 / rise_time_spec;  % rad/s

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

ki_calc = wn^2 * tau_avg / K_avg;
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

kp_fw = kp_calc * pwm_per_rad_s / 10;  % Scaled for encoder counts
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
ylabel('\omega [rad/s]');
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

% Plot 3: Model fit comparison
subplot(2, 2, 3);
hold on;
% Simulate open-loop model response
[y_model, t_model] = step(G * mean(volt_data(end-100:end)), t_sim);
plot(time, omega_data(:, 1), 'b', 'LineWidth', 1, 'DisplayName', 'Measured (Motor 1)');
plot(t_model, y_model, 'r--', 'LineWidth', 2, 'DisplayName', 'Model');
xlabel('Time [s]');
ylabel('\omega [rad/s]');
title('Model vs Measured');
legend('Location', 'best');
grid on;

% Plot 4: Closed-loop simulation
subplot(2, 2, 4);
plot(t_sim, y_sim, 'b', 'LineWidth', 2);
hold on;
yline(1, 'k--', 'LineWidth', 1);
yline(0.9, 'g--', 'LineWidth', 1);  % 90% rise
yline(1.1, 'r--', 'LineWidth', 1);  % 10% overshoot band
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

