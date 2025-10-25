%% UR5e Robot Triangle Painting Simulation
% Main script for robotics mini-project
%
% Team Members:
%   - Ido Fang Bentov (322869140)
%   - Nir Karl (322437203)
%   - Ofir Rubin (211544275)
%
% Course: Introduction to Robotics (035001)
% Semester: Spring 2025
%
% Description:
%   This script simulates a UR5e robot painting a triangular shape on
%   doors moving on a conveyor belt. The simulation includes:
%   - Forward and inverse kinematics
%   - Jacobian computation
%   - Singularity analysis
%   - Trajectory planning with cubic polynomials
%   - Static torque calculation
%   - Comprehensive visualization

clear; close all; clc;

fprintf('========================================\n');
fprintf('  UR5e Triangle Painting Simulation\n');
fprintf('========================================\n\n');

%% 1. Initialize Robot Parameters
fprintf('Step 1: Initializing robot parameters...\n');
robot = ur5_dh_parameters();
fprintf('\n');

%% 2. Determine Optimal Robot Placement and Via-Points
fprintf('Step 2: Determining robot placement and via-points...\n');
[placement, via_points] = robot_placement(robot);
fprintf('\n');

%% 3. Perform Singularity Analysis
fprintf('Step 3: Performing singularity analysis...\n');
fprintf('(This may take a few moments...)\n');
singularity_analysis(robot, true);
fprintf('\n');

%% 4. Plan Trajectory
fprintf('Step 4: Planning joint-space trajectory...\n');
trajectory = trajectory_planning(placement, robot);
fprintf('\n');

%% 5. Calculate Joint Torques
fprintf('Step 5: Calculating joint torques...\n');
torques = torque_calculation(trajectory, robot);
fprintf('\n');

%% 6. Generate All Plots
fprintf('Step 6: Generating visualization plots...\n');
generate_plots(trajectory, torques, placement, robot, true);
fprintf('\n');

%% 7. Summary Report
fprintf('========================================\n');
fprintf('          SIMULATION SUMMARY\n');
fprintf('========================================\n\n');

fprintf('Robot Configuration:\n');
fprintf('  Model: UR5e\n');
fprintf('  Base Position: [%.2f, %.2f, %.2f] m\n', ...
        placement.base_x, placement.base_y, placement.base_z);
fprintf('  Payload: %.1f kg (paint sprayer)\n', robot.payload_mass);
fprintf('\n');

fprintf('Task Parameters:\n');
fprintf('  Triangle Side Length: %.2f m\n', 0.4);
fprintf('  Conveyor Velocity: %.2f m/s\n', 0.3);
fprintf('  Nozzle Distance: %.2f m\n', 0.10);
fprintf('  Total Via-Points: %d\n', placement.n_via_points);
fprintf('  Total Time: %.2f s (requirement: ≤ 5 s)\n', placement.total_time);
fprintf('\n');

fprintf('Constraint Verification:\n');

% Velocity constraints
fprintf('  Joint Velocities:\n');
for i = 1:6
    status = '';
    if trajectory.max_velocity(i) <= robot.max_velocity(i)
        status = '✓';
    else
        status = '✗';
    end
    fprintf('    Joint %d: %.1f / %.1f deg/s %s\n', i, ...
            rad2deg(trajectory.max_velocity(i)), ...
            rad2deg(robot.max_velocity(i)), status);
end
fprintf('\n');

% Torque constraints
fprintf('  Joint Torques:\n');
for i = 1:6
    status = '';
    if torques.tau_max(i) <= torques.torque_limits(i)
        status = '✓';
    else
        status = '✗';
    end
    fprintf('    Joint %d: %.2f / %.2f N-m %s\n', i, ...
            torques.tau_max(i), torques.torque_limits(i), status);
end
fprintf('\n');

% Position accuracy
fprintf('  Position Accuracy:\n');
fprintf('    Max Error: %.4f mm\n', max(trajectory.pos_errors) * 1000);
fprintf('    Repeatability: ±%.3f mm\n', robot.specs.repeatability * 1000);
fprintf('\n');

% Overall status
all_satisfied = ~trajectory.violations.velocity && ...
                ~trajectory.violations.acceleration && ...
                ~trajectory.violations.timing;

if all_satisfied
    fprintf('Overall Status: ✓ ALL CONSTRAINTS SATISFIED\n');
else
    fprintf('Overall Status: ⚠ SOME CONSTRAINTS VIOLATED - Review required\n');
end
fprintf('\n');

fprintf('Output Files:\n');
fprintf('  Plots saved in: plots/\n');
fprintf('  Triangle trajectory: triangle_trajectory.png\n');
fprintf('  Singularity analysis: workspace_3d_singularities.png\n');
fprintf('  Joint positions: joint_positions.png\n');
fprintf('  Joint velocities: joint_velocities.png\n');
fprintf('  Joint torques: joint_torques.png\n');
fprintf('  End-effector trajectory: ee_trajectory_3d.png\n');
fprintf('  Robot snapshots: robot_snapshots.png\n');
fprintf('\n');

fprintf('========================================\n');
fprintf('    SIMULATION COMPLETED SUCCESSFULLY\n');
fprintf('========================================\n\n');

%% 8. Save Workspace
save('simulation_results.mat', 'robot', 'placement', ...
     'trajectory', 'torques', 'via_points');
fprintf('Workspace saved to: simulation_results.mat\n\n');

%% 9. Additional Analysis Functions

% Function to display forward kinematics at a specific configuration
function display_fk(q, robot)
    fprintf('\nForward Kinematics for q = [%.2f, %.2f, %.2f, %.2f, %.2f, %.2f]^T rad\n', q);
    T = forward_kinematics(q, robot);
    fprintf('End-effector position: [%.4f, %.4f, %.4f]^T m\n', T(1:3, 4));
    fprintf('End-effector orientation:\n');
    disp(T(1:3, 1:3));
end

% Function to test inverse kinematics
function test_ik(robot)
    fprintf('\n=== Testing Inverse Kinematics ===\n');
    
    % Test configuration
    q_test = [0; -pi/4; pi/4; 0; pi/2; 0];
    fprintf('Original joint angles (rad): [%.3f, %.3f, %.3f, %.3f, %.3f, %.3f]\n', q_test);
    
    % Forward kinematics
    T_desired = forward_kinematics(q_test, robot);
    fprintf('Forward kinematics position: [%.4f, %.4f, %.4f] m\n', T_desired(1:3, 4));
    
    % Inverse kinematics
    [q_all, q_best] = inverse_kinematics(T_desired, q_test, robot);
    fprintf('Number of IK solutions found: %d\n', size(q_all, 2));
    fprintf('Best solution (rad): [%.3f, %.3f, %.3f, %.3f, %.3f, %.3f]\n', q_best);
    
    % Verify
    T_verify = forward_kinematics(q_best, robot);
    error = norm(T_verify(1:3, 4) - T_desired(1:3, 4));
    fprintf('Verification error: %.6f m\n', error);
    
    if error < 1e-3
        fprintf('✓ IK verification passed\n');
    else
        fprintf('✗ IK verification failed\n');
    end
end

% Function to compute manipulability along trajectory
function plot_manipulability(trajectory, robot)
    fprintf('\nComputing manipulability along trajectory...\n');
    
    n = length(trajectory.time);
    manip = zeros(1, n);
    
    for i = 1:n
        J = compute_jacobian(trajectory.q(:,i), robot);
        manip(i) = sqrt(det(J * J'));
    end
    
    figure;
    plot(trajectory.time, manip, 'b-', 'LineWidth', 1.5);
    grid on;
    xlabel('Time (s)');
    ylabel('Manipulability Index');
    title('Yoshikawa Manipulability Index Along Trajectory');
    
    fprintf('Manipulability statistics:\n');
    fprintf('  Mean: %.4f\n', mean(manip));
    fprintf('  Min: %.4f\n', min(manip));
    fprintf('  Max: %.4f\n', max(manip));
    fprintf('  Std: %.4f\n', std(manip));
end

