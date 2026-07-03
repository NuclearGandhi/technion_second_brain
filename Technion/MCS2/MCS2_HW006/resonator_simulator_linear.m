%% 1-DOF linear resonator
%
% David Elata, Technion
% Last edited: Tuesday, June. 30. 2026
%

%% Pre Proccecing

% Housekeeping
clear all; close all; clc;
% Setting system Parameters
Q = 20; % Quality factor
n = 10;  % number of output peaks to analize

y_initial = [0 0]; % Initial initial conditions
ww = linspace(0.5,1.5,51); % Frequency range

%% *Running Simulation*

tend = 200;

tstart = tic
for i=1:length(ww)
    % Setting simulation & running
    fprintf("Iteration number: %i  Frequency: %6.4f",i , ww(i)); fprintf('\n');
    % fprintf("Iteration number: %i  ",i ,"Frequency  ", ww(i)); fprintf('\n');

    options = odeset('events',@(t,y) events(t,y,Q,ww(i)),'Reltol',1e-7,'AbsTol',1e-8,'MaxStep',1/200);
    fun = @(t,y) ME_Linear(t,y,Q,ww(i));

    [t_vctr,sol_mat,te,ye,ie] = ode113(fun, [0 tend], y_initial, options);

    % Ax - maximal displacement during motion cycle
    %      Amplitude of x when v=0 (ie==1) and v is decreasing (i.e. x>0)
    Ax = ye( ie==1 , 1);
    tAx= te( ie==1    );

    % Av - maximal velocity during motion cycle
    %      Amplitude of v when a=0 (ie==2) and a is decreasing (i.e. v>0)
    Av = ye( ie==2 , 2);
    tAv= te( ie==2    );

    % Amplitude calculations
    Amp_dis(i) = mean( Ax(end-n:end));
    Amp_vel(i) = mean( Av(end-n:end));
    % Phase calculation

end

% save('Linear_resonator')

simulation_time = toc(tstart)

%% load Data
% % Linear.mat
% clc; close all; clear all;
% % load
% load('Linear_resonator.mat')
% whos;


%% Plotting

close all

figure(1)
% Plot displacement and velocity, last n_points points in time
hold on; box on; grid on;
n_points = 600;
plot(t_vctr(end-n_points:end),sol_mat(end-n_points:end,1),'b.');
plot(t_vctr(end-n_points:end),sol_mat(end-n_points:end,2),'r.');
plot(t_vctr(end-n_points:end),sin(ww(end)*t_vctr(end-n_points:end)),'g-');
plot(tAx(end),Ax(end),'b*');
plot(tAv(end),Av(end),'r*');
set(gca,'FontSize',18);

figure(2)
hold on; box on; grid on;
plot(ww,Amp_dis,'b-','linewidth',3);
plot(ww,Amp_vel,'r--','linewidth',3);
set(gca,'FontSize',18);

figure(3)
hold on; box on; grid on;
plot(ww,Amp_dis,'b-','linewidth',3);
set(gca,'FontSize',18);

figure(4)
hold on; box on; grid on;
plot(ww,Amp_vel,'r--','linewidth',3);
set(gca,'FontSize',18);


%% Momentum equation of a linear resonator subjected to harmonic force at frequency w

function dy = ME_Linear(t,y,Q,w)

% momentum equation of 1 degree of freedom system
% second order regular differential equation
% y(1) ->  x
% y(2) ->  x'
% Q - quality factor
% w - harmonic force frequency

dy = zeros(2,1);
dy(1) = y(2);
dy(2) = sin(w*t) - y(1) - 1/Q*y(2) ;
end

% Events Functions
function [check,isterminal,direction] = events(t,y,Q,w)
x = y(1); % displacement
v = y(2); % velocity
a = sin(w*t) - y(1) - 1/Q*y(2) ; % acceleration

% check = [v=0,a=0]
check = [v,a]; % The value that we want to be zero
isterminal = [0,0];  % Halt integration:  0 = no
direction = [-1,-1];
% direction(i) =  1 locates only zeros where the event function is increasing,
% direction(i) = -1 locates only zeros where the event function is decreasing.
end


