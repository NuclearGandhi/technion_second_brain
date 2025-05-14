clc; clear; close all;

h = 25e-3; % m
h_error = 0.1e-3; % m

ell = 108.5e-3; % m
ell_error = 0.1e-3; % m

S = 141.6e-3; % m
S_error = 0.1e-3; % m

L = 1.26; % m
L_error = 1e-3; % m

g = 9.7949; % m/s^2
g_error = 0.0001; % m/s^2

t_for_l = [0.874, 1.0192, 0.8982, 0.9361];
t_for_l_mean = mean(t_for_l);
l_from_t = 1/2 * g * (h/L) * t_for_l_mean^2;

disp(['l from t: ', num2str(l_from_t)]);

data = readmatrix('measurements.txt', 'NumHeaderLines', 1);

t = data(:, 2);

t_mean = mean(t);
t_std = std(t);

% mean error
t_mean_error = t_std / sqrt(numel(t));

% full mean result
disp(['mean t: ', num2str(t_mean, '%.5f'), ' +/- ', num2str(t_mean_error, '%.5f')]);
disp(['std t: ', num2str(t_std)]);

% measured average velocity
v_mean = ell / t_mean;

% average velocity error
v_mean_error = v_mean * sqrt((ell_error / ell)^2 + (t_mean_error / t_mean)^2);

disp(['v_mean: ', num2str(v_mean, '%.5f'), ' +/- ', num2str(v_mean_error, '%.5f')]);

% Histogram with counts (default)
hist_handle = histogram(t, 10); % Save handle to get bin width
hold on;

% Fit normal distribution
pd = fitdist(t, 'Normal');

% PDF x values
x = linspace(min(t), max(t), 100);

% Calculate bin width (assume uniform bins)
bin_width = hist_handle.BinWidth;
disp(['bin width: ', num2str(bin_width)]);

% Scale PDF to match histogram counts
y = pdf(pd, x) * numel(t) * bin_width;

% Plot scaled PDF
plot(x, y, 'LineWidth', 2);

% Add labels, title, and legend with LaTeX formatting
xlabel('$\Delta t$ (s)', 'Interpreter', 'latex');
ylabel('Counts per bin', 'Interpreter', 'latex');
title('Histogram and Normal Fit for $t$ Measurements', 'Interpreter', 'latex');
legend({'Histogram', 'Normal Fit'}, 'Interpreter', 'latex', 'Location', 'best');
grid on;


% theoretical t
t_theoretical = sqrt((2 * (S+ell)) / (g * (h/L))) - sqrt((2 * (S)) / (g * (h/L)));

% theoretical error
t_theoretical_error = t_theoretical * sqrt((S_error / S)^2 + (ell_error / ell)^2 + (h_error / h)^2 + (L_error / L)^2 + (g_error / g)^2);

disp(['theoretical t: ', num2str(t_theoretical, '%.5f'), ' +/- ', num2str(t_theoretical_error, '%.5f')]);

% % Plot t_theoretical with error as lines
% xline(t_theoretical, '--k', {'$t_{\\mathrm{theoretical}}$'}, 'Interpreter', 'latex', 'LineWidth', 2);

% % Plot error bounds
% xline(t_theoretical + t_theoretical_error, ':k', {'$t_{\\mathrm{theoretical}} + \\Delta t$'}, 'Interpreter', 'latex', 'LineWidth', 1.5);
% xline(t_theoretical - t_theoretical_error, ':k', {'$t_{\\mathrm{theoretical}} - \\Delta t$'}, 'Interpreter', 'latex', 'LineWidth', 1.5);

hold off;


% theoretical average velocity
v_theoretical = ell / t_theoretical;

v_theoretical_error = v_theoretical * sqrt((ell_error/ell)^2 + (t_theoretical_error/t_theoretical)^2);

disp(['v_theoretical: ', num2str(v_theoretical, '%.5f'), ' +/- ', num2str(v_theoretical_error, '%.5f')]);

% relative error
t_relative_error = (t_theoretical - t_mean) / t_theoretical;
disp(['relative error: ', num2str(t_relative_error)]);

v_relative_error = (v_theoretical - v_mean) / v_theoretical;
disp(['v_relative_error: ', num2str(v_relative_error)]);

% Set figure size to 600x400 pixels
set(gcf, 'Position', [100, 100, 800, 600]);

% Export the figure as a PNG (or PDF, SVG, etc.)
exportgraphics(gcf, 'histogram_normal_fit.png', 'Resolution', 300); % 300 DPI for high quality
