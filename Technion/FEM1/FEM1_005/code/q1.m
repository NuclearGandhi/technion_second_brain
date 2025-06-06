close all; clear; clc;

%% Problem Parameters
L = 1;      % Domain length
tend = 10/24; % End time

% Define parameters for the three initial cases
dt_cases = [1/24, 1/500, 1/24];   % Delta t values
theta_cases = [0.5, 0.5, 0];      % Theta values
titles = {'Case 1: $\Delta t = 1/24$, $\theta = 0.5$', ...
    'Case 2: $\Delta t = 1/500$, $\theta = 0.5$', ...
    'Case 3: $\Delta t = 1/24$, $\theta = 0$'};

% Define number of elements for the two discretizations
n_elements = [2, 50];

% Time steps to plot (including t=0, so 11 total points)
nTimePlots = 11;
t_plot = linspace(0, tend, nTimePlots);

% Define colormap for time evolution
startColor = [0, 0, 1];   % Blue
endColor = [1, 0, 0];     % Red
colors = zeros(nTimePlots, 3);
for i = 1:nTimePlots
    frac = (i-1)/(nTimePlots-1);
    colors(i,:) = startColor*(1-frac) + endColor*frac;
end

%% Loop through each case
for caseIdx = 1:3
    dt = dt_cases(caseIdx);
    theta = theta_cases(caseIdx);

    % Create a new figure
    fig = figure('Position', [100, 100, 1000, 500]);

    % Loop through the two discretizations
    for discIdx = 1:2
        num_elements = n_elements(discIdx);
        h = L/num_elements;  % Element size

        % Create nodes
        nodes = linspace(0, L, num_elements+1)';
        num_nodes = length(nodes);

        % Initial condition
        u0 = zeros(num_nodes, 1);
        for i = 1:num_nodes
            x = nodes(i);
            if x <= 0.5
                u0(i) = 2*x;
            else
                u0(i) = 2-2*x;
            end
        end

        % Apply boundary conditions (first and last nodes are fixed to zero)
        fixed_dofs = [1, num_nodes];
        free_dofs = setdiff(1:num_nodes, fixed_dofs);

        % Assemble global matrices
        K = zeros(num_nodes, num_nodes);
        M = zeros(num_nodes, num_nodes);

        for e = 1:num_elements
            % Element nodes
            n1 = e;
            n2 = e+1;

            % Element length
            he = nodes(n2) - nodes(n1);

            % Element stiffness matrix
            Ke = (1/he) * [1, -1; -1, 1];

            % Element mass matrix
            Me = (he/6) * [2, 1; 1, 2];

            % Assemble into global matrices
            K(n1:n2, n1:n2) = K(n1:n2, n1:n2) + Ke;
            M(n1:n2, n1:n2) = M(n1:n2, n1:n2) + Me;
        end

        % If this is case 3 (theta=0), calculate critical time step
        if caseIdx == 3 && discIdx == 2  % Only for the 50-element case
            % Compute critical time step by finding eigenvalues
            K_free = K(free_dofs, free_dofs);
            M_free = M(free_dofs, free_dofs);
            eigvals = eig(M_free\K_free);
            lambda_max = max(abs(eigvals));
            dt_critical = 2/lambda_max;
            fprintf('Calculated critical time step for %d elements (θ=0): Δt_cr = %g\n', ...
                num_elements, dt_critical);
        end

        % Create matrices for time stepping
        A = M + theta*dt*K;
        B = M - (1-theta)*dt*K;

        % Apply boundary conditions
        A_free = A(free_dofs, free_dofs);
        B_free = B(free_dofs, free_dofs);

        % Time stepping
        u = u0;
        u_history = zeros(num_nodes, nTimePlots);
        u_history(:,1) = u0;  % Store initial condition

        % Calculate the solutions at specific time points
        current_time = 0;
        next_plot_idx = 2;

        % Define a small tolerance for floating-point comparisons
        tol = 1e-10;

        while current_time < tend && next_plot_idx <= nTimePlots
            % Update time
            current_time = current_time + dt;

            % Compute RHS
            rhs = B(free_dofs, free_dofs) * u(free_dofs);

            % Solve system
            u(free_dofs) = A_free \ rhs;

            % Store solution for plotting if we've passed or are very close to a time point of interest
            while next_plot_idx <= nTimePlots && (current_time >= t_plot(next_plot_idx) || abs(current_time - t_plot(next_plot_idx)) < tol)
                u_history(:, next_plot_idx) = u;
                next_plot_idx = next_plot_idx + 1;
            end
        end

        % Ensure all time points have solutions by interpolating any missing ones
        for i = 2:nTimePlots
            if all(u_history(:,i) == 0) % If this time point wasn't captured
                fprintf('Interpolating solution for time point %d (t = %f)\n', i, t_plot(i));
                % Find the nearest time points that were captured
                prev_idx = i-1;
                next_idx = i+1;
                while next_idx <= nTimePlots && all(u_history(:,next_idx) == 0)
                    next_idx = next_idx + 1;
                end

                if next_idx <= nTimePlots
                    % Linear interpolation between prev_idx and next_idx
                    alpha = (t_plot(i) - t_plot(prev_idx)) / (t_plot(next_idx) - t_plot(prev_idx));
                    u_history(:,i) = (1-alpha) * u_history(:,prev_idx) + alpha * u_history(:,next_idx);
                else
                    % If we couldn't find a next point, extrapolate from previous
                    u_history(:,i) = u_history(:,prev_idx);
                end
            end
        end

        % Create subplot
        subplot(1, 2, discIdx);
        hold on;

        % Plot solution at different time steps
        x_fine = linspace(0, L, 200);

        for i = 1:nTimePlots
            % For plotting a smooth curve, interpolate the solution
            if num_elements == 2
                % For 2 elements, we can manually interpolate
                u_fine = zeros(size(x_fine));
                for j = 1:length(x_fine)
                    xj = x_fine(j);
                    % Find which element this point is in
                    if xj <= nodes(2)  % First element
                        % Linear interpolation in first element
                        u_fine(j) = u_history(1,i) * (nodes(2)-xj)/h + u_history(2,i) * (xj-nodes(1))/h;
                    else  % Second element
                        % Linear interpolation in second element
                        u_fine(j) = u_history(2,i) * (nodes(3)-xj)/h + u_history(3,i) * (xj-nodes(2))/h;
                    end
                end
            else
                % For more elements, use MATLAB's interp1
                u_fine = interp1(nodes, u_history(:,i), x_fine, 'linear');
            end

            % Plot with color based on time
            plot(x_fine, u_fine, 'Color', colors(i,:), 'LineWidth', 1.5);
        end

        % Format plot
        grid on;
        title(sprintf('$%d$ Elements', num_elements), 'Interpreter', 'latex', 'FontSize', 12);
        xlabel('$x$', 'Interpreter', 'latex');
        ylabel('$T(x,t)$', 'Interpreter', 'latex');
        ylim([0, 1.1]);

    end

    % Create a single colorbar for the figure
    cb = colorbar('Position', [0.92, 0.1, 0.02, 0.8]);
    colormap(colors);

    % Label the colorbar with actual time values (0, 1/24, 2/24, ...)
    ylabel(cb, 'Time', 'Interpreter', 'latex');
    cb.Ticks = linspace(0, 1, 6);

    % Create actual time labels
    time_labels = cell(1, 6);
    for i = 1:6
        t_val = (i-1)*2/24;  % 0, 2/24, 4/24, 6/24, 8/24, 10/24
        if i == 1
            time_labels{i} = '$0$';
        else
            time_labels{i} = ['$\frac{', num2str((i-1)*2), '}{24}$'];
        end
    end
    cb.TickLabels = time_labels;
    set(cb, 'TickLabelInterpreter', 'latex');

    % Add main title for the figure
    sgtitle(titles{caseIdx}, 'Interpreter', 'latex', 'FontSize', 14);

    % Save figure
    filename = sprintf('fem1_005_case%d.png', caseIdx);
    exportgraphics(fig, filename, 'Resolution', 300);
end

fprintf('Plotting complete. Figures saved as fem1_005_case1.png, fem1_005_case2.png, and fem1_005_case3.png\n');

%% Case 4: Stability Comparison for θ=0
% Add a new figure showing stability for θ=0 cases with 50 elements
fprintf('\nCreating stability comparison figure for θ=0 with 50 elements...\n');

% Create a new figure
fig = figure('Position', [100, 100, 1000, 500]);

% Setup for θ=0 stability comparison
theta = 0;  % We'll use Forward Euler (θ=0)
num_elements = 50;  % Use 50 elements as requested
h = L/num_elements;

% Create nodes
nodes = linspace(0, L, num_elements+1)';
num_nodes = length(nodes);

% Initial condition
u0 = zeros(num_nodes, 1);
for i = 1:num_nodes
    x = nodes(i);
    if x <= 0.5
        u0(i) = 2*x;
    else
        u0(i) = 2-2*x;
    end
end

% Apply boundary conditions
fixed_dofs = [1, num_nodes];
free_dofs = setdiff(1:num_nodes, fixed_dofs);

% Assemble global matrices
K = zeros(num_nodes, num_nodes);
M = zeros(num_nodes, num_nodes);

for e = 1:num_elements
    % Element nodes
    n1 = e;
    n2 = e+1;

    % Element length
    he = nodes(n2) - nodes(n1);

    % Element stiffness matrix
    Ke = (1/he) * [1, -1; -1, 1];

    % Element mass matrix
    Me = (he/6) * [2, 1; 1, 2];

    % Assemble into global matrices
    K(n1:n2, n1:n2) = K(n1:n2, n1:n2) + Ke;
    M(n1:n2, n1:n2) = M(n1:n2, n1:n2) + Me;
end

% Calculate critical time step
K_free = K(free_dofs, free_dofs);
M_free = M(free_dofs, free_dofs);
eigvals = eig(M_free\K_free);
lambda_max = max(abs(eigvals));
dt_critical = 2/lambda_max;
fprintf('Calculated critical time step for %d elements (θ=0): Δt_cr = %g\n', ...
    num_elements, dt_critical);

% Create two cases: one stable, one unstable
% Use a very small factor above critical for unstable case to avoid extreme instability
dt_unstable = dt_critical * 1.0005;  % Just 0.05% larger than critical (slightly unstable)
dt_stable = dt_critical * 0.8;     % 20% smaller than critical (stable)
dt_values = [dt_unstable, dt_stable];

fprintf('  - Unstable case: Δt = %g (> Δt_cr = %g)\n', dt_unstable, dt_critical);
fprintf('  - Stable case: Δt = %g (< Δt_cr = %g)\n', dt_stable, dt_critical);

% Use the same time range as the other cases
tend_stability = tend;  % 10/24, same as the first three cases

% Number of time steps to save (evenly spaced)
nTimePlots = 11;
t_plot = linspace(0, tend_stability, nTimePlots);

% Define subplot titles
subplot_titles = {'Unstable: $\Delta t > \Delta t_{cr}$', 'Stable: $\Delta t < \Delta t_{cr}$'};

% Loop through stable and unstable cases
for caseIdx = 1:2
    dt = dt_values(caseIdx);

    % Create matrices for time stepping with θ=0
    A = M + theta*dt*K;  % M for θ=0
    B = M - (1-theta)*dt*K;  % M - dt*K for θ=0

    % Apply boundary conditions
    A_free = A(free_dofs, free_dofs);
    B_free = B(free_dofs, free_dofs);

    % Time stepping
    u = u0;
    u_history = zeros(num_nodes, nTimePlots);
    u_history(:,1) = u0;  % Store initial condition

    % Calculate the solutions at specific time points
    current_time = 0;
    next_plot_idx = 2;

    % Define a small tolerance for floating-point comparisons
    tol = 1e-10;

    % For unstable case, we'll monitor and limit extremes
    max_allowed_value = 10;  % Limit how large values can get for better visualization

    while current_time < tend_stability && next_plot_idx <= nTimePlots
        % Update time
        current_time = current_time + dt;

        % Compute RHS
        rhs = B(free_dofs, free_dofs) * u(free_dofs);

        % Solve system
        u(free_dofs) = A_free \ rhs;

        % For unstable case, check if solution is growing too large
        if caseIdx == 1 && any(abs(u) > max_allowed_value)
            fprintf('Solution becoming too unstable at t = %g. Clipping values.\n', current_time);
            % Clip values to maintain reasonable scale
            too_large = abs(u) > max_allowed_value;
            u(too_large) = sign(u(too_large)) * max_allowed_value;
        end

        % Store solution for plotting if we've passed or are very close to a time point of interest
        while next_plot_idx <= nTimePlots && (current_time >= t_plot(next_plot_idx) || abs(current_time - t_plot(next_plot_idx)) < tol)
            u_history(:, next_plot_idx) = u;
            next_plot_idx = next_plot_idx + 1;
        end
    end

    % Ensure all time points have solutions
    for i = 2:nTimePlots
        if all(u_history(:,i) == 0) % If this time point wasn't captured
            fprintf('Interpolating stability solution for time point %d (t = %f)\n', i, t_plot(i));
            % Find the nearest time points that were captured
            prev_idx = i-1;
            next_idx = i+1;
            while next_idx <= nTimePlots && all(u_history(:,next_idx) == 0)
                next_idx = next_idx + 1;
            end

            if next_idx <= nTimePlots
                % Linear interpolation between prev_idx and next_idx
                alpha = (t_plot(i) - t_plot(prev_idx)) / (t_plot(next_idx) - t_plot(prev_idx));
                u_history(:,i) = (1-alpha) * u_history(:,prev_idx) + alpha * u_history(:,next_idx);
            else
                % If we couldn't find a next point, extrapolate from previous
                u_history(:,i) = u_history(:,prev_idx);
            end
        end
    end

    % Plot the results
    subplot(1, 2, caseIdx);
    hold on;

    % Define colormap for time evolution (like in the original cases)
    startColor = [0, 0, 1];   % Blue
    endColor = [1, 0, 0];     % Red
    colors_stability = zeros(nTimePlots, 3);
    for i = 1:nTimePlots
        frac = (i-1)/(nTimePlots-1);
        colors_stability(i,:) = startColor*(1-frac) + endColor*frac;
    end

    % Fine x grid for plotting
    x_fine = linspace(0, L, 200);

    % Plot solution at different time steps
    for i = 1:nTimePlots
        % Interpolate for smooth plotting
        u_fine = interp1(nodes, u_history(:,i), x_fine, 'linear');

        % Plot with color based on time
        plot(x_fine, u_fine, 'Color', colors_stability(i,:), 'LineWidth', 1.5);
    end

    % Format plot
    grid on;
    title(subplot_titles{caseIdx}, 'Interpreter', 'latex', 'FontSize', 12);
    xlabel('$x$', 'Interpreter', 'latex');
    ylabel('$T(x,t)$', 'Interpreter', 'latex');

    % Use a reasonable y-range for the unstable case to see oscillations
    ylim([-0.5, 1.1]);
end

% Create a single colorbar for the figure
cb = colorbar('Position', [0.92, 0.1, 0.02, 0.8]);
colormap(colors_stability);

% Label the colorbar with actual time values (0, 1/24, 2/24, ...)
ylabel(cb, 'Time', 'Interpreter', 'latex');
cb.Ticks = linspace(0, 1, 6);

% Create actual time labels (same as original cases)
time_labels = cell(1, 6);
for i = 1:6
    t_val = (i-1)*2/24;  % 0, 2/24, 4/24, 6/24, 8/24, 10/24
    if i == 1
        time_labels{i} = '$0$';
    else
        time_labels{i} = ['$\frac{', num2str((i-1)*2), '}{24}$'];
    end
end
cb.TickLabels = time_labels;
set(cb, 'TickLabelInterpreter', 'latex');

% Add main title for the figure
sgtitle(['Case 4: Stability Comparison for Forward Euler ($\theta=0$) with $50$ Elements, $\Delta t_{cr} = ', ...
    num2str(dt_critical, '%.6f'), '$'], 'Interpreter', 'latex', 'FontSize', 14);

% Save figure
filename = 'fem1_005_case4.png';
exportgraphics(fig, filename, 'Resolution', 300);
fprintf('Stability comparison figure saved as %s\n', filename);