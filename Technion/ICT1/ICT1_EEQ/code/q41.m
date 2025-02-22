clc; clear; close all;

a1=4;
a2=2;
sys = zpk([-1/sqrt(2)+1/sqrt(2)*1i, -1/sqrt(2)-1/sqrt(2)*1i], [0,0,0,-a1,-a2], 1);
display(sys);
rlocusplot(sys);

title('Root locus for $G(s) = \frac{s^2+\sqrt{2}s+1}{s^3(s+4)(s+2)}$', 'Interpreter', 'latex');
grid on; xlim([-6, 1]); ylim([-2, 2]);
set(gcf, 'Position', [100, 100, 600, 400]);
exportgraphics(gcf, 'q41.png', 'Resolution', 300);