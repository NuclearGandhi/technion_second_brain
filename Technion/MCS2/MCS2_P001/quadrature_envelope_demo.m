%% Slowly varying quadratures and their fast carrier
close all; clc;

set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
set(groot, 'defaultTextInterpreter', 'latex');
set(groot, 'defaultLegendInterpreter', 'latex');
set(groot, 'defaultAxesToolbarVisible', 'off');

out_dir = fileparts(mfilename('fullpath'));

cycles = linspace(0, 30, 6000);
fast_time = 2 * pi * cycles;
slow_time = cycles / 30;

p = 0.75 + 0.25 * cos(2 * pi * slow_time);
s = 0.20 + 0.35 * sin(2 * pi * slow_time);
amplitude = hypot(p, s);
signal = p .* cos(fast_time) + s .* sin(fast_time);

fig = figure('Position', [100, 100, 800, 430], 'Color', 'w');
hold on; box on; grid on;
plot(cycles, signal, 'Color', [0.35, 0.35, 0.35], 'LineWidth', 0.8);
plot(cycles, amplitude, '-', 'Color', [0.80, 0.12, 0.12], 'LineWidth', 2.2);
plot(cycles, -amplitude, '-', 'Color', [0.80, 0.12, 0.12], ...
    'LineWidth', 2.2, 'HandleVisibility', 'off');
xlabel('Fast oscillation cycles, $\Omega t/(2\pi)$');
ylabel('$A(t)$');
title('Slow quadratures produce a modulated fast oscillation');
legend({'$p(\tau)\cos(\Omega t)+s(\tau)\sin(\Omega t)$', ...
    '$\pm\sqrt{p(\tau)^2+s(\tau)^2}$'}, 'Location', 'southwest');

print(fig, fullfile(out_dir, 'p001_quadrature_envelope.svg'), ...
    '-dsvg', '-painters');
close(fig);

fprintf('Saved quadrature-envelope SVG in:\n  %s\n', out_dir);
