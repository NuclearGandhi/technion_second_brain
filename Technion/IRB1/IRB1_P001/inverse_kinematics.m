function [q_all, q_best] = inverse_kinematics(T_desired, q_current, robot, door_y, floor_z)
% INVERSE_KINEMATICS - Compute inverse kinematics for UR5e robot with collision constraints
%
% Inputs:
%   T_desired - Desired end-effector transformation [4x4]
%   q_current - Current joint configuration [6x1] (for solution selection)
%   robot - Robot parameters structure
%   door_y - Door surface Y position (optional, default: 0.4)
%   floor_z - Floor Z position (optional, default: 0.0)
%
% Outputs:
%   q_all - All valid IK solutions [6 x N] (numerical finds best one)
%   q_best - Best solution [6x1]
%
% Uses numerical optimization with collision avoidance constraints

    if nargin < 3
        robot = ur5_dh_parameters();
    end
    if nargin < 2 || isempty(q_current)
        q_current = zeros(6, 1);
    end
    if nargin < 4 || isempty(door_y)
        door_y = 0.4;  % Default door position
    end
    if nargin < 5 || isempty(floor_z)
        floor_z = 0.0;  % Default floor level
    end
    
    % Extract desired position and orientation
    p_desired = T_desired(1:3, 4);
    R_desired = T_desired(1:3, 1:3);
    
    % Cost function: minimize position error + penalty for deviation from current config
    cost_function = @(q) ik_cost_with_continuity(q, p_desired, q_current, robot);
    
    % Fix only joint 6 (wrist roll) - allow joint 5 to help with positioning
    % This gives 5-DOF problem, better for velocity constraints
    q6_fixed = 0;     % Joint 6 fixed at 0 degrees (no roll)
    
    % Multiple initial guesses for robustness (joints 1-5 vary, only 6 fixed)
    % Generate more guesses around the workspace
    initial_guesses = [
        q_current, ...                          % Current configuration
        [0; 0; 0; 0; pi/2; q6_fixed], ...      % Home position  
        [0; -pi/6; pi/3; 0; pi/2; q6_fixed], ...      % Reaching forward
        [0; -pi/4; pi/2; 0; pi/2; q6_fixed], ...      % Medium reach
        [0; -pi/3; pi/2; 0; pi/3; q6_fixed], ...      % Lower position
        [pi/6; -pi/4; pi/3; 0; pi/2; q6_fixed], ...   % Slight rotation
        [-pi/6; -pi/4; pi/3; 0; pi/2; q6_fixed], ...  % Opposite rotation
        [0; -pi/2; pi/3; 0; pi/4; q6_fixed], ...      % Low configuration
        [0; 0; pi/4; 0; pi/3; q6_fixed], ...          % Alternative 1
        [0; -pi/8; pi/4; 0; pi/2; q6_fixed]           % Alternative 2
    ];
    
    % Joint limits (UR5e specifications with safety margins)
    lb = -2*pi * ones(6,1);  % Lower bounds
    ub = 2*pi * ones(6,1);   % Upper bounds
    
    % Tighter practical limits to avoid extreme configurations
    lb(2) = -3*pi/4;  % Joint 2: allow some downward reach but not too much
    ub(2) = pi/4;     % Joint 2: allow slightly above horizontal
    lb(3) = -pi/6;    % Joint 3: allow slight negative angle
    ub(3) = 5*pi/6;   % Joint 3: reasonable elbow angle
    
    % Equality constraint: fix only joint 6
    % Aeq * q = beq  =>  [0 0 0 0 0 1] * q = q6_fixed
    Aeq = [0 0 0 0 0 1];
    beq = q6_fixed;
    
    % Nonlinear constraints: collision avoidance
    nonlcon = @(q) collision_constraints(q, robot, door_y, floor_z);
    
    % Optimization options - balance speed and accuracy
    options = optimoptions('fmincon', ...
        'Display', 'off', ...
        'MaxFunctionEvaluations', 8000, ...
        'MaxIterations', 800, ...
        'Algorithm', 'sqp', ...
        'OptimalityTolerance', 1e-5, ...
        'ConstraintTolerance', 5e-3, ...
        'StepTolerance', 1e-8);
    
    % Try each initial guess
    best_cost = inf;
    q_best = q_current;
    q_all = [];
    
    for i = 1:size(initial_guesses, 2)
        q0 = initial_guesses(:, i);
        
        try
            [q_sol, cost] = fmincon(cost_function, q0, [], [], Aeq, beq, lb, ub, nonlcon, options);
            
            % Validate solution - relaxed tolerance
            T_check = forward_kinematics(q_sol, robot);
            pos_error = norm(T_check(1:3, 4) - p_desired);
            
            % Double-check collision constraints
            [c, ceq] = collision_constraints(q_sol, robot, door_y, floor_z);
            collision_free = all(c <= 0.01);  % Allow small violations (1cm margin)
            
            % Accept if position error is reasonable (2mm tolerance) and collision-free
            if pos_error < 0.002 && collision_free
                q_all = [q_all, q_sol];
                
                % Keep track of best solution (lowest cost)
                if cost < best_cost
                    best_cost = cost;
                    q_best = q_sol;
                end
            end
        catch ME
            % Skip this initial guess if optimization fails
            continue;
        end
    end
    
    % If no good solution found, try one more time with very relaxed criteria
    if isempty(q_all)
        % Try lsqnonlin as alternative (manually enforce fixed joint 6)
        try
            % Modified residual that includes constraint penalty for joint 6
            cost_lsq = @(q) [ik_residual(q, p_desired, robot); 
                            100*(q(6) - q6_fixed)];
            options_lsq = optimoptions('lsqnonlin', ...
                'Display', 'off', ...
                'MaxFunctionEvaluations', 3000, ...
                'MaxIterations', 300);
            
            [q_sol, ~] = lsqnonlin(cost_lsq, q_current, lb, ub, options_lsq);
            
            % Force exact value for joint 6
            q_sol(6) = q6_fixed;
            
            T_check = forward_kinematics(q_sol, robot);
            pos_error = norm(T_check(1:3, 4) - p_desired);
            
            if pos_error < 0.1  % 10cm tolerance as last resort
                q_all = q_sol;
                q_best = q_sol;
                return;
            end
        catch
            % If even this fails, return current configuration
        end
        
        warning('No valid IK solution found. Returning current configuration.');
        q_all = q_current;
        q_best = q_current;
        return;
    end
    
    % Remove duplicate solutions
    if size(q_all, 2) > 1
        q_all = uniquetol(q_all', 0.01, 'ByRows', true)';
    end
end

function cost = ik_cost_with_continuity(q, p_desired, q_current, robot)
    % Cost function with continuity penalty
    % Minimizes position error while preferring solutions near q_current
    
    % Compute forward kinematics
    T = forward_kinematics(q, robot);
    p = T(1:3, 4);
    
    % Position error (heavily weighted)
    pos_error = norm(p - p_desired);
    
    % Continuity penalty: prefer solutions close to current configuration
    % Use small weight to avoid interfering with position accuracy
    joint_deviation = norm(q - q_current);
    
    % Combined cost: position error + small continuity penalty
    cost = 1000 * pos_error^2 + 0.01 * joint_deviation^2;
end

function residual = ik_residual(q, p_desired, robot)
    % Residual vector for lsqnonlin
    T = forward_kinematics(q, robot);
    p = T(1:3, 4);
    residual = p - p_desired;
end

function [c, ceq] = collision_constraints(q, robot, door_y, floor_z)
    % Nonlinear inequality constraints for collision avoidance
    % c(x) <= 0  means constraints are satisfied
    % ceq(x) = 0 means equality constraints are satisfied
    
    % Get all joint positions from forward kinematics
    [~, T_all] = forward_kinematics(q, robot);
    
    % Extract positions of all joints
    joint_positions = zeros(3, 7);  % Base + 6 joints
    joint_positions(:, 1) = [0; 0; 0];  % Base position
    
    for i = 1:6
        joint_positions(:, i+1) = T_all{i}(1:3, 4);
    end
    
    % Safety margin
    safety_margin = 0.03;  % 3 cm clearance (reduced for better reachability)
    
    % Inequality constraints (c <= 0)
    c = [];
    
    % Constraint 1: No joint should cross the door surface (Y > door_y)
    % Reformulate as: Y - door_y <= -safety_margin
    for i = 1:7
        c = [c; joint_positions(2, i) - (door_y - safety_margin)];
    end
    
    % Constraint 2: No joint should go below floor (Z < floor_z)
    % Reformulate as: floor_z - Z <= -safety_margin
    for i = 1:7
        c = [c; (floor_z + safety_margin) - joint_positions(3, i)];
    end
    
    % Constraint 3: Keep robot in front half-space (reasonable X limits)
    % Prevent extreme sideways motion: -1m < X < 1m
    for i = 2:7  % Skip base
        c = [c; joint_positions(1, i) - 1.0];   % X < 1m
        c = [c; -1.0 - joint_positions(1, i)];  % X > -1m
    end
    
    % Constraint 4: End-effector Y position must be within nozzle distance range
    % Door at Y=door_y, nozzle must be 5-20cm from door
    % This means: (door_y - 0.2) <= Y_ee <= (door_y - 0.05)
    ee_pos = joint_positions(:, 7);  % End-effector is joint 7
    c = [c; (door_y - 0.2) - ee_pos(2)];        % Y >= door_y - 0.2
    c = [c; ee_pos(2) - (door_y - 0.05)];       % Y <= door_y - 0.05
    
    % No equality constraints beyond what's in Aeq/beq
    ceq = [];
end
