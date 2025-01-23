clc; clear; close all;

% Parameters
start_pixels = [12, 10, 10]; % Example start pixels for each graph
end_pixels = [59, 113, 232]; % Example end pixels for each graph
pixels_to_cm_ratio = 190 / 113;
y_margin = 10; % Margin for y-axis

% Read the CSV files
data1 = readtable('../data/fins1.csv');
data2 = readtable('../data/fins2.csv');

% Number of measurements
num_measurements = length(start_pixels);

% Initialize cell array to store average temperatures
avg_temp = cell(num_measurements, 1);
length_cm = cell(num_measurements, 1);

for i = 1:num_measurements
    % Extract the temperature data for the specified range and calculate averages
    temp1 = data1.(sprintf('Li%d', i))(start_pixels(i):end_pixels(i));
    temp2 = data2.(sprintf('Li%d', i))(start_pixels(i):end_pixels(i));
    avg_temp{i} = (temp1 + temp2) / 2;
    
    % Generate the length data for the specified range and convert to cm
    length_pixels = (start_pixels(i):end_pixels(i))';
    length_cm{i} = length_pixels * pixels_to_cm_ratio;
end

% Plot the temperature vs length graphs
figure;
for i = 1:num_measurements
    subplot(num_measurements, 1, i);
    plot(length_cm{i}, avg_temp{i}, '-x');
    title(sprintf('Average Temperature vs Length (Fin %d)', i));
    xlabel('$L$ (mm)');
    ylabel('$T$ ($^\circ$C)');
    grid on;
    xlim([min(length_cm{1}), max(length_cm{end})]);
    ylim([min(cellfun(@min, avg_temp)) - y_margin, max(cellfun(@max, avg_temp)) + y_margin]);
end

set(gcf, 'Position', [100, 0, 600, 1200]);