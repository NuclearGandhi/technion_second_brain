import numpy as np

# %% Parameters
sigma = 5.67e-8  # W/m^2.K^4, Stefan-Boltzmann constant
T1 = 270 + 273.15  # K
T2 = 400 + 273.15  # K
T3 = 600 + 273.15  # K
T4 = 600 + 273.15  # K
T5 = 600 + 273.15  # K
T6 = 600 + 273.15  # K
epsilon1 = 0.8
epsilon2 = 0.8
epsilon3 = 0.7
epsilon4 = 0.7
epsilon5 = 0.7
epsilon6 = 0.7
A1 = A2 = A3 = A4 = A5 = A6 = 1  # Assuming unit areas for simplicity
Ac = A3+A4+A5+A6

# %% Part a
F12 = F21 = 0.2
F1c = F2c = 0.8

# %% Part b
Eb1 = sigma * T1**4
Eb2 = sigma * T2**4
Ebc = sigma * T3**4  # Since T3 = T4 = T5 = T6

# Solve the system of equations
A = np.array([
    [(epsilon1 * A1) / (1 - epsilon1) + (A1 * F12) + (A1 * F1c), - (A1 * F12), -(A1 * F1c)],
    [-(A2 * F21), (epsilon2 * A2) / (1 - epsilon2) + (A2 * F21) + (A2 * F2c), - (A2 * F2c)],
    [-(A2 * F1c), - (A2 * F2c), (epsilon3 * Ac) / (1 - epsilon3) + (A2 * F1c) + (A2 * F2c)]
])
B = np.array([
    [Eb1 * epsilon1 * A1 / (1 - epsilon1)],
    [Eb2 * epsilon2 * A2 / (1 - epsilon2)],
    [Ebc * epsilon3 * Ac / (1 - epsilon3)]
])

J = np.linalg.solve(A, B)

J1, J2, Jc = J.flatten()

print(f"J1: {J1:.5} W/m^2")
print(f"J2: {J2:.5} W/m^2")
print(f"Jc: {Jc:.5} W/m^2")

# Calculate the heat fluxes
q1 = (Eb1 - J1) / ((1 - epsilon1) / (epsilon1 * A1))
q2 = (Eb2 - J2) / ((1 - epsilon2) / (epsilon2 * A2))
qc = (Ebc - Jc) / ((1 - epsilon3) / (epsilon3 * Ac))

print(f"Heat flux q1: {q1:.5} W")
print(f"Heat flux q2: {q2:.5} W")
print(f"Heat flux qc: {qc:.5} W")

# %% Part c

# Parameters for part d
k_s = 60  # W/m.K
L = 0.1  # m
T_inf = 27 + 273.15  # K
nu_a = 32e-6  # m^2/s
k_a = 0.037  # W/m.K
Pr_a = 0.7

# Calculate the surface temperature T_s
T_s = T2 - abs(q2) * L / (k_s * A1)

print(f"Surface temperature T_s: {T_s - 273.15:.5} °C")

L = 1  # m

# Calculate the heat transfer coefficient h
h = abs(q2) / (A2 * (T_s - T_inf))

print(f"Heat transfer coefficient h: {h:.5} W/m^2.K")

# Calculate the Reynolds number
Re_L = ((h * L / (k_a * Pr_a**(1/3)) + 871) / 0.037)**(5/4)

print(f"Reynolds number for air Re_a: {Re_L:.5}")

# Calculate the air velocity
u_a = Re_L * nu_a / L

print(f"Air velocity u_a: {u_a:.5} m/s")


