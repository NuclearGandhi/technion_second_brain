%% Problem 2: 2D Elasticity with 3 Triangular Elements
clear; clc; close all;

%% Material Properties and Parameters
E = 200e9;              % Young's modulus [Pa]
nu = 0.25;              % Poisson's ratio
t = 0.015;              % Thickness [m]
p0 = 2000;              % Applied pressure [N/m]

% Domain dimensions
a = 3;                  % Width [m]
b = 4;                  % Height [m]

%% Node Coordinates (5 nodes)
nodes = [0,   0;        % Node 1
         a,   0;        % Node 2  
         a,   b;        % Node 3
         0,   b;        % Node 4
         2*a, b];       % Node 5 at (2a,b) = (6,4)

%% Element Connectivity (3 elements)
elements = [1, 2, 3;    % Element 1: nodes 1-2-3 (same as Problem 1)
            3, 4, 1;    % Element 2: nodes 3-4-1 (same as Problem 1)  
            2, 5, 3];   % Element 3: nodes 2-5-3 (new element)

%% Constitutive Matrix for Plane Stress
C = (E/(1-nu^2)) * [1,  nu, 0;
                    nu, 1,  0;
                    0,  0,  (1-nu)/2];

%% Master Element B-hat Matrix  
B_hat = [-1,  1,  0;
         -1,  0,  1];

%% Strain-Displacement Matrix in Master Element
D_phi_hat = [-1,  1,  0,  0,  0,  0;
              0,  0,  0, -1,  0,  1;
             -1,  0,  1, -1,  1,  0];

%% Initialize Global Stiffness Matrix and Force Vector
num_nodes = size(nodes, 1);
num_dofs = 2 * num_nodes;
K_global = zeros(num_dofs);
F_global = zeros(num_dofs, 1);

%% Assemble Element Stiffness Matrices
for e = 1:size(elements, 1)
    % Get element nodes
    elem_nodes = elements(e, :);
    
    % Element node coordinates
    x_elem = nodes(elem_nodes, 1);
    y_elem = nodes(elem_nodes, 2);
    X_elem = [x_elem, y_elem];
    
    % Calculate Jacobian matrix
    J = B_hat * X_elem;
    det_J = det(J);
    
    fprintf('Element %d: det(J) = %.2f\n', e, det_J);
    
    if det_J <= 0
        error('Negative or zero Jacobian determinant in element %d', e);
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
    
    % Element stiffness matrix (using Gaussian quadrature weight 0.5 for triangle)
    K_elem = t * D_phi_phys' * C * D_phi_phys * det_J * 0.5;
    
    % Assembly into global matrix
    % Use same DOF ordering as q1: {u1,u2,u3,u4,u5,v1,v2,v3,v4,v5}
    % For element with nodes [n1,n2,n3], element DOFs are [u_n1,u_n2,u_n3,v_n1,v_n2,v_n3]
    elem_dofs = zeros(1, 6);
    for i = 1:3
        node = elem_nodes(i);
        elem_dofs(i) = node;                % u DOF (positions 1-5)
        elem_dofs(i+3) = node + num_nodes;  % v DOF (positions 6-10)
    end
    
    % Add element contribution to global matrix
    for i = 1:6
        for j = 1:6
            K_global(elem_dofs(i), elem_dofs(j)) = ...
                K_global(elem_dofs(i), elem_dofs(j)) + K_elem(i, j);
        end
    end
end

%% Apply Triangular Load on Edge 2-5
% Calculate edge 2-5 properties
edge_vec = nodes(5,:) - nodes(2,:);  % Edge vector (3, 4)
edge_length = norm(edge_vec);         % Length = 5m
edge_normal = [edge_vec(2), -edge_vec(1)] / edge_length;  % Outward normal vector (4/5, -3/5)

% Triangular load: 0 at node 2, p0 at node 5
% Equivalent nodal forces for triangular distribution
F_node2_mag = (1/6) * p0 * edge_length;  % 1667 N
F_node5_mag = (1/3) * p0 * edge_length;  % 3333 N

% Apply forces in outward normal direction (southeast)
% DOF ordering: {u1,u2,u3,u4,u5,v1,v2,v3,v4,v5}
F_global(2) = F_node2_mag * edge_normal(1);      % F_x at node 2: +1333 N
F_global(2+num_nodes) = F_node2_mag * edge_normal(2);  % F_y at node 2: -1000 N
F_global(5) = F_node5_mag * edge_normal(1);      % F_x at node 5: +2667 N  
F_global(5+num_nodes) = F_node5_mag * edge_normal(2);  % F_y at node 5: -2000 N

fprintf('Applied triangular load on edge 2-5:\n');
fprintf('Node 2: Fx = %.0f N, Fy = %.0f N\n', F_global(2), F_global(2+num_nodes));
fprintf('Node 5: Fx = %.0f N, Fy = %.0f N\n', F_global(5), F_global(5+num_nodes));

%% Display Global Matrices
fprintf('\n=== GLOBAL STIFFNESS MATRIX ===\n');
disp(K_global);

fprintf('\n=== GLOBAL LOAD VECTOR ===\n');
disp(F_global');

%% Apply Boundary Conditions
% Fixed nodes: 1 and 4 (u=0, v=0)
% DOF ordering: {u1,u2,u3,u4,u5,v1,v2,v3,v4,v5}
fixed_dofs = [1, 4, 1+num_nodes, 4+num_nodes];  % u1, u4, v1, v4
free_dofs = setdiff(1:num_dofs, fixed_dofs);

%% Solve Reduced System
K_reduced = K_global(free_dofs, free_dofs);
F_reduced = F_global(free_dofs);

u_reduced = K_reduced \ F_reduced;

%% Reconstruct Full Displacement Vector
u_global = zeros(num_dofs, 1);
u_global(free_dofs) = u_reduced;

%% Extract Nodal Displacements
u_nodes = u_global(1:num_nodes);              % u displacements
v_nodes = u_global(num_nodes+1:2*num_nodes);  % v displacements

%% Display Results
fprintf('\n=== NODAL DISPLACEMENTS ===\n');
for i = 1:num_nodes
    fprintf('Node %d: u = %.3e m, v = %.3e m\n', i, u_nodes(i), v_nodes(i));
end

%% Post-Processing: Calculate Strains and Stresses
fprintf('\n=== ELEMENT STRAINS AND STRESSES ===\n');

for e = 1:size(elements, 1)
    % Get element nodes and displacements
    elem_nodes = elements(e, :);
    
    % Element displacement vector
    % Extract nodal displacements for this element
    u_elem = zeros(6, 1);  % [u1, u2, u3, v1, v2, v3] for element nodes
    for i = 1:3
        node = elem_nodes(i);
        u_elem(i) = u_global(node);                % u displacement
        u_elem(i+3) = u_global(node + num_nodes);  % v displacement
    end
    
    % Element node coordinates
    x_elem = nodes(elem_nodes, 1);
    y_elem = nodes(elem_nodes, 2);
    X_elem = [x_elem, y_elem];
    
    % Calculate Jacobian matrix
    J = B_hat * X_elem;
    det_J = det(J);
    J_inv = inv(J);
    
    % Transform master element matrix to physical element
    B_phys = J_inv * B_hat;
    
    % Form physical strain-displacement matrix
    D_phi_phys = zeros(3, 6);
    D_phi_phys(1, 1:3) = B_phys(1, :);  % du/dx
    D_phi_phys(2, 4:6) = B_phys(2, :);  % dv/dy
    D_phi_phys(3, 1:3) = B_phys(2, :);  % du/dy
    D_phi_phys(3, 4:6) = B_phys(1, :);  % dv/dx
    
    % Calculate strains using physical strain-displacement matrix
    strains = D_phi_phys * u_elem;
    
    % Calculate stresses
    stresses = C * strains;
    
    fprintf('\nElement %d:\n', e);
    fprintf('  Strains: ε_xx = %.3e, ε_yy = %.3e, γ_xy = %.3e\n', ...
            strains(1), strains(2), strains(3));
    fprintf('  Stresses: σ_xx = %.3f MPa, σ_yy = %.3f MPa, τ_xy = %.3f MPa\n', ...
            stresses(1)/1e6, stresses(2)/1e6, stresses(3)/1e6);
end

%% Visualization
figure('Position', [100, 100, 800, 400]);

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
for i = 1:num_nodes
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
scale = 5e4;  % Amplification factor
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
print('q2_mesh_analysis', '-dpng', '-r300');
