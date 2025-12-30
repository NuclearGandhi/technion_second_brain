function comPort = find_com()
    % FIND_COM Automatically finds available COM ports
    % Returns the first available COM port, or prompts user to select if multiple exist.
    % Returns empty string if no ports are found.

    comPort = '';
    ports = {};

    % Try modern serialportlist (R2019b+)
    try
        portList = serialportlist("available");

        if ~isempty(portList)
            ports = cellstr(portList);
        end

    catch
        % serialportlist not available, ports remains empty
    end

    % Handle results
    if isempty(ports)
        warndlg('No COM ports found. Please check your device connection.', 'COM Port');
        return;
    elseif numel(ports) == 1
        comPort = ports{1};
        disp(['Found single COM port: ' comPort]);
    else
        % Multiple ports found - let user select
        disp('Available COM ports:');

        for i = 1:numel(ports)
            fprintf('  [%d] %s\n', i, ports{i});
        end

        % Create selection dialog
        [selection, ok] = listdlg('ListString', ports, ...
            'SelectionMode', 'single', ...
            'Name', 'Select COM Port', ...
            'PromptString', 'Multiple COM ports detected. Select one:', ...
            'ListSize', [200, 100]);

        if ok && ~isempty(selection)
            comPort = ports{selection};
            disp(['Selected COM port: ' comPort]);
        else
            disp('No COM port selected.');
        end

    end

end
