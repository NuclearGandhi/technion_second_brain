%% HDY1 HW001 symbolic helper
% Derives:
%   1) Total CoM position components (x_c, y_c)
%   2) CoM velocity components (x_c_dot, y_c_dot)
%   3) Angular momentum coefficients f0, f1, f2 so that
%      H_c = f0*theta_dot + f1*phi1_dot + f2*phi2_dot

clear; clc; close all;

% This will work if "parent" is defined; MATLAB does not have a built-in "parent" function for paths.
% The code below replaces "parent" with fileparts, which is compatible with the default MATLAB folder structure.

scriptPath = mfilename('fullpath');
if isempty(scriptPath)
    scriptPath = which('hw1_symbolic_numeric_calc');
end
scriptDir = fileparts(scriptPath);
projectDir = fileparts(scriptDir);  % parent directory of scriptDir

syms x y theta phi1 phi2 ell m g tau1 tau2 real
syms dx dy dtheta dphi1 dphi2 real
syms ddx ddy ddtheta ddphi1 ddphi2 real

q  = [x; y; theta; phi1; phi2];
qd = [dx; dy; dtheta; dphi1; dphi2];
qdd = [ddx; ddy; ddtheta; ddphi1; ddphi2];

%% Link CoM positions
r0 = [x;
      y];

r1 = [x - ell*cos(theta) - ell*cos(theta + phi1);
      y - ell*sin(theta) - ell*sin(theta + phi1)];

r2 = [x + ell*cos(theta) + ell*cos(theta + phi2);
      y + ell*sin(theta) + ell*sin(theta + phi2)];

rc = simplify((r0 + r1 + r2)/3);
xc = simplify(rc(1));
yc = simplify(rc(2));

%% CoM velocity components
xc_dot = simplify(jacobian(xc, q) * qd);
yc_dot = simplify(jacobian(yc, q) * qd);

%% Angular momentum about total CoM
r0d = [dx; dy];
r1d = simplify(jacobian(r1, q) * qd);
r2d = simplify(jacobian(r2, q) * qd);
rcd = simplify((r0d + r1d + r2d)/3);

r0c = simplify(r0 - rc);
r1c = simplify(r1 - rc);
r2c = simplify(r2 - rc);
v0c = simplify(r0d - rcd);
v1c = simplify(r1d - rcd);
v2c = simplify(r2d - rcd);

cross_z = @(r, v) simplify(r(1)*v(2) - r(2)*v(1));

I = m*ell^2/3;
omega0 = dtheta;
omega1 = dtheta + dphi1;
omega2 = dtheta + dphi2;

Hc = simplify( ...
    m*cross_z(r0c, v0c) + ...
    m*cross_z(r1c, v1c) + ...
    m*cross_z(r2c, v2c) + ...
    I*(omega0 + omega1 + omega2));

Hc = simplify(collect(expand(Hc), dtheta));
Hc = simplify(collect(Hc, dphi1));
Hc = simplify(collect(Hc, dphi2));
f0 = simplify(diff(Hc, dtheta));
f1 = simplify(diff(Hc, dphi1));
f2 = simplify(diff(Hc, dphi2));

%% Assignment 3: link 2 angular momentum about p2
p2 = [x + ell*cos(theta);
      y + ell*sin(theta)];
vp2 = simplify(jacobian(p2, q) * qd);
v2 = simplify(jacobian(r2, q) * qd);
r2p = simplify(r2 - p2);
Ic_link2 = m*ell^2/3;

Hp2 = simplify(Ic_link2*omega2 + m*cross_z(r2p, v2));
zVars = [q; qd];
zdot = [qd; qdd];
Hp2_dot = simplify(jacobian(Hp2, zVars) * zdot);
Fg = [0; -m*g];
Mg = simplify(cross_z(r2p, Fg));
% Balance about moving point p2: Hp2_dot + vp2 x (m*v2) = M_ext
term_inertial = simplify(m * cross_z(vp2, v2));
eq_p2 = simplify(Hp2_dot + term_inertial - (tau2 + Mg));
eq_p2_norm = simplify(eq_p2/(ell*m));
theta_link2_coeff = simplify(diff(eq_p2_norm, ddtheta));
theta_link2_const = simplify(subs(eq_p2_norm, ddtheta, 0));

%% Assignment 4: Lagrange dynamics and partitioning
T_trans = simplify((m/2)*(r0d.'*r0d + r1d.'*r1d + r2d.'*r2d));
T_rot = simplify((I/2)*(omega0^2 + omega1^2 + omega2^2));
T = simplify(T_trans + T_rot);
V = simplify(m*g*(r0(2) + r1(2) + r2(2)));
Lagrangian = simplify(T - V);

dL_dqd = simplify(jacobian(Lagrangian, qd).');
dL_dq = simplify(jacobian(Lagrangian, q).');

E = simplify(jacobian(dL_dqd, q)*qd + jacobian(dL_dqd, qd)*qdd - dL_dq);
Tau = [0; 0; 0; tau1; tau2];

Mmat = simplify(jacobian(E, qdd));
Hvec = simplify(E - Mmat*qdd);
vel_zero = sym(zeros(5,1));
Gvec = simplify(subs(Hvec, [dx; dy; dtheta; dphi1; dphi2], vel_zero));
Bvec = simplify(Hvec - Gvec);
E_std = simplify(Mmat*qdd + Bvec + Gvec - Tau);

% Partition matrices following eq. (1.2) format
idx_b = 1:3;
idx_s = 4:5;

Mbb = simplify(Mmat(idx_b, idx_b));
Mbs = simplify(Mmat(idx_b, idx_s));
Mss = simplify(Mmat(idx_s, idx_s));

Bb = simplify(Bvec(idx_b));
Bs = simplify(Bvec(idx_s));
Gb = simplify(Gvec(idx_b));
Gs = simplify(Gvec(idx_s));

%% Display results
disp('x_c(q) = ');
pretty(xc);

disp('y_c(q) = ');
pretty(yc);

disp('x_c_dot(q, qdot) = ');
pretty(xc_dot);

disp('y_c_dot(q, qdot) = ');
pretty(yc_dot);

disp('H_c(q, qdot) = ');
pretty(Hc);

disp('f0(phi1, phi2) = ');
pretty(f0);

disp('f1(phi1, phi2) = ');
pretty(f1);

disp('f2(phi1, phi2) = ');
pretty(f2);

disp('p2(q) = ');
pretty(p2);

disp('r2(q) = ');
pretty(r2);

disp('r2p(q) = ');
pretty(r2p);

disp('v2(q, qdot) = ');
pretty(v2)

disp('cross_z(r2p, vp2) = ');
pretty(simplify(cross_z(r2p, v2)));

disp('H_p2 about joint (Assignment 3) = ');
pretty(Hp2);

disp('Residual Hp2_dot - (tau2 + M_g) = 0 => ');
pretty(eq_p2_norm);

disp('Kinetic energy T(q, qdot) = ');
pretty(T);

disp('Potential energy V(q) = ');
pretty(V);

disp('Mass matrix M(q) = ');
pretty(Mmat);

disp('Velocity-dependent vector B(q, qdot) = ');
pretty(Bvec);

disp('Gravity vector G(q) = ');
pretty(Gvec);

disp('Check M*qdd + B + G - Tau = 0 => ');
pretty(E_std);

disp('Partitioned blocks (eq. 1.2 form):');
disp('M_bb = ');
pretty(Mbb);

disp('M_bs = ');
pretty(Mbs);

disp('M_ss = ');
pretty(Mss);

disp('B_b = ');
pretty(Bb);

disp('B_s = ');
pretty(Bs);

disp('G_b = ');
pretty(Gb);

disp('G_s = ');
pretty(Gs);

%% Numeric helper data (Assignment 5)
symVars = struct();
symVars.q = [x; y; theta; phi1; phi2];
symVars.qd = [dx; dy; dtheta; dphi1; dphi2];
symVars.q_qd = [symVars.q; symVars.qd];
symVars.theta_link2 = [symVars.q; symVars.qd; ddx; ddy; ddphi1; ddphi2; tau2];
symVars.phi = [phi1; phi2];

symData = struct( ...
    'Mbb', Mbb, ...
    'Mbs', Mbs, ...
    'Mss', Mss, ...
    'Bb', Bb, ...
    'Bs', Bs, ...
    'Gb', Gb, ...
    'Gs', Gs, ...
    'xc', xc, ...
    'yc', yc, ...
    'xc_dot', xc_dot, ...
    'yc_dot', yc_dot, ...
    'Hc', Hc, ...
    'f0', f0, ...
    'f1', f1, ...
    'f2', f2, ...
    'theta_link2_coeff', theta_link2_coeff, ...
    'theta_link2_const', theta_link2_const);

%% Assignment 5: numeric simulation parameters
params = struct();
params.m = 1;
params.g = 10;
params.ell = 0.1;
params.alpha = pi/4;
params.beta = pi/2;
params.psi = pi/4;
params.omega = 1;
params.tf = 2*pi/params.omega;

param_syms = [m; ell; g];
param_vals = [params.m; params.ell; params.g];

symConst = symData;
symFields = fieldnames(symData);
for iField = 1:numel(symFields)
    symConst.(symFields{iField}) = subs(symData.(symFields{iField}), param_syms, param_vals);
end

useMatlabFunction = exist('matlabFunction', 'file') == 2;
numericFuncs = struct();
numericFuncs.Mbb = make_numeric_handle(symConst.Mbb, symVars.q, useMatlabFunction);
numericFuncs.Mbs = make_numeric_handle(symConst.Mbs, symVars.q, useMatlabFunction);
numericFuncs.Mss = make_numeric_handle(symConst.Mss, symVars.q, useMatlabFunction);
numericFuncs.Bb = make_numeric_handle(symConst.Bb, symVars.q_qd, useMatlabFunction);
numericFuncs.Bs = make_numeric_handle(symConst.Bs, symVars.q_qd, useMatlabFunction);
numericFuncs.Gb = make_numeric_handle(symConst.Gb, symVars.q, useMatlabFunction);
numericFuncs.Gs = make_numeric_handle(symConst.Gs, symVars.q, useMatlabFunction);
numericFuncs.xc = make_numeric_handle(symConst.xc, symVars.q, useMatlabFunction);
numericFuncs.yc = make_numeric_handle(symConst.yc, symVars.q, useMatlabFunction);
numericFuncs.xc_dot = make_numeric_handle(symConst.xc_dot, symVars.q_qd, useMatlabFunction);
numericFuncs.yc_dot = make_numeric_handle(symConst.yc_dot, symVars.q_qd, useMatlabFunction);
numericFuncs.Hc = make_numeric_handle(symConst.Hc, symVars.q_qd, useMatlabFunction);
numericFuncs.f0 = make_numeric_handle(symConst.f0, symVars.phi, useMatlabFunction);
numericFuncs.f1 = make_numeric_handle(symConst.f1, symVars.phi, useMatlabFunction);
numericFuncs.f2 = make_numeric_handle(symConst.f2, symVars.phi, useMatlabFunction);
numericFuncs.theta_link2_coeff = make_numeric_handle(symConst.theta_link2_coeff, symVars.theta_link2, useMatlabFunction);
numericFuncs.theta_link2_const = make_numeric_handle(symConst.theta_link2_const, symVars.theta_link2, useMatlabFunction);

t_final = 40;
dt = 1e-3;
t_eval = 0:dt:t_final;

X0 = zeros(6,1);
ode_opts = odeset('RelTol',1e-6, 'AbsTol',1e-8);
[t_state, X_state] = ode45(@(t,X) state_eq(t, X, params, numericFuncs), t_eval, X0, ode_opts);

num_samples = numel(t_state);
qb = X_state(:, 1:3);
qb_dot = X_state(:, 4:6);

phi_hist = zeros(num_samples, 2);
phi_d_hist = zeros(num_samples, 2);
phi_dd_hist = zeros(num_samples, 2);
ddqb_hist = zeros(num_samples, 3);
tau_hist = zeros(num_samples, 2);
theta_dd_link2_hist = zeros(num_samples, 1);
theta_dot_cons_hist = zeros(num_samples, 1);
xc_hist = zeros(num_samples, 1);
yc_hist = zeros(num_samples, 1);
xc_dot_hist = zeros(num_samples, 1);
yc_dot_hist = zeros(num_samples, 1);
Hc_hist = zeros(num_samples, 1);

fprintf('Processing samples: %6.2f%%%%', 0);
for k = 1:num_samples
    t = t_state(k);
    [phi_vec, phi_d_vec, phi_dd_vec] = angles_input(t, params);
    phi_hist(k, :) = phi_vec.';
    phi_d_hist(k, :) = phi_d_vec.';
    phi_dd_hist(k, :) = phi_dd_vec.';

    q = [qb(k, :).'; phi_vec];
    qd = [qb_dot(k, :).'; phi_d_vec];

    [ddqb, tau_vec] = dyn_sol(q, qd, phi_dd_vec, numericFuncs);
    ddqb_hist(k, :) = ddqb.';
    tau_hist(k, :) = tau_vec.';

    xc_hist(k) = numericFuncs.xc(q);
    yc_hist(k) = numericFuncs.yc(q);
    qc_state = [q; qd];
    xc_dot_hist(k) = numericFuncs.xc_dot(qc_state);
    yc_dot_hist(k) = numericFuncs.yc_dot(qc_state);
    Hc_hist(k) = numericFuncs.Hc(qc_state);

    theta_coeff = numericFuncs.theta_link2_coeff([q; qd; ddqb(1); ddqb(2); phi_dd_vec(1); phi_dd_vec(2); tau_vec(2)]);
    theta_const = numericFuncs.theta_link2_const([q; qd; ddqb(1); ddqb(2); phi_dd_vec(1); phi_dd_vec(2); tau_vec(2)]);
    theta_dd_link2_hist(k) = -theta_const ./ theta_coeff;

    f0_val = numericFuncs.f0(q(4:5));
    f1_val = numericFuncs.f1(q(4:5));
    f2_val = numericFuncs.f2(q(4:5));
    if abs(f0_val) > 1e-9
        theta_dot_cons_hist(k) = -(f1_val * qd(4) + f2_val * qd(5)) / f0_val;
    else
        theta_dot_cons_hist(k) = NaN;
    end

    if mod(k, max(1, floor(num_samples/200))) == 0 || k == num_samples
        fprintf('\rProcessing samples: %6.2f%%%%', 100*k/num_samples);
    end
end
fprintf('\n');

resultsFile = fullfile(scriptDir, 'assignment5_data.mat');
save(resultsFile, 't_state', 'X_state', 'qb', 'qb_dot', 'phi_hist', 'phi_d_hist', ...
    'phi_dd_hist', 'ddqb_hist', 'tau_hist', 'theta_dd_link2_hist', ...
    'theta_dot_cons_hist', 'xc_hist', 'yc_hist', 'xc_dot_hist', 'yc_dot_hist', ...
    'Hc_hist', 'params', 't_final', 'dt');
fprintf('Saved dataset to %s\n', resultsFile);

%% Helper function definitions
function Xdot = state_eq(t, X, params, numericFuncs)
    qb = X(1:3);
    qb_dot = X(4:6);
    [phi_vec, phi_d_vec, phi_dd_vec] = angles_input(t, params);
    q = [qb; phi_vec];
    qd = [qb_dot; phi_d_vec];
    [ddqb, ~] = dyn_sol(q, qd, phi_dd_vec, numericFuncs);
    Xdot = [qb_dot; ddqb];
end

function [M, B, G] = dynamics_mat(q, qd, numericFuncs) %#ok<DEFNU>
    Mbb = numericFuncs.Mbb(q);
    Mbs = numericFuncs.Mbs(q);
    Mss = numericFuncs.Mss(q);
    Bb = numericFuncs.Bb([q; qd]);
    Bs = numericFuncs.Bs([q; qd]);
    Gb = numericFuncs.Gb(q);
    Gs = numericFuncs.Gs(q);

    M = [Mbb, Mbs; Mbs.', Mss];
    B = [Bb; Bs];
    G = [Gb; Gs];
end

function [phi_vec, phi_d_vec, phi_dd_vec] = angles_input(t, params)
    [S, Sd, Sdd] = smoothstep_profile(t, params.tf);
    cmd = [-params.alpha + params.beta * sin(params.omega * t - params.psi);
            params.alpha + params.beta * sin(params.omega * t + params.psi)];
    cmd_d = params.beta * params.omega * [cos(params.omega * t - params.psi);
                                         cos(params.omega * t + params.psi)];
    cmd_dd = -params.beta * params.omega^2 * [sin(params.omega * t - params.psi);
                                              sin(params.omega * t + params.psi)];

    phi_vec = S * cmd;
    phi_d_vec = Sd * cmd + S * cmd_d;
    phi_dd_vec = Sdd * cmd + 2 * Sd * cmd_d + S * cmd_dd;
end

function [ddqb, tau_vec] = dyn_sol(q, qd, phi_dd_vec, numericFuncs)
    Mbb = numericFuncs.Mbb(q);
    Mbs = numericFuncs.Mbs(q);
    Bb = numericFuncs.Bb([q; qd]);
    Gb = numericFuncs.Gb(q);

    ddqb = -Mbb \ (Mbs * phi_dd_vec + Bb + Gb);

    Bs = numericFuncs.Bs([q; qd]);
    Gs = numericFuncs.Gs(q);
    Mss = numericFuncs.Mss(q);
    tau_vec = Mbs.' * ddqb + Mss * phi_dd_vec + Bs + Gs;
end

function [S, Sd, Sdd] = smoothstep_profile(t, tf)
    S = ones(size(t));
    Sd = zeros(size(t));
    Sdd = zeros(size(t));
    idx = t <= tf;
    if any(idx)
        u = t(idx) / tf;
        S(idx) = 6*u.^5 - 15*u.^4 + 10*u.^3;
        Sd(idx) = (30*u.^4 - 60*u.^3 + 30*u.^2) / tf;
        Sdd(idx) = (120*u.^3 - 180*u.^2 + 60*u) / tf^2;
    end
end

function fn = make_numeric_handle(expr, vars, useMatlabFunction)
    if isempty(vars)
        value = double(expr);
        fn = @(~) value;
        return;
    end

    if useMatlabFunction
        fn = matlabFunction(expr, 'Vars', {vars});
    else
        fn = @(vals) double(subs(expr, vars, vals));
    end
end
