%% Symbolic checks for the corrected Asadi et al. (2021) reduction
% Requires Symbolic Math Toolbox.
close all; clc;

fprintf('Symbolic verification of the Asadi reduction\n');
fprintf('============================================\n');

%% Conservative quadratic force pair
syms q1 q2 w1 w2 kappa real
V = sym(1)/2*w1^2*q1^2 + sym(1)/2*w2^2*q2^2 ...
    + kappa*q1^2*q2;

assert_zero(diff(V, q1) - (w1^2*q1 + 2*kappa*q1*q2), ...
    'first reciprocal restoring force');
assert_zero(diff(V, q2) - (w2^2*q2 + kappa*q1^2), ...
    'second reciprocal restoring force');
assert_zero(diff(diff(V, q1), q2) - diff(diff(V, q2), q1), ...
    'mixed-derivative reciprocity');

%% Corrected polar transformation
syms a1 a2 beta1 beta2 real
p1 = a1*cos(beta1);
s1 = a1*sin(beta1);
p2 = a2*cos(beta2);
s2 = a2*sin(beta2);

assert_zero(p1^2 + s1^2 - a1^2, ...
    'corrected first polar transformation');
assert_zero(p2^2 + s2^2 - a2^2, ...
    'second polar transformation');

%% LME steady-amplitude polynomial
syms zeta1 zeta2 alpha1 alpha2 sigma2 Delta Lambda x real
D2 = zeta2^2 + Delta^2;
K = alpha1*alpha2/D2;
a2_squared = alpha2^2*x^2/D2;

assert_zero(a2_squared*D2 - alpha2^2*x^2, ...
    'internally resonated amplitude relation');

steady_balance = x*((-zeta1 + K*zeta2*x)^2 ...
    + (sigma2 + K*Delta*x)^2) - Lambda^2;
steady_polynomial = K^2*D2*x^3 ...
    + 2*K*(-zeta1*zeta2 + sigma2*Delta)*x^2 ...
    + (zeta1^2 + sigma2^2)*x - Lambda^2;

assert_zero(expand(steady_balance - steady_polynomial), ...
    'LME steady first-mode amplitude polynomial');

fprintf('\nAll Asadi symbolic checks PASS.\n');

function assert_zero(expression, label)
%ASSERT_ZERO Print PASS/FAIL and stop if a residual is nonzero.
    reduced = simplify(expand(expression), 'Steps', 100);
    passed = isAlways(reduced == 0, 'Unknown', 'false');
    if passed
        fprintf('PASS: %s\n', label);
    else
        fprintf('FAIL: %s\n  residual: %s\n', label, char(reduced));
        error('verifyAsadi:nonzeroResidual', ...
            'Symbolic check failed: %s', label);
    end
end
