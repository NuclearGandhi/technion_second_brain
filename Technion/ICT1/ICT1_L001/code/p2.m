clc; clear; close all;

%% Part 2.1

disp('===== Part 2.1 =====');


K_m = 0.0242;
R = 2.15;
J = 0.0047;
f = 1.3439e-4;
n_g = 4.5;

k_s = n_g * K_m / (R * f + n_g^2 * K_m^2);
tau = R * J / (R * f + n_g^2 * K_m^2);

disp('k_s = '); disp(k_s);
disp('tau = '); disp(tau);

%% Part 2.2

disp('===== Part 2.2 =====');

k_p_values = [0.05, 0.36];
file_paths = {'q12/k_p_005/m1.mat', 'q12/k_p_036/m1.mat'};
titles = {'$k_p = 0.05$', '$k_p = 0.36$'};
file_names = {'q12_k_p_005', 'q12_k_p_036'};

for i = 1:length(k_p_values)
    % Load data from m1.mat
    fileData = load(file_paths{i});
    y = fileData.y.signals.values;
    u = fileData.u.signals.values;
    time = fileData.y.time;

    k_p = k_p_values(i);
    simulatedP = tf(k_s, [tau, 1, 0]);
    simulatedC = tf(k_p, 1);
    simulatedT = feedback(simulatedP * simulatedC, 1);
    simulatedTc = feedback(simulatedC, simulatedP);

    simulatedThetaResponse = step(simulatedT * 30, time);
    simulatedVoltageResponse = step(simulatedTc * 30, time);

    % Plot the measured step response for angle and voltage
    figure;
    subplot(1, 2, 1);
    plot(time, y);
    hold on;
    plot(time, simulatedThetaResponse);
    legend('Measured', 'Simulated');
    xlabel('$t$ (s)');
    ylabel('$y$ (deg)', 'Interpreter', 'latex');
    title(['Step Response (Angle) ', titles{i}], 'Interpreter', 'latex');
    grid on;

    subplot(1, 2, 2);
    plot(time, u);
    hold on;
    plot(time, simulatedVoltageResponse);
    legend('Measured', 'Simulated');
    xlabel('$t$ (s)');
    ylabel('$u$ (V)', 'Interpreter', 'latex');
    title(['Step Response (Voltage) ', titles{i}], 'Interpreter', 'latex');
    grid on;

    set(gcf, 'Position',  [100, 100, 1200, 400]);
    % exportgraphics(gcf, ['figs/', file_names{i}, '_combined.png'], 'Resolution', 300);

    stepinfo = stepinfo(y, time, 30);
    disp(['Step Info for ', titles{i}, ':']); disp(stepinfo);
end