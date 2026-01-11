%% test_velocity_control.m
% Test and Validate Velocity Control Loop
% MCP1 Lab 2 Part 2 - Assignment 1 Verification
%
% This script tests the closed-loop velocity controller:
% 1. Applies step reference inputs
% 2. Records the response
% 3. Compares actual vs simulated response
%
% Run after implementing PI controller on STM32.

clear; close all; clc;

%% Configuration
BAUD_RATE = 115200;
Ts = 0.01; % Sample period (100 Hz)
test_duration = 3; % Test duration [s]
step_delay = 0.5; % Delay before step [s]

% Step reference (encoder counts per sample period)
ref_value = 20; % Target velocity

%% Connect to STM32
fprintf('=== Velocity Control Test ===\n\n');

port = find_com();

if isempty(port)
    error('No COM port found. Connect STM32 and try again.');
end

% find_com() already cleaned up existing connections, so we can connect directly
try
    s = serialport(port, BAUD_RATE);
    configureTerminator(s, "CR/LF");
    s.Timeout = 10;
    fprintf('Connected to %s\n', port);
catch ME
    error('Failed to connect: %s', ME.message);
end

cleanupObj = onCleanup(@() cleanup_serial(s));

%% Test Sequence
pause(0.5);
flush(s);

% Set to IDLE first
writeline(s, 'state 1');
pause(0.2);

% Check/set PI gains
fprintf('\nSetting PI gains...\n');
writeline(s, 'gains 12.0 0.15');
pause(0.2);

% Set to VELOCITY mode
fprintf('\nSwitching to velocity control mode...\n');
writeline(s, 'state 5');
pause(0.2);

% Zero reference initially
writeline(s, 'ref 0 0 0 0');
pause(0.1);

%% Data Recording Loop
fprintf('\n--- Recording Step Response ---\n');

n_samples = round(test_duration / Ts);
n_step = round(step_delay / Ts);

time_rec = (0:n_samples - 1)' * Ts;
ref_rec = zeros(n_samples, 4);

tic;

for i = 1:n_samples
    % Apply step at appropriate time
    if i == n_step
        fprintf('Applying step: ref = %d\n', ref_value);
        cmd = sprintf('ref %d %d %d %d', ref_value, ref_value, ref_value, ref_value);
        writeline(s, cmd);
    end

    ref_rec(i, :) = (i >= n_step) * ref_value;

    pause(Ts);
end

% Return to IDLE
writeline(s, 'state 1');

fprintf('Test complete (%.2f s)\n', toc);

%% Load Recorded Data (if available)
% If firmware recorded data during test, retrieve it
if exist('record_data.mat', 'file')
    load('record_data.mat');
    fprintf('\nLoaded recorded data from record_data.mat\n');

    % Plot comparison
    figure('Position', [100, 100, 1000, 600]);

    subplot(2, 1, 1);
    hold on;

    for motor = 1:4
        plot(time, omega_data(:, motor), 'LineWidth', 1.5, ...
            'DisplayName', sprintf('Motor %d', motor));
    end

    xlabel('Time [s]');
    ylabel('Velocity [counts/sample]');
    title('Measured Velocity Response');
    legend('Location', 'best');
    grid on;

    subplot(2, 1, 2);
    hold on;
    plot(time_rec, ref_rec(:, 1), 'k--', 'LineWidth', 2, 'DisplayName', 'Reference');
    xlabel('Time [s]');
    ylabel('Reference');
    title('Reference Input');
    legend('Location', 'best');
    grid on;

    sgtitle('Closed-Loop Velocity Control Test');
end

%% Simulation Comparison (using system_id results)
if exist('system_id_results.mat', 'file')
    load('system_id_results.mat');

    fprintf('\n--- Simulation Comparison ---\n');
    fprintf('Using identified parameters:\n');
    fprintf('  K = %.2f, tau = %.3f\n', results.K_avg, results.tau_avg);
    fprintf('  kp = %.2f, ki = %.3f\n', results.kp, results.ki);

    % Create transfer functions
    G = tf(results.K_avg, [results.tau_avg, 1]);
    C = pid(results.kp, results.ki);
    T = feedback(C * G, 1);

    % Simulate step response
    t_sim = 0:Ts:test_duration;
    u_sim = [zeros(1, n_step), ref_value * ones(1, n_samples - n_step + 1)];
    u_sim = u_sim(1:length(t_sim));

    [y_sim, t_sim] = lsim(T, u_sim, t_sim);

    % Plot
    figure('Position', [100, 100, 800, 500]);
    plot(t_sim, u_sim, 'k--', 'LineWidth', 2, 'DisplayName', 'Reference');
    hold on;
    plot(t_sim, y_sim, 'b-', 'LineWidth', 2, 'DisplayName', 'Simulated');
    xlabel('Time [s]');
    ylabel('Velocity');
    title(sprintf('Simulated Closed-Loop Step Response (kp=%.2f, ki=%.3f)', results.kp, results.ki));
    legend('Location', 'best');
    grid on;

    % Performance metrics
    info = stepinfo(y_sim(n_step:end), t_sim(n_step:end) - t_sim(n_step), ref_value);
    fprintf('\nSimulated Performance:\n');
    fprintf('  Rise time: %.3f s\n', info.RiseTime);
    fprintf('  Settling time: %.3f s\n', info.SettlingTime);
    fprintf('  Overshoot: %.1f%%\n', info.Overshoot);
end

%% Kinematics Test
fprintf('\n--- Kinematics Quick Test ---\n');

writeline(s, 'state 6'); % STATE_KINEMATICS
pause(0.2);

% Test forward motion
fprintf('Testing forward motion...\n');
writeline(s, 'vel 0.1 0 0');
pause(2);

% Test lateral motion
fprintf('Testing lateral motion...\n');
writeline(s, 'vel 0 0.1 0');
pause(2);

% Test rotation
fprintf('Testing rotation...\n');
writeline(s, 'vel 0 0 0.5');
pause(2);

% Stop
writeline(s, 'vel 0 0 0');
writeline(s, 'state 1');

fprintf('\nKinematics test complete.\n');

%% Summary
fprintf('\n========================================\n');
fprintf('Velocity Control Test Summary\n');
fprintf('========================================\n');
fprintf('  Reference step: %d counts/sample\n', ref_value);
fprintf('  Test duration: %.1f s\n', test_duration);
fprintf('\nRun record.m first to get actual motor data,\n');
fprintf('then run system_id.m to tune PI gains.\n');
fprintf('========================================\n');

%% Cleanup
function cleanup_serial(s)

    try
        writeline(s, 'state 1');
        pause(0.1);
    catch
    end

    if ~isempty(s) && isvalid(s)
        delete(s);
        disp('Serial port closed.');
    end

end
