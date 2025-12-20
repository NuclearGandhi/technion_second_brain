%% 1-DOF linear resonator
%
% David Elata, Technion
% Last edited: Tuesday, Feb. 13. 2024
%

%% Pre Proccecing

% Housekeeping
clear all; close all; clc;
% Setting system Parameters
Q = 20; % Quality factor
n = 10; % number of output peaks to analize

% ww = linspace(0.5,1.5,2001); % Frequency range

ww = [linspace(0.5, 0.98, 101), linspace(0.98, 1.02, 501), linspace(1.02, 1.5, 101)]; % Frequency range

%% *Running Simulation*

tstart = tic;

% Preallocate output arrays for parfor
num_freqs = length(ww);
Amp_dis = zeros(1, num_freqs);
Amp_vel = zeros(1, num_freqs);
phi_vel = zeros(1, num_freqs);

parfor i = 1:num_freqs
    % Setting simulation & running
    fprintf("Iteration number: %i  Frequency: %6.4f\n", i, ww(i));
    
    w_i = ww(i);
    tau = 2 * pi / w_i; % period time
    options = odeset('events', @(t, y) events(t, y, Q, w_i), 'Reltol', 1e-7, 'AbsTol', 1e-8, 'MaxStep', tau / 200);
    fun = @(t, y) ME_Linear(t, y, Q, w_i);
    tend = ceil(3 * Q) * tau;
    [t_vctr, sol_mat, te, ye, ie] = ode113(fun, [0 tend], [0 0], options);

    % Ax - maximal displacement during motion cycle
    %      Amplitude of x when v=0 (ie==1) and v is decreasing (i.e. x>0)
    Ax = ye(ie == 1, 1);
    tAx = te(ie == 1);

    % Av - maximal velocity during motion cycle
    %      Amplitude of v when a=0 (ie==2) and a is decreasing (i.e. v>0)
    Av = ye(ie == 2, 2);
    tAv = te(ie == 2);

    % phi - phase between velocity and force
    phi = (1 - mod(tAv, tau) / tau) * (pi * 2);

    % Amplitude calculations
    Amp_dis(i) = mean(Ax(end - n:end));
    Amp_vel(i) = mean(Av(end - n:end));
    % Phase calculation
    phi_vel(i) = mean(phi(end - n:end));
end

% correct phase for vaues over pi/2
phi_vel(phi_vel > pi) = phi_vel(phi_vel > pi) - 2 * pi;

% save('Linear_resonator')

simulation_time = toc(tstart)

%% Plot figures

% Question 1 - average power delivered to the system

close all;

set(gcf, 'Position', [100, 100, 600, 400]);

P_avg = 0.5 * ww .* Amp_dis .* cos(phi_vel);
P_max = max(P_avg);
P_max_index = find(P_avg == P_max);
P_max_omega = ww(P_max_index);

figure(1)
plot(ww, P_avg, '-');
hold on; 
plot(P_max_omega, P_max, 'o');
grid on;
title('Average Power Delivered to the System');
xlabel('$\tilde{\omega}$');
xticks(0.5:0.1:1.5);
ylabel('$P_{\mathrm{avg}}$');
ylim([-1, 11]);

exportgraphics(gcf, 'average_power_delivered_to_the_system.png', 'Resolution', 300);

% Question 3 - Total energy of the system during one period
% at resonance in displacement and velocity. Plot the energy
% as a function of time.

omega_x = sqrt(1 - 1 / (2 * Q^2));
omega_v = 1;

omega_range = [omega_x, omega_v];
labels = {'$\tilde{\omega}_{x}=\sqrt{1-\frac{1}{2Q^2}}$', '$\tilde{\omega}_v = 1$ (max velocity)'};

% Store results for both frequencies
t_norm_cell = cell(1, 2);
E_total_cell = cell(1, 2);

for i = 1:length(omega_range)
    omega = omega_range(i);
    tau = 2 * pi / omega; % period time
    options = odeset('Reltol', 1e-7, 'AbsTol', 1e-8, 'MaxStep', tau / 200);
    fun = @(t, y) ME_Linear(t, y, Q, omega);
    tend = ceil(3 * Q) * tau;
    [t_vctr, sol_mat] = ode113(fun, [0 tend], [0 0], options);

    % Extract the last period (steady state)
    t_last_period_start = t_vctr(end) - tau;
    idx = t_vctr >= t_last_period_start;
    t_period = t_vctr(idx) - t_last_period_start; % normalize to start from 0
    x_period = sol_mat(idx, 1);
    v_period = sol_mat(idx, 2);

    % Total energy: kinetic + potential
    t_norm_cell{i} = t_period / tau;
    E_total_cell{i} = 0.5 * v_period.^2 + 0.5 * x_period.^2;
end

% Main figure
figure(2)
set(gcf, 'Position', [100, 100, 700, 400]);
hold on;

plot(t_norm_cell{1}, E_total_cell{1}, '-', 'DisplayName', labels{1});
plot(t_norm_cell{2}, E_total_cell{2}, '--', 'DisplayName', labels{2});

grid on;
title('Total Energy during One Period at Resonance');
xlabel('$\tilde{t}/\tau$');
ylabel('$E_{\mathrm{total}}$');
xlim([0, 1]);
ylim([0, 220]);
legend('Location', 'southwest');

% Inset axes for zoomed view
inset_ax = axes('Position', [0.6, 0.35, 0.35, 0.4]);
hold(inset_ax, 'on');

plot(inset_ax, t_norm_cell{1}, E_total_cell{1}, '-');
plot(inset_ax, t_norm_cell{2}, E_total_cell{2}, '--');

% Set zoom limits to show the oscillation difference
E_mean = mean(E_total_cell{2});
E_range = max(E_total_cell{1}) - min(E_total_cell{1});
ylim(inset_ax, [E_mean - 1.5*E_range, E_mean + 1.5*E_range]);
xlim(inset_ax, [0, 1]);

grid(inset_ax, 'on');
box(inset_ax, 'on');
set(inset_ax, 'FontSize', 8);
title(inset_ax, 'Zoomed View of Energy Oscillations');


exportgraphics(gcf, 'total_energy_one_period.png', 'Resolution', 300);

%% Momentum equation of a linear resonator subjected to harmonic force at frequency w

function dy = ME_Linear(t, y, Q, w)

    % momentum equation of 1 degree of freedom system
    % second order regular differential equation
    % y(1) ->  x
    % y(2) ->  x'
    % Q - quality factor
    % w - harmonic force frequency

    dy = zeros(2, 1);
    dy(1) = y(2);
    dy(2) = cos(w * t) - y(1) - 1 / Q * y(2);
end

% Events Functions
function [check, isterminal, direction] = events(t, y, Q, w)
    x = y(1); % displacement
    v = y(2); % velocity
    a = cos(w * t) - y(1) - 1 / Q * y(2); % acceleration

    % check = [v=0,a=0]
    check = [v, a]; % The value that we want to be zero
    isterminal = [0, 0]; % Halt integration:  0 = no
    direction = [-1, -1];
    % direction(i) =  1 locates only zeros where the event function is increasing,
    % direction(i) = -1 locates only zeros where the event function is decreasing.
end
