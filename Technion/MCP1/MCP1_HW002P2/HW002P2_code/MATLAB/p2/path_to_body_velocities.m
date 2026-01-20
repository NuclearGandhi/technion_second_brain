function [vx, vy, wz, heading] = path_to_body_velocities(x, y, time)
    %PATH_TO_BODY_VELOCITIES Convert path coordinates to body-frame velocities
    %
    %   [vx, vy, wz, heading] = path_to_body_velocities(x, y, time)
    %
    %   For path-following, the robot moves FORWARD along the path and ROTATES
    %   to match the path heading. This outputs body-frame velocities:
    %
    %   OUTPUTS:
    %       vx      - Forward velocity [m/s] (always positive = moving along path)
    %       vy      - Sideways velocity [m/s] (always 0 for path following)
    %       wz      - Angular velocity [rad/s] (rate of heading change)
    %       heading - Path heading at each point [rad]
    %
    %   COORDINATE SYSTEM (matches firmware):
    %       +vx = move forward (front of cart)
    %       +vy = move left
    %       +wz = rotate counter-clockwise (CCW)
    %
    %   MOTOR INDEX MAPPING (firmware):
    %       Motor 0 = Rear Right  (RR)
    %       Motor 1 = Rear Left   (RL)
    %       Motor 2 = Front Left  (FL)
    %       Motor 3 = Front Right (FR)

    % Ensure row vectors
    x = x(:)';
    y = y(:)';
    time = time(:)';

    n = length(x);

    % Compute path tangent direction (dx/dt, dy/dt)
    dx = gradient(x, time);
    dy = gradient(y, time);

    % Speed = magnitude of velocity (this is forward velocity in body frame)
    speed = sqrt(dx .^ 2 + dy .^ 2);
    speed(speed < 1e-6) = 1e-6; % Avoid division by zero

    % Path heading (direction of travel)
    heading = atan2(dy, dx);
    heading = unwrap(heading); % Remove discontinuities

    % Angular velocity = rate of heading change
    dt = gradient(time);
    dt(dt < 1e-6) = 1e-6; % Avoid division by zero
    wz = gradient(heading, time);

    % Body-frame velocities for path following:
    % - vx = speed (robot moves forward along path)
    % - vy = 0 (no sideways motion during path following)
    vx = speed;
    vy = zeros(size(vx));

    % Ensure row vectors
    vx = vx(:)';
    vy = vy(:)';
    wz = wz(:)';
    heading = heading(:)';

    % Debug info
    fprintf('path_to_body_velocities:\n');
    fprintf('  Points: %d\n', n);
    fprintf('  Duration: %.2f s\n', time(end) - time(1));
    fprintf('  Speed range: [%.3f, %.3f] m/s\n', min(vx), max(vx));
    fprintf('  wz range: [%.3f, %.3f] rad/s\n', min(wz), max(wz));
    fprintf('  Total heading change: %.1f deg\n', (heading(end) - heading(1)) * 180 / pi);
end
