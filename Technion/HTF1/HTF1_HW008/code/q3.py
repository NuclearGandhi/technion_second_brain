import math

# Given data
m_dot_h = 6.9  # kg/s
c_p_h = 3810  # J/kg.K
T_h_i = 66  # °C
T_h_o = 40  # °C

m_dot_c = 6.3  # kg/s
c_p_c = 4173  # J/kg.K
T_c_i = 10  # °C

U = 570  # W/m^2.K

# Calculate heat transfer rate (q)
q = m_dot_h * c_p_h * (T_h_i - T_h_o)
T_c_o = T_c_i + q / (m_dot_c * c_p_c)

print(f"Heat transfer rate (q): {q:.5} W")
print(f"Outlet temperature of the cold fluid (T_c_o): {T_c_o:.5} °C")

# Calculate the log mean temperature difference (ΔT_lm)
delta_T1 = T_h_i - T_c_i
delta_T2 = T_h_o - T_c_o
delta_T_lm = (delta_T1 - delta_T2) / math.log(delta_T1 / delta_T2)

print(f"Log mean temperature difference (ΔT_lm): {delta_T_lm:.5} °C")

# Calculate the area (A) for parallel flow
A_parallel = q / (U * delta_T_lm)
print(f"Area for parallel flow (A_parallel): {A_parallel:.5} m^2")

# Calculate the log mean temperature difference (ΔT_lm) for counterflow
delta_T1_cf = T_h_i - T_c_o
delta_T2_cf = T_h_o - T_c_i
delta_T_lm_cf = (delta_T1_cf - delta_T2_cf) / math.log(delta_T1_cf / delta_T2_cf)

print(f"Log mean temperature difference for counterflow (ΔT_lm_cf): {delta_T_lm_cf:.5} °C")

# Calculate the area (A) for counterflow
A_counterflow = q / (U * delta_T_lm_cf)
print(f"Area for counterflow (A_counterflow): {A_counterflow:.5} m^2")

# Calculate R and P for crossflow
R = (T_h_i - T_h_o) / (T_c_o - T_c_i)
P = (T_c_o - T_c_i) / (T_h_i - T_c_i)
print(f"R: {R:.5}")
print(f"P: {P:.5}")

F = 0.85
# Calculate the corrected log mean temperature difference (ΔT_lm_corrected)
delta_T_lm_corrected = delta_T_lm_cf * F

# Calculate the area (A) for two tube passes
A_crossflow = q / (U * delta_T_lm_corrected)
print(f"Area for crossflow with correction factor (A_crossflow): {A_crossflow:.5} m^2")

F = 0.9
# Calculate the corrected log mean temperature difference (ΔT_lm_corrected)
delta_T_lm_corrected = delta_T_lm_cf * F

# Calculate the area (A) for crossflow with one fluid mixed and the other unmixed
A_crossflow = q / (U * delta_T_lm_corrected)
print(f"Area for crossflow with one fluid mixed and the other unmixed (A_crossflow): {A_crossflow:.5} m^2")
