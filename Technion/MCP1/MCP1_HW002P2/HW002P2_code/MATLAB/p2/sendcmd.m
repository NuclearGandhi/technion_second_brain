function response = sendcmd(s, cmd, varargin)
%SENDCMD Send command to STM32 via serial port
%   response = sendcmd(s, cmd) - Send simple command
%   response = sendcmd(s, cmd, arg1, arg2, ...) - Send command with arguments
%
%   Inputs:
%       s    - Serial port object
%       cmd  - Command string (e.g., 'state', 'vel', 'pwm')
%       args - Optional numeric or string arguments
%
%   Output:
%       response - Response string from STM32
%
%   Examples:
%       sendcmd(s, 'state', 5)           % Set state to 5
%       sendcmd(s, 'vel', 0.1, 0, 0.5)   % Set velocity vx=0.1, vy=0, wz=0.5
%       sendcmd(s, 'pwm', 3000, 3000, 3000, 3000)  % Set PWM values

    % Build command string
    if nargin > 2
        args_str = '';
        for i = 1:length(varargin)
            if isnumeric(varargin{i})
                args_str = [args_str, ' ', num2str(varargin{i}, '%.4f')];
            else
                args_str = [args_str, ' ', char(varargin{i})];
            end
        end
        full_cmd = [cmd, args_str];
    else
        full_cmd = cmd;
    end
    
    % Flush before sending
    flush(s);
    
    % Send command
    writeline(s, full_cmd);
    
    % Wait for response
    pause(0.1);
    
    response = '';
    try
        if s.NumBytesAvailable > 0
            response = readline(s);
            fprintf('%s\n', response);
        end
    catch
        % Timeout or error reading
    end
end
