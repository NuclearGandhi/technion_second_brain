clear; clc;

%% 1. Define Symbolic Variables
syms x y theta phi1 phi2 psi real
syms dx dy dtheta dphi1 dphi2 dpsi real
syms m1 m2 J1 J2 b d k c cw real
syms t real
%% 

% Generalized coordinates and velocities
q = [x; y; theta; phi1; phi2; psi];
dq = [dx; dy; dtheta; dphi1; dphi2; dpsi];

%% 2. Geometry and Kinematics
% Rotation matrix from Body to World (e1', e2' expressed in e1, e2)
% e1' = [cos(theta); sin(theta)]
% e2' = [-sin(theta); cos(theta)]
R_bw = [cos(theta), -sin(theta); 
        sin(theta),  cos(theta)];

e1_prime = R_bw(:,1);
e2_prime = R_bw(:,2);

% Center of Mass Position
r_c = [x; y];
v_c = [dx; dy]; % Jacobian would give same result

% Wheel Hinge Positions (relative to C in body frame)
% Hinge 1 is at -b along e1'
% Hinge 2 is at +b along e1'
r_h1_b = [-b; 0]; 
r_h2_b = [ b; 0];

% Wheel Axle Positions relative to Hinges (in body frame)
% Based on derivation: (-d*cos(phi), -d*sin(phi))
% This implies the arm points backwards relative to the angle phi
r_p1_h1_b = [-d*cos(phi1); -d*sin(phi1)];
r_p2_h2_b = [-d*cos(phi2); -d*sin(phi2)];

% Absolute Positions of Axles
r_p1 = r_c + R_bw * (r_h1_b + r_p1_h1_b);
r_p2 = r_c + R_bw * (r_h2_b + r_p2_h2_b);

% Velocities of Axles (Time derivative)
% We can use the chain rule: v = J_r_q * dq
v_p1 = simplify(jacobian(r_p1, q) * dq);
v_p2 = simplify(jacobian(r_p2, q) * dq);

%% 3. Kinetic Energy (T)
v_c_sq = v_c.' * v_c;
omega_1 = dtheta; % Platform angular velocity
omega_2 = dtheta + dpsi; % Rider angular velocity (relative twist psi)

T_platform = 0.5 * m1 * v_c_sq + 0.5 * J1 * omega_1^2;
T_rider    = 0.5 * m2 * v_c_sq + 0.5 * J2 * omega_2^2;

T = simplify(T_platform + T_rider);

%% 4. Potential Energy (V)
% Only torsional springs k at the hinges phi1, phi2
V = 0.5 * k * phi1^2 + 0.5 * k * phi2^2;

%% 5. Dissipation Function (D)
% Viscous damping c at hinges and Rolling resistance cw at axles
v_p1_sq = v_p1.' * v_p1;
v_p2_sq = v_p2.' * v_p2;

D = simplify(0.5 * c * dphi1^2 + 0.5 * c * dphi2^2 + ...
             0.5 * cw * v_p1_sq + 0.5 * cw * v_p2_sq);

%% 6. Generalized Forces
% Actuation torque tau_psi on coordinate psi
syms tau_psi real
Q_act = [0; 0; 0; 0; 0; tau_psi];

% Dissipation Forces F_diss = -dD/d(dq)
F_diss = -simplify(jacobian(D, dq).');

% Total Generalized Forces (excluding constraints)
F_q = Q_act + F_diss;

%% 7. Nonholonomic Constraints
% Direction of no-slip (perpendicular to arm)
% Perpendicular u_hat in body frame: [-sin(phi); cos(phi)]
u1_hat_b = [-sin(phi1); cos(phi1)];
u2_hat_b = [-sin(phi2); cos(phi2)];

% Rotate to world frame
u1_hat = R_bw * u1_hat_b;
u2_hat = R_bw * u2_hat_b;

% Constraint equations: v_p dot u_hat = 0
constr1 = simplify(dot(v_p1, u1_hat));
constr2 = simplify(dot(v_p2, u2_hat));

% Matrix form W(q) * dq = 0
% Extract coefficients of dq from constraints
W = jacobian([constr1; constr2], dq);
W = simplify(W);

%% 8. Equations of Motion (Form 2.12)
% Calculate M, B, G
% M = d^2T / d(dq)^2
M = jacobian(jacobian(T, dq).', dq);
M = simplify(M);

% B (Coriolis/Centrifugal) = (d(dT/d_dq)/dt - dT/dq) - M*ddq
% Or explicit formula B_i = sum(sum( (dM_ij/dq_k - 0.5*dM_jk/dq_i) * dq_j * dq_k ))
% Thus B = 0.
B = zeros(6, 1);

% G = dV/dq
G = jacobian(V, q).';

% Full EOM: M*ddq + B + G = F_q + W.' * lambda
syms lambda1 lambda2 real
lambda = [lambda1; lambda2];
EOM_lhs = M * sym('ddq', [6 1]) + B + G;
EOM_rhs = F_q + W.' * lambda;

%% 9. Partitioning for Under-Actuated System (Form 2.16)
% q_p = [x; y; theta; phi1; phi2] (Passive)
% q_a = [psi] (Actuated/Prescribed)
% We need to split M, B, G, F_q, W

idx_p = 1:5;
idx_a = 6;

M_pp = M(idx_p, idx_p);
M_pa = M(idx_p, idx_a);
M_aa = M(idx_a, idx_a);

% B is zero
B_p = B(idx_p);
B_a = B(idx_a);

G_p = G(idx_p);
G_a = G(idx_a);

F_q_p = F_q(idx_p); % Contains dissipation forces
F_q_a = F_q(idx_a); % Contains tau_psi and dissipation

W_p = W(:, idx_p);
W_a = W(:, idx_a);

% Check invertibility of W_p for kinematic check (unlikely since m < np)
% m=2, np=5. Not kinematic.

% Rearrange into Form 2.16
%   [ M_pp   0     -W_p^T ] [ ddq_p ]   [ -M_pa*ddq_a - B_p - G_p + F_q_p ]
%   [ M_pa^T -I    -W_a^T ] [ F_a   ] = [ -M_aa*ddq_a - B_a - G_a + F_q_a_rest ]
%   [ W_p    0      0     ] [ lambda]   [ -dW_a*dq_a - dW_p*dq_p ]

% Note: 2.16 assumes F_q_a is the UNKNOWN actuation force F_qa, and moves it to LHS.
% Here F_q_a includes tau_psi (actuation) AND dissipation.
% We should split F_q_a into F_act + F_diss_a
F_act_a = [tau_psi]; 
F_diss_a = F_diss(idx_a);

% The term F_q_a_rest in RHS would be F_diss_a.
% The term F_q_p in RHS includes F_diss_p.

% Derivative of constraints for RHS
% dW/dt * dq + W * ddq = 0 => W * ddq = -dW/dt * dq
% dW/dt = sum(dW/dq_k * dq_k)
dW_dt = zeros(size(W));
for i = 1:length(q)
    dW_dt = dW_dt + diff(W, q(i)) * dq(i);
end
Gamma = -dW_dt * dq; % RHS of acceleration constraint

% Partition Gamma into terms depending on ddq (none) and rest (all)
% Actually Gamma = - (dW_p * dq_p + dW_a * dq_a) ?
% No, dW/dt includes dq terms.
% The constraint equation is W * ddq + dW_dt * dq = 0
% W_p * ddq_p + W_a * ddq_a = Gamma

% Form 2.16 Matrices
% Unknowns vector X = [ddq_p; tau_psi; lambda]
% Size: 5 + 1 + 2 = 8 unknowns.
% Equations: 5 (dynamic p) + 1 (dynamic a) + 2 (constraints) = 8 equations.

LHS_Matrix = [
    M_pp,               zeros(5,1),      -W_p.';
    M_pa.',             -1,              -W_a.';
    W_p,                zeros(2,1),       zeros(2,2)
];

% RHS Vector
RHS_Vector = [
    -M_pa * sym('ddpsi') - B_p - G_p + F_q_p;         % Top block (5 rows)
    -M_aa * sym('ddpsi') - B_a - G_a + F_diss_a;      % Middle block (1 row) - Note: tau_psi moved to LHS
    -W_a * sym('ddpsi') + Gamma                       % Bottom block (2 rows)
];

%% 10. Display Results for Verification
disp('Constraint Matrix W:');
disp(W);
disp('Mass Matrix M:');
disp(M);
disp('Gravity Vector G:');
disp(G);
disp('Generalized Forces F_q (excluding constraints):');
disp(F_q);
disp('LHS Matrix for Form 2.16:');
disp(LHS_Matrix);
disp('RHS Vector for Form 2.16:');
disp(RHS_Vector);

%% 11. Total External Force and Moment (Assignment 3)
% External forces acting on the system are:
% 1. Constraint forces at wheels
% 2. Rolling resistance at wheels (dissipative)
% Actuation torque is internal. Gravity is in vertical plane (ignored/horizontal motion).
% Springs/dampers at hinges are internal to the multi-body system?
% Wait, the problem asks for "total external force acting on the vehicle".
% The vehicle is the whole system.
% Internal forces (springs, dampers, actuation) sum to zero.
% External forces are from the ground interaction at the wheels.

% Force at wheel contact i: F_contact_i = F_constraint_i + F_roll_i
% F_constraint_i is along u_hat_i (perpendicular to arm) with magnitude lambda_i
% F_roll_i is -cw * v_pi

F_constr_1 = lambda1 * u1_hat;
F_constr_2 = lambda2 * u2_hat;

F_roll_1 = -cw * v_p1;
F_roll_2 = -cw * v_p2;

F_ext_total = F_constr_1 + F_constr_2 + F_roll_1 + F_roll_2;
F_ext_total = simplify(F_ext_total);

% Total External Moment about C
% M_c = sum( (r_pi - r_c) cross F_contact_i )
% Cross product in 2D (result is scalar along z)
% cross(u, v) = u1*v2 - u2*v1

r_p1_c = r_p1 - r_c;
r_p2_c = r_p2 - r_c;

F_total_1 = F_constr_1 + F_roll_1;
F_total_2 = F_constr_2 + F_roll_2;

M_ext_total = (r_p1_c(1)*F_total_1(2) - r_p1_c(2)*F_total_1(1)) + ...
              (r_p2_c(1)*F_total_2(2) - r_p2_c(2)*F_total_2(1));

M_ext_total = simplify(M_ext_total);

%% 12. Display Results for Assignment 3
disp('Total External Force F_ext (x, y components):');
disp(F_ext_total);
disp('Total External Moment M_c:');
disp(M_ext_total);

%% 13. Export Function
ddpsi_sym = sym('ddpsi');
matlabFunction(LHS_Matrix, RHS_Vector, F_ext_total, M_ext_total, 'File', 'get_EOM_matrices', ...
    'Vars', {q, dq, m1, m2, J1, J2, b, d, k, c, cw, ddpsi_sym, tau_psi, lambda1, lambda2});



