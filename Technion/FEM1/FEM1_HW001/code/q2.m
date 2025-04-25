% FEM1 Homework 1 - Question 2
% Implementation of complementary error function using Gauss-Legendre quadrature
clear; close all; clc;

% Define interval for plotting
x_plot = linspace(0, 1, 1000);

% Calculate erfc using different methods and number of integration points
erfc_matlab = erfc(x_plot); % Built-in MATLAB function for comparison
erfc_gl_n1 = zeros(size(x_plot));
erfc_gl_n2 = zeros(size(x_plot));

% Calculate erfc using our custom function with Gauss-Legendre quadrature
for i = 1:length(x_plot)
    erfc_gl_n1(i) = my_erfc(x_plot(i), 1); % 1 integration point
    erfc_gl_n2(i) = my_erfc(x_plot(i), 2); % 2 integration points
end

% Enable LaTeX interpreter for all text
set(0, 'DefaultTextInterpreter', 'latex');
set(0, 'DefaultAxesTickLabelInterpreter', 'latex');
set(0, 'DefaultLegendInterpreter', 'latex');

% Plot the results
figure;
plot(x_plot, erfc_matlab, '-', 'LineWidth', 2);
hold on;
plot(x_plot, erfc_gl_n1, '--', 'LineWidth', 2);
plot(x_plot, erfc_gl_n2, '-.', 'LineWidth', 2);
grid on;

% Add labels and legend
xlabel('$x$', 'Interpreter', 'latex');
ylabel('$\mathrm{erfc}(x)$', 'Interpreter', 'latex');
legend('MATLAB $erfc(x)$', 'Gauss-Legendre ($n=1$)', 'Gauss-Legendre ($n=2$)', 'Location', 'best');
title('Complementary Error Function $\mathrm{erfc}(x) = \frac{2}{\sqrt{\pi}}\int_{x}^{\infty} e^{-t^2} dt$', 'Interpreter', 'latex');

% Calculate and display maximum errors
error_n1 = max(abs(erfc_matlab - erfc_gl_n1));
error_n2 = max(abs(erfc_matlab - erfc_gl_n2));
fprintf('Maximum error for n=1: %.6e\n', error_n1);
fprintf('Maximum error for n=2: %.6e\n', error_n2);

% Save the plot with high resolution
set(gcf, 'Position', [100, 100, 600, 480]); % [x, y, width, height]
print('erfc_plot', '-dpng', '-r300');

% Function to calculate erfc using Gauss-Legendre quadrature
function result = my_erfc(x, n)
    % The complementary error function
    % erfc(x) = (2/sqrt(pi)) * integral from x to infinity of exp(-t^2) dt
    
    % We need to transform the infinite integral [x, inf) to a finite interval
    % Using the substitution t = x + (1+s)/(1-s), dt = 2/((1-s)^2) ds
    % This maps [x, inf) to [-1, 1)
    % And the integral becomes:
    % (2/sqrt(pi)) * integral from -1 to 1 of exp(-(x + (1+s)/(1-s))^2) * 2/((1-s)^2) ds
    
    % For n = 1 (1-point Gauss-Legendre)
    if n == 1
        % Weights and nodes for 1-point Gauss-Legendre on [-1,1]
        weights = 2;  % Total interval length is 2
        nodes = 0;
    elseif n == 2
        % Weights and nodes for 2-point Gauss-Legendre on [-1,1]
        weights = [1, 1];  % Each weight is 1 for [-1,1]
        nodes = [-1/sqrt(3), 1/sqrt(3)];
    else
        error('Only n=1 or n=2 is supported in this implementation');
    end
    
    % Calculate the integral using Gauss-Legendre quadrature
    integral_value = 0;
    for i = 1:n
        s = nodes(i);
        t = x + (1+s)/(1-s);
        integrand = exp(-t^2) * (2/((1-s)^2));
        integral_value = integral_value + weights(i) * integrand;
    end
    
    % Multiply by 2/sqrt(pi)
    result = (2/sqrt(pi)) * integral_value;
end