% Define system parameters
m = [1, 1, 1, 1, 1]; % Masses
l = [1, 1, 1, 1, 1]; % Lengths
k = [50, 90, 15, 90, 50]; % Torsional spring constants

% Define the differential equations
dynamics = @(t, theta) [theta(2); 
                        (-k(1)*theta(1) - k(2)*(theta(1) - theta(3))) / (2*m(1)*l(1)^2);
                        theta(4);
                        (-k(2)*(theta(3) - theta(1)) - k(3)*(theta(3) - theta(5))) / (2*m(2)*l(2)^2);
                        theta(6);
                        (-k(3)*(theta(5) - theta(3)) - k(4)*(theta(5) - theta(7))) / (2*m(3)*l(3)^2);
                        theta(8);
                        (-k(4)*(theta(7) - theta(5)) - k(5)*(theta(7) - theta(9))) / (2*m(4)*l(4)^2);
                        theta(10);
                        (-k(5)*(theta(9) - theta(7))) / (2*m(5)*l(5)^2)];

% Initial conditions
theta0 = [0.1; 0; 0.1; 0; 0.1; 0; 0.1; 0; 0.1; 0]; % Initial angles and angular velocities

% Time span
tspan = linspace(0, 10, 1000); % Finer time span for smoother animation

% Solve the differential equations
[t, theta] = ode45(dynamics, tspan, theta0);

% Define the modes
modes = [1, 4/3, 10/7, 4/3, 1; 
         -1, -2/3, 0, 2/3, 1;
         1, -4/3, -10/9, -4/9, 1;
         -1, 2, 0, -2, 1;
         -1, -4, 6, -4, 1];

% Create the 3D animation for all modes in a single figure
figure;
axis equal;
axis([-5 5 -5 5 -5 5]); % Enlarge the viewing boundaries
view(3); % Set the view to 3D
hold on;
masses = gobjects(5, 2);
rods = gobjects(5, 1);
colors = ['b', 'r', 'g', 'm', 'c'];

for i = 1:5
    masses(i, 1) = animatedline('Marker', 'o', 'MarkerSize', 8, 'MarkerFaceColor', colors(i), 'Color', colors(i));
    masses(i, 2) = animatedline('Marker', 'o', 'MarkerSize', 8, 'MarkerFaceColor', colors(i), 'Color', colors(i));
    rods(i) = animatedline('LineWidth', 2, 'Color', 'k');
end

xlabel('X Position');
ylabel('Y Position');
zlabel('Rod Index');
title('3D Physical Animation of All Modes');
grid on;
axis manual; % Fix the axes limits
xlim([-5 5]);
ylim([-5 5]);
zlim([-5 5]);

for i = 1:length(t)
    for j = 1:5
        clearpoints(masses(j, 1));
        clearpoints(masses(j, 2));
        clearpoints(rods(j));
        
        addpoints(masses(j, 1), l(j)*cos(modes(j, j)*theta(i, j)), l(j)*sin(modes(j, j)*theta(i, j)), j);
        addpoints(masses(j, 2), -l(j)*cos(modes(j, j)*theta(i, j)), -l(j)*sin(modes(j, j)*theta(i, j)), j);
        addpoints(rods(j), l(j)*cos(modes(j, j)*theta(i, j)), l(j)*sin(modes(j, j)*theta(i, j)), j);
        addpoints(rods(j), -l(j)*cos(modes(j, j)*theta(i, j)), -l(j)*sin(modes(j, j)*theta(i, j)), j);
    end
    drawnow; % Update the animation
end
