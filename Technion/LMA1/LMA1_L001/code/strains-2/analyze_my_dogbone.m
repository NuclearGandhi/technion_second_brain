clear;
close all;
clc;

%% --- User-defined Parameters and Data Loading ---
% Please VERIFY/UPDATE these constants for your specific experiment
Vin = 2.5;       % Strain gauge bridge input voltage [V]
GF = 2.12;       % Gauge Factor of the strain gauge
A_mm2 = 12.5*5;      % Cross-sectional area of the specimen [mm^2]
A_m2 = A_mm2 * 1e-6; % Cross-sectional area [m^2]

% Strain gauge data file (ensure this file is in the MATLAB path or provide full path)
strain_gauge_file = 'dogbone.txt';
% DIC data file (ensure this is the correct path to your .mat file)
dic_data_file = 'C:\\Users\\Ido\\Documents\\lab-data\\advanced-lab\\strains-2\\dogbone\\dic_data.mat'; % Windows path

% --- Load data ---
fprintf('Loading strain gauge data from: %s\n', strain_gauge_file);
try
    opts = detectImportOptions(strain_gauge_file);
    opts.SelectedVariableNames = [1, 2, 3, 4, 5]; % SG1, SG2, SG3, Load, Position
    opts.DataLines = [2, Inf]; % Skip header line
    raw_data = readtable(strain_gauge_file, opts);
    % Convert table to numeric array, handling potential NaNs if columns are not full
    data_sg = table2array(raw_data);
catch ME
    fprintf('Error loading strain gauge data: %s\n', ME.message);
    fprintf('Please ensure the file exists and is correctly formatted.\n');
    return;
end

fprintf('Loading DIC data from: %s\n', dic_data_file);
try
    load(dic_data_file); % This should load a structure, e.g., 'data_dic_save' or 'handles_ncorr'
    % The example script used 'data_dic_save'. If your .mat file saves the Ncorr
    % handle directly (e.g. 'handles_ncorr'), you might need to adjust:
    % For example, if it's 'handles_ncorr', then:
    % data_dic_struct = handles_ncorr.data_dic;
    % If it's already 'data_dic_save' as in the example:
    if exist('data_dic_save', 'var')
        data_dic_struct = data_dic_save;
    elseif exist('handles_ncorr', 'var') % If the main Ncorr handle is saved
        data_dic_struct = handles_ncorr.data_dic;
    else
        error('Could not find expected DIC data variable (e.g., "data_dic_save" or "handles_ncorr") in the .mat file.');
    end
catch ME
    fprintf('Error loading DIC data: %s\n', ME.message);
    fprintf('Please ensure the file exists and contains the expected DIC data structure.\n');
    return;
end

% Determine number of frames for analysis
% Typically, this is limited by the number of DIC frames processed
N_analysis = length(data_dic_struct.strains);
if N_analysis == 0
    error('No strain data found in the loaded DIC structure.');
end

if size(data_sg, 1) < N_analysis
    warning('Number of data points in strain gauge file (%d) is less than DIC frames (%d). Analysis will be limited to %d points.', size(data_sg,1), N_analysis, size(data_sg,1));
    N_analysis = size(data_sg,1);
end

fprintf('Number of frames for analysis: %d\n', N_analysis);

% Extract data from strain gauge file
% dogbone.txt columns: SG1 [mV] SG2 [mV] SG3 [mV] Load [N] Position [mm]
% Corresponding indices in `data_sg` (after readtable with selected vars):
% SG1: 1, SG2: 2, SG3: 3, Load: 4, Position: 5

% USER ACTION: Choose which strain gauge to use (1, 2, or 3 for SG1, SG2, SG3)
% sg_column_index = 2; % Defaulting to SG2 as in the example
% if sg_column_index == 1
%     fprintf('Using Strain Gauge SG1 for analysis.\n');
% elseif sg_column_index == 2
%     fprintf('Using Strain Gauge SG2 for analysis.\n');
% elseif sg_column_index == 3
%     fprintf('Using Strain Gauge SG3 for analysis.\n');
% else
%     error('Invalid sg_column_index. Choose 1, 2, or 3.');
% end

F = data_sg(1:N_analysis, 4);        % Force [N] (column 4 is Load)
% Vout = data_sg(1:N_analysis, sg_column_index); % Strain gauge [mV]
% Reverted Vout inversion
Vout_sg2 = data_sg(1:N_analysis, 2); % SG2 in mV (column 2 of data_sg)
Vout_sg3 = data_sg(1:N_analysis, 3); % SG3 in mV (column 3 of data_sg)
fprintf('Using average of Strain Gauge SG2 and SG3 for analysis in Part 1 & 2.\n');

% Print frame and load info for selected examples
% USER ACTION: Adjust these indices if needed, ensure they are <= N_analysis
example_indices = [3, 30, 60, 85]; % Adjusted example indices
example_indices(example_indices > N_analysis) = []; % Remove indices out of bounds
fprintf('\n--- Selected Frames and Corresponding Loads ---\n');
if ~isempty(example_indices)
    for i = 1:length(example_indices)
        idx = example_indices(i);
        fprintf('Frame %2d: Load = %.1f N\n', idx, F(idx));
    end
else
    fprintf('No example frames to display or N_analysis is too small.\n');
end

%% --- Part 1: Strain Calculation and Elastic Modulus ---

% Strain from gauge
% epsilon_gauge = (4 * Vout * 1e-3) ./ (GF * Vin); % Vout is in mV
epsilon_gauge_sg2_p1 = (4 * Vout_sg2 * 1e-3) ./ (GF * Vin);
epsilon_gauge_sg3_p1 = (4 * Vout_sg3 * 1e-3) ./ (GF * Vin);
epsilon_gauge_avg_p1 = (epsilon_gauge_sg2_p1 + epsilon_gauge_sg3_p1) / 2;

% Normalize strain gauge average to start from approximately zero
first_valid_sg_idx_p1 = find(~isnan(epsilon_gauge_avg_p1), 1, 'first');
if ~isempty(first_valid_sg_idx_p1)
    epsilon_gauge_avg_p1 = epsilon_gauge_avg_p1 - epsilon_gauge_avg_p1(first_valid_sg_idx_p1);
    fprintf('Normalized average strain gauge data (Part 1) relative to first valid reading.\n');
else
    fprintf('Warning: No valid average strain gauge data found for Part 1 normalization.\n');
end

% Strain from DIC (average εyy from each frame)
epsilon_dic = zeros(N_analysis, 1);
for i = 1:N_analysis
    if i <= length(data_dic_struct.strains) && isfield(data_dic_struct.strains(i), 'plot_eyy_ref_formatted') && isfield(data_dic_struct.strains(i), 'roi_ref_formatted')
        Eyy = data_dic_struct.strains(i).plot_eyy_ref_formatted;
        % Use .mask property of the roi_ref_formatted object
        current_roi_mask = data_dic_struct.strains(i).roi_ref_formatted.mask;
        Eyy_valid = Eyy(current_roi_mask);
        % If ROI is all false or Eyy_valid is empty, Eyy could be all zeros or NaN
        % Filter out zeros and NaNs if any remain or if ROI isn't perfect
        Eyy_valid = Eyy_valid(Eyy_valid ~= 0 & ~isnan(Eyy_valid));
        if isempty(Eyy_valid)
            epsilon_dic(i) = NaN; % Or handle as per your preference
        else
            epsilon_dic(i) = mean(Eyy_valid, 'omitnan');
        end
    else
        fprintf('Warning: Missing plot_eyy_ref_formatted or roi_ref_formatted for frame %d\n', i);
        epsilon_dic(i) = NaN;
    end
end

% Normalize DIC strain (set ε=0 at frame 1, if frame 1 is valid)
if ~isnan(epsilon_dic(1))
    epsilon_dic = epsilon_dic - epsilon_dic(1);
else
    fprintf('Warning: DIC strain for frame 1 is NaN. Cannot normalize relative to frame 1.\n');
    % Alternative: find first non-NaN value to normalize, or skip normalization
    first_valid_idx = find(~isnan(epsilon_dic), 1, 'first');
    if ~isempty(first_valid_idx)
        epsilon_dic = epsilon_dic - epsilon_dic(first_valid_idx);
        fprintf('Normalized DIC strain relative to first valid frame: %d\n', first_valid_idx);
    end
end

% Filter valid (positive strain and positive force) data for plotting and analysis
% Allow strains to be zero after normalization
valid_combined = ~isnan(epsilon_gauge_avg_p1) & ~isnan(epsilon_dic) & epsilon_gauge_avg_p1 >= 0 & epsilon_dic >= 0 & F > 0;

F_common = F(valid_combined);
% epsilon_gauge_common = epsilon_gauge(valid_combined);
epsilon_gauge_avg_common = epsilon_gauge_avg_p1(valid_combined);
epsilon_dic_common = epsilon_dic(valid_combined);

if isempty(F_common)
    error('No valid data points after filtering. Check data quality and filter conditions.');
end

% Elastic range
% USER ACTION: Define the range of points from F_common to use for elastic fit
% Adjust start_fit_offset to skip initial points from F_common
% Adjust num_points_for_fit for the number of points to include in the fit
start_fit_offset = 1; % Number of initial valid data points to skip (e.g., 0, 1, 2...)
num_points_for_fit = 5; % Number of data points to use for the fit, after the offset

if start_fit_offset < 0, start_fit_offset = 0; end

fit_start_index = 1 + start_fit_offset;
fit_end_index = fit_start_index + num_points_for_fit - 1;

if fit_start_index > length(F_common)
    error('start_fit_offset is too large, no data points left for fitting.');
end
if fit_end_index > length(F_common)
    fit_end_index = length(F_common);
    fprintf('Warning: num_points_for_fit adjusted as it exceeded available common data points after offset.\n');
end

elastic_indices = fit_start_index:fit_end_index;
N_elastic = length(elastic_indices);

if N_elastic < 2
    warning('N_elastic is less than 2 (%d points selected for fitting). Polyfit will error or be unreliable. Adjust start_fit_offset or num_points_for_fit.\n', N_elastic);
    % Optionally, could skip fitting if N_elastic < 2
    E_gauge = NaN; sE_gauge = NaN; F_fit_gauge = [];
    E_dic = NaN; sE_dic = NaN; F_fit_dic = [];
    sigma_y_gauge_offset = NaN; % Yield strength cannot be calculated
else
    fprintf('Using N_elastic = %d points (indices %d to %d of F_common) for elastic modulus calculation.\n', N_elastic, elastic_indices(1), elastic_indices(end));
end

F_elastic = F_common(elastic_indices);
% strain_g_elastic = epsilon_gauge_common(1:N_elastic);
strain_g_elastic = epsilon_gauge_avg_common(elastic_indices);
strain_d_elastic = epsilon_dic_common(elastic_indices);
% F_dic_elastic is F_elastic, since we use F_common

% --- Calculate Stress ---
stress_common = F_common / A_m2; % Stress for all common valid data points
stress_elastic = F_elastic / A_m2; % Stress for the points used in elastic fit

% --- Linear regression: gauge (Stress vs Strain) ---
if N_elastic >=2
    p_gauge_stress = polyfit(strain_g_elastic, stress_elastic, 1);
    stress_fit_gauge = polyval(p_gauge_stress, strain_g_elastic);
    E_gauge = p_gauge_stress(1); % E_gauge is the slope d(stress)/d(strain)
    % Error estimation for E_gauge from stress-strain fit
    res_gauge_stress = stress_elastic - stress_fit_gauge;
    RSS_gauge_stress = sum(res_gauge_stress.^2);
    sigma2_gauge_stress = RSS_gauge_stress / (N_elastic - 2);
    xbar_g_stress = mean(strain_g_elastic);
    Sxx_g_stress = sum((strain_g_elastic - xbar_g_stress).^2);
    s_slope_gauge_stress = sqrt(sigma2_gauge_stress / Sxx_g_stress);
    sE_gauge = s_slope_gauge_stress; % Standard error of E_gauge
else
    p_gauge_stress = [NaN NaN]; stress_fit_gauge = []; E_gauge = NaN; sE_gauge = NaN;
end

% --- Linear regression: gauge (Force vs Strain) for Fig 1 plot slope AND Fig 2 offset line slope ---
p_gauge_force_elastic = [NaN NaN]; 
slope_force_strain_elastic_gauge = NaN; % This is dF/dEpsilon for AVG GAUGE in elastic region
fit_force_gauge_fig1 = [];
if N_elastic >=2
    p_gauge_force_elastic = polyfit(strain_g_elastic, F_elastic, 1); 
    slope_force_strain_elastic_gauge = p_gauge_force_elastic(1);
    fit_force_gauge_fig1 = polyval(p_gauge_force_elastic, strain_g_elastic);
end

% --- Linear regression: DIC (Stress vs Strain) ---
if N_elastic >= 2
    p_dic_stress = polyfit(strain_d_elastic, stress_elastic, 1);
    stress_fit_dic = polyval(p_dic_stress, strain_d_elastic);
    E_dic = p_dic_stress(1); % E_dic is the slope d(stress)/d(strain)
    % Error estimation for E_dic from stress-strain fit
    res_dic_stress = stress_elastic - stress_fit_dic;
    RSS_dic_stress = sum(res_dic_stress.^2);
    sigma2_dic_stress = RSS_dic_stress / (N_elastic - 2);
    xbar_d_stress = mean(strain_d_elastic);
    Sxx_d_stress = sum((strain_d_elastic - xbar_d_stress).^2);
    s_slope_dic_stress = sqrt(sigma2_dic_stress / Sxx_d_stress);
    sE_dic = s_slope_dic_stress; % Standard error of E_dic
else
    p_dic_stress = [NaN NaN]; stress_fit_dic = []; E_dic = NaN; sE_dic = NaN;
end

% --- Linear regression: DIC (Force vs Strain) for Fig 1 plot slope ---
p_dic_force_elastic = [NaN NaN];
slope_force_strain_elastic_dic_fig1 = NaN;
fit_force_dic_fig1 = [];
if N_elastic >=2
    p_dic_force_elastic = polyfit(strain_d_elastic, F_elastic, 1); % F_elastic vs strain_d_elastic
    slope_force_strain_elastic_dic_fig1 = p_dic_force_elastic(1);
    fit_force_dic_fig1 = polyval(p_dic_force_elastic, strain_d_elastic);
end

% --- 0.2% Offset Yield Strength Calculation (from average STRESS-STRAIN gauge data) ---
sigma_y_gauge_offset = NaN;
epsilon_offset_line_stress_calc = [];

if N_elastic >= 2 && ~isnan(E_gauge)
    offset_strain = 0.002;
    % Define the offset line: Stress = E_gauge * (Strain - offset_strain)
    % We need to find where this line intersects the full stress_common vs epsilon_gauge_avg_common curve
    
    % Generate points for the offset line for plotting (extended range)
    min_strain_plot = min(epsilon_gauge_avg_common) - offset_strain; % Extend a bit for visual
    max_strain_plot = max(epsilon_gauge_avg_common);
    epsilon_offset_line_stress_calc = linspace(offset_strain, max_strain_plot, 100);
    stress_offset_line_stress_calc = E_gauge * (epsilon_offset_line_stress_calc - offset_strain);
    % Ensure offset line doesn't plot negative stress if it starts before data
    stress_offset_line_stress_calc(stress_offset_line_stress_calc < 0 & epsilon_offset_line_stress_calc < offset_strain + min(epsilon_gauge_avg_common(epsilon_gauge_avg_common>0))) = NaN; 

    % Find intersection points
    % Consider only the part of the curve where epsilon_gauge_avg_common >= offset_strain
    relevant_indices = find(epsilon_gauge_avg_common >= offset_strain);
    if length(relevant_indices) > 1
        strain_curve_segment = epsilon_gauge_avg_common(relevant_indices);
        stress_curve_segment = stress_common(relevant_indices);
        
        % Values of the offset line at the strain points of the curve segment
        stress_offset_at_curve_strains = E_gauge * (strain_curve_segment - offset_strain);
        
        % Difference between actual stress and offset line stress
        difference = stress_curve_segment - stress_offset_at_curve_strains;
        
        % Find where the difference crosses zero
        sign_changes = find(diff(sign(difference)));
        
        if ~isempty(sign_changes)
            idx1 = sign_changes(1); % Index before a sign change in 'difference' array
            idx2 = idx1 + 1;        % Index after a sign change in 'difference' array
            
            % Linear interpolation to find intersection strain and stress
            % Intersection of y1=m1*x+c1 and y2=m2*x+c2 is x=(c2-c1)/(m1-m2)
            % Here, one line is data segment, other is offset line.
            % Interpolate stress (y) vs strain (x)
            % Stress_curve(idx1) at Strain_curve(idx1)
            % Stress_curve(idx2) at Strain_curve(idx2)
            % Stress_offset(idx1) at Strain_curve(idx1)
            % Stress_offset(idx2) at Strain_curve(idx2)
            
            % Interpolate between the two points on the experimental curve where sign changes
            p_intersect = polyfit(difference(idx1:idx2), strain_curve_segment(idx1:idx2), 1);
            intersect_strain = polyval(p_intersect, 0); % Strain where difference is zero
            sigma_y_gauge_offset = E_gauge * (intersect_strain - offset_strain);
            
            fprintf(1, '0.2%% Offset Yield Strength (Gauge): %.2f MPa\n', sigma_y_gauge_offset / 1e6);
        else
            fprintf(1, 'Warning: 0.2%% offset line does not intersect the stress-strain curve (gauge data).\n');
        end
    else
        fprintf(1, 'Warning: Not enough data points beyond 0.2%% strain to find offset yield strength (gauge data).\n');
    end
else
    fprintf(1, 'Warning: E_gauge not valid, cannot calculate 0.2%% offset yield strength.\n');
end


%% --- Plot elastic region only (now Force vs Strain for Fig 1) ---
% --- Determine which example_indices fall into the elastic region for Fig 1 ---
valid_common_frame_indices_for_map = find(valid_combined); 
highlight_points_strain_g_elastic_fig1 = [];
highlight_points_FORCE_elastic_fig1 = []; % Changed from stress to force

if ~isempty(elastic_indices) && N_elastic > 0 && ~isempty(valid_common_frame_indices_for_map) && ~isempty(example_indices)
    elastic_region_original_frame_indices = valid_common_frame_indices_for_map(elastic_indices);
    frames_to_highlight_on_fig1 = intersect(example_indices, elastic_region_original_frame_indices);
    
    if ~isempty(frames_to_highlight_on_fig1)
        num_highlights_fig1 = length(frames_to_highlight_on_fig1);
        highlight_points_strain_g_elastic_fig1 = zeros(num_highlights_fig1, 1);
        highlight_points_FORCE_elastic_fig1 = zeros(num_highlights_fig1, 1); % Changed
        actual_found_count_fig1 = 0;

        for i_hl = 1:num_highlights_fig1
            current_frame = frames_to_highlight_on_fig1(i_hl);
            idx_in_elastic_set = find(elastic_region_original_frame_indices == current_frame, 1);
            if ~isempty(idx_in_elastic_set) 
                actual_found_count_fig1 = actual_found_count_fig1 + 1;
                highlight_points_strain_g_elastic_fig1(actual_found_count_fig1) = strain_g_elastic(idx_in_elastic_set);
                highlight_points_FORCE_elastic_fig1(actual_found_count_fig1) = F_elastic(idx_in_elastic_set); % Changed to F_elastic
            end
        end
        highlight_points_strain_g_elastic_fig1 = highlight_points_strain_g_elastic_fig1(1:actual_found_count_fig1);
        highlight_points_FORCE_elastic_fig1 = highlight_points_FORCE_elastic_fig1(1:actual_found_count_fig1); % Changed
    end
end
% --- End Fig 1 Highlight Prep ---

figure; hold on; grid on; box on;
% Plot force-strain data for the elastic region for Figure 1
plot(strain_g_elastic, F_elastic, 'bo', 'MarkerSize', 4, 'DisplayName', 'Strain Gauge Data (Elastic)'); % Simplified name
plot(strain_d_elastic, F_elastic, 'ro', 'MarkerSize', 4, 'DisplayName', 'DIC Data (Elastic, $\varepsilon_{yy}$ avg)'); % Simplified name, assuming 'eyy' is fine, if not, remove too

% Plot the force-strain fit line based on the elastic region only for Figure 1
% The legend will show E (from stress-strain), though plot shows dF/dEpsilon visually
if N_elastic >= 2 
    if ~isempty(fit_force_gauge_fig1) && ~isnan(E_gauge) % Check E_gauge for legend
        plot(strain_g_elastic, fit_force_gauge_fig1, 'b-', 'LineWidth', 1.5, 'DisplayName', sprintf('Avg Gauge Fit (E = %.2f GPa)', E_gauge/1e9));
    end
    if ~isempty(fit_force_dic_fig1) && ~isnan(E_dic) % Check E_dic for legend
        plot(strain_d_elastic, fit_force_dic_fig1, 'r-', 'LineWidth', 1.5, 'DisplayName', sprintf('DIC Fit (E = %.2f GPa)', E_dic/1e9));
    end
end

% Plot highlighted example_indices for Figure 1
if ~isempty(highlight_points_strain_g_elastic_fig1) && ~isempty(highlight_points_FORCE_elastic_fig1)
    plot(highlight_points_strain_g_elastic_fig1, highlight_points_FORCE_elastic_fig1, 'mp', ...
        'MarkerFaceColor', 'm', 'MarkerSize', 10, 'DisplayName', 'Example Frames');
end

xlabel('Strain, $\varepsilon$','Interpreter','latex');
ylabel('Force (N)','Interpreter','latex');
title(sprintf('Force vs. Strain (Elastic Region, $N_{elastic}=%d$)', N_elastic),'Interpreter','latex');

% Manually center the legend for Figure 1
lgd1 = legend('show', 'Interpreter', 'latex'); % Create legend and get handle
lgd1.Units = 'normalized'; % Ensure position is normalized to axes
current_width_lgd1 = lgd1.Position(3);
current_height_lgd1 = lgd1.Position(4);
new_left_lgd1 = (1 - current_width_lgd1) / 2;
new_bottom_lgd1 = (1 - current_height_lgd1) / 2;
lgd1.Position = [new_left_lgd1, new_bottom_lgd1, current_width_lgd1, current_height_lgd1];

set(gca, 'FontSize', 14);
hold off;

% Save the first figure
try
    fig1_handle = gcf; % Get current figure handle
    fig1_handle.Position = [100, 100, 1000, 800]; % [left, bottom, width, height] in pixels
    fig1_filename = 'figure1_elastic_region.png';
    print(fig1_handle, fig1_filename, '-dpng', '-r300'); % Save as PNG with 300 DPI
    fprintf(1, 'Saved first figure as: %s\n', fullfile(pwd, fig1_filename));
catch ME_fig1
    fprintf(1, 'Warning: Could not save Figure 1. Error: %s\n', ME_fig1.message);
end

%% --- Modulus output ---
% Temporarily simplify to test fprintf basic functionality
fprintf(1, 'Test output for Modulus Section\n'); 
% fprintf(1, '\n--- Estimated Young\'\'s Moduli [GPa] (Elastic Range) ---\n');
fprintf(1, 'Avg Strain Gauge (SG2 & SG3): %.3f GPa ± %.3f GPa\n', E_gauge/1e9, sE_gauge/1e9);
fprintf(1, 'DIC (avg Eyy): %.3f GPa ± %.3f GPa\n', E_dic/1e9, sE_dic/1e9);
if ~isnan(sigma_y_gauge_offset)
    fprintf(1, '0.2%% Offset Yield Strength (Gauge): %.2f MPa\n', sigma_y_gauge_offset/1e6);
end

%% --- Student t-test on E_gauge and E_dic ---
if N_elastic > 2 && ~isnan(sE_gauge) && ~isnan(sE_dic)
    alpha = 0.05; % Significance level (e.g., 0.05 for 95% confidence)
    % Degrees of freedom for pooled variance (conservative: use N_elastic-2 from one sample,
    % or for two independent samples with individual fits, it's more complex.
    % Here, we're comparing two slopes, each fit with N_elastic points.
    % The t-statistic for comparing two regression coefficients is:
    % t = (b1 - b2) / sqrt(SE(b1)^2 + SE(b2)^2)
    % Degrees of freedom: (N1 - 2) + (N2 - 2) = 2 * (N_elastic - 2) if slopes are from different datasets.
    % Or, if comparing to a known value, df = N-2.
    % For comparing two slopes, use the SE of the difference.
    % A common approach is to use a conservative df, e.g., min(N1-2, N2-2).
    % Since N1=N2=N_elastic, df = N_elastic-2.
    
    df_ttest = N_elastic - 2; % Using conservative df for t-critical value lookup
    if df_ttest <= 0
        fprintf('Not enough degrees of freedom for t-test.\n');
    else
        t_crit = tinv(1 - alpha/2, df_ttest);
        
        diff_E = abs(E_gauge - E_dic);
        SE_diff = sqrt(sE_gauge^2 + sE_dic^2); % Standard error of the difference
        
        if SE_diff == 0
             fprintf(1, 'Cannot perform t-test: Standard error of difference is zero.\n');
        else
            t_stat = diff_E / SE_diff;
            confidence_level_percent = (1-alpha)*100;
            
            fprintf(1, '\n--- Student t-test Comparison (alpha=%.2f) ---\n', alpha);
            fprintf(1, 'Degrees of Freedom (df) = %d\n', df_ttest);
            fprintf(1, 't-statistic = %.3f, t-critical (%.1f%% two-tailed) = %.3f\n', t_stat, confidence_level_percent, t_crit);
            if t_stat > t_crit
                % fprintf(1, 'The difference in Young\'\'s moduli IS statistically significant at the %.0f%% confidence level.\n', confidence_level_percent);
                fprintf(1, 't-test: Difference IS significant (%.0f%%)\n', confidence_level_percent); % Simplified test line
            else
                % fprintf(1, 'The difference in Young\'\'s moduli is NOT statistically significant at the %.0f%% confidence level.\n', confidence_level_percent);
                fprintf(1, 't-test: Difference IS NOT significant (%.0f%%)\n', confidence_level_percent); % Simplified test line that was erroring
            end
        end
    end
else
    fprintf(1, '\n--- Student t-test Comparison ---\n');
    fprintf(1, 'Skipping t-test due to insufficient data or undefined errors.\n');
end

%% --- Student t-test against Literature Values ---
% USER ACTION: Define literature values
E_literature_Pa = 69e9; % Placeholder - e.g., 70e9 for Aluminum
sigma_y_literature_Pa = 267e6; % Placeholder - e.g., 250e6 for some Aluminum alloys

fprintf(1, '\n--- t-test against Literature Values (if defined) ---\n');

% t-test for E_gauge vs E_literature
if ~isnan(E_literature_Pa) && ~isnan(E_gauge) && ~isnan(sE_gauge) && N_elastic >=2
    t_stat_E_gauge_lit = (E_gauge - E_literature_Pa) / sE_gauge; % sE_gauge is std error of E_gauge
    df_E_lit = N_elastic - 2; % Degrees of freedom from the regression fit of E_gauge
    p_val_E_gauge_lit = 2 * tcdf(-abs(t_stat_E_gauge_lit), df_E_lit); % two-tailed p-value
    fprintf(1, 'Comparison of E_gauge (%.2f GPa) with Literature E (%.2f GPa):\n', E_gauge/1e9, E_literature_Pa/1e9);
    fprintf(1, '  t-statistic = %.3f, df = %d, p-value = %.4f\n', t_stat_E_gauge_lit, df_E_lit, p_val_E_gauge_lit);
    if p_val_E_gauge_lit < alpha % alpha defined earlier for t-test (e.g. 0.05)
        fprintf(1, '  Difference IS statistically significant at alpha = %.2f\n', alpha);
    else
        fprintf(1, '  Difference IS NOT statistically significant at alpha = %.2f\n', alpha);
    end
else
    fprintf(1, 'Skipping t-test for E_gauge vs Literature E (missing data or E_literature_Pa not set).\n');
end

% t-test for E_dic vs E_literature
if ~isnan(E_literature_Pa) && ~isnan(E_dic) && ~isnan(sE_dic) && N_elastic >=2
    t_stat_E_dic_lit = (E_dic - E_literature_Pa) / sE_dic; % sE_dic is std error of E_dic
    df_E_lit_dic = N_elastic - 2; % Degrees of freedom from the regression fit of E_dic
    p_val_E_dic_lit = 2 * tcdf(-abs(t_stat_E_dic_lit), df_E_lit_dic); % two-tailed p-value
    fprintf(1, 'Comparison of E_dic (%.2f GPa) with Literature E (%.2f GPa):\n', E_dic/1e9, E_literature_Pa/1e9);
    fprintf(1, '  t-statistic = %.3f, df = %d, p-value = %.4f\n', t_stat_E_dic_lit, df_E_lit_dic, p_val_E_dic_lit);
    if p_val_E_dic_lit < alpha
        fprintf(1, '  Difference IS statistically significant at alpha = %.2f\n', alpha);
    else
        fprintf(1, '  Difference IS NOT statistically significant at alpha = %.2f\n', alpha);
    end
else
    fprintf(1, 'Skipping t-test for E_dic vs Literature E (missing data or E_literature_Pa not set).\n');
end

% Note: t-test for yield strength vs literature is more complex to set up without std error for sigma_y_gauge_offset
% For now, we will just report the calculated yield strength.
if ~isnan(sigma_y_literature_Pa) && ~isnan(sigma_y_gauge_offset)
    fprintf(1, 'Calculated 0.2%% Offset Yield Strength (Gauge): %.2f MPa\n', sigma_y_gauge_offset/1e6);
    fprintf(1, 'Literature Yield Strength: %.2f MPa\n', sigma_y_literature_Pa/1e6);
else
     fprintf(1, 'Literature Yield Strength (sigma_y_literature_Pa) not set, skipping direct comparison printout.\n');
end


%% --- Section 2: DIC Point Selection: Near & Far from Neck ---
% This section analyzes strain at specific points (near/far from failure) using DIC area averaging.

fprintf(1, '\n--- Section 2: DIC Point Selection Analysis ---\n');

% Strain Gauge 3 data for Section 2 (ensure Vout_sg3 is defined earlier from raw data)
epsilon_sg3_s2 = (4 * Vout_sg3 * 1e-3) ./ (GF * Vin); % Using Vout_sg3 (column 3)

% Normalize SG3 strain data for Section 2
first_valid_sg3_idx_s2 = find(~isnan(epsilon_sg3_s2), 1, 'first');
if ~isempty(first_valid_sg3_idx_s2)
    epsilon_sg3_s2_normalized = epsilon_sg3_s2 - epsilon_sg3_s2(first_valid_sg3_idx_s2);
    fprintf(1, 'Normalized Strain Gauge 3 data (Section 2) relative to its first valid reading.\n');
else
    fprintf(1, 'Warning: No valid Strain Gauge 3 data found for Section 2 normalization.\n');
    epsilon_sg3_s2_normalized = epsilon_sg3_s2; % Keep as is if no valid points to normalize
end

% Initialize DIC strain arrays for this section
strain_dic_far_neck = zeros(N_analysis, 1);
strain_dic_near_neck = zeros(N_analysis, 1);

% --- DIC Point Coordinates and Averaging Radius (USER DEFINED) --- 
coords_near_failure = [350, 155]; % [X_pixel, Y_pixel]
coords_far_failure  = [350, 382]; % [X_pixel, Y_pixel]
dic_avg_radius    = 15;      % Pixels
% --- End of DIC Point Parameters ---

fprintf(1, 'DIC Point Selection Parameters:\n');
fprintf(1, '  Near Failure Coords (X,Y): [%d, %d], Radius: %d px\n', coords_near_failure(1), coords_near_failure(2), dic_avg_radius);
fprintf(1, '  Far from Failure Coords (X,Y): [%d, %d], Radius: %d px\n', coords_far_failure(1), coords_far_failure(2), dic_avg_radius);

% Create a meshgrid for pixel coordinates - once, if Eyy map size is constant
first_valid_strain_idx = find(arrayfun(@(s) isfield(s, 'plot_eyy_ref_formatted') && ~isempty(s.plot_eyy_ref_formatted), data_dic_struct.strains), 1);
if isempty(first_valid_strain_idx)
    error('No frames found with plot_eyy_ref_formatted data to determine Eyy map size for Section 2.');
end
[map_rows, map_cols] = size(data_dic_struct.strains(first_valid_strain_idx).plot_eyy_ref_formatted);
[X_grid, Y_grid] = meshgrid(1:map_cols, 1:map_rows); % X_grid columns, Y_grid rows

% Analyze all frames for specific DIC points
for i = 1:N_analysis
    if i <= length(data_dic_struct.strains) && isfield(data_dic_struct.strains(i), 'plot_eyy_ref_formatted') && isfield(data_dic_struct.strains(i), 'roi_ref_formatted')
        Eyy = data_dic_struct.strains(i).plot_eyy_ref_formatted;
        current_roi_object = data_dic_struct.strains(i).roi_ref_formatted;
        
        Eyy_masked = Eyy; % Start with raw Eyy for the frame
        if isprop(current_roi_object, 'mask') && ~isempty(current_roi_object.mask)
            if all(size(Eyy_masked) == size(current_roi_object.mask))
                Eyy_masked(~current_roi_object.mask) = NaN; % Apply main ROI mask from Ncorr
            else
                 if i==1, fprintf(1, 'Warning: Mismatch in Eyy and ROI mask dimensions for frame %d in Sec 2. Cannot apply main ROI mask.\n', i); end
            end
        else
            if i==1, fprintf(1, 'Warning: Main ROI mask not found/empty for frame %d in Sec 2. Using Eyy data as is (may include invalid points).\n', i); end
        end

        % --- Strain "Near Failure" using area averaging ---
        y_center_near = coords_near_failure(2); % Y-coordinate for row index
        x_center_near = coords_near_failure(1); % X-coordinate for col index
        distance_near = sqrt((X_grid - x_center_near).^2 + (Y_grid - y_center_near).^2);
        circular_mask_near = distance_near <= dic_avg_radius;
        
        Eyy_values_near = Eyy_masked(circular_mask_near); % Extract values within the circle from the (already ROI-masked) Eyy_masked
        strain_dic_near_neck(i) = mean(Eyy_values_near, 'omitnan');

        % --- Strain "Far from Failure" using area averaging ---
        y_center_far = coords_far_failure(2); % Y-coordinate for row index
        x_center_far = coords_far_failure(1); % X-coordinate for col index
        distance_far = sqrt((X_grid - x_center_far).^2 + (Y_grid - y_center_far).^2);
        circular_mask_far = distance_far <= dic_avg_radius;

        Eyy_values_far = Eyy_masked(circular_mask_far);
        strain_dic_far_neck(i) = mean(Eyy_values_far, 'omitnan');
    else
        strain_dic_near_neck(i) = NaN;
        strain_dic_far_neck(i) = NaN;
        if i==1, fprintf(1, 'Warning: Missing DIC data structure for frame %d in Section 2 point selection loop.\n', i); end
    end
end

% Normalize DIC strains for Section 2
first_valid_dic_near_idx = find(~isnan(strain_dic_near_neck), 1, 'first');
if ~isempty(first_valid_dic_near_idx)
    strain_dic_near_neck_normalized = strain_dic_near_neck - strain_dic_near_neck(first_valid_dic_near_idx);
else
    strain_dic_near_neck_normalized = strain_dic_near_neck; % Keep as is
end

first_valid_dic_far_idx = find(~isnan(strain_dic_far_neck), 1, 'first');
if ~isempty(first_valid_dic_far_idx)
    strain_dic_far_neck_normalized = strain_dic_far_neck - strain_dic_far_neck(first_valid_dic_far_idx);
else
    strain_dic_far_neck_normalized = strain_dic_far_neck; % Keep as is
end

% Filter invalid values for Section 2 plotting
valid_sec2 = ~isnan(epsilon_sg3_s2_normalized) & ...
             ~isnan(strain_dic_far_neck_normalized) & ...
             ~isnan(strain_dic_near_neck_normalized) & ...
             epsilon_sg3_s2_normalized >= 0 & ...
             strain_dic_far_neck_normalized >= 0 & ...
             strain_dic_near_neck_normalized >= 0 & ...
             F > 0; % F is from global scope, ensure it aligns with N_analysis

if sum(valid_sec2) < 2 % Need at least 2 points to plot lines
    fprintf(1, 'Warning: Not enough valid data points for Section 2 plot (%d points). Skipping plot.\n', sum(valid_sec2));
else
    sg3_plot_s2 = epsilon_sg3_s2_normalized(valid_sec2);
    dic_far_plot_s2 = strain_dic_far_neck_normalized(valid_sec2);
    dic_near_plot_s2 = strain_dic_near_neck_normalized(valid_sec2);
    F_plot_s2 = F(valid_sec2); % Ensure F is also filtered by valid_sec2

    %% --- Plot for Section 2 ---
    % --- Determine which example_indices are plotted on Fig 2's Avg Gauge Data ---
    % THIS HIGHLIGHTING IS BEING MOVED TO DIC NEAR FAILURE DATA
    % highlight_points_strain_avg_gauge_fig2 = [];
    % highlight_points_force_avg_gauge_fig2 = [];
    % if exist('valid_common_frame_indices_for_map', 'var') && ~isempty(valid_common_frame_indices_for_map) && ~isempty(example_indices)
    %     frames_to_highlight_on_fig2 = intersect(example_indices, valid_common_frame_indices_for_map);
    %     if ~isempty(frames_to_highlight_on_fig2)
    %         ...
    %     end
    % end

    % --- Determine which example_indices are plotted on Fig 2's DIC Near Failure Data ---
    highlight_points_strain_dic_near_fig2 = [];
    highlight_points_force_dic_near_fig2 = [];
    valid_sec2_original_frame_indices = find(valid_sec2); % Original frame numbers for data in F_plot_s2, sg3_plot_s2 etc.

    if ~isempty(valid_sec2_original_frame_indices) && ~isempty(example_indices) && ~isempty(dic_near_plot_s2)
        frames_to_highlight_dic_near_fig2 = intersect(example_indices, valid_sec2_original_frame_indices);

        if ~isempty(frames_to_highlight_dic_near_fig2)
            num_hl_dic_near = length(frames_to_highlight_dic_near_fig2);
            highlight_points_strain_dic_near_fig2 = zeros(num_hl_dic_near, 1);
            highlight_points_force_dic_near_fig2 = zeros(num_hl_dic_near, 1);
            actual_found_count_dic_near = 0;

            for i_hl = 1:num_hl_dic_near
                current_frame = frames_to_highlight_dic_near_fig2(i_hl);
                idx_in_valid_sec2_arrays = find(valid_sec2_original_frame_indices == current_frame, 1);
                if ~isempty(idx_in_valid_sec2_arrays) && idx_in_valid_sec2_arrays <= length(dic_near_plot_s2) % Ensure index is valid for plotted data
                    actual_found_count_dic_near = actual_found_count_dic_near + 1;
                    highlight_points_strain_dic_near_fig2(actual_found_count_dic_near) = dic_near_plot_s2(idx_in_valid_sec2_arrays);
                    highlight_points_force_dic_near_fig2(actual_found_count_dic_near) = F_plot_s2(idx_in_valid_sec2_arrays); % Use F_plot_s2 as Y-values
                end
            end
            highlight_points_strain_dic_near_fig2 = highlight_points_strain_dic_near_fig2(1:actual_found_count_dic_near);
            highlight_points_force_dic_near_fig2 = highlight_points_force_dic_near_fig2(1:actual_found_count_dic_near);
        end
    end
    % --- End Fig 2 DIC Near Highlight Prep ---

    figure; % Create Figure 2
    fig2_handle = gcf; % Get handle immediately after creation
    hold on; grid on; box on;
    
    % Plot the average strain gauge data from Part 1 (from which yield is determined) - REMOVED AS PER USER REQUEST
    % handle_avg_gauge_data_fig2 = [];
    % if ~isempty(F_common) && ~isempty(epsilon_gauge_avg_common)
    %     handle_avg_gauge_data_fig2 = plot(epsilon_gauge_avg_common, F_common, '-p', 'DisplayName', 'Avg Gauge Data (SG2&SG3, Part 1)', ...
    %          'Color', [0.5 0.5 1], 'MarkerSize', 4, 'LineWidth', 1); % Light blue
    % end

    plot(sg3_plot_s2, F_plot_s2, '-o', 'DisplayName', 'Strain Gauge 3 (Far)', ...
         'Color', 'b', 'MarkerSize', 4, 'LineWidth', 1.2);
    plot(dic_far_plot_s2, F_plot_s2, '-s', 'DisplayName', 'DIC Far from Failure (Avg)', ...
         'Color', 'r', 'MarkerSize', 4, 'LineWidth', 1.2);
    plot(dic_near_plot_s2, F_plot_s2, '-d', 'DisplayName', 'DIC Near Failure (Avg)', ...
         'Color', 'k', 'MarkerSize', 4, 'LineWidth', 1.2);

    % --- NEW: 0.2% Offset Yield Calculation for SG3 Data on Figure 2 ---
    F_yield_sg3_fig2 = NaN;
    intersect_strain_sg3_fig2 = NaN;
    epsilon_offset_line_sg3_fig2 = [];
    force_offset_line_sg3_fig2 = [];
    slope_force_strain_elastic_sg3_fig2 = NaN;

    % Define elastic range for SG3 in Figure 2 (sg3_plot_s2, F_plot_s2)
    start_fit_offset_sg3_fig2 = 1; % USER ADJUSTABLE: Points to skip from start of sg3_plot_s2
    num_points_for_fit_sg3_fig2 = 5; % USER ADJUSTABLE: Number of points for SG3 elastic fit on Fig 2

    if length(sg3_plot_s2) >= (start_fit_offset_sg3_fig2 + num_points_for_fit_sg3_fig2)
        elastic_indices_fig2_sg3 = (1+start_fit_offset_sg3_fig2) : min( (start_fit_offset_sg3_fig2 + num_points_for_fit_sg3_fig2) , length(sg3_plot_s2) );
        sg3_elastic_fig2 = sg3_plot_s2(elastic_indices_fig2_sg3);
        F_elastic_fig2_sg3 = F_plot_s2(elastic_indices_fig2_sg3);
        N_elastic_fig2_sg3 = length(sg3_elastic_fig2);

        if N_elastic_fig2_sg3 >= 2
            p_sg3_force_fig2 = polyfit(sg3_elastic_fig2, F_elastic_fig2_sg3, 1);
            slope_force_strain_elastic_sg3_fig2 = p_sg3_force_fig2(1);
        end
    else
        fprintf(1, 'Warning: Not enough points in sg3_plot_s2 for elastic fit for Fig 2 yield point.\n');
        N_elastic_fig2_sg3 = 0;
    end

    offset_param = 0.002; % 0.2%
    if ~isnan(slope_force_strain_elastic_sg3_fig2) && N_elastic_fig2_sg3 >=2
        relevant_indices_sg3 = find(sg3_plot_s2 >= offset_param);
        if length(relevant_indices_sg3) > 1
            strain_curve_segment_sg3 = sg3_plot_s2(relevant_indices_sg3);
            force_curve_segment_sg3 = F_plot_s2(relevant_indices_sg3);
            force_offset_at_curve_strains_sg3 = slope_force_strain_elastic_sg3_fig2 * (strain_curve_segment_sg3 - offset_param);
            difference_sg3 = force_curve_segment_sg3 - force_offset_at_curve_strains_sg3;
            sign_changes_sg3 = find(diff(sign(difference_sg3)));
            
            if ~isempty(sign_changes_sg3)
                idx1_sg3 = sign_changes_sg3(1);
                idx2_sg3 = idx1_sg3 + 1;        
                
                % Check if idx1_sg3 and idx2_sg3 are valid for difference_sg3 and strain_curve_segment_sg3
                if idx2_sg3 <= length(difference_sg3) && idx2_sg3 <= length(strain_curve_segment_sg3)
                    % Interpolate to find intersection strain
                    % Avoid issues if difference is exactly zero at one point by checking range
                    if difference_sg3(idx1_sg3) == 0
                        intersect_strain_sg3_fig2 = strain_curve_segment_sg3(idx1_sg3);
                    elseif difference_sg3(idx2_sg3) == 0
                        intersect_strain_sg3_fig2 = strain_curve_segment_sg3(idx2_sg3);
                    else
                         p_intersect_sg3 = polyfit(difference_sg3(idx1_sg3:idx2_sg3), strain_curve_segment_sg3(idx1_sg3:idx2_sg3), 1);
                         intersect_strain_sg3_fig2 = polyval(p_intersect_sg3, 0); % Strain where difference is zero
                    end
                    F_yield_sg3_fig2 = slope_force_strain_elastic_sg3_fig2 * (intersect_strain_sg3_fig2 - offset_param);
                else
                    fprintf(1, 'Warning: Index issue during SG3 yield intersection for Fig 2.\n');
                end
            else
                fprintf(1, 'Warning: 0.2%% offset line (SG3-based) does not intersect the SG3 curve for Fig 2.\n');
            end
        else
            fprintf(1, 'Warning: Not enough SG3 data points beyond 0.2%% strain for Fig 2 yield search.\n');
        end
        
        % Define offset line for plotting if yield point found
        if ~isnan(F_yield_sg3_fig2)
            max_strain_sg3_plot = max(sg3_plot_s2(sg3_plot_s2 < Inf)); % Avoid Inf if any
            min_strain_sg3_plot_positive = min(sg3_plot_s2(sg3_plot_s2 > 0 & sg3_plot_s2 < Inf));
            if isempty(min_strain_sg3_plot_positive), min_strain_sg3_plot_positive = 0; end

            epsilon_offset_line_sg3_fig2 = linspace(offset_param, max_strain_sg3_plot, 200);
            force_offset_line_sg3_fig2 = slope_force_strain_elastic_sg3_fig2 * (epsilon_offset_line_sg3_fig2 - offset_param);
            force_offset_line_sg3_fig2(force_offset_line_sg3_fig2 < 0 & epsilon_offset_line_sg3_fig2 < (offset_param + min_strain_sg3_plot_positive)) = NaN;
        end
    else
        fprintf(1, 'Warning: Cannot calculate 0.2%% offset line for SG3 on Fig 2 (slope or N_elastic invalid).\n');
    end
    % --- End SG3 Yield Calculation for Fig 2 ---

    % Plot 0.2% offset line and yield point if calculated (SG3 based)
    if ~isnan(F_yield_sg3_fig2) && ~isempty(epsilon_offset_line_sg3_fig2) && ~isempty(force_offset_line_sg3_fig2) && ~isnan(intersect_strain_sg3_fig2)
        plot(epsilon_offset_line_sg3_fig2, force_offset_line_sg3_fig2, 'g--', 'LineWidth', 1.2, 'DisplayName', '0.2\% Offset Line (SG3 Elastic Slope)');
        sigma_y_sg3_display_MPa = (F_yield_sg3_fig2 / A_m2) / 1e6;
        fy_val_str_fig2 = sprintf('$F_y = %.1f$ N', F_yield_sg3_fig2);
        sigmay_val_str_fig2 = sprintf('$\\sigma_y = %.1f$ MPa', sigma_y_sg3_display_MPa);
        display_name_yield_fig2 = ['Yield Point (SG3, ', fy_val_str_fig2, ', ', sigmay_val_str_fig2, ')'];
        plot(intersect_strain_sg3_fig2, F_yield_sg3_fig2, 'gx', 'MarkerSize', 10, 'LineWidth', 2, ...
             'DisplayName', display_name_yield_fig2);
    end

    % Plot highlighted example_indices for Figure 2 (on DIC Near Failure)
    if ~isempty(highlight_points_strain_dic_near_fig2) && ~isempty(highlight_points_force_dic_near_fig2)
        plot(highlight_points_strain_dic_near_fig2, highlight_points_force_dic_near_fig2, 'mp', ... 
            'MarkerFaceColor', 'm', 'MarkerSize', 10, 'DisplayName', 'Example Frames (on DIC Near Failure)');
    end

    % OLD Plot highlighted example_indices for Figure 2 (on Avg Gauge) - REMOVED
    % if ~isempty(highlight_points_strain_avg_gauge_fig2) && ~isempty(handle_avg_gauge_data_fig2) 
    %     plot(highlight_points_strain_avg_gauge_fig2, highlight_points_force_avg_gauge_fig2, 'cp', ... 
    %         'MarkerFaceColor', 'c', 'MarkerSize', 10, 'DisplayName', 'Example Frames (on Avg Gauge)');
    % elseif ~isempty(highlight_points_strain_avg_gauge_fig2)
    %     fprintf(1, 'Note: Example frames found for Fig 2 highlight, but avg gauge data was not plotted or handle_avg_gauge_data_fig2 is missing.\n');
    % end

    xlabel('Strain, $\varepsilon$','Interpreter','latex');
    ylabel('Force (N)','Interpreter','latex');
    title('Force vs. Strain (Full Experiment Range with Yield Point)','Interpreter','latex');
    legend('Location', 'northwest', 'Interpreter', 'latex');
    set(gca, 'FontSize', 14);
    ylim([0 22000]); % Cap Y-axis as requested

    % --- Create Inset Plot for Force Zoom (14kN-20kN) ---
    try
        ax_main_fig2 = gca; % Get handle to main axes of Figure 2
        inset_pos_fig2 = [0.58, 0.20, 0.35, 0.3]; % Bottom-right, slightly higher
        ax_inset_fig2 = axes(fig2_handle, 'Position', inset_pos_fig2);
        % set(ax_inset_fig2, 'Color', 'cyan'); % Removed cyan background
        fprintf(1, 'DEBUG: Inset axes created at position [%.2f %.2f %.2f %.2f].\n', inset_pos_fig2);
        hold(ax_inset_fig2, 'on');
        grid(ax_inset_fig2, 'on');
        box(ax_inset_fig2, 'on');

        force_zoom_min = 14000;
        force_zoom_max = 20000;
        all_strains_inset_fig2 = []; 
        any_data_plotted_in_inset = false;

        % --- Logic to determine tight X-limits for the inset --- 
        relevant_strains_for_xlim_calc = [];
        if exist('sg3_plot_s2', 'var') && exist('F_plot_s2', 'var') && ~isempty(sg3_plot_s2)
            idx = (F_plot_s2 >= force_zoom_min & F_plot_s2 <= force_zoom_max);
            if any(idx), relevant_strains_for_xlim_calc = [relevant_strains_for_xlim_calc; sg3_plot_s2(idx)]; end
        end
        if exist('dic_far_plot_s2', 'var') && exist('F_plot_s2', 'var') && ~isempty(dic_far_plot_s2)
            idx = (F_plot_s2 >= force_zoom_min & F_plot_s2 <= force_zoom_max);
            if any(idx), relevant_strains_for_xlim_calc = [relevant_strains_for_xlim_calc; dic_far_plot_s2(idx)]; end
        end
        if exist('dic_near_plot_s2', 'var') && exist('F_plot_s2', 'var') && ~isempty(dic_near_plot_s2)
            idx = (F_plot_s2 >= force_zoom_min & F_plot_s2 <= force_zoom_max);
            if any(idx), relevant_strains_for_xlim_calc = [relevant_strains_for_xlim_calc; dic_near_plot_s2(idx)]; end
        end
        if exist('epsilon_offset_line_sg3_fig2', 'var') && exist('force_offset_line_sg3_fig2', 'var') && ~isempty(epsilon_offset_line_sg3_fig2)
            idx = (force_offset_line_sg3_fig2 >= force_zoom_min & force_offset_line_sg3_fig2 <= force_zoom_max);
            if any(idx), relevant_strains_for_xlim_calc = [relevant_strains_for_xlim_calc; epsilon_offset_line_sg3_fig2(idx).']; end
        end
        if exist('F_yield_sg3_fig2', 'var') && exist('intersect_strain_sg3_fig2', 'var') && ~isnan(F_yield_sg3_fig2)
            if (F_yield_sg3_fig2 >= force_zoom_min && F_yield_sg3_fig2 <= force_zoom_max)
                relevant_strains_for_xlim_calc = [relevant_strains_for_xlim_calc; intersect_strain_sg3_fig2];
            end
        end
        if exist('highlight_points_strain_dic_near_fig2', 'var') && exist('highlight_points_force_dic_near_fig2', 'var') && ~isempty(highlight_points_strain_dic_near_fig2)
            idx = (highlight_points_force_dic_near_fig2 >= force_zoom_min & highlight_points_force_dic_near_fig2 <= force_zoom_max);
            if any(idx), relevant_strains_for_xlim_calc = [relevant_strains_for_xlim_calc; highlight_points_strain_dic_near_fig2(idx)]; end
        end
        % --- End X-limit data collection ---

        % 1. Strain Gauge 3 (Far) - Plot full series
        if exist('sg3_plot_s2', 'var') && exist('F_plot_s2', 'var') && ~isempty(sg3_plot_s2)
            plot(ax_inset_fig2, sg3_plot_s2, F_plot_s2, '-o', 'Color', 'b', 'MarkerSize', 3, 'LineWidth', 1);
            any_data_plotted_in_inset = true; % Assume if var exists, it's plotted
            fprintf(1, 'DEBUG: Plotted FULL SG3 data in inset.\n');
        end

        % 2. DIC Far from Failure (Avg) - Plot full series
        if exist('dic_far_plot_s2', 'var') && exist('F_plot_s2', 'var') && ~isempty(dic_far_plot_s2)
            plot(ax_inset_fig2, dic_far_plot_s2, F_plot_s2, '-s', 'Color', 'r', 'MarkerSize', 3, 'LineWidth', 1);
            any_data_plotted_in_inset = true;
            fprintf(1, 'DEBUG: Plotted FULL DIC Far data in inset.\n');
        end

        % 3. DIC Near Failure (Avg) - Plot full series
        if exist('dic_near_plot_s2', 'var') && exist('F_plot_s2', 'var') && ~isempty(dic_near_plot_s2)
            plot(ax_inset_fig2, dic_near_plot_s2, F_plot_s2, '-d', 'Color', 'k', 'MarkerSize', 3, 'LineWidth', 1);
            any_data_plotted_in_inset = true;
            fprintf(1, 'DEBUG: Plotted FULL DIC Near data in inset.\n');
        end

        % 4. 0.2% Offset Line (SG3 Elastic Slope) - Plot full series
        if exist('epsilon_offset_line_sg3_fig2', 'var') && exist('force_offset_line_sg3_fig2', 'var') && ~isempty(epsilon_offset_line_sg3_fig2)
            plot(ax_inset_fig2, epsilon_offset_line_sg3_fig2, force_offset_line_sg3_fig2, 'g--', 'LineWidth', 1);
            any_data_plotted_in_inset = true;
            fprintf(1, 'DEBUG: Plotted FULL Offset Line in inset.\n');
        end

        % 5. Yield Point (SG3) - Plot if exists
        if exist('F_yield_sg3_fig2', 'var') && exist('intersect_strain_sg3_fig2', 'var') && ~isnan(F_yield_sg3_fig2) && ~isnan(intersect_strain_sg3_fig2)
            plot(ax_inset_fig2, intersect_strain_sg3_fig2, F_yield_sg3_fig2, 'gx', 'MarkerSize', 8, 'LineWidth', 1.5);
            any_data_plotted_in_inset = true; % If it exists and is plotted
            fprintf(1, 'DEBUG: Plotted Yield Point in inset (if it exists).\n');
        end

        % 6. Example Frames (on DIC Near Failure) - Plot if exists
        if exist('highlight_points_strain_dic_near_fig2', 'var') && exist('highlight_points_force_dic_near_fig2', 'var') && ~isempty(highlight_points_strain_dic_near_fig2)
             plot(ax_inset_fig2, highlight_points_strain_dic_near_fig2, highlight_points_force_dic_near_fig2, 'mp', 'MarkerFaceColor', 'm', 'MarkerSize', 8);
             any_data_plotted_in_inset = true;
             fprintf(1, 'DEBUG: Plotted Example Frames in inset (if they exist).\n');
        end
        
        fprintf(1, 'DEBUG: any_data_plotted_in_inset flag is: %d\n', any_data_plotted_in_inset);
        fprintf(1, 'DEBUG: relevant_strains_for_xlim_calc is empty: %d\n', isempty(relevant_strains_for_xlim_calc));

        % Set Inset Limits
        ylim(ax_inset_fig2, [force_zoom_min force_zoom_max]);
        xlim(ax_inset_fig2, [0, 0.03]); % User-defined xlim for inset
        fprintf(1, 'DEBUG: Set inset xlim to [0, 0.03] as requested.\n');

        xlabel(ax_inset_fig2, 'Strain, $\varepsilon$','Interpreter','latex');
        ylabel(ax_inset_fig2, 'Force (N)');
        title(ax_inset_fig2, 'Zoom: 14kN - 20kN');
        set(ax_inset_fig2, 'FontSize', 10);

        uistack(ax_inset_fig2, 'top'); % Bring inset to the top
        hold(ax_inset_fig2, 'off');
        drawnow; % Force graphics update
        % axes(ax_main_fig2); % Switch back to main axes - COMMENTED OUT

    catch ME_inset_fig2
        fprintf(1, 'Warning: Could not create inset plot for Figure 2. Error: %s\n', ME_inset_fig2.message);
        if exist('ax_main_fig2', 'var') && ishandle(ax_main_fig2)
            axes(ax_main_fig2); % Ensure main axes are active if error occurred
        end
    end
    % --- End Inset Plot ---

    hold off;

    % % Save the second figure
    % try
    %     % fig2_handle should already be defined
    %     fig2_handle.Position = [100, 100, 1000, 800]; 
    %     fig2_filename = 'figure2_full_range_comparison.png';
    %     pause(0.5); % Short pause to allow graphics to fully render before saving
    %     print(fig2_handle, fig2_filename, '-dpng', '-r300'); 
    %     fprintf(1, 'Saved second figure as: %s\n', fullfile(pwd, fig2_filename));
    % catch ME_fig2
    %     fprintf(1, 'Warning: Could not save Figure 2. Error: %s\n', ME_fig2.message);
    % end
end

% %% --- Figure 3: Zoomed Low Strain Region --- (REMOVING ENTIRE SECTION)
% if sum(valid_sec2) < 2 % Check if there was enough data for Sec 2 plots
%     fprintf(1, 'Skipping Figure 3 (Zoomed Low Strain) as there was not enough data for Section 2 plots.\n');
% else
%     figure; 
%     hold on; grid on; box on;
%
%     strain_zoom_min = 0;
%     strain_zoom_max = 0.02; % Changed from 0.04 to 0.02
%     any_data_in_fig3 = false;
%     all_forces_in_zoom_strain_range = []; % To determine Y limits dynamically
%
%     % Data to plot on Figure 3 (already filtered by valid_sec2 in their creation):
%     % sg3_plot_s2, F_plot_s2 (for SG3)
%     % dic_far_plot_s2, F_plot_s2 (for DIC Far)
%     % dic_near_plot_s2, F_plot_s2 (for DIC Near)
%     % epsilon_offset_line_sg3_fig2, force_offset_line_sg3_fig2 (for Offset Line)
%     % intersect_strain_sg3_fig2, F_yield_sg3_fig2 (for Yield Point)
%     % highlight_points_strain_dic_near_fig2, highlight_points_force_dic_near_fig2 (for Example Frames)
%
%     % 1. Strain Gauge 3 (Far)
%     if exist('sg3_plot_s2', 'var') && exist('F_plot_s2', 'var') && ~isempty(sg3_plot_s2) && (length(sg3_plot_s2) == length(F_plot_s2))
%         idx_sg3_fig3 = (sg3_plot_s2 >= strain_zoom_min & sg3_plot_s2 <= strain_zoom_max);
%         if any(idx_sg3_fig3)
%             plot(sg3_plot_s2(idx_sg3_fig3), F_plot_s2(idx_sg3_fig3), '-o', 'Color', 'b', 'MarkerSize', 4, 'LineWidth', 1.2, 'DisplayName', 'Strain Gauge 3 (Far)');
%             any_data_in_fig3 = true;
%             all_forces_in_zoom_strain_range = [all_forces_in_zoom_strain_range; F_plot_s2(idx_sg3_fig3)];
%         end
%     end
%
%     % 2. DIC Far from Failure (Avg)
%     if exist('dic_far_plot_s2', 'var') && exist('F_plot_s2', 'var') && ~isempty(dic_far_plot_s2) && (length(dic_far_plot_s2) == length(F_plot_s2))
%         idx_dic_far_fig3 = (dic_far_plot_s2 >= strain_zoom_min & dic_far_plot_s2 <= strain_zoom_max);
%         if any(idx_dic_far_fig3)
%             plot(dic_far_plot_s2(idx_dic_far_fig3), F_plot_s2(idx_dic_far_fig3), '-s', 'Color', 'r', 'MarkerSize', 4, 'LineWidth', 1.2, 'DisplayName', 'DIC Far from Failure (Avg)');
%             any_data_in_fig3 = true;
%             all_forces_in_zoom_strain_range = [all_forces_in_zoom_strain_range; F_plot_s2(idx_dic_far_fig3)];
%         end
%     end
%
%     % 3. DIC Near Failure (Avg)
%     if exist('dic_near_plot_s2', 'var') && exist('F_plot_s2', 'var') && ~isempty(dic_near_plot_s2) && (length(dic_near_plot_s2) == length(F_plot_s2))
%         idx_dic_near_fig3 = (dic_near_plot_s2 >= strain_zoom_min & dic_near_plot_s2 <= strain_zoom_max);
%         if any(idx_dic_near_fig3)
%             plot(dic_near_plot_s2(idx_dic_near_fig3), F_plot_s2(idx_dic_near_fig3), '-d', 'Color', 'k', 'MarkerSize', 4, 'LineWidth', 1.2, 'DisplayName', 'DIC Near Failure (Avg)');
%             any_data_in_fig3 = true;
%             all_forces_in_zoom_strain_range = [all_forces_in_zoom_strain_range; F_plot_s2(idx_dic_near_fig3)];
%         end
%     end
%
%     % 4. 0.2% Offset Line (SG3 Elastic Slope)
%     if exist('epsilon_offset_line_sg3_fig2', 'var') && exist('force_offset_line_sg3_fig2', 'var') && ~isempty(epsilon_offset_line_sg3_fig2)
%         idx_offset_fig3 = (epsilon_offset_line_sg3_fig2 >= strain_zoom_min & epsilon_offset_line_sg3_fig2 <= strain_zoom_max);
%         if any(idx_offset_fig3)
%             plot(epsilon_offset_line_sg3_fig2(idx_offset_fig3), force_offset_line_sg3_fig2(idx_offset_fig3), 'g--', 'LineWidth', 1.2, 'DisplayName', '0.2% Offset Line (SG3 Elastic Slope)');
%             any_data_in_fig3 = true;
%             all_forces_in_zoom_strain_range = [all_forces_in_zoom_strain_range; force_offset_line_sg3_fig2(idx_offset_fig3).']; % Transpose to column vector
%         end
%     end
%
%     % 5. Yield Point (SG3)
%     if exist('F_yield_sg3_fig2', 'var') && exist('intersect_strain_sg3_fig2', 'var') && ~isnan(F_yield_sg3_fig2) && ~isnan(intersect_strain_sg3_fig2)
%         if (intersect_strain_sg3_fig2 >= strain_zoom_min && intersect_strain_sg3_fig2 <= strain_zoom_max)
%             sigma_y_sg3_display_MPa_fig3 = (F_yield_sg3_fig2 / A_m2) / 1e6; % This should use F_yield_sg3_fig2 for consistency in display
%             plot(intersect_strain_sg3_fig2, F_yield_sg3_fig2, 'gx', 'MarkerSize', 10, 'LineWidth', 2, 'DisplayName', sprintf('Yield Point (SG3, $F_y = %.1f$ N, $\sigma_y = %.1f$ MPa)', F_yield_sg3_fig2, sigma_y_sg3_display_MPa_fig3));
%             any_data_in_fig3 = true;
%             all_forces_in_zoom_strain_range = [all_forces_in_zoom_strain_range; F_yield_sg3_fig2]; % Scalar, remove (:)
%         end
%     end
%
%     % 6. Example Frames (on DIC Near Failure)
%     if exist('highlight_points_strain_dic_near_fig2', 'var') && exist('highlight_points_force_dic_near_fig2', 'var') && ~isempty(highlight_points_strain_dic_near_fig2)
%         idx_example_fig3 = (highlight_points_strain_dic_near_fig2 >= strain_zoom_min & highlight_points_strain_dic_near_fig2 <= strain_zoom_max);
%         
%         fprintf(1, '\n--- Fig 3 Example Frame Diagnostic ---\n');
%         fprintf(1, 'Strain zoom range: [%.4f, %.4f]\n', strain_zoom_min, strain_zoom_max);
%         valid_indices_for_highlight = find(idx_example_fig3);
%         if ~isempty(valid_indices_for_highlight)
%             fprintf(1, 'Example frame strains for DIC Near Failure data within Fig 3 zoom:\n');
%             % Need to map these back to original example_indices to show frame number
%             % highlight_points_strain_dic_near_fig2 are derived from example_indices filtered by valid_sec2_original_frame_indices
%             % First, get the original frame numbers that were used to create highlight_points_strain_dic_near_fig2
%             if exist('frames_to_highlight_dic_near_fig2','var') && ~isempty(frames_to_highlight_dic_near_fig2)
%                 original_frames_for_highlights = frames_to_highlight_dic_near_fig2; % These are the frame numbers for points in highlight_points_...
%                 plotted_frame_numbers_fig3 = original_frames_for_highlights(valid_indices_for_highlight);
%                 for k_diag = 1:length(plotted_frame_numbers_fig3)
%                     fprintf(1, '  Original Frame %d (DIC Near Strain: %.4f) will be plotted on Fig 3.\n', plotted_frame_numbers_fig3(k_diag), highlight_points_strain_dic_near_fig2(valid_indices_for_highlight(k_diag)));
%                 end
%             else
%                  fprintf(1, 'Variable frames_to_highlight_dic_near_fig2 not found, cannot map to original frame numbers easily here.\n');
%                  fprintf(1, 'Strains of highlight points within zoom: %s\n', mat2str(highlight_points_strain_dic_near_fig2(idx_example_fig3)', 4));
%             end
%         else
%             fprintf(1, 'No example frame DIC Near Failure strains fall within Fig 3 zoom range.\n');
%         end
%         fprintf(1, 'Full list of DIC Near Failure highlight strains (before Fig 3 zoom filter): %s\n', mat2str(highlight_points_strain_dic_near_fig2',4));
%         
%
%         if any(idx_example_fig3)
%             plot(highlight_points_strain_dic_near_fig2(idx_example_fig3), highlight_points_force_dic_near_fig2(idx_example_fig3), 'mp', 'MarkerFaceColor', 'm', 'MarkerSize', 10, 'DisplayName', 'Example Frames (on DIC Near Failure)');
%             any_data_in_fig3 = true;
%             all_forces_in_zoom_strain_range = [all_forces_in_zoom_strain_range; highlight_points_force_dic_near_fig2(idx_example_fig3)];
%         end
%     end
%
%     if ~any_data_in_fig3
%         fprintf(1, 'Figure 3 Info: No data points found within the strain (0-0.1) limits for the plot.\n');
%         text(mean([strain_zoom_min, strain_zoom_max]), 0, 'No data in this strain range', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 10, 'Color', 'red', 'Interpreter', 'none');
%     end
%
%     % Set X limits for Figure 3 with padding
%     xlim([strain_zoom_min - 0.005, strain_zoom_max + 0.005]);
%     
%     % Set Y limits for Figure 3 dynamically based on data in the strain range, with an upper cap
%     if ~isempty(all_forces_in_zoom_strain_range)
%         min_force_val = min(all_forces_in_zoom_strain_range(isfinite(all_forces_in_zoom_strain_range))); 
%         max_force_val = max(all_forces_in_zoom_strain_range(isfinite(all_forces_in_zoom_strain_range)));  
%
%         if isempty(min_force_val) || isempty(max_force_val) % Handle if all data was NaN/Inf
%             if any_data_in_fig3
%                 ylim([0 upper_force_cap_fig3]); % Fallback, upper_force_cap_fig3 is 22000
%             end
%         else
%             upper_force_cap_fig3 = 22000; % Defined earlier, reiterated here for clarity
%
%             padding_force_fig3 = (max_force_val - min_force_val) * 0.05; 
%             if padding_force_fig3 <= 0 || isnan(padding_force_fig3) 
%                 padding_force_fig3 = max(200, 0.05 * abs(max_force_val)); 
%                 if padding_force_fig3 == 0 && max_force_val == 0 % Max val is 0, 5% is 0
%                     padding_force_fig3 = 200; % Default padding
%                 elseif padding_force_fig3 == 0 && max_force_val ~=0 % max_force_val is non-zero but small
%                     padding_force_fig3 = 0.1*abs(max_force_val) + 10; % Ensure some small padding
%                 end
%             end
%             
%             final_ylim_min_fig3 = min_force_val - padding_force_fig3;
%             if final_ylim_min_fig3 < 0, final_ylim_min_fig3 = 0; end
%
%             tentative_ylim_max_fig3 = max_force_val + padding_force_fig3;
%             final_ylim_max_fig3 = min(tentative_ylim_max_fig3, upper_force_cap_fig3);
%
%             if final_ylim_min_fig3 >= final_ylim_max_fig3 % Ensure min is less than max
%                 final_ylim_min_fig3 = max(0, final_ylim_max_fig3 - padding_force_fig3*2); 
%                 if final_ylim_min_fig3 >= final_ylim_max_fig3 && final_ylim_max_fig3 == upper_force_cap_fig3
%                    final_ylim_min_fig3 = max(0, upper_force_cap_fig3 - 4000); % Show a decent range below cap
%                 end
%                 if final_ylim_min_fig3 >= final_ylim_max_fig3 % If still problematic
%                     final_ylim_min_fig3 = 0;
%                     if final_ylim_max_fig3 == 0, final_ylim_max_fig3 = upper_force_cap_fig3; end % Prevent 0,0 ylim if all data was 0
%                 end
%             end
%             ylim([final_ylim_min_fig3, final_ylim_max_fig3]);
%         end
%     else
%          if any_data_in_fig3 
%             ylim([0 upper_force_cap_fig3]); 
%          end 
%     end
%     
%     xlabel('Strain, epsilon','Interpreter','none');
%     ylabel('Force (N)','Interpreter','none');
%     title('Zoomed View: Strain 0-0.1','Interpreter','none'); % Removed force capping text
%     legend('Location','best','Interpreter','latex'); % Changed from none to latex
%     set(gca, 'FontSize', 12);
%     hold off;
%
%     % Save the third figure
%     try
%         fig3_handle = gcf; 
%         fig3_handle.Position = [100, 100, 1000, 800]; 
%         fig3_filename = 'figure3_zoom_low_strain.png';
%         print(fig3_handle, fig3_filename, '-dpng', '-r300'); 
%         fprintf(1, 'Saved third figure as: %s\n', fullfile(pwd, fig3_filename));
%     catch ME_fig3
%         fprintf(1, 'Warning: Could not save Figure 3. Error: %s\n', ME_fig3.message);
%     end
% end

fprintf(1, '\nAnalysis complete. Check plots and console output.\n');
fprintf('Remember to update USER ACTION sections if defaults are not appropriate.\n'); 