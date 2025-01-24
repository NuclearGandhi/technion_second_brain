clc; clear; close all;
K_m = 0.0242;
R = 2.15;
J = 0.0047;
f = 0.004;
n_g = 4.85;
k_i = 3;

sys = @(k_i) tf([n_g*K_m, k_i*n_g*K_m], [R*J, R*f+n_g^2*K_m*K_m, 0, 0]);

figure;
subplot(2,2,1);
rlocusplot(sys(k_i));
title('Root Locus Plot $k_p > 0$ and $k_i > |p_3|$', 'Interpreter', 'latex');
grid on;

subplot(2,2,2);
rlocusplot(-sys(k_i));
title('Root Locus Plot $k_p < 0$ and $k_i > |p_3|$', 'Interpreter', 'latex');
grid on;

k_i = 0.5;
subplot(2,2,3);
rlocusplot(sys(k_i));
title('Root Locus Plot $k_p > 0$ and $0 < k_i < |p_3|$', 'Interpreter', 'latex');
grid on;

subplot(2,2,4);
rlocusplot(-sys(k_i));
title('Root Locus Plot $k_p < 0$ and $0 < k_i < |p_3|$', 'Interpreter', 'latex');
grid on;
set(findall(gcf,'type','line'),'linewidth',2);

set(gcf, 'Position',  [100, 100, 1000, 800]);
exportgraphics(gcf, 'figs/q5_1.png', 'Resolution', 300);

% Part d
figure;
K_m = 0.0242;
R = 2.15;
J = 0.0047;
f = 0.004;
n_g = 4.85;

% Define the plant P_theta(s)
P_theta = tf(n_g*K_m, [R*J, R*f+n_g^2*K_m*K_m, 0]);

% Define the controller C(s)
kp_values = linspace(0.1, 10, 1000); % Range of kp values to test
ki = 0.01;

best_kp = 0;
best_ki = 0;
best_overshoot = Inf;
best_settling_time = Inf;

for kp = kp_values
    C = tf([kp, kp*ki], [1, 0]);
    T = feedback(C*P_theta, 1);
    info = stepinfo(T);
        
    if info.Overshoot < 15 && info.SettlingTime < 3
        if info.SettlingTime < best_settling_time
            best_kp = kp;
            best_ki = ki;
            best_overshoot = info.Overshoot;
            best_settling_time = info.SettlingTime;
        end
    end
end

% Display the best kp and ki values
disp(['Best kp: ', num2str(best_kp)]);
disp(['Best ki: ', num2str(best_ki)]);
disp(['Best Overshoot: ', num2str(best_overshoot)]);
disp(['Best Settling Time: ', num2str(best_settling_time)]);

% Plot the step response with the best kp and ki values
C = tf([best_kp, best_kp*best_ki], [1, 0]);
T = feedback(C*P_theta, 1);
info = stepinfo(T);

figure;
step(T);
% Show the info on the plot
text(info.SettlingTime/2, info.Peak-0.2, ['Overshoot: ', num2str(info.Overshoot), '%']);
text(info.SettlingTime, info.Peak*0.75, ['Settling Time: ', num2str(info.SettlingTime), 's']);
title('Step Response of T(s)');
grid on;
set(gcf, 'Position',  [100, 100, 600, 400]);
set(findall(gcf,'type','line'),'linewidth',2);
exportgraphics(gcf, 'figs/q5_2.png', 'Resolution', 300);