function animate_compass_biped()
    %% Compass Biped Animation
    % Run compass_biped_symbolic.m first to generate required functions.

    close all; clc;

    %% Parameters
    params.m = 4;
    params.m_h = 1.8;
    params.I_c = 0;
    params.l = 0.8;
    params.g = 10;
    params.alpha = deg2rad(1);
    params.mu = 0.3;

    T_max = 10;
    max_steps = 50;

    %% Initial Conditions
    theta1_0 = -0.166539;
    theta2_0 = -0.166539;
    theta1_dot_0 = 0.803329;
    theta2_dot_0 = -0.44;
    X0 = [theta1_0; theta2_0; theta1_dot_0; theta2_dot_0];

    y_swing_0 = 2*params.l*(cos(theta1_0) - cos(theta2_0));
    fprintf('Initial swing foot height: %.3f m\n', y_swing_0);

    %% Simulate
    fprintf('=== Running Simulation ===\n');
    fprintf('theta1 = %.1f deg, theta2 = %.1f deg\n', rad2deg(theta1_0), rad2deg(theta2_0));

    physics = biped_physics();
    [T_seg, X_seg, x_stance_seg, swap_count_seg] = physics.simulate(X0, T_max, max_steps, params);

    fprintf('Complete: %.2f s, %d segments\n', T_seg{end}(end), length(T_seg));

    %% Animate (and save to videos folder)
    video_dir = fullfile(fileparts(mfilename('fullpath')), 'videos');
    animate(T_seg, X_seg, x_stance_seg, swap_count_seg, params, video_dir);
end


function animate(T_seg, X_seg, x_stance_seg, swap_count_seg, params, video_dir)
    l = params.l;
    alpha = params.alpha;

    %% Compute view bounds from full trajectory
    x_all = [];
    for seg = 1:length(T_seg)
        x_st = x_stance_seg{seg};
        X = X_seg{seg};
        for i = 1:length(x_st)
            x_hip = x_st(i) + 2*l*sin(X(i,1));
            x_all = [x_all; x_hip];
        end
    end
    x_min = min(x_all) - 3*l;
    x_max = max(x_all) + 3*l;

    %% Setup Figure
    fig = figure('Position', [100, 100, 1200, 600], 'Color', 'w');
    ax = axes('Parent', fig);
    hold(ax, 'on'); axis(ax, 'equal'); grid(ax, 'on');

    xlabel(ax, '$x$ [m]', 'Interpreter', 'latex');
    ylabel(ax, '$y$ [m]', 'Interpreter', 'latex');
    title(ax, 'Compass Biped', 'Interpreter', 'latex');

    %% Ground (fixed view)
    [xw_min, ~] = slope_to_world(x_min, 0, alpha);
    [xw_max, ~] = slope_to_world(x_max, 0, alpha);
    ground_x = linspace(xw_min - 2*l, xw_max + 2*l, 200);
    ground_y = -ground_x * tan(alpha);
    plot(ax, ground_x, ground_y, 'k-', 'LineWidth', 2);
    fill(ax, [ground_x, fliplr(ground_x)], [ground_y, -2*ones(size(ground_y))], ...
        [0.8 0.8 0.8], 'EdgeColor', 'none');

    %% Fixed axis limits
    xlim(ax, [xw_min, xw_max]);
    ylim(ax, [-l, 4*l]);

    %% Graphics Objects (Leg A = blue, Leg B = orange)
    color_A = [0, 0.4470, 0.7410];
    color_B = [0.8500, 0.3250, 0.0980];

    leg_A = line('Parent', ax, 'XData', [0 0], 'YData', [0 2*l], 'Color', color_A, 'LineWidth', 4);
    leg_B = line('Parent', ax, 'XData', [0 0], 'YData', [0 2*l], 'Color', color_B, 'LineWidth', 4);
    hip = line('Parent', ax, 'XData', 0, 'YData', 2*l, 'Marker', 'o', 'MarkerSize', 15, ...
        'MarkerFaceColor', [0.4 0.4 0.4], 'MarkerEdgeColor', 'k', 'LineWidth', 2);
    foot_A = line('Parent', ax, 'XData', 0, 'YData', 0, 'Marker', 'o', 'MarkerSize', 8, ...
        'MarkerFaceColor', color_A, 'MarkerEdgeColor', 'k');
    foot_B = line('Parent', ax, 'XData', 0, 'YData', 0, 'Marker', 'o', 'MarkerSize', 8, ...
        'MarkerFaceColor', color_B, 'MarkerEdgeColor', 'k');

    time_txt = text(ax, 0.02, 0.95, '$t = 0$ s', 'Units', 'normalized', 'FontSize', 14, 'Interpreter', 'latex');
    step_txt = text(ax, 0.02, 0.88, 'Step: 0', 'Units', 'normalized', 'FontSize', 12, 'Interpreter', 'latex');

    legend(ax, [leg_A, leg_B], {'Leg A', 'Leg B'}, 'Location', 'northeast', 'Interpreter', 'latex');

    %% Video writer
    if nargin < 6, video_dir = []; end
    if ~isempty(video_dir)
        if ~exist(video_dir, 'dir'), mkdir(video_dir); end
        video_path = fullfile(video_dir, 'compass_biped_animation.mp4');
        writer = VideoWriter(video_path, 'MPEG-4');
        writer.FrameRate = 50;
        open(writer);
    end

    %% Animation Loop
    dt = 0.02;

    for seg = 1:length(T_seg)
        T = T_seg{seg};
        X = X_seg{seg};
        x_st = x_stance_seg{seg};
        swaps = swap_count_seg(seg);
        
        % Determine which physical leg is stance based on swap count
        leg_A_stance = (mod(swaps, 2) == 0);

        t_anim = T(1):dt:T(end);
        if isempty(t_anim), t_anim = T(1); end

        X_interp = interp1(T, X, t_anim);
        x_st_interp = interp1(T, x_st, t_anim);
        if length(t_anim) == 1
            X_interp = X(1, :);
            x_st_interp = x_st(1);
        end

        for i = 1:length(t_anim)
            if ~isvalid(fig), return; end

            t = t_anim(i);
            th1 = X_interp(i, 1);
            th2 = X_interp(i, 2);
            xs = x_st_interp(i);

            % Compute positions in slope frame
            x_stance_foot = xs;
            y_stance_foot = 0;
            x_hip = xs + 2*l*sin(th1);
            y_hip = 2*l*cos(th1);
            x_swing_foot = x_hip + 2*l*sin(th2);
            y_swing_foot = y_hip - 2*l*cos(th2);

            % Transform to world frame
            [xsf_w, ysf_w] = slope_to_world(x_stance_foot, y_stance_foot, alpha);
            [xh_w, yh_w] = slope_to_world(x_hip, y_hip, alpha);
            [xswf_w, yswf_w] = slope_to_world(x_swing_foot, y_swing_foot, alpha);

            % Update graphics based on which physical leg is stance
            if leg_A_stance
                % Leg A is stance (foot to hip), Leg B is swing (hip to foot)
                set(leg_A, 'XData', [xsf_w xh_w], 'YData', [ysf_w yh_w]);
                set(leg_B, 'XData', [xh_w xswf_w], 'YData', [yh_w yswf_w]);
                set(foot_A, 'XData', xsf_w, 'YData', ysf_w);
                set(foot_B, 'XData', xswf_w, 'YData', yswf_w);
            else
                % Leg B is stance (foot to hip), Leg A is swing (hip to foot)
                set(leg_B, 'XData', [xsf_w xh_w], 'YData', [ysf_w yh_w]);
                set(leg_A, 'XData', [xh_w xswf_w], 'YData', [yh_w yswf_w]);
                set(foot_B, 'XData', xsf_w, 'YData', ysf_w);
                set(foot_A, 'XData', xswf_w, 'YData', yswf_w);
            end

            set(hip, 'XData', xh_w, 'YData', yh_w);
            set(time_txt, 'String', sprintf('$t = %.2f$ s', t));
            set(step_txt, 'String', sprintf('Step: %d', swaps));

            drawnow;
            if ~isempty(video_dir)
                writeVideo(writer, getframe(fig));
            end
            pause(dt);
        end
    end

    if ~isempty(video_dir)
        close(writer);
        fprintf('Animation saved to: %s\n', video_path);
    end
    fprintf('Animation complete.\n');
end

function [xw, yw] = slope_to_world(xs, ys, alpha)
    xw = xs*cos(alpha) + ys*sin(alpha);
    yw = -xs*sin(alpha) + ys*cos(alpha);
end
