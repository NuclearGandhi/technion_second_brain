function ui()
    % Simple UI for Robot Control
    % COM port is automatically detected using find_com()

    current_state = 1;

    % --- Configuration ---
    COM_PORT = find_com(); % Automatically find COM port

    if isempty(COM_PORT)
        error('No COM port selected. Exiting.');
    end

    BAUD_RATE = 115200;

    % --- Serial Connection ---
    % Try to close existing connections to this port to avoid conflicts
    try
        old_objs = serialportfind('Port', COM_PORT);

        if ~isempty(old_objs)
            delete(old_objs);
        end

    catch
        % Ignore errors if serialportfind fails
    end

    s = [];

    try
        % Try using modern serialport (R2019b+)
        s = serialport(COM_PORT, BAUD_RATE);
        configureTerminator(s, "CR");
        disp(['Connected to ' COM_PORT ' using serialport.']);
    catch

        try
            % Fallback to legacy serial (older MATLAB)
            s = serial(COM_PORT, 'BaudRate', BAUD_RATE, 'Terminator', 'CR');
            fopen(s);
            disp(['Connected to ' COM_PORT ' using legacy serial.']);
        catch ME
            errordlg(['Failed to open serial port ' COM_PORT '. Check if it is correct and not in use.'], 'Serial Error');
            rethrow(ME);
        end

    end

    % --- UI Layout ---
    f = figure('Name', 'Robot Control', 'NumberTitle', 'off', ...
        'MenuBar', 'none', 'ToolBar', 'none', ...
        'Position', [300, 300, 400, 400], ...
        'CloseRequestFcn', @(src, event) closeApp(src, s));

    % Define button positions (Normalized units: 0 to 1)
    % Grid 3x3
    w = 0.33; h = 0.33;

    % Row 1 (Top)
    createButton(f, 'NW', [0 * w, 2 * h, w, h], @(~, ~) setMode(s, 5)); % MODE_NW = 5
    createButton(f, 'FORWARD', [1 * w, 2 * h, w, h], @(~, ~) setMode(s, 1)); % MODE_F = 1
    createButton(f, 'NE', [2 * w, 2 * h, w, h], @(~, ~) setMode(s, 7)); % MODE_NE = 7

    % Row 2 (Middle)
    createButton(f, 'CCW', [0 * w, 1 * h, w, h], @(~, ~) setMode(s, 4)); % MODE_CCW = 4
    createButton(f, 'IDLE', [1 * w, 1 * h, w, h], @(~, ~) setIdle(s)); % STATE_IDLE = 1
    createButton(f, 'CW', [2 * w, 1 * h, w, h], @(~, ~) setMode(s, 3)); % MODE_CW = 3

    % Row 3 (Bottom)
    createButton(f, 'SW', [0 * w, 0 * h, w, h], @(~, ~) setMode(s, 6)); % MODE_SW = 6
    createButton(f, 'BACK', [1 * w, 0 * h, w, h], @(~, ~) setMode(s, 2)); % MODE_B = 2
    createButton(f, 'SE', [2 * w, 0 * h, w, h], @(~, ~) setMode(s, 8)); % MODE_SE = 8

    % Nested functions follow

    function createButton(parent, label, pos, callback)
        uicontrol(parent, 'Style', 'pushbutton', 'String', label, ...
            'Units', 'normalized', 'Position', pos, ...
            'Callback', callback, 'FontSize', 14, 'FontWeight', 'bold');
    end

    function setMode(s, modeVal)
        % Protocol: "mode <val>" then "state 4" (DRIVE)
        if (current_state ~= 4)
            sendSerial(s, 'state 4');
            current_state = 4;
        end

        sendSerial(s, sprintf('mode %d', modeVal));
    end

    function setIdle(s)
        % Protocol: "state 1" (IDLE)
        sendSerial(s, 'state 1');
        current_state = 1;
    end

    function sendSerial(s, cmd)

        try

            if isobject(s) && isvalid(s)
                % Check type of serial object
                if isa(s, 'internal.Serialport') || isa(s, 'matlab.io.SerialPort')
                    writeline(s, cmd);
                else
                    fprintf(s, '%s', cmd); % Legacy serial appends terminator automatically
                end

                disp(['Sent: ' cmd]);
            else
                disp('Serial port not valid.');
            end

        catch
            disp(['Error sending: ' cmd]);
        end

    end

    function closeApp(fig, s)
        % Cleanup serial port
        if ~isempty(s) && isvalid(s)

            try

                if isa(s, 'internal.Serialport') || isa(s, 'matlab.io.SerialPort')
                    delete(s);
                else
                    fclose(s);
                    delete(s);
                end

            catch
                delete(s);
            end

        end

        delete(fig);
    end

end
