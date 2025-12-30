function comPort = find_com(preferred)
%FIND_COM Find available COM port for STM32 connection
%   comPort = find_com() - Auto-detect COM port with UI selection
%   comPort = find_com('COM12') - Try preferred port first
%
%   Returns the COM port string (e.g., 'COM3') or empty if not found.

    if nargin < 1
        preferred = 'COM12';
    end

    comPort = '';
    ports = {};

    % Get available serial ports
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
