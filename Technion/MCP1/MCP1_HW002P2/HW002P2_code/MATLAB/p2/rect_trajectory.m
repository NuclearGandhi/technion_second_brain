%% rect_trajectory.m
% Interactive Rectangle Trajectory Generator
% MCP1 Lab 2 Part 2 - Assignment 3
%
% This script allows interactive selection of rectangle corners
% and generates a smooth trajectory using Catmull-Rom splines.
%
% Usage:
%   1. Run the script
%   2. Click on the figure to define rectangle corners
%   3. Close the drawing window when done
%   4. Trajectory is generated and exported

clear; close all; clc;

%% Configuration
% Add path to given functions
addpath('../p2-given');

% Trajectory parameters
v_min = 50;           % Minimum speed [mm/s equivalent units]
v_max = 200;          % Maximum speed
samples_per_segment = 25;  % Spline resolution

% Target rectangle size (for reference grid)
target_width = 2.0;   % meters
target_height = 1.0;  % meters

% STM32 clock frequency
f_clk = 170e6;        % 170 MHz

% Total trajectory time
total_time = 20;      % seconds

%% Interactive Point Selection
fprintf('=== Interactive Rectangle Trajectory ===\n\n');
fprintf('Instructions:\n');
fprintf('  1. Click to place corner points of the rectangle\n');
fprintf('  2. For a ~2m x ~1m rectangle, place 4 corners\n');
fprintf('  3. Close the window when done\n\n');

% Create figure for point selection
fig_draw = figure('Name', 'Draw Rectangle Path', ...
                  'Position', [100, 100, 800, 600], ...
                  'Color', 'white');

ax = axes('Position', [0.1, 0.1, 0.8, 0.8]);
hold on;
grid on;
axis equal;

% Set axis limits for ~2m x 1m workspace
xlim([-0.5, 2.5]);
ylim([-0.5, 1.5]);

xlabel('X [m]');
ylabel('Y [m]');
title('Click to add rectangle corners (close window when done)');

% Draw reference rectangle
rectangle('Position', [0, 0, target_width, target_height], ...
          'EdgeColor', [0.8, 0.8, 0.8], 'LineStyle', '--', 'LineWidth', 1);
text(target_width/2, -0.2, sprintf('Reference: %.1fm x %.1fm', target_width, target_height), ...
     'HorizontalAlignment', 'center', 'Color', [0.5, 0.5, 0.5]);

% Collect points interactively
points = [];
point_handles = [];
line_handles = [];

set(fig_draw, 'WindowButtonDownFcn', @add_point);

% Wait for figure to close
waitfor(fig_draw);

%% Process Points
if size(points, 1) < 3
    error('Need at least 3 points to create a path. Got %d.', size(points, 1));
end

fprintf('\nCollected %d points\n', size(points, 1));

% Close the path by adding the first point at the end
points_closed = [points; points(1, :)];

x_pts = points_closed(:, 1);
y_pts = points_closed(:, 2);

%% Generate Spline Trajectory
fprintf('\n--- Generating Spline Trajectory ---\n');

try
    % Use Catmull-Rom spline fitting from given code
    [s, xs, ys, dxds, dyds, kappa, vt_raw, tt, pp] = ...
        catmullRomSplineFit1(x_pts, y_pts, v_min, v_max, ...
        'SamplesPerSegment', samples_per_segment, ...
        'VtEpsKappa', 0.03, ...
        'VtRefStrategy', 'max', ...
        'Alpha', 0.5, ...
        'Plot', false);
    
    fprintf('Spline generated with %d points\n', length(xs));
catch ME
    warning('catmullRomSplineFit1 failed: %s', ME.message);
    fprintf('Using linear interpolation instead.\n');
    
    % Simple linear interpolation fallback
    n_segments = size(points_closed, 1) - 1;
    total_pts = n_segments * samples_per_segment;
    
    xs = [];
    ys = [];
    for seg = 1:n_segments
        t_seg = linspace(0, 1, samples_per_segment + 1);
        t_seg = t_seg(1:end-1);
        
        xs = [xs, points_closed(seg, 1) + t_seg * (points_closed(seg+1, 1) - points_closed(seg, 1))];
        ys = [ys, points_closed(seg, 2) + t_seg * (points_closed(seg+1, 2) - points_closed(seg, 2))];
    end
    
    % Compute arc length
    s = zeros(1, length(xs));
    for i = 2:length(xs)
        s(i) = s(i-1) + sqrt((xs(i)-xs(i-1))^2 + (ys(i)-ys(i-1))^2);
    end
    
    % Simple velocity profile
    vt_raw = v_max * ones(size(xs));
    
    % Compute time
    tt = zeros(size(s));
    for i = 2:length(s)
        ds = s(i) - s(i-1);
        tt(i) = tt(i-1) + ds / vt_raw(i);
    end
    
    kappa = zeros(size(xs));
    dxds = gradient(xs);
    dyds = gradient(ys);
end

%% Compute Velocities
% Velocity direction from spline tangent
speed_mag = sqrt(dxds.^2 + dyds.^2);
speed_mag(speed_mag < 0.001) = 0.001;

vx = vt_raw(:)' .* dxds(:)' ./ speed_mag(:)';
vy = vt_raw(:)' .* dyds(:)' ./ speed_mag(:)';

% Angular velocity from heading change
heading = atan2(dyds, dxds);
heading_unwrapped = unwrap(heading);
dt_array = diff(tt);
dt_array(dt_array < 0.001) = 0.001;
wz = [0, diff(heading_unwrapped) ./ dt_array];

% Limit angular velocity
wz_max = 2.0;
wz = max(min(wz, wz_max), -wz_max);

%% Scale to Total Time
time_scale = total_time / tt(end);
tt_scaled = tt * time_scale;
dt_scaled = diff(tt_scaled);

%% Convert to STM32 Format
% Scale velocities
vt = round(vt_raw);

% Add end markers
vt = [vt(:)', 0, 9999, 9999];

% Convert time to clock counts
dt_clk = round(dt_scaled * f_clk);
dt_clk = [dt_clk, round(0.1 * f_clk), round(0.1 * f_clk)];

%% Visualization
figure('Position', [100, 100, 1200, 600]);

% Plot 1: Path with control points
subplot(1, 2, 1);
plot(xs, ys, 'b-', 'LineWidth', 2);
hold on;
plot(x_pts, y_pts, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
scatter(xs, ys, 10, vt_raw, 'filled');
colorbar;
xlabel('X [m]');
ylabel('Y [m]');
title('Rectangle Path (color = speed)');
axis equal;
grid on;
legend('Spline path', 'Control points', 'Location', 'best');

% Plot 2: Velocity profile
subplot(1, 2, 2);
plot(tt_scaled, vt_raw, 'b-', 'LineWidth', 2);
xlabel('Time [s]');
ylabel('Speed [units]');
title('Speed Profile');
grid on;

sgtitle('Rectangle Trajectory');

saveas(gcf, 'rect_trajectory.png');
fprintf('\nFigure saved to: rect_trajectory.png\n');

%% Export to C Header
fprintf('\n--- Exporting to trajectory.h ---\n');

output_file = '../../Core/Inc/trajectory.h';
trajectory_to_c(vt(1:end-2), dt_clk(1:end-2), output_file, 'rectangle');

fprintf('\nTrajectory exported to: %s\n', output_file);

%% Save Data
trajectory_data.control_points = points;
trajectory_data.xs = xs;
trajectory_data.ys = ys;
trajectory_data.vx = vx;
trajectory_data.vy = vy;
trajectory_data.wz = wz;
trajectory_data.vt = vt;
trajectory_data.time = tt_scaled;
trajectory_data.dt_clk = dt_clk;

save('rect_trajectory_data.mat', 'trajectory_data');
fprintf('Data saved to: rect_trajectory_data.mat\n');

%% Summary
path_length = s(end);
fprintf('\n========================================\n');
fprintf('Rectangle Trajectory Summary:\n');
fprintf('  Control points: %d\n', size(points, 1));
fprintf('  Spline points: %d\n', length(xs));
fprintf('  Path length: %.2f m\n', path_length);
fprintf('  Duration: %.2f s\n', tt_scaled(end));
fprintf('========================================\n');

%% Nested Callback Function
function add_point(~, ~)
    pt = get(ax, 'CurrentPoint');
    px = pt(1, 1);
    py = pt(1, 2);
    
    % Check if within bounds
    lim = axis(ax);
    if px >= lim(1) && px <= lim(2) && py >= lim(3) && py <= lim(4)
        points = [points; px, py];
        
        % Draw point
        h = plot(ax, px, py, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'red');
        point_handles = [point_handles; h];
        
        % Label point
        text(ax, px + 0.05, py + 0.05, num2str(size(points, 1)), 'FontSize', 12);
        
        % Draw line to previous point
        if size(points, 1) > 1
            prev = points(end-1, :);
            lh = plot(ax, [prev(1), px], [prev(2), py], 'b-', 'LineWidth', 1.5);
            line_handles = [line_handles; lh];
        end
        
        title(ax, sprintf('Points: %d (close window when done)', size(points, 1)));
    end
end

end

