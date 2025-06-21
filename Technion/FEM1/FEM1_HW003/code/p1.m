close all; clear; clc;

%% Problem 1: Time-dependent heat conduction with variable conductivity
% Governing equation: d/dx(k(x) dT/dx) = dT/dt, 0 < x < 1.5
% Boundary conditions: T(0,t) = 12, T(1.5,t) = 1.5
% Initial condition: T(x,0) = 12

%% Problem Parameters
L = 1.5;           % Domain length
T0 = 12;           % Left boundary temperature
TL = 3;          % Right boundary temperature
Ti = 12;           % Initial temperature

% Material properties k(x) - piecewise constant
k_values = [1.2, 2.3, 3.8, 2.6];  % k1, k2, k3, k4
x_boundaries = [0, 0.2, 0.5, 0.9, 1.5];  % Region boundaries

%% Helper function to get conductivity at a given x
function k = get_conductivity(x, k_values, x_boundaries)
    if x <= x_boundaries(2)
        k = k_values(1);
    elseif x <= x_boundaries(3)
        k = k_values(2);
    elseif x <= x_boundaries(4)
        k = k_values(3);
    else
        k = k_values(4);
    end
end

%% Part 4: Domain discretization function
function [nodes, K, M] = create_fem_discretization(n_elements, L, k_values, x_boundaries)
    % For the general case, divide each region into n_elements/4 elements
    % This ensures each material region gets equal discretization
    
    if n_elements == 4
        % Special case: one element per region
        nodes = x_boundaries';
    else
        % General case: divide each region into equal sub-elements
        elements_per_region = n_elements / 4;
        if mod(n_elements, 4) ~= 0
            error('Number of elements must be divisible by 4 to match material regions');
        end
        
        % Create nodes for each region
        nodes = [];
        for region = 1:4
            x_start = x_boundaries(region);
            x_end = x_boundaries(region + 1);
            region_nodes = linspace(x_start, x_end, elements_per_region + 1);
            
            if region == 1
                nodes = [nodes, region_nodes];
            else
                % Skip the first node to avoid duplication
                nodes = [nodes, region_nodes(2:end)];
            end
        end
        nodes = nodes';
    end
    
    num_nodes = length(nodes);
    n_elements = num_nodes - 1;  % Update actual number of elements
    
    % Initialize global matrices
    K = zeros(num_nodes, num_nodes);
    M = zeros(num_nodes, num_nodes);
    
    % Assemble element by element
    for e = 1:n_elements
        % Element nodes
        n1 = e;
        n2 = e+1;
        x_center = (nodes(n1) + nodes(n2))/2;  % Element center
        
        % Get element conductivity (evaluate at element center)
        k_e = get_conductivity(x_center, k_values, x_boundaries);
        
        % Element length
        he = nodes(n2) - nodes(n1);
        
        % Element stiffness matrix (from HW3 derivation)
        Ke = (k_e/he) * [1, -1; -1, 1];
        
        % Element mass matrix (consistent mass matrix)
        Me = (he/6) * [2, 1; 1, 2];
        
        % Assemble into global matrices
        K(n1:n2, n1:n2) = K(n1:n2, n1:n2) + Ke;
        M(n1:n2, n1:n2) = M(n1:n2, n1:n2) + Me;
    end
end

%% Critical time step calculation for 4 elements
fprintf('=== Critical time step calculation for 4 elements ===\n');

n_elements_4 = 4;
[nodes_4, K_4, M_4] = create_fem_discretization(n_elements_4, L, k_values, x_boundaries);
num_nodes_4 = length(nodes_4);

% Calculate critical time step for 4 elements
fixed_dofs_4 = [1, num_nodes_4];
free_dofs_4 = setdiff(1:num_nodes_4, fixed_dofs_4);
K_free_4 = K_4(free_dofs_4, free_dofs_4);
M_free_4 = M_4(free_dofs_4, free_dofs_4);
eigvals_4 = eig(M_free_4\K_free_4);
lambda_max_4 = max(abs(eigvals_4));
dt_critical_4 = 2/lambda_max_4;

fprintf('For 4 elements:\n');
fprintf('  Number of nodes: %d\n', num_nodes_4);
fprintf('  Free DOFs: %d\n', length(free_dofs_4));
fprintf('  Maximum eigenvalue: %.6e\n', lambda_max_4);
fprintf('  Critical time step: dt_cr = %.6e s\n', dt_critical_4);

%% Part 5: Steady-state solution with 4 elements
fprintf('\n=== Part 5: Steady-state solution with 4 elements ===\n');

n_elements_steady = 4;
[nodes_steady, K_steady, M_steady] = create_fem_discretization(n_elements_steady, L, k_values, x_boundaries);
num_nodes_steady = length(nodes_steady);

% For steady state: K*a = R, where R accounts for boundary conditions
% Apply boundary conditions: T(0) = T0, T(1.5) = TL
fixed_dofs = [1, num_nodes_steady];
free_dofs = setdiff(1:num_nodes_steady, fixed_dofs);

% Create modified system for steady state
K_free = K_steady(free_dofs, free_dofs);
R_free = -K_steady(free_dofs, 1) * T0 - K_steady(free_dofs, end) * TL;

% Solve for free DOFs
a_free = K_free \ R_free;

% Construct full solution
T_steady = zeros(num_nodes_steady, 1);
T_steady(1) = T0;
T_steady(end) = TL;
T_steady(free_dofs) = a_free;

% Plot steady-state solution
figure('Position', [100, 100, 600, 400]);
plot(nodes_steady, T_steady, 'ro-', 'LineWidth', 2, 'MarkerSize', 8);
grid on;
title('Steady-State Solution (4 Elements)', 'FontSize', 14);
xlabel('$x$ [m]', 'FontSize', 12, 'Interpreter', 'latex');
ylabel('Temperature $T$ [K]', 'FontSize', 12, 'Interpreter', 'latex');
legend('FEM Solution', 'Location', 'best');

% Export steady-state figure
exportgraphics(gcf, 'fem1_hw3_steady_state.png', 'Resolution', 300);

fprintf('Steady-state temperatures at nodes:\n');
for i = 1:num_nodes_steady
    fprintf('  Node %d (x = %.2f): T = %.4f K\n', i, nodes_steady(i), T_steady(i));
end

%% Part 6: Time-dependent solution with 200 elements for different theta values
fprintf('\n=== Part 6: Time-dependent solutions (200 elements) ===\n');

n_elements_transient = 200;
[nodes_trans, K_trans, M_trans] = create_fem_discretization(n_elements_transient, L, k_values, x_boundaries);
num_nodes_trans = length(nodes_trans);

% Time parameters
tend = 0.5;  % End time
theta_cases = [0, 0.5, 1];  % Forward Euler, Crank-Nicolson, Backward Euler
theta_names = {'Forward Euler ($\theta=0$)', 'Crank-Nicolson ($\theta=0.5$)', 'Backward Euler ($\theta=1$)'};

% Calculate critical time step for stability
fixed_dofs = [1, num_nodes_trans];
free_dofs = setdiff(1:num_nodes_trans, fixed_dofs);
K_free = K_trans(free_dofs, free_dofs);
M_free = M_trans(free_dofs, free_dofs);
eigvals = eig(M_free\K_free);
lambda_max = max(abs(eigvals));
dt_critical = 2/lambda_max;

fprintf('Critical time step: dt_cr = %.6e\n', dt_critical);
fprintf('Total simulation time: %.1f s\n', tend);

% Time steps for plotting (11 points like in q1.m)
nTimePlots = 11;
t_plot = linspace(0, tend, nTimePlots);

% Initialize solution storage
solutions = cell(length(theta_cases), 1);

% Define colormap for time evolution (same as q1.m)
startColor = [0, 0, 1];   % Blue
endColor = [1, 0, 0];     % Red
colors = zeros(nTimePlots, 3);
for i = 1:nTimePlots
    frac = (i-1)/(nTimePlots-1);
    colors(i,:) = startColor*(1-frac) + endColor*frac;
end

% Create single figure with subplots for all theta cases
figure('Position', [100, 100, 600, 1000]);

% Define subplot width as a variable for consistent spacing
subplot_width = 0.75;

% Loop through different theta values - create subplots
for theta_idx = 1:length(theta_cases)
    theta = theta_cases(theta_idx);
    
    % Set time step based on theta value
    if theta == 0
        dt = dt_critical;  % Use critical time step for theta=0
    else
        dt = 10 * dt_critical;  % Use 10x critical time step for theta=0.5 and theta=1
    end
    
    fprintf('Solving for %s with dt = %.6e s (%.1fx critical)...\n', ...
        theta_names{theta_idx}, dt, dt/dt_critical);
    
    % Initial condition
    u0 = Ti * ones(num_nodes_trans, 1);
    u0(1) = T0;   % Apply left boundary condition
    u0(end) = TL; % Apply right boundary condition
    
    % Create matrices for time stepping
    % Standard heat equation formulation: M*du/dt + K*u = 0
    % θ-method: (M + θ*dt*K)*u^(n+1) = (M - (1-θ)*dt*K)*u^n
    A = M_trans + theta*dt*K_trans;
    B = M_trans - (1-theta)*dt*K_trans;
    
    % Apply boundary conditions to matrices
    A_free = A(free_dofs, free_dofs);
    B_free = B(free_dofs, free_dofs);
    
    % Time stepping
    u = u0;
    u_history = zeros(num_nodes_trans, nTimePlots);
    u_history(:,1) = u0;  % Store initial condition
    
    % Calculate solutions at specified time points
    current_time = 0;
    next_plot_idx = 2;
    tol = 1e-10;
    
    while current_time < tend && next_plot_idx <= nTimePlots
        % Update time
        current_time = current_time + dt;
        
        % Compute RHS for free DOFs, including boundary contributions
        rhs = B_free * u(free_dofs);
        
        % Add boundary condition contributions from current time step
        % These come from the boundary DOFs that are eliminated from the system
        rhs = rhs + B(free_dofs, 1) * T0 + B(free_dofs, end) * TL;
        rhs = rhs - A(free_dofs, 1) * T0 - A(free_dofs, end) * TL;
        
        % Solve system for free DOFs
        u(free_dofs) = A_free \ rhs;
        
        % Set boundary conditions
        u(1) = T0;   % Left boundary
        u(end) = TL; % Right boundary
        
        % Store solution for plotting
        while next_plot_idx <= nTimePlots && (current_time >= t_plot(next_plot_idx) || abs(current_time - t_plot(next_plot_idx)) < tol)
            u_history(:, next_plot_idx) = u;
            next_plot_idx = next_plot_idx + 1;
        end
    end
    
    % Store solution
    solutions{theta_idx} = u_history;
    
    % Create subplot for this theta case with custom positioning
    subplot_height = 0.22;  % Height for each of 3 subplots
    subplot_bottom = 0.68 - (theta_idx - 1) * 0.32;  % Bottom position (top to bottom)
    subplot('Position', [0.1, subplot_bottom, subplot_width, subplot_height]);
    hold on;
    
    % Plot solution at different time steps with blue-to-red gradient
    for i = 1:nTimePlots
        plot(nodes_trans, u_history(:,i), 'Color', colors(i,:), 'LineWidth', 1.5);
    end
    
    % Plot steady-state solution for comparison
    T_steady_200 = interp1(nodes_steady, T_steady, nodes_trans, 'linear');
    h_ss = plot(nodes_trans, T_steady_200, 'k--', 'LineWidth', 2);
    
    grid on;
    title(theta_names{theta_idx}, 'FontSize', 12, 'Interpreter', 'latex');
    xlabel('$x$ [m]', 'FontSize', 10, 'Interpreter', 'latex');
    ylabel('Temperature $T$ [K]', 'FontSize', 10, 'Interpreter', 'latex');
    ylim([1, 13]);
    
    % Add legend only for the first subplot
    if theta_idx == 1
        legend(h_ss, {'Steady-state solution'}, 'Location', 'SouthWest', 'FontSize', 8);
    end
end

% Add a single colorbar for the entire figure
cb = colorbar('Position', [0.88 0.15 0.03 0.7]);
colormap(colors);
ylabel(cb, 'Time [s]', 'Interpreter', 'latex');
cb.Ticks = linspace(0, 1, 6);

% Create time labels (0, 0.1, 0.2, 0.3, 0.4, 0.5 seconds)
time_labels = cell(1, 6);
for i = 1:6
    t_val = (i-1)*0.1;
    if t_val == 0
        time_labels{i} = '$0$';
    else
        time_labels{i} = sprintf('$%.1f$', t_val);
    end
end
cb.TickLabels = time_labels;
set(cb, 'TickLabelInterpreter', 'latex');

% Export combined time evolution figure
exportgraphics(gcf, 'fem1_hw3_time_evolution_combined.png', 'Resolution', 300);

%% Part 7: Critical time step analysis for theta = 0
fprintf('\n=== Part 7: Critical time step analysis (theta=0) ===\n');

% Calculate critical time step for stability analysis
fixed_dofs = [1, num_nodes_trans];
free_dofs = setdiff(1:num_nodes_trans, fixed_dofs);
K_free = K_trans(free_dofs, free_dofs);
M_free = M_trans(free_dofs, free_dofs);
eigvals = eig(M_free\K_free);
lambda_max = max(abs(eigvals));
dt_critical = 2/lambda_max;

% Use dt slightly larger than critical to demonstrate instability
dt_unstable = 1.01 * dt_critical;  % 0.1% larger than critical
dt_stable = 0.9 * dt_critical;     % 10% smaller than critical

fprintf('Critical time step: dt_cr = %.6e\n', dt_critical);
fprintf('Stable time step: dt_stable = %.6e\n', dt_stable);
fprintf('Unstable time step: dt_unstable = %.6e\n', dt_unstable);

% Simulation time for stability analysis
tend_stability = tend;  % Same as main simulation time
nTimePlots_stab = 11;
t_plot_stab = linspace(0, tend_stability, nTimePlots_stab);

dt_cases = [dt_stable, dt_unstable];
case_names = {'Stable: $\Delta t < \Delta t_{\mathrm{cr}}$', 'Unstable: $\Delta t > \Delta t_{\mathrm{cr}}$'};

% Create single figure with subplots for stability analysis
figure('Position', [200, 200, 600, 800]);

% Use the same subplot width variable for consistency
% subplot_width = 0.75; % Already defined above

% Define colormap for time evolution (same as Part 6)
startColor = [0, 0, 1];   % Blue
endColor = [1, 0, 0];     % Red
colors_stab = zeros(nTimePlots_stab, 3);
for i = 1:nTimePlots_stab
    frac = (i-1)/(nTimePlots_stab-1);
    colors_stab(i,:) = startColor*(1-frac) + endColor*frac;
end

% Loop through stability cases - create subplots
for case_idx = 1:2
    dt_current = dt_cases(case_idx);
    
    % Initial condition
    u0 = Ti * ones(num_nodes_trans, 1);
    u0(1) = T0;
    u0(end) = TL; % Apply right boundary condition
    
    % Matrices for theta = 0 (Forward Euler)
    theta = 0;
    A = M_trans;  % For theta = 0
    B = M_trans - dt_current*K_trans;
    
    % Apply boundary conditions
    A_free = A(free_dofs, free_dofs);
    B_free = B(free_dofs, free_dofs);
    
    % Time stepping
    u = u0;
    u_history_stab = zeros(num_nodes_trans, nTimePlots_stab);
    u_history_stab(:,1) = u0;
    
    current_time = 0;
    next_plot_idx = 2;
    max_allowed = 100;  % Limit for visualization
    
    while current_time < tend_stability && next_plot_idx <= nTimePlots_stab
        current_time = current_time + dt_current;
        
        % Compute RHS for free DOFs, including boundary contributions
        rhs = B_free * u(free_dofs);
        
        % Add boundary condition contributions from current time step
        % These come from the boundary DOFs that are eliminated from the system
        rhs = rhs + B(free_dofs, 1) * T0 + B(free_dofs, end) * TL;
        rhs = rhs - A(free_dofs, 1) * T0 - A(free_dofs, end) * TL;
        
        % Solve system for free DOFs
        u(free_dofs) = A_free \ rhs;
        
        % Set boundary conditions
        u(1) = T0;   % Left boundary
        u(end) = TL; % Right boundary
        
        % Clip extreme values for visualization
        if case_idx == 2 && any(abs(u) > max_allowed)
            % Only log the first clipping event
            if current_time < 0.001  % Only log very early clipping
                fprintf('Clipping unstable solution at t = %.4f\n', current_time);
            end
            u(abs(u) > max_allowed) = sign(u(abs(u) > max_allowed)) * max_allowed;
        end
        
        % Store solution
        while next_plot_idx <= nTimePlots_stab && (current_time >= t_plot_stab(next_plot_idx) || abs(current_time - t_plot_stab(next_plot_idx)) < 1e-10)
            u_history_stab(:, next_plot_idx) = u;
            next_plot_idx = next_plot_idx + 1;
        end
    end
    
    % Create subplot for this stability case with custom positioning
    if case_idx == 1
        subplot('Position', [0.1, 0.55, subplot_width, 0.35]);  % [left, bottom, width, height] - top subplot
    else
        subplot('Position', [0.1, 0.1, subplot_width, 0.35]);   % [left, bottom, width, height] - bottom subplot
    end
    hold on;
    
    % Plot solution at different time steps
    for i = 1:nTimePlots_stab
        plot(nodes_trans, u_history_stab(:,i), 'Color', colors_stab(i,:), 'LineWidth', 1.5);
    end
    
    % Plot steady-state solution for comparison
    T_steady_200 = interp1(nodes_steady, T_steady, nodes_trans, 'linear');
    h_ss = plot(nodes_trans, T_steady_200, 'k--', 'LineWidth', 2);
    
    grid on;
    title(case_names{case_idx}, 'FontSize', 12, 'Interpreter', 'latex');
    xlabel('$x$ [m]', 'FontSize', 10, 'Interpreter', 'latex');
    ylabel('Temperature $T$ [K]', 'FontSize', 10, 'Interpreter', 'latex');
    
    ylim([0, 13]);
    
    % Add legend only for the first subplot
    if case_idx == 1
        legend(h_ss, {'Steady-state solution'}, 'Location', 'SouthWest', 'FontSize', 8);
    end
end

% Add a single colorbar for the entire stability figure
startColor = [0, 0, 1];   % Blue
endColor = [1, 0, 0];     % Red
colors_stab = zeros(nTimePlots_stab, 3);
for i = 1:nTimePlots_stab
    frac = (i-1)/(nTimePlots_stab-1);
    colors_stab(i,:) = startColor*(1-frac) + endColor*frac;
end

cb = colorbar('Position', [0.88 0.15 0.03 0.7]);
colormap(colors_stab);
ylabel(cb, 'Time [s]', 'Interpreter', 'latex');
cb.Ticks = linspace(0, 1, nTimePlots_stab);

% Create time labels for the colorbar
time_labels = cell(1, nTimePlots_stab);
for i = 1:nTimePlots_stab
    t_val = t_plot_stab(i);
    if t_val == 0
        time_labels{i} = '$0$';
    else
        time_labels{i} = sprintf('$%.2f$', t_val);
    end
end
cb.TickLabels = time_labels;
set(cb, 'TickLabelInterpreter', 'latex');

% Export combined stability analysis figure
exportgraphics(gcf, 'fem1_hw3_stability_combined.png', 'Resolution', 300);

fprintf('\nAnalysis complete. All figures generated.\n');
