clc; clear; close all;

h = 25e-3; % m
l = 108.5e-3; % m
S = 141.6e-3; % m
L = 1.26; % m

g = 9.7949 +- 0.0001; % m/s^2

t_for_l = [0.874, 1.0192, 0.8982, 0.9361];
t_for_l_mean = mean(t_for_l);
l_from_t = 1/2 * g * (h/L) * t_for_l_mean^2
