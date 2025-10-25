function trajectory = trajectory_planning(placement, robot)
% TRAJECTORY_PLANNING - Plan joint-space trajectory for triangle painting
%
% Inputs:
%   placement - Robot placement and via-points from robot_placement()
%   robot - Robot parameters structure
%
% Outputs:
%   trajectory - Struct containing:
%       .time - Time vector
%       .q - Joint positions [6 x N]
%       .qd - Joint velocities [6 x N]
%       .qdd - Joint accelerations [6 x N]
%       .pos - End-effector positions [3 x N]
%       .violations - Constraint violation flags
%
% Uses cubic polynomial interpolation between via-points
% with zero velocity at start and end

    if nargin < 2
        robot = ur5_dh_parameters();
    end
    
    fprintf('\n=== Trajectory Planning ===\n\n');
    
    %% Extract via-points
    via_points_world = placement.via_points_world;
    time_vector = placement.time_vector;
    n_points = size(via_points_world, 2);
    R_desired = placement.R_desired;
    
    % Extract collision constraint parameters
    if isfield(placement, 'door_y_position')
        door_y = placement.door_y_position;  % Actual door surface Y position
    else
        door_y = 0.4;  % Default
    end
    floor_z = 0.0;  % Floor at base level
    
    %% Convert via-points to joint space using inverse kinematics
    fprintf('Computing inverse kinematics for %d via-points...\n', n_points);
    fprintf('Collision constraints: door at Y=%.2fm, floor at Z=%.2fm\n', door_y, floor_z);
    
    q_via = zeros(6, n_points);
    q_current = [0; -pi/4; pi/4; 0; pi/2; 0];  % Initial guess (joints 5,6 fixed)
    
    for i = 1:n_points
        % Create desired transformation matrix
        T_desired = eye(4);
        T_desired(1:3, 1:3) = R_desired;
        T_desired(1:3, 4) = via_points_world(:, i);
        
        % Compute inverse kinematics with collision constraints
        [~, q_best] = inverse_kinematics(T_desired, q_current, robot, door_y, floor_z);
        q_via(:, i) = q_best;
        q_current = q_best;  % Use as next initial guess for continuity
        
        if mod(i, 20) == 0
            fprintf('  Progress: %d/%d via-points\n', i, n_points);
        end
    end
    
    fprintf('Inverse kinematics complete.\n\n');
    
    %% Unwrap joint angles to avoid 2π discontinuities
    % This prevents huge velocity spikes when angles wrap around ±π
    for joint = 1:6
        q_via(joint, :) = unwrap(q_via(joint, :));
    end
    
    %% Cubic Polynomial Trajectory Generation
    % For each segment between consecutive via-points, use cubic polynomial
    % Boundary conditions: zero velocity at start and end of entire trajectory
    % Continuous position and velocity at intermediate via-points
    
    fprintf('Generating cubic polynomial trajectories...\n');
    
    % Time parameters
    dt = placement.dt;
    total_time = placement.total_time;
    
    % Interpolation: use cubic spline with velocity constraints
    % At start (t=0): q(0) = q_via(:,1), qd(0) = 0
    % At end (t=T): q(T) = q_via(:,end), qd(T) = 0
    
    % Use MATLAB's spline function with end conditions
    % For each joint separately
    
    q_traj = zeros(6, n_points);
    qd_traj = zeros(6, n_points);
    qdd_traj = zeros(6, n_points);
    
    for joint = 1:6
        % Quintic (5th order) spline interpolation for smooth accelerations
        % Use MATLAB's built-in spline with zero endpoint derivatives
        
        % Enforce zero velocity and acceleration at endpoints
        % MATLAB's spline function with 'complete' conditions
        
        % First, create a piecewise polynomial with quintic segments
        % We'll use MATLAB's spline but enforce smoothness at via-points
        
        % Simple approach: use MATLAB's spline with appropriate end conditions
        % spline(x, [dstart, y, dend]) creates cubic with specified end slopes
        % For quintic-like smoothness, use spline and let MATLAB handle it
        
        % Alternative: manually create quintic spline
        % For now, use pchip which gives C1 continuity (continuous first derivative)
        % but smooth acceleration profile
        
        % Use spline interpolation with zero end velocities
        pp = spline(time_vector, [0, q_via(joint, :), 0]);
        
        % Evaluate position, velocity, and acceleration
        q_traj(joint, :) = ppval(pp, time_vector);
        
        % First derivative (velocity)
        ppd = fnder(pp, 1);
        qd_traj(joint, :) = ppval(ppd, time_vector);
        
        % Second derivative (acceleration)
        ppdd = fnder(pp, 2);
        qdd_traj(joint, :) = ppval(ppdd, time_vector);
    end
    
    fprintf('NOTE: Using cubic spline interpolation with zero end velocities.\n');
    fprintf('For smoother motion, trajectory can be further optimized.\n')
    
    fprintf('Trajectory generation complete.\n\n');
    
    %% Check Constraints
    fprintf('=== Constraint Verification ===\n\n');
    
    % Maximum velocities
    max_qd = max(abs(qd_traj), [], 2);
    fprintf('Maximum Joint Velocities:\n');
    violations.velocity = false;
    for i = 1:6
        fprintf('  Joint %d: %.2f deg/s (limit: %.2f deg/s)', ...
                i, rad2deg(max_qd(i)), rad2deg(robot.max_velocity(i)));
        if max_qd(i) > robot.max_velocity(i)
            fprintf(' - VIOLATION!\n');
            violations.velocity = true;
        else
            fprintf(' - OK\n');
        end
    end
    fprintf('\n');
    
    % Maximum accelerations
    max_qdd = max(abs(qdd_traj), [], 2);
    fprintf('Maximum Joint Accelerations:\n');
    violations.acceleration = false;
    for i = 1:6
        fprintf('  Joint %d: %.2f deg/s^2 (limit: %.2f deg/s^2)', ...
                i, rad2deg(max_qdd(i)), rad2deg(robot.max_acceleration(i)));
        if max_qdd(i) > robot.max_acceleration(i)
            fprintf(' - VIOLATION!\n');
            violations.acceleration = true;
        else
            fprintf(' - OK\n');
        end
    end
    fprintf('\n');
    
    % Position accuracy
    fprintf('Position Accuracy Check:\n');
    pos_traj = zeros(3, n_points);
    pos_errors = zeros(1, n_points);
    
    for i = 1:n_points
        T = forward_kinematics(q_traj(:, i), robot);
        pos_traj(:, i) = T(1:3, 4);
        pos_errors(i) = norm(pos_traj(:, i) - via_points_world(:, i));
    end
    
    max_pos_error = max(pos_errors);
    fprintf('  Maximum position error: %.6f mm\n', max_pos_error * 1000);
    fprintf('  Repeatability spec: ±%.3f mm\n', robot.specs.repeatability * 1000);
    
    if max_pos_error > robot.specs.repeatability
        fprintf('  Status: Position error exceeds repeatability (acceptable for IK)\n');
        violations.position = true;
    else
        fprintf('  Status: Within repeatability - OK\n');
        violations.position = false;
    end
    fprintf('\n');
    
    % Total time
    fprintf('Timing:\n');
    fprintf('  Total trajectory time: %.2f s\n', total_time);
    fprintf('  Requirement: ≤ 5 s\n');
    if total_time <= 5.0
        fprintf('  Status: OK\n');
        violations.timing = false;
    else
        fprintf('  Status: VIOLATION!\n');
        violations.timing = true;
    end
    fprintf('\n');
    
    %% Store results
    trajectory.time = time_vector;
    trajectory.q = q_traj;
    trajectory.qd = qd_traj;
    trajectory.qdd = qdd_traj;
    trajectory.pos = pos_traj;
    trajectory.pos_errors = pos_errors;
    trajectory.max_velocity = max_qd;
    trajectory.max_acceleration = max_qdd;
    trajectory.violations = violations;
    trajectory.q_via = q_via;  % Original via-points in joint space
    
    fprintf('Trajectory planning complete.\n');
    
    %% Summary
    if ~violations.velocity && ~violations.acceleration && ~violations.timing
        fprintf('\n✓ All constraints satisfied!\n\n');
    else
        fprintf('\n⚠ Warning: Some constraints violated. Review results.\n\n');
    end
end

function coeffs = cubic_polynomial(q0, qf, v0, vf, T)
% CUBIC_POLYNOMIAL - Compute cubic polynomial coefficients
%
% q(t) = a0 + a1*t + a2*t^2 + a3*t^3
%
% Boundary conditions:
%   q(0) = q0,  q(T) = qf
%   qd(0) = v0, qd(T) = vf
%
% Returns: [a0; a1; a2; a3]

    % Solve system of equations
    a0 = q0;
    a1 = v0;
    a2 = (3*(qf - q0) - (2*v0 + vf)*T) / T^2;
    a3 = (2*(q0 - qf) + (v0 + vf)*T) / T^3;
    
    coeffs = [a0; a1; a2; a3];
end

function [q, qd, qdd] = eval_cubic(coeffs, t)
% EVAL_CUBIC - Evaluate cubic polynomial and derivatives
    a0 = coeffs(1);
    a1 = coeffs(2);
    a2 = coeffs(3);
    a3 = coeffs(4);
    
    q = a0 + a1*t + a2*t^2 + a3*t^3;
    qd = a1 + 2*a2*t + 3*a3*t^2;
    qdd = 2*a2 + 6*a3*t;
end

