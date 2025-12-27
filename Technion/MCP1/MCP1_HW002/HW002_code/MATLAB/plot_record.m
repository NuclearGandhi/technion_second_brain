
function plot_record(filename)
    % PLOT_RECORD - Load recorded data and generate plots
    % Usage: plot_record()           - loads 'record_data.mat' from current folder
    %        plot_record('path.mat') - loads specified file

    if nargin < 1
        filename = 'record_data.mat';
    end

    %% Load data
    if ~isfile(filename)
        error('File not found: %s', filename);
    end

    data = load(filename);
    record_data = data.record_data;

    % Extract variables
    t = record_data.time;
    omega = record_data.omega;
    voltage = record_data.voltage;
    wheel_names = record_data.wheel_names;

    % voltage needs to match omega size (omega is from diff, so 1 fewer sample)
    voltage_diff = voltage(2:end);

    %% Plot results
    % Figure 1: Angular velocity vs Time for all wheels
    fig1 = figure('Name', 'Angular Velocity vs Time', 'NumberTitle', 'off');
    hold on;

    for i = 1:4
        plot(t, omega(:, i), 'DisplayName', wheel_names{i});
    end

    hold off;
    xlabel('Time [s]');
    ylabel('Angular Velocity [rad/s]');
    title('Angular Velocity vs Time');
    legend('Location', 'best');
    grid on;

    % Figure 2: Input Voltage vs Time
    fig2 = figure('Name', 'Input Voltage vs Time', 'NumberTitle', 'off');
    plot(t, voltage_diff, 'LineWidth', 1.5);
    xlabel('Time [s]');
    ylabel('Voltage [V]');
    title('Input Voltage vs Time');
    grid on;

    %% Save figures
    saveas(fig1, 'omega_vs_time.png');
    saveas(fig2, 'voltage_vs_time.png');
    disp('Figures saved to: omega_vs_time.png, voltage_vs_time.png');
end

