clc;
clear;
close all;

omega_tilde = linspace(0, 2, 5000);
Q = 10;
A = 1./sqrt((1-omega_tilde.^2).^2 + (omega_tilde ./ Q).^2);
A_over_Q = A ./ Q;
omega_tilde_A = omega_tilde .* A;
omega_tilde_A_over_Q = omega_tilde .* A_over_Q;
x_phi = atan((1 - omega_tilde.^2) ./ (omega_tilde / Q)) - pi/2;
v_phi = atan((1 - omega_tilde.^2) ./ (omega_tilde / Q));
zoom_in_region = (omega_tilde > 0.9) & (omega_tilde < 1.1) & (A_over_Q > 0.9) & (A_over_Q < 1.1);


figure('Position', [100, 100, 700, 400], 'Name', 'Resonance');
plot(omega_tilde, omega_tilde_A_over_Q, 'DisplayName', 'Velocity Amplitude');
hold on;
plot(omega_tilde, A_over_Q, '--', 'DisplayName', 'Displacement Amplitude');
xlabel('$\tilde{\omega}$');
ylabel('$\frac{A}{Q}$');
title('Resonance in the Velocity and Displacement');
legend('Location', 'northwest');
grid on;

% Show a floating plot with zoom in on the region 0.9 < omega_tilde < 1.1 and 0.9 < A_over_Q < 1.1, on top of subplot(1, 2, 1)
% Create a floating inset plot for the zoom region
zoom_indices = find(zoom_in_region);
if ~isempty(zoom_indices)
    % Create axes for the inset plot positioned over the main plot
    inset_ax = axes('Position', [0.64, 0.6, 0.34, 0.3]); % [left, bottom, width, height]
    
    % Plot the zoomed data
    plot(inset_ax, omega_tilde(zoom_indices), omega_tilde_A_over_Q(zoom_indices), 'DisplayName', 'Velocity Amplitude');
    hold(inset_ax, 'on');
    plot(inset_ax, omega_tilde(zoom_indices), A_over_Q(zoom_indices), '--', 'DisplayName', 'Displacement Amplitude');
    
    % Set limits for the zoom region
    xlim(inset_ax, [0.98, 1.02]);
    ylim(inset_ax, [0.98, 1.005]);
    
    % Style the inset plot
    grid(inset_ax, 'on');
    box(inset_ax, 'on');
    set(inset_ax, 'FontSize', 8);
    
    % Add a border to make it stand out
    set(inset_ax, 'LineWidth', 1.5);

    % Make sure to return focus to the main subplot
    axes(gca);
end

exportgraphics(gcf, 'displacement_and_velocity_resonance.png', 'Resolution', 300);



figure('Position', [100, 100, 600, 400], 'Name', 'Phase');

plot(omega_tilde, v_phi, 'DisplayName', 'Velocity Phase');
hold on;
plot(omega_tilde, x_phi, '--', 'DisplayName', 'Displacement Phase');
yticks([-pi, -pi/2, 0, pi/2, pi]);
yticklabels({'$-\pi$', '$- \pi/2$', '0', '$\pi/2$', '$\pi$'});
xlabel('$\tilde{\omega}$');
ylabel('$\phi$');
ylim([-pi - 0.1, pi/2 + 0.1]);
title('Phase of the Velocity and Displacement');
grid on;
legend('Location', 'northeast');

exportgraphics(gcf, 'displacement_and_velocity_phase.png', 'Resolution', 300);

%% Electrostatic Resonator - Displacement amplitude for different K values
% Equation (7.51): xi = 2*x_s*nu_ac / sqrt((Omega^2 - omega^2)^2 + omega^2/Q^2)
% K = Omega^2 = (1-3*x_s)/(1-x_s)
% x_s = (1-K)/(3-K)
% Resonance occurs at omega_tilde = Omega = sqrt(K)

Q_es = 100;  % Quality factor for electrostatic resonator
% Choose K values so resonance peaks are at Omega = sqrt(K)
% Omega values: ~0.95, 0.8, 0.6, 0.4 -> K = 0.9, 0.64, 0.36, 0.16
K_values = [0.9, 0.64, 0.36, 0.16];
colors = lines(length(K_values));

omega_t = logspace(-1, 0.1, 2000);  % omega_tilde from 0.1 to ~1.25

figure('Position', [100, 100, 700, 450], 'Name', 'Electrostatic Resonator Displacement');
hold on;

for idx = 1:length(K_values)
    K = K_values(idx);
    Omega = sqrt(K);
    x_s = (1 - K) / (3 - K);
    
    % Normalized transfer function: H_norm = Omega / sqrt((Omega^2 - omega^2)^2 + omega^2/Q^2)
    % This makes all peaks equal to Q (at omega = Omega, H_norm = Omega / (Omega/Q) = Q)
    H_norm = Omega ./ sqrt((Omega^2 - omega_t.^2).^2 + omega_t.^2 / Q_es^2);
    
    % Convert to dB
    H_dB = 20 * log10(H_norm);
    
    plot(omega_t, H_dB, '-', 'Color', colors(idx,:), ...
        'DisplayName', sprintf('$K = %.2f,\\, \\Omega = %.2f$', K, Omega));
end

set(gca, 'XScale', 'log');
xlabel('$\tilde{\omega}$');
ylabel('Normalized Gain [dB]');
title(sprintf('Electrostatic Resonator Displacement, $Q = %d$', Q_es));
legend('Location', 'southwest');
grid on;
xlim([0.1, 1.2]);
ylim([-40, 50]);
% Custom x-ticks to match reference
xticks([0.4, 0.6, 0.8, 0.95]);
xticklabels({'0.4', '0.6', '0.8', '0.95'});

exportgraphics(gcf, 'electrostatic_resonator_displacement.png', 'Resolution', 300);

%% Bode diagram - Current gain and phase (with feedthrough and anti-resonance)
% Total admittance: Y = 1 + gamma / ((Omega^2 - omega^2) + i*omega/Q)
% where gamma = 2*x_s/(1-x_s)
%
% Key property: Omega^2 + gamma = 1, so anti-resonance always at omega = 1
% Y = ((1 - omega^2) + i*omega/Q) / ((Omega^2 - omega^2) + i*omega/Q)
%
% Gain: |Y| shows resonance at Omega and anti-resonance at omega = 1
% Phase: referenced to motional current (goes from +90° to -90°)

figure('Position', [100, 100, 700, 600], 'Name', 'Bode Diagram - Current with Feedthrough');

% Use same K values and omega range
omega_t_bode = logspace(-1, 0.3, 2000);  % extend to see past anti-resonance

% Subplot 1: Gain (total admittance with anti-resonance)
subplot(2, 1, 1);
hold on;

for idx = 1:length(K_values)
    K = K_values(idx);
    Omega = sqrt(K);
    x_s = (1 - K) / (3 - K);
    gamma = 2 * x_s / (1 - x_s);
    
    % Total admittance: Y = 1 + gamma / denom
    denom = (Omega^2 - omega_t_bode.^2) + 1i * omega_t_bode / Q_es;
    Y_total = 1 + gamma ./ denom;
    
    % Normalize gain so peaks are equal: multiply by Omega/gamma
    % At resonance: |Y| ~ gamma*Q/Omega, so |Y|*Omega/gamma ~ Q
    Y_norm = abs(Y_total) * Omega / gamma;
    Y_dB = 20 * log10(Y_norm);
    
    plot(omega_t_bode, Y_dB, '-', 'Color', colors(idx,:), ...
        'DisplayName', sprintf('$K = %.2f$', K));
end

set(gca, 'XScale', 'log');
ylabel('Gain [dB]');
title(sprintf('Bode Diagram: Current with Feedthrough, $Q = %d$', Q_es));
legend('Location', 'southwest');
grid on;
xlim([0.1, 1.5]);
xticks([0.4, 0.6, 0.8, 1.0, 1.2]);
yticks([-40, -20, 0, 20, 40]);

% Subplot 2: Phase of total current relative to V_ac
% From eq. (7.60): current ~ cos(omega*t), so there's a 90° lead (i factor)
% At low freq: feedthrough dominates -> phase = +90°
% At resonance: motional dominates (in phase with V) -> phase ~ 0°
% At anti-resonance: partial cancellation, phase jumps
% At high freq: feedthrough dominates again -> phase ~ +90°
subplot(2, 1, 2);
hold on;

for idx = 1:length(K_values)
    K = K_values(idx);
    Omega = sqrt(K);
    x_s = (1 - K) / (3 - K);
    gamma = 2 * x_s / (1 - x_s);
    
    % Total admittance with i factor: Y = i*(1 + gamma/denom)
    % The i factor represents the 90° phase lead from I = C*dV/dt
    denom = (Omega^2 - omega_t_bode.^2) + 1i * omega_t_bode / Q_es;
    Y_total = 1i * (1 + gamma ./ denom);
    phi = angle(Y_total) * 180 / pi;
    
    plot(omega_t_bode, phi, '-', 'Color', colors(idx,:), ...
        'DisplayName', sprintf('$K = %.2f$', K));
end

set(gca, 'XScale', 'log');
xlabel('$\tilde{\omega}$');
ylabel('Phase [deg]');
legend('Location', 'southwest');
grid on;
xlim([0.1, 1.5]);
xticks([0.4, 0.6, 0.8, 1.0, 1.2]);
yticks([-90, -45, 0, 45, 90]);
ylim([-100, 100]);

exportgraphics(gcf, 'electrostatic_resonator_bode.png', 'Resolution', 300);