%% Solving Heat Equation using Finite Element Method
% T_t - T_xx = 0, 0 < x < 1
% T(0,t) = 0
% T(1,t) = 0
% T(x,0) = 2x for 0 < x < 0.5
%          2-2x for 0.5 < x < 1

clear all;

%% Solution parameters
num_elements = [2, 50]; % Number of elements to test
final_time = 10/24; % Final time to run simulation to

% We'll solve for 3 cases:
% Case 1: Δt = 1/24, θ = 0.5, h = 0.5
% Case 2: Δt = 1/500, θ = 0.5, h = 0.5
% Case 3: Δt = 1/24, θ = 0, h = 0.5
dt_values = [1/24, 1/500, 1/24];
theta_values = [0.5, 0.5, 0];

%% Setting up outputs
figure('Position', [50 50 800 600]);
legends = {};

%% Loop over the number of elements
for ne_idx = 1:length(num_elements)
    ne = num_elements(ne_idx);
    h = 1/ne; % Element size
    
    % Create mesh
    x = linspace(0, 1, ne+1)';
    
    % Initial condition
    T0 = zeros(ne+1, 1);
    for i = 1:ne+1
        if x(i) <= 0.5
            T0(i) = 2*x(i);
        else
            T0(i) = 2 - 2*x(i);
        end
    end
    
    % Apply boundary conditions
    T0(1) = 0;
    T0(ne+1) = 0;
    
    % Setup stiffness and mass matrices
    K = zeros(ne+1, ne+1);
    M = zeros(ne+1, ne+1);
    
    % Assemble element matrices
    for i = 1:ne
        nodes = [i, i+1];
        
        % Element stiffness matrix
        k_e = [1, -1; -1, 1] / h;
        
        % Element mass matrix
        m_e = [2, 1; 1, 2] * h/6;
        
        % Add to global matrices
        K(nodes, nodes) = K(nodes, nodes) + k_e;
        M(nodes, nodes) = M(nodes, nodes) + m_e;
    end
    
    % Apply boundary conditions to matrices
    K(1,:) = 0; K(:,1) = 0; K(1,1) = 1;
    K(ne+1,:) = 0; K(:,ne+1) = 0; K(ne+1,ne+1) = 1;
    
    M(1,:) = 0; M(:,1) = 0; M(1,1) = 1;
    M(ne+1,:) = 0; M(:,ne+1) = 0; M(ne+1,ne+1) = 1;
    
    % Node at x = 0.5 (middle point)
    mid_idx = find(abs(x - 0.5) < 1e-6);
    if isempty(mid_idx)
        % If no exact node at x=0.5, find closest node
        [~, mid_idx] = min(abs(x - 0.5));
    end
    
    % Loop over different dt and theta values
    for case_idx = 1:length(dt_values)
        dt = dt_values(case_idx);
        theta = theta_values(case_idx);
        
        % Compute matrices for time-stepping
        A = M + theta*dt*K;
        B = M - (1-theta)*dt*K;
        
        % Time-stepping
        T = T0;
        times = 0:dt:final_time;
        T_mid = zeros(size(times));
        T_mid(1) = T(mid_idx);
        
        for t_idx = 2:length(times)
            % Solve for the next time step
            rhs = B*T;
            
            % Apply boundary conditions to right-hand side
            rhs(1) = 0;
            rhs(ne+1) = 0;
            
            % Solve system
            T = A\rhs;
            
            % Store temperature at the middle point
            T_mid(t_idx) = T(mid_idx);
        end
        
        % Plot temperature at x=0.5 over time
        subplot(length(num_elements), length(dt_values), (ne_idx-1)*length(dt_values) + case_idx);
        plot(times, T_mid, 'LineWidth', 1.5);
        grid on;
        title(sprintf('$n_e=%d$, $\\Delta t=1/%d$, $\\theta=%.1f$', ne, round(1/dt), theta), 'Interpreter', 'latex');
        xlabel('Time $t$', 'Interpreter', 'latex');
        ylabel('Temperature $T(0.5,t)$', 'Interpreter', 'latex');
        xlim([0 final_time]);
        
        % Store for consolidated plot
        if ne_idx == 1
            hold on;
        end
    end
end

% Create a consolidated plot showing all cases with ne=50
figure('Position', [50 50 800 400]);
legends = {};

% Regenerate data for ne=50 for all cases
ne = 50;
h = 1/ne; % Element size

% Create mesh
x = linspace(0, 1, ne+1)';

% Initial condition
T0 = zeros(ne+1, 1);
for i = 1:ne+1
    if x(i) <= 0.5
        T0(i) = 2*x(i);
    else
        T0(i) = 2 - 2*x(i);
    end
end

% Apply boundary conditions
T0(1) = 0;
T0(ne+1) = 0;

% Setup stiffness and mass matrices
K = zeros(ne+1, ne+1);
M = zeros(ne+1, ne+1);

% Assemble element matrices
for i = 1:ne
    nodes = [i, i+1];
    
    % Element stiffness matrix
    k_e = [1, -1; -1, 1] / h;
    
    % Element mass matrix
    m_e = [2, 1; 1, 2] * h/6;
    
    % Add to global matrices
    K(nodes, nodes) = K(nodes, nodes) + k_e;
    M(nodes, nodes) = M(nodes, nodes) + m_e;
end

% Apply boundary conditions to matrices
K(1,:) = 0; K(:,1) = 0; K(1,1) = 1;
K(ne+1,:) = 0; K(:,ne+1) = 0; K(ne+1,ne+1) = 1;

M(1,:) = 0; M(:,1) = 0; M(1,1) = 1;
M(ne+1,:) = 0; M(:,ne+1) = 0; M(ne+1,ne+1) = 1;

% Node at x = 0.5 (middle point)
mid_idx = find(abs(x - 0.5) < 1e-6);
if isempty(mid_idx)
    % If no exact node at x=0.5, find closest node
    [~, mid_idx] = min(abs(x - 0.5));
end

% Line styles for different cases
line_styles = {'-', '--', ':'};
colors = {'b', 'r', 'g'};

% Plot comparison for ne=50
subplot(1, 1, 1);
hold on;

for case_idx = 1:length(dt_values)
    dt = dt_values(case_idx);
    theta = theta_values(case_idx);
    
    % Compute matrices for time-stepping
    A = M + theta*dt*K;
    B = M - (1-theta)*dt*K;
    
    % Time-stepping
    T = T0;
    times = 0:dt:final_time;
    T_mid = zeros(size(times));
    T_mid(1) = T(mid_idx);
    
    for t_idx = 2:length(times)
        % Solve for the next time step
        rhs = B*T;
        
        % Apply boundary conditions to right-hand side
        rhs(1) = 0;
        rhs(ne+1) = 0;
        
        % Solve system
        T = A\rhs;
        
        % Store temperature at the middle point
        T_mid(t_idx) = T(mid_idx);
    end
    
    % Plot temperature at x=0.5 over time
    plot(times, T_mid, [line_styles{case_idx}, colors{case_idx}], 'LineWidth', 1.5);
    
    if theta == 0
        legends{case_idx} = sprintf('$\\Delta t=1/%d$, $\\theta=%d$ (Explicit)', round(1/dt), theta);
    else
        legends{case_idx} = sprintf('$\\Delta t=1/%d$, $\\theta=%.1f$ (Crank-Nicolson)', round(1/dt), theta);
    end
end

grid on;
title('Temperature at $x=0.5$ over time ($n_e=50$)', 'Interpreter', 'latex');
xlabel('Time $t$', 'Interpreter', 'latex');
ylabel('Temperature $T(0.5,t)$', 'Interpreter', 'latex');
legend(legends, 'Interpreter', 'latex', 'Location', 'northeast');
xlim([0 final_time]);

% Save figures
saveas(gcf, 'temperature_comparison.png');