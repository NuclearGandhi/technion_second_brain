%% FEM1_008 - 2D Elasticity Problem
% Element stiffness matrix calculation for triangular elements
% Using Gaussian quadrature integration

clear; clc; close all;

%% Problem Parameters
E = 200e9;          % Young's modulus [Pa]
nu = 0.25;          % Poisson's ratio
t = 0.015;          % thickness [m]
a = 3;              % width [m]
b = 4;              % height [m]
p0 = 2000;          % applied pressure [N/m]

%% Node coordinates
nodes = [0, 0;      % Node 1
         3, 0;      % Node 2  
         3, 4;      % Node 3
         0, 4];     % Node 4

%% Element connectivity
elements = [1, 2, 3;    % Element 1: nodes 1-2-3
            3, 4, 1];   % Element 2: nodes 3-4-1

%% Material matrix for plane stress
C = (E/(1-nu^2)) * [1,    nu,   0;
                    nu,   1,    0;
                    0,    0,    (1-nu)/2];

%% Master element strain-displacement matrix (from theoretical calculation)
% [D_hat][phi_hat] = constant matrix for triangular master element
D_phi_hat = [-1,  1,  0,  0,  0,  0;
              0,  0,  0, -1,  0,  1;
             -1,  0,  1, -1,  1,  0];

%% Gaussian quadrature points and weights for triangles
% Using 1-point Gauss quadrature for triangular elements
gauss_points = [1/3, 1/3];  % (zeta1, zeta2) coordinates
gauss_weights = 1/2;        % weight for triangle area integration

%% Initialize global stiffness matrix
ndof = 8;  % 4 nodes × 2 DOF per node
K_global = zeros(ndof, ndof);

%% Calculate element stiffness matrices
for elem = 1:size(elements, 1)
    fprintf('Calculating element %d stiffness matrix...\n', elem);
    
    % Get element nodes
    elem_nodes = elements(elem, :);
    
    % Element coordinates
    x_coords = nodes(elem_nodes, 1);
    y_coords = nodes(elem_nodes, 2);
    
    % Form coordinate matrix for Jacobian calculation
    X_elem = [x_coords, y_coords];
    
    % Initialize element stiffness matrix
    K_elem = zeros(6, 6);  % 3 nodes × 2 DOF per node
    
    % Gaussian quadrature integration
    for q = 1:length(gauss_weights)
        % Gauss point coordinates
        zeta1 = gauss_points(q, 1);
        zeta2 = gauss_points(q, 2);
        
        % Calculate Jacobian matrix
        % B_hat matrix for derivatives of shape functions
        B_hat = [-1,  1,  0;
                 -1,  0,  1];
        
        % Jacobian J = B_hat * X_elem^T
        J = B_hat * X_elem;
        
        % Jacobian determinant
        det_J = det(J);
        
        if det_J <= 0
            error('Negative or zero Jacobian determinant in element %d', elem);
        end
        
        % Inverse Jacobian
        J_inv = inv(J);
        
        % Transform master element matrix to physical element
        % B_physical = J_inv * B_hat
        B_phys = J_inv * B_hat;
        
        % Form physical strain-displacement matrix
        D_phi_phys = zeros(3, 6);
        D_phi_phys(1, 1:3) = B_phys(1, :);  % du/dx
        D_phi_phys(2, 4:6) = B_phys(2, :);  % dv/dy
        D_phi_phys(3, 1:3) = B_phys(2, :);  % du/dy
        D_phi_phys(3, 4:6) = B_phys(1, :);  % dv/dx
        
        % Element stiffness contribution
        K_contrib = D_phi_phys' * C * D_phi_phys * det_J * gauss_weights(q);
        
        % Add to element stiffness matrix
        K_elem = K_elem + K_contrib;
    end
    
    % Multiply by thickness
    K_elem = t * K_elem;
    
    % Display element stiffness matrix
    fprintf('\nElement %d stiffness matrix:\n', elem);
    disp(K_elem);
    
    % Assembly into global matrix
    % DOF mapping: {u1, u2, u3, u4, v1, v2, v3, v4}
    % Element DOFs: {u_node1, u_node2, u_node3, v_node1, v_node2, v_node3}
    elem_dofs = zeros(1, 6);
    for i = 1:3
        node = elem_nodes(i);
        elem_dofs(i) = node;         % u DOF (positions 1-4)
        elem_dofs(i+3) = node + 4;   % v DOF (positions 5-8)
    end
    
    % Add element contribution to global matrix
    for i = 1:6
        for j = 1:6
            K_global(elem_dofs(i), elem_dofs(j)) = ...
                K_global(elem_dofs(i), elem_dofs(j)) + K_elem(i, j);
        end
    end
end

%% Display global stiffness matrix
fprintf('\nGlobal stiffness matrix:\n');
disp(K_global);

%% Apply boundary conditions and loads
% Boundary conditions: u1 = v1 = u4 = v4 = 0
% With ordering {u1, u2, u3, u4, v1, v2, v3, v4}: DOFs 1, 4, 5, 8 are fixed
% Free DOFs: u2, u3, v2, v3 (indices 2, 3, 6, 7)
free_dofs = [2, 3, 6, 7];
K_reduced = K_global(free_dofs, free_dofs);

% Load vector: F = p0 * L / 2 = 2000 * 4 / 2 = 4000 N per node
F_reduced = [4000; 4000; 0; 0];  % [u2, u3, v2, v3]

%% Solve for displacements
fprintf('\nSolving for displacements...\n');
fprintf('Reduced stiffness matrix (4x4):\n');
disp(K_reduced);
fprintf('Load vector:\n');
disp(F_reduced);

u_reduced = K_reduced \ F_reduced;

% Full displacement vector
u_full = zeros(8, 1);
u_full(free_dofs) = u_reduced;

%% Display results
fprintf('\nDisplacement results:\n');
fprintf('u1 = %.6e m, v1 = %.6e m\n', u_full(1), u_full(5));
fprintf('u2 = %.6e m, v2 = %.6e m\n', u_full(2), u_full(6));
fprintf('u3 = %.6e m, v3 = %.6e m\n', u_full(3), u_full(7));
fprintf('u4 = %.6e m, v4 = %.6e m\n', u_full(4), u_full(8));

%% Post-Processing: Calculate Strains and Stresses
% Using direct strain transformation method (most efficient approach)
fprintf('\n=== POST-PROCESSING: STRAINS AND STRESSES ===\n');
fprintf('Using direct strain transformation method\n');

for elem = 1:size(elements, 1)
    fprintf('\n--- Element %d ---\n', elem);
    
    % Get element nodes
    elem_nodes = elements(elem, :);
    
    % Element coordinates
    x_coords = nodes(elem_nodes, 1);
    y_coords = nodes(elem_nodes, 2);
    X_elem = [x_coords, y_coords];
    
    % Element displacement vector
    % Extract nodal displacements for this element
    u_elem = zeros(6, 1);  % [u1, u2, u3, v1, v2, v3] for element nodes
    for i = 1:3
        node = elem_nodes(i);
        u_elem(i) = u_full(node);        % u displacement
        u_elem(i+3) = u_full(node + 4);  % v displacement
    end
    
    fprintf('Element nodal displacements:\n');
    for i = 1:3
        fprintf('  Node %d: u = %.6e m, v = %.6e m\n', ...
            elem_nodes(i), u_elem(i), u_elem(i+3));
    end
    
    % Calculate strains and stresses at Gauss points
    % Using direct strain transformation method
    for q = 1:length(gauss_weights)
        % Gauss point coordinates
        zeta1 = gauss_points(q, 1);
        zeta2 = gauss_points(q, 2);
        
        fprintf('\nAt Gauss point %d (ζ₁=%.3f, ζ₂=%.3f):\n', q, zeta1, zeta2);
        
        % Calculate Jacobian matrix (reuse from stiffness calculation)
        B_hat = [-1,  1,  0;
                 -1,  0,  1];
        
        J = B_hat * X_elem;
        det_J = det(J);
        J_inv = inv(J);
        
        % EFFICIENT METHOD: Use already computed J_inv to transform derivatives
        % Instead of recalculating B_phys, reuse the transformation we know
        B_phys = J_inv * B_hat;
        
        % Form strain-displacement matrix efficiently
        % Reuse the same structure but with already computed B_phys
        D_phi_phys = zeros(3, 6);
        D_phi_phys(1, 1:3) = B_phys(1, :);  % ∂u/∂x₁ → ε₁₁
        D_phi_phys(2, 4:6) = B_phys(2, :);  % ∂v/∂x₂ → ε₂₂  
        D_phi_phys(3, 1:3) = B_phys(2, :);  % ∂u/∂x₂ → γ₁₂ part 1
        D_phi_phys(3, 4:6) = B_phys(1, :);  % ∂v/∂x₁ → γ₁₂ part 2
        
        % Calculate strains: {ε} = [D][φ]{u} (but efficiently)
        strains_physical = D_phi_phys * u_elem;
        
        % For comparison, also show master element calculation
        strains_master = D_phi_hat * u_elem;
        fprintf('  Master element strains (for reference):\n');
        fprintf('    ε_ζ₁ζ₁ = %.6e\n', strains_master(1));
        fprintf('    ε_ζ₂ζ₂ = %.6e\n', strains_master(2));
        fprintf('    γ_ζ₁ζ₂ = %.6e\n', strains_master(3));
        
        % Extract physical strain components
        epsilon_11 = strains_physical(1);      % Normal strain in x₁ direction
        epsilon_22 = strains_physical(2);      % Normal strain in x₂ direction
        gamma_12 = strains_physical(3);        % Shear strain (engineering notation: 2ε₁₂)
        epsilon_12 = gamma_12 / 2;             % Tensor shear strain
        
        % Calculate stresses: {σ} = [C]{ε}
        stresses = C * strains_physical;
        
        % Extract stress components
        sigma_11 = stresses(1);       % Normal stress in x₁ direction
        sigma_22 = stresses(2);       % Normal stress in x₂ direction
        tau_12 = stresses(3);         % Shear stress
        
        % Display results
        fprintf('  Physical strains:\n');
        fprintf('    ε₁₁ = %.6e\n', epsilon_11);
        fprintf('    ε₂₂ = %.6e\n', epsilon_22);
        fprintf('    ε₁₂ = %.6e\n', epsilon_12);
        fprintf('    γ₁₂ = %.6e (engineering shear strain)\n', gamma_12);
        
        fprintf('  Stresses:\n');
        fprintf('    σ₁₁ = %.6e Pa = %.2f MPa\n', sigma_11, sigma_11/1e6);
        fprintf('    σ₂₂ = %.6e Pa = %.2f MPa\n', sigma_22, sigma_22/1e6);
        fprintf('    τ₁₂ = %.6e Pa = %.2f MPa\n', tau_12, tau_12/1e6);
        
        % Calculate von Mises stress for comparison
        sigma_vm = sqrt(sigma_11^2 + sigma_22^2 - sigma_11*sigma_22 + 3*tau_12^2);
        fprintf('    σᵥₘ = %.6e Pa = %.2f MPa (von Mises)\n', sigma_vm, sigma_vm/1e6);
        
        % Calculate principal stresses
        sigma_center = (sigma_11 + sigma_22) / 2;
        sigma_radius = sqrt(((sigma_11 - sigma_22)/2)^2 + tau_12^2);
        sigma_1 = sigma_center + sigma_radius;  % Maximum principal stress
        sigma_2 = sigma_center - sigma_radius;  % Minimum principal stress
        
        fprintf('  Principal stresses:\n');
        fprintf('    σ₁ = %.6e Pa = %.2f MPa (max principal)\n', sigma_1, sigma_1/1e6);
        fprintf('    σ₂ = %.6e Pa = %.2f MPa (min principal)\n', sigma_2, sigma_2/1e6);
        
        % Principal stress angle
        if abs(sigma_11 - sigma_22) > 1e-12
            theta_p = 0.5 * atan(2*tau_12 / (sigma_11 - sigma_22)) * 180/pi;
        else
            theta_p = 45;  % When σ₁₁ = σ₂₂
        end
        fprintf('    θₚ = %.2f° (principal stress angle)\n', theta_p);
    end
end

%% Summary
fprintf('\n=== SUMMARY ===\n');
fprintf('Problem: 2D plane stress analysis\n');
fprintf('Material: E = %.1e Pa, ν = %.2f\n', E, nu);
fprintf('Geometry: %g m × %g m, thickness = %g m\n', a, b, t);
fprintf('Loading: p₀ = %g N/m distributed load\n', p0);
fprintf('Elements: %d triangular elements\n', size(elements, 1));
fprintf('DOFs: %d total degrees of freedom\n', ndof);
fprintf('Post-processing: Efficient coordinate transformation method\n');
fprintf('  - Reuses already computed inverse Jacobian J⁻¹\n');
fprintf('  - Transforms derivatives efficiently: B_phys = J⁻¹ * B_hat\n');
fprintf('  - Shows master element strains for comparison\n');
fprintf('Solution completed successfully.\n');

%% Visualization
figure('Position', [100, 100, 800, 400]);

% Extract nodal displacements for plotting
u_nodes = u_full(1:4);  % u displacements at nodes 1-4
v_nodes = u_full(5:8);  % v displacements at nodes 1-4

% Plot undeformed mesh
subplot(1,2,1);
hold on;
for e = 1:size(elements, 1)
    elem_nodes = elements(e, :);
    x_elem = nodes(elem_nodes, 1);
    y_elem = nodes(elem_nodes, 2);
    patch(x_elem, y_elem, 'w', 'EdgeColor', 'k', 'LineWidth', 2);
end
scatter(nodes(:,1), nodes(:,2), 100, 'ro', 'filled');
for i = 1:size(nodes, 1)
    if nodes(i,2) == 0  % Bottom nodes
        text(nodes(i,1), nodes(i,2)-0.3, sprintf('%d', i), 'FontSize', 12, 'HorizontalAlignment', 'center');
    else  % Other nodes
        text(nodes(i,1)+0.1, nodes(i,2)+0.3, sprintf('%d', i), 'FontSize', 12);
    end
end
title('Undeformed Mesh');
xlabel('x [m]'); ylabel('y [m]');
xrange = [-0.5, 7.25];
yrange = [-2, 6];
xlim(xrange); ylim(yrange); grid on;

% Plot deformed mesh (scaled)
subplot(1,2,2);
scale = 5e5;  % Amplification factor
deformed_nodes = nodes + scale * [u_nodes, v_nodes];

hold on;
for e = 1:size(elements, 1)
    elem_nodes = elements(e, :);
    x_elem = deformed_nodes(elem_nodes, 1);
    y_elem = deformed_nodes(elem_nodes, 2);
    patch(x_elem, y_elem, 'c', 'EdgeColor', 'b', 'LineWidth', 2);
end
scatter(deformed_nodes(:,1), deformed_nodes(:,2), 100, 'bo', 'filled');
for i = 1:size(deformed_nodes, 1)
    if nodes(i,2) == 0  % Bottom nodes (check original position)
        text(deformed_nodes(i,1), deformed_nodes(i,2)-0.3, sprintf('%d', i), 'FontSize', 12, 'HorizontalAlignment', 'center');
    else  % Other nodes
        text(deformed_nodes(i,1)+0.1, deformed_nodes(i,2)+0.3, sprintf('%d', i), 'FontSize', 12);
    end
end
title(sprintf('Deformed Mesh (Scale: %.0e)', scale));
xlabel('x [m]'); ylabel('y [m]');
% Set axis limits to maintain aspect ratio and show all content
x_range = max(deformed_nodes(:,1)) - min(deformed_nodes(:,1));
y_range = max(deformed_nodes(:,2)) - min(deformed_nodes(:,2));
x_center = (max(deformed_nodes(:,1)) + min(deformed_nodes(:,1))) / 2;
y_center = (max(deformed_nodes(:,2)) + min(deformed_nodes(:,2))) / 2;
max_range = max(x_range, y_range) * 1.2;  % Add 20% padding
xlim(xrange); ylim(yrange);
grid on;

% Export figure at 300 DPI
print('q1_mesh_analysis', '-dpng', '-r300');

