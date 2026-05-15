%% Symbolic Verification: Interdigitated-Fingers Actuator
% Verifies the algebra used in the interdigitated-fingers section of
% "MCS2_002 Electromechanical Systems with N DOFs and K Voltages.md".
%
% Notation:
%   q1    = normalized axial overlap displacement
%   q2    = normalized transverse displacement
%   kappa = normalized suspension stiffness ratio
%   W1    = V1^2
%   W2    = V2^2

clear; clc;

syms q1 q2 kappa W1 W2 real

fprintf('Symbolic verification for the interdigitated-fingers actuator\n');
fprintf('-------------------------------------------------------------\n');

%% Normalized potential, Eq. (2.18)
psi = sym(1)/2*q1^2 + sym(1)/2*kappa*q2^2 ...
    - (1 + q1)*(W1/(1 - q2) + W2/(1 + q2));

%% First derivatives, Eq. (2.20)
dpsi_dq1 = diff(psi, q1);
dpsi_dq2 = diff(psi, q2);

dpsi_dq1_expected = q1 - (W1/(1 - q2) + W2/(1 + q2));
dpsi_dq2_expected = kappa*q2 ...
    - (1 + q1)*(W1/(1 - q2)^2 - W2/(1 + q2)^2);

assert_zero(dpsi_dq1 - dpsi_dq1_expected, 'd(psi)/dq1');
assert_zero(dpsi_dq2 - dpsi_dq2_expected, 'd(psi)/dq2');

%% Equilibrium voltages, Eqs. (2.21)-(2.22)
sol = solve([dpsi_dq1 == 0, dpsi_dq2 == 0], [W1, W2]);
W1_from_equilibrium = simplify(sol.W1);
W2_from_equilibrium = simplify(sol.W2);

W1_expected = (1 - q2)^2/(2*(1 + q1)) ...
    *(q1^2 + q1 + kappa*q2^2 + kappa*q2);
W2_expected = (1 + q2)^2/(2*(1 + q1)) ...
    *(q1^2 + q1 + kappa*q2^2 - kappa*q2);

assert_zero(W1_from_equilibrium - W1_expected, 'equilibrium W1 = V1^2');
assert_zero(W2_from_equilibrium - W2_expected, 'equilibrium W2 = V2^2');

%% Hessian / tangent stiffness matrix, Eq. (2.24)
K = hessian(psi, [q1, q2]);

K11_expected = sym(1);
K12_expected = -W1/(1 - q2)^2 + W2/(1 + q2)^2;
K22_expected = kappa ...
    - 2*(1 + q1)*(W1/(1 - q2)^3 + W2/(1 + q2)^3);
K_expected = [K11_expected, K12_expected; K12_expected, K22_expected];

assert_zero(K(1,1) - K_expected(1,1), 'K11 before voltage substitution');
assert_zero(K(1,2) - K_expected(1,2), 'K12 before voltage substitution');
assert_zero(K(2,1) - K_expected(2,1), 'K21 before voltage substitution');
assert_zero(K(2,2) - K_expected(2,2), 'K22 before voltage substitution');

%% K entries used in the MATLAB plotting code after voltage substitution
K_sub = simplify(subs(K, [W1, W2], [W1_expected, W2_expected]));

K11_code = sym(1);
K12_code = -W1_expected/(1 - q2)^2 + W2_expected/(1 + q2)^2;
K22_code = kappa ...
    - 2*(1 + q1)*W1_expected/(1 - q2)^3 ...
    - 2*(1 + q1)*W2_expected/(1 + q2)^3;

assert_zero(K_sub(1,1) - K11_code, 'code K11 after voltage substitution');
assert_zero(K_sub(1,2) - K12_code, 'code K12 after voltage substitution');
assert_zero(K_sub(2,2) - K22_code, 'code K22 after voltage substitution');

%% Pull-in equation, Eq. (2.25)
detK_sub = simplify(det(K_sub));

pullin_poly = kappa^2*q2^4 ...
    - (5*kappa*(1 + q1)^2 + kappa^2)*q2^2 ...
    - (2*q1*(1 + q1) - kappa)*(1 + q1)^2;

% det(K) = 0 is equivalent to pullin_poly = 0 away from the singular
% coordinate boundaries q1 = -1 and q2 = +/-1.
det_den = (1 + q1)^2*(1 - q2)*(1 + q2);
assert_zero(detK_sub*det_den - pullin_poly, 'pull-in polynomial from det(K)');

%% Comb-drive and zero-voltage boundary checks
assert_zero(subs(W1_expected - W2_expected, q2, 0), ...
    'comb-drive line q2 = 0 gives V1^2 = V2^2');

q1_v1_zero = (-1 + sqrt(1 - 4*kappa*q2*(q2 + 1)))/2;
q1_v2_zero = (-1 + sqrt(1 - 4*kappa*q2*(q2 - 1)))/2;

assert_zero(subs(W1_expected, q1, q1_v1_zero), ...
    'V1 = 0 boundary');
assert_zero(subs(W2_expected, q1, q1_v2_zero), ...
    'V2 = 0 boundary');

fprintf('-------------------------------------------------------------\n');
fprintf('All symbolic checks passed.\n');

%% Local helper
function assert_zero(expr, label)
    simplified = simplify(expr, 'Steps', 200);
    [num, ~] = numden(simplified);
    num = simplify(expand(num), 'Steps', 200);

    if ~isequal(num, sym(0)) && ~isAlways(num == 0)
        fprintf(2, 'FAIL: %s\n', label);
        disp('Residual numerator:');
        disp(num);
        error('Symbolic verification failed.');
    end

    fprintf('PASS: %s\n', label);
end
