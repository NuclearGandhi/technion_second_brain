import math

# %% Part a

# Given data
k_N = 21  # W/m.K
k_C = 1.4  # W/m.K
T_inf = 300  # K
h_o = 8.0  # W/m^2.K
q_dot = 3e4  # W/m^3
r1 = 0.7  # m
r2 = 0.77  # m
r3 = 0.97  # m

# Calculate the thermal resistances
R_N = 1 / (4 * math.pi * k_N) * (1 / r1 - 1 / r2)
print(f"Thermal resistance R_N: {R_N:.5} K/W")

R_C = 1 / (4 * math.pi * k_C) * (1 / r2 - 1 / r3)
print(f"Thermal resistance R_C: {R_C:.5} K/W")

R_conv = 1 / (4 * math.pi * h_o * r3**2)
print(f"Thermal resistance R_conv: {R_conv:.5} K/W")

# Calculate the total thermal resistance
R_total = R_N + R_C + R_conv
print(f"Total thermal resistance R_total: {R_total:.5} K/W")

# Calculate the heat generation rate
V = (4 / 3) * math.pi * r1**3
q = q_dot * V
print(f"Heat generation rate Q_gen: {q:.5} W")

# Calculate the temperatures
T3 = T_inf + q * R_conv
print(f"Temperature T3: {T3:.5} K")

T2 = T_inf + q * (R_conv + R_C)
print(f"Temperature T2: {T2:.5} K")

T1 = T_inf + q * (R_conv + R_C + R_N)
print(f"Temperature T1: {T1:.5} K")

# %% Part c

# Given data for סעיף ג'
k = 116  # W/m.K
rho = 7130  # kg/m^3
c_p = 388  # J/kg.K
h = 15  # W/m^2.K
r1 = 0.7  # m
T_i = 1432.9  # K (initial temperature)
T_inf = 300  # K (ambient temperature)

# Calculate the characteristic length
L_c = r1 / 3
print(f"Characteristic length L_c: {L_c:.5} m")

# Calculate the Biot number
Bi = h * L_c / k
print(f"Biot number Bi: {Bi:.5}")

# Calculate the time constant
tau = (rho * c_p * (4/3) * math.pi * r1**3) / (h * 4 * math.pi * r1**2)
print(f"Time constant tau: {tau:.5} s")

# Calculate the time to lose 50% of the initial energy
t = -tau * math.log(0.5)
print(f"Time to lose 50% of the initial energy t: {t:.5} s")

# Calculate the temperature at time t1
T_t1 = T_inf + (T_i - T_inf) * math.exp(-t / tau)
print(f"Temperature at time t1: {T_t1:.5} K")

