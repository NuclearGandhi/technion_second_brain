function [T, T_all] = forward_kinematics(q, robot)
% FORWARD_KINEMATICS - Compute forward kinematics for UR5e robot
%
% Inputs:
%   q - Joint angles [6x1] vector in radians
%   robot - Robot parameters structure from ur5_dh_parameters()
%
% Outputs:
%   T - Homogeneous transformation matrix [4x4] from base to end-effector
%   T_all - Cell array of transformation matrices for each joint
%
% Uses standard DH convention

    if nargin < 2
        robot = ur5_dh_parameters();
    end
    
    % Initialize
    T = eye(4);
    T_all = cell(robot.n, 1);
    
    % Compute transformation for each joint
    for i = 1:robot.n
        % Get DH parameters for joint i
        theta = q(i) + robot.DH(i, 1);  % Joint angle + offset
        d = robot.DH(i, 2);
        a = robot.DH(i, 3);
        alpha = robot.DH(i, 4);
        
        % Standard DH transformation matrix
        % T = Rz(theta) * Tz(d) * Tx(a) * Rx(alpha)
        ct = cos(theta);
        st = sin(theta);
        ca = cos(alpha);
        sa = sin(alpha);
        
        Ti = [
            ct,    -st*ca,   st*sa,   a*ct;
            st,     ct*ca,  -ct*sa,   a*st;
            0,      sa,      ca,      d;
            0,      0,       0,       1
        ];
        
        % Accumulate transformation
        T = T * Ti;
        T_all{i} = T;
    end
    
end

function pos = get_position(T)
% GET_POSITION - Extract position from transformation matrix
    pos = T(1:3, 4);
end

function R = get_rotation(T)
% GET_ROTATION - Extract rotation matrix from transformation matrix
    R = T(1:3, 1:3);
end

function rpy = rotation_to_rpy(R)
% ROTATION_TO_RPY - Convert rotation matrix to roll-pitch-yaw angles
%   Returns [roll; pitch; yaw] in radians
    
    % Extract roll, pitch, yaw (ZYX Euler angles)
    pitch = atan2(-R(3,1), sqrt(R(1,1)^2 + R(2,1)^2));
    
    if abs(cos(pitch)) > 1e-6
        roll = atan2(R(3,2), R(3,3));
        yaw = atan2(R(2,1), R(1,1));
    else
        % Gimbal lock case
        roll = 0;
        yaw = atan2(-R(1,2), R(2,2));
    end
    
    rpy = [roll; pitch; yaw];
end

