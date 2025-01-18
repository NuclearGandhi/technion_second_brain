clc; close all; clear;

% Define constants
R_0 = 1; % Example value
a = 1; % Example value
b = 0.1; % Example value
k_0 = 1; % Example value

% Define range for A
A = linspace(0, 50, 100);

% Calculate E^+ and E^-
E_plus = (4 * R_0) / a * ones(size(A));
E_minus = (pi * b * k_0 * A) / a;

% Calculate A_ST
A_ST = (4 * R_0) / (pi * b * k_0);

% Plot E^+ and E^-
figure;
plot(A, E_plus, 'DisplayName', '$E^+$');
hold on;
plot(A, E_minus, 'DisplayName', '$E^-$');
xline(A_ST, '--k', 'DisplayName', '$A_{ST}$');
xlabel('$A$');
ylabel('Energy');
title('$E^+$ and $E^-$ as a function of $A$', 'Interpreter', 'latex');
legend('Interpreter', 'latex');
grid on;

% Add arrows to indicate convergence to A_ST
y_arrow = 0.5; % Position arrows slightly above the plot
arrow_length = 2; % Length of the arrows
arrow_positions = [A_ST - arrow_length, A_ST + arrow_length];
for pos = arrow_positions
    annotation('textarrow', [A_ST - arrow_length A_ST], [A_ST A_ST + arrow_length], ...
               'String', '', 'HeadStyle', 'plain', 'LineWidth', 1.5);
end

set(gcf, 'Units', 'pixels', 'Position', [100, 100, 600, 400]);

