clc; clear; close all;

sys = tf([1,3,3,1], [1,0,0,0]);
display(sys);
rlocusplot(sys);

title('Root locus for $G(s) = \frac{s^3 + 3s^2 + 3s + 1}{s^3}$', 'Interpreter', 'latex');
grid on; xlim([-6, 1]); ylim([-2, 2]);
set(gcf, 'Position', [100, 100, 600, 400]);
exportgraphics(gcf, 'q42.png', 'Resolution', 300);