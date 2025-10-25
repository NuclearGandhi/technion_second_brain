function torques = torque_calculation(trajectory, robot)
% TORQUE_CALCULATION - Calculate joint torques for trajectory
%
% Inputs:
%   trajectory - Trajectory structure from trajectory_planning()
%   robot - Robot parameters structure
%
% Outputs:
%   torques - Struct containing:
%       .tau - Joint torques [6 x N] (N-m)
%       .tau_max - Maximum torque per joint [6 x 1]
%       .tau_gravity - Gravity torques [6 x N]
%
% Uses static torque analysis (neglecting dynamic forces as specified)

    if nargin < 2
        robot = ur5_dh_parameters();
    end
    
    fprintf('\n=== Torque Calculation ===\n\n');
    
    n_points = length(trajectory.time);
    tau = zeros(6, n_points);
    
    % Gravity vector
    g = robot.gravity;
    
    fprintf('Computing static torques for %d configurations...\n', n_points);
    
    % For each configuration, compute static torques
    for idx = 1:n_points
        q = trajectory.q(:, idx);
        
        % Get transformation matrices for all joints
        [~, T_all] = forward_kinematics(q, robot);
        
        % Compute torque for each joint using static equilibrium
        % tau_i = sum of (force × moment_arm) for all links j >= i
        
        for i = 1:6
            tau_i = 0;
            
            % Get position and orientation of joint i
            if i == 1
                p_i = [0; 0; 0];
                z_i = [0; 0; 1];
            else
                p_i = T_all{i-1}(1:3, 4);
                z_i = T_all{i-1}(1:3, 3);
            end
            
            % Add contribution from all downstream links (j >= i)
            for j = i:6
                % Center of mass of link j
                if j == 6
                    % Last link - CoM at joint position
                    p_j = T_all{j}(1:3, 4);
                else
                    % CoM at midpoint between joints j and j+1
                    p_j_start = T_all{j}(1:3, 4);
                    if j < 6
                        p_j_end = T_all{j+1}(1:3, 4);
                    else
                        p_j_end = T_all{j}(1:3, 4);
                    end
                    p_j = (p_j_start + p_j_end) / 2;
                end
                
                % Gravitational force on link j
                F_g_j = robot.link_mass(j) * g;
                
                % Moment arm from joint i to CoM of link j
                r_ij = p_j - p_i;
                
                % Torque contribution (projection onto joint axis)
                tau_contrib = z_i' * cross(r_ij, F_g_j);
                tau_i = tau_i + tau_contrib;
            end
            
            % Add payload (paint sprayer) at end-effector
            if i <= 6
                p_ee = T_all{6}(1:3, 4);
                F_payload = robot.payload_mass * g;
                r_i_ee = p_ee - p_i;
                tau_payload = z_i' * cross(r_i_ee, F_payload);
                tau_i = tau_i + tau_payload;
            end
            
            tau(i, idx) = tau_i;
        end
        
        if mod(idx, 50) == 0
            fprintf('  Progress: %d/%d configurations\n', idx, n_points);
        end
    end
    
    fprintf('Torque calculation complete.\n\n');
    
    %% Analyze results
    tau_max = max(abs(tau), [], 2);
    tau_min = min(tau, [], 2);
    tau_max_val = max(tau, [], 2);
    
    fprintf('=== Torque Analysis ===\n\n');
    fprintf('Maximum Joint Torques:\n');
    for i = 1:6
        fprintf('  Joint %d: %.2f N-m (range: %.2f to %.2f N-m)\n', ...
                i, tau_max(i), tau_min(i), tau_max_val(i));
    end
    fprintf('\n');
    
    % UR5e torque limits (approximate from specifications)
    % These are typical values - adjust based on actual specs
    torque_limits = [150; 150; 150; 28; 28; 28];  % N-m
    
    fprintf('Torque Limit Comparison:\n');
    for i = 1:6
        fprintf('  Joint %d: %.2f / %.2f N-m (%.1f%% of limit)', ...
                i, tau_max(i), torque_limits(i), 100*tau_max(i)/torque_limits(i));
        if tau_max(i) > torque_limits(i)
            fprintf(' - EXCEEDS LIMIT!\n');
        else
            fprintf(' - OK\n');
        end
    end
    fprintf('\n');
    
    %% Store results
    torques.tau = tau;
    torques.tau_max = tau_max;
    torques.tau_min = tau_min;
    torques.tau_max_val = tau_max_val;
    torques.torque_limits = torque_limits;
    torques.time = trajectory.time;
    
    fprintf('Torque analysis complete.\n');
end

function tau = compute_static_torque_recursive(q, robot)
% COMPUTE_STATIC_TORQUE_RECURSIVE - Alternative recursive formulation
%
% Uses recursive Newton-Euler for static case (zero velocities/accelerations)

    n = robot.n;
    tau = zeros(n, 1);
    
    % Forward kinematics
    [~, T_all] = forward_kinematics(q, robot);
    
    % Initialize forces and moments
    f = zeros(3, n+1);  % Forces
    n_vec = zeros(3, n+1);  % Moments
    
    % End-effector force (payload)
    f(:, n+1) = robot.payload_mass * robot.gravity;
    n_vec(:, n+1) = zeros(3, 1);
    
    % Backward recursion (from tip to base)
    for i = n:-1:1
        % Transformation matrix
        T_i = T_all{i};
        R_i = T_i(1:3, 1:3);
        p_i = T_i(1:3, 4);
        
        % Link properties
        m_i = robot.link_mass(i);
        
        % Center of mass position (approximate)
        if i < n
            p_next = T_all{i+1}(1:3, 4);
            p_com_i = (p_i + p_next) / 2;
        else
            p_com_i = p_i;
        end
        
        % Gravitational force on link i
        f_grav_i = m_i * robot.gravity;
        
        % Force balance
        if i < n
            R_next = T_all{i+1}(1:3, 1:3);
            f(:, i) = R_next' * f(:, i+1) + f_grav_i;
        else
            f(:, i) = f(:, i+1) + f_grav_i;
        end
        
        % Moment balance
        r_com = p_com_i - p_i;
        if i < n
            p_next = T_all{i+1}(1:3, 4);
            r_next = p_next - p_i;
            n_vec(:, i) = R_next' * n_vec(:, i+1) + cross(r_com, f_grav_i) + cross(r_next, R_next' * f(:, i+1));
        else
            n_vec(:, i) = cross(r_com, f_grav_i);
        end
        
        % Joint torque (projection onto joint axis)
        if i == 1
            z_i = [0; 0; 1];
        else
            z_i = T_all{i-1}(1:3, 3);
        end
        
        tau(i) = z_i' * n_vec(:, i);
    end
end

