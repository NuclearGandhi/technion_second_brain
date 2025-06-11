clear; close all; clc;

m_A = 207.3e-3; % kg
m_B = 208.46e-3; % kg

mk_1 = 11.75e-3; % kg
mk_2 = 17.49e-3; % kg

mm_per_count = 127 / 241; % millimeters per count

% Load and analyze first file
data1 = readtable('6.1_100_5000.txt', 'Delimiter', '\t', 'HeaderLines', 1);
time1 = data1{:, 2};
count_A1 = data1{:, 3};
count_B1 = data1{:, 4};
freq1 = calculate_frequency(time1, count_A1);

% Load and analyze second file
data2 = readtable('6.2_100_5000_bigger.txt', 'Delimiter', '\t', 'HeaderLines', 1);
time2 = data2{:, 2};
count_A2 = data2{:, 3};
count_B2 = data2{:, 4};
freq2 = calculate_frequency(time2, count_A2);

% Load and analyze third file
data3 = readtable('6.2_100_5000_smaller.txt', 'Delimiter', '\t', 'HeaderLines', 1);
time3 = data3{:, 2};
count_A3 = data3{:, 3};
count_B3 = data3{:, 4};
freq3 = calculate_frequency(time3, count_A3);

% Print only frequencies
fprintf('6.1_100_5000.txt frequency A: %.4f Hz\n', freq1);
fprintf('6.2_100_5000_a.txt frequency A: %.4f Hz\n', freq2);
fprintf('6.2_100_5000_smaller.txt frequency A: %.4f Hz\n', freq3);

% Convert counts to displacement in mm
displacement_A1 = count_A1 * mm_per_count;
displacement_B1 = count_B1 * mm_per_count;
displacement_A2 = count_A2 * mm_per_count;
displacement_B2 = count_B2 * mm_per_count;
displacement_A3 = count_A3 * mm_per_count;
displacement_B3 = count_B3 * mm_per_count;

% Plot first file
figure(1);
plot(time1, displacement_A1, 'b-', 'LineWidth', 1.5, 'DisplayName', 'A');
hold on;
plot(time1, displacement_B1, 'r-', 'LineWidth', 1.5, 'DisplayName', 'B');
xlabel('Time (s)');
ylabel('Displacement (mm)');
title('6.1\_100\_5000.txt');
legend('show');
grid on;
hold off;

% Plot second file
figure(2);
plot(time2, displacement_A2, 'b-', 'LineWidth', 1.5, 'DisplayName', 'A');
hold on;
plot(time2, displacement_B2, 'r-', 'LineWidth', 1.5, 'DisplayName', 'B');
xlabel('Time (s)');
ylabel('Displacement (mm)');
title('6.2\_100\_5000\_bigger.txt');
legend('show');
grid on;
hold off;

% Plot third file
figure(3);
plot(time3, displacement_A3, 'b-', 'LineWidth', 1.5, 'DisplayName', 'A');
hold on;
plot(time3, displacement_B3, 'r-', 'LineWidth', 1.5, 'DisplayName', 'B');
xlabel('Time (s)');
ylabel('Displacement (mm)');
title('6.2\_100\_5000\_smaller.txt');
legend('show');
grid on;
hold off;

%%

% Fit Name: bigger
% 
% Sum of Sine Curve Fit (sin2)
% f(x) = a1*sin(b1*x+c1) + a2*sin(b2*x+c2)
% 
% Coefficients and 95% Confidence Bounds
%       Value    Lower    Upper 
% a1     42.231         42     42.462
% b1     7.6933     7.6929     7.6937
% c1    -3.0831    -3.0941    -3.0722
% a2     38.769     38.538         39
% b2     7.1503     7.1499     7.1507
% c2     0.1414     0.1295     0.1534
% 
% Goodness of Fit
%              Value   
% SSE         1.7243e+05
% R-square        0.9784
% DFE               4994
% Adj R-sq        0.9784
% RMSE             5.876

%% Fit smaller
% Fit Name: smaller
% 
% Sum of Sine Curve Fit (sin2)
% f(x) = a1*sin(b1*x+c1) + a2*sin(b2*x+c2)
% 
% Coefficients and 95% Confidence Bounds
%       Value    Lower    Upper 
% a1     41.148     40.876      41.42
% b1     6.5569     6.5565     6.5574
% c1     1.4433       1.43     1.4565
% a2     29.029     28.757     29.302
% b2     7.1513     7.1506     7.1519
% c2    -1.7645    -1.7833    -1.7457
% 
% Goodness of Fit
%              Value  
% SSE         2.399e+05
% R-square       0.9634
% DFE              4994
% Adj R-sq       0.9634
% RMSE           6.9309

%% a resonance
% Fit Name: a_res
% 
% Custom Curve Fit
% f(x) = a1*sin(b1*x+c1)+d1
% 
% Coefficients and 95% Confidence Bounds
%       Value    Lower    Upper 
% a1          3        NaN        NaN
% b1     7.1578     7.1569     7.1587
% c1    -0.4425    -0.4592    -0.4257
% d1     3.7282     3.7113     3.7451
% Info: Coefficients fixed at bound: a1
% 
% Goodness of Fit
%            Value 
% SSE         698.12
% R-square    0.9297
% DFE           3068
% Adj R-sq    0.9297
% RMSE         0.477

%% b resonance
% Fit Name: b_res
% 
% Custom Curve Fit
% f(x) = a1*x*sin(b1*x)+c1
% 
% Coefficients and 95% Confidence Bounds
%      Value   Lower   Upper 
% a1    4.3826    4.3007    4.4646
% b1    7.0795    7.0787    7.0803
% c1    6.3713    5.3114    7.4312
% 
% Goodness of Fit
%              Value   
% SSE         2.9328e+06
% R-square        0.7763
% DFE               3167
% Adj R-sq        0.7762
% RMSE            30.431