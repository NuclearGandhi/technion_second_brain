function robot = ur5_dh_parameters()
% UR5_DH_PARAMETERS - Define UR5e robot parameters using standard DH convention
%
% Returns:
%   robot - struct containing DH parameters and physical properties
%
% DH Convention: Standard (Craig)
% Transformation: T = Rz(theta) * Tz(d) * Tx(a) * Rx(alpha)

    % UR5e link lengths (in meters, from technical specifications)
    robot.d1 = 0.1625;  % Base height
    robot.a2 = 0.425;   % Upper arm length
    robot.a3 = 0.3922;  % Forearm length
    robot.d4 = 0.1333;  % Wrist 1 to wrist 2
    robot.d5 = 0.0997;  % Wrist 2 to wrist 3
    robot.d6 = 0.0996;  % Wrist 3 to flange
    
    % DH Parameters Table [theta, d, a, alpha]
    % theta: joint angle (variable)
    % d: link offset along z-axis
    % a: link length along x-axis
    % alpha: link twist about x-axis
    
    %     theta    d          a          alpha
    robot.DH = [
        0,       robot.d1,  0,         pi/2;     % Joint 1
        0,       0,         robot.a2,  0;        % Joint 2
        0,       0,         robot.a3,  0;        % Joint 3
        0,       robot.d4,  0,         pi/2;     % Joint 4
        0,       robot.d5,  0,        -pi/2;     % Joint 5
        0,       robot.d6,  0,         0         % Joint 6
    ];
    
    % Array versions for convenience
    robot.a = [0, robot.a2, robot.a3, 0, 0, 0];
    robot.d = [robot.d1, 0, 0, robot.d4, robot.d5, robot.d6];
    robot.alpha = [pi/2, 0, 0, pi/2, -pi/2, 0];
    
    % Joint limits (from UR5e specifications, in radians)
    robot.joint_limits = [
        -2*pi,  2*pi;   % Joint 1: ±360°
        -2*pi,  2*pi;   % Joint 2: ±360°
        -2*pi,  2*pi;   % Joint 3: ±360°
        -2*pi,  2*pi;   % Joint 4: ±360°
        -2*pi,  2*pi;   % Joint 5: ±360°
        -2*pi,  2*pi    % Joint 6: ±360°
    ];
    
    % Maximum joint velocities (rad/s)
    robot.max_velocity = deg2rad(180) * ones(6,1);  % 180 deg/s for all joints
    
    % Maximum joint accelerations (rad/s^2) - typical values
    robot.max_acceleration = deg2rad(300) * ones(6,1);
    
    % Link masses (kg) - assumption: each link weighs 7 kg
    robot.link_mass = 7 * ones(6,1);
    
    % End-effector payload
    robot.payload_mass = 0.6;  % Paint sprayer mass in kg
    
    % Center of mass positions (fraction along link length)
    % Assumption: CoM at midpoint of line connecting neighboring joints
    robot.com_position = 0.5 * ones(6,1);
    
    % Gravity vector
    robot.gravity = [0; 0; -9.81];  % m/s^2
    
    % Base position (as specified: origin)
    robot.base_position = [0; 0; 0];
    
    % Robot specifications from datasheet
    robot.specs.reach = 0.850;              % Maximum reach in meters
    robot.specs.repeatability = 0.03e-3;    % ±0.03 mm
    robot.specs.payload = 5;                % Maximum payload in kg
    robot.specs.weight = 20.6;              % Total robot weight in kg
    
    % Number of joints
    robot.n = 6;
    
    fprintf('UR5e robot parameters initialized.\n');
    fprintf('Base position: [%.3f, %.3f, %.3f] m\n', robot.base_position);
    fprintf('Maximum reach: %.3f m\n', robot.specs.reach);
    fprintf('Repeatability: ±%.3f mm\n', robot.specs.repeatability*1000);
    fprintf('Payload capacity: %.1f kg (current: %.1f kg)\n', ...
            robot.specs.payload, robot.payload_mass);
end

