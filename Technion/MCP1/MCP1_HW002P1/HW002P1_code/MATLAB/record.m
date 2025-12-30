function record()
    % RECORD - Record motor data and plot angular velocity vs time
    % Connects to the robot, triggers a square wave recording session,
    % retrieves the data, and plots angular velocity and voltage vs time.
    %
    % To regenerate plots later without the robot, use: plot_record()

    %% Configuration
    BAUD_RATE = 115200;
    NP = 1000; % Number of samples (must match firmware)
    SAMPLE_PERIOD = 0.01; % 10ms sample period (from TIM15 config: 50ms/5 = 10ms per sample)

    COUNTS_PER_REV = 1000; % Encoder counts per revolution
    PWM_MAX = 9999; % Maximum PWM value
    VOLTAGE_MAX = 12; % Motor voltage at max PWM

    %% Find and connect to COM port
    COM_PORT = find_com();

    if isempty(COM_PORT)
        error('No COM port selected. Exiting.');
    end

    % Clean up any existing connections
    try
        old_objs = serialportfind('Port', COM_PORT);

        if ~isempty(old_objs)
            delete(old_objs);
        end

    catch
    end

    % Connect
    s = serialport(COM_PORT, BAUD_RATE);
    configureTerminator(s, "CR/LF");
    s.Timeout = 30; % Long timeout for data transfer
    disp(['Connected to ' COM_PORT]);

    % Cleanup function
    cleanupObj = onCleanup(@() cleanup_serial(s));

    %% Start recording
    disp('Starting recording (square wave test)...');
    flush(s);
    writeline(s, 'state 3'); % STATE_SQUARE = 3

    % Read command echo
    pause(0.1);

    try
        echo = readline(s);
        disp(['Echo: ' char(echo)]);
    catch
    end

    % Wait for recording to complete (NP samples at ~10ms each = ~10 seconds)
    % Plus some margin for the square wave pattern
    record_time = NP * SAMPLE_PERIOD + 2;
    disp(sprintf('Waiting %.1f seconds for recording to complete...', record_time));
    pause(record_time);

    %% Request data
    disp('Requesting recorded data...');
    flush(s);
    writeline(s, 'send');

    % Read command echo
    pause(0.1);

    try
        echo = readline(s);
        disp(['Echo: ' char(echo)]);
    catch
    end

    % Read binary data: NP samples * 5 int16 values * 2 bytes = 10000 bytes
    expected_bytes = NP * 5 * 2;
    disp(sprintf('Reading %d bytes...', expected_bytes));

    try
        raw_data = read(s, expected_bytes, 'uint8');
    catch ME
        error('Failed to read data from device: %s', ME.message);
    end

    if length(raw_data) ~= expected_bytes
        error('Incomplete data received: got %d bytes, expected %d', length(raw_data), expected_bytes);
    end

    disp('Data received successfully.');

    % Read the "DONE" confirmation
    pause(0.5);

    try
        done_msg = readline(s);
        disp(['Response: ' char(done_msg)]);
    catch
    end

    %% Parse data
    % Data format: [PWM, Enc0, Enc1, Enc2, Enc3] as int16 for each sample
    data_int16 = typecast(uint8(raw_data), 'int16');
    data_matrix = reshape(data_int16, 5, NP)'; % NP x 5 matrix

    pwm_rec = double(data_matrix(:, 1)); % PWM value (same for all wheels in square test)
    enc = double(data_matrix(:, 2:5)); % Encoder values for 4 wheels

    %% Calculate angular velocity
    % Angular velocity = (encoder_diff / counts_per_rev) * 2*pi / sample_period [rad/s]
    % Or in RPM: (encoder_diff / counts_per_rev) * 60 / sample_period

    enc_diff = diff(enc); % Encoder differences between samples
    omega = (enc_diff / COUNTS_PER_REV) * 2 * pi / SAMPLE_PERIOD; % rad/s

    % Convert PWM to voltage
    voltage = (pwm_rec / PWM_MAX) * VOLTAGE_MAX;

    %% Create time vector
    t = (0:NP - 2)' * SAMPLE_PERIOD;

    %% Build data struct
    wheel_names = {'SE (Motor 1)', 'SW (Motor 2)', 'NW (Motor 3)', 'NE (Motor 4)'};
    record_data = struct( ...
        'time', t, ...
        'pwm', pwm_rec, ...
        'voltage', voltage, ...
        'encoder', enc, ...
        'omega', omega, ...
        'wheel_names', {wheel_names}, ...
        'sample_period', SAMPLE_PERIOD, ...
        'counts_per_rev', COUNTS_PER_REV);

    save('record_data.mat', 'record_data');
    disp('Data saved to: record_data.mat');

    %% Plot and save figures
    plot_record(record_data);

    %% Also save to workspace
    assignin('base', 'record_data', record_data);
    disp('Recording complete. Data also available in workspace as ''record_data''.');
end

function cleanup_serial(s)

    if ~isempty(s) && isvalid(s)
        delete(s);
        disp('Serial port closed.');
    end

end
