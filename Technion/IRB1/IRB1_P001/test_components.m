%% Test Script for Individual Components
% This script tests each component of the UR5e simulation independently
% to verify correct implementation before running the full simulation

clear; close all; clc;

fprintf('========================================\n');
fprintf('  Component Testing Script\n');
fprintf('========================================\n\n');

%% Test 1: Robot Parameters
fprintf('Test 1: Robot Parameters Initialization\n');
fprintf('----------------------------------------\n');

robot = ur5_dh_parameters();
fprintf('✓ Robot parameters loaded successfully\n');
fprintf('  - Number of joints: %d\n', robot.n);
fprintf('  - Base position: [%.2f, %.2f, %.2f] m\n', robot.base_position);
fprintf('  - Maximum reach: %.3f m\n', robot.specs.reach);
fprintf('\n');

%% Test 2: Forward Kinematics
fprintf('Test 2: Forward Kinematics\n');
fprintf('----------------------------------------\n');

% Test configuration
q_test = [0; -pi/4; pi/4; 0; pi/2; 0];
fprintf('Test configuration (rad): [%.3f, %.3f, %.3f, %.3f, %.3f, %.3f]\n', q_test);

[T, T_all] = forward_kinematics(q_test, robot);
pos = T(1:3, 4);
fprintf('End-effector position: [%.4f, %.4f, %.4f] m\n', pos);
fprintf('Distance from base: %.4f m\n', norm(pos));

% Check if within reach
if norm(pos) <= robot.specs.reach
    fprintf('✓ Within robot reach\n');
else
    fprintf('✗ Outside robot reach!\n');
end
fprintf('\n');

%% Test 3: Inverse Kinematics
fprintf('Test 3: Inverse Kinematics\n');
fprintf('----------------------------------------\n');

% Use FK result as target
T_target = T;
fprintf('Target position: [%.4f, %.4f, %.4f] m\n', T_target(1:3, 4));

[q_all, q_best] = inverse_kinematics(T_target, q_test, robot);
fprintf('Number of IK solutions found: %d\n', size(q_all, 2));
fprintf('Best solution (rad): [%.3f, %.3f, %.3f, %.3f, %.3f, %.3f]\n', q_best);

% Verify by FK
T_verify = forward_kinematics(q_best, robot);
error_pos = norm(T_verify(1:3, 4) - T_target(1:3, 4));
error_rot = norm(T_verify(1:3, 1:3) - T_target(1:3, 1:3), 'fro');

fprintf('Position error: %.6f m\n', error_pos);
fprintf('Rotation error: %.6f\n', error_rot);

if error_pos < 1e-3 && error_rot < 1e-3
    fprintf('✓ IK verification passed\n');
else
    fprintf('✗ IK verification failed\n');
end
fprintf('\n');

%% Test 4: Jacobian Computation
fprintf('Test 4: Jacobian Computation\n');
fprintf('----------------------------------------\n');

[J, J_linear] = compute_jacobian(q_test, robot);
fprintf('Jacobian size: %dx%d\n', size(J, 1), size(J, 2));
fprintf('Linear Jacobian size: %dx%d\n', size(J_linear, 1), size(J_linear, 2));

% Compute manipulability
manip = sqrt(det(J * J'));
fprintf('Manipulability index: %.4f\n', manip);

% Condition number
cond_num = cond(J);
fprintf('Condition number: %.2f\n', cond_num);

if cond_num < 100
    fprintf('✓ Configuration is far from singularity\n');
else
    fprintf('⚠ Configuration is near singularity\n');
end
fprintf('\n');

%% Test 5: Robot Placement
fprintf('Test 5: Robot Placement and Via-Points\n');
fprintf('----------------------------------------\n');

[placement, via_points] = robot_placement(robot);
fprintf('Robot base: [%.2f, %.2f, %.2f] m\n', ...
        placement.base_x, placement.base_y, placement.base_z);
fprintf('Number of via-points: %d\n', placement.n_via_points);
fprintf('Total trajectory time: %.2f s\n', placement.total_time);

% Check reachability of via-points
min_dist = inf;
max_dist = 0;
for i = 1:size(via_points, 2)
    dist = norm(via_points(:, i) - [placement.base_x; placement.base_y; placement.base_z]);
    min_dist = min(min_dist, dist);
    max_dist = max(max_dist, dist);
end

fprintf('Via-points distance range: [%.3f, %.3f] m\n', min_dist, max_dist);
if max_dist <= robot.specs.reach
    fprintf('✓ All via-points within reach\n');
else
    fprintf('✗ Some via-points outside reach!\n');
end
fprintf('\n');

%% Test 6: Trajectory Planning (simplified)
fprintf('Test 6: Trajectory Planning (Quick Test)\n');
fprintf('----------------------------------------\n');

% Use only a subset of via-points for quick testing
placement_test = placement;
n_test = min(20, placement.n_via_points);
indices = round(linspace(1, placement.n_via_points, n_test));
placement_test.via_points_world = placement.via_points_world(:, indices);
placement_test.time_vector = linspace(0, placement.total_time, n_test);
placement_test.n_via_points = n_test;

fprintf('Testing with %d via-points (subset)...\n', n_test);
trajectory_test = trajectory_planning(placement_test, robot);

fprintf('Maximum joint velocities:\n');
for i = 1:6
    fprintf('  Joint %d: %.2f deg/s\n', i, rad2deg(trajectory_test.max_velocity(i)));
end

if ~trajectory_test.violations.velocity
    fprintf('✓ All velocity constraints satisfied\n');
else
    fprintf('⚠ Velocity constraints violated\n');
end
fprintf('\n');

%% Test 7: Singularity Detection
fprintf('Test 7: Singularity Detection\n');
fprintf('----------------------------------------\n');

% Test known singular configuration (wrist singularity: theta5 = 0)
q_singular = [0; -pi/4; pi/4; 0; 0; 0];  % theta5 = 0
J_sing = compute_jacobian(q_singular, robot);
cond_sing = cond(J_sing);

fprintf('Singular configuration: theta5 = 0\n');
fprintf('Condition number: %.2f\n', cond_sing);

if cond_sing > 100
    fprintf('✓ Singularity correctly detected (high condition number)\n');
else
    fprintf('⚠ Singularity not detected clearly\n');
end
fprintf('\n');

%% Summary
fprintf('========================================\n');
fprintf('  Testing Summary\n');
fprintf('========================================\n\n');

fprintf('All basic component tests completed.\n');
fprintf('Review the output above for any warnings or failures.\n\n');

fprintf('To run the full simulation, execute:\n');
fprintf('  >> main_simulation\n\n');

