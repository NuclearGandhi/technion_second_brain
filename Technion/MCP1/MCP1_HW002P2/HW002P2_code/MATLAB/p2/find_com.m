function comPort = find_com(preferred)
    %FIND_COM Find available COM port for STM32 connection
    %   comPort = find_com() - Auto-detect COM port with UI selection
    %   comPort = find_com('COM12') - Try preferred port first
    %
    %   This function also cleans up any existing serial connections
    %   to prevent "port already in use" errors.
    %
    %   Returns the COM port string (e.g., 'COM3') or empty if not found.

    if nargin < 1
        preferred = 'COM13';
    end

    comPort = '';

    % Clean up ALL existing serial connections first
    % This ensures re-running scripts works even if the previous run was interrupted
    cleanup_serial_connections();

    % Get available serial ports
    ports = {};

    try
        portList = serialportlist("available");

        if ~isempty(portList)
            ports = cellstr(portList);
        end

    catch
        % serialportlist not available
    end

    % Handle results
    if isempty(ports)
        warndlg('No COM ports found. Please check your device connection.', 'COM Port');
        return;
    end

    fprintf('Available ports: %s\n', strjoin(ports, ', '));

    % Check preferred port first
    if ~isempty(preferred) && any(strcmp(ports, preferred))
        comPort = preferred;
        fprintf('Using preferred port: %s\n', comPort);
        return;
    end

    % Single port - use it directly
    if numel(ports) == 1
        comPort = ports{1};
        fprintf('Found single COM port: %s\n', comPort);
        return;
    end

    % Multiple ports - let user select via UI
    disp('Available COM ports:');

    for i = 1:numel(ports)
        fprintf('  [%d] %s\n', i, ports{i});
    end

    [selection, ok] = listdlg('ListString', ports, ...
        'SelectionMode', 'single', ...
        'Name', 'Select COM Port', ...
        'PromptString', 'Multiple COM ports detected. Select one:', ...
        'ListSize', [200, 100]);

    if ok && ~isempty(selection)
        comPort = ports{selection};
        fprintf('Selected COM port: %s\n', comPort);
    else
        disp('No COM port selected.');
    end

end

function cleanup_serial_connections()
    %CLEANUP_SERIAL_CONNECTIONS Close all existing serial port connections
    %   This helper function closes any open serial connections to prevent
    %   "port already in use" errors when re-running scripts.

    try
        all_ports = serialportfind();

        if ~isempty(all_ports)
            fprintf('Closing %d existing serial connection(s)...\n', numel(all_ports));
            delete(all_ports);
            pause(0.3);
        end

    catch
        % Fallback: try instrfindall for older MATLAB versions
        try
            old_serial = instrfindall; %#ok<INSTRFINDALL>

            if ~isempty(old_serial)
                fclose(old_serial);
                delete(old_serial);
                pause(0.3);
            end

        catch
        end

    end

end
