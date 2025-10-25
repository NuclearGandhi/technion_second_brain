function generate_plots(trajectory, torques, placement, robot, save_figs)
% GENERATE_PLOTS - Generate all required plots for the project report
%
% Inputs:
%   trajectory - Trajectory structure
%   torques - Torques structure
%   placement - Placement structure
%   robot - Robot parameters
%   save_figs - Boolean to save figures (default: true)

    if nargin < 5
        save_figs = true;
    end
    if nargin < 4
        robot = ur5_dh_parameters();
    end
    
    fprintf('\n=== Generating Plots ===\n\n');
    
    % Create output directory if it doesn't exist
    output_dir = 'plots/';
    if ~exist(output_dir, 'dir')
        mkdir(output_dir);
    end
    
    %% Plot 1: Joint Positions vs Time
    figure('Position', [100, 100, 1200, 800]);
    
    for i = 1:6
        subplot(3, 2, i);
        plot(trajectory.time, rad2deg(trajectory.q(i,:)), 'b-', 'LineWidth', 1.5);
        grid on;
        xlabel('Time (s)');
        ylabel(['Joint ' num2str(i) ' Angle (deg)']);
        title(['Joint ' num2str(i) ' Position']);
        
        % Mark start and end
        hold on;
        plot(trajectory.time(1), rad2deg(trajectory.q(i,1)), 'go', 'MarkerSize', 8, 'LineWidth', 2);
        plot(trajectory.time(end), rad2deg(trajectory.q(i,end)), 'ro', 'MarkerSize', 8, 'LineWidth', 2);
        hold off;
    end
    
    sgtitle('Joint Angles vs Time', 'FontSize', 14, 'FontWeight', 'bold');
    
    if save_figs
        saveas(gcf, [output_dir 'joint_positions.png']);
        fprintf('Saved: joint_positions.png\n');
    end
    
    %% Plot 2: Joint Velocities vs Time
    figure('Position', [100, 100, 1200, 800]);
    
    for i = 1:6
        subplot(3, 2, i);
        plot(trajectory.time, rad2deg(trajectory.qd(i,:)), 'b-', 'LineWidth', 1.5);
        grid on;
        xlabel('Time (s)');
        ylabel(['Joint ' num2str(i) ' Velocity (deg/s)']);
        title(['Joint ' num2str(i) ' Velocity']);
        
        % Mark maximum velocity
        [max_vel, max_idx] = max(abs(trajectory.qd(i,:)));
        hold on;
        plot(trajectory.time(max_idx), rad2deg(trajectory.qd(i,max_idx)), 'r*', ...
             'MarkerSize', 10, 'LineWidth', 2);
        
        % Draw velocity limits
        vel_limit = rad2deg(robot.max_velocity(i));
        yline(vel_limit, 'r--', 'Limit', 'LineWidth', 1);
        yline(-vel_limit, 'r--', 'LineWidth', 1);
        
        % Add text annotation offset from the max velocity point
        % Offset vertically by 10% of the y-range for visibility
        ax_ylim = ylim;
        y_offset = 0.10 * (ax_ylim(2) - ax_ylim(1));
        text(trajectory.time(max_idx), rad2deg(trajectory.qd(i,max_idx)) + y_offset, ...
             sprintf('Max: %.1f deg/s', rad2deg(max_vel)), ...
             'FontSize', 9, 'BackgroundColor', 'white', 'EdgeColor', 'black', ...
             'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'center');
        
        hold off;
    end
    
    sgtitle('Joint Velocities vs Time (with Limits)', 'FontSize', 14, 'FontWeight', 'bold');
    
    if save_figs
        saveas(gcf, [output_dir 'joint_velocities.png']);
        fprintf('Saved: joint_velocities.png\n');
    end
    
    %% Plot 3: Joint Torques vs Time
    figure('Position', [100, 100, 1200, 800]);
    
    % Find global max torque across all joints for consistent y-axis scaling
    global_max_torque = max(max(abs(torques.tau)));
    % Round up to nearest 50 for cleaner scale
    y_limit = ceil(global_max_torque / 50) * 50;
    if y_limit == 0
        y_limit = 10;  % Minimum scale for visibility
    end
    
    for i = 1:6
        subplot(3, 2, i);
        plot(torques.time, torques.tau(i,:), 'b-', 'LineWidth', 1.5);
        grid on;
        xlabel('Time (s)');
        ylabel(['Joint ' num2str(i) ' Torque (N-m)']);
        title(['Joint ' num2str(i) ' Torque']);
        
        % Set consistent y-axis limits for all subplots
        ylim([-y_limit, y_limit]);
        
        % Mark maximum torque
        [max_tor, max_idx] = max(abs(torques.tau(i,:)));
        hold on;
        plot(torques.time(max_idx), torques.tau(i,max_idx), 'r*', ...
             'MarkerSize', 10, 'LineWidth', 2);
        
        % Add text annotation
        text(0.7, 0.9, sprintf('Max: %.2f N-m', max_tor), ...
             'Units', 'normalized', 'FontSize', 9, 'BackgroundColor', 'white');
        
        hold off;
    end
    
    sgtitle('Joint Torques vs Time (0.6 kg Payload)', 'FontSize', 14, 'FontWeight', 'bold');
    
    if save_figs
        saveas(gcf, [output_dir 'joint_torques.png']);
        fprintf('Saved: joint_torques.png\n');
    end
    
    %% Plot 4: 3D End-Effector Trajectory
    figure('Position', [100, 100, 900, 700]);
    
    plot3(trajectory.pos(1,:), trajectory.pos(2,:), trajectory.pos(3,:), ...
          'b-', 'LineWidth', 2.5);
    hold on;
    
    % Start and end markers
    plot3(trajectory.pos(1,1), trajectory.pos(2,1), trajectory.pos(3,1), ...
          'go', 'MarkerSize', 12, 'LineWidth', 2, 'MarkerFaceColor', 'g');
    plot3(trajectory.pos(1,end), trajectory.pos(2,end), trajectory.pos(3,end), ...
          'ro', 'MarkerSize', 12, 'LineWidth', 2, 'MarkerFaceColor', 'r');
    
    % Robot base (get from placement if available)
    if nargin >= 3 && isfield(placement, 'base_x')
        base_x = placement.base_x;
        base_y = placement.base_y;
        base_z = placement.base_z;
    else
        base_x = 0;
        base_y = -0.35;
        base_z = 0.4;
    end
    plot3(base_x, base_y, base_z, 'k^', 'MarkerSize', 15, 'LineWidth', 2, 'MarkerFaceColor', 'k');
    
    % Draw coordinate frame at base
    quiver3(base_x, base_y, base_z, 0.2, 0, 0, 'r', 'LineWidth', 2, 'MaxHeadSize', 0.5);
    quiver3(base_x, base_y, base_z, 0, 0.2, 0, 'g', 'LineWidth', 2, 'MaxHeadSize', 0.5);
    quiver3(base_x, base_y, base_z, 0, 0, 0.2, 'b', 'LineWidth', 2, 'MaxHeadSize', 0.5);
    
    % Draw door surface representation at Y = 0.4m
    door_y_position = 0.4;  % Actual door position
    [door_x_mesh, door_z_mesh] = meshgrid([-0.5, 0.5], [-0.5, 0.5]);
    door_y_mesh = door_y_position * ones(size(door_x_mesh));
    surf(door_x_mesh, door_y_mesh, door_z_mesh, 'FaceAlpha', 0.3, 'EdgeColor', 'k', ...
         'EdgeAlpha', 0.3, 'FaceColor', [0.7 0.7 0.9]);
    
    grid on;
    xlabel('X (m) - Conveyor Direction');
    ylabel('Y (m)');
    zlabel('Z (m)');
    title('3D End-Effector Trajectory - Triangle Painting', 'FontSize', 12, 'FontWeight', 'bold');
    legend('Paint Path', 'Start', 'End', 'Robot Base', 'X-axis', 'Y-axis', 'Z-axis', ...
           'Door Surface', 'Location', 'best');
    view(45, 25);
    axis equal;
    hold off;
    
    if save_figs
        saveas(gcf, [output_dir 'ee_trajectory_3d.png']);
        fprintf('Saved: ee_trajectory_3d.png\n');
    end
    
    %% Plot 5: Robot Configuration Snapshots
    figure('Position', [100, 100, 1200, 400]);
    
    % Show robot at start, middle, and end
    snapshot_indices = [1, round(length(trajectory.time)/2), length(trajectory.time)];
    snapshot_labels = {'Start', 'Middle', 'End'};
    
    for s = 1:3
        subplot(1, 3, s);
        idx = snapshot_indices(s);
        q = trajectory.q(:, idx);
        
        % Plot robot stick figure
        plot_robot_config(q, robot);
        
        title([snapshot_labels{s} sprintf(' (t=%.2fs)', trajectory.time(idx))]);
        xlabel('X (m)');
        ylabel('Y (m)');
        zlabel('Z (m)');
        grid on;
        axis equal;
        view(45, 25);
    end
    
    sgtitle('Robot Configurations During Painting', 'FontSize', 14, 'FontWeight', 'bold');
    
    if save_figs
        saveas(gcf, [output_dir 'robot_snapshots.png']);
        fprintf('Saved: robot_snapshots.png\n');
    end
    
    fprintf('\nAll plots generated successfully.\n');
end

function plot_robot_config(q, robot)
% PLOT_ROBOT_CONFIG - Plot 3D stick figure of robot configuration
    
    % Get all transformation matrices
    [~, T_all] = forward_kinematics(q, robot);
    
    % Extract joint positions
    positions = zeros(3, 7);
    positions(:, 1) = [0; 0; 0];  % Base
    
    for i = 1:6
        positions(:, i+1) = T_all{i}(1:3, 4);
    end
    
    % Plot links
    hold on;
    for i = 1:6
        plot3([positions(1,i), positions(1,i+1)], ...
              [positions(2,i), positions(2,i+1)], ...
              [positions(3,i), positions(3,i+1)], ...
              'b-', 'LineWidth', 3);
    end
    
    % Plot joints
    plot3(positions(1,:), positions(2,:), positions(3,:), ...
          'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
    
    % Plot base
    plot3(0, 0, 0, 'ks', 'MarkerSize', 12, 'MarkerFaceColor', 'k');
    
    % Plot end-effector
    plot3(positions(1,end), positions(2,end), positions(3,end), ...
          'g^', 'MarkerSize', 12, 'MarkerFaceColor', 'g');
    
    hold off;
end

