import math


# Given diameters
D_i = 0.025  # m
D_o = 0.035  # m

# Calculate areas
A_c = math.pi * (D_i ** 2) / 4
A_h = math.pi * ((D_o ** 2) / 4 - (D_i ** 2) / 4)

print(f"Area of the cold fluid side (A_c): {A_c:.5} m^2")
print(f"Area of the hot fluid side (A_h): {A_h:.5} m^2")


# Given data
m_dot_h = 0.1  # kg/s
c_p_h = 2130  # J/kg.K
T_h_i = 100  # °C
T_h_o = 60  # °C

m_dot_c = 0.2  # kg/s
c_p_c = 4174  # J/kg.K
T_c_i = 30  # °C

# Calculate heat transfer rate (q)
q = m_dot_h * c_p_h * (T_h_i - T_h_o)

# Calculate the outlet temperature of the cold fluid (T_c_o)
T_c_o = T_c_i + q / (m_dot_c * c_p_c)

# Calculate the log mean temperature difference (ΔT_lm)
delta_T1 = T_h_i - T_c_o
delta_T2 = T_h_o - T_c_i
delta_T_lm = (delta_T1 - delta_T2) / math.log(delta_T1 / delta_T2)

# Print the results
print(f"Heat transfer rate (q): {q:.5} W")
print(f"Outlet temperature of the cold fluid (T_c_o): {T_c_o:.5} °C")
print(f"Log mean temperature difference (ΔT_lm): {delta_T_lm:.5} °C")

# Given properties for oil
k_o = 0.138  # W/m.K
Nu_D_o = 5.56

# Calculate heat transfer coefficient for oil (h_o)
h_o = k_o * Nu_D_o / (D_o - D_i)
print(f"Heat transfer coefficient for oil (h_o): {h_o:.5} W/m^2.K")

# Given properties for water
rho_w = 934.58  # kg/m^3
k_w = 0.628  # W/m.K
mu_w = 695e-6  # N.s/m^2
Pr_w = 4.62

# Calculate Reynolds number for water (Re_D_w)
u_w = m_dot_c / (A_c * rho_w)
Re_D_w = (rho_w * u_w * D_i) / mu_w
print(f"Reynolds number for water (Re_D_w): {Re_D_w:.5}")

# Calculate Nusselt number for water (Nu_D_w)
Nu_D_w = 0.023 * (Re_D_w ** 0.8) * (Pr_w ** 0.4)

# Calculate heat transfer coefficient for water (h_i)
h_i = k_w * Nu_D_w / D_i
print(f"Heat transfer coefficient for water (h_i): {h_i:.5} W/m^2.K")

# Calculate overall heat transfer coefficient (U)
U = (h_i * h_o) / (h_i + h_o)
print(f"Overall heat transfer coefficient (U): {U:.5} W/m^2.K")

# Calculate length of the heat exchanger (L)
L = q / (math.pi * U * D_i * delta_T_lm)
print(f"Length of the heat exchanger (L): {L:.5} m")

# Given data for part c
m_dot_c_new = 0.1  # kg/s
m_dot_h_new = 0.1  # kg/s

# Calculate new Reynolds number for water (Re_D_w_new)
u_w_new = m_dot_c_new / (A_c * rho_w)
Re_D_w_new = (rho_w * u_w_new * D_i) / mu_w
print(f"New Reynolds number for water (Re_D_w_new): {Re_D_w_new:.5}")

# Calculate new Nusselt number for water (Nu_D_w_new)
Nu_D_w_new = 0.023 * (Re_D_w_new ** 0.8) * (Pr_w ** 0.4)

# Calculate new heat transfer coefficient for water (h_i_new)
h_i_new = k_w * Nu_D_w_new / D_i
print(f"New heat transfer coefficient for water (h_i_new): {h_i_new:.5} W/m^2.K")

# Calculate new overall heat transfer coefficient (U_new)
U_new = (h_i_new * h_o) / (h_i_new + h_o)
print(f"New overall heat transfer coefficient (U_new): {U_new:.5} W/m^2.K")

# Calculate new outlet temperature of the cold fluid (T_c_o_new)
T_c_o_new = T_c_i + q / (m_dot_c_new * c_p_c)
print(f"New outlet temperature of the cold fluid (T_c_o_new): {T_c_o_new:.5} °C")

# Calculate heat capacity rates
C_min = m_dot_h_new * c_p_h
C_max = m_dot_c_new * c_p_c

print(f"Heat capacity rate for the hot fluid (C_min): {C_min:.5} W/K")
print(f"Heat capacity rate for the cold fluid (C_max): {C_max:.5} W/K")

C_r = C_min / C_max
print(f"Heat capacity rate ratio (C_r): {C_r:.5}")

# Calculate NTU
NTU = U_new * math.pi * D_i * L / C_min
print(f"Number of Transfer Units (NTU): {NTU:.5}")

# Calculate effectiveness (ε)
epsilon = (1 - math.exp(-NTU * (1 - C_r))) / (1 - C_r * math.exp(-NTU * (1 - C_r)))
print(f"Effectiveness (ε): {epsilon:.5}")

# Calculate new outlet temperature of the hot fluid (T_h_o_new)
T_h_o_new = T_h_i - epsilon * (T_h_i - T_c_i)
print(f"New outlet temperature of the hot fluid (T_h_o_new): {T_h_o_new:.5} °C")

# Calculate new outlet temperature of the cold fluid (T_c_o_new)
T_c_o_new = T_c_i + epsilon * C_r * (T_h_i - T_c_i)
print(f"New outlet temperature of the cold fluid (T_c_o_new): {T_c_o_new:.5} °C")

