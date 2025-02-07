import math
import matplotlib.pyplot as plt
import numpy as np

# %% Parameters
d_i = 0.1  # m
d_o = 0.2  # m
T_c_i = 30  # °C
T_c_h = 70  # °C
m_dot_h = 5.0  # kg/s
T_h_e = 250.0  # °C
T_h_o = 150  # °C
T_inf = 20  # °C
h_inf = 50  # W/m^2.K
mu_h = 25e-6  # Pa.s
cp_h = 1020  # J/kg.K
k_h = 0.037  # W/m.K
Pr_h = 0.7
mu_c = 490e-6  # Pa.s
cp_c = 4180  # J/kg.K
k_c = 0.65  # W/m.K
Pr_c = 3.1
L_1 = 20  # m

# %% Part a
# Calculate Reynolds number
rho_h = 1.225  # kg/m^3 (assumed for air at standard conditions)
A_i = math.pi * (d_i / 2)**2
u_m_h = m_dot_h / (rho_h * A_i)
Re_D = (rho_h * u_m_h * d_i) / mu_h

print(f"Reynolds number Re_D: {Re_D:.5}")

# Calculate Nusselt number for turbulent flow
Nu_e = 0.023 * Re_D**(4/5) * Pr_h**0.3

print(f"Nusselt number Nu_e: {Nu_e:.5}")

# Calculate heat transfer coefficient
h_e = (k_h / d_i) * Nu_e

print(f"Heat transfer coefficient h_e: {h_e:.5} W/m^2.K")

# %% Part b

# Calculate overall heat transfer coefficient
U_e = 1 / ((1 / h_e) + (1 / h_inf))

print(f"Overall heat transfer coefficient U: {U_e:.5} W/m^2.K")

# Calculate the heat transfer area
A_h = math.pi * d_i * L_1  # Assuming length of 1 meter for simplicity

# Calculate the inlet temperature T_h_i
T_h_i = T_inf - (T_inf - T_h_e) * math.exp(-U_e * A_h / (m_dot_h * cp_h))

print(f"Inlet temperature T_h_i: {T_h_i:.5} °C")

# %% Part c

# Calculate mass flow rate of water
m_dot_c = m_dot_h * cp_h * (T_h_i - T_h_o) / (cp_c * (T_c_h - T_c_i))

print(f"Mass flow rate of water m_dot_c: {m_dot_c:.5} kg/s")

# Calculate Reynolds number for water
Re_D_c = (4 * m_dot_c) / (math.pi * (d_o + d_i) * mu_c)

print(f"Reynolds number for water Re_D_c: {Re_D_c:.5}")

# Calculate Nusselt number for water
Nu_c = 0.023 * Re_D_c**(4/5) * Pr_c**0.4

print(f"Nusselt number for water Nu_c: {Nu_c:.5}")

# Calculate heat transfer coefficient for water
h_c = (k_c / (d_o - d_i)) * Nu_c

print(f"Heat transfer coefficient for water h_c: {h_c:.5} W/m^2.K")

# Calculate overall heat transfer coefficient for heat exchanger
U = 1 / ((1 / h_e) + (1 / h_c))

print(f"Overall heat transfer coefficient U: {U:.5} W/m^2.K")

# %% Part d

# Calculate the log mean temperature difference (LMTD)
delta_T1 = T_h_i - T_c_i
delta_T2 = T_h_o - T_c_h
delta_T_lm = (delta_T1 - delta_T2) / math.log(delta_T1 / delta_T2)

print(f"Log mean temperature difference delta_T_lm: {delta_T_lm:.5} °C")

# Calculate the heat transfer rate
q = m_dot_h * cp_h * (T_h_i - T_h_o)

print(f"Heat transfer rate q: {q:.5} W")

# Calculate the length of the heat exchanger
L_2 = q / (U * math.pi * d_i * delta_T_lm)

print(f"Length of the heat exchanger L_2: {L_2:.5} m")

# Calculate the log mean temperature difference (LMTD) for counterflow
delta_T1_CF = T_h_i - T_c_h
delta_T2_CF = T_h_o - T_c_i
delta_T_lm_CF = (delta_T1_CF - delta_T2_CF) / math.log(delta_T1_CF / delta_T2_CF)

print(f"Log mean temperature difference for counterflow delta_T_lm_CF: {delta_T_lm_CF:.5} °C")

# Calculate the length of the heat exchanger for counterflow
L_2_CF = q / (U * math.pi * d_i * delta_T_lm_CF)

print(f"Length of the heat exchanger for counterflow L_2_CF: {L_2_CF:.5} m")
