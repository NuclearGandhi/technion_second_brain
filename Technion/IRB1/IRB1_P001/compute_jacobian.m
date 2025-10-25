function [J, J_linear] = compute_jacobian(q, robot)
% COMPUTE_JACOBIAN - Compute the Jacobian matrix for UR5e robot
%
% Inputs:
%   q - Joint angles [6x1] vector in radians
%   robot - Robot parameters structure
%
% Outputs:
%   J - Full 6x6 Jacobian matrix [linear_velocity; angular_velocity]
%   J_linear - Upper 3x6 Jacobian for linear velocity only
%
% Jacobian maps joint velocities to end-effector velocity:
%   v = J * q_dot
% where v = [linear_velocity; angular_velocity]

    if nargin < 2
        robot = ur5_dh_parameters();
    end
    
    % Get forward kinematics for all joints
    [~, T_all] = forward_kinematics(q, robot);
    
    % End-effector position
    p_e = T_all{end}(1:3, 4);
    
    % Initialize Jacobian
    J = zeros(6, 6);
    
    % Base frame (identity)
    T0 = eye(4);
    z0 = [0; 0; 1];  % z-axis of base frame
    p0 = [0; 0; 0];  % origin of base frame
    
    % Compute each column of Jacobian
    for i = 1:robot.n
        if i == 1
            % First joint
            z_i = z0;
            p_i = p0;
        else
            % Extract z-axis and position from previous transformation
            T_prev = T_all{i-1};
            z_i = T_prev(1:3, 3);  % z-axis (3rd column of rotation matrix)
            p_i = T_prev(1:3, 4);  % position
        end
        
        % All UR5 joints are revolute
        % Linear velocity component: z_i × (p_e - p_i)
        J(1:3, i) = cross(z_i, p_e - p_i);
        
        % Angular velocity component: z_i
        J(4:6, i) = z_i;
    end
    
    % Extract linear velocity Jacobian (upper half)
    J_linear = J(1:3, :);
end

function det_J = jacobian_determinant(q, robot)
% JACOBIAN_DETERMINANT - Compute determinant of Jacobian (for singularity detection)
%
% For singularity analysis, we typically look at det(J * J^T) for
% rectangular Jacobians, or det(J) for square Jacobians

    J = compute_jacobian(q, robot);
    
    % For square Jacobian
    det_J = det(J);
end

function manipulability = compute_manipulability(q, robot)
% COMPUTE_MANIPULABILITY - Compute Yoshikawa's manipulability index
%
% Manipulability index: w = sqrt(det(J * J^T))
% Higher values indicate better manipulability (far from singularities)

    J = compute_jacobian(q, robot);
    
    % Yoshikawa manipulability measure
    manipulability = sqrt(det(J * J'));
end

function [is_singular, condition_num] = check_singularity(q, robot, threshold)
% CHECK_SINGULARITY - Check if configuration is near singularity
%
% Inputs:
%   q - Joint configuration
%   robot - Robot parameters
%   threshold - Singularity threshold for condition number (default: 100)
%
% Outputs:
%   is_singular - Boolean indicating if near singularity
%   condition_num - Condition number of Jacobian

    if nargin < 3
        threshold = 100;
    end
    
    J = compute_jacobian(q, robot);
    
    % Compute condition number
    condition_num = cond(J);
    
    % Check if near singularity
    is_singular = condition_num > threshold;
end

