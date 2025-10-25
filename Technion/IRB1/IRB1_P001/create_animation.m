%% Create Animation of Robot Motion
% Standalone script to animate the UR5e robot painting the triangle
%
% Usage:
%   1. First run main_simulation.m to generate simulation_results.mat
%   2. Then run this script to create the animation
%
% Options:
%   - Set save_video = true to save as MP4 file
%   - Adjust frame_rate and playback_speed as desired

clear; close all; clc;

%% Configuration
save_video = true;          % Set to true to save animation as video
video_filename = 'robot_animation.mp4';
frame_rate = 30;            % Frames per second for video
playback_speed = 1.0;       % 1.0 = real-time, 0.5 = slow motion, 2.0 = 2x speed
skip_frames = 5;            % Show every Nth frame (reduce for smoother animation)

%% Load Simulation Results
if ~exist('simulation_results.mat', 'file')
    error('simulation_results.mat not found. Please run main_simulation.m first.');
end

fprintf('Loading simulation results...\n');
load('simulation_results.mat', 'robot', 'placement', 'trajectory');
fprintf('Data loaded successfully.\n\n');

%% Prepare Animation
fprintf('Preparing animation...\n');
fprintf('  Total time: %.2f seconds\n', trajectory.time(end));
fprintf('  Total frames: %d\n', length(trajectory.time));
fprintf('  Displaying every %d frames\n', skip_frames);
fprintf('  Playback speed: %.1fx\n\n', playback_speed);

% Indices to animate (skip frames for faster rendering)
frame_indices = 1:skip_frames:length(trajectory.time);
n_frames = length(frame_indices);

%% Setup Figure
fig = figure('Position', [100, 100, 1200, 800], 'Color', 'w');
ax = axes('Parent', fig);
hold(ax, 'on');
grid(ax, 'on');
xlabel(ax, 'X (m)');
ylabel(ax, 'Y (m)');
zlabel(ax, 'Z (m)');
title(ax, 'UR5e Robot Painting Triangle - Time: 0.00s', 'FontSize', 14);
view(ax, 45, 30);
axis(ax, 'equal');
set(ax, 'XLim', [-0.8, 0.8], 'YLim', [-0.2, 0.6], 'ZLim', [-0.3, 0.8]);

% Draw door surface
door_y = placement.door_y_position;
[door_X, door_Z] = meshgrid([-0.5, 0.5], [-0.3, 0.8]);
door_Y = door_y * ones(size(door_X));
surf(ax, door_X, door_Y, door_Z, 'FaceAlpha', 0.2, 'FaceColor', [0.8, 0.8, 0.9], ...
     'EdgeColor', 'none');

% Draw floor (at z = -0.5m, well below the triangle)
floor_z = -0.5;
[floor_X, floor_Y] = meshgrid([-0.8, 0.8], [-0.2, 0.6]);
floor_Z = floor_z * ones(size(floor_X));
surf(ax, floor_X, floor_Y, floor_Z, 'FaceAlpha', 0.1, 'FaceColor', [0.7, 0.7, 0.7], ...
     'EdgeColor', 'none');

% Plot complete trajectory path (faint)
plot3(ax, trajectory.pos(1,:), trajectory.pos(2,:), trajectory.pos(3,:), ...
      'b-', 'LineWidth', 0.5, 'Color', [0.5, 0.5, 1, 0.3]);

% Initialize robot visualization elements
robot_links = cell(1, 6);
robot_joints = [];
ee_trail = [];

% Color scheme for links
link_colors = [
    0.8, 0.2, 0.2;  % Joint 1: Red
    0.2, 0.8, 0.2;  % Joint 2: Green
    0.2, 0.2, 0.8;  % Joint 3: Blue
    0.8, 0.8, 0.2;  % Joint 4: Yellow
    0.8, 0.2, 0.8;  % Joint 5: Magenta
    0.2, 0.8, 0.8   % Joint 6: Cyan
];

%% Setup Video Writer
if save_video
    fprintf('Initializing video writer...\n');
    v = VideoWriter(video_filename, 'MPEG-4');
    v.FrameRate = frame_rate / playback_speed;
    v.Quality = 95;
    open(v);
end

%% Animation Loop
fprintf('Creating animation...\n');
tic;

for idx = 1:n_frames
    i = frame_indices(idx);
    
    % Get current configuration
    q = trajectory.q(:, i);
    t = trajectory.time(i);
    
    % Compute forward kinematics for all joints
    [~, T_all] = forward_kinematics(q, robot);
    
    % Extract joint positions
    joint_positions = zeros(3, 7);
    joint_positions(:, 1) = [0; 0; 0];  % Base
    for j = 1:6
        joint_positions(:, j+1) = T_all{j}(1:3, 4);
    end
    
    % Clear previous robot visualization
    if ~isempty(robot_links)
        for j = 1:6
            try
                delete(robot_links{j});
            catch
                % Handle already deleted or invalid
            end
        end
    end
    if ~isempty(robot_joints)
        try
            delete(robot_joints);
        catch
            % Handle already deleted or invalid
        end
    end
    
    % Draw robot links
    for j = 1:6
        robot_links{j} = plot3(ax, ...
            joint_positions(1, j:j+1), ...
            joint_positions(2, j:j+1), ...
            joint_positions(3, j:j+1), ...
            '-', 'LineWidth', 4, 'Color', link_colors(j, :));
    end
    
    % Draw joints as spheres
    robot_joints = plot3(ax, joint_positions(1, :), joint_positions(2, :), ...
                        joint_positions(3, :), 'ko', 'MarkerSize', 8, ...
                        'MarkerFaceColor', [0.3, 0.3, 0.3]);
    
    % Update end-effector trail
    if isempty(ee_trail)
        ee_trail = plot3(ax, trajectory.pos(1, 1:i), trajectory.pos(2, 1:i), ...
                        trajectory.pos(3, 1:i), 'r-', 'LineWidth', 3);
    else
        set(ee_trail, 'XData', trajectory.pos(1, 1:i), ...
                      'YData', trajectory.pos(2, 1:i), ...
                      'ZData', trajectory.pos(3, 1:i));
    end
    
    % Update title with time
    title(ax, sprintf('UR5e Robot Painting Triangle - Time: %.2fs / %.2fs', ...
                     t, trajectory.time(end)), 'FontSize', 14);
    
    % Render frame
    drawnow;
    
    % Save frame to video
    if save_video
        frame = getframe(fig);
        writeVideo(v, frame);
    end
    
    % Progress indicator
    if mod(idx, 10) == 0
        fprintf('  Progress: %d/%d frames (%.1f%%)\n', idx, n_frames, 100*idx/n_frames);
    end
    
    % Pause to control playback speed (only if not saving video)
    if ~save_video && idx < n_frames
        actual_dt = trajectory.time(frame_indices(idx+1)) - trajectory.time(frame_indices(idx));
        pause(actual_dt / playback_speed);
    end
end

elapsed_time = toc;
fprintf('\nAnimation complete!\n');
fprintf('  Rendering time: %.2f seconds\n', elapsed_time);

%% Finalize Video
if save_video
    close(v);
    fprintf('\nVideo saved to: %s\n', video_filename);
    fprintf('  Duration: %.2f seconds\n', trajectory.time(end));
    fprintf('  Frame rate: %.1f fps\n', v.FrameRate);
    fprintf('  File size: %.2f MB\n', dir(video_filename).bytes / 1e6);
end

fprintf('\n=== Animation Script Complete ===\n\n');

% Keep figure open
hold(ax, 'off');

