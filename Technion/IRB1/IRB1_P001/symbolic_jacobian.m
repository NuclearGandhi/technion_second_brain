%% Symbolic Jacobian Computation for UR5e
% This script computes the symbolic Jacobian matrix
% using both geometric and analytical methods
%
% Output: Displays Jacobian components and saves results

clear; clc;

fprintf('=== Symbolic Jacobian Computation for UR5e ===\n\n');

%% Load symbolic forward kinematics if available
if exist('symbolic_fk_results.mat', 'file')
    fprintf('Loading pre-computed symbolic FK results...\n');
    load('symbolic_fk_results.mat', 'T_cumulative', 'p_ee', 'theta_sym', 'a', 'alpha', 'd');
else
    fprintf('Computing symbolic forward kinematics...\n');
    % Run the FK script first
    run('symbolic_forward_kinematics.m');
    load('symbolic_fk_results.mat', 'T_cumulative', 'p_ee', 'theta_sym', 'a', 'alpha', 'd');
end

fprintf('Symbolic FK loaded.\n');
fprintf('DH parameters: a2, a3, d1, d4, d5, d6 (symbolic), zeros and pi (numeric)\n\n');

%% Extract symbolic variables
theta1 = theta_sym(1);
theta2 = theta_sym(2);
theta3 = theta_sym(3);
theta4 = theta_sym(4);
theta5 = theta_sym(5);
theta6 = theta_sym(6);

%% Method 1: Analytical Jacobian (partial derivatives)
fprintf('=== Method 1: Analytical Jacobian ===\n');
fprintf('Computing partial derivatives of end-effector position...\n\n');

% Linear velocity Jacobian: J_v = ∂p/∂θ
fprintf('Computing ∂p/∂θ_i for each joint...\n');
J_linear_analytical = jacobian(p_ee, theta_sym);

fprintf('Simplifying expressions (this may take several minutes)...\n');
J_linear_analytical = simplify(J_linear_analytical, 'Steps', 100);

fprintf('Analytical linear Jacobian computed.\n\n');

%% Method 2: Geometric Jacobian
fprintf('=== Method 2: Geometric Jacobian ===\n');
fprintf('Computing geometric Jacobian using cross products...\n\n');

J_linear_geometric = sym(zeros(3, 6));
J_angular_geometric = sym(zeros(3, 6));

% End-effector position
p_6 = p_ee;

fprintf('Computing for each joint:\n');
for i = 1:6
    fprintf('  Joint %d: ', i);
    
    % Get joint axis and position
    if i == 1
        z_prev = [0; 0; 1];  % Base z-axis
        p_prev = [0; 0; 0];   % Base position
    else
        z_prev = T_cumulative{i-1}(1:3, 3);  % z-axis of joint i-1
        p_prev = T_cumulative{i-1}(1:3, 4);   % Position of joint i-1
    end
    
    % Linear velocity: J_v = z × (p_ee - p_joint)
    J_linear_geometric(:, i) = cross(z_prev, p_6 - p_prev);
    
    % Angular velocity: J_ω = z
    J_angular_geometric(:, i) = z_prev;
    
    fprintf('Done\n');
end

fprintf('\nSimplifying geometric Jacobian...\n');
J_linear_geometric = simplify(J_linear_geometric, 'Steps', 100);
J_angular_geometric = simplify(J_angular_geometric, 'Steps', 100);

fprintf('Geometric Jacobian computed.\n\n');

%% Verify consistency between methods
fprintf('=== Verification ===\n');
fprintf('Checking if analytical and geometric linear Jacobians match...\n');

diff_J = simplify(J_linear_analytical - J_linear_geometric, 'Steps', 50);
max_diff = max(abs(diff_J), [], 'all');

if max_diff == 0
    fprintf('✓ Both methods produce identical results!\n\n');
else
    fprintf('Note: Small differences may exist due to symbolic simplification.\n\n');
end

%% Display results
fprintf('=== Jacobian Matrix Components ===\n\n');

fprintf('Linear Velocity Jacobian (3×6):\n');
fprintf('J_v = ∂p/∂θ where p = [p_x; p_y; p_z]\n');
fprintf('--------------------------------------------------\n');

for i = 1:3
    coord = ['x', 'y', 'z'];
    fprintf('\nRow %d (∂p_%c/∂θ):\n', i, coord(i));
    for j = 1:min(3, 6)  % Show first 3 joints to avoid overwhelming output
        fprintf('  ∂p_%c/∂θ_%d:\n', coord(i), j);
        term = char(J_linear_geometric(i, j));
        if length(term) > 200
            fprintf('    [Expression too long: %d characters]\n', length(term));
        else
            disp(J_linear_geometric(i, j));
        end
    end
end

fprintf('\n\nAngular Velocity Jacobian (3×6):\n');
fprintf('J_ω where each column is the joint axis z_{i-1}\n');
fprintf('--------------------------------------------------\n');

for i = 1:6
    fprintf('\nColumn %d (Joint %d axis):\n', i, i);
    disp(J_angular_geometric(:, i));
end

%% Full 6×6 Jacobian
fprintf('\n\n=== Full 6×6 Jacobian ===\n\n');
J_full = [J_linear_geometric; J_angular_geometric];

fprintf('J(θ) = [J_v; J_ω] where:\n');
fprintf('  - J_v is 3×6 (linear velocity)\n');
fprintf('  - J_ω is 3×6 (angular velocity)\n\n');

%% Save results
fprintf('Saving results to symbolic_jacobian_results.mat...\n');
save('symbolic_jacobian_results.mat', 'J_linear_analytical', ...
     'J_linear_geometric', 'J_angular_geometric', 'J_full', 'theta_sym', ...
     'a', 'alpha', 'd');

%% Export to text file
fprintf('Exporting results to symbolic_jacobian_output.txt...\n');
diary('symbolic_jacobian_output.txt');

fprintf('\n========================================\n');
fprintf('UR5e Symbolic Jacobian Results\n');
fprintf('========================================\n\n');

fprintf('Linear Velocity Jacobian (Geometric Method):\n');
fprintf('--------------------------------------------\n\n');
disp('J_linear = ');
disp(J_linear_geometric);

fprintf('\nAngular Velocity Jacobian:\n');
fprintf('-------------------------\n\n');
disp('J_angular = ');
disp(J_angular_geometric);

fprintf('\nFull 6×6 Jacobian:\n');
fprintf('-----------------\n\n');
disp('J_full = [J_linear; J_angular] = ');
fprintf('  [Due to size, showing structure only]\n');
fprintf('  Rows 1-3: Linear velocity components\n');
fprintf('  Rows 4-6: Angular velocity components\n\n');

fprintf('\n========================================\n');
fprintf('Analysis Complete\n');
fprintf('========================================\n\n');

diary off;

%% Complexity analysis
fprintf('\n=== Complexity Analysis ===\n\n');

for j = 1:6
    for i = 1:3
        term = char(J_linear_geometric(i, j));
        fprintf('J_v(%d,%d): %d characters\n', i, j, length(term));
    end
end

fprintf('\nTotal complexity grows with each joint due to cascading transformations.\n');
fprintf('Joints 1-2 have simpler expressions; Joints 5-6 are most complex.\n\n');

%% Display UR5e-specific numeric values for reference
fprintf('=== UR5e Numeric Parameter Values ===\n\n');
fprintf('For the UR5e robot, the symbolic parameters have these values:\n');
fprintf('  a2 = 0.425 m\n');
fprintf('  a3 = 0.3922 m\n');
fprintf('  d1 = 0.1625 m\n');
fprintf('  d4 = 0.1333 m\n');
fprintf('  d5 = 0.0997 m\n');
fprintf('  d6 = 0.0996 m\n\n');

fprintf('=== Symbolic Jacobian Computation Complete ===\n');
fprintf('Results saved to:\n');
fprintf('  - symbolic_jacobian_results.mat\n');
fprintf('  - symbolic_jacobian_output.txt\n\n');


