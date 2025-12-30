%% kinematics_gui.m
% Real-time Kinematics Control GUI for Mecanum Cart
% MCP1 Lab 2 Part 2 - Assignment 2
%
% This GUI allows real-time control of the cart's kinematics:
% - vx: Forward/backward velocity (m/s)
% - vy: Left/right velocity (m/s)
% - wz: Rotation rate (rad/s)
%
% Usage:
%   1. Connect STM32 to PC via USB
%   2. Run this script
%   3. Use sliders or buttons to control the cart
%   4. The cart must be in STATE_KINEMATICS (mode 6) to respond

function kinematics_gui()
    %% Configuration
    BAUD_RATE = 115200;
    
    % Velocity limits
    VX_MAX = 0.3;    % m/s
    VY_MAX = 0.3;    % m/s
    WZ_MAX = 2.0;    % rad/s
    
    %% Create Serial Connection
    port = find_com();
    if isempty(port)
        error('No COM port found. Connect STM32 and try again.');
    end
    
    % Clean up any existing connections
    try
        old_objs = serialportfind('Port', port);
        if ~isempty(old_objs)
            delete(old_objs);
            pause(0.5);
        end
    catch
    end
    
    try
        s = serialport(port, BAUD_RATE);
        configureTerminator(s, "CR/LF");
        s.Timeout = 5;
        fprintf('Connected to %s\n', port);
    catch ME
        error('Failed to connect to %s: %s', port, ME.message);
    end
    
    %% Create GUI
    fig = figure('Name', 'Mecanum Cart Kinematics Control', ...
                 'NumberTitle', 'off', ...
                 'Position', [100, 100, 600, 500], ...
                 'Color', [0.94, 0.94, 0.94], ...
                 'CloseRequestFcn', @close_gui);
    
    % Current values
    vx = 0; vy = 0; wz = 0;
    
    %% Title
    uicontrol('Style', 'text', ...
              'String', 'Mecanum Cart Kinematics Control', ...
              'Position', [150, 460, 300, 30], ...
              'FontSize', 14, 'FontWeight', 'bold', ...
              'BackgroundColor', [0.94, 0.94, 0.94]);
    
    %% Vx Slider (Forward/Backward)
    uicontrol('Style', 'text', 'String', 'Vx (Forward/Back) [m/s]:', ...
              'Position', [30, 400, 180, 20], 'HorizontalAlignment', 'left', ...
              'BackgroundColor', [0.94, 0.94, 0.94]);
    
    slider_vx = uicontrol('Style', 'slider', ...
                          'Min', -VX_MAX, 'Max', VX_MAX, 'Value', 0, ...
                          'Position', [30, 370, 400, 25], ...
                          'Callback', @slider_callback);
    
    text_vx = uicontrol('Style', 'text', 'String', '0.000', ...
                        'Position', [440, 370, 80, 25], ...
                        'BackgroundColor', 'white', 'FontSize', 12);
    
    %% Vy Slider (Left/Right)
    uicontrol('Style', 'text', 'String', 'Vy (Left/Right) [m/s]:', ...
              'Position', [30, 320, 180, 20], 'HorizontalAlignment', 'left', ...
              'BackgroundColor', [0.94, 0.94, 0.94]);
    
    slider_vy = uicontrol('Style', 'slider', ...
                          'Min', -VY_MAX, 'Max', VY_MAX, 'Value', 0, ...
                          'Position', [30, 290, 400, 25], ...
                          'Callback', @slider_callback);
    
    text_vy = uicontrol('Style', 'text', 'String', '0.000', ...
                        'Position', [440, 290, 80, 25], ...
                        'BackgroundColor', 'white', 'FontSize', 12);
    
    %% Wz Slider (Rotation)
    uicontrol('Style', 'text', 'String', 'Wz (Rotation) [rad/s]:', ...
              'Position', [30, 240, 180, 20], 'HorizontalAlignment', 'left', ...
              'BackgroundColor', [0.94, 0.94, 0.94]);
    
    slider_wz = uicontrol('Style', 'slider', ...
                          'Min', -WZ_MAX, 'Max', WZ_MAX, 'Value', 0, ...
                          'Position', [30, 210, 400, 25], ...
                          'Callback', @slider_callback);
    
    text_wz = uicontrol('Style', 'text', 'String', '0.000', ...
                        'Position', [440, 210, 80, 25], ...
                        'BackgroundColor', 'white', 'FontSize', 12);
    
    %% Quick Action Buttons
    uicontrol('Style', 'text', 'String', 'Quick Actions:', ...
              'Position', [30, 170, 100, 20], 'HorizontalAlignment', 'left', ...
              'BackgroundColor', [0.94, 0.94, 0.94], 'FontWeight', 'bold');
    
    % Row 1: Linear motions
    btn_width = 80;
    btn_height = 40;
    btn_y1 = 120;
    btn_y2 = 70;
    btn_y3 = 20;
    
    uicontrol('Style', 'pushbutton', 'String', 'Forward', ...
              'Position', [140, btn_y1, btn_width, btn_height], ...
              'Callback', @(~,~) set_vel(VX_MAX, 0, 0));
    
    uicontrol('Style', 'pushbutton', 'String', 'Backward', ...
              'Position', [140, btn_y2, btn_width, btn_height], ...
              'Callback', @(~,~) set_vel(-VX_MAX, 0, 0));
    
    uicontrol('Style', 'pushbutton', 'String', 'Left', ...
              'Position', [50, btn_y2, btn_width, btn_height], ...
              'Callback', @(~,~) set_vel(0, VY_MAX, 0));
    
    uicontrol('Style', 'pushbutton', 'String', 'Right', ...
              'Position', [230, btn_y2, btn_width, btn_height], ...
              'Callback', @(~,~) set_vel(0, -VY_MAX, 0));
    
    % Row 2: Rotation
    uicontrol('Style', 'pushbutton', 'String', 'CCW', ...
              'Position', [320, btn_y1, btn_width, btn_height], ...
              'Callback', @(~,~) set_vel(0, 0, WZ_MAX));
    
    uicontrol('Style', 'pushbutton', 'String', 'CW', ...
              'Position', [320, btn_y2, btn_width, btn_height], ...
              'Callback', @(~,~) set_vel(0, 0, -WZ_MAX));
    
    % Row 3: Combined and Stop
    uicontrol('Style', 'pushbutton', 'String', 'Fwd+CW', ...
              'Position', [410, btn_y1, btn_width, btn_height], ...
              'Callback', @(~,~) set_vel(VX_MAX, 0, -WZ_MAX/2));
    
    uicontrol('Style', 'pushbutton', 'String', 'Fwd+Lat', ...
              'Position', [410, btn_y2, btn_width, btn_height], ...
              'Callback', @(~,~) set_vel(VX_MAX, VY_MAX/2, 0));
    
    uicontrol('Style', 'pushbutton', 'String', 'STOP', ...
              'Position', [500, btn_y2, btn_width, btn_height], ...
              'BackgroundColor', [1, 0.3, 0.3], ...
              'FontWeight', 'bold', 'FontSize', 12, ...
              'Callback', @(~,~) set_vel(0, 0, 0));
    
    %% Status Panel
    uicontrol('Style', 'text', 'String', 'Status:', ...
              'Position', [30, btn_y3, 60, 20], 'HorizontalAlignment', 'left', ...
              'BackgroundColor', [0.94, 0.94, 0.94], 'FontWeight', 'bold');
    
    status_text = uicontrol('Style', 'text', 'String', 'Connected to ' + string(port), ...
                            'Position', [90, btn_y3, 400, 20], 'HorizontalAlignment', 'left', ...
                            'BackgroundColor', [0.94, 0.94, 0.94]);
    
    %% Initialize STM32 to Kinematics Mode
    pause(0.5);
    flush(s);
    writeline(s, 'state 6');  % STATE_KINEMATICS
    pause(0.1);
    set(status_text, 'String', 'Connected - Mode: Kinematics');
    
    %% Callback Functions
    function slider_callback(~, ~)
        vx = get(slider_vx, 'Value');
        vy = get(slider_vy, 'Value');
        wz = get(slider_wz, 'Value');
        
        set(text_vx, 'String', sprintf('%.3f', vx));
        set(text_vy, 'String', sprintf('%.3f', vy));
        set(text_wz, 'String', sprintf('%.3f', wz));
        
        send_velocity();
    end
    
    function set_vel(new_vx, new_vy, new_wz)
        vx = new_vx;
        vy = new_vy;
        wz = new_wz;
        
        set(slider_vx, 'Value', vx);
        set(slider_vy, 'Value', vy);
        set(slider_wz, 'Value', wz);
        
        set(text_vx, 'String', sprintf('%.3f', vx));
        set(text_vy, 'String', sprintf('%.3f', vy));
        set(text_wz, 'String', sprintf('%.3f', wz));
        
        send_velocity();
    end
    
    function send_velocity()
        try
            vx
            vy
            wz
            cmd = sprintf('vel %.4f %.4f %.4f', vx, vy, wz);
            cmd
            flush(s);
            writeline(s, cmd);
            set(status_text, 'String', sprintf('Sent: vx=%.3f vy=%.3f wz=%.3f', vx, vy, wz));
        catch ME
            set(status_text, 'String', ['Error: ', ME.message]);
        end
    end
    
    function close_gui(~, ~)
        % Stop cart before closing
        try
            writeline(s, 'vel 0 0 0');
            pause(0.1);
            writeline(s, 'state 1');  % STATE_IDLE
            pause(0.1);
        catch
        end
        
        % Properly close serial port
        if ~isempty(s) && isvalid(s)
            delete(s);
        end
        
        delete(fig);
    end
    
    % Wait for figure to close
    waitfor(fig);
end
