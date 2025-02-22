clc; clear; close all;

sys = zpk([], [-1,-1,-1,-1,-1,-1], 1);
display(sys);
rlocusplot(sys);

title('Root locus for $G(s) = \frac{1}{(s+1)^6}$', 'Interpreter', 'latex');
grid on; xlim([-6, 1]); ylim([-2, 2]);
set(gcf, 'Position', [100, 100, 600, 400]);
exportgraphics(gcf, 'q43.png', 'Resolution', 300);