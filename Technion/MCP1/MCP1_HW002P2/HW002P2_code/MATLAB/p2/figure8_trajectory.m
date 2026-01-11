%% figure8_trajectory.m
% Generate Figure-8 Trajectory for Mecanum Cart
% MCP1 Lab 2 Part 2 - Assignment 3
%
% This script generates a figure-8 path with:
% - Parametric path: x = A*sin(t), y = A*sin(t)*cos(t)
% - Curvature-based adaptive speed profile
% - Output: vx, vy, wz arrays and timing for STM32
%
% The output is exported to trajectory.h for inclusion in firmware.

clear; close all; clc;

%% Configuration
% Figure-8 dimensions (in meters)
A = 0.3; % Amplitude/size of figure-8 (smaller = faster to complete)
total_time = 8; % Total trajectory time [s]

% Speed limits
v_min = 0.08; % Minimum speed [m/s]
v_max = 0.4; % Maximum speed [m/s]

% Sampling
n_points = 100; % Number of trajectory points (fewer = less memory)
Ts = total_time / n_points; % Sample time

% STM32 clock frequency for timing
f_clk = 170e6; % 170 MHz

%% Generate Figure-8 Path
fprintf('=== Figure-8 Trajectory Generation ===\n\n');

% Parameter range (one full figure-8 = 0 to 2*pi)
t = linspace(0, 2 * pi, n_points + 1);
t = t(1:end - 1); % Remove duplicate end point

% Parametric equations for figure-8 (lemniscate)
x = A * sin(t);
y = A * sin(t) .* cos(t);

% Compute derivatives for velocity and curvature
dx_dt = A * cos(t);
dy_dt = A * (cos(t) .^ 2 - sin(t) .^ 2); % = A * cos(2t)

% Second derivatives for curvature
d2x_dt2 = -A * sin(t);
d2y_dt2 = -4 * A * sin(t) .* cos(t); % = -2A * sin(2t)

% Speed (magnitude of velocity)
speed_param = sqrt(dx_dt .^ 2 + dy_dt .^ 2);

% Curvature: kappa = |x'*y'' - y'*x''| / (x'^2 + y'^2)^(3/2)
numerator = abs(dx_dt .* d2y_dt2 - dy_dt .* d2x_dt2);
denominator = speed_param .^ 3;
curvature = numerator ./ (denominator +1e-10); % Avoid division by zero

%% Curvature-Based Speed Profile
% Slow down at high curvature, speed up at low curvature
% v = v_max / (1 + k_scale * |kappa|)

k_scale = 5; % Curvature scaling factor
v_profile = v_max ./ (1 + k_scale * curvature);
v_profile = max(v_profile, v_min);
v_profile = min(v_profile, v_max);

%% Compute Cart Velocities (vx, vy, wz)
% Normalize velocity direction
vx = v_profile .* dx_dt ./ speed_param;
vy = v_profile .* dy_dt ./ speed_param;

% Angular velocity: rate of heading change
heading = atan2(dy_dt, dx_dt);
heading_unwrapped = unwrap(heading);

% Compute heading derivative (angular velocity)
wz = gradient(heading_unwrapped) / Ts * (total_time / (2 * pi));

% Scale wz to be physically reasonable
wz_max = 2.0; % rad/s
wz = wz * v_max / max(abs(wz) + 0.01);
wz = max(min(wz, wz_max), -wz_max);

%% Compute Time Spacing
% Use arc length for adaptive timing
arc_length = zeros(1, n_points);

for i = 2:n_points
    arc_length(i) = arc_length(i - 1) + sqrt((x(i) - x(i - 1)) ^ 2 + (y(i) - y(i - 1)) ^ 2);
end

% Time based on arc length and speed profile
dt = zeros(1, n_points - 1);

for i = 1:n_points - 1
    ds = sqrt((x(i + 1) - x(i)) ^ 2 + (y(i + 1) - y(i)) ^ 2);
    v_avg = (v_profile(i) + v_profile(i + 1)) / 2;
    dt(i) = ds / v_avg;
end

% Normalize to total time
dt = dt * (total_time / sum(dt));
time = [0, cumsum(dt)];

fprintf('Path length: %.2f m\n', arc_length(end));
fprintf('Total time: %.2f s\n', time(end));
fprintf('Average speed: %.3f m/s\n', arc_length(end) / time(end));

%% Convert to STM32 Format
% Velocities stay in m/s and rad/s - the firmware handles the conversion
velocity_scale = 1.0; % Scale factor (1.0 = full speed)

vx_export = vx * velocity_scale;
vy_export = vy * velocity_scale;
wz_export = wz * velocity_scale;

% Convert time deltas to clock counts (TIM5 runs at 17MHz after prescaler=9)
f_tim5 = 17e6; % 170MHz / 10 = 17MHz
dt_clk = round(dt * f_tim5);

%% Visualization
figure('Position', [100, 100, 1200, 800]);

% Plot 1: Figure-8 path
subplot(2, 3, 1);
plot(x, y, 'b-', 'LineWidth', 2);
hold on;
scatter(x, y, 20, curvature, 'filled');
colorbar;
xlabel('x [m]');
ylabel('y [m]');
title('Figure-8 Path (color = curvature)');
axis equal;
grid on;

% Plot 2: Speed profile along path
subplot(2, 3, 2);
plot(arc_length, v_profile * 1000, 'b-', 'LineWidth', 2);
xlabel('Arc Length [m]');
ylabel('Speed [mm/s]');
title('Curvature-Based Speed Profile');
grid on;

% Plot 3: Curvature
subplot(2, 3, 3);
plot(arc_length, curvature, 'r-', 'LineWidth', 2);
xlabel('Arc Length [m]');
ylabel('Curvature [1/m]');
title('Path Curvature');
grid on;

% Plot 4: Velocity components vs time
subplot(2, 3, 4);
time_vel = time(1:n_points); % Match velocity array length
plot(time_vel, vx * 1000, 'r-', 'LineWidth', 1.5, 'DisplayName', 'vx');
hold on;
plot(time_vel, vy * 1000, 'g-', 'LineWidth', 1.5, 'DisplayName', 'vy');
xlabel('Time [s]');
ylabel('Velocity [mm/s]');
title('Velocity Components');
legend('Location', 'best');
grid on;

% Plot 5: Angular velocity
subplot(2, 3, 5);
plot(time_vel, wz, 'b-', 'LineWidth', 2);
xlabel('Time [s]');
ylabel('\omega_z [rad/s]');
title('Angular Velocity');
grid on;

% Plot 6: Time spacing (dt)
subplot(2, 3, 6);
bar(dt * 1000);
xlabel('Segment');
ylabel('\Delta t [ms]');
title('Adaptive Time Spacing');
grid on;

sgtitle('Figure-8 Trajectory for Mecanum Cart');

% Save figure
saveas(gcf, 'figure8_trajectory.png');
fprintf('\nFigure saved to: figure8_trajectory.png\n');

%% Export to C Header
fprintf('\n--- Exporting to trajectory.h ---\n');

output_file = '../../Core/Inc/trajectory.h';
trajectory_to_c(vx_export, vy_export, wz_export, dt_clk, output_file, 'figure8');

fprintf('\nTrajectory exported to: %s\n', output_file);

%% Export Full Data (for analysis)
trajectory_data.x = x;
trajectory_data.y = y;
trajectory_data.vx = vx;
trajectory_data.vy = vy;
trajectory_data.wz = wz;
trajectory_data.v_profile = v_profile;
trajectory_data.curvature = curvature;
trajectory_data.time = time;
trajectory_data.dt = dt;
trajectory_data.vt = vt;
trajectory_data.dt_clk = dt_clk;

save('figure8_trajectory_data.mat', 'trajectory_data');
fprintf('Data saved to: figure8_trajectory_data.mat\n');

%% Summary
fprintf('\n========================================\n');
fprintf('Figure-8 Trajectory Summary:\n');
fprintf('  Size: %.2f m x %.2f m\n', 2 * A, A);
fprintf('  Points: %d\n', n_points);
fprintf('  Duration: %.2f s\n', time(end));
fprintf('  Speed range: %.0f - %.0f mm/s\n', v_min * 1000, v_max * 1000);
fprintf('========================================\n');
