%% HDY1 HW001 analysis plots
% Loads the precomputed simulation data and regenerates Assignment 5 plots.

clear; clc; close all;

set(groot, 'defaultTextInterpreter', 'latex');
set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
set(groot, 'defaultLegendInterpreter', 'latex');

scriptPath = mfilename('fullpath');
if isempty(scriptPath)
    scriptPath = which('hw1_analysis_plots');
end
scriptDir = fileparts(scriptPath);
projectDir = fileparts(scriptDir);
plotsDir = fullfile(projectDir, 'figures');
if ~exist(plotsDir, 'dir')
    mkdir(plotsDir);
end

dataFile = fullfile(scriptDir, 'assignment5_data.mat');
if ~isfile(dataFile)
    error('Data file "%s" not found. Run assignment_symbolic.m to generate it.', dataFile);
end

S = load(dataFile);

requiredFields = {'t_state','qb','qb_dot','xc_hist','xc_dot_hist','yc_hist','yc_dot_hist', ...
    'Hc_hist','theta_dot_cons_hist','theta_dd_link2_hist','ddqb_hist','tau_hist', ...
    'params','t_final','dt'};
missing = setdiff(requiredFields, fieldnames(S));
if ~isempty(missing)
    error('Data file is missing fields: %s', strjoin(missing, ', '));
end

t_state = S.t_state;
qb = S.qb;
qb_dot = S.qb_dot;
xc_hist = S.xc_hist;
xc_dot_hist = S.xc_dot_hist;
yc_hist = S.yc_hist;
yc_dot_hist = S.yc_dot_hist;
Hc_hist = S.Hc_hist;
theta_dot_cons_hist = S.theta_dot_cons_hist;
theta_dd_link2_hist = S.theta_dd_link2_hist;
ddqb_hist = S.ddqb_hist;
tau_hist = S.tau_hist;
params = S.params;
t_final = S.t_final;
dt = S.dt;
ell = params.ell;
omega = params.omega;
m = params.m;

theta_deg = qb(:, 3) * 180 / pi;

figA = figure('Visible', 'off');
set(figA, 'Position', [100, 100, 800, 533]);
plot(t_state, theta_deg, 'LineWidth', 2, 'Color', [0.10, 0.45, 0.85]);
grid on;
xlabel('$t~[\mathrm{s}]$');
ylabel('$\theta~[\mathrm{deg}]$');
title('Middle link angle');
xlim([0, t_final]);
exportgraphics(figA, fullfile(plotsDir, 'HDY1_HW001_PartA.png'), 'Resolution', 300);
close(figA);

figB = figure('Visible', 'off');
set(figB, 'Position', [100, 100, 800, 533]);
plot(t_state, qb(:, 1) / ell, 'LineWidth', 2, 'LineStyle', '-', 'Color', [0.85, 0.33, 0.10]);
hold on;
plot(t_state, xc_hist / ell, 'LineWidth', 2, 'LineStyle', '-', 'Color', [0.00, 0.45, 0.74]);
grid on;
xlabel('$t~[\mathrm{s}]$');
ylabel('Normalized position');
title('Normalized horizontal positions');
xlim([0, t_final]);
legend({'$x/\ell$', '$x_{c}/\ell$'}, 'Location', 'best');
exportgraphics(figB, fullfile(plotsDir, 'HDY1_HW001_PartB.png'), 'Resolution', 300);
close(figB);

%% Part c: normalized horizontal velocity and angular momentum
xdot_norm = qb_dot(:, 1) / (ell * omega);
xc_dot_norm = xc_dot_hist / (ell * omega);
Hc_norm = Hc_hist / (m * ell^2 * omega);

figC = figure('Visible', 'off');
set(figC, 'Position', [100, 100, 800, 533]);
plot(t_state, xdot_norm, 'LineWidth', 2, 'LineStyle', '-', 'Color', [0.85, 0.33, 0.10]);
hold on;
plot(t_state, xc_dot_norm, 'LineWidth', 2, 'LineStyle', '--', 'Color', [0.00, 0.45, 0.74]);
plot(t_state, Hc_norm, 'LineWidth', 2, 'LineStyle', ':', 'Color', [0.10, 0.60, 0.40]);
grid on;
xlabel('$t~[\mathrm{s}]$');
ylabel('Normalized value');
title('Horizontal velocity and angular momentum');
xlim([0, t_final]);
legend({'$\dot{x}/(\ell\omega)$', '$\dot{x}_{c}/(\ell\omega)$', '$H_{c}/(m\ell^{2}\omega)$'}, 'Location', 'best');
exportgraphics(figC, fullfile(plotsDir, 'HDY1_HW001_PartC.png'), 'Resolution', 300);
close(figC);

%% Part d: vertical velocity comparison and difference
ydot_norm = qb_dot(:, 2) / (ell * omega);
yc_dot_norm = yc_dot_hist / (ell * omega);
ydiff_norm = (qb_dot(:, 2) - yc_dot_hist) / (ell * omega);

figD = figure('Visible', 'off');
set(figD, 'Position', [100, 100, 800, 600]);
tiledlayout(figD, 2, 1, 'TileSpacing', 'compact');
nexttile;
plot(t_state, ydot_norm, 'LineWidth', 2, 'LineStyle', '-', 'Color', [0.85, 0.33, 0.10]);
hold on;
plot(t_state, yc_dot_norm, 'LineWidth', 2, 'LineStyle', '--', 'Color', [0.00, 0.45, 0.74]);
grid on;
xlabel('$t~[\mathrm{s}]$');
ylabel('Normalized value');
title('Vertical velocity comparison');
legend({'$\dot{y}/(\ell\omega)$', '$\dot{y}_{c}/(\ell\omega)$'}, 'Location', 'best');
nexttile;
plot(t_state, ydiff_norm, 'LineWidth', 2, 'Color', [0.10, 0.60, 0.40]);
grid on;
xlabel('$t~[\mathrm{s}]$');
ylabel('Difference');
title('$[\dot{y}-\dot{y}_{c}]/(\ell\omega)$');
exportgraphics(figD, fullfile(plotsDir, 'HDY1_HW001_PartD.png'), 'Resolution', 300);
close(figD);

%% Part e: normalized theta_dot and momentum-based estimate
theta_dot_norm = qb_dot(:, 3) / omega;
theta_dot_cons_norm = theta_dot_cons_hist / omega;

figE = figure('Visible', 'off');
set(figE, 'Position', [100, 100, 800, 533]);
plot(t_state, theta_dot_norm, 'LineWidth', 2, 'LineStyle', '-', 'Color', [0.85, 0.33, 0.10]);
hold on;
plot(t_state, theta_dot_cons_norm, 'LineWidth', 2, 'LineStyle', '--', 'Color', [0.00, 0.45, 0.74]);
grid on;
xlabel('$t~[\mathrm{s}]$');
ylabel('Normalized value');
title('Angular velocity comparison');
legend({'$\dot{\theta}/\omega$', '$\dot{\theta}_{H_{c}=0}/\omega$'}, 'Location', 'best');
xlim([0, t_final]);
exportgraphics(figE, fullfile(plotsDir, 'HDY1_HW001_PartE.png'), 'Resolution', 300);
close(figE);

%% Part f: joint torques
figF = figure('Visible', 'off');
set(figF, 'Position', [100, 100, 800, 533]);
plot(t_state, tau_hist(:, 1), 'LineWidth', 2, 'LineStyle', '-', 'Color', [0.85, 0.33, 0.10]);
hold on;
plot(t_state, tau_hist(:, 2), 'LineWidth', 2, 'LineStyle', '-', 'Color', [0.00, 0.45, 0.74]);
grid on;
xlabel('$t~[\mathrm{s}]$');
ylabel('$\tau~[\mathrm{N\cdot m}]$');
title('Actuation torques');
legend({'$\tau_{1}$', '$\tau_{2}$'}, 'Location', 'best');
xlim([0, t_final]);
exportgraphics(figF, fullfile(plotsDir, 'HDY1_HW001_PartF.png'), 'Resolution', 300);
close(figF);

%% Part g: normalized angular acceleration comparison
theta_dd_norm = ddqb_hist(:, 3) / omega^2;
theta_dd_link2_norm = theta_dd_link2_hist / omega^2;

figG = figure('Visible', 'off');
set(figG, 'Position', [100, 100, 800, 533]);
plot(t_state, theta_dd_norm, 'LineWidth', 2, 'LineStyle', '-', 'Color', [0.85, 0.33, 0.10]);
hold on;
plot(t_state, theta_dd_link2_norm, 'LineWidth', 2, 'LineStyle', '-', 'Color', [0.00, 0.45, 0.74]);
grid on;
xlabel('$t~[\mathrm{s}]$');
ylabel('Normalized value');
title('Angular acceleration comparison');
legend({'$\ddot{\theta}/\omega^{2}$', '$\ddot{\theta}_{p_{2}}/\omega^{2}$'}, 'Location', 'best');
xlim([0, t_final]);
exportgraphics(figG, fullfile(plotsDir, 'HDY1_HW001_PartG.png'), 'Resolution', 300);
close(figG);

%% Console summaries for write-up
fprintf('Updated plots using data in %s\n', dataFile);
fprintf('Dataset horizon %.1f s with sampling %.4g s\n', t_final, dt);
fprintf('Part C: max |Hc|/(m l^2 w) = %.3f\n', max(abs(Hc_norm)));
fprintf('Part D: max |y - yc|/(l w) = %.3f\n', max(abs(ydiff_norm)));
fprintf('Part E: RMS error between theta_dot curves = %.3e\n', ...
    rms(theta_dot_norm - theta_dot_cons_norm));
fprintf('Part G: RMS error between theta_dd curves = %.3e\n', ...
    rms(theta_dd_norm - theta_dd_link2_norm));
fprintf('Part F: tau1 range = [%.2f, %.2f] N·m, tau2 range = [%.2f, %.2f] N·m\n', ...
    min(tau_hist(:,1)), max(tau_hist(:,1)), min(tau_hist(:,2)), max(tau_hist(:,2)));
fprintf('Part G: max |ddtheta difference|/omega^2 = %.2f\n', ...
    max(abs(theta_dd_norm - theta_dd_link2_norm)));

