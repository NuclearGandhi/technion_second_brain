function plot_results_full()
    % PLOT_RESULTS_FULL Generate all plots (a)-(j) for HDY1 Homework 2
    % Loads simulation_results.mat and saves figures to ../figures/

    %% 1. Load and Preprocess Data
    if ~isfile('simulation_results.mat')
        error('simulation_results.mat not found. Run simulation first.');
    end
    data = load('simulation_results.mat');
    
    % Extract raw data
    t_raw = data.t;
    q_raw = data.q;       % [x; y; theta; phi1; phi2; psi]
    dq_raw = data.dq;     % [dx; dy; dtheta; dphi1; dphi2; dpsi]
    lam_raw = data.lambda;
    tau_raw = data.tau_psi;
    Fext_raw = data.F_ext;
    Mc_raw = data.Mc;
    p = data.params;
    
    % Resample to uniform time grid for accurate differentiation
    dt = 0.01;
    t = (t_raw(1):dt:t_raw(end)).';
    
    % Interpolate data
    q = interp1(t_raw, q_raw.', t, 'spline').';
    dq = interp1(t_raw, dq_raw.', t, 'spline').';
    lam = interp1(t_raw, lam_raw.', t, 'spline').';
    tau_psi = interp1(t_raw, tau_raw.', t, 'spline').';
    Fext = interp1(t_raw, Fext_raw.', t, 'spline').';
    Mc = interp1(t_raw, Mc_raw.', t, 'spline').';
    
    % Unpack State
    x = q(1,:); y = q(2,:); theta = q(3,:); phi1 = q(4,:); phi2 = q(5,:); psi = q(6,:);
    dx = dq(1,:); dy = dq(2,:); dtheta = dq(3,:); dphi1 = dq(4,:); dphi2 = dq(5,:); dpsi = dq(6,:);
    
    % Accelerations via gradient
    ddx = gradient(dx, dt);
    ddtheta = gradient(dtheta, dt);
    ddpsi = gradient(dpsi, dt); % Or use analytical derivative
    
    % Constants
    m_total = p.m1 + p.m2;
    
    % Directory for figures
    fig_dir = '../figures';
    if ~exist(fig_dir, 'dir')
        mkdir(fig_dir);
    end

    % Set all figures to the same 600x400 size
    set(0, 'defaultFigurePosition', [100, 100, 600, 400]);

    set(groot, 'defaultTextInterpreter', 'latex');
    set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
    set(groot, 'defaultLegendInterpreter', 'latex');
    
    %% 2. Plot Generation
    
    % -- (a) Wheels' angles phi1, phi2 --
    f_a = figure('Name', 'Wheels Angles', 'Visible', 'off');
    plot(t, rad2deg(phi1), 'LineWidth', 2, 'DisplayName', '$\phi_1$');
    hold on;
    plot(t, rad2deg(phi2), 'LineWidth', 2, 'DisplayName', '$\phi_2$');
    xlabel('Time [s]'); ylabel('Angle [deg]');
    title('(a) Wheels'' Angles $\phi_1, \phi_2$');
    legend('show'); grid on;
    saveas(f_a, fullfile(fig_dir, 'HDY1_HW002_Fig_a.png'));
    
    % -- (b) Body orientation theta --
    f_b = figure('Name', 'Body Orientation', 'Visible', 'off');
    plot(t, rad2deg(theta), 'LineWidth', 2);
    xlabel('Time [s]'); ylabel('Angle [deg]');
    title('(b) Body Orientation $\theta(t)$');
    grid on;
    saveas(f_b, fullfile(fig_dir, 'HDY1_HW002_Fig_b.png'));
    
    % -- (c) COM velocity projected along body-fixed e1' --
    % e1' = [cos(theta); sin(theta)]
    % v_c = [dx; dy]
    vc_proj = dx .* cos(theta) + dy .* sin(theta);
    
    f_c = figure('Name', 'Projected COM Velocity', 'Visible', 'off');
    plot(t, vc_proj, 'LineWidth', 2);
    xlabel('Time [s]'); ylabel('Velocity [m/s]');
    title('(c) COM Velocity along body axis $e_1''$');
    grid on;
    saveas(f_c, fullfile(fig_dir, 'HDY1_HW002_Fig_c.png'));
    
    % -- (d) Trajectory of C --
    f_d = figure('Name', 'Trajectory', 'Visible', 'off');
    plot(x, y, 'LineWidth', 2);
    xlabel('$x$ [m]'); ylabel('$y$ [m]');
    title('(d) Trajectory of Center of Mass $c$');
    axis equal; grid on;
    saveas(f_d, fullfile(fig_dir, 'HDY1_HW002_Fig_d.png'));
    
    % -- (e) Constraint Forces lambda --
    f_e = figure('Name', 'Constraint Forces', 'Visible', 'off');
    plot(t, lam(1,:), 'LineWidth', 2, 'DisplayName', '$\lambda_1$');
    hold on;
    plot(t, lam(2,:), 'LineWidth', 2, 'DisplayName', '$\lambda_2$');
    xlabel('Time [s]'); ylabel('Force [N]');
    title('(e) Constraint Forces $\lambda_1, \lambda_2$');
    legend('show'); grid on;
    saveas(f_e, fullfile(fig_dir, 'HDY1_HW002_Fig_e.png'));
    
    % -- (f) Actuation Torque --
    f_f = figure('Name', 'Actuation Torque', 'Visible', 'off');
    plot(t, tau_psi, 'LineWidth', 2);
    xlabel('Time [s]'); ylabel('Torque [Nm]');
    title('(f) Actuation Torque $\tau_\psi(t)$');
    grid on;
    saveas(f_f, fullfile(fig_dir, 'HDY1_HW002_Fig_f.png'));
    
    % -- (g) Linear Momentum Check (X direction) --
    % F_ext_x vs m * a_cx
    F_ext_x = Fext(1, :);
    ma_x = m_total * ddx;
    
    f_g = figure('Name', 'Linear Momentum Check', 'Visible', 'off');
    plot(t, F_ext_x, 'LineWidth', 2, 'DisplayName', '$\mathbf{F}_{ext} \cdot \mathbf{e}_1$');
    hold on;
    plot(t, ma_x, '--', 'LineWidth', 2, 'DisplayName', '$m \ddot{\mathbf{r}}_c \cdot \mathbf{e}_1$');
    xlabel('Time [s]'); ylabel('Force [N]');
    title('(g) Linear Momentum Check (X-dir)');
    legend('show'); grid on;
    saveas(f_g, fullfile(fig_dir, 'HDY1_HW002_Fig_g.png'));
    
    % -- (h) Angular Momentum Check --
    % Mc vs dHc/dt
    % Hc = J1*theta_dot + J2*(theta_dot + psi_dot)
    % dHc/dt = J1*ddtheta + J2*(ddtheta + ddpsi)
    dHc_dt = p.J1 * ddtheta + p.J2 * (ddtheta + ddpsi);
    
    f_h = figure('Name', 'Angular Momentum Check', 'Visible', 'off');
    plot(t, Mc, 'LineWidth', 2, 'DisplayName', '$M_c$');
    hold on;
    plot(t, dHc_dt, '--', 'LineWidth', 2, 'DisplayName', '$\dot{H}_c$');
    xlabel('Time [s]'); ylabel('Moment [Nm]');
    title('(h) Angular Momentum Check');
    legend('show'); grid on;
    saveas(f_h, fullfile(fig_dir, 'HDY1_HW002_Fig_h.png'));
    
    % -- (i) Energy / Power Check --
    % T + V derivation
    v_c_sq = dx.^2 + dy.^2;
    T = 0.5 * m_total * v_c_sq + 0.5 * p.J1 * dtheta.^2 + 0.5 * p.J2 * (dtheta + dpsi).^2;
    V = 0.5 * p.k * (phi1.^2 + phi2.^2);
    E = T + V;
    dE_dt = gradient(E, dt);
    
    % Non-conservative Power
    % P_nc = Q_act*dq + Q_diss*dq
    % P_act = tau_psi * dpsi
    % P_diss = -2 * D (Rayleigh dissipation)
    
    % Recompute Dissipation Function D
    % Vectorized calculation
    vx1 = dx + p.b * dtheta .* sin(theta) + p.d * (dtheta + dphi1) .* sin(theta + phi1);
    vy1 = dy - p.b * dtheta .* cos(theta) - p.d * (dtheta + dphi1) .* cos(theta + phi1);
    vp1_sq = vx1.^2 + vy1.^2;

    vx2 = dx - p.b * dtheta .* sin(theta) + p.d * (dtheta + dphi2) .* sin(theta + phi2);
    vy2 = dy + p.b * dtheta .* cos(theta) - p.d * (dtheta + dphi2) .* cos(theta + phi2);
    vp2_sq = vx2.^2 + vy2.^2;
    
    D = 0.5 * p.c * dphi1.^2 + 0.5 * p.c * dphi2.^2 + ...
        0.5 * p.cw * vp1_sq + 0.5 * p.cw * vp2_sq;
        
    P_act = tau_psi .* dpsi;
    P_diss = -2 * D;
    P_nc = P_act + P_diss;
    
    f_i = figure('Name', 'Power Balance', 'Visible', 'off');
    plot(t, dE_dt, 'LineWidth', 2, 'DisplayName', '$d(T+V)/dt$');
    hold on;
    plot(t, P_nc, '--', 'LineWidth', 2, 'DisplayName', '$P_{nc}$');
    xlabel('Time [s]'); ylabel('Power [W]');
    title('(i) Power Balance Check');
    legend('show'); grid on;
    saveas(f_i, fullfile(fig_dir, 'HDY1_HW002_Fig_i.png'));
    
    % -- (j) Drift / Skid Velocities --
    % w1 * dq = 0?
    
    % Vectorized drift calculation
    drift1 = -sin(theta + phi1) .* dx + cos(theta + phi1) .* dy - ...
             (p.d + p.b * cos(phi1)) .* dtheta - p.d * dphi1;
             
    drift2 = -sin(theta + phi2) .* dx + cos(theta + phi2) .* dy + ...
             (p.b * cos(phi2) - p.d) .* dtheta - p.d * dphi2;
    
    f_j = figure('Name', 'Constraint Drift', 'Visible', 'off');
    plot(t, drift1, 'DisplayName', 'Constraint 1');
    hold on;
    plot(t, drift2, 'DisplayName', 'Constraint 2');
    xlabel('Time [s]'); ylabel('Skid Velocity [m/s]');
    title('(j) Constraint Drift (Numerical Error)');
    legend('show'); grid on;
    saveas(f_j, fullfile(fig_dir, 'HDY1_HW002_Fig_j.png'));
    
    fprintf('All plots (a)-(j) saved to %s\n', fig_dir);
    
    % Close all
    close([f_a, f_b, f_c, f_d, f_e, f_f, f_g, f_h, f_i, f_j]);
end

