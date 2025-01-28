%% Part a

clc; clear; close all;

K_m = 0.0242;
R = 2.15;
J = 0.0047;
f = 0.004;
n_g = 4.85;

sys = tf(1, [R*J, n_g^2*K_m*K_m+R*f, 0]);

plot1 = rlocusplot(sys);
title('Root Locus Plot $k_p > 0$', 'Interpreter', 'latex');
set(gcf, 'Position',  [100, 100, 600, 400]);
grid on;
set(findall(gca,'type','line'),'linewidth',2);
exportgraphics(gcf, 'figs/q4_1.png', 'Resolution', 300);

figure;
plot2 = rlocusplot(-sys);
title('Root Locus Plot $k_p < 0$', 'Interpreter', 'latex');
grid on;
set(gcf, 'Position',  [100, 100, 600, 400]);
set(findall(gca,'type','line'),'linewidth',2);
exportgraphics(gcf, 'figs/q4_2.png', 'Resolution', 300);

%% Part e

k_p = 1;

zeta = 0.5 * sqrt(1 / (R * J * n_g * K_m * k_p)) * (R * f + (n_g^2 * K_m^2));
OS = exp((-pi * zeta) / sqrt(1 - zeta^2));

fprintf('zeta for k_p = 1: %.5f\n', zeta);
fprintf('Overshoot for k_p >= 1: %.5f%%\n', OS * 100);