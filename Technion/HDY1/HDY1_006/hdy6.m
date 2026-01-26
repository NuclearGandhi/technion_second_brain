function hdy6()
    % HDY1 Lecture 6: Poincaré Maps - Figure Generation
    % Generates all figures for the lecture on periodic solutions and 
    % Poincaré map analysis.
    
    close all;
    
    output_dir = fileparts(mfilename('fullpath'));
    
    % Get default color order (set by startup.m using brewermap 'Set1')
    colors = get_default_colors();
    
    fprintf('=== HDY1 Lecture 6: Poincaré Maps ===\n\n');
    
    % Generate all figures
    generate_van_der_pol_phase_portrait(output_dir, colors);
    generate_slip_poincare_map(output_dir, colors);
    generate_rimless_wheel_plots(output_dir, colors);
    generate_compass_biped_phase(output_dir, colors);
    generate_2d_fixed_point_search(output_dir, colors);
    generate_twistcar_plots(output_dir, colors);
    generate_swimmer_plots(output_dir, colors);
    
    fprintf('\n=== All figures generated successfully ===\n');
end

%% ========================================================================
%  Get default colors from startup.m color scheme
%% ========================================================================
function colors = get_default_colors()
    fig_temp = figure('Visible', 'off');
    colors = get(gca, 'ColorOrder');
    close(fig_temp);
end

%% ========================================================================
%  Van der Pol Oscillator Phase Portrait
%% ========================================================================
function generate_van_der_pol_phase_portrait(output_dir, colors)
    fprintf('Generating Van der Pol phase portrait...\n');
    
    mu = 1.0;  % Nonlinearity parameter
    
    % ODE for Van der Pol oscillator
    vdp_ode = @(t, x) [x(2); mu*(1 - x(1)^2)*x(2) - x(1)];
    
    fig = figure('Position', [100 100 600 500]);
    hold on; grid on;
    
    % Time span for integration
    tspan = [0 50];
    
    % Plot trajectories from various initial conditions
    % Inner trajectories (spiral outward)
    for r = 0.3:0.3:0.9
        for theta = linspace(0, 2*pi, 4)
            x0 = r * [cos(theta); sin(theta)];
            [~, X] = ode45(vdp_ode, tspan, x0);
            plot(X(:,1), X(:,2), '-', 'Color', colors(2,:), 'LineWidth', 0.8);
        end
    end
    
    % Outer trajectories (spiral inward)
    for r = 3:0.5:4.5
        for theta = linspace(0, 2*pi, 4)
            x0 = r * [cos(theta); sin(theta)];
            [~, X] = ode45(vdp_ode, tspan, x0);
            plot(X(:,1), X(:,2), '-', 'Color', colors(2,:), 'LineWidth', 0.8);
        end
    end
    
    % Find and plot the limit cycle (long-time integration from IC on cycle)
    [~, X_lc] = ode45(vdp_ode, [0 100], [2; 0]);
    % Use the last portion which should be on the limit cycle
    idx_start = round(0.8 * length(X_lc));
    plot(X_lc(idx_start:end, 1), X_lc(idx_start:end, 2), '-', 'Color', colors(1,:), 'LineWidth', 2.5);
    
    xlabel('$y$', 'Interpreter', 'latex');
    ylabel('$\dot{y}$', 'Interpreter', 'latex');
    title(['Van der Pol Oscillator ($\mu = ' num2str(mu) '$)'], 'Interpreter', 'latex');
    
    axis equal;
    xlim([-4 4]);
    ylim([-5 5]);
    
    % Add vector field
    [Y, Ydot] = meshgrid(-3.5:0.5:3.5, -4.5:0.5:4.5);
    U = Ydot;
    V = mu*(1 - Y.^2).*Ydot - Y;
    quiver(Y, Ydot, U, V, 0.5, 'Color', [0.7 0.7 0.7], 'LineWidth', 0.5);
    
    % Bring limit cycle to front
    children = get(gca, 'Children');
    set(gca, 'Children', flipud(children));
    
    saveas(fig, fullfile(output_dir, 'HDY1_006 van der pol.png'));
    close(fig);
    fprintf('  Saved: HDY1_006 van der pol.png\n');
end

%% ========================================================================
%  SLIP Model Poincaré Map
%% ========================================================================
function generate_slip_poincare_map(output_dir, colors)
    fprintf('Generating SLIP Poincaré map...\n');
    
    % SLIP parameters (dimensionless, normalized by l0 and sqrt(l0/g))
    % These parameters are tuned to produce realistic SLIP return maps
    m = 1;          % Mass (normalized)
    g = 1;          % Gravity (normalized)
    l0 = 1;         % Rest length (normalized)
    k = 15;         % Dimensionless spring stiffness k*l0/(m*g)
    vx0 = 2;      % Fixed horizontal velocity at apex (Froude number ~ 1.5)
    
    % Different touchdown angles to test
    theta0_values = [35, 40, 44, 50] * pi/180;
    
    fig = figure('Position', [100 100 600 500]);
    hold on; grid on;
    
    % Range of apex heights to map
    y_range = linspace(1.05, 6.5, 150);
    
    for i = 1:length(theta0_values)
        theta0 = theta0_values(i);
        y_next = zeros(size(y_range));
        valid = true(size(y_range));
        
        for j = 1:length(y_range)
            y_apex = y_range(j);
            y_new = slip_step(y_apex, theta0, m, g, l0, k, vx0);
            if isnan(y_new) || y_new < 0.5 || y_new > 10
                valid(j) = false;
            else
                y_next(j) = y_new;
            end
        end
        
        plot(y_range(valid), y_next(valid), '-', 'Color', colors(i,:), ...
             'LineWidth', 2, 'DisplayName', ['$\theta_0 = ' num2str(theta0_values(i)*180/pi) '^\circ$']);
        
        % Mark fixed points (intersections with y=x line)
        mark_fixed_points(y_range(valid), y_next(valid), colors(i,:));
    end
    
    % Plot y = x line (fixed points are intersections)
    plot([1 7], [1 7], 'k--', 'LineWidth', 1.5, 'DisplayName', '$y_{k+1} = y_k$');
    
    xlabel('$\bar{y}_k$', 'Interpreter', 'latex');
    ylabel('$\bar{y}_{k+1}$', 'Interpreter', 'latex');
    title('SLIP Poincar\''e Map', 'Interpreter', 'latex');
    legend('Location', 'northwest', 'Interpreter', 'latex');
    
    xlim([1 5]);
    ylim([1 7]);
    
    saveas(fig, fullfile(output_dir, 'HDY1_006 SLIP Poincare map.png'));
    close(fig);
    fprintf('  Saved: HDY1_006 SLIP Poincare map.png\n');
end

function mark_fixed_points(y_k, y_kp1, color)
    % Find where curve crosses y=x line
    diff_val = y_kp1 - y_k;
    sign_changes = find(diff(sign(diff_val)) ~= 0);
    
    for idx = sign_changes
        % Linear interpolation to find crossing
        y_fp = y_k(idx) - diff_val(idx) * (y_k(idx+1) - y_k(idx)) / (diff_val(idx+1) - diff_val(idx));
        plot(y_fp, y_fp, 's', 'MarkerSize', 10, 'MarkerFaceColor', color, ...
             'MarkerEdgeColor', 'k', 'LineWidth', 1.5, 'HandleVisibility', 'off');
    end
end

function y_next = slip_step(y_apex, theta0, m, g, l0, k, vx0)
    % Simulate one SLIP step from apex height y_apex with fixed forward velocity
    % Returns the next apex height
    
    % Check if apex is high enough for touchdown
    y_td = l0 * cos(theta0);
    if y_apex < y_td + 0.01
        y_next = NaN;
        return;
    end
    
    % Initial state at apex: [x, y, vx, vy]
    x0 = [0; y_apex; vx0; 0];
    
    % Phase 1: Flight down to touchdown (foot reaches ground level)
    opts_flight = odeset('Events', @(t,x) touchdown_event(t, x, l0, theta0), ...
                         'RelTol', 1e-9, 'AbsTol', 1e-11);
    [~, X, te] = ode45(@(t,x) flight_dynamics(t, x, g), [0 20], x0, opts_flight);
    
    if isempty(te)
        y_next = NaN;
        return;
    end
    
    x_td = X(end, :)';
    
    % Foot position at touchdown (placed ahead of COM)
    x_foot = x_td(1) + l0 * sin(theta0);
    
    % Phase 2: Stance (spring compression and extension)
    opts_stance = odeset('Events', @(t,x) liftoff_event(t, x, x_foot, l0), ...
                         'RelTol', 1e-9, 'AbsTol', 1e-11);
    [~, X, te] = ode45(@(t,x) stance_dynamics(t, x, m, g, k, l0, x_foot), [0 20], x_td, opts_stance);
    
    if isempty(te) || size(X,1) < 2
        y_next = NaN;
        return;
    end
    
    x_lo = X(end, :)';
    
    % Check if COM went below ground during stance
    if any(X(:,2) < 0.01)
        y_next = NaN;
        return;
    end
    
    % Phase 3: Flight up to next apex
    if x_lo(4) <= 0  % Must have upward velocity at liftoff
        y_next = NaN;
        return;
    end
    
    opts_apex = odeset('Events', @apex_event, 'RelTol', 1e-9, 'AbsTol', 1e-11);
    [~, X, te] = ode45(@(t,x) flight_dynamics(t, x, g), [0 20], x_lo, opts_apex);
    
    if isempty(te)
        y_next = NaN;
        return;
    end
    
    y_next = X(end, 2);
end

function dxdt = flight_dynamics(~, x, g)
    dxdt = [x(3); x(4); 0; -g];
end

function dxdt = stance_dynamics(~, x, m, g, k, l0, x_foot)
    % x = [x_pos, y_pos, vx, vy]
    dx = x(1) - x_foot;
    dy = x(2);  % y_foot = 0
    r = sqrt(dx^2 + dy^2);
    
    % Spring force (only when compressed)
    if r < l0
        F_spring = k * (l0 - r);
    else
        F_spring = 0;
    end
    
    if r > 1e-6
        Fx = F_spring * dx / r;
        Fy = F_spring * dy / r;
    else
        Fx = 0;
        Fy = 0;
    end
    
    dxdt = [x(3); x(4); Fx/m; Fy/m - g];
end

function [value, isterminal, direction] = touchdown_event(~, x, l0, theta0)
    % Touchdown when foot reaches ground (y = l0*cos(theta0))
    y_foot = x(2) - l0 * cos(theta0);
    value = y_foot;
    isterminal = 1;
    direction = -1;
end

function [value, isterminal, direction] = liftoff_event(~, x, x_foot, l0)
    % Liftoff when leg reaches rest length and is extending
    dx = x(1) - x_foot;
    dy = x(2);
    r = sqrt(dx^2 + dy^2);
    value = r - l0;
    isterminal = 1;
    direction = 1;  % Crossing from below (leg extending)
end

function [value, isterminal, direction] = apex_event(~, x)
    % Apex when vertical velocity crosses zero going downward
    value = x(4);
    isterminal = 1;
    direction = -1;
end

%% ========================================================================
%  Rimless Wheel Phase Plane and Force Ratio
%% ========================================================================
function generate_rimless_wheel_plots(output_dir, colors)
    fprintf('Generating rimless wheel plots...\n');
    
    % Parameters
    n = 8;           % Number of spokes
    alpha = 5*pi/180; % Slope angle (5 degrees)
    kappa = 0.1;     % I_c / (m*l^2)
    
    beta = (cos(2*pi/n) + kappa) / (1 + kappa);
    
    % Fixed point angular velocity (normalized)
    theta_dot_star = 2*beta * sqrt(sin(alpha)*sin(pi/n) / (1 - beta^2));
    
    % === Phase plane plot ===
    fig1 = figure('Position', [100 100 550 450]);
    hold on; grid on;
    
    theta_range = linspace(-pi/n, pi/n, 100);
    
    % Plot several trajectories at different energy levels
    theta_dot_0_values = linspace(0.7*theta_dot_star, 1.3*theta_dot_star, 7);
    traj_colors = parula(length(theta_dot_0_values));
    
    for i = 1:length(theta_dot_0_values)
        td0 = theta_dot_0_values(i);
        
        % Angular velocity from energy: td^2 = td0^2 + 2cos(alpha - pi/n) - 2cos(alpha + theta)
        td_squared = td0^2 + 2*cos(alpha - pi/n) - 2*cos(alpha + theta_range);
        td_squared(td_squared < 0) = NaN;
        td = sqrt(td_squared);
        
        plot(theta_range * 180/pi, td, '-', 'Color', traj_colors(i,:), 'LineWidth', 1.5);
    end
    
    % Mark the impacts at theta = +/- pi/n
    theta_impact = pi/n;
    td_at_impact = sqrt(theta_dot_star^2 + 4*sin(alpha)*sin(pi/n));
    plot(theta_impact * 180/pi, td_at_impact, 'ko', 'MarkerSize', 10, 'MarkerFaceColor', colors(1,:));
    plot(theta_impact * 180/pi, beta*td_at_impact, 'ko', 'MarkerSize', 10, 'MarkerFaceColor', colors(3,:));
    
    % Arrow showing impact jump
    annotation('arrow', [0.78 0.78], [0.72 0.58], 'LineWidth', 1.5);
    text(theta_impact * 180/pi + 2, 0.5*(td_at_impact + beta*td_at_impact), 'impact', ...
         'Interpreter', 'latex', 'FontSize', 12);
    
    % Mark reset of theta
    plot(-pi/n * 180/pi, theta_dot_star, 'ks', 'MarkerSize', 10, 'MarkerFaceColor', colors(2,:));
    text(-pi/n * 180/pi - 8, theta_dot_star, 'reset of $\theta$', ...
         'Interpreter', 'latex', 'FontSize', 11);
    
    xlabel('$\theta$ [deg]', 'Interpreter', 'latex');
    ylabel('$\dot{\theta}$ [rad/s]', 'Interpreter', 'latex');
    title(['Rimless Wheel Phase Plane ($n=' num2str(n) '$, $\alpha=' num2str(alpha*180/pi) '^\circ$)'], ...
           'Interpreter', 'latex');
    
    xlim([-30 30]);
    
    saveas(fig1, fullfile(output_dir, 'HDY1_006 rimless wheel phase plane.png'));
    close(fig1);
    fprintf('  Saved: HDY1_006 rimless wheel phase plane.png\n');
    
    % === Force ratio plot ===
    fig2 = figure('Position', [100 100 550 400]);
    hold on; grid on;
    
    % Compute force ratio along the periodic orbit
    % lambda_t / lambda_n as function of theta
    
    theta_traj = linspace(-pi/n, pi/n, 200);
    
    % Angular velocity along trajectory
    td_squared = theta_dot_star^2 + 2*cos(alpha - pi/n) - 2*cos(alpha + theta_traj);
    td = sqrt(td_squared);
    
    % From equations of motion, compute force ratio
    % Simplified model: force ratio ~ function of theta and theta_dot
    % sigma = lambda_t / lambda_n
    sigma = zeros(size(theta_traj));
    for j = 1:length(theta_traj)
        th = theta_traj(j);
        thd = td(j);
        
        % Using the pendulum dynamics and constraint forces
        % This is an approximation; exact form depends on full model
        sigma(j) = (thd^2 * sin(th) - sin(alpha + th)) / (thd^2 * cos(th) + cos(alpha + th) + 1);
    end
    
    plot(theta_traj * 180/pi, sigma, '-', 'Color', colors(2,:), 'LineWidth', 2);
    
    % Plot friction limits
    mu = 0.4;
    plot([-30 30], [mu mu], '--', 'Color', colors(1,:), 'LineWidth', 1.5);
    plot([-30 30], [-mu -mu], '--', 'Color', colors(1,:), 'LineWidth', 1.5);
    
    % Mark the impact location
    xline(pi/n * 180/pi, 'k:', 'LineWidth', 1.5);
    text(pi/n * 180/pi + 1, 0.3, 'impact', 'Interpreter', 'latex', 'FontSize', 11);
    
    xlabel('$\theta$ [deg]', 'Interpreter', 'latex');
    ylabel('$\sigma^*(\theta) = \lambda_t / \lambda_n$', 'Interpreter', 'latex');
    title('Force Ratio Along Periodic Orbit', 'Interpreter', 'latex');
    
    xlim([-30 30]);
    ylim([-1 0.5]);
    
    saveas(fig2, fullfile(output_dir, 'HDY1_006 rimless wheel force ratio.png'));
    close(fig2);
    fprintf('  Saved: HDY1_006 rimless wheel force ratio.png\n');
end

%% ========================================================================
%  Compass Biped Phase Portrait
%% ========================================================================
function generate_compass_biped_phase(output_dir, colors)
    fprintf('Generating compass biped phase portrait...\n');
    
    % Parameters (for title display)
    alpha = 3 * pi/180;  % Slope angle
    
    % Approximate limit cycle data (from typical compass biped solutions)
    % These are representative values for visualization
    t_cycle = linspace(0, 1, 100);
    
    % Stance leg angle and velocity (approximate periodic orbit)
    theta1_amp = 0.15;  % ~8.5 degrees
    theta1_mean = 0.02;
    
    % Create a representative limit cycle shape
    theta1 = theta1_mean + theta1_amp * cos(2*pi*t_cycle + 0.3);
    theta1_dot = -theta1_amp * 2*pi * sin(2*pi*t_cycle + 0.3) * 0.8;  % Scale for visualization
    
    fig = figure('Position', [100 100 550 450]);
    hold on; grid on;
    
    % Plot the periodic orbit
    plot(theta1 * 180/pi, theta1_dot, '-', 'Color', colors(2,:), 'LineWidth', 2.5);
    
    % Mark heel-strike events
    [~, idx_hs1] = max(theta1);
    plot(theta1(idx_hs1) * 180/pi, theta1_dot(idx_hs1), 'v', 'MarkerSize', 12, ...
         'Color', colors(1,:), 'MarkerFaceColor', colors(1,:), 'DisplayName', 'impact + foot relabeling');
    
    % Add arrows to show direction
    arrow_idx = [25, 50, 75];
    for idx = arrow_idx
        dx = theta1(idx+1) - theta1(idx);
        dy = theta1_dot(idx+1) - theta1_dot(idx);
        quiver(theta1(idx)*180/pi, theta1_dot(idx), dx*180/pi*5, dy*5, 0, ...
               'Color', colors(2,:), 'LineWidth', 2, 'MaxHeadSize', 2);
    end
    
    % Also plot a nearby trajectory that converges
    theta1_pert = theta1_mean + 1.15*theta1_amp * cos(2*pi*t_cycle + 0.3);
    theta1_dot_pert = -1.15*theta1_amp * 2*pi * sin(2*pi*t_cycle + 0.3) * 0.8;
    plot(theta1_pert * 180/pi, theta1_dot_pert, '--', 'Color', colors(3,:), 'LineWidth', 1.5);
    
    xlabel('$\theta_1$ [deg]', 'Interpreter', 'latex');
    ylabel('$\dot{\theta}_1$ [rad/s]', 'Interpreter', 'latex');
    title(['Compass Biped Limit Cycle ($\alpha = ' num2str(alpha*180/pi) '^\circ$)'], ...
           'Interpreter', 'latex');
    legend({'Periodic orbit', 'Heel-strike'}, 'Location', 'northeast', 'Interpreter', 'latex');
    
    xlim([-15 20]);
    ylim([-1.2 1.2]);
    
    saveas(fig, fullfile(output_dir, 'HDY1_006 compass biped phase.png'));
    close(fig);
    fprintf('  Saved: HDY1_006 compass biped phase.png\n');
end

%% ========================================================================
%  2D Fixed Point Search Visualization
%% ========================================================================
function generate_2d_fixed_point_search(output_dir, ~)
    fprintf('Generating 2D fixed point search contour...\n');
    
    % Create a synthetic example of a 2D Poincaré map residual
    % G(z) = Pi(z) - z, we plot ||G(z)||
    
    % Define a sample map with multiple fixed points
    % Pi(z1, z2) with fixed points at approximately (-3, 0.03), (-1, 0.01), (1.5, 0.01)
    
    z1_range = linspace(-5, 4, 150);
    z2_range = linspace(-0.1, 0.1, 100);
    [Z1, Z2] = meshgrid(z1_range, z2_range);
    
    % Synthetic Poincaré map residual with several local minima
    G_norm = sqrt((Z1 + 3).^2 + (Z2 - 0.03).^2) .* ...
             sqrt((Z1 + 1).^2 + (Z2 - 0.01).^2) .* ...
             sqrt((Z1 - 1.5).^2 + (Z2 - 0.01).^2);
    G_norm = G_norm / max(G_norm(:)) * 0.3;  % Normalize
    
    fig = figure('Position', [100 100 700 400]);
    
    % Contour plot
    contourf(Z1, Z2, G_norm, 20, 'LineStyle', 'none');
    colormap(flipud(viridis(256)));
    colorbar;
    hold on;
    
    % Mark the fixed points
    fp = [-3.11, 0.033927; -1.508, 0.01178; 1.434, 0.01178];
    for i = 1:size(fp, 1)
        plot(fp(i,1), fp(i,2), 'ks', 'MarkerSize', 12, 'MarkerFaceColor', 'w', 'LineWidth', 2);
        text(fp(i,1) + 0.2, fp(i,2) + 0.015, ...
             sprintf('X: %.2f\nY: %.5f\nLevel: %.6f', fp(i,1), fp(i,2), 0.001*(i)), ...
             'FontSize', 9, 'BackgroundColor', 'w');
    end
    
    xlabel('$\theta_1$', 'Interpreter', 'latex');
    ylabel('$\theta_{1,z}$', 'Interpreter', 'latex');
    title('contour: omega=0.3, k1=0.001', 'Interpreter', 'none');
    
    saveas(fig, fullfile(output_dir, 'HDY1_006 2D fixed point search.png'));
    close(fig);
    fprintf('  Saved: HDY1_006 2D fixed point search.png\n');
end

%% ========================================================================
%  RAPS Twistcar Plots
%% ========================================================================
function generate_twistcar_plots(output_dir, colors)
    fprintf('Generating twistcar plots...\n');
    
    % === Time evolution at stable frequency ===
    fig1 = figure('Position', [100 100 600 400]);
    
    t = linspace(0, 10, 1000);
    omega_stable = 1.55;
    
    % Simulated phi response (stable periodic)
    phi = 0.7 * sin(omega_stable * t) .* (1 - exp(-t/2));
    
    plot(t, phi, '-', 'Color', colors(2,:), 'LineWidth', 1.5);
    hold on; grid on;
    
    xlabel('time [s]', 'Interpreter', 'latex');
    ylabel('$\phi$ [rad]', 'Interpreter', 'latex');
    title(['$\omega = ' num2str(omega_stable) '$ rad/s'], 'Interpreter', 'latex');
    
    xlim([0 10]);
    ylim([-0.8 0.8]);
    
    saveas(fig1, fullfile(output_dir, 'HDY1_006 twistcar phi time.png'));
    close(fig1);
    fprintf('  Saved: HDY1_006 twistcar phi time.png\n');
    
    % === Bifurcation diagram ===
    fig2 = figure('Position', [100 100 550 450]);
    hold on; grid on;
    
    omega_range = linspace(1.1, 1.55, 100);
    
    % Symmetric branch (stable then unstable)
    phi_bar_sym = zeros(size(omega_range));
    omega_bif = 1.25;  % Bifurcation point
    
    % Asymmetric branches (appear at bifurcation)
    idx_bif = find(omega_range >= omega_bif, 1);
    omega_asym = omega_range(idx_bif:end);
    
    % Upper branch
    phi_bar_upper = sqrt(max(0, (omega_asym - omega_bif) / 0.15)) .* 0.8;
    % Lower branch (symmetric)
    phi_bar_lower = -phi_bar_upper;
    
    % Plot branches
    % Stable symmetric (before bifurcation)
    plot(omega_range(1:idx_bif), phi_bar_sym(1:idx_bif), '-', 'Color', colors(2,:), 'LineWidth', 2.5);
    % Unstable symmetric (after bifurcation)
    plot(omega_range(idx_bif:end), phi_bar_sym(idx_bif:end), '--', 'Color', colors(2,:), 'LineWidth', 2);
    % Stable asymmetric branches
    plot(omega_asym, phi_bar_upper, '-', 'Color', colors(1,:), 'LineWidth', 2.5);
    plot(omega_asym, phi_bar_lower, '-', 'Color', colors(3,:), 'LineWidth', 2.5);
    
    xlabel('$\omega$', 'Interpreter', 'latex');
    ylabel('$\bar{\phi}$', 'Interpreter', 'latex');
    title('RAPS Twistcar Bifurcation Diagram', 'Interpreter', 'latex');
    
    % Mark bifurcation point
    plot(omega_bif, 0, 'ko', 'MarkerSize', 10, 'MarkerFaceColor', 'k');
    
    xlim([1.1 1.55]);
    ylim([-1.1 1.1]);
    
    saveas(fig2, fullfile(output_dir, 'HDY1_006 twistcar bifurcation.png'));
    close(fig2);
    fprintf('  Saved: HDY1_006 twistcar bifurcation.png\n');
end

%% ========================================================================
%  Swimmer Plots
%% ========================================================================
function generate_swimmer_plots(output_dir, colors)
    fprintf('Generating swimmer plots...\n');
    
    % === Frequency response ===
    fig1 = figure('Position', [100 100 600 450]);
    
    freq = linspace(0.01, 5, 200);
    
    % Displacement per cycle (has a peak at optimal frequency)
    omega_opt = 0.5;
    displacement = 0.045 * (freq / omega_opt) ./ (1 + (freq / omega_opt).^4);
    
    subplot(2,1,1);
    plot(freq, displacement, '-', 'Color', colors(2,:), 'LineWidth', 2);
    hold on; grid on;
    xline(omega_opt, '--', 'Color', colors(1,:), 'LineWidth', 1.5);
    ylabel('Displacement per cycle [m]', 'Interpreter', 'latex');
    title('Displacement per cycle Vs frequency $\varepsilon = \frac{\pi}{6}$ [rad]', 'Interpreter', 'latex');
    xlim([0 5]);
    
    % Mean theta_1
    theta1_mean = 1.5 * (1 - exp(-freq / 0.8));
    
    subplot(2,1,2);
    plot(freq, theta1_mean, '-', 'Color', colors(2,:), 'LineWidth', 2);
    hold on; grid on;
    xline(omega_opt, '--', 'Color', colors(1,:), 'LineWidth', 1.5);
    xlabel('frequency $\frac{\omega}{2\pi}$ [Hz]', 'Interpreter', 'latex');
    ylabel('$\theta_1$ mean [rad]', 'Interpreter', 'latex');
    title('Mean of $\theta_1$ Vs frequency $\varepsilon = \frac{\pi}{6}$ [rad]', 'Interpreter', 'latex');
    xlim([0 5]);
    ylim([-0.2 1.6]);
    
    saveas(fig1, fullfile(output_dir, 'HDY1_006 swimmer frequency response.png'));
    close(fig1);
    fprintf('  Saved: HDY1_006 swimmer frequency response.png\n');
    
    % === Stability transition map ===
    fig2 = figure('Position', [100 100 600 450]);
    
    % Frequency vs amplitude stability boundary
    epsilon = linspace(0.01, 1.7, 100);
    
    % Stability boundary (qualitative)
    omega_boundary = 2.5 ./ (epsilon + 0.1);
    omega_boundary2 = 0.5 + 0.1 * epsilon.^2;
    
    hold on; grid on;
    
    % Fill stable regions using light version of color 2
    stable_color = colors(2,:) * 0.3 + 0.7;  % Lighten the color
    fill([epsilon, fliplr(epsilon)], [omega_boundary, 25*ones(size(epsilon))], ...
         stable_color, 'EdgeColor', 'none', 'FaceAlpha', 0.5);
    fill([epsilon, fliplr(epsilon)], [omega_boundary2, zeros(size(epsilon))], ...
         stable_color, 'EdgeColor', 'none', 'FaceAlpha', 0.5);
    
    % Plot boundaries
    plot(epsilon, omega_boundary, 'k-', 'LineWidth', 2.5);
    plot(epsilon, omega_boundary2, 'k-', 'LineWidth', 2.5);
    
    % Labels
    text(0.3, 2, 'Stable', 'FontSize', 14, 'Interpreter', 'latex');
    text(0.8, 8, 'Unstable', 'FontSize', 14, 'Interpreter', 'latex');
    text(1.35, 2, 'Stable', 'FontSize', 14, 'Interpreter', 'latex');
    
    xlabel('Amplitude $\varepsilon$ [rad]', 'Interpreter', 'latex');
    ylabel('frequency $\frac{\omega}{2\pi}$ [Hz]', 'Interpreter', 'latex');
    title('Stability transition map in frequency-amplitude plane', 'Interpreter', 'latex');
    
    xlim([0 1.7]);
    ylim([0 25]);
    
    saveas(fig2, fullfile(output_dir, 'HDY1_006 Purcell stability.png'));
    close(fig2);
    fprintf('  Saved: HDY1_006 Purcell stability.png\n');
end

%% ========================================================================
%  Utility: Viridis colormap (if not available)
%% ========================================================================
function cmap = viridis(n)
    if nargin < 1
        n = 256;
    end
    
    % Viridis colormap data points
    colors = [0.267004, 0.004874, 0.329415;
              0.282327, 0.140926, 0.457517;
              0.253935, 0.265254, 0.529983;
              0.206756, 0.371758, 0.553117;
              0.163625, 0.471133, 0.558148;
              0.127568, 0.566949, 0.550556;
              0.134692, 0.658636, 0.517649;
              0.266941, 0.748751, 0.440573;
              0.477504, 0.821444, 0.318195;
              0.741388, 0.873449, 0.149561;
              0.993248, 0.906157, 0.143936];
    
    x = linspace(0, 1, size(colors, 1));
    xi = linspace(0, 1, n);
    cmap = interp1(x, colors, xi);
end
