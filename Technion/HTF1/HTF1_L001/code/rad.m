% filepath: /c:/Users/Ido/Documents/Obsidian/quartz_fangia/content/Technion/HTF1/HTF1_L001/code/rad.m
clc; clear; close all;

% Read the CSV files
data = readtable('../data/rad1.csv');

% Extract L, T, and view factor data
L = data.L1;
T = data.P1;
F_12 = data.VF1;

% Constants
sigma = 5.67e-8; % Stefan-Boltzmann constant (W/m^2K^4)
T_surr = 300; % Surrounding temperature (K)

% Convert temperatures to Kelvin
T1 = T + 273.15;
T2 = 300 + 273.15; % Assuming T2 is the same as T1 for simplicity

% Calculate h as a function of T
h = sigma * (F_12 .* (T1.^4 - T2.^4) - (1 - F_12) .* (T2.^4 - T_surr^4)) ./ (T2 - T_surr);

% Cut first 5 values of T and h
h = h(4:end);
T = T(4:end);

% Plot h vs T
figure;
plot(T + 273.15, h, '-o');
xlabel('$T$ ($^\circ$C)', 'Interpreter', 'latex');
ylabel('$h$ (W/m$^2$K)', 'Interpreter', 'latex');
title('$h$ vs $T$', 'FontSize', 14);
grid on;
set(gca, 'FontSize', 12);
set(gcf, 'Units', 'pixels', 'Position', [-50, -100, 600, 600]);
exportgraphics(gcf, 'rad.png', 'Resolution', 300);