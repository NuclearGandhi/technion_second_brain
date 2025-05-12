clear;
close all;
clc;

%% --- User-defined Parameters ---
% Path to the DIC data .mat file
dic_data_file = 'C:\\Users\\Ido\\Documents\\lab-data\\advanced-lab\\strains-2\\notch\\dic_data.mat';
% Path to the text file containing force data
force_data_file = 'notch.txt'; % Assuming it's in the same directory or MATLAB path

% Y-coordinate (pixel) for the horizontal strain profile
y_profile_pixel = 270;

% Strain component to plot. Options typically include:
% 'plot_exx_ref_formatted' for E_xx (normal strain in X)
% 'plot_eyy_ref_formatted' for E_yy (normal strain in Y)
% 'plot_exy_ref_formatted' for E_xy (shear strain in XY)
% 'plot_e1_ref_formatted' for E_1 (principal strain 1)
% 'plot_e2_ref_formatted' for E_2 (principal strain 2)
strain_component_to_plot = 'plot_eyy_ref_formatted'; % Default to E_yy

% Frame number to analyze (e.g., 1 for first, or use 'last' for the last frame)
frame_to_analyze = 'last'; % Default to the last frame

fprintf('--- Notch Strain Profile Analysis ---\n');
fprintf('DIC Data File: %s\n', dic_data_file);
fprintf('Y-coordinate for profile: %d pixels\n', y_profile_pixel);
fprintf('Strain component: %s\n', strain_component_to_plot);

%% --- Load DIC Data ---
fprintf('Loading DIC data...\n');
try
    loaded_data = load(dic_data_file);
    if isfield(loaded_data, 'data_dic_save')
        data_dic_struct = loaded_data.data_dic_save;
        fprintf('Loaded data from "data_dic_save" structure.\n');
    elseif isfield(loaded_data, 'handles_ncorr') && isfield(loaded_data.handles_ncorr, 'data_dic')
        data_dic_struct = loaded_data.handles_ncorr.data_dic;
        fprintf('Loaded data from "handles_ncorr.data_dic" structure.\n');
    else
        error('Could not find expected DIC data variable (e.g., "data_dic_save" or "handles_ncorr.data_dic") in the .mat file.');
    end
catch ME
    fprintf('Error loading DIC data: %s\n', ME.message);
    fprintf('Please ensure the file exists and contains the expected DIC data structure.\n');
    return;
end

if ~isfield(data_dic_struct, 'strains') || isempty(data_dic_struct.strains)
    error('No strain data found in the loaded DIC structure (data_dic_struct.strains is missing or empty).');
end

num_frames = length(data_dic_struct.strains);
fprintf('Number of frames available: %d\n', num_frames);

if strcmpi(frame_to_analyze, 'last')
    frame_idx = num_frames;
else
    frame_idx = frame_to_analyze;
end

if frame_idx < 1 || frame_idx > num_frames
    error('Invalid frame_to_analyze. Must be between 1 and %d (or "last").', num_frames);
end
fprintf('Analyzing frame: %d\n', frame_idx);

%% --- Load Force Data ---
% --- Load force data from text file ---
load_at_frame_N = NaN; % Default to NaN
try
    fprintf('Loading force data from: %s\n', force_data_file);
    if exist(force_data_file, 'file')
        opts_force = detectImportOptions(force_data_file, 'FileType', 'text');
        % Assuming tab delimited and Load is the 4th column
        if length(opts_force.VariableNames) >= 4
            opts_force.SelectedVariableNames = opts_force.VariableNames{4}; % Select 4th column by name if possible
        else
            opts_force.SelectedVariableNames = 4; % Fallback to index if names are not as expected
        end
        opts_force.DataLines = [2, Inf]; % Skip header line
        force_table = readtable(force_data_file, opts_force);
        force_vector_N = table2array(force_table);

        if isempty(force_vector_N)
            fprintf('Warning: Force data file "%s" was loaded but resulted in an empty vector.\n', force_data_file);
        elseif frame_idx <= length(force_vector_N)
            load_at_frame_N = force_vector_N(frame_idx);
            fprintf('Load at frame %d: %.2f N\n', frame_idx, load_at_frame_N);
        else
            fprintf('Warning: Frame index %d exceeds available force data points (%d) in "%s".\n', frame_idx, length(force_vector_N), force_data_file);
        end
    else
        fprintf('Warning: Force data file "%s" not found.\n', force_data_file);
    end
catch ME_force
    fprintf('Warning: Could not load or process force data from "%s". Error: %s\n', force_data_file, ME_force.message);
end

%% --- Extract Strain Map and Profile ---
% Check if the selected strain component exists for the chosen frame
if ~isfield(data_dic_struct.strains(frame_idx), strain_component_to_plot)
    error('Strain component "%s" not found for frame %d. Check available fields in data_dic_struct.strains(%d).', strain_component_to_plot, frame_idx, frame_idx);
end

strain_map_2D = data_dic_struct.strains(frame_idx).(strain_component_to_plot);
if isempty(strain_map_2D)
    error('The strain map for "%s" in frame %d is empty.', strain_component_to_plot, frame_idx);
end
fprintf('Extracted 2D strain map of size: %d x %d\n', size(strain_map_2D,1), size(strain_map_2D,2));

% Validate y_profile_pixel
if y_profile_pixel < 1 || y_profile_pixel > size(strain_map_2D, 1)
    error('y_profile_pixel (%d) is out of bounds. Must be between 1 and %d.', y_profile_pixel, size(strain_map_2D, 1));
end

% Extract the 1D strain profile along the specified y-coordinate
strain_profile_1D_raw = strain_map_2D(y_profile_pixel, :);

%% --- Apply ROI Mask ---
roi_mask_1D = [];
if isfield(data_dic_struct.strains(frame_idx), 'roi_ref_formatted') && ...
        isprop(data_dic_struct.strains(frame_idx).roi_ref_formatted, 'mask') && ...
        ~isempty(data_dic_struct.strains(frame_idx).roi_ref_formatted.mask)

    roi_map_2D = data_dic_struct.strains(frame_idx).roi_ref_formatted.mask;
    if size(roi_map_2D, 1) == size(strain_map_2D, 1) && size(roi_map_2D, 2) == size(strain_map_2D, 2)
        roi_mask_1D = roi_map_2D(y_profile_pixel, :);
        strain_profile_1D_masked = strain_profile_1D_raw;
        strain_profile_1D_masked(~roi_mask_1D) = NaN; % Apply mask by setting non-ROI points to NaN
        fprintf('Applied ROI mask to the 1D strain profile.\n');
    else
        fprintf('Warning: ROI mask dimensions do not match strain map dimensions. Cannot apply ROI mask to profile.\n');
        strain_profile_1D_masked = strain_profile_1D_raw;
    end
else
    fprintf('Warning: ROI mask not found or is empty for frame %d. Using raw strain profile.\n', frame_idx);
    strain_profile_1D_masked = strain_profile_1D_raw;
end

%% --- Prepare X-coordinates ---
% Attempt to use physical coordinates if available
x_coords = 1:length(strain_profile_1D_masked); % Default to pixel indices
x_label_text = 'X-coordinate (pixels)';

if isfield(data_dic_struct.strains(frame_idx), 'plot_x_ref_formatted')
    x_map_2D = data_dic_struct.strains(frame_idx).plot_x_ref_formatted;
    if ~isempty(x_map_2D) && size(x_map_2D,1) == size(strain_map_2D,1) && size(x_map_2D,2) == size(strain_map_2D,2)
        x_coords_profile = x_map_2D(y_profile_pixel, :);
        % Check if these physical coordinates are uniform enough or if they also need masking
        if ~isempty(roi_mask_1D)
            x_coords = x_coords_profile(roi_mask_1D); % Use only X-coords within ROI for plotting against masked strain
            strain_values_to_plot = strain_profile_1D_masked(roi_mask_1D);
        else
            x_coords = x_coords_profile;
            strain_values_to_plot = strain_profile_1D_masked;
        end
        x_label_text = 'X-coordinate (physical units, e.g., mm)';
        fprintf('Using physical X-coordinates for the plot.\n');
    else
        fprintf('Warning: "plot_x_ref_formatted" found but dimensions mismatch or empty. Using pixel indices for X-axis.\n');
        if ~isempty(roi_mask_1D)
            x_coords = x_coords(roi_mask_1D);
            strain_values_to_plot = strain_profile_1D_masked(roi_mask_1D);
        else
            strain_values_to_plot = strain_profile_1D_masked;
        end
    end
else
    fprintf('Physical X-coordinates ("plot_x_ref_formatted") not found. Using pixel indices for X-axis.\n');
    if ~isempty(roi_mask_1D)
        x_coords = x_coords(roi_mask_1D);
        strain_values_to_plot = strain_profile_1D_masked(roi_mask_1D);
    else
        strain_values_to_plot = strain_profile_1D_masked;
    end
end

if isempty(x_coords) || isempty(strain_values_to_plot)
    fprintf('Warning: No data points remaining after masking for plotting. Check ROI and y_profile_pixel.\n');
    return;
end

%% --- Plot Strain Profile (Figure 1) ---
figure;

% --- Determine plot labels ---
strain_label_latex = '';
switch strain_component_to_plot
    case 'plot_exx_ref_formatted'
        strain_label_latex = '$\varepsilon_{xx}$';
    case 'plot_eyy_ref_formatted'
        strain_label_latex = '$\varepsilon_{yy}$';
    case 'plot_exy_ref_formatted'
        strain_label_latex = '$\varepsilon_{xy}$'; % or '\gamma_{xy}' if preferred
    case 'plot_e1_ref_formatted'
        strain_label_latex = '$\varepsilon_1$'; % Principal strain 1
    case 'plot_e2_ref_formatted'
        strain_label_latex = '$\varepsilon_2$'; % Principal strain 2
    otherwise
        strain_label_latex = strrep(strain_component_to_plot, '_ref_formatted', ''); % Fallback
end

% --- Generate plot ---
plot(x_coords, strain_values_to_plot, '-o', 'LineWidth', 1.5, 'MarkerSize', 4);
grid on;
box on;

% --- Configure Plot Details ---
legend('DIC measurements', 'Location', 'best', 'Interpreter', 'none');

if ~isnan(load_at_frame_N)
    title_str = sprintf('Strain Profile (%s) along Y = %d pixels (Load: %.1f N)', ...
        strain_label_latex, y_profile_pixel, load_at_frame_N);
else
    title_str = sprintf('Strain Profile (%s) along Y = %d pixels (Load N/A for frame %d)', ...
        strain_label_latex, y_profile_pixel, frame_idx);
end
title(title_str, 'Interpreter', 'latex');

xlabel(x_label_text, 'Interpreter', 'none'); % X-label might be 'pixels' or 'physical units'

ylabel_str = sprintf('Strain, %s', strain_label_latex);
ylabel(ylabel_str, 'Interpreter', 'latex');

set(gca, 'FontSize', 12);

% --- Export Figure 1 ---
try
    fig_handle = gcf; % Get current figure handle
    fig_handle.Position = [100, 100, 600, 400]; % [left, bottom, width, height] in pixels

    % Define filename based on parameters
    filename_str = sprintf('notch_profile_y%d_frame%d_%s.png', ...
        y_profile_pixel, ...
        frame_idx, ...
        strrep(strain_component_to_plot, '_ref_formatted', ''));

    print(fig_handle, filename_str, '-dpng', '-r300'); % Save as PNG with 300 DPI
    fprintf('Saved figure as: %s\n', fullfile(pwd, filename_str));
catch ME_export
    fprintf('Warning: Could not save figure. Error: %s\n', ME_export.message);
end

fprintf('Plot generated. Check the figure window.\n');

%% --- Plot Theoretical Stress (Figure 2) ---
% --- Define Parameters and Calculate ---
KI = 3; % Stress Intensity Factor

% Define r_values for the theoretical plot (e.g., from a small positive number to 10)
r_min_theoretical = 0.01; % Avoid r=0 for the formula
r_max_theoretical = 10;
num_points_theoretical = 200;
r_values = linspace(r_min_theoretical, r_max_theoretical, num_points_theoretical);
x_label_text_fig2 = '$r$ (arbitrary units)'; % Specific x-axis label for this plot

if isempty(r_values) % Should not be empty with linspace unless num_points is 0
    fprintf('Warning: r_values for theoretical stress are empty. Skipping Figure 2.\n');
else
    sigma_yy_theoretical = KI ./ sqrt(2 * pi * r_values);

    figure; % New figure for theoretical stress
% --- Configure Plot Details ---
    plot(r_values, sigma_yy_theoretical, 'r-', 'LineWidth', 1.5);
    grid on;
    box on;

    title_str_fig2 = sprintf('Theoretical Stress $\\sigma_{yy}$ (Mode I, $\\theta=0^{\\circ}, K_I=%.1f$)', KI);
    title(title_str_fig2, 'Interpreter', 'latex');

    xlabel(x_label_text_fig2, 'Interpreter', 'latex'); % Use the new x-axis label
    ylabel('Theoretical $\sigma_{yy}$ (arbitrary units)', 'Interpreter', 'latex');
    legend(sprintf('$\\sigma_{yy} = K_I / \\sqrt{2\\pi r}$'), 'Location', 'best', 'Interpreter', 'latex');
    set(gca, 'FontSize', 12);

    % --- Export Figure 2 ---
    try
        fig2_handle = gcf;
        fig2_handle.Position = [150, 150, 600, 400]; % Slightly offset from first figure position
        fig2_filename = sprintf('notch_theoretical_sigma_yy_KI%.1f.png', KI);
        print(fig2_handle, fig2_filename, '-dpng', '-r300');
        fprintf('Saved theoretical stress figure as: %s\n', fullfile(pwd, fig2_filename));
    catch ME_export_fig2
        fprintf('Warning: Could not save theoretical stress figure. Error: %s\n', ME_export_fig2.message);
    end
end

%% --- Log-Log Analysis: ln(Eyy) vs ln(r) (Figures 3 & 4) ---
% --- Check Prerequisites ---
if strcmp(strain_component_to_plot, 'plot_eyy_ref_formatted')
    fprintf('\n--- Generating Figure 3: Plot of log10(Eyy) vs log10(r) ---\n');
% --- Prepare Data for Log Plot ---
    if exist('strain_values_to_plot', 'var') && exist('x_coords', 'var') && ...
            ~isempty(strain_values_to_plot) && ~isempty(x_coords) && ...
            length(strain_values_to_plot) == length(x_coords)

        % --- Shift r data (x_coords) so its minimum is 0 for this plot ---
        min_r_original = 0;
        r_shifted = x_coords; % Default if x_coords is empty or all non-positive
        if ~isempty(x_coords)
            min_r_original = min(x_coords(x_coords > 0)); % Min of positive r values if any
            if isempty(min_r_original) % If all x_coords were <=0 or empty initially
                min_r_original = 0; % Avoid issues if x_coords was all non-positive
                fprintf('Warning: Original x_coords (r) had no positive values. Shift based on 0.\n');
                r_shifted = x_coords; % Keep as is, subsequent log will filter
            else
                r_shifted = x_coords - min_r_original;
                fprintf('DEBUG: For Figure 3, original r (x_coords) min positive value used for shift: %.4g. Data shifted for ln(r) plot.\n', min_r_original);
            end
        else
            fprintf('Warning: x_coords is empty, cannot perform shift effectively for Figure 3.\n');
        end

        % Filter for positive values for log plot (r_shifted > 0 and eyy > 0)
        valid_log_indices = (r_shifted > 0) & (strain_values_to_plot > 0);
        r_input_for_ln = r_shifted(valid_log_indices);
        eyy_input_for_ln = strain_values_to_plot(valid_log_indices);

        if isempty(r_input_for_ln) || isempty(eyy_input_for_ln)
            fprintf('Warning: No valid positive data points (r_shifted > 0 and eyy > 0) for ln-ln plot. Skipping Figure 3.\n');
        else
% --- Plot Full Log-Log Data (Figure 3) ---
            % Perform linear fit on natural log-transformed data
            ln_r_values = log(r_input_for_ln);
            ln_eyy_values = log(eyy_input_for_ln);

            % Remove any potential NaNs or Infs
            valid_fit_indices = ~isinf(ln_r_values) & ~isinf(ln_eyy_values) & ...
                ~isnan(ln_r_values) & ~isnan(ln_eyy_values);
            ln_r_clean = ln_r_values(valid_fit_indices);
            ln_eyy_clean = ln_eyy_values(valid_fit_indices);

            if length(ln_r_clean) >= 2 % Need at least 2 points for Figure 3 plot
                figure; % Figure 3: Plot of all valid ln(eyy) vs ln(r)
                plot(ln_r_clean, ln_eyy_clean, 'bo', 'MarkerSize', 6, 'DisplayName', 'Experimental Data ($\ln(\varepsilon_{yy})$ vs $\ln(r)$)');
                grid on;
                box on;

                title_str_fig3 = '$\ln(\varepsilon_{yy})$ vs. $\ln(r)$';
                title(title_str_fig3, 'Interpreter', 'latex');

                xlabel_str_fig3 = ['$\ln(r)$'];
                xlabel(xlabel_str_fig3, 'Interpreter', 'latex');
                ylabel('$\ln(\varepsilon_{yy})$', 'Interpreter', 'latex');
                legend('Location', 'best', 'Interpreter', 'latex');
                set(gca, 'FontSize', 12);

                fprintf('Figure 3 (ln(Eyy) vs ln(r)) plotted showing all valid data points.\n');

                % --- Export Figure 3 ---
                try
                    fig3_handle = gcf;
                    fig3_handle.Position = [200, 200, 600, 400];
                    fig3_filename = 'notch_ln_eyy_vs_ln_r_all_data.png'; % Updated filename
                    print(fig3_handle, fig3_filename, '-dpng', '-r300');
                    fprintf('Saved Figure 3 as: %s\n', fullfile(pwd, fig3_filename));
                catch ME_export_fig3
                    fprintf('Warning: Could not save Figure 3. Error: %s\n', ME_export_fig3.message);
                end

                % --- Fit Subset and Plot (Figure 4) ---
                fprintf('\n--- Preparing for Figure 4: Fit for ln(r-rmin) > 2.5 ---\n');
                filter_threshold_ln_r = 2.5;
                idx_fig4_fit = (ln_r_clean > filter_threshold_ln_r);

                ln_r_fig4_subset = ln_r_clean(idx_fig4_fit);
                ln_eyy_fig4_subset = ln_eyy_clean(idx_fig4_fit);
                num_points_fig4_fit = length(ln_r_fig4_subset);

                if num_points_fig4_fit >= 2
                    fprintf('Found %d data points where ln(r-rmin) > %.2f for Figure 4 fit.\n', num_points_fig4_fit, filter_threshold_ln_r);
                    figure; % New Figure 4
                    plot(ln_r_fig4_subset, ln_eyy_fig4_subset, 'gs', 'MarkerSize', 6, ...
                        'DisplayName', ['Exp. Data ($\ln(r) > ',num2str(filter_threshold_ln_r), '$)']);
                    hold on;
                    grid on;
                    box on;

                    p_fig4_fit = polyfit(ln_r_fig4_subset, ln_eyy_fig4_subset, 1);
                    slope_fig4 = p_fig4_fit(1);

                    ln_r_fit_line_fig4 = linspace(min(ln_r_fig4_subset), max(ln_r_fig4_subset), 100);
                    ln_eyy_fit_line_fig4 = polyval(p_fig4_fit, ln_r_fit_line_fig4);

                    plot(ln_r_fit_line_fig4, ln_eyy_fit_line_fig4, 'r--', 'LineWidth', 1.5, ...
                        'DisplayName', sprintf('Linear Fit (Slope = %.3f)', slope_fig4));
                    hold off;

                    title_str_fig4 = '$\ln(\varepsilon_{yy})$ vs. $\ln(r)$';
                    title(title_str_fig4, 'Interpreter', 'latex');
                    xlabel(xlabel_str_fig3, 'Interpreter', 'latex'); % Re-use x-label from Fig 3
                    ylabel('$\ln(\varepsilon_{yy})$', 'Interpreter', 'latex');
                    legend('Location', 'best', 'Interpreter', 'latex');
                    set(gca, 'FontSize', 12);

% --- Output Fit Results ---
                    fprintf('\n--- Figure 4 Analysis (Fit on $\ln(r) > %.1f$ Data) ---\n', filter_threshold_ln_r);
                    fprintf('Experimental slope from fit: %.4f\n', slope_fig4);
                    fprintf('Theoretical slope for original Eyy vs r^(-1/2) model is -0.5000.\n');

                    % --- Export Figure 4 ---
                    try
                        fig4_handle = gcf;
                        fig4_handle.Position = [250, 250, 600, 400];
                        fig4_filename = sprintf('notch_ln_fit_ln_r_gt_%.1f.png', filter_threshold_ln_r);
                        print(fig4_handle, fig4_filename, '-dpng', '-r300');
                        fprintf('Saved Figure 4 as: %s\n', fullfile(pwd, fig4_filename));
                    catch ME_export_fig4
                        fprintf('Warning: Could not save Figure 4. Error: %s\n', ME_export_fig4.message);
                    end
                else
                    fprintf('Warning: Not enough data points (need at least 2, found %d) where ln(r-rmin) > %.2f to create Figure 4 fit.\n', num_points_fig4_fit, filter_threshold_ln_r);
                end
            else
                fprintf('Warning: Not enough valid data points (after log and cleaning) for Figure 3. Figure 4 also skipped.\n');
            end
        end
    else
        fprintf('Warning: Prerequisite data (strain_values_to_plot or x_coords from Figure 1) not available or mismatched. Skipping Figure 3.\n');
    end
else
    fprintf('\n--- Skipping Figure 3: Plot of log10(Eyy) vs log10(r) ---\n');
    fprintf('This plot is only generated when "strain_component_to_plot" is set to "plot_eyy_ref_formatted".\n');
    fprintf('Current setting is: %s\n', strain_component_to_plot);
end

%% --- Analysis Complete ---
fprintf('--- Analysis Complete ---\n');
