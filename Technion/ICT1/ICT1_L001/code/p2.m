clc; clear; close all;

%% Part 2.1

disp('===== Part 2.1 =====');


K_m = 0.0242;
R = 2.15;
J = 0.0047;
f = 0.0077;
n_g = 4.5;

k_s = n_g * K_m / (R * f + n_g^2 * K_m^2);
tau = R * J / (R * f + n_g^2 * K_m^2);

% Convert k to degrees
k_s = k_s * 180 / pi;

disp('k_s = '); disp(k_s);
disp('tau = '); disp(tau);

F = tf(30^2, [1, 1.6 * 30, 30^2]);

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

    simulatedT = feedback(simulatedP * simulatedC, 1) * F;
    simulatedTc = feedback(simulatedC, simulatedP) * F;

    simulatedThetaResponse = step(simulatedT * 30, time);
    simulatedVoltageResponse = step(simulatedTc * 30, time);

    % Calculate performance metrics
    steady_state_value = y(end);
    steady_state_error = abs(30 - steady_state_value);
    time_to_steady_state = time(find(y >= 0.98 * 30, 1));
    overshoot = (max(y) - 30) / 30 * 100;
    rise_time = time(find(y >= 0.9 * 30, 1)) - time(find(y >= 0.1 * 30, 1));
    settling_time = time(find(abs(y - 30) <= 0.02 * 30, 1, 'last'));
    max_input_voltage = max(u);

    % Display performance metrics
    disp(['Performance Metrics for ', titles{i}, ':']);
    disp(['Steady-State Error: ', num2str(steady_state_error)]);
    disp(['Settling Time: ', num2str(settling_time)]);
    disp(['Overshoot: ', num2str(overshoot), '%']);
    disp(['Rise Time: ', num2str(rise_time)]);
    disp(['Max Input Voltage: ', num2str(max_input_voltage)]);

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

    step_info = stepinfo(y, time, 30);
    disp(['Step Info for ', titles{i}, ':']); disp(step_info);
end

k_p = 0.05;
zeta = (1 / 2) * sqrt(1 / (R * J * n_g * K_m * k_p)) * (R * f + n_g^2 * K_m * K_m);
disp('zeta: '); disp(zeta);
k_p = 0.36;
zeta = (1 / 2) * sqrt(1 / (R * J * n_g * K_m * k_p)) * (R * f + n_g^2 * K_m * K_m);
disp('zeta: '); disp(zeta);


%% Part 2.3
disp('===== Part 2.3 =====');

max_stable_k_i = (R * f + n_g^2 * K_m^2) / (R * J);
disp('Max Stable k_i: '); disp(max_stable_k_i);

k_i_values = [0.1, 1.1];
k_p = 0.36;
file_paths = {'q18/k_i_01/m1.mat', 'q18/k_i_11/m1.mat'};
titles = {'$k_i = 0.1$', '$k_i = 1.1$'};
file_names = {'q18_k_i_01', 'q18_k_i_11'};

for i = 1:length(k_i_values)
    k_i = k_i_values(i);
    % Load data from m1.mat
    fileData = load(file_paths{i});
    y = fileData.y.signals.values;
    u = fileData.u.signals.values;
    time = fileData.y.time;

    simulatedP = tf(k_s, [tau, 1, 0]);
    simulatedC = tf([k_p, k_p * k_i], [1, 0]);  % PI controller

    simulatedT = feedback(simulatedP * simulatedC, 1) * F;
    simulatedTc = feedback(simulatedC, simulatedP) * F;
    
    simulatedThetaResponse = step(simulatedT * 30, time);
    simulatedVoltageResponse = step(simulatedTc * 30, time);

    % Calculate performance metrics
    steady_state_value = y(end);
    steady_state_error = abs(30 - steady_state_value);
    overshoot = (max(y) - 30) / 30 * 100;
    rise_time = time(find(y >= 0.9 * 30, 1)) - time(find(y >= 0.1 * 30, 1));
    settling_time = time(find(abs(y - 30) <= 0.02 * 30, 1, 'last'));
    max_input_voltage = max(u);

    % Display performance metrics
    disp(['Performance Metrics for ', titles{i}, ':']);
    disp(['Steady-State Error: ', num2str(steady_state_error)]);
    disp(['Time to Reach Steady State: ', num2str(settling_time)]);
    disp(['Overshoot: ', num2str(overshoot), '%']);
    disp(['Rise Time: ', num2str(rise_time)]);
    disp(['Settling Time: ', num2str(settling_time)]);
    disp(['Max Input Voltage: ', num2str(max_input_voltage)]);

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

    step_info = stepinfo(y, time, 30);
    disp(['Step Info for ', titles{i}, ':']); disp(step_info);
end