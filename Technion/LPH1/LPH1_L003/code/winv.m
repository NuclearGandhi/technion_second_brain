clc; clear all; close all;

h1 = 25e-3; % m
h1_error = 0.1e-3; % m

h2 = 10e-3;
h2_error = 0.1e-3;

rate_1 = 1 / 100; % 1/s
rate_2 = 1 / 200; % 1/s

ell = 127e-3; % m
ell_error = 0.1e-3; % m

L = 1.26; % m
L_error = 1e-3; % m

g = 9.7949; % m/s^2
g_error = 0.0001; % m/s^2

files_data = {
    struct('name', 'meas_100_10.txt', 'desc', 'Rate 1 (100Hz), Height $h_2$ (10mm)', 'start_index', 161, 'end_index', 491), ...
    struct('name', 'meas_100_25.txt', 'desc', 'Rate 1 (100Hz), Height $h_1$ (25mm)', 'start_index', 111, 'end_index', 316), ...
    struct('name', 'meas_200_10.txt', 'desc', 'Rate 2 (200Hz), Height $h_2$ (10mm)', 'start_index', 314, 'end_index', 944), ...
    struct('name', 'meas_200_25.txt', 'desc', 'Rate 2 (200Hz), Height $h_1$ (25mm)', 'start_index', 208, 'end_index', 605)
};

mm_per_count = 127 / 241; % millimeters per count

% --- Phase 1: Data Pre-processing ---
fprintf("--- Phase 1: Data Pre-processing ---\n");
all_processed_data = cell(1, length(files_data));

for i = 1:length(files_data)
    current_file_info = files_data{i};
    filename = current_file_info.name;
    file_description = current_file_info.desc;
    original_start_idx_val = current_file_info.start_index; % Store for accel peak mapping
    original_end_idx_val = current_file_info.end_index;

    fprintf("Processing raw data for %s...\n", filename);

    processed_entry.file_description = file_description;
    processed_entry.original_start_idx_val = original_start_idx_val;
    processed_entry.filename = filename; % For error messages
    processed_entry.successful = false; % Default to not successful
    processed_entry.norm_time = [];
    processed_entry.pos_mm = [];

    time_col = [];
    count_col = [];

    try
        fid = fopen(filename, 'rt');
        if fid == -1
            warning('MATLAB:FileProcessing:CannotOpenFile', "Cannot open file: %s. Skipping this file.", filename);
            all_processed_data{i} = processed_entry;
            continue;
        end
        fgetl(fid); % Skip header
        raw_data = textscan(fid, '%f%f%f%f%f%f', 'Delimiter', '\t', 'EmptyValue', NaN);
        fclose(fid);

        if isempty(raw_data) || length(raw_data) < 4 || isempty(raw_data{2}) || isempty(raw_data{4})
            warning('MATLAB:FileProcessing:ReadError', "Could not read expected data columns from %s. Skipping.", filename);
            all_processed_data{i} = processed_entry;
            continue;
        end
        
        time_col = raw_data{2};  
        count_col = raw_data{4}; 
        
        valid_rows = ~isnan(time_col) & ~isnan(count_col);
        time_col = time_col(valid_rows);
        count_col = count_col(valid_rows);

        if isempty(time_col)
            warning('MATLAB:FileProcessing:NoValidData', "No valid data points in %s after parsing. Skipping.", filename);
            all_processed_data{i} = processed_entry;
            continue;
        end

    catch ME
        fprintf("Error during raw data processing for %s: %s. Skipping this file.\n", filename, ME.message);
        all_processed_data{i} = processed_entry;
        continue;
    end

    % Determine baseline count
    baseline_calc_end_idx = original_start_idx_val - 1;
    if baseline_calc_end_idx < 10 
        baseline_calc_end_idx = min(length(count_col), max(10, floor(length(count_col)*0.05))); 
    end
    if baseline_calc_end_idx == 0 && ~isempty(count_col); baseline_calc_end_idx = 1; end
    
    if isempty(count_col) || baseline_calc_end_idx < 1 || baseline_calc_end_idx > length(count_col)
        warning('MATLAB:FileProcessing:BaselineError', 'Could not determine baseline for %s. Using first count if available.', filename);
        if isempty(count_col)
            all_processed_data{i} = processed_entry; % Mark as failed
            continue;
        end
        baseline_count = count_col(1); 
    else
        baseline_count = median(count_col(1:baseline_calc_end_idx));
    end
    
    % Use predefined start and end indices (these are for the *original* non-NaN-filtered data)
    % We need to ensure these indices are valid for the *current* time_col/count_col
    % (which have had NaNs removed and might be shorter). This part is tricky.
    % For simplicity of refactor, assuming files_data indices are "sensible"
    % and apply to the NaN-cleaned data for now. This might need revisiting if lengths mismatch.
    
    % Let's re-evaluate start/end_idx based on full, NaN-cleaned data length
    % The files_data indices are 1-based for the original text file line numbers (after header)
    % Since textscan skips lines, we assume files_data indices effectively map to NaN-cleaned data.
    
    start_plot_idx = original_start_idx_val; 
    end_plot_idx = original_end_idx_val;

    % The user removed the previous validation for start_plot_idx/end_plot_idx against count_col length.
    % Adding a basic check here to prevent immediate out-of-bounds error.
    if start_plot_idx < 1 || end_plot_idx > length(count_col) || start_plot_idx > end_plot_idx || isempty(count_col)
         warning('MATLAB:FileProcessing:InvalidIndices', 'Original start/end indices from files_data are invalid for the loaded data of %s. Skipping file.', filename);
         all_processed_data{i} = processed_entry;
         continue;
    end

    current_truncated_time_segment = time_col(start_plot_idx:end_plot_idx);
    current_truncated_count_segment = count_col(start_plot_idx:end_plot_idx);

    if isempty(current_truncated_time_segment)
        warning('MATLAB:FileProcessing:EmptySegment', "Segment is empty after truncation for %s. Skipping.", filename);
        all_processed_data{i} = processed_entry;
        continue;
    end
    
    % Normalize truncated_time to start from t=0
    time_offset = current_truncated_time_segment(1);
    norm_time = current_truncated_time_segment - time_offset;
    
    pos_mm = (baseline_count - current_truncated_count_segment) * mm_per_count;

    processed_entry.norm_time = norm_time;
    processed_entry.pos_mm = pos_mm;
    processed_entry.successful = true;
    all_processed_data{i} = processed_entry;
    fprintf("Successfully pre-processed %s.\n", filename);
end
fprintf("--- End Phase 1 ---\n\n");

% --- Phase 2: Generate Figure 1 (All Position Plots) ---
fprintf("--- Phase 2: Generating Figure 1 (Position Plots) ---\n");
figure_handle = figure; 
set(figure_handle, 'Name', 'Kruza Gate Measurements: Position vs. Time', 'NumberTitle', 'off', 'Position', [100, 100, 900, 600]);
hold on;

plotted_anything_fig1 = false;
for i = 1:length(all_processed_data)
    data = all_processed_data{i};
    if data.successful
        % Assign colors based on height and rate
        if contains(data.file_description, "$h_1$")
            if contains(data.file_description, "(100Hz)")
                plot_color = [0 0.4470 0.7410]; % blue
            else
                plot_color = [0.3 0.7 1]; % light blue
            end
        elseif contains(data.file_description, "$h_2$")
            if contains(data.file_description, "(100Hz)")
                plot_color = [0.8500 0.3250 0.0980]; % red
            else
                plot_color = [1 0.6 0.2]; % orange
            end
        else
            plot_color = 'black';
        end
        % All lines: solid with markers
        plot(data.norm_time, data.pos_mm, 'Marker', '*', 'LineStyle', 'none', 'DisplayName', data.file_description, 'Color', plot_color);
        plotted_anything_fig1 = true;
    else
        fprintf("Skipping plot for %s in Figure 1 due to pre-processing errors.\n", data.filename);
    end
end

hold off; 
if plotted_anything_fig1
    ax_main = gca;
    title(ax_main, 'Kruza Gate: Position vs. Time (All Measurements)');
    xlabel(ax_main, 'Time (s) from segment start');
    ylabel(ax_main, 'Position (mm)');
    grid(ax_main, 'on');
    
    % Add padding to axes
    current_xlim = xlim(ax_main);
    current_ylim = ylim(ax_main);
    x_range = current_xlim(2) - current_xlim(1);
    y_range = current_ylim(2) - current_ylim(1);
    x_padding = 0.05 * x_range;
    y_padding = 0.05 * y_range;
    if x_range == 0; x_padding = 0.1; end % Handle case with single x-point if it ever occurs
    if y_range == 0; y_padding = 0.1; end % Handle case with single y-point
    xlim(ax_main, [current_xlim(1) - x_padding, current_xlim(2) + x_padding]);
    ylim(ax_main, [current_ylim(1) - y_padding, current_ylim(2) + y_padding]);
    
    legend(ax_main, 'show', 'Location', 'best', 'Interpreter', 'latex');
else
    title('Figure 1: No data successfully processed to plot.');
end

figure(figure_handle); 
drawnow expose; 

try
    exportgraphics(figure_handle, 'position_vs_time_all_measurements.png');
    fprintf("Exported main position figure to position_vs_time_all_measurements.png\n");
catch ME_export_main
    fprintf("Error exporting main position figure: %s\n", ME_export_main.message);
end
fprintf("--- End Phase 2 ---\n\n");


% --- Phase 3: Generate Figure 2 (Velocity Plots for Specific Measurement) ---
fprintf("--- Phase 3: Generating Figure 2 (Velocity Plots) ---\n");
target_desc_fig2 = 'Rate 1 (100Hz), Height $h_1$ (25mm)';
data_for_velocity = [];
for i = 1:length(all_processed_data)
    if strcmp(all_processed_data{i}.file_description, target_desc_fig2) && all_processed_data{i}.successful
        data_for_velocity = all_processed_data{i};
        break;
    end
end

if ~isempty(data_for_velocity)
    velocity_mm_s_n1 = []; velocity_time_n1 = [];
    velocity_mm_s_n5 = []; velocity_time_n5 = [];
    velocity_mm_s_n20 = []; velocity_time_n20 = [];

    pos_data_vel = data_for_velocity.pos_mm;
    time_data_vel = data_for_velocity.norm_time;

    % n=1 Central Difference
    if length(pos_data_vel) >= 3
        temp_vel_n1 = NaN(length(pos_data_vel) - 2, 1);
        temp_time_n1 = NaN(length(pos_data_vel) - 2, 1);
        for k = 1:(length(pos_data_vel) - 2)
            idx_center = k + 1;
            if (time_data_vel(idx_center + 1) - time_data_vel(idx_center - 1)) ~= 0
                temp_vel_n1(k) = (pos_data_vel(idx_center + 1) - pos_data_vel(idx_center - 1)) / (time_data_vel(idx_center + 1) - time_data_vel(idx_center - 1));
            else; temp_vel_n1(k) = NaN; end
            temp_time_n1(k) = time_data_vel(idx_center);
        end
        velocity_mm_s_n1 = temp_vel_n1; velocity_time_n1 = temp_time_n1;
    end

    % n=5 Central Difference
    n_val_5 = 5;
    if length(pos_data_vel) >= (2*n_val_5 + 1)
        temp_vel_n5 = NaN(length(pos_data_vel) - 2*n_val_5, 1);
        temp_time_n5 = NaN(length(pos_data_vel) - 2*n_val_5, 1);
        for k = 1:(length(pos_data_vel) - 2*n_val_5)
            idx_center = k + n_val_5;
            if (time_data_vel(idx_center + n_val_5) - time_data_vel(idx_center - n_val_5)) ~= 0
                temp_vel_n5(k) = (pos_data_vel(idx_center + n_val_5) - pos_data_vel(idx_center - n_val_5)) / (time_data_vel(idx_center + n_val_5) - time_data_vel(idx_center - n_val_5));
            else; temp_vel_n5(k) = NaN; end
            temp_time_n5(k) = time_data_vel(idx_center);
        end
        velocity_mm_s_n5 = temp_vel_n5; velocity_time_n5 = temp_time_n5;
    end

    % n=20 Central Difference
    n_val_20 = 20;
    if length(pos_data_vel) >= (2*n_val_20 + 1)
        temp_vel_n20 = NaN(length(pos_data_vel) - 2*n_val_20, 1);
        temp_time_n20 = NaN(length(pos_data_vel) - 2*n_val_20, 1);
        for k = 1:(length(pos_data_vel) - 2*n_val_20)
            idx_center = k + n_val_20;
            if (time_data_vel(idx_center + n_val_20) - time_data_vel(idx_center - n_val_20)) ~= 0
                temp_vel_n20(k) = (pos_data_vel(idx_center + n_val_20) - pos_data_vel(idx_center - n_val_20)) / (time_data_vel(idx_center + n_val_20) - time_data_vel(idx_center - n_val_20));
            else; temp_vel_n20(k) = NaN; end
            temp_time_n20(k) = time_data_vel(idx_center);
        end
        velocity_mm_s_n20 = temp_vel_n20; velocity_time_n20 = temp_time_n20;
    end

    if ~isempty(velocity_time_n1) || ~isempty(velocity_time_n5) || ~isempty(velocity_time_n20)
        velocity_figure_handle = figure; 
        set(velocity_figure_handle, 'Position', [200, 200, 800, 600]); 
        hold on;

        if ~isempty(velocity_time_n1); plot(velocity_time_n1, velocity_mm_s_n1, '*', 'DisplayName', 'n=1'); end
        if ~isempty(velocity_time_n5); plot(velocity_time_n5, velocity_mm_s_n5, '*', 'DisplayName', 'n=5'); end
        if ~isempty(velocity_time_n20)
            plot(velocity_time_n20, velocity_mm_s_n20, '*', 'DisplayName', 'n=20');
            % Linear regression for n=20
            if length(velocity_time_n20) >= 2
                [p_vel, S_vel] = polyfit(velocity_time_n20, velocity_mm_s_n20, 1);
                v_fit = polyval(p_vel, velocity_time_n20);
                plot(velocity_time_n20, v_fit, 'k--', 'LineWidth', 1.5, 'DisplayName', 'n=20 fit');
                
                % Calculate R^2
                SS_res = sum((velocity_mm_s_n20 - v_fit).^2);
                SS_tot = sum((velocity_mm_s_n20 - mean(velocity_mm_s_n20)).^2);
                R2 = 1 - SS_res/SS_tot;
                
                % Calculate error in slope (acceleration)
                % Covariance matrix: inv(S.R'*S.R) * S.normr^2 / S.df
                % Standard error of slope p(1) is sqrt(cov_matrix(1,1))
                cov_matrix_vel = inv(S_vel.R'*S_vel.R) * S_vel.normr^2 / S_vel.df;
                error_p1_vel_mm_s2 = sqrt(cov_matrix_vel(1,1));
                a_v_SI = p_vel(1) / 1000; % m/s^2
                a_v_error_SI = error_p1_vel_mm_s2 / 1000; % m/s^2
                b_v_mm_s = p_vel(2);

                fprintf('n=20 linear regression: v = (%.5f +/- %.5f) t + %.5f (mm/s units for v, t in s)\n', p_vel(1), error_p1_vel_mm_s2, b_v_mm_s);
                fprintf('  Slope (a_v) = (%.5f +/- %.5f) m/s^2, R^2 = %.5f\n', a_v_SI, a_v_error_SI, R2);
            end
        end
        
        hold off;
        title(sprintf('Momentary Velocity (Central Diff. n=1,5,20) for %s', data_for_velocity.file_description), 'Interpreter', 'latex');
        xlabel('Time (s) from segment start');
        ylabel('Velocity (mm/s)');
        grid on; 
        % Add padding to axes
        ax_vel = gca;
        current_xlim_vel = xlim(ax_vel);
        current_ylim_vel = ylim(ax_vel);
        x_range_vel = current_xlim_vel(2) - current_xlim_vel(1);
        y_range_vel = current_ylim_vel(2) - current_ylim_vel(1);
        x_padding_vel = 0.01 * x_range_vel;
        y_padding_vel = 0.01 * y_range_vel;
        if x_range_vel == 0; x_padding_vel = 0.1; end
        if y_range_vel == 0; y_padding_vel = 0.1; end
        xlim(ax_vel, [current_xlim_vel(1) - x_padding_vel, current_xlim_vel(2) + x_padding_vel]);
        ylim(ax_vel, [current_ylim_vel(1) - y_padding_vel, current_ylim_vel(2) + y_padding_vel]);
        
        legend(gca, 'show', 'Location', 'best');
        
        figure(velocity_figure_handle); 
        drawnow expose; 

        try
            exportgraphics(velocity_figure_handle, 'velocity_100Hz_h1_25mm_n1_5_20.png');
            fprintf("Exported velocity figure to velocity_100Hz_h1_25mm_n1_5_20.png\n");
        catch ME_export_velocity
            fprintf("Error exporting velocity figure: %s\n", ME_export_velocity.message);
        end
    else
        fprintf('Warning: Not enough data points in %s to calculate any velocity.\n', data_for_velocity.filename);
    end
else
    fprintf("Warning: Target data for velocity plot ('%s') not successfully processed or not found.\n", target_desc_fig2);
end
fprintf("--- End Phase 3 ---\n\n");


% --- Phase 3.5: Acceleration Figure for 100Hz h_1 (Central Difference, n=20) ---
fprintf("--- Phase 3.5: Generating Acceleration Figure (Central Difference, n=20) ---\n");
target_desc_accel_fig = 'Rate 1 (100Hz), Height $h_1$ (25mm)';
data_for_accel_fig = [];
for i = 1:length(all_processed_data)
    if strcmp(all_processed_data{i}.file_description, target_desc_accel_fig) && all_processed_data{i}.successful
        data_for_accel_fig = all_processed_data{i};
        break;
    end
end

if ~isempty(data_for_accel_fig)
    pos_data_acc = data_for_accel_fig.pos_mm / 1000; % Convert mm to m
    time_data_acc = data_for_accel_fig.norm_time; % seconds
    n_acc = 20;
    N = length(pos_data_acc);
    if N >= 2*n_acc+1
        % Use uniform time step for denominator
        delta_t = mean(diff(time_data_acc));
        acc_vals = NaN(N - 2*n_acc, 1);
        acc_times = NaN(N - 2*n_acc, 1);
        for k = (n_acc+1):(N-n_acc)
            acc_vals(k-n_acc) = (pos_data_acc(k+n_acc) - 2*pos_data_acc(k) + pos_data_acc(k-n_acc)) / ((n_acc * delta_t)^2);
            acc_times(k-n_acc) = time_data_acc(k);
        end
        % Mark stagnation point (original index 216)
        stagnation_idx_original = 216;
        stagnation_idx_proc = stagnation_idx_original - data_for_accel_fig.original_start_idx_val + 1;
        % Find the closest time in acc_times to the stagnation point
        stagnation_acc_idx = find(abs(acc_times - time_data_acc(stagnation_idx_proc)) == min(abs(acc_times - time_data_acc(stagnation_idx_proc))), 1, 'first');
        % Fit acceleration to a constant (mean)
        acc_fit_val = mean(acc_vals(~isnan(acc_vals)));
        % Calculate Standard Error of the Mean for acc_fit_val
        valid_acc_vals = acc_vals(~isnan(acc_vals));
        if length(valid_acc_vals) > 1
            a_cd_error_SI = std(valid_acc_vals) / sqrt(length(valid_acc_vals));
        else
            a_cd_error_SI = NaN; % Cannot compute SEM with 0 or 1 point
        end

        % Plot
        acc_fig = figure;
        set(acc_fig, 'Position', [300, 300, 600, 400]);
        plot(acc_times, acc_vals, '*', 'DisplayName', 'Central Diff. n=20'); hold on;
        plot(acc_times, acc_fit_val*ones(size(acc_times)), 'k--', 'LineWidth', 1.5, 'DisplayName', 'Fit (mean)');
        if ~isempty(stagnation_acc_idx)
            plot(acc_times(stagnation_acc_idx), acc_vals(stagnation_acc_idx), 'ro', 'MarkerSize', 10, 'LineWidth', 2, 'DisplayName', 'Stagnation Point');
        end
        hold off;
        title('Acceleration (Central Difference, n=20) for 100Hz $h_1$', 'Interpreter', 'latex');
        xlabel('Time (s)');
        ylabel('Acceleration (m/s^{2})', 'Interpreter', 'tex', 'FontName', 'SanSerif');
        legend('show', 'Location', 'best');
        grid on;
        % Add padding to axes
        ax_acc_cd = gca;
        current_xlim_acc_cd = xlim(ax_acc_cd);
        current_ylim_acc_cd = ylim(ax_acc_cd);
        x_range_acc_cd = current_xlim_acc_cd(2) - current_xlim_acc_cd(1);
        y_range_acc_cd = current_ylim_acc_cd(2) - current_ylim_acc_cd(1);
        x_padding_acc_cd = 0.05 * x_range_acc_cd;
        y_padding_acc_cd = 0.05 * y_range_acc_cd;
        if x_range_acc_cd == 0; x_padding_acc_cd = 0.1; end
        if y_range_acc_cd == 0; y_padding_acc_cd = 0.1; end
        xlim(ax_acc_cd, [current_xlim_acc_cd(1) - x_padding_acc_cd, current_xlim_acc_cd(2) + x_padding_acc_cd]);
        ylim(ax_acc_cd, [current_ylim_acc_cd(1) - y_padding_acc_cd, current_ylim_acc_cd(2) + y_padding_acc_cd]);
        
        drawnow expose;
        try
            exportgraphics(acc_fig, 'acceleration_100Hz_h1_n20.png');
            fprintf('Exported acceleration figure to acceleration_100Hz_h1_n20.png\n');
        catch ME_acc
            fprintf('Error exporting acceleration figure: %s\n', ME_acc.message);
        end
        fprintf('Acceleration (central diff, n=20) mean fit (a_cd): (%.5f +/- %.5f) m/s^2\n', acc_fit_val, a_cd_error_SI);
    else
        fprintf('Not enough data points for central difference acceleration with n=20.\n');
    end
else
    fprintf('Target data for acceleration figure (central diff, n=20) not found or not processed.\n');
end
fprintf("--- End Phase 3.5 ---\n\n");

% --- Phase 4: Acceleration Calculation ---
fprintf("--- Phase 4: Acceleration Calculation for Specific File ---\n");
target_desc_accel = 'Rate 1 (100Hz), Height $h_1$ (25mm)'; % Same target as velocity for this example
data_for_accel = [];
for i = 1:length(all_processed_data)
    if strcmp(all_processed_data{i}.file_description, target_desc_accel) && all_processed_data{i}.successful
        data_for_accel = all_processed_data{i};
        break;
    end
end

if ~isempty(data_for_accel)
    fprintf('--- Acceleration Calculation for %s ---\n', data_for_accel.file_description);
    
    % --- Calculate Theoretical Acceleration for h1 and its error ---
    % Ensure h1, L, g, h1_error, L_error are available (defined globally)
    a_theo_h1 = -g * (h1 / L);
    % Error propagation: delta_a_theo = |a_theo| * sqrt((delta_h1/h1)^2 + (delta_L/L)^2)
    % Assuming g has negligible error for this calculation relative to h1 and L
    if h1 ~= 0 && L ~= 0 % Avoid division by zero if h1 or L is zero
        delta_a_theo_h1 = abs(a_theo_h1) * sqrt((h1_error/h1)^2 + (L_error/L)^2);
    else
        delta_a_theo_h1 = NaN;
    end
    fprintf('Theoretical acceleration for h1 (a_theo_h1): (%.5f +/- %.5f) m/s^2\n', a_theo_h1, delta_a_theo_h1);
    % --- End Theoretical Acceleration for h1 ---

    peak_original_idx = 216; % As specified by user for meas_100_25.txt (Rate 1 (100Hz), Height $h_1$ (25mm))
    
    % The time and position data are already normalized (time starts at 0 for the segment)
    accel_pos_mm = data_for_accel.pos_mm;
    accel_norm_time = data_for_accel.norm_time;
    
    % Map peak_original_idx to index within the current *processed and truncated* segment
    % original_start_idx_val was the start_index from files_data used for truncation
    peak_idx_in_segment = peak_original_idx - data_for_accel.original_start_idx_val + 1;

    if peak_idx_in_segment > 0 && peak_idx_in_segment <= length(accel_pos_mm)
        % RISING SEGMENT
        if peak_idx_in_segment >= 3 
            x_rising = accel_pos_mm(1:peak_idx_in_segment);
            t_rising_segment_processed = accel_norm_time(1:peak_idx_in_segment);
            
            % Time for this fit should start from 0 for this specific (rising) segment
            t_fit_rising = t_rising_segment_processed - t_rising_segment_processed(1);
            
            % Full quadratic fit: x = a*t^2 + b*t + c
            [coeffs_rising, S_rise] = polyfit(t_fit_rising, x_rising, 2);
            % Convert coefficients to SI units
            a_r_coeff_SI = coeffs_rising(1) / 1000; % mm/s^2 to m/s^2
            b_r_coeff_SI = coeffs_rising(2) / 1000; % mm/s to m/s
            c_r_coeff_SI = coeffs_rising(3) / 1000; % mm to m
            acc_rise_SI = 2 * a_r_coeff_SI; % m/s^2

            % Calculate error for acc_rise_SI
            % Error for a_r_coeff_SI from S_rise
            cov_matrix_rise = inv(S_rise.R'*S_rise.R) * S_rise.normr^2 / S_rise.df;
            error_a_r_coeff_mm_s2 = sqrt(cov_matrix_rise(1,1));
            error_a_r_coeff_SI = error_a_r_coeff_mm_s2 / 1000; % m/s^2
            acc_rise_error_SI = 2 * error_a_r_coeff_SI; % Error for 2*a

            fprintf('Rising segment: Fitted x = (%.5f) t^2 + (%.5f) t + (%.5f)   [all SI units: m, s]\n', a_r_coeff_SI, b_r_coeff_SI, c_r_coeff_SI);
            fprintf('  Coeff a_r = (%.5f +/- %.5f) m/s^2, b_r = %.5f m/s, c_r = %.5f m\n', a_r_coeff_SI, error_a_r_coeff_SI, b_r_coeff_SI, c_r_coeff_SI);
            fprintf('  Acceleration (rising, a_rise) = (%.5f +/- %.5f) m/s^2\n', acc_rise_SI, acc_rise_error_SI);
            % Plot data and fit for rising segment
            t_smooth = linspace(min(t_fit_rising), max(t_fit_rising), 200);
            x_fit_smooth = polyval(coeffs_rising, t_smooth);
            rising_fig = figure;
            set(rising_fig, 'Position', [200, 200, 600, 400]);
            plot(t_fit_rising, x_rising, '*', 'DisplayName', 'Data'); hold on;
            plot(t_smooth, x_fit_smooth, 'k--', 'LineWidth', 1.5, 'DisplayName', 'Fit'); hold off;
            title('Rising Segment: Data and Quadratic Fit');
            xlabel('Time (s) to peak');
            ylabel('Position (mm)');
            legend('show', 'Location', 'best');
            grid on;
            % Add padding to axes
            ax_rise = gca;
            current_xlim_rise = xlim(ax_rise);
            current_ylim_rise = ylim(ax_rise);
            x_range_rise = current_xlim_rise(2) - current_xlim_rise(1);
            y_range_rise = current_ylim_rise(2) - current_ylim_rise(1);
            x_padding_rise = 0.05 * x_range_rise;
            y_padding_rise = 0.05 * y_range_rise;
            if x_range_rise == 0; x_padding_rise = 0.1; end
            if y_range_rise == 0; y_padding_rise = 0.1; end
            xlim(ax_rise, [current_xlim_rise(1) - x_padding_rise, current_xlim_rise(2) + x_padding_rise]);
            ylim(ax_rise, [current_ylim_rise(1) - y_padding_rise, current_ylim_rise(2) + y_padding_rise]);
            
            drawnow expose;
            try
                exportgraphics(rising_fig, 'rising_fit.png');
                fprintf('Exported rising segment fit figure to rising_fit.png\n');
            catch ME_rising
                fprintf('Error exporting rising segment fit figure: %s\n', ME_rising.message);
            end
        else
            fprintf('  Rising segment: Not enough data points to fit (needs at least 3).\n');
        end

        % FALLING SEGMENT
        if (length(accel_pos_mm) - peak_idx_in_segment + 1) >= 3
            x_falling = accel_pos_mm(peak_idx_in_segment:end);
            t_falling_segment_processed = accel_norm_time(peak_idx_in_segment:end);
            
            % Time for this fit should start from 0 for this specific (falling) segment (i.e., from the peak)
            t_fit_falling = t_falling_segment_processed - t_falling_segment_processed(1);

            % Full quadratic fit: x = a*t^2 + b*t + c
            [coeffs_falling, S_fall] = polyfit(t_fit_falling, x_falling, 2);
            % Convert coefficients to SI units
            a_f_coeff_SI = coeffs_falling(1) / 1000; % mm/s^2 to m/s^2
            b_f_coeff_SI = coeffs_falling(2) / 1000; % mm/s to m/s
            c_f_coeff_SI = coeffs_falling(3) / 1000; % mm to m
            acc_fall_SI = 2 * a_f_coeff_SI; % m/s^2

            % Calculate error for acc_fall_SI
            cov_matrix_fall = inv(S_fall.R'*S_fall.R) * S_fall.normr^2 / S_fall.df;
            error_a_f_coeff_mm_s2 = sqrt(cov_matrix_fall(1,1));
            error_a_f_coeff_SI = error_a_f_coeff_mm_s2 / 1000; % m/s^2
            acc_fall_error_SI = 2 * error_a_f_coeff_SI; % Error for 2*a

            fprintf('Falling segment: Fitted x = (%.5f) t^2 + (%.5f) t + (%.5f)   [all SI units: m, s]\n', a_f_coeff_SI, b_f_coeff_SI, c_f_coeff_SI);
            fprintf('  Coeff a_f = (%.5f +/- %.5f) m/s^2, b_f = %.5f m/s, c_f = %.5f m\n', a_f_coeff_SI, error_a_f_coeff_SI, b_f_coeff_SI, c_f_coeff_SI);
            fprintf('  Acceleration (falling, a_fall) = (%.5f +/- %.5f) m/s^2\n', acc_fall_SI, acc_fall_error_SI);
            % Plot data and fit for falling segment
            t_smooth_fall = linspace(min(t_fit_falling), max(t_fit_falling), 200);
            x_fit_smooth_fall = polyval(coeffs_falling, t_smooth_fall);
            falling_fig = figure;
            set(falling_fig, 'Position', [250, 250, 600, 400]);
            plot(t_fit_falling, x_falling, '*', 'DisplayName', 'Data'); hold on;
            plot(t_smooth_fall, x_fit_smooth_fall, 'k--', 'LineWidth', 1.5, 'DisplayName', 'Fit'); hold off;
            title('Falling Segment: Data and Quadratic Fit');
            xlabel('Time (s) from peak');
            ylabel('Position (mm)');
            legend('show', 'Location', 'best');
            grid on;
            % Add padding to axes
            ax_fall = gca;
            current_xlim_fall = xlim(ax_fall);
            current_ylim_fall = ylim(ax_fall);
            x_range_fall = current_xlim_fall(2) - current_xlim_fall(1);
            y_range_fall = current_ylim_fall(2) - current_ylim_fall(1);
            x_padding_fall = 0.05 * x_range_fall;
            y_padding_fall = 0.05 * y_range_fall;
            if x_range_fall == 0; x_padding_fall = 0.1; end
            if y_range_fall == 0; y_padding_fall = 0.1; end
            xlim(ax_fall, [current_xlim_fall(1) - x_padding_fall, current_xlim_fall(2) + x_padding_fall]);
            ylim(ax_fall, [current_ylim_fall(1) - y_padding_fall, current_ylim_fall(2) + y_padding_fall]);
            
            drawnow expose;
            try
                exportgraphics(falling_fig, 'falling_fit.png');
                fprintf('Exported falling segment fit figure to falling_fit.png\n');
            catch ME_falling
                fprintf('Error exporting falling segment fit figure: %s\n', ME_falling.message);
            end

            % --- Calculate and print mu_k ---
            if ~isnan(acc_rise_SI) && ~isnan(acc_fall_SI)
                % Ensure h1 and L are the correct ones for this measurement (they are globally defined)
                % h1 is 25e-3 m, L is 1.26 m, g is 9.7949 m/s^2
                if L > h1 % Ensure L^2 - h1^2 is not negative for sqrt
                    cos_theta = sqrt(L^2 - h1^2) / L;
                    mu_k = (acc_fall_SI - acc_rise_SI) / (2 * g * cos_theta);
                    fprintf('Calculated kinetic friction coefficient (mu_k) for h1 (25mm) measurement:\n');
                    fprintf('  a_up = (%.5f +/- %.5f) m/s^2, a_down = (%.5f +/- %.5f) m/s^2\n', acc_rise_SI, acc_rise_error_SI, acc_fall_SI, acc_fall_error_SI);
                    fprintf('  L = %.5f m, h1 = %.5f m, g = %.5f m/s^2\n', L, h1, g);
                    fprintf('  cos(theta) = %.5f\n', cos_theta);
                    fprintf('  mu_k = %.5f\n', mu_k);
                else
                    fprintf('Cannot calculate mu_k: L must be greater than h1 for cos(theta) calculation.\n');
                end
            else
                fprintf('Cannot calculate mu_k: acc_rise_SI or acc_fall_SI is NaN.\n');
            end
            % --- End mu_k calculation ---

        else
            fprintf('  Falling segment: Not enough data points to fit (needs at least 3).\n');
        end
    else
        fprintf('  Peak index (%d) for accel calculation is outside the processed data segment (1 to %d) for %s.\n', peak_idx_in_segment, length(accel_pos_mm), data_for_accel.filename);
    end
    fprintf('--- End Acceleration Calculation ---\n');
else
    fprintf("Warning: Target data for acceleration calculation ('%s') not successfully processed or not found.\n", target_desc_accel);
end
fprintf("--- End Phase 4 ---\n\n");

fprintf("Processing complete.\n");