function singularity_analysis(robot, save_plots)
% SINGULARITY_ANALYSIS - Analyze and visualize singular configurations
%
% Inputs:
%   robot - Robot parameters structure
%   save_plots - Boolean to save plots (default: true)
%
% This function identifies and visualizes singularities of the UR5e robot
% using the upper 3x6 Jacobian (linear velocity part)

    if nargin < 2
        save_plots = true;
    end
    if nargin < 1
        robot = ur5_dh_parameters();
    end
    
    fprintf('\n=== UR5e Singularity Analysis ===\n\n');
    
    % Common UR5 singularities:
    % 1. Shoulder singularity: Joint 1 axis aligned with wrist center
    % 2. Elbow singularity: Arm fully extended or folded
    % 3. Wrist singularity: Joint 4 and 6 axes aligned (theta5 = 0)
    
    %% Singularity Type 1: Wrist Singularity (theta5 = 0)
    fprintf('Singularity Type 1: Wrist Singularity\n');
    fprintf('Condition: theta5 = 0 (joints 4 and 6 axes are aligned)\n');
    fprintf('Physical meaning: Loss of control in rotation about wrist\n\n');
    
    q_wrist_sing = [0; -pi/4; pi/4; 0; 0; 0];  % theta5 = 0
    [J_wrist, J_lin_wrist] = compute_jacobian(q_wrist_sing, robot);
    rank_wrist = rank(J_lin_wrist, 1e-3);
    det_wrist = det(J_lin_wrist * J_lin_wrist');
    
    fprintf('Example configuration: q = [%.2f, %.2f, %.2f, %.2f, %.2f, %.2f]^T rad\n', q_wrist_sing);
    fprintf('Rank of J_linear: %d (should be < 3 at singularity)\n', rank_wrist);
    fprintf('det(J_linear * J_linear^T): %.6e\n\n', det_wrist);
    
    %% Singularity Type 2: Shoulder Singularity
    fprintf('Singularity Type 2: Shoulder Singularity\n');
    fprintf('Condition: Wrist center on z0 axis (joint 1 axis)\n');
    fprintf('Physical meaning: Cannot move wrist in certain directions\n\n');
    
    q_shoulder_sing = [0; pi/2; 0; 0; pi/2; 0];
    [J_shoulder, J_lin_shoulder] = compute_jacobian(q_shoulder_sing, robot);
    rank_shoulder = rank(J_lin_shoulder, 1e-3);
    det_shoulder = det(J_lin_shoulder * J_lin_shoulder');
    
    fprintf('Example configuration: q = [%.2f, %.2f, %.2f, %.2f, %.2f, %.2f]^T rad\n', q_shoulder_sing);
    fprintf('Rank of J_linear: %d\n', rank_shoulder);
    fprintf('det(J_linear * J_linear^T): %.6e\n\n', det_shoulder);
    
    %% Singularity Type 3: Elbow Singularity
    fprintf('Singularity Type 3: Elbow Singularity\n');
    fprintf('Condition: Arm fully extended (theta2 + theta3 ≈ 0)\n');
    fprintf('Physical meaning: Cannot move perpendicular to arm plane\n\n');
    
    q_elbow_sing = [0; 0; 0; 0; pi/2; 0];  % Fully extended
    [J_elbow, J_lin_elbow] = compute_jacobian(q_elbow_sing, robot);
    rank_elbow = rank(J_lin_elbow, 1e-3);
    det_elbow = det(J_lin_elbow * J_lin_elbow');
    
    fprintf('Example configuration: q = [%.2f, %.2f, %.2f, %.2f, %.2f, %.2f]^T rad\n', q_elbow_sing);
    fprintf('Rank of J_linear: %d\n', rank_elbow);
    fprintf('det(J_linear * J_linear^T): %.6e\n\n', det_elbow);
    
    %% Workspace Visualization with Singularities
    fprintf('Generating 3D workspace visualization...\n');
    
    % Sample workspace
    n_samples = 50;
    theta1_range = linspace(-pi, pi, n_samples);
    theta2_range = linspace(-pi, pi, n_samples);
    
    positions = [];
    
    % Sample configurations
    fprintf('Sampling %d configurations...\n', n_samples * n_samples);
    for i = 1:length(theta1_range)
        for j = 1:length(theta2_range)
            % Use middle values for other joints
            q_sample = [theta1_range(i); theta2_range(j); 0; 0; pi/2; 0];
            
            T = forward_kinematics(q_sample, robot);
            pos = T(1:3, 4);
            positions = [positions, pos];
        end
    end
    
    %% Plot 1: 3D Workspace visualization
    figure('Position', [100, 100, 800, 600]);
    
    % Simple scatter plot without singularity coloring
    scatter3(positions(1,:), positions(2,:), positions(3,:), 20, 'b', 'filled', 'MarkerFaceAlpha', 0.3);
    title('UR5e 3D Workspace');
    xlabel('X (m)');
    ylabel('Y (m)');
    zlabel('Z (m)');
    grid on;
    axis equal;
    view(45, 30);
    
    if save_plots
        % Create output directory if it doesn't exist
        if ~exist('plots', 'dir')
            mkdir('plots');
        end
        saveas(gcf, 'plots/workspace_3d_singularities.png');
        fprintf('Saved: plots/workspace_3d_singularities.png\n');
    end
    
    fprintf('\nSingularity analysis complete.\n');
end

