clc; clear; close all;

sys = tf([1,0], [1,sqrt(2),1]);
display(sys);
bodemag(sys);
title('Bode plot for G(s) = $\frac{s}{(s^2 + \sqrt{2}s + 1)}$', 'Interpreter', 'latex');
grid on;
set(gcf, 'Position', [100, 100, 600, 400]);
set(gcf, 'PaperPositionMode', 'auto');
exportgraphics(gcf, 'q18.png', 'Resolution', 300);