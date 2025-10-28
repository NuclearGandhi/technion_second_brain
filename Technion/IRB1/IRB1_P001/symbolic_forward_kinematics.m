%% Symbolic Forward Kinematics for UR5e
% This script computes the symbolic transformation matrices
% for each joint and the complete end-effector transformation
%
% Output: Displays individual transformations and saves full result

clear; clc;

fprintf('=== Symbolic Forward Kinematics for UR5e ===\n\n');

%% Define symbolic variables
fprintf('Defining symbolic joint angles...\n');
syms theta1 theta2 theta3 theta4 theta5 theta6 real
theta_sym = [theta1; theta2; theta3; theta4; theta5; theta6];

fprintf('Defining symbolic DH parameters...\n');
syms a2 a3 d1 d4 d5 d6 real positive

%% UR5e DH Parameters (modified DH convention)
% From ur5_dh_parameters.m
% Using symbolic variables for non-zero link lengths/offsets
% Using sym(pi) for exact symbolic representation (not floating-point approximation)
a = [0; a2; a3; 0; 0; 0];        % a2=0.425m, a3=0.3922m
alpha = [sym(pi)/2; 0; 0; sym(pi)/2; -sym(pi)/2; 0];  % Exact symbolic pi
d = [d1; 0; 0; d4; d5; d6];      % d1=0.1625m, d4=0.1333m, d5=0.0997m, d6=0.0996m

fprintf('DH Parameters defined:\n');
fprintf('  Symbolic: a2, a3, d1, d4, d5, d6\n');
fprintf('  Numeric: zeros and pi multiples\n\n');

%% Define DH transformation function
dh_transform = @(a, alpha, d, theta) [
    cos(theta), -sin(theta)*cos(alpha),  sin(theta)*sin(alpha), a*cos(theta);
    sin(theta),  cos(theta)*cos(alpha), -cos(theta)*sin(alpha), a*sin(theta);
    0,           sin(alpha),              cos(alpha),            d;
    0,           0,                       0,                     1
];

%% Compute individual transformation matrices
fprintf('Computing individual transformation matrices...\n');
T_individual = cell(1, 6);

for i = 1:6
    fprintf('  Computing T_%d^%d...\n', i-1, i);
    T_individual{i} = dh_transform(a(i), alpha(i), d(i), theta_sym(i));
    T_individual{i} = simplify(T_individual{i}, 'Steps', 50);
end

fprintf('\nIndividual transformations computed.\n\n');

%% Display individual transformations
fprintf('=== Individual Transformation Matrices ===\n\n');

for i = 1:6
    fprintf('T_%d^%d (Frame %d to Frame %d):\n', i-1, i, i-1, i);
    fprintf('--------------------------------------------------\n');
    disp(T_individual{i});
    fprintf('\n');
end

%% Compute cumulative transformations
fprintf('Computing cumulative transformations...\n');
T_cumulative = cell(1, 6);
T_cum = eye(4);

for i = 1:6
    fprintf('  Computing T_0^%d...\n', i);
    T_cum = T_cum * T_individual{i};
    T_cumulative{i} = simplify(T_cum, 'Steps', 50);
end

fprintf('Cumulative transformations computed.\n\n');

%% Display cumulative transformations (showing complexity growth)
fprintf('=== Cumulative Transformation Matrices ===\n\n');

for i = 1:3  % Only show first 3 to avoid overwhelming output
    fprintf('T_0^%d (Base to Joint %d):\n', i, i);
    fprintf('--------------------------------------------------\n');
    disp(T_cumulative{i});
    fprintf('\n');
end

fprintf('Note: T_0^4, T_0^5, and T_0^6 are very large and omitted from display.\n');
fprintf('      They are stored in T_cumulative{4}, T_cumulative{5}, T_cumulative{6}.\n\n');

%% Extract end-effector position symbolically
fprintf('=== End-Effector Position (symbolic) ===\n\n');
p_ee = T_cumulative{6}(1:3, 4);

fprintf('p_x(theta1, ..., theta6) =\n');
disp(p_ee(1));
fprintf('\n');

fprintf('p_y(theta1, ..., theta6) =\n');
disp(p_ee(2));
fprintf('\n');

fprintf('p_z(theta1, ..., theta6) =\n');
disp(p_ee(3));
fprintf('\n');

%% Save results to file
fprintf('Saving results to symbolic_fk_results.mat...\n');
save('symbolic_fk_results.mat', 'T_individual', 'T_cumulative', 'p_ee', 'theta_sym', ...
     'a', 'alpha', 'd');

%% Export to text file for documentation
fprintf('Exporting readable results to symbolic_fk_output.txt...\n');
diary('symbolic_fk_output.txt');

fprintf('\n========================================\n');
fprintf('UR5e Symbolic Forward Kinematics Results\n');
fprintf('========================================\n\n');

fprintf('Individual Transformation Matrices:\n');
fprintf('-----------------------------------\n\n');

for i = 1:6
    fprintf('T_%d^%d:\n', i-1, i);
    disp(T_individual{i});
    fprintf('\n');
end

fprintf('\nCumulative Transformations (Base to Joint i):\n');
fprintf('---------------------------------------------\n\n');

for i = 1:6
    fprintf('T_0^%d:\n', i);
    
    % Show size information
    T_str = char(T_cumulative{i}(1,1));
    fprintf('  (Position (1,1) has %d characters)\n', length(T_str));
    
    if i <= 3
        disp(T_cumulative{i});
    else
        fprintf('  [Matrix too large to display - %d x %d with complex expressions]\n', 4, 4);
    end
    fprintf('\n');
end

fprintf('\nEnd-Effector Position Components:\n');
fprintf('----------------------------------\n\n');

fprintf('p_x = ');
disp(p_ee(1));
fprintf('\n');

fprintf('p_y = ');
disp(p_ee(2));
fprintf('\n');

fprintf('p_z = ');
disp(p_ee(3));
fprintf('\n');

fprintf('\n========================================\n');
fprintf('Analysis Complete\n');
fprintf('========================================\n\n');

fprintf('Results saved to:\n');
fprintf('  - symbolic_fk_results.mat (MATLAB data)\n');
fprintf('  - symbolic_fk_output.txt (text format)\n\n');

diary off;

fprintf('\n=== Symbolic Forward Kinematics Complete ===\n');
fprintf('See symbolic_fk_output.txt for detailed results.\n\n');

%% Summary statistics
fprintf('=== Complexity Summary ===\n\n');

for i = 1:6
    % Get string representation length as complexity measure
    T_str = char(T_cumulative{i}(1,1));
    fprintf('T_0^%d element (1,1): %d characters\n', i, length(T_str));
end

fprintf('\nAs shown, the symbolic expressions grow exponentially in complexity.\n');
fprintf('The final transformation T_0^6 contains thousands of terms.\n\n');

%% Display UR5e-specific numeric values for reference
fprintf('=== UR5e Numeric Parameter Values ===\n\n');
fprintf('For the UR5e robot, the symbolic parameters have these values:\n');
fprintf('  a2 = 0.425 m\n');
fprintf('  a3 = 0.3922 m\n');
fprintf('  d1 = 0.1625 m\n');
fprintf('  d4 = 0.1333 m\n');
fprintf('  d5 = 0.0997 m\n');
fprintf('  d6 = 0.0996 m\n\n');

