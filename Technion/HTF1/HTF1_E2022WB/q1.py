import numpy as np

# %% Parameters

# Given data
N = 2000
r = 0.006  # m
k = 15.1  # W/m.K
rho = 8085  # kg/m^3
cp = 480  # J/kg.K
T_i1 = 900 + 273.15  # K
T_inf1 = 35 + 273.15  # K
h1 = 125  # W/m^2.K
T_inf2 = 25 + 273.15  # K
h2 = 230  # W/m^2.K
T_o1 = 750 + 273.15  # K

# %% Part a

# Calculate Biot number
Lc = r / 3
Bi = h1 * Lc / k

print(f"Biot number: {Bi:.5}")

# Calculate the time t1 for the temperature to reach T_o1
a = 3 * h1 / (rho * cp * r)
t1 = -1 / a * np.log((T_o1 - T_inf1) / (T_i1 - T_inf1))

print(f"Time t1: {t1:.5} s")

# %% Part b

# Calculate the heat transfer Q for all balls
Q_ball = (4 / 3) * np.pi * rho * r**3 * cp * (T_o1 - T_i1)
Q_total = N * Q_ball

print(f"Heat transfer per ball Q_ball: {Q_ball:.5} J")
print(f"Total heat transfer Q_total: {Q_total:.5} J")

# %% Part c

# Calculate Biot number for the second condition
Bi2 = h2 * Lc / k

print(f"Biot number for second condition: {Bi2:.5}")

# Calculate the time t2 for the temperature to reach T_inf2
a2 = 3 * h2 / (rho * cp * r)
t2 = -1 / a2 * np.log((T_inf2 - T_inf1) / (T_o1 - T_inf1))

print(f"Time t2: {t2:.5} s")

# Calculate the temperature at the outer surface T_o2 after time t2
T_o2 = T_inf2 + (T_o1 - T_inf2) * np.exp(-a2 * 120)

print(f"Temperature at outer surface T_o2: {T_o2 - 273.15:.5} °C")

# Calculate the heat transfer Q for all balls in the second condition
Q_ball2 = (4 / 3) * np.pi * rho * r**3 * cp * (T_o2 - T_o1)
Q_total2 = N * Q_ball2

print(f"Heat transfer per ball in second condition Q_ball2: {Q_ball2:.5} J")
print(f"Total heat transfer in second condition Q_total2: {Q_total2:.5} J")

# %% Part e

# Calculate Biot number for the worst-case scenario
k_eff = k / 12  # Assuming the worst-case scenario
Bi_worst = h2 * Lc / k_eff

print(f"Worst-case Biot number: {Bi_worst:.5}")
