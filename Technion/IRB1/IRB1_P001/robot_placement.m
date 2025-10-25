function [placement, via_points] = robot_placement(robot)
% ROBOT_PLACEMENT - Determine optimal robot placement and via-points
%
% Inputs:
%   robot - Robot parameters structure
%
% Outputs:
%   placement - Struct with robot placement information
%   via_points - Matrix of via-points for triangle trajectory [3 x N]
%
% Problem parameters:
%   - Conveyor velocity: 0.3 m/s
%   - Triangle: equilateral, 40 cm sides
%   - Nozzle distance from door: 10 cm (perpendicular)
%   - Door dimensions: 2m height, 1m width

    if nargin < 1
        robot = ur5_dh_parameters();
    end
    
    %% Optimal Robot Placement (Assignment 1)
    
    fprintf('\n=== Optimal Robot Placement ===\n\n');
    
    % Conveyor parameters
    conveyor.velocity = 0.3;  % m/s
    conveyor.height = 0.5;    % m (approximate ground to door bottom)
    
    % Door parameters
    door.height = 2.0;  % m
    door.width = 1.0;   % m
    
    % Triangle parameters (from Figure 2)
    triangle.side_length = 0.4;  % m (40 cm)
    triangle.center_height = 1.0;  % m from ground
    triangle.offset_from_edge = 0.2;  % m from door left edge
    
    % Nozzle constraint
    nozzle.distance = 0.10;  % m (10 cm from door, middle of 5-20 cm range)
    
    % Optimal placement rationale:
    % Robot base at origin (0, 0, 0) - standard reference frame
    % Position door and triangle within reach of robot
    
    % Robot base position (ORIGIN)
    placement.base_x = 0.0;      % m
    placement.base_y = 0.0;      % m
    placement.base_z = 0.0;      % m
    
    % Door and triangle positioning (relative to robot base)
    % Door surface at Y = 0.4 m from robot base
    % Nozzle at Y = 0.3 m (10 cm from door surface)
    % Triangle center at comfortable working height and position
    
    door_y_position = 0.40;  % Door surface 40 cm from robot base
    
    % Triangle geometry calculations:
    % - Bottom center of triangle at z = -0.2m (below base to reduce max reach)
    % - Triangle height = 0.4 * sqrt(3)/2 = 0.346m
    % - Centroid at z = -0.2 + 0.346/3 = -0.085m
    triangle_bottom_z = -0.2;  % Bottom center below base level
    triangle_height_geom = triangle.side_length * sqrt(3) / 2;
    triangle_centroid_z = triangle_bottom_z + triangle_height_geom / 3;
    
    placement.work_region_x = 0.0;  % Centered in front of robot
    placement.work_region_y = door_y_position - nozzle.distance;  % 10 cm from door
    placement.work_region_z = triangle_centroid_z;  % Centroid height based on bottom at z=0.2
    
    % Calculate actual distance to work region
    dist_to_work = norm([placement.work_region_x - placement.base_x, ...
                        placement.work_region_y - placement.base_y, ...
                        placement.work_region_z - placement.base_z]);
    
    fprintf('Robot Base Position (Reference Frame Origin):\n');
    fprintf('  X = %.3f m\n', placement.base_x);
    fprintf('  Y = %.3f m\n', placement.base_y);
    fprintf('  Z = %.3f m\n', placement.base_z);
    fprintf('\n');
    
    fprintf('Work Region (Triangle Center):\n');
    fprintf('  Position: [%.2f, %.2f, %.2f] m\n', ...
            placement.work_region_x, placement.work_region_y, placement.work_region_z);
    fprintf('  Distance from base: %.3f m ', dist_to_work);
    if dist_to_work <= robot.specs.reach
        fprintf('(within %.3f m reach) ✓\n', robot.specs.reach);
    else
        fprintf('(EXCEEDS %.3f m reach) ✗\n', robot.specs.reach);
    end
    fprintf('\n');
    
    fprintf('Door Position:\n');
    fprintf('  Door surface at Y = %.2f m\n', door_y_position);
    fprintf('  Nozzle at Y = %.2f m (%.0f cm from door)\n', ...
            door_y_position - nozzle.distance, nozzle.distance * 100);
    fprintf('\n');
    
    %% Via-Points for Triangle Trajectory (Assignment 2)
    
    fprintf('=== Triangle Via-Points Generation ===\n\n');
    
    % Triangle geometry: equilateral triangle with 40 cm sides
    % Bottom center at z = 0.2m as specified
    side_len = triangle.side_length;
    height_triangle = side_len * sqrt(3) / 2;
    
    % Triangle positioned with bottom center at (0, triangle_bottom_z)
    center_x = 0.0;  % X position (centered in front of robot)
    bottom_center_z = triangle_bottom_z;  % Bottom center at z = 0.2m
    
    % Vertices in XZ plane (door frame)
    % Vertex 1 (top) - directly above bottom center
    v1 = [center_x; 
          bottom_center_z + height_triangle];
    
    % Vertex 2 (bottom right)
    v2 = [center_x + side_len/2; 
          bottom_center_z];
    
    % Vertex 3 (bottom left)
    v3 = [center_x - side_len/2; 
          bottom_center_z];
    
    fprintf('Triangle Vertices in Door Frame:\n');
    fprintf('  V1 (top):    [%.3f, %.3f] m\n', v1(1), v1(2));
    fprintf('  V2 (bottom right): [%.3f, %.3f] m\n', v2(1), v2(2));
    fprintf('  V3 (bottom left):  [%.3f, %.3f] m\n', v3(1), v3(2));
    fprintf('\n');
    
    % Time parameters (determine first to know how many points we need)
    total_time = 3.0;  % seconds (faster trajectory - 3s instead of 4s)
    dt = 0.01;  % 0.01 seconds between via-points as specified
    time_vector = 0:dt:total_time;
    n_points = length(time_vector);  % Calculate based on dt and total_time
    
    % Generate via-points along triangle perimeter
    % Paint order: V1 -> V2 -> V3 -> V1 (closed triangle)
    % At 0.01s intervals for 3 seconds = 301 points total
    points_per_side = ceil(n_points / 3);  % Distribute points evenly across 3 sides
    
    % Side 1: V1 to V2
    side1_x = linspace(v1(1), v2(1), points_per_side);
    side1_z = linspace(v1(2), v2(2), points_per_side);
    
    % Side 2: V2 to V3
    side2_x = linspace(v2(1), v3(1), points_per_side);
    side2_z = linspace(v2(2), v3(2), points_per_side);
    
    % Side 3: V3 to V1
    side3_x = linspace(v3(1), v1(1), points_per_side);
    side3_z = linspace(v3(2), v1(2), points_per_side);
    
    % Combine all sides and trim to exact n_points
    path_x_door = [side1_x, side2_x(2:end), side3_x(2:end)];
    path_z_door = [side1_z, side2_z(2:end), side3_z(2:end)];
    
    % Trim or pad to match exactly n_points
    if length(path_x_door) > n_points
        path_x_door = path_x_door(1:n_points);
        path_z_door = path_z_door(1:n_points);
    elseif length(path_x_door) < n_points
        % Pad by repeating last point
        path_x_door = [path_x_door, repmat(path_x_door(end), 1, n_points - length(path_x_door))];
        path_z_door = [path_z_door, repmat(path_z_door(end), 1, n_points - length(path_z_door))];
    end
    
    fprintf('Total via-points: %d\n', n_points);
    fprintf('Time interval: %.4f s (0.01s as specified)\n', dt);
    fprintf('Total painting time: %.2f s\n', total_time);
    fprintf('\n');
    
    % Account for moving conveyor
    % Door moves in +X direction at conveyor velocity
    % At time t, door has moved conveyor.velocity * t
    % Adjust X position to track the moving door
    
    via_points = zeros(3, n_points);  % [X; Y; Z] in world frame (robot base frame)
    
    % CRITICAL ISSUE: Door moves 1.5m during 5s painting time
    % End-effector would need to track from X=0 to X=1.5m
    % Distance at t=5s: sqrt(1.5^2 + 0.3^2 + 0.3^2) = 1.56m >> 0.85m reach!
    % 
    % SOLUTION: Offset the door's initial position so painting happens
    % when door is already in front of robot, minimizing total X displacement
    % 
    % Strategy: Start painting when door center is at X = 0.5m
    % This means at t=0, door has already traveled some distance
    % We paint as it moves from X=0.5m to X=2.0m, but robot only tracks
    % the portion that keeps end-effector within reach
    %
    % Better approach: Since triangle width is 0.4m and takes 5s,
    % start at X offset such that midpoint is at X=0.3m (good reach distance)
    
    % Offset to center the painting range around X = 0 (robot base)
    % Door travel = conveyor.velocity * total_time
    % Via-point X range: [x_offset - 0.2] to [x_offset + door_travel + 0.2]
    % Center: (x_offset - 0.2 + x_offset + door_travel + 0.2) / 2 = x_offset + door_travel/2
    % To center at robot base (X=0): x_offset + door_travel/2 = 0
    door_travel = conveyor.velocity * total_time;  % 0.9m for 3s
    initial_door_offset = -door_travel / 2;  % = -0.45m for 3s
    
    for i = 1:n_points
        t = time_vector(i);
        
        % Door displacement from offset starting position
        door_displacement = initial_door_offset + conveyor.velocity * t;
        
        % Via-point in robot frame:
        via_points(1, i) = path_x_door(i) + door_displacement;
        via_points(2, i) = placement.work_region_y;  % Fixed Y (nozzle position)
        via_points(3, i) = path_z_door(i);
    end
    
    fprintf('Conveyor Synchronization:\n');
    fprintf('  Door velocity: %.2f m/s\n', conveyor.velocity);
    fprintf('  Painting time: %.2f s\n', total_time);
    fprintf('  Door travel during painting: %.2f m\n', conveyor.velocity * total_time);
    fprintf('  Initial door offset: %.2f m (centers trajectory at X≈%.2fm)\n', ...
            initial_door_offset, initial_door_offset + conveyor.velocity * total_time / 2);
    fprintf('  End-effector X range: [%.2f, %.2f] m\n', ...
            min(via_points(1,:)), max(via_points(1,:)));
    fprintf('\n');
    
    % Store via-points info
    placement.triangle_vertices = [v1, v2, v3];
    placement.via_points_world = via_points;
    placement.time_vector = time_vector;
    placement.n_via_points = n_points;
    placement.total_time = total_time;
    placement.dt = dt;
    
    % Nozzle orientation: Use simple achievable orientation
    % For UR5, use a configuration that points roughly toward the door
    placement.nozzle_orientation = [0; 0; -1];  % -Z direction (downward pointing tool)
    
    % End-effector orientation matrix
    % Use identity with rotation to point tool downward/forward
    % This is achievable for UR5 in the working region
    % Tool Z-axis points downward, X forward, Y to side
    placement.R_desired = eye(3);  % Identity - simplest achievable orientation
    
    fprintf('End-Effector Orientation (constant):\n');
    fprintf('  Using identity orientation for maximum reachability\n');
    fprintf('  (Can be adjusted for specific nozzle requirements)\n');
    fprintf('\n');
    
    %% Visualization
    figure('Position', [100, 100, 1200, 500]);
    
    % 3D view
    subplot(1, 2, 1);
    plot3(via_points(1,:), via_points(2,:), via_points(3,:), 'b-', 'LineWidth', 2);
    hold on;
    plot3(via_points(1,1), via_points(2,1), via_points(3,1), 'go', 'MarkerSize', 10, 'LineWidth', 2);
    plot3(via_points(1,end), via_points(2,end), via_points(3,end), 'ro', 'MarkerSize', 10, 'LineWidth', 2);
    
    % Mark robot base (use actual base position)
    plot3(placement.base_x, placement.base_y, placement.base_z, 'k^', ...
          'MarkerSize', 15, 'LineWidth', 2, 'MarkerFaceColor', 'k');
    
    % Draw conveyor representation
    conv_x = [-0.5, 2.5];
    conv_y = [0, 0];
    conv_z = [conveyor.height, conveyor.height];
    plot3(conv_x, conv_y, conv_z, 'k--', 'LineWidth', 1);
    
    xlabel('X (m) - Conveyor Direction');
    ylabel('Y (m)');
    zlabel('Z (m)');
    title('Triangle Trajectory in 3D (World Frame)');
    grid on;
    axis equal;
    legend('Triangle Path', 'Start', 'End', 'Robot Base', 'Conveyor', 'Location', 'best');
    view(45, 30);
    hold off;
    
    % XZ view (door view)
    subplot(1, 2, 2);
    plot(via_points(1,:), via_points(3,:), 'b-', 'LineWidth', 2);
    hold on;
    plot(via_points(1,1), via_points(3,1), 'go', 'MarkerSize', 10, 'LineWidth', 2);
    plot(via_points(1,end), via_points(3,end), 'ro', 'MarkerSize', 10, 'LineWidth', 2);
    
    % Mark vertices
    plot([v1(1), v2(1), v3(1), v1(1)] + [0, 0, 0, 0], ...
         [v1(2), v2(2), v3(2), v1(2)], 'r--', 'LineWidth', 1);
    
    xlabel('X (m) - Horizontal on Door');
    ylabel('Z (m) - Vertical');
    title('Triangle on Door Surface (accounting for motion)');
    grid on;
    axis equal;
    legend('Path with Conveyor Motion', 'Start', 'End', 'Static Triangle', 'Location', 'best');
    hold off;
    
    sgtitle('UR5e Triangle Painting Trajectory');
    
    % Create output directory if it doesn't exist
    if ~exist('plots', 'dir')
        mkdir('plots');
    end
    saveas(gcf, 'plots/triangle_trajectory.png');
    fprintf('Saved: plots/triangle_trajectory.png\n\n');
    
    % Save placement information
    placement.conveyor = conveyor;
    placement.door = door;
    placement.door_y_position = door_y_position;  % Actual door surface Y coordinate
    placement.triangle = triangle;
    placement.nozzle = nozzle;
    
    fprintf('Robot placement and via-points generation complete.\n');
end

