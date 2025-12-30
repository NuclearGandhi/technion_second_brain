%%  Demo: Catmull–Rom spline + curvature-based speed profile

clear; clc; close all;

% ------------------------------------------------------------
% Demonstration data (slightly "wavy" loop)
% ------------------------------------------------------------
th = linspace(0, 2*pi, 14);
x = cos(th) + 0.20*cos(3*th);
y = sin(th) + 0.15*sin(2*th);

% ------------------------------------------------------------
% Speed bounds (length/time)
% ------------------------------------------------------------
vt_min = 0.10;
vt_max = 1.20;

% ------------------------------------------------------------
% Fit and sample
% ------------------------------------------------------------
[s, xs, ys, dxds, dyds, kappa, vt, tt, pp] = catmullRomSplineFit1( ...
    x, y, vt_min, vt_max, ...
    'SamplesPerSegment', 80, ...
    'Alpha', 0.5, ...
    'Plot', true, ...
    'VtRefStrategy', 'geometric');

% ------------------------------------------------------------
% Extra diagnostics
% ------------------------------------------------------------

% Curvature vs arc length
figure; grid on;
plot(s, kappa, 'LineWidth', 1.6);
xlabel('arc length s'); ylabel('\kappa(s)');
title('Curvature along spline');

% Speed vs arc length (often easier to interpret than vs time)
figure; grid on;
plot(s, vt, 'LineWidth', 1.6);
xlabel('arc length s'); ylabel('v_t(s)');
title('Traversal speed vs arc length');

% Tangent arrows along the curve
figure; hold on; axis equal; grid on;
plot(xs, ys, 'k-', 'LineWidth', 1.5);
plot(x, y, 'r+', 'MarkerSize', 8, 'LineWidth', 1.5);

step = max(1, round(numel(xs)/25));
quiver(xs(1:step:end), ys(1:step:end), ...
       dxds(1:step:end), dyds(1:step:end), ...
       0.3, 'b', 'LineWidth', 1.2);

title('Spline with unit tangents');
xlabel('x'); ylabel('y');
legend('Spline','Data points','Unit tangents','Location','best');

% Sanity check: total time and length
fprintf('Total arc length: %.4f\n', s(end));
fprintf('Total time:       %.4f\n', tt(end));
fprintf('Speed range used: [%.4f, %.4f]\n', min(vt), max(vt));
