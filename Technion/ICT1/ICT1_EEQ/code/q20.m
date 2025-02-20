clc; clear; close all;

sys = tf([0.62], [1,0.62]);
display(sys);
bodemag(sys);
title('Bode plot for G(s) = $\frac{0.62}{(s + 0.62)}$', 'Interpreter', 'latex');
grid on;
set(gcf, 'Position', [100, 100, 600, 400]);
set(gcf, 'PaperPositionMode', 'auto');
exportgraphics(gcf, 'q20.png', 'Resolution', 300);