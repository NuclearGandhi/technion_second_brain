import numpy as np

# %% Parameters

# Given data
epsilon = 0.5
D = 0.02  # m
T1 = 300  # K
T2 = 500  # K
Ta = 300  # K
h = 50  # W/m^2.K
k = 20  # W/m.K
c = 450  # J/kg.K
T = 320  # K

# %% Part a

# Calculate the heat transfer rate q
Ac = np.pi * D**2
q = h * Ac * (T - Ta)

print(f"Heat transfer rate q: {q:.5} W")

# %% Part b

# Constants
sigma = 5.67e-8  # W/m^2.K^4, Stefan-Boltzmann constant

# Calculate blackbody emissive power
Eb1 = sigma * T1**4
Eb2 = sigma * T2**4
Eb3 = sigma * T**4

# View factors
F31 = F32 = 0.5

# Areas (assuming unit areas for simplicity)
A1 = A2 = 1
A3 = np.pi * D**2

# Calculate J3
numerator = Eb1 * A3 * F31 + Eb2 * A3 * F32 + Eb3 * epsilon * A3 / (1 - epsilon)
denominator = A3 * F31 + A3 * F32 + epsilon * A3 / (1 - epsilon)
J3 = numerator / denominator

print(f"J3: {J3:.5} W/m^2")

# Calculate the radiative heat transfer rate q_rad
q_rad = (J3 - Eb3) / ((1 - epsilon) / (epsilon * A3))

print(f"Radiative heat transfer rate q_rad: {q_rad:.5} W")

# %% Part c

rho = 8000  # kg/m^3

Bio = h * (D / 6) / k
print(f"Biot number: {Bio:.5}")

dTdt= (q_rad - q) / (rho * (4 / 3) * np.pi * (D / 2)**3 * c)
print(f"Rate of temperature change dT/dt: {dTdt:.5} K/s")

# %%