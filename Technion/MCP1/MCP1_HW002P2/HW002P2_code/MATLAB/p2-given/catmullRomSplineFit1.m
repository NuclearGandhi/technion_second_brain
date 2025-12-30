function [s, xs, ys, dxds, dyds, kappa, vt, tt, pp] = catmullRomSplineFit1(x, y, vt_min, vt_max, varargin)
%CATMULLROMSPLINEFIT Fit + plot a Catmull–Rom spline through (x,y) points,
% and compute arc-length parameterization + curvature + curvature-based speed.
%
%   [s,xs,ys,dxds,dyds,kappa,vt,tt,pp] = catmullRomSplineFit1(x,y,vt_min,vt_max)
%
% Inputs:
%   x,y     : vectors of data points
%   vt_min  : minimum traversal speed along curve (units of length / time)
%   vt_max  : maximum traversal speed along curve
%
% Outputs (evaluated at sampled points along the plotted curve):
%   s      : arc length along the sampled spline (s(1)=0)
%   xs, ys : sampled spline coordinates x(s), y(s)
%   dxds   : x'(s) = dx/ds (unit tangent x-component)
%   dyds   : y'(s) = dy/ds (unit tangent y-component)
%   kappa  : curvature κ(s)
%   vt     : speed v(t) chosen ~ 1/|kappa| and clamped to [vt_min, vt_max]
%   tt     : time instances corresponding to each sampled point (tt(1)=0)
%   pp     : piecewise polynomial form with fields pp.ppx, pp.ppy over q
%
% Name-value options:
%   'SamplesPerSegment' : integer, default 50
%   'Alpha'             : parameterization exponent (0=uniform, 0.5=centripetal, 1=chordal), default 0.5
%   'Plot'              : true/false, default true
%   'LineWidth'         : default 1.8
%   'VtEpsKappa'        : epsilon added to |kappa| to avoid blowups, default 1e-9
%   'VtRefStrategy'     : 'geometric' (default) or 'max' scaling strategy for proportionality
%
% Speed law:
%   vt_raw = Kscale ./ (|kappa| + epsK);
%   vt = clamp(vt_raw, vt_min, vt_max);
%
% Time integration (between samples i and i+1):
%   dt_i = ds_i / v_bar, with v_bar = (vt_i + vt_{i+1})/2  (trapezoid)

% -------------------- Validate required args --------------------
if nargin < 4
    error('Usage: catmullRomSplineFit(x,y,vt_min,vt_max,...)');
end
if ~(isscalar(vt_min) && isscalar(vt_max) && isnumeric(vt_min) && isnumeric(vt_max) && vt_min > 0 && vt_max > 0)
    error('vt_min and vt_max must be positive scalars.');
end
if vt_min > vt_max
    error('vt_min must be <= vt_max.');
end

% -------------------- Parse inputs --------------------
x = x(:); y = y(:);
n = numel(x);
if n ~= numel(y)
    error('x and y must have the same length.');
end
if n < 2
    error('Need at least 2 points.');
end

p = inputParser;
p.addParameter('SamplesPerSegment', 50, @(v) isnumeric(v) && isscalar(v) && v >= 2);
p.addParameter('Alpha', 0.5, @(v) isnumeric(v) && isscalar(v) && v >= 0 && v <= 1);
p.addParameter('Plot', true, @(v) islogical(v) || (isnumeric(v) && isscalar(v)));
p.addParameter('LineWidth', 1.8, @(v) isnumeric(v) && isscalar(v) && v > 0);
p.addParameter('VtEpsKappa', 1e-9, @(v) isnumeric(v) && isscalar(v) && v > 0);
p.addParameter('VtRefStrategy', 'geometric', @(s) ischar(s) || isstring(s));
p.parse(varargin{:});

Ns = round(p.Results.SamplesPerSegment);
alpha = p.Results.Alpha;
doPlot = logical(p.Results.Plot);
lw = p.Results.LineWidth;
epsK = p.Results.VtEpsKappa;
vtRefStrategy = lower(string(p.Results.VtRefStrategy));

P = [x, y];

% -------------------- Alpha-parameter t_i --------------------
t = zeros(n,1);
for i = 2:n
    d = norm(P(i,:) - P(i-1,:));
    t(i) = t(i-1) + d^alpha;
end

if any(diff(t) == 0)
    warning('Some consecutive points are identical (or too close). This may cause degenerate segments.');
end

% -------------------- Compute tangents m_i = dP/dt --------------------
m = zeros(n,2);

if n == 2
    dt = t(2) - t(1); if dt == 0, dt = 1; end
    dir = (P(2,:) - P(1,:)) / dt;
    m(1,:) = dir;
    m(2,:) = dir;
else
    dt1 = t(2) - t(1); if dt1 == 0, dt1 = 1; end
    dtn = t(n) - t(n-1); if dtn == 0, dtn = 1; end
    m(1,:) = (P(2,:) - P(1,:)) / dt1;
    m(n,:) = (P(n,:) - P(n-1,:)) / dtn;

    for i = 2:n-1
        denom = (t(i+1) - t(i-1));
        if denom == 0, denom = 1; end
        m(i,:) = (P(i+1,:) - P(i-1,:)) / denom;
    end
end

% -------------------- Build Hermite cubics per segment --------------------
nSeg = n - 1;

% x(u) = ax*u^3 + bx*u^2 + cx*u + dx
coefsX = zeros(nSeg,4);
coefsY = zeros(nSeg,4);

H = [  2  -2   1   1;
      -3   3  -2  -1;
       0   0   1   0;
       1   0   0   0];

for i = 1:nSeg
    dt = t(i+1) - t(i);
    if dt == 0, dt = 1; end

    T0 = m(i,:)   * dt;   % tangents w.r.t u
    T1 = m(i+1,:) * dt;

    Gx = [P(i,1); P(i+1,1); T0(1); T1(1)];
    Gy = [P(i,2); P(i+1,2); T0(2); T1(2)];

    coefsX(i,:) = (H * Gx).';
    coefsY(i,:) = (H * Gy).';
end

% Piecewise polynomials over global q with breaks 0:1:nSeg
breaks = 0:nSeg;
pp.ppx = mkpp(breaks, coefsX);
pp.ppy = mkpp(breaks, coefsY);

% -------------------- Sample curve + derivatives --------------------
xs = [];
ys = [];
dxdu_all = [];
dydu_all = [];
d2xdu2_all = [];
d2ydu2_all = [];

for i = 1:nSeg
    if i < nSeg
        u = linspace(0,1,Ns+1); u(end) = [];
    else
        u = linspace(0,1,Ns+1);
    end

    a = coefsX(i,1); b = coefsX(i,2); c = coefsX(i,3); d = coefsX(i,4);
    e = coefsY(i,1); f = coefsY(i,2); g = coefsY(i,3); h = coefsY(i,4);

    xu = ((a*u + b).*u + c).*u + d;
    yu = ((e*u + f).*u + g).*u + h;

    dxdu = (3*a*u + 2*b).*u + c;
    dydu = (3*e*u + 2*f).*u + g;

    d2xdu2 = 6*a*u + 2*b;
    d2ydu2 = 6*e*u + 2*f;

    xs = [xs; xu(:)];
    ys = [ys; yu(:)];
    dxdu_all = [dxdu_all; dxdu(:)];
    dydu_all = [dydu_all; dydu(:)];
    d2xdu2_all = [d2xdu2_all; d2xdu2(:)];
    d2ydu2_all = [d2ydu2_all; d2ydu2(:)];
end

% Arc length s from sampled polyline distances
ds = hypot(diff(xs), diff(ys));
s = [0; cumsum(ds)];

% Unit tangent components (derivative w.r.t arc length)
speed_u = hypot(dxdu_all, dydu_all);
speed_u(speed_u == 0) = eps;
dxds = dxdu_all ./ speed_u;
dyds = dydu_all ./ speed_u;

% Curvature (parameterization invariant)
kappa = (dxdu_all .* d2ydu2_all - dydu_all .* d2xdu2_all) ./ (speed_u.^3);

% -------------------- Curvature-based traversal speed vt(s) --------------------
absK = abs(kappa);

% Choose scaling Kscale so vt ~ 1/|kappa| but stays reasonable before clamping
switch vtRefStrategy
    case "geometric"
        % Pick a reference curvature near the median (robust) and set reference speed
        finiteK = absK(isfinite(absK));
        if isempty(finiteK)
            k_ref = 1;
        else
            k_ref = median(finiteK);
            if k_ref < epsK, k_ref = epsK; end
        end
        vt_ref = sqrt(vt_min * vt_max);           % geometric mid-speed
        Kscale = vt_ref * k_ref;                  % vt_raw = Kscale/(|kappa|+epsK)
    case "max"
        % Scale so that the largest 1/|kappa| maps roughly to vt_max before clamping
        invK = 1 ./ (absK + epsK);
        invKmax = max(invK(isfinite(invK)));
        if isempty(invKmax) || invKmax <= 0
            Kscale = vt_max;
        else
            % vt_raw = Kscale * invK; choose Kscale so max(vt_raw)=vt_max
            Kscale = vt_max / invKmax;
        end
    otherwise
        error('Unknown VtRefStrategy. Use ''geometric'' or ''max''.');
end

vt_raw = Kscale ./ (absK + epsK);
vt = min(max(vt_raw, vt_min), vt_max);

% Time integration along samples using trapezoidal average speed
tt = zeros(size(s));
if numel(s) >= 2
    ds_seg = diff(s);
    vbar = 0.5 * (vt(1:end-1) + vt(2:end));
    vbar(vbar <= 0) = eps;
    dt = ds_seg ./ vbar;
    tt(2:end) = cumsum(dt);
end

% -------------------- Plot --------------------
if doPlot
    figure; hold on; grid on; axis equal;
    plot(x, y, '+', 'LineWidth', 1.5, 'MarkerSize', 8);
    plot(xs, ys, '-', 'LineWidth', lw);
    xlabel('x'); ylabel('y');
    title('Catmull–Rom Spline Fit');
    legend('Data points','Catmull–Rom spline','Location','best');

    figure; grid on; hold on;
    plot(tt, vt, 'LineWidth', 1.6);
    xlabel('time t'); ylabel('v_t(t)');
    title('Curvature-based traversal speed (clamped)');
end
end
