%example_lesson_9

% an example for Lab assignmen #2 , part 2
% 
%% Izhak Bucher 26-12-2025
%
% This example reads a trajectory created by clicking the mouse
%  to choose several xmy pairs indicating the path of the car
%  The trajectory can be created using "demo_plan_trajectory.m"
%   running this code and choosing option 2 in the Matlab command window
%   creates several *.csv files, we choose one
%   Later we employ catmullRomSplineFit1.m to fit a spline and compute
%    the non-uniform time spacing, based on the curvature in the x,y plane,
%    and the velocities
% Finally, the speed and time instances are written to a *.c file that can
% be imported into the STM32CubeIDE as data arrays.

%% read trajectory from MOUSE clicked points 
%T1=readtable("adaptive_time_trajectory.csv");
T=readtable("custom_path_control_points.csv");
 
% extract chosen points
x = T.x; % x
y = T.y; % y

vt_min=5;
vt_max=200;

[s,xs,ys,dxds,dyds,kappa,vt,tt,pp] = ...
    catmullRomSplineFit1(...
    x,y,vt_min,vt_max,SamplesPerSegment= 22,VtEpsKappa=3e-2,...
    VtRefStrategy='max',Alpha=0 );

clf
subplot(2,1,1)
plot(xs,ys )
title spline-fitted-trajectory
xlabel x_s , ylabel y_s
set(gca,'fontsize',19)
subplot(2,1,2)
 %tmax = max(tt);
 %ts = T1.time_sec*tmax/max(T1.time_sec);
%plot(tt,vt,'.-', ts,T1.vy_m_s,'.-')
plot(tt,vt,'.-')
xlabel t
ylabel v_t
shg
set(gca,'fontsize',19)

%% export to file
v_out = [vt;0;9999];  % add zero speed and stopping symbol (9999)
t_out = [tt; tt(end)+.05; tt(end)+.1  ]
trajectory_export(v_out, t_out, 12, 'trajectory.c')
%% generate code for array

% trajectory_export.m
% Writes two vectors into a C file named "trajectory.c":
%   1) vt -> int16_t array "vt" (rounded to nearest integer)
%   2) tt -> scaled to [0, tmax], then converted to clock-count deltas
%            at 170 MHz (rounded to nearest clock count), written as
%            uint32_t array "tt_clk" (length = length(vt)-1)
%
% Usage:
%   trajectory_export(vt, tt, tmax);                % writes trajectory.c in cwd
%   trajectory_export(vt, tt, tmax, 'trajectory.c');% explicit filename

function trajectory_export(vt, tt, tmax, outFile)

    if nargin < 4 || isempty(outFile)
        outFile = 'trajectory.c';
    end

    % --- Basic checks ---
    vt = vt(:);
    tt = tt(:);

    if numel(vt) ~= numel(tt)
        error('vt and tt must have the same length.');
    end
    if numel(vt) < 2
        error('vt/tt must have length >= 2 to form time differences.');
    end
    if ~isscalar(tmax) || ~isfinite(tmax) || tmax <= 0
        error('tmax must be a positive finite scalar (seconds).');
    end

    % --- 1) vt -> rounded int16_t ---
    vt_r = round(vt);

    % Optional: range check before cast (int16_t is [-32768, 32767])
    if any(vt_r < -32768 | vt_r > 32767)
        error('Rounded vt contains values outside int16_t range.');
    end
    vt_i16 = int16(vt_r);

    % --- 2) tt scaling to [0, tmax] ---
    % Scale based on min/max of provided tt so it spans exactly [0, tmax]
    tt_min = tt(1);          % if you prefer "start at first sample"
    tt_max = tt(end);        % and "end at last sample"
    denom  = tt_max - tt_min;

    if denom == 0
        error('tt has zero span (tt(end) == tt(1)); cannot scale.');
    end

    tt_scaled = (tt - tt_min) / denom * tmax; % now in seconds, from 0..tmax

    % Ensure monotonic nondecreasing (needed for diffs)
    if any(diff(tt_scaled) < 0)
        error('Scaled tt is not nondecreasing. Check ordering of tt.');
    end

    % --- Convert to nearest clock count deltas at 170 MHz ---
    fclk = 170e6; % Hz
    dt_s = diff(tt_scaled);                 % seconds between samples
    tt_clk = uint32(round(dt_s * fclk));    % nearest clock count (ticks)

    % If you need absolute ticks instead of deltas, use:
    % t_abs_clk = uint32(round(tt_scaled * fclk));

    % --- Write C file ---
    fid = fopen(outFile, 'w');
    if fid < 0
        error('Could not open "%s" for writing.', outFile);
    end

    cleaner = onCleanup(@() fclose(fid));

    N = numel(vt_i16);

    fprintf(fid, '/* Auto-generated trajectory file */\n');
    fprintf(fid, '/* vt: int16_t samples (rounded) */\n');
    fprintf(fid, '/* tt_clk: uint32_t clock-count deltas at %.0f Hz */\n', fclk);
    fprintf(fid, '/* N_vt = %d, N_tt_clk = %d */\n\n', N, N-1);

    fprintf(fid, '#include <stdint.h>\n\n');

    fprintf(fid, 'const uint32_t vt_len = %u;\n', uint32(N));
    fprintf(fid, 'const int16_t vt[%u] = {\n', uint32(N));
    write_array(fid, vt_i16, '%d', 12);
    fprintf(fid, '};\n\n');

    fprintf(fid, 'const uint32_t tt_clk_len = %u;\n', uint32(N-1));
    fprintf(fid, 'const uint32_t tt_clk[%u] = {\n', uint32(N-1));
    write_array(fid, tt_clk, '%u', 12);
    fprintf(fid, '};\n');

    % done (fclose handled by onCleanup)
end

function write_array(fid, vec, fmt, perLine)
    % Helper to format arrays nicely in C initializer style
    n = numel(vec);
    for i = 1:n
        if mod(i-1, perLine) == 0
            fprintf(fid, '    ');
        end

        if i < n
            fprintf(fid, [fmt, ', '], vec(i));
        else
            fprintf(fid, fmt, vec(i));
        end

        if mod(i, perLine) == 0 && i < n
            fprintf(fid, '\n');
        end
    end
    fprintf(fid, '\n');
end