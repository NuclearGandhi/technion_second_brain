% Frenet-Serret Curvilinear Coordinates for Mecanum-Wheeled Cart
% With Adaptive Sampling, Wheel Kinematics, and Interactive Path Drawing
% This code creates an animation and exports it as a GIF


clear; close all; clc;
global userPoints
global pointHandles
global lineHandles

%% Interactive Path Drawing
fprintf('=== Interactive Path Drawing ===\n');
fprintf('Choose path mode:\n');
fprintf('1. Use default figure-8 path\n');
fprintf('2. Draw custom path with mouse\n');
pathMode = input('Enter choice (1 or 2): ');

userPoints = [];
useCustomPath = false;

if pathMode == 2
    % Create drawing figure
    drawFig = figure('Position', [100, 100, 800, 600], 'Color', 'white', ...
        'Name', 'Draw Your Path (Close window when done)');
    drawAx = axes('Position', [0.1 0.1 0.8 0.8]);
       set(drawAx,'tag','ax')
 hold on; axis equal; grid on;
    xlim([-100 100]); ylim([-100 100]);
    axLimits = axis;
    title('Click to add points (close window when finished)', 'FontSize', 14);
    xlabel('X coordinate', 'FontSize', 12);
    ylabel('Y coordinate', 'FontSize', 12);
    
    % Draw coordinate system
    plot([0 0], [-100 100], 'k--', 'LineWidth', 0.5);
    plot([-100 100], [0 0], 'k--', 'LineWidth', 0.5);
    
    userPoints = [];
    pointHandles = [];
    lineHandles = [];
    
    % Mouse click callback
    set(drawFig, 'WindowButtonDownFcn', @(src, event) addPoint());
    
   
    
    fprintf('Click on the figure to add points...\n');
    fprintf('Close the figure window when you are done.\n');
    
    waitfor(drawFig);
    
    if size(userPoints, 1) >= 2
        useCustomPath = true;
        fprintf('Custom path created with %d points.\n', size(userPoints, 1));
        
        % Convert to pixel coordinates (400, 300 center, scaled)
        userPoints(:,1) = 400 + (userPoints(:,1) / 100) * 300;
        userPoints(:,2) = 300 + (userPoints(:,2) / 100) * 200;
    else
        fprintf('Not enough points. Using default path.\n');
        useCustomPath = false;
    end
end



%% Setup Animation Parameters
if useCustomPath
    numFrames = 200;
    tMax = size(userPoints, 1) - 1;
    tValues = linspace(0, tMax, numFrames);
else
    numFrames = 200;
    tMax = 2*pi;
    tValues = linspace(0, tMax, numFrames);
end

% Adaptive sampling parameters
dsMin = 0.05;
dsMax = 0.3;
kRef = 0.02;

% Cart dimensions
cartWidth = 40;
cartHeight = 30;

% Mecanum wheel kinematics parameters
wheelRadius = 0.05;
L = cartWidth / 800;
W = cartHeight / 800;

% Storage for wheel speed data
wheelSpeedData = zeros(numFrames, 5);


%% Generate Adaptive Sampling Points
adaptivePoints = [];
s = 0;

while s < tMax
    pos = pathFunc(s, useCustomPath, userPoints);
    k = computeCurvature(s, useCustomPath, userPoints);
    
    kNorm = min(k / kRef, 1);
    ds = dsMin + (dsMax - dsMin) * (1 - kNorm);
    
    adaptivePoints = [adaptivePoints; pos(1), pos(2), s, k, ds];
    s = s + ds;
end

%% Create Main Figure
fig = figure('Position', [100, 100, 1000, 700], 'Color', [0.1 0.1 0.15]);
ax = axes('Position', [0.05 0.15 0.9 0.8]);
hold on; axis equal; grid on;
set(ax, 'Color', [0.15 0.18 0.22], 'XColor', [0.4 0.45 0.5], ...
    'YColor', [0.4 0.45 0.5], 'GridColor', [0.3 0.35 0.4]);

% Set axis limits based on path
if useCustomPath
    xMargin = 100;
    yMargin = 100;
    xlim([min(userPoints(:,1)) - xMargin, max(userPoints(:,1)) + xMargin]);
    ylim([min(userPoints(:,2)) - yMargin, max(userPoints(:,2)) + yMargin]);
else
    xlim([200 600]); 
    ylim([100 500]);
end

if useCustomPath
    title('Frenet-Serret Frame - Custom Path with Adaptive Sampling', ...
        'Color', 'white', 'FontSize', 14, 'FontWeight', 'bold');
else
    title('Frenet-Serret Frame - Figure-8 Path with Adaptive Sampling', ...
        'Color', 'white', 'FontSize', 14, 'FontWeight', 'bold');
end

% Plot full path
pathPoints = zeros(200, 2);
for i = 1:200
    t = (i-1) / 199 * tMax;
    pathPoints(i, :) = pathFunc(t, useCustomPath, userPoints);
end
plot(pathPoints(:,1), pathPoints(:,2), '--', 'Color', [0.4 0.45 0.5], 'LineWidth', 2);

% Plot user control points if custom path
if useCustomPath
    % Map back to drawing coordinates for display
    displayPts = [(userPoints(:,1) - 400) / 300 * 100, ...
                  (userPoints(:,2) - 300) / 200 * 100];
    
    for i = 1:size(userPoints, 1)
        plot(userPoints(i,1), userPoints(i,2), 'o', 'MarkerSize', 8, ...
            'MarkerFaceColor', [0.66 0.33 0.96], 'MarkerEdgeColor', 'white', 'LineWidth', 2);
        text(userPoints(i,1)+10, userPoints(i,2)+10, sprintf('%d', i), ...
            'Color', [0.66 0.33 0.96], 'FontSize', 10, 'FontWeight', 'bold');
    end
end

% Plot adaptive sampling points
for i = 1:size(adaptivePoints, 1)
    kNorm = min(adaptivePoints(i, 4) / kRef, 1);
    hue = 120 - kNorm * 120;
    rgb = hsv2rgb([hue/360, 0.8, 0.8]);
    markerSize = 4 + kNorm * 4;
    
    plot(adaptivePoints(i, 1), adaptivePoints(i, 2), 'o', ...
        'MarkerFaceColor', rgb, 'MarkerEdgeColor', 'none', ...
        'MarkerSize', markerSize);
end

% Initialize plot objects
hCart = fill(0, 0, [0.12 0.16 0.23], 'EdgeColor', [0.28 0.33 0.4], 'LineWidth', 2);
hWheels = cell(4,1);
for i = 1:4
    hWheels{i} = fill(0, 0, [0.58 0.64 0.72], 'EdgeColor', [0.28 0.33 0.4]);
end
hTangent = quiver(0, 0, 0, 0, 0, 'r', 'LineWidth', 3, 'MaxHeadSize', 0.5);
hNormal = quiver(0, 0, 0, 0, 0, 'b', 'LineWidth', 3, 'MaxHeadSize', 0.5);
hBinormal = plot(0, 0, 'go', 'MarkerSize', 12, 'LineWidth', 3);
hBinormalCenter = plot(0, 0, 'g.', 'MarkerSize', 20);
hOscCircle = plot(0, 0, 'm--', 'LineWidth', 1.5);
hRadiusLine = plot([0 0], [0 0], 'm:', 'LineWidth', 1.5);
hCenterPoint = plot(0, 0, 'm.', 'MarkerSize', 15);

% Text objects
hTextT = text(0, 0, 'T', 'Color', 'r', 'FontSize', 16, 'FontWeight', 'bold');
hTextN = text(0, 0, 'N', 'Color', 'b', 'FontSize', 16, 'FontWeight', 'bold');
hTextB = text(0, 0, 'B', 'Color', 'g', 'FontSize', 16, 'FontWeight', 'bold');

infoTextX = axLimits(1) + 20;
infoTextY = axLimits(3) + 80;
hInfoText = text(infoTextX, infoTextY, '', 'Color', 'white', 'FontSize', 10, ...
    'BackgroundColor', [0.12 0.16 0.23], 'EdgeColor', [0.28 0.33 0.4], ...
    'Margin', 5, 'VerticalAlignment', 'top');

wheelTextX = axLimits(2) - 180;
wheelTextY = axLimits(3) + 180;
hWheelText = text(wheelTextX, wheelTextY, '', 'Color', 'white', 'FontSize', 9, ...
    'BackgroundColor', [0.12 0.16 0.23], 'EdgeColor', [0.28 0.33 0.4], ...
    'Margin', 5, 'VerticalAlignment', 'top', 'FontName', 'FixedWidth');

% Legend
axLimits = axis;
legendX = axLimits(1) + 20; 
legendY = axLimits(4) - 20;
plot([legendX, legendX+30], [legendY, legendY], 'r-', 'LineWidth', 2);
text(legendX+35, legendY, 'T: Tangent', 'Color', 'white', 'FontSize', 10);
plot([legendX, legendX+30], [legendY-20, legendY-20], 'b-', 'LineWidth', 2);
text(legendX+35, legendY-20, 'N: Normal', 'Color', 'white', 'FontSize', 10);
plot(legendX+15, legendY-40, 'go', 'MarkerSize', 8, 'LineWidth', 2);
text(legendX+35, legendY-40, 'B: Binormal (⊙)', 'Color', 'white', 'FontSize', 10);

plot(legendX+5, legendY-60, 'o', 'MarkerFaceColor', [0.2 0.8 0.2], ...
    'MarkerEdgeColor', 'none', 'MarkerSize', 5);
text(legendX+15, legendY-60, 'Low κ (ds→ds_{max})', 'Color', 'white', 'FontSize', 9);
plot(legendX+5, legendY-75, 'o', 'MarkerFaceColor', [0.8 0.2 0.2], ...
    'MarkerEdgeColor', 'none', 'MarkerSize', 8);
text(legendX+15, legendY-75, 'High κ (ds→ds_{min})', 'Color', 'white', 'FontSize', 9);

infoBoxX = axLimits(2) - 160;
infoBoxY = axLimits(4) - 20;
text(infoBoxX, infoBoxY, sprintf('ds_{min} = %.3f', dsMin), 'Color', 'white', ...
    'FontSize', 10, 'BackgroundColor', [0.12 0.16 0.23], 'EdgeColor', [0.28 0.33 0.4], 'Margin', 3);
text(infoBoxX, infoBoxY-20, sprintf('ds_{max} = %.3f', dsMax), 'Color', 'white', ...
    'FontSize', 10, 'BackgroundColor', [0.12 0.16 0.23], 'EdgeColor', [0.28 0.33 0.4], 'Margin', 3);

% GIF filename
if useCustomPath
    gifFile = 'frenet_mecanum_custom_path.gif';
else
    gifFile = 'frenet_mecanum_adaptive_sampling.gif';
end
delayTime = 0.05;

%% Animation Loop
for frame = 1:numFrames
    t = tValues(frame);
    
    % Current position
    pos = pathFunc(t, useCustomPath, userPoints);
    x = pos(1);
    y = pos(2);
    
    % Numerical derivatives
    h = 0.001;
    pos1 = pathFunc(t + h, useCustomPath, userPoints);
    pos_1 = pathFunc(max(t - h, 0), useCustomPath, userPoints);
    
    dx = (pos1(1) - x) / h;
    dy = (pos1(2) - y) / h;
    ddx = (pos1(1) - 2*x + pos_1(1)) / h^2;
    ddy = (pos1(2) - 2*y + pos_1(2)) / h^2;
    
    % Tangent vector
    velMag = sqrt(dx^2 + dy^2);
    Tx = dx / velMag;
    Ty = dy / velMag;
    
    % Normal vector
    Nx = -Ty;
    Ny = Tx;
    
    % Curvature
    crossProd = dx * ddy - dy * ddx;
    curvature = abs(crossProd) / velMag^3;
    if curvature > 0.0001
        radiusOfCurv = 1 / curvature;
    else
        radiusOfCurv = 1000;
    end
    
    % Adaptive step
    kNorm = min(curvature / kRef, 1);
    currentDS = dsMin + (dsMax - dsMin) * (1 - kNorm);
    
    % Mecanum Wheel Kinematics
% --- Mecanum Wheel Kinematics ---
% Calculate desired robot velocities
linearSpeed = velMag * 0.01; % scale to reasonable speed (m/s)

% Calculate angular velocity (yaw rate) using larger step size
h_angle = 0.01; % Larger step for better angular velocity estimation

% Get next position for angular velocity calculation
if t + h_angle <= tMax
    pos_next = pathFunc(t + h_angle, useCustomPath, userPoints);
    pos_curr = pathFunc(t, useCustomPath, userPoints);
    
    % Calculate derivatives at next time
    h_deriv = 0.001;
    pos_next_h = pathFunc(t + h_angle + h_deriv, useCustomPath, userPoints);
    dx_next = (pos_next_h(1) - pos_next(1)) / h_deriv;
    dy_next = (pos_next_h(2) - pos_next(2)) / h_deriv;
    
    % Angles at current and next time
    angle_next = atan2(dy_next, dx_next);
    angle_curr = atan2(dy, dx);
    
    % Calculate angle difference
    angularVel = angle_next - angle_curr;
    
    % Normalize angular velocity to [-pi, pi]
    if angularVel > pi
        angularVel = angularVel - 2*pi;
    elseif angularVel < -pi
        angularVel = angularVel + 2*pi;
    end
    
    % Convert to rad/s (divide by time step, scale)
    angularVel = angularVel / h_angle * 0.01;
else
    angularVel = 0;
end

% Robot velocities in body frame
vx = linearSpeed;  % forward velocity
vy = 0;            % lateral velocity (0 for pure path following)
omega = angularVel; % yaw rate
%%
 
     
    wheelFL = (vx - vy - (L + W) * omega) / wheelRadius;
    wheelFR = (vx + vy + (L + W) * omega) / wheelRadius;
    wheelRL = (vx + vy - (L + W) * omega) / wheelRadius;
    wheelRR = (vx - vy + (L + W) * omega) / wheelRadius;
    
    wheelFL_RPM = wheelFL * 60 / (2*pi);
    wheelFR_RPM = wheelFR * 60 / (2*pi);
    wheelRL_RPM = wheelRL * 60 / (2*pi);
    wheelRR_RPM = wheelRR * 60 / (2*pi);
    
    wheelSpeedData(frame, :) = [t, wheelFL_RPM, wheelFR_RPM, wheelRL_RPM, wheelRR_RPM];
    
    % Store velocity data
    velocityData(frame, :) = [t, x, y, dx*0.01, dy*0.01, vx, omega, curvature];
    
    % Center of curvature
    centerX = x + Nx * radiusOfCurv * sign(crossProd);
    centerY = y + Ny * radiusOfCurv * sign(crossProd);
    
    % Cart angle
    angle = atan2(Ty, Tx);
    
    % Update cart
    cartCorners = [-cartWidth/2, cartWidth/2, cartWidth/2, -cartWidth/2;
                   -cartHeight/2, -cartHeight/2, cartHeight/2, cartHeight/2];
    R = [cos(angle), -sin(angle); sin(angle), cos(angle)];
    rotatedCart = R * cartCorners;
    set(hCart, 'XData', rotatedCart(1,:) + x, 'YData', rotatedCart(2,:) + y);
    
    % Update wheels
    wheelOffsets = [-cartWidth/2+5, -cartHeight/2+5;
                    cartWidth/2-5, -cartHeight/2+5;
                    -cartWidth/2+5, cartHeight/2-5;
                    cartWidth/2-5, cartHeight/2-5];
    for i = 1:4
        theta = linspace(0, 2*pi, 20);
        wheelX = 6 * cos(theta);
        wheelY = 4 * sin(theta);
        wheelPos = R * [wheelOffsets(i,1); wheelOffsets(i,2)];
        set(hWheels{i}, 'XData', wheelX + x + wheelPos(1), ...
                        'YData', wheelY + y + wheelPos(2));
    end
    
    % Update Frenet frame
    vecScale = 60;
    set(hTangent, 'XData', x, 'YData', y, 'UData', Tx*vecScale, 'VData', Ty*vecScale);
    set(hNormal, 'XData', x, 'YData', y, ...
        'UData', Nx*vecScale*sign(crossProd), 'VData', Ny*vecScale*sign(crossProd));
    
    binomTheta = linspace(0, 2*pi, 30);
    set(hBinormal, 'XData', x + 8*cos(binomTheta), 'YData', y + 8*sin(binomTheta));
    set(hBinormalCenter, 'XData', x, 'YData', y);
    
    % Update osculating circle
    if radiusOfCurv < 500
        oscTheta = linspace(0, 2*pi, 100);
        set(hOscCircle, 'XData', centerX + radiusOfCurv*cos(oscTheta), ...
                        'YData', centerY + radiusOfCurv*sin(oscTheta));
        set(hRadiusLine, 'XData', [x, centerX], 'YData', [y, centerY]);
        set(hCenterPoint, 'XData', centerX, 'YData', centerY);
    else
        set(hOscCircle, 'XData', [], 'YData', []);
        set(hRadiusLine, 'XData', [], 'YData', []);
        set(hCenterPoint, 'XData', [], 'YData', []);
    end
    
    % Update text
    set(hTextT, 'Position', [x + Tx*70, y + Ty*70]);
    set(hTextN, 'Position', [x + Nx*70*sign(crossProd), y + Ny*70*sign(crossProd)]);
    set(hTextB, 'Position', [x + 15, y - 10]);
    
    infoStr = sprintf(['κ = %.4f\nρ = %.1f\n' ...
                       'ds = %.3f\n' ...
                       'Frame: %d/%d'], ...
                      curvature, radiusOfCurv, currentDS, frame, numFrames);
    set(hInfoText, 'String', infoStr);
    
    wheelStr = sprintf(['Wheel Speeds (RPM)\n' ...
                        '─────────────────\n' ...
                        'FL: %+7.1f  FR: %+7.1f\n' ...
                        'RL: %+7.1f  RR: %+7.1f\n' ...
                        '─────────────────\n' ...
                        'vx: %+.3f m/s\n' ...
                        'ω:  %+.3f rad/s'], ...
                       wheelFL_RPM, wheelFR_RPM, ...
                       wheelRL_RPM, wheelRR_RPM, ...
                       vx, omega);
    set(hWheelText, 'String', wheelStr);
    
    drawnow;
    
    % Capture frame
    frame_img = getframe(fig);
    im = frame2im(frame_img);
    [imind, cm] = rgb2ind(im, 256);
    
    if frame == 1
        imwrite(imind, cm, gifFile, 'gif', 'Loopcount', inf, 'DelayTime', delayTime);
    else
        imwrite(imind, cm, gifFile, 'gif', 'WriteMode', 'append', 'DelayTime', delayTime);
    end
end

hold off;
fprintf('Animation complete! GIF saved as: %s\n', gifFile);
fprintf('Total adaptive points: %d\n', size(adaptivePoints, 1));
fprintf('Average spacing: %.4f\n', mean(adaptivePoints(:, 5)));

%% Analysis Plots
figure('Position', [100, 100, 1000, 600], 'Color', 'white');

subplot(2,1,1);
plot(wheelSpeedData(:,1), wheelSpeedData(:,2), 'r-', 'LineWidth', 2, 'DisplayName', 'Front Left');
hold on;
plot(wheelSpeedData(:,1), wheelSpeedData(:,3), 'b-', 'LineWidth', 2, 'DisplayName', 'Front Right');
plot(wheelSpeedData(:,1), wheelSpeedData(:,4), 'g-', 'LineWidth', 2, 'DisplayName', 'Rear Left');
plot(wheelSpeedData(:,1), wheelSpeedData(:,5), 'm-', 'LineWidth', 2, 'DisplayName', 'Rear Right');
hold off;
grid on;
xlabel('Parameter t', 'FontSize', 12);
ylabel('Wheel Speed (RPM)', 'FontSize', 12);
title('Individual Wheel Speeds', 'FontSize', 14, 'FontWeight', 'bold');
legend('Location', 'best');

subplot(2,1,2);
leftAvg = (wheelSpeedData(:,2) + wheelSpeedData(:,4)) / 2;
rightAvg = (wheelSpeedData(:,3) + wheelSpeedData(:,5)) / 2;
speedDiff = rightAvg - leftAvg;
plot(wheelSpeedData(:,1), speedDiff, 'k-', 'LineWidth', 2);
hold on;
yline(0, '--r', 'LineWidth', 1);
hold off;
grid on;
xlabel('Parameter t', 'FontSize', 12);
ylabel('Speed Difference (RPM)', 'FontSize', 12);
title('Left-Right Speed Difference (indicates turning)', 'FontSize', 14, 'FontWeight', 'bold');

sgtitle('Mecanum Wheel Kinematics Analysis', 'FontSize', 16, 'FontWeight', 'bold');

%% Curvature Analysis
figure('Position', [100, 100, 1000, 500], 'Color', 'white');

subplot(2,2,1);
plot(adaptivePoints(:, 3), adaptivePoints(:, 4), 'LineWidth', 2);
xlabel('Parameter s', 'FontSize', 12);
ylabel('Curvature κ', 'FontSize', 12);
title('Curvature Profile', 'FontSize', 14, 'FontWeight', 'bold');
grid on;

subplot(2,2,2);
plot(adaptivePoints(:, 3), adaptivePoints(:, 5), 'LineWidth', 2, 'Color', [0.8 0.2 0.2]);
hold on;
yline(dsMin, '--k', 'ds_{min}', 'LineWidth', 1.5);
yline(dsMax, '--k', 'ds_{max}', 'LineWidth', 1.5);
xlabel('Parameter s', 'FontSize', 12);
ylabel('Step size ds', 'FontSize', 12);
title('Adaptive Step Size', 'FontSize', 14, 'FontWeight', 'bold');
grid on;
hold off;

subplot(2,2,3);
scatter(adaptivePoints(:, 4), adaptivePoints(:, 5), 50, adaptivePoints(:, 4), 'filled');
colormap(gca, jet);
xlabel('Curvature κ', 'FontSize', 12);
ylabel('Step size ds', 'FontSize', 12);
title('ds vs κ Relationship', 'FontSize', 14, 'FontWeight', 'bold');
grid on;
colorbar;

subplot(2,2,4);
histogram(adaptivePoints(:, 5), 20, 'FaceColor', [0.2 0.6 0.8]);
xlabel('Step size ds', 'FontSize', 12);
ylabel('Frequency', 'FontSize', 12);
title('Distribution of Step Sizes', 'FontSize', 14, 'FontWeight', 'bold');
grid on;

sgtitle('Adaptive Sampling Analysis', 'FontSize', 16, 'FontWeight', 'bold');

%% Export Data
samplingData = array2table(adaptivePoints, ...
    'VariableNames', {'x', 'y', 's', 'curvature', 'ds'});
writetable(samplingData, 'adaptive_sampling_data.csv');
fprintf('Sampling data exported to: adaptive_sampling_data.csv\n');

% Export velocity data (linear and angular velocities)
velocityDataTable = array2table(velocityData, ...
    'VariableNames', {'time', 'x_position', 'y_position', 'vx', 'vy', ...
                      'linear_speed_m_s', 'angular_velocity_rad_s', 'curvature'});
writetable(velocityDataTable, 'velocity_data.csv');
fprintf('Velocity data (linear & angular) exported to: velocity_data.csv\n');

wheelKinematicsData = array2table(wheelSpeedData, ...
    'VariableNames', {'t', 'FL_RPM', 'FR_RPM', 'RL_RPM', 'RR_RPM'});
writetable(wheelKinematicsData, 'wheel_kinematics_data.csv');
fprintf('Wheel kinematics data exported to: wheel_kinematics_data.csv\n');

if useCustomPath
    controlPointsData = array2table([(userPoints(:,1) - 400) / 300 * 100, ...
                                     (userPoints(:,2) - 300) / 200 * 100], ...
        'VariableNames', {'x', 'y'});
    writetable(controlPointsData, 'custom_path_control_points.csv');
    fprintf('Control points exported to: custom_path_control_points.csv\n');
end

 %% Summary Statistics
fprintf('\n=== Mecanum Wheel Kinematics Summary ===\n');
fprintf('Average wheel speeds (RPM):\n');
fprintf('  Front Left:  %7.2f\n', mean(abs(wheelSpeedData(:,2))));
fprintf('  Front Right: %7.2f\n', mean(abs(wheelSpeedData(:,3))));
fprintf('  Rear Left:   %7.2f\n', mean(abs(wheelSpeedData(:,4))));
fprintf('  Rear Right:  %7.2f\n', mean(abs(wheelSpeedData(:,5))));
fprintf('\nMax wheel speeds (RPM):\n');
fprintf('  Front Left:  %7.2f\n', max(abs(wheelSpeedData(:,2))));
fprintf('  Front Right: %7.2f\n', max(abs(wheelSpeedData(:,3))));
fprintf('  Rear Left:   %7.2f\n', max(abs(wheelSpeedData(:,4))));
fprintf('  Rear Right:  %7.2f\n', max(abs(wheelSpeedData(:,5))));

fprintf('\n=== Velocity Summary ===\n');
fprintf('Linear velocity (m/s):\n');
fprintf('  Average: %7.4f\n', mean(velocityData(:,6)));
fprintf('  Maximum: %7.4f\n', max(velocityData(:,6)));
fprintf('  Minimum: %7.4f\n', min(velocityData(:,6)));
fprintf('\nAngular velocity (rad/s):\n');
fprintf('  Average: %7.4f\n', mean(abs(velocityData(:,7))));
fprintf('  Maximum: %7.4f\n', max(abs(velocityData(:,7))));
fprintf('  Minimum: %7.4f\n', min(abs(velocityData(:,7))));
fprintf('\nCurvature:\n');
fprintf('  Average: %7.6f\n', mean(velocityData(:,8)));
fprintf('  Maximum: %7.6f\n', max(velocityData(:,8)));

fprintf('\n=== Files Generated ===\n');
fprintf('- %s (animation GIF)\n', gifFile);
fprintf('- adaptive_sampling_data.csv\n');
fprintf('- velocity_data.csv\n');
fprintf('- wheel_kinematics_data.csv\n');
if useCustomPath
    fprintf('- custom_path_control_points.csv\n');
end
fprintf('\nAll done! Check the generated files for detailed trajectory data.\n');

%% Generate Time-Stamped Trajectory with Adaptive Temporal Sampling
% Time sampling is proportional to curvature: high curvature = more time samples

% Define time allocation parameters
dt_min = 0.02;  % minimum time step (seconds) for high curvature
dt_max = 0.10;  % maximum time step (seconds) for straight sections
total_time = 20; % total trajectory time (seconds)

% Generate adaptive time-stamped trajectory
trajectoryData = [];
current_time = 0;
s_index = 1;

fprintf('Generating adaptive temporal sampling...\n');

while s_index <= size(adaptivePoints, 1) && current_time < total_time
    % Get current point data
    x = adaptivePoints(s_index, 1);
    y = adaptivePoints(s_index, 2);
    s = adaptivePoints(s_index, 3);
    k = adaptivePoints(s_index, 4);
    ds = adaptivePoints(s_index, 5);
    
    % Calculate velocities at this point
    pos = [x, y];
    
    % Compute derivatives
    h = 0.001;
    if s + h <= tMax
        pos1 = pathFunc(s + h, useCustomPath, userPoints);
        pos_1 = pathFunc(max(s - h, 0), useCustomPath, userPoints);
        
        dx = (pos1(1) - x) / h;
        dy = (pos1(2) - y) / h;
        ddx = (pos1(1) - 2*x + pos_1(1)) / h^2;
        ddy = (pos1(2) - 2*y + pos_1(2)) / h^2;
    else
        dx = 0; dy = 0; ddx = 0; ddy = 0;
    end
    
    velMag = sqrt(dx^2 + dy^2);
    
    % Calculate angular velocity
    h_angle = 0.01;
    if s + h_angle <= tMax
        pos_next = pathFunc(s + h_angle, useCustomPath, userPoints);
        h_deriv = 0.001;
        pos_next_h = pathFunc(min(s + h_angle + h_deriv, tMax), useCustomPath, userPoints);
        dx_next = (pos_next_h(1) - pos_next(1)) / h_deriv;
        dy_next = (pos_next_h(2) - pos_next(2)) / h_deriv;
        
        angle_next = atan2(dy_next, dx_next);
        angle_curr = atan2(dy, dx);
        
        angularVel = angle_next - angle_curr;
        if angularVel > pi
            angularVel = angularVel - 2*pi;
        elseif angularVel < -pi
            angularVel = angularVel + 2*pi;
        end
        angularVel = angularVel / h_angle * 0.01;
    else
        angularVel = 0;
    end
    
    linearSpeed = velMag * 0.01;
    
    % Adaptive time step based on curvature
    % High curvature -> small dt (more samples), Low curvature -> large dt (fewer samples)
    kNorm = min(k / kRef, 1);
    dt = dt_min + (dt_max - dt_min) * (1 - kNorm);
    
    % Calculate wheel speeds
    vx = linearSpeed;
    vy = 0;
    omega = angularVel;
    
    wheelFL = (vx - vy - (L + W) * omega) / wheelRadius;
    wheelFR = (vx + vy + (L + W) * omega) / wheelRadius;
    wheelRL = (vx + vy - (L + W) * omega) / wheelRadius;
    wheelRR = (vx - vy + (L + W) * omega) / wheelRadius;
    
    wheelFL_RPM = wheelFL * 60 / (2*pi);
    wheelFR_RPM = wheelFR * 60 / (2*pi);
    wheelRL_RPM = wheelRL * 60 / (2*pi);
    wheelRR_RPM = wheelRR * 60 / (2*pi);
    
    % Store trajectory point with timestamp
    trajectoryData = [trajectoryData; ...
        current_time, x, y, s, ...
        dx*0.01, dy*0.01, linearSpeed, angularVel, ...
        k, ds, dt, ...
        wheelFL_RPM, wheelFR_RPM, wheelRL_RPM, wheelRR_RPM];
    
    current_time = current_time + dt;
    s_index = s_index + 1;
end

fprintf('Generated %d time-stamped trajectory points\n', size(trajectoryData, 1));
fprintf('Total trajectory time: %.2f seconds\n', trajectoryData(end, 1));
fprintf('Average time step: %.4f seconds\n', mean(trajectoryData(:, 11)));
fprintf('Min time step (high curvature): %.4f seconds\n', min(trajectoryData(:, 11)));
fprintf('Max time step (low curvature): %.4f seconds\n', max(trajectoryData(:, 11)));

%% Export Adaptive Time-Sampled Trajectory
trajectoryTable = array2table(trajectoryData, ...
    'VariableNames', {'time_sec', 'x_pos', 'y_pos', 's_param', ...
                      'vx_m_s', 'vy_m_s', 'linear_speed_m_s', 'angular_velocity_rad_s', ...
                      'curvature', 'ds_spatial', 'dt_temporal', ...
                      'wheel_FL_RPM', 'wheel_FR_RPM', 'wheel_RL_RPM', 'wheel_RR_RPM'});
writetable(trajectoryTable, 'adaptive_time_trajectory.csv');
fprintf('Adaptive time-sampled trajectory exported to: adaptive_time_trajectory.csv\n');

%% Visualize Time Sampling Distribution
figure('Position', [100, 100, 1200, 400], 'Color', 'white');

subplot(1,3,1);
plot(trajectoryData(:,1), trajectoryData(:,11), 'b-', 'LineWidth', 2);
xlabel('Time (s)', 'FontSize', 12);
ylabel('Time Step dt (s)', 'FontSize', 12);
title('Adaptive Time Step vs Time', 'FontSize', 14, 'FontWeight', 'bold');
grid on;

subplot(1,3,2);
scatter(trajectoryData(:,9), trajectoryData(:,11), 50, trajectoryData(:,9), 'filled');
xlabel('Curvature κ', 'FontSize', 12);
ylabel('Time Step dt (s)', 'FontSize', 12);
title('Time Step vs Curvature', 'FontSize', 14, 'FontWeight', 'bold');
colorbar;
colormap(jet);
grid on;

subplot(1,3,3);
plot(trajectoryData(:,4), trajectoryData(:,1), 'r-', 'LineWidth', 2);
xlabel('Path Parameter s', 'FontSize', 12);
ylabel('Time (s)', 'FontSize', 12);
title('Time vs Path Progress', 'FontSize', 14, 'FontWeight', 'bold');
grid on;

sgtitle('Adaptive Temporal Sampling Analysis', 'FontSize', 16, 'FontWeight', 'bold');

%%
 function addPoint()
  global userPoints
    global pointHandles
    global lineHandles
    drawAx= findobj('tag','ax');

        pt = get(drawAx, 'CurrentPoint');
        x = pt(1,1);
        y = pt(1,2);
        
        if abs(x) <= 100 && abs(y) <= 100
            userPoints = [userPoints; x, y];
            
            % Plot point
            h = plot(x, y, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
            text(x+3, y+3, sprintf('%d', size(userPoints,1)), 'FontSize', 10);
            pointHandles = [pointHandles; h];
            
            % Draw line to previous point
            if size(userPoints, 1) > 1
                prev = userPoints(end-1, :);
                lineH = plot([prev(1) x], [prev(2) y], 'b--', 'LineWidth', 1);
                lineHandles = [lineHandles; lineH];
            end
            
            title(sprintf('Points: %d (close window when finished)', size(userPoints,1)), ...
                'FontSize', 14);
        end
 end

 %%
 %% Catmull-Rom Spline Function
function pos = catmullRomSpline(points, t)
    n = size(points, 1);
    
    if n < 2
        pos = [400, 300];
        return;
    end
    
    if n == 2
        alpha = t;
        pos = points(1,:) * (1 - alpha) + points(2,:) * alpha;
        return;
    end
    
    segment = min(floor(t), n - 2);
    localT = t - segment;
    
    if segment < 1
        p0 = points(1, :);
    else
        p0 = points(segment, :);
    end
    
    p1 = points(segment + 1, :);
    p2 = points(segment + 2, :);
    
    if segment + 2 < n
        p3 = points(segment + 3, :);
    else
        p3 = points(n, :);
    end
    
    t2 = localT^2;
    t3 = t2 * localT;
    
    pos = 0.5 * (...
        (2 * p1) + ...
        (-p0 + p2) * localT + ...
        (2*p0 - 5*p1 + 4*p2 - p3) * t2 + ...
        (-p0 + 3*p1 - 3*p2 + p3) * t3 ...
    );
end

%% Path Function
function pos = pathFunc(t, useCustom, userPts)
    if useCustom && ~isempty(userPts)
        pos = catmullRomSpline(userPts, t);
    else
        % Default figure-8 path
        scale = 120;
        center = [400, 300];
        pos = [center(1) + scale * sin(t), ...
               center(2) + scale * sin(t) * cos(t)];
    end
end

%% Curvature Computation Function
function k = computeCurvature(t, useCustom, userPts)
    h = 0.001;
    p0 = pathFunc(t, useCustom, userPts);
    p1 = pathFunc(t + h, useCustom, userPts);
    p2 = pathFunc(t + 2*h, useCustom, userPts);
    
    dx = (p1(1) - p0(1)) / h;
    dy = (p1(2) - p0(2)) / h;
    ddx = (p2(1) - 2*p1(1) + p0(1)) / h^2;
    ddy = (p2(2) - 2*p1(2) + p0(2)) / h^2;
    
    velMag = sqrt(dx^2 + dy^2);
    crossProd = dx * ddy - dy * ddx;
    k = abs(crossProd) / velMag^3;
end
