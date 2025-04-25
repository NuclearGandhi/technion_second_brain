clear; close all; clc;

% FEM1 Homework 1 - Question 1
% Lagrange interpolation of f(x) = (x + sin(x)) * log(1 + x)

% Define the function
f = @(x) (x + sin(x)) .* log(1 + x);

% Define the interval
a = 0;
b = 0.5;
h = b - a;

% Number of interpolation points (4 points for O(h^4) error)
n = 4;

% Generate equally spaced nodes
x_nodes = linspace(a, b, n);

% Calculate function values at nodes
f_values = f(x_nodes);

% Generate points for plotting
x_plot = linspace(a, b, 1000);

% Evaluate original function for plotting
f_plot = f(x_plot);

% Lagrange interpolation
f_interp = zeros(size(x_plot));
for i = 1:length(x_plot)
    f_interp(i) = lagrange_interpolation(x_nodes, f_values, x_plot(i));
end

% Enable LaTeX interpreter for all text
set(0, 'DefaultTextInterpreter', 'latex');
set(0, 'DefaultAxesTickLabelInterpreter', 'latex');
set(0, 'DefaultLegendInterpreter', 'latex');

% Plot the results
figure;
plot(x_plot, f_plot, '-', 'LineWidth', 2);
hold on;
plot(x_plot, f_interp, '--', 'LineWidth', 4);
plot(x_nodes, f_values, 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 8);
legend('Original function $f(x)$', 'Lagrange interpolation', 'Interpolation nodes', 'Location', 'Best');
title('$f(x) = (x + \sin(x)) \cdot \ln(1 + x)$ and its interpolation');
xlabel('$x$');
ylabel('$f(x)$');
grid on;

% Set figure properties
set(gcf, 'Position', [100, 100, 600, 480]); % [x, y, width, height]

% Save the plot with high resolution
print('interpolation_plot', '-dpng', '-r300');

% Calculate and display the maximum error
error = max(abs(f_plot - f_interp));
fprintf('Maximum interpolation error: %.2e\n', error);

% Display the order of truncation error
h_node = (b - a)/(n - 1);  % Distance between nodes
fprintf('Expected error order: O(h^%d) = %.2e\n', n, h_node^n);

% Lagrange interpolation function
function y = lagrange_interpolation(x_nodes, f_values, x)
    n = length(x_nodes);
    y = 0;
    
    for i = 1:n
        L = 1;
        for j = 1:n
            if j ~= i
                L = L * (x - x_nodes(j))/(x_nodes(i) - x_nodes(j));
            end
        end
        y = y + f_values(i) * L;
    end
end