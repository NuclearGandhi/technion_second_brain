function animate_simulation()
    % ANIMATE_SIMULATION Animate the results of the wave-board simulation
    % utilizing hgtransform for efficient rendering.
    
    %% 1. Load Data
    res_file = 'simulation_results.mat';
    if ~isfile(res_file)
        error('File %s not found. Run run_simulation.m first.', res_file);
    end
    data = load(res_file);
    
    t = data.t;
    q = data.q; % [x; y; theta; phi1; phi2; psi]
    p = data.params;
    
    % Resample for constant frame rate
    fps = 30;
    t_end = t(end);
    dt_frame = 1/fps;
    t_anim = 0:dt_frame:t_end;
    
    q_anim = interp1(t, q.', t_anim).';
    
    x = q_anim(1, :);
    y = q_anim(2, :);
    theta = q_anim(3, :);
    phi1 = q_anim(4, :);
    phi2 = q_anim(5, :);
    psi = q_anim(6, :);
    
    %% 2. Setup Figure
    hf = figure('Name', 'Wave-Board Animation', 'Color', 'w');
    ax = axes('Parent', hf, 'DataAspectRatio', [1 1 1]);
    hold(ax, 'on');
    grid(ax, 'on');
    xlabel(ax, 'X [m]');
    ylabel(ax, 'Y [m]');
    
    % Set axis limits (dynamic update or fixed?)
    % Let's start with fixed reasonable limits or update in loop
    axis(ax, 'equal');
    xlim(ax, [-1 1]);
    ylim(ax, [-1 1]);
    
    %% 3. Create Graphics Objects with hgtransform
    
    % -- Group 1: Main Platform Transform (Body Frame) --
    % Controls position (x,y) and orientation (theta) of the whole board
    t_body = hgtransform('Parent', ax);
    
    % Draw Platform (Main Board)
    % Represented as a long rectangle of length 2b and some width
    L_board = 2 * p.b + 0.1; % slightly larger than distance between axles
    W_board = 0.15;
    
    % Board shape centered at C
    x_b = [-L_board/2, L_board/2, L_board/2, -L_board/2];
    y_b = [-W_board/2, -W_board/2, W_board/2, W_board/2];
    
    patch('XData', x_b, 'YData', y_b, 'FaceColor', [0.8 0.8 0.8], ...
          'EdgeColor', 'k', 'Parent', t_body, 'DisplayName', 'Platform');
      
    % -- Group 2: Rider (Relative to Body) --
    % Rotates by psi relative to body at C
    t_rider = hgtransform('Parent', t_body);
    
    % Rider shape (e.g., a triangle or ellipse indicating twist)
    % Let's make a distinctive shape to see the twist
    rider_len = 0.2;
    rider_width = 0.05;
    patch('XData', [-rider_width, rider_width, rider_width, -rider_width], ...
          'YData', [-rider_len/2, -rider_len/2, rider_len/2, rider_len/2], ...
          'FaceColor', [0.2 0.6 1.0], 'Parent', t_rider, 'DisplayName', 'Rider');
      
    % -- Group 3: Wheel 1 (Rear? at -b) --
    % Parent is Body. Local transform: Translate to -b, Rotate phi1
    t_arm1 = hgtransform('Parent', t_body);
    
    % Arm geometry: Line from hinge (0,0 in local) to axle
    % The arm definition in derive_equations was: axle at [-d*cos(phi), -d*sin(phi)]
    % This means the arm vector is [-d, 0] in the ARM frame (if rotated by phi)
    % So we draw arm from (0,0) to (-d, 0)
    
    % Arm Graphic
    line([0, -p.d], [0, 0], 'Color', 'k', 'LineWidth', 2, 'Parent', t_arm1);
    
    % Wheel Graphic at end of arm (-d, 0)
    % Wheel is perpendicular to arm? 
    % Constraint: no slip perpendicular to arm.
    % So wheel rolls along arm. Wheel plane is parallel to arm.
    % Draw a rectangle representing the wheel at (-d, 0)
    w_len = 0.08; 
    w_thk = 0.02;
    patch('XData', -p.d + [-w_len/2, w_len/2, w_len/2, -w_len/2], ...
          'YData', [-w_thk/2, -w_thk/2, w_thk/2, w_thk/2], ...
          'FaceColor', 'k', 'Parent', t_arm1);
    
    % -- Group 4: Wheel 2 (Front? at +b) --
    t_arm2 = hgtransform('Parent', t_body);
    
    % Same geometry as arm 1
    line([0, -p.d], [0, 0], 'Color', 'k', 'LineWidth', 2, 'Parent', t_arm2);
    patch('XData', -p.d + [-w_len/2, w_len/2, w_len/2, -w_len/2], ...
          'YData', [-w_thk/2, -w_thk/2, w_thk/2, w_thk/2], ...
          'FaceColor', 'k', 'Parent', t_arm2);
    
    % Trace for Center of Mass
    h_trace = plot(x(1), y(1), 'r-', 'LineWidth', 1, 'Parent', ax);
    
    
    %% 4. Animation Loop
    fprintf('Starting animation... Press Ctrl+C to stop.\n');
    
    % Initial Hinge Transforms (constant translation part)
    % Hinge 1 is at [-b, 0] in body frame
    % Hinge 2 is at [ b, 0] in body frame
    
    for i = 1:length(t_anim)
        if ~isvalid(hf), break; end
        
        % Update State
        xi = x(i);
        yi = y(i);
        thetai = theta(i);
        phi1i = phi1(i);
        phi2i = phi2(i);
        psii = psi(i);
        
        % 1. Body Transform
        % Translate to (x,y), then Rotate theta
        M_body = makehgtform('translate', [xi, yi, 0]) * makehgtform('zrotate', thetai);
        set(t_body, 'Matrix', M_body);
        
        % 2. Rider Transform
        % Relative to body: just rotate psi
        M_rider = makehgtform('zrotate', psii);
        set(t_rider, 'Matrix', M_rider);
        
        % 3. Arm 1 Transform
        % Relative to body: Translate to [-b, 0], then Rotate phi1
        M_arm1 = makehgtform('translate', [-p.b, 0, 0]) * makehgtform('zrotate', phi1i);
        set(t_arm1, 'Matrix', M_arm1);
        
        % 4. Arm 2 Transform
        % Relative to body: Translate to [b, 0], then Rotate phi2
        M_arm2 = makehgtform('translate', [p.b, 0, 0]) * makehgtform('zrotate', phi2i);
        set(t_arm2, 'Matrix', M_arm2);
        
        % Update Camera / Limits to follow board
        xlim(ax, [xi - 1, xi + 1]);
        ylim(ax, [yi - 1, yi + 1]);
        
        % Update Trace
        set(h_trace, 'XData', x(1:i), 'YData', y(1:i));
        
        title(ax, sprintf('Time: %.2f s', t_anim(i)));
        drawnow;
        
        % Pause to maintain real-time speed roughly
        % (drawnow takes time, so this is approximate)
        % pause(dt_frame/2); 
    end
end

