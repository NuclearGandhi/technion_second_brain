clc; clear; close all;

% Read the CSV files
data1 = readtable('../data/cond1.csv');
data2 = readtable('../data/cond2.csv');

% Extract the temperature data for the specified range
temp1 = data1.Li1(18:144);
temp2 = data2.Li1(18:144);

% Calculate the average temperature
avg_temp = (temp1 + temp2) / 2;

% Generate the length data for the specified range and convert to mm
length_pixels = (18:144)' - 18;
pixels_to_mm = 190 / 120;
length_mm = length_pixels * pixels_to_mm;

% Plot the temperature vs length graph
figure;
plot(length_mm, avg_temp, 'x', 'MarkerSize', 8);
title('Average Temperature vs Length');
xlabel('$L$ (mm)');
ylabel('$T$ ($^\circ$C)');
grid on;
legend('Average Temperature');

steel = [0, 45];
granite = [45, 96];
aluminum = [96, 175];
glass = [183, 200];


% Convert to pixels (in integers)
steel = round(steel .* pixels_to_mm^-1);
granite = round(granite .* pixels_to_mm^-1);
aluminum = round(aluminum .* pixels_to_mm^-1);
glass = round(glass .* pixels_to_mm^-1);


% Calculate the slope of the temperature vs length graph in each material
steel_slope = polyfit(length_pixels(steel(1)+1:steel(2)), avg_temp(steel(1)+1:steel(2)), 1);
granite_slope = polyfit(length_pixels(granite(1)+1:granite(2)), avg_temp(granite(1)+1:granite(2)), 1);
aluminum_slope = polyfit(length_pixels(aluminum(1)+1:aluminum(2)), avg_temp(aluminum(1)+1:aluminum(2)), 1);
glass_slope = polyfit(length_pixels(glass(1)+1:glass(2)), avg_temp(glass(1)+1:glass(2)), 1);

% Draw the lines on the graph
hold on;
plot(length_mm(steel(1)+1:steel(2)), polyval(steel_slope, length_pixels(steel(1)+1:steel(2))), 'LineWidth', 2, 'DisplayName', 'Stainless Steel');
plot(length_mm(granite(1)+1:granite(2)), polyval(granite_slope, length_pixels(granite(1)+1:granite(2))), 'LineWidth', 2, 'DisplayName', 'Granite');
plot(length_mm(aluminum(1)+1:aluminum(2)), polyval(aluminum_slope, length_pixels(aluminum(1)+1:aluminum(2))), 'LineWidth', 2, 'DisplayName', 'Aluminum');
plot(length_mm(glass(1)+1:glass(2)), polyval(glass_slope, length_pixels(glass(1)+1:glass(2))), 'LineWidth', 2, 'DisplayName', 'Glass');


set(gcf, 'Position', [100, 100, 1200, 600]);
% exportgraphics(gcf, 'cond.png', 'Resolution', 300);

% The units are T/pixels, so we need to convert to T/mm
steel_slope = steel_slope * pixels_to_mm^-1;
granite_slope = granite_slope * pixels_to_mm^-1;
aluminum_slope = aluminum_slope * pixels_to_mm^-1;
glass_slope = glass_slope * pixels_to_mm^-1;

disp('Stainless Steel:');
disp(steel_slope(1));
disp('Granite:');
disp(granite_slope(1));
disp('Aluminum:');
disp(aluminum_slope(1));
disp('Glass:');
disp(glass_slope(1));

% Calculate the ratios between the slope of steel to the slope of the other materials
steel_to_granite = steel_slope(1) / granite_slope(1);
steel_to_aluminum = steel_slope(1) / aluminum_slope(1);
steel_to_glass = steel_slope(1) / glass_slope(1);

% These ratiors are ^-1 of the ratios between steel conductivity to the other materials
disp('Stainless Steel to Granite:');
disp(steel_to_granite^-1);
disp('Stainless Steel to Aluminum:');
disp(steel_to_aluminum^-1);
disp('Stainless Steel to Glass:');
disp(steel_to_glass^-1);

steel_cond = 18; % W/mK
A = 0.150 * 0.150; % m^2
q_steel = -steel_cond * steel_slope(1) * 10^(3) * A ; % W
disp('Stainless Steel Heat Transfer:');
disp(q_steel);

granite_cond = steel_cond * steel_to_granite;
aluminum_cond = steel_cond * steel_to_aluminum;
glass_cond = steel_cond * steel_to_glass;

disp('Granite Conductivity:');
disp(granite_cond);
disp('Aluminum Conductivity:');
disp(aluminum_cond);
disp('Glass Conductivity:');
disp(glass_cond);

% Define the real lengths of the materials
steel_length = 0.05; % m
granite_length = 0.045; % m
aluminum_length = 0.09; % m
glass_length = 0.02; % m

% Calculate the thermal resistance of each material
R_steel = steel_length / (steel_cond * A);
R_granite = granite_length / (granite_cond * A);
R_aluminum = aluminum_length / (aluminum_cond * A);
R_glass = glass_length / (glass_cond * A);

disp('Stainless Steel Thermal Resistance:');
disp(R_steel);
disp('Granite Thermal Resistance:');
disp(R_granite);
disp('Aluminum Thermal Resistance:');
disp(R_aluminum);
disp('Glass Thermal Resistance:');
disp(R_glass);

total_resistance = R_steel + R_granite + R_aluminum + R_glass;
real_thermal_total_resistance = (avg_temp(1) - avg_temp(end)) / q_steel;

disp('Total Resistance:');
disp(total_resistance);
disp('Real Total Resistance:');
disp(real_thermal_total_resistance);
