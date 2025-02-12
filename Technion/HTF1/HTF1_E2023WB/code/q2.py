import math

# %% Parameters
T_inf = 20  # °C
h_i = 40  # W/m^2.K
b2 = 10e-3  # m
b1 = 3e-3  # m
W = 40e-3  # m
H = 40e-3  # m
q_dot = 125e3  # W/m^3
k_PCB = 10  # W/m.K
v_o = 0  # m/s
k_fin = 180  # W/m.K
b3 = 20e-3  # m
N_f = 5
Ra_H = 3e5
k_a = 0.037  # W/m.K
Pr_a = 0.7
t = 8e-3  # m

# %% Part a
# Calculate the heat generation rate
q = q_dot * W * b2 * H
print(f"Heat generation rate q: {q:.5} W")

# %% Part b
# Calculate the thermal resistance of the PCB
R_PCB = b1 / (k_PCB * W * H)
print(f"Thermal resistance of PCB R_PCB: {R_PCB:.5} K/W")

# Calculate the convective heat transfer coefficient for natural convection
C = 0.59
n = 1/4
Nu_L = C * (Ra_H**n)
h_a = k_a * Nu_L / H
print(f"Convective heat transfer coefficient h_a: {h_a:.5} W/m^2.K")

# Calculate the thermal resistance of convection
R_conv = 1 / (h_a * W * H)
print(f"Thermal resistance of convection R_conv: {R_conv:.5} K/W")

# Calculate the total thermal resistance to the environment
R_L = R_PCB + R_conv
print(f"Total thermal resistance to the environment R_L: {R_L:.5} K/W")

# Calculate the fin efficiency
L_c = b3 + t / 2
A_f = 2 * W * L_c
m = math.sqrt(2 * h_i / (k_fin * t))
eta_fin = math.tanh(m * L_c) / (m * L_c)
print(f"Corrected length L_c: {L_c:.5} m")
print(f"Fin area A_f: {A_f:.5} m^2")
print(f"m: {m:.5}")
print(f"Fin efficiency η_fin: {eta_fin:.5}")

# Calculate the thermal resistance of the fins
A_b = W * t
R_fins = 1 / (N_f * eta_fin * h_i * A_f + A_b * h_i)
print(f"Thermal resistance of fins R_fins: {R_fins:.5} K/W")

