%% record.m
% Record Motor Response Data for System Identification
% MCP1 Lab 2 Part 2
%
% This script records motor step response data from the STM32:
% 1. Connects to the cart via serial port
% 2. Triggers the SQUARE wave recording mode
% 3. Retrieves and saves the recorded data
%
% Usage:
%   1. Connect STM32 to PC
%   2. Run this script
%   3. Wait for recording to complete
%   4. Data saved to record_data.mat

clear; close all; clc;

%% Configuration
BAUD_RATE = 115200;
NP = 1000; % Number of points to record (matches firmware)
Ts = 0.01; % Sample period (100 Hz)
TIMEOUT = 15; % Seconds to wait for recording

%% Connect to STM32
fprintf('=== Motor Response Recording ===\n\n');

port = find_com();

if isempty(port)
    error('No COM port found. Connect STM32 and try again.');
end

% find_com() already cleaned up existing connections, so we can connect directly
try
    s = serialport(port, BAUD_RATE);
    configureTerminator(s, "CR/LF");
    s.Timeout = 30;
    fprintf('Connected to %s\n', port);
catch ME
    error('Failed to connect: %s', ME.message);
end

% Ensure cleanup on exit
cleanupObj = onCleanup(@() cleanup_serial(s));

%% Initialize
pause(0.5);

% Flush any existing data
flush(s);

% Check status
fprintf('\nChecking cart status...\n');
writeline(s, 'status');
pause(0.2);

try
    resp = readline(s);
    fprintf('Status: %s\n', resp);
catch
    fprintf('No status response (cart may need reset)\n');
end

%% Start Recording
fprintf('\n--- Starting Square Wave Recording ---\n');
fprintf('Recording %d samples at %.0f Hz (%.1f seconds)...\n', NP, 1 / Ts, NP * Ts);

% Set mode to SQUARE (state 3) to start recording
flush(s);
writeline(s, 'state 3');

% Read command echo
pause(0.1);

try
    echo = readline(s);
    fprintf('Echo: %s\n', echo);
catch
end

% Wait for recording to complete
record_time = NP * Ts + 2;
fprintf('Waiting %.1f seconds for recording to complete...\n', record_time);
pause(record_time);

%% Retrieve Data
fprintf('\n--- Retrieving Recorded Data ---\n');

% Request data transfer
flush(s);
writeline(s, 'send');

% Read command echo
pause(0.1);

try
    echo = readline(s);
    fprintf('Echo: %s\n', echo);
catch
end

% Read binary data: NP samples x 5 values x 2 bytes = 10000 bytes
expected_bytes = NP * 5 * 2;
fprintf('Expecting %d bytes...\n', expected_bytes);

try
    raw_data = read(s, expected_bytes, 'uint8');
catch ME
    error('Failed to read data: %s', ME.message);
end

if length(raw_data) ~= expected_bytes
    warning('Incomplete data: got %d bytes, expected %d', length(raw_data), expected_bytes);
end

fprintf('Received %d bytes\n', length(raw_data));

% Convert to int16 matrix
data_int16 = typecast(uint8(raw_data), 'int16');
n_values = floor(length(data_int16) / 5);
data_int16 = data_int16(1:n_values * 5);

REC = reshape(data_int16, [5, n_values])';
fprintf('Received %d x 5 data matrix\n', n_values);

% Wait for DONE message
pause(0.5);

try
    done_msg = readline(s);
    fprintf('Response: %s\n', done_msg);
catch
end

%% Process and Plot Data
time = (0:size(REC, 1) - 1)' * Ts;

% Extract columns (convert to double for calculations)
pwm_data = double(REC(:, 1));
enc_data_raw = double(REC(:, 2:5));

% Zero encoder positions relative to first sample
% This handles the case where wheels were rotated before recording
enc_data = enc_data_raw - enc_data_raw(1, :);

% Compute velocities (encoder counts per sample)
% Handle 16-bit counter wraparound: if delta > 32767, it wrapped negative
% if delta < -32767, it wrapped positive
raw_diff = diff(enc_data_raw);
raw_diff(raw_diff > 32767) = raw_diff(raw_diff > 32767) - 65536;
raw_diff(raw_diff < -32767) = raw_diff(raw_diff < -32767) + 65536;
omega_data = [zeros(1, 4); raw_diff];

% Convert to rad/s
ENCODER_CPR = 1320; % counts per revolution (x4 mode: 4 * 330 encoder lines)
omega_rad = omega_data * (2 * pi / ENCODER_CPR) / Ts;

%% Visualization
figure('Position', [100, 100, 1200, 800]);

% PWM input
subplot(2, 2, 1);
plot(time, pwm_data, 'LineWidth', 2);
xlabel('Time [s]');
ylabel('PWM');
title('PWM Input (Square Wave)');
grid on;

% Encoder positions
subplot(2, 2, 2);
hold on;

for i = 1:4
    plot(time, enc_data(:, i), 'LineWidth', 1.5, 'DisplayName', sprintf('Motor %d', i));
end

xlabel('Time [s]');
ylabel('Encoder [counts]');
title('Encoder Positions');
legend('Location', 'best');
grid on;

% Encoder velocities (counts/sample)
subplot(2, 2, 3);
hold on;

for i = 1:4
    plot(time, omega_data(:, i), 'LineWidth', 1.5, 'DisplayName', sprintf('Motor %d', i));
end

xlabel('Time [s]');
ylabel('$\Delta$ Encoder [counts/sample]');
title('Encoder Velocities');
legend('Location', 'best');
grid on;

% Angular velocities (rad/s)
subplot(2, 2, 4);
hold on;

for i = 1:4
    plot(time, omega_rad(:, i), 'LineWidth', 1.5, 'DisplayName', sprintf('Motor %d', i));
end

xlabel('Time [s]');
ylabel('$\omega$ [rad/s]');
title('Angular Velocities');
legend('Location', 'best');
grid on;

sgtitle('Motor Step Response Recording');

%% Save Data
save('record_data.mat', 'REC', 'time', 'pwm_data', 'enc_data', 'omega_data', 'omega_rad', 'Ts');
fprintf('\nData saved to: record_data.mat\n');

saveas(gcf, 'record_data.png');
fprintf('Figure saved to: record_data.png\n');

%% Summary
fprintf('\n========================================\n');
fprintf('Recording Summary:\n');
fprintf('  Samples: %d\n', size(REC, 1));
fprintf('  Duration: %.2f s\n', time(end));
fprintf('  PWM range: %d to %d\n', min(pwm_data), max(pwm_data));
fprintf('  Max velocity: %.1f rad/s\n', max(abs(omega_rad(:))));
fprintf('========================================\n');

%% Cleanup Function
function cleanup_serial(s)

    try
        writeline(s, 'state 1'); % Return to IDLE
        pause(0.1);
    catch
    end

    if ~isempty(s) && isvalid(s)
        delete(s);
        disp('Serial port closed.');
    end

end
