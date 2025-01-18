% filepath: /c:/Users/Ido/Documents/courses/DVI1/proj1/proj.m
% Set default interpreter to 'latex'
set(0, 'DefaultLineLineWidth', 2);
set(groot, 'defaultTextInterpreter', 'latex');
set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
set(groot, 'defaultLegendInterpreter', 'latex');

%% Question 5
% Define global variables
global k m a g c1 c3 theta ell_0 x_eq;
k = 4;
m = 1.0;
a = 1.0;
g = 9.81;
c1 = 0.1;
c3 = 0.001;
theta = deg2rad(30);

equation = @(x_eq, ell_0) (k/m) * x_eq * (1 - ell_0 / sqrt(x_eq^2 + a^2)) - g * sin(theta);

x_eq_initial_guess = 1.0;

options = optimoptions('fsolve', 'Display', 'none');

ell_0 = 0.2;
x_eq_first_solution = fsolve(@(x_eq) equation(x_eq, ell_0), x_eq_initial_guess, options);

fprintf('The root x\\_eq is: %f\n', x_eq_first_solution);

%%  Question 6
ell_0 = 5;

initial_guesses = linspace(-10, 10, 100);

x_eq_second_solution = [];
for guess = initial_guesses
    root = fsolve(@(x_eq) equation(x_eq, ell_0), guess, options);
    if ~any(abs(root - x_eq_second_solution) < 1e-5)
        x_eq_second_solution = [x_eq_second_solution, root];
    end
end

fprintf('Roots: ');
disp(x_eq_second_solution);

%% Question 7
ell_0 = @(x_eq) sqrt(x_eq.^2 + a^2) .* (1 - (m * g * sin(theta)) ./ (k * x_eq));

x_eq_values = linspace(-10, 10, 401);
ell_0_values = ell_0(x_eq_values);

% Set discontinuity at x_eq = 0 to NaN
ell_0_values(abs(x_eq_values) < 1e-5) = NaN;

crit_ell_0 = 3.143;

figure;
hold on;
plot(x_eq_values, ell_0_values, 'DisplayName', '$\ell_0$ as a function of $x_{eq}$');
yline(crit_ell_0, 'r--', 'Label', sprintf('$\\ell_0$ = %.3f', crit_ell_0), 'Interpreter', 'latex');
xlabel('$x_{eq}$', 'Interpreter', 'latex');
ylabel('$\ell_0$', 'Interpreter', 'latex');
title('$\ell_0$ as a function of $x_{eq}$', 'Interpreter', 'latex');
grid on;
legend;
saveas(gcf, 'm-plot-output/q7_el0_vs_xeq.png');
hold off;

%% Question 8
f = @(l_0, x_eq) -(k/m) .* x_eq .* (1 - (l_0 ./ sqrt(x_eq.^2 + a^2))) + g * sin(theta);

ell_0_values = linspace(-10, 10, 200);

x_eq_values = [linspace(-10, -1.07, 200);
    linspace(-1.07, 0, 200);
    linspace(0, 10, 200)];

% Default colors
contour_colors = {'red', 'blue', 'green'};
contour_line_styles = {'-', '--', '-'};
contour_labels = {'Left stable points', 'Unstable points', 'Right stable points'};

figure;
for i = 1:size(x_eq_values, 1)
    [L, X] = meshgrid(ell_0_values, x_eq_values(i, :));
    F = f(L, X);
    hold on;
    contour(L, X, F, [0 0], contour_colors{i}, 'LineWidth', 1.5, 'LineStyle', contour_line_styles{i}, 'DisplayName', contour_labels{i});
end

% Mark the critical point x_eq = -1.07
legend;
scatter(3.143, -1.07, 'black', 'filled', 'DisplayName', 'Critical Point');
grid on;
xlabel('$\ell_0$', 'Interpreter', 'latex');
ylabel('$x_{eq}$', 'Interpreter', 'latex');
title('Contour plot of $f(\ell_0, x_{eq}) = 0$', 'Interpreter', 'latex');
saveas(gcf, sprintf('m-plot-output/q8_f=0_region.png'));
hold off;


%% Question 9
state_space = @(t, x, ell_0) [x(2); -(c1/m)*x(2) - (c3/m)*x(2)^3 - (k/m)*(1 - ell_0/sqrt(x(1)^2 + a^2))*x(1) + g*sin(theta)];

initial_conditions = [0, 0; 3, 0; -1.5, 0; -1.5, 5; 0, -5];

t_span = [0, 25];
t_eval = linspace(t_span(1), t_span(2), 50000);

ell_0_values = [0.2, 5];

for ell_0 = ell_0_values
    figure;
    hold on;
    for x0 = initial_conditions'
        [t, sol] = ode45(@(t, x) state_space(t, x, ell_0), t_eval, x0);
        plot(sol(:, 1), sol(:, 2), 'DisplayName', sprintf('$\\mathbf{x}$ = [%.1f, %.1f]', x0(1), x0(2)));
    end
    if ell_0 == 0.2
        scatter(x_eq_first_solution, 0, 'k', 'filled', 'DisplayName', 'Stable');
    else
        scatter(x_eq_second_solution(1), 0, 'k', 'filled', 'DisplayName', 'Stable');
        scatter(x_eq_second_solution(2), 0, 'b', 'DisplayName', 'Unstable');
        scatter(x_eq_second_solution(3), 0, 'k', 'filled', 'DisplayName', 'Stable');
    end
    xlabel('$x_1$', 'Interpreter', 'latex');
    ylabel('$x_2$', 'Interpreter', 'latex');
    title(sprintf('$\\ell_0 = %.1f$', ell_0));
    legend('Location', 'southwest');
    grid on;
    xlim([-7, 12]);
    ylim([-10, 12.5]);
    saveas(gcf, sprintf('m-plot-output/q9-l0=%.1f.png', ell_0));
    hold off;
end

%% Question 10
zeta = 0.02526;
omega_n = 1.979;
x_eq = x_eq_second_solution(3);
ell_0 = 5;
t_span = [0, 100];
t_eval = linspace(0, 100, 1000);

compute_solution = @(u_0, v_0) deal(...
    @(t) sqrt(u_0^2 + ((zeta * omega_n * u_0 + v_0) / (omega_n * sqrt(1 - zeta^2)))^2) * exp(-zeta * omega_n * t) .* cos(omega_n * sqrt(1 - zeta^2) * t - atan((zeta * omega_n * u_0 + v_0) / (omega_n * sqrt(1 - zeta^2) * u_0))) + x_eq, ...
    ode45(@(t, x) state_space(t, x, ell_0), t_span, [u_0 + x_eq, v_0]));

[x_t_1, sol_1] = compute_solution(2, 0);
[x_t_2, sol_2] = compute_solution(6.7, 0);

function plot_solution(sol, x_t, u_0)
    figure; 
    hold on; 
    plot(sol.x, sol.y(1, :), "-.", 'LineWidth', 2, 'DisplayName', sprintf('Nonlinear solution ($u_0$ = %.1f)', u_0)); 
    plot(sol.x, x_t(sol.x), '--', 'LineWidth', 1.5, 'DisplayName', sprintf('Linearized solution ($u_0$ = %.1f)', u_0)); 
    xlabel('$t$', 'Interpreter', 'latex'); 
    ylabel('$x(t)$', 'Interpreter', 'latex'); 
    title(sprintf('Solution $x(t)$ as a function of time ($u_0 = %.1f$)', u_0), 'Interpreter', 'latex'); 
    legend; 
    grid on; 
    saveas(gcf, sprintf('m-plot-output/q10-u0=%.1f.png', u_0)); 
    hold off;
end

plot_solution(sol_1, x_t_1, 2);
plot_solution(sol_2, x_t_2, 6.7);

%% Question 11
c = 0.001;
omega_n = sqrt(k/m);

initial_conditions = [12, 0; 50, 0];

alt_state_space = @(t, x) [x(2); - (k/m) * x(1) - (c/m) * abs(x(1)) * x(2)^3];

M_0 = @(t, x0) ( (6 * c * omega_n^4 / (5 * pi * k) * t + 1 / x0^3) )^(-1/3);

t_span = [0, 100];
t_eval = linspace(0, 100, 1000);

for i = 1:size(initial_conditions, 1)
    [t, sol] = ode45(@(t, x) alt_state_space(t, x), t_eval, initial_conditions(i, :));
    A_t = arrayfun(@(t) M_0(t, initial_conditions(i, 1)), t_eval);
    figure;
    hold on;
    plot(t, sol(:, 1), 'LineWidth', 2, 'DisplayName', 'Nonlinear solution');
    plot(t, A_t, 'LineWidth', 2, 'DisplayName', 'Amplitude envelope');
    xlabel('t', 'Interpreter', 'latex');
    ylabel('x(t)', 'Interpreter', 'latex');
    title(sprintf('$x_0 = %d$', initial_conditions(i, 1)), 'Interpreter', 'latex');
    legend;
    grid on;
    saveas(gcf, sprintf('m-plot-output/q11-%d.png', i));
    hold off;
end

%% Question 12
%% Part b

omega_values = linspace(0, 10, 1000);

% Calculate |A|/M0 as a function of omega
A_M0 = zeros(size(omega_values));
for i = 1:length(omega_values)
    ceq = c1 + (3/4) * c3 * omega_values(i)^2 * abs(A_M0(i))^2;
    A_M0(i) = sqrt((1 / (x_eq^2 + a^2)).^2 / ...
        ((-m/2 * omega_values(i)^2 + ceq * 1i * omega_values(i) / 2 + k / 2 * (1 - ell_0 * a^2 / (x_eq^2 + a^2)^(3/2)))^2));
    A_M0(i) = abs(A_M0(i));
end

A_M0_analytical = A_M0;

% Plot the result
figure;
plot(omega_values, A_M0, 'LineWidth', 2);
title('Plot of $\frac{|A|}{M_0}$ as a function of $\omega$', 'Interpreter', 'latex');
xlabel('$\omega$', 'Interpreter', 'latex');
ylabel('$\frac{|A|}{M_0}$', 'Interpreter', 'latex');
grid on;
saveas(gcf, 'm-plot-output/q12-e_comparison.png');
hold off;

% Print the values at omega = 0.2 and omega = 10
fprintf('At omega = 0.2, |A|/M0 = %.6f\n', A_M0(20));
fprintf('At omega = 10, |A|/M0 = %.6f\n', A_M0(end));

%% Part c
equation = @(t, y, omega, M_0) [y(2); (m * g * sin(theta) - k * y(1) * (1 - ell_0 / sqrt(y(1)^2 + a^2)) - c1 * y(2) - c3 * y(2)^3 + (M_0 * cos(omega * t)) * a / (y(1)^2 + a^2)) / m];

omega_values = [0.1 * omega_n, 5.0 * omega_n];
M_0_values = [0.1, 10];

t_span = [0, 100 * 2 * pi / omega_n];
t_step = 0.01;
t_eval = linspace(t_span(1), t_span(2), (t_span(2) - t_span(1)) / t_step);

last_10_cycles = cell(1, length(omega_values));

for i = 1:length(omega_values)
    omega = omega_values(i);
    M_0 = M_0_values(i);
    [t, sol] = ode45(@(t, y) equation(t, y, omega, M_0), t_eval, [x_eq, 0]);
    
    start_idx = max(1, length(t) - floor(10 * 2 * pi / omega / t_step));
    last_10_cycles{i} = {t(start_idx:end), sol(start_idx:end, 1)};

    figure;
    hold on;
    plot(t, sol(:, 1), 'DisplayName', sprintf('$\\omega = %.2f, M_0 = %.2f$', omega, M_0));
    xlabel('$t$', 'Interpreter', 'latex');
    ylabel('$x(t)$', 'Interpreter', 'latex');
    title('Response over time for 100 cycles', 'Interpreter', 'latex');
    legend;
    grid on;
    saveas(gcf, sprintf('m-plot-output/q12-c%d.png', i));
    hold off;
end

%% Part d
M_0_normlization = [0.02, 0.0004];
for i = 1:length(omega_values)
    omega = omega_values(i);
    t = last_10_cycles{i}{1};
    x = last_10_cycles{i}{2};
    M_0 = M_0_values(i);
    M_t = M_0 * cos(omega * t);

    x_norm = (x - mean(x)) / std(x);

    residuals = @(params) x_norm - params(1) * cos(omega * t - params(2));
    params = lsqnonlin(residuals, [0.0001, pi/2], [0, -pi], [Inf, pi], optimset('Display', 'none'));
    A_fit = params(1);
    phi_fit = params(2);
    A_M_0 = A_fit * std(x) / M_0;

    figure;
    hold on;
    plot(t, x, 'DisplayName', 'x(t)');
    plot(t, M_0_normlization(i) * M_t + x_eq, 'DisplayName', sprintf('M(t), normalized by %.4f', M_0_normlization(i)));
    plot(t, A_fit * std(x) * cos(omega_values * t - phi_fit) + x_eq, '--', 'DisplayName', 'Fitted response');
    xlabel('t', 'Interpreter', 'latex');
    ylabel('x(t)', 'Interpreter', 'latex');
    title(sprintf('Response for the last 10 cycles, with $\\omega = %.2f$ and $M_0 = %.2f$', omega_values, M_0), 'Interpreter', 'latex');
    ylim([x_eq - 0.01, x_eq + 0.01]);
    legend;
    grid on;
    saveas(gcf, sprintf('m-plot-output/q12-d%d.png', i));
    hold off;

    fprintf('For omega = %.2f and A = %.2f:\n', omega_values, M_0);
    fprintf('Amplitude ratio: %f\n', A_M_0);
    fprintf('Phase difference: %f\n', rad2deg(phi_fit));
end

%% Part e
omega_values = linspace(0, 10, 1000);
M_0_values = [0.1, 1.0, 5.0, 10.0];

t_span = [0, 100 * 2 * pi / omega_values(end)];
t_eval = linspace(t_span(1), t_span(2), 500);

figure;
hold on;
for i = 1:length(M_0_values)
    M_0 = M_0_values(i);
    A_M0_values = zeros(1, length(omega_values));
    for j = 1:length(omega_values)
        omega = omega_values(j);
        [t, sol] = ode45(@(t, y) equation(t, y, omega, M_0), t_eval, [x_eq, 0]);
        steady_state_amplitude = max(abs(sol(end - floor(0.05 * length(sol)):end, 2)));
        A_M0_values(j) = steady_state_amplitude / M_0;
    end
    plot(omega_values, A_M0_values, 'DisplayName', sprintf('$M_0$ = %.1f', M_0));
    if (i == 1)
        A_M0_numeric = A_M0_values;
    end
end
xlabel('$\omega$', 'Interpreter', 'latex');
ylabel('$\frac{|A|}{M_0}$', 'Interpreter', 'latex');
title('Frequency response of the system', 'Interpreter', 'latex');
legend;
grid on;
saveas(gcf, 'm-plot-output/q12-e_combined.png');
hold off;

figure;
hold on;
plot(omega_values, A_M0_numeric, 'DisplayName', 'Numeric');
plot(omega_values, A_M0_analytical, 'DisplayName', 'Analytical', LineStyle='--');
xlabel('$\omega$', 'Interpreter', 'latex');
ylabel('$\frac{|A|}{M_0}$', 'Interpreter', 'latex');
title('Frequency response of the system', 'Interpreter', 'latex');
legend;
grid on;
saveas(gcf, 'm-plot-output/q12-e_comparison.png');
hold off;




