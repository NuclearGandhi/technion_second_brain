% MATLAB script to plot the stress function sigma_theta_theta(r,theta) at theta = 90 degrees
% Equation: sigma_theta_theta(r,theta) = (sigma/2)[1+(a/r)^2] - (sigma/2)[1+3(a/r)^4]cos(2*theta)

% Set up LaTeX interpreter for plots
set(0, 'DefaultTextInterpreter', 'latex');
set(0, 'DefaultAxesTickLabelInterpreter', 'latex');
set(0, 'DefaultLegendInterpreter', 'latex');

% Define parameters
a = 7;            % Given parameter
sigma = 1;        % Unit stress (can be scaled as needed)
r_values = linspace(7, 48, 100);  % r from a to 48
theta = pi/2;     % Fixed θ = 90 degrees (π/2 radians)

% Calculate sigma_theta_theta using the given equation for θ = 90°
sigma_theta_theta_90 = (sigma/2) * (1 + (a./r_values).^2) - (sigma/2) * (1 + 3*(a./r_values).^4) .* cos(2*theta);

% Create figure with specified size (600x400)
figure('Position', [100, 100, 600, 400]);

% Plot stress vs radial distance
plot(r_values, sigma_theta_theta_90, 'LineWidth', 2);

% Add grid and formatting
grid on;
xlabel('Radial Distance $r$', 'FontSize', 12);
ylabel('$\sigma_{\theta\theta}(r, \theta=90^{\circ})$', 'FontSize', 12);
title('Stress Function at $\theta = 90^{\circ}$', 'FontSize', 14);

% Add a text box with the equation
equation_text = ['$\sigma_{\theta\theta}(r,\theta=90^{\circ})=\frac{\sigma}{2}\left[ 1+\left( \frac{a}{r} \right)^{2} \right]-'...
                '\frac{\sigma}{2}\left[ 1+3\left( \frac{a}{r} \right)^{4} \right]\cos (2 \cdot 90^{\circ})$'];
            
% At 90 degrees, cos(2θ) = cos(180°) = -1, so the equation simplifies to:
simplified_text = ['$\sigma_{\theta\theta}(r,90^{\circ})=\frac{\sigma}{2}\left[ 1+\left( \frac{a}{r} \right)^{2} \right]+'...
                  '\frac{\sigma}{2}\left[ 1+3\left( \frac{a}{r} \right)^{4} \right]$'];
                

% Add a text box with the parameters
param_text = ['$a = ', num2str(a), ', \, r \in [', num2str(min(r_values)), ',', num2str(max(r_values)), ']$'];

% Save the figure
print('stress_theta_theta_90deg', '-dpng', '-r300');