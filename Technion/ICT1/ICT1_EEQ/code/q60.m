clc; clear; close all;

sys = tf([2,0,2], [1, sqrt(2), 1]);
display(sys);
nyquist(sys, 1:0.01:100);

title('Nyquist plot for $L(s) = \frac{2s^2 + 2}{s^2 + \sqrt{2}s + 1}$', 'Interpreter', 'latex');
axis equal;
xlim([-3, 3]);
ylim([-2, 2]);

set(gcf, 'Position', [100, 100, 600, 400]);
exportgraphics(gcf, 'q60.png', 'Resolution', 300);