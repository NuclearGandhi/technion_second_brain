clc; clear; close all;

sys = tf([0.005], [1,0.005]);
display(sys);
bodemag(sys);
title('Bode plot for G(s) = $\frac{0.005}{(s + 0.005)}$', 'Interpreter', 'latex');
grid on;
set(gcf, 'Position', [100, 100, 600, 400]);
set(gcf, 'PaperPositionMode', 'auto');
exportgraphics(gcf, 'q21.png', 'Resolution', 300);