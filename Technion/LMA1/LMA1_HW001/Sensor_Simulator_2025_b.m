%% Sensor Simulator V2025.1 \CopyRights: Faculty of Mechanical Engineering, Technion 

function Sensor_Simulator_2025_b()
    % Load force-time curve from the .mat file
    data = load("data1.mat");
    xdata = data.xdata;
    ydata = data.ydata;

    % Initial values for simulation parameters
    FS = 1500; % Full scale of force sensor, N
    RE = 1; % Repeatability error in sensor [% of FS]
    RE_N = (RE / 100) * FS; % Repeatability error in sensor [N]
    SE = -1.5; % Sensitivity error [% of k]
%     ZS = 0; % Zero shift error [N]
%     LE = 0; % Linearity error [% deviation from linearity]
    FScard = 1500; % Full scale of sampling card
    BD = 10; % Bit depth of A/D card
    BW = 100; % Bandwidth of force measurement
    sr = 250; % Sampling rate of force measurement [Hz]

    x_0 = xdata; % Values of time (controlled variable)
    z = 2; % Multiplication factor for force raw data
    y_0 = ydata * z;

    % Create the figure
    hFig = figure('color', [1 1 1], 'Units', 'normalized', 'Position', [0.1 0.1 0.8 0.8]);

    % Add a title to the entire figure
    sgtitle('Advanced Lab in Mechanical Engineering - Project 1', 'Interpreter', 'latex', 'FontSize', 20, 'FontWeight', 'bold');

    % Initial plot
    hPlot = plot(x_0, y_0, 'b-', 'LineWidth', 1.3);
    hold on;
    hErrorPlot = plot(x_0, y_0, 'r.--', 'linewidth', 1.1, 'markersize', 12);
    xlabel('Time [s]', 'Interpreter', 'latex', 'FontSize', 18);
    ylabel('Force [N]', 'Interpreter', 'latex', 'FontSize', 18);
    grid(gca, 'minor');
    axis([0 x_0(end) 0 max(y_0) * 1.15]);
    m=0.4; % x location of sliders' text.
    n=0.68; % x location of sliders.

    % Text annotations for parameters
    textHandles = [
         text(m, 0.62, sprintf('Full scale of sensor = %g [N]', FS), 'fontsize', 12, 'Color', 'r','units','normalized');%, 'Interpreter', 'latex');
         text(m, 0.534, sprintf('Rep. error = %g [%% of FS]', RE), 'fontsize', 12, 'Color', 'r','units','normalized');%, 'Interpreter', 'latex');
         text(m, 0.445, sprintf('Sensitivity error = %g [%% of reading]', SE), 'fontsize', 12, 'Color', 'r','units','normalized');%, 'Interpreter', 'latex');
 %         text(m, 0.4, sprintf('Zero shift error = %g [N]', ZS), 'fontsize', 12, 'Color', 'r', 'Interpreter', 'latex');
 %         text(m, 0.38, sprintf('Linearity error = %g [%% deviation]', LE), 'fontsize', 12, 'Color', 'r', 'Interpreter', 'latex');
         text(m, 0.36, sprintf('Full scale of A/D card = %g [N]', FScard), 'fontsize', 12, 'Color', 'r','units','normalized');%, 'Interpreter', 'latex');
         text(m, 0.273, sprintf('Bit depth of A/D card = %g [bit]', BD), 'fontsize', 12, 'Color', 'r','units','normalized');%, 'Interpreter', 'latex');
         text(m, 0.19, sprintf('Bandwidth = %g [Hz]', BW), 'fontsize', 12, 'Color', 'r','units','normalized');%, 'Interpreter', 'latex');
         text(m, 0.105, sprintf('Sampling Rate = %g [Hz]', sr), 'fontsize', 12, 'Color', 'r','units','normalized');%, 'Interpreter', 'latex')
    ];

    % Create sliders next to the text annotations
    sliderWidth = 0.1;
    sliderPositionY = [0.60, 0.53, 0.46, 0.39, 0.32, 0.25, 0.18];%, 0.195, 0.13];
    sliders = gobjects(7, 1);

    sliders(1) = uicontrol('Style', 'slider', 'Min', 900, 'Max', 2000, 'Value', FS, 'Units', 'normalized','SliderStep',[1/110,1/110], 'Position', [n sliderPositionY(1) sliderWidth 0.025], 'Callback', @(src, event) updatePlot(), 'TooltipString', 'Adjust Full Scale of Sensor');
    sliders(2) = uicontrol('Style', 'slider', 'Min', 0, 'Max', 5, 'Value', RE, 'Units', 'normalized','SliderStep',[1/50,1/50], 'Position', [n sliderPositionY(2) sliderWidth 0.025], 'Callback', @(src, event) updatePlot(), 'TooltipString', 'Adjust Repeatability Error');
    sliders(3) = uicontrol('Style', 'slider', 'Min', -5, 'Max', 5, 'Value', SE, 'Units', 'normalized', 'Position', [n sliderPositionY(3) sliderWidth 0.025], 'Callback', @(src, event) updatePlot(), 'TooltipString', 'Adjust Sensitivity Error');
%     sliders(4) = uicontrol('Style', 'slider', 'Min', -10, 'Max', 10, 'Value', ZS, 'Units', 'normalized', 'Position', [n sliderPositionY(4) sliderWidth 0.025], 'Callback', @(src, event) updatePlot(), 'TooltipString', 'Adjust Zero Shift Error');
%     sliders(5) = uicontrol('Style', 'slider', 'Min', 0, 'Max', 5, 'Value', LE, 'Units', 'normalized', 'Position', [n sliderPositionY(5) sliderWidth 0.025], 'Callback', @(src, event) updatePlot(), 'TooltipString', 'Adjust Linearity Error');
    sliders(6) = uicontrol('Style', 'slider', 'Min', 900, 'Max', 2000, 'Value', FScard, 'Units', 'normalized','SliderStep',[1/110,1/110], 'Position', [n sliderPositionY(4) sliderWidth 0.025], 'Callback', @(src, event) updatePlot(), 'TooltipString', 'Adjust Full Scale of A/D Card');
    sliders(7) = uicontrol('Style', 'slider', 'Min', 4, 'Max', 16, 'Value', BD, 'Units', 'normalized','SliderStep',[1/12,1/12], 'Position', [n sliderPositionY(5) sliderWidth 0.025], 'Callback', @(src, event) updatePlot(), 'TooltipString', 'Adjust Bit Depth of A/D Card');
    sliders(8) = uicontrol('Style', 'slider', 'Min', 10, 'Max', 500, 'Value', BW, 'Units', 'normalized','SliderStep',[1/49,1/49], 'Position', [n sliderPositionY(6) sliderWidth 0.025], 'Callback', @(src, event) updatePlot(), 'TooltipString', 'Adjust Bandwidth');
    sliders(9) = uicontrol('Style', 'slider', 'Min', 10, 'Max', 1000, 'Value', sr, 'Units', 'normalized','SliderStep',[1/99,1/99], 'Position', [n sliderPositionY(7) sliderWidth 0.025], 'Callback', @(src, event) updatePlot(), 'TooltipString', 'Adjust Sampling Rate');

    % Update the plot based on slider values
    function updatePlot()
        FS = get(sliders(1), 'Value');
        RE = get(sliders(2), 'Value');
        SE = get(sliders(3), 'Value');
%         ZS = get(sliders(4), 'Value');
%         LE = get(sliders(5), 'Value');
        FScard = get(sliders(6), 'Value');
        BD = get(sliders(7), 'Value');
        BW = get(sliders(8), 'Value');
        sr = get(sliders(9), 'Value');

        RE_N = (RE / 100) * FS; % Update repeatability error with new FS
        k_prime = 1 + (SE / 100); % Adjusted sensitivity with error

        % STEP 1: Inserting random noise (from sensor)
        y_1 = y_0 + RE_N * randn(1, length(x_0));

        % STEP 2: Apply sensitivity error to simulated data
        y_5 = y_1 * (k_prime);

        % STEP 3: Apply zero shift error to simulated data
%         y_6 = y_5 + ZS;

        % STEP 4: Apply linearity error (non-linearity)
%         y_7 = y_6 .* (1 + (LE / 100) * sin(2 * pi * (0:length(y_6) - 1) / length(y_6)));

        % STEP 5: Lowpass filter
        % Calculate the normalized cutoff frequency
        Wn = BW / (1000);
        % Create the low-pass filter using a Butterworth design (order 4)
        [b, a] = butter(4, Wn, 'low');
        % Apply the filter to the signal
        y_2 = filtfilt(b, a, y_5);

        % STEP 6: Digitization of signal in A/D card, according to value of full scale & bit depth
        r = FScard / 2^BD; % Digital resolution of card
        y_3 = round(y_2 ./ r) .* r;

        % STEP 7: Adjust sampling rate
        x_4 = downsample(x_0, round(1000 / sr));
        y_4 = downsample(y_3, round(1000 / sr));

        % Update the plot
        set(hPlot, 'YData', y_0);
        set(hErrorPlot, 'XData', x_4, 'YData', y_4);
        axis([0 x_0(end) 0 max(y_4) * 1.15]);

        % Update text annotations
        set(textHandles(1), 'String', sprintf('Full scale of sensor = %g [ N ]', FS));
        set(textHandles(2), 'String', sprintf('Repeatability err. = %g [ %% of F.S. ]', RE));
        set(textHandles(3), 'String', sprintf('Sensitivity err. = %g [ %% of reading]', SE));
%         set(textHandles(4), 'String', sprintf('Zero shift error = %g [N]', ZS));
%         set(textHandles(5), 'String', sprintf('Linearity error = %g [Precentage deviation]', LE));
        set(textHandles(4), 'String', sprintf('Full scale of A/D card = %g [ N ]', FScard));
        set(textHandles(5), 'String', sprintf('Bit depth of A/D card = %g [ bit ]', BD));
        set(textHandles(6), 'String', sprintf('Bandwidth = %g [ Hz ]', BW));
        set(textHandles(7), 'String', sprintf('Sampling Rate = %g [ Samples/s ]', sr));
    end

    updatePlot(); % Initial plot update

end
