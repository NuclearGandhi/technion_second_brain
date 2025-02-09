import numpy as np

# %% Parameters

# Given data
L1 = 4 * np.sqrt(2)  # m
L2 = 2  # m
T_surr = T3 = 100  # K
T1 = 305  # K
epsilon = 0.8
T_inf = 300  # K
k = 26.4e-3  # W/m.K
Pr = 0.707
nu = 15.76e-6  # m^2/s
beta = 3.33e-3  # K^-1
bd = 4  # m

# %% Part a

# Calculate characteristic length L
W = 10  # Assuming W is large enough
L = L1 / 2

print(f"Characteristic length L: {L:.5} m")

# Calculate Rayleigh number Ra_L
g = 9.81  # m/s^2
Ra_L = (g * beta * (T1 - T_inf) * L**3) / (nu**2) * Pr

print(f"Rayleigh number Ra_L: {Ra_L:.5}")

# Calculate Nusselt number Nu_L
Nu_L = 0.15 * Ra_L**(1/3)

print(f"Nusselt number Nu_L: {Nu_L:.5}")

# Calculate convective heat transfer coefficient h
h = k / L * Nu_L

print(f"Convective heat transfer coefficient h: {h:.5} W/m^2.K")

# %% Part b

# Constants
sigma = 5.67e-8  # W/m^2.K^4, Stefan-Boltzmann constant

# Calculate the heat flux q'
q_conv = h * L1 * (T1 - T_inf)
q_rad = L1 * epsilon * sigma * (T1**4 - T3**4)
q_prime = q_conv + q_rad

print(f"Heat per unit length q': {q_prime:.5} W/m")

# %% Part d

# Calculate view factors
F_14 = (L1 + L2 - np.sqrt(L2**2 + (2 * L2)**2)) / (2 * L1)
F_16 = 0.5  # From symmetry
F_12 = 1 - F_16 - F_14
F_13 = 1 - F_12

print(f"View factor F_14: {F_14:.5}")
print(f"View factor F_16: {F_16:.5}")
print(f"View factor F_12: {F_12:.5}")
print(f"View factor F_13: {F_13:.5}")

# Calculate view factors for surface 2
A1 = L1
A2 = L2
F_21 = (A1 / A2) * F_12
F_23 = 1 - F_21

print(f"View factor F_21: {F_21:.5}")
print(f"View factor F_23: {F_23:.5}")

# %% Part e

def parallel_resistance(R1, R2):
    return 1 / (1 / R1 + 1 / R2)

# Calculate total radiative resistance R'_tot
R_surface = (1 - epsilon) / (epsilon * L1)
R_12 = 1 / (L1 * F_12)
R_23 = 1 / (L2 * F_23)
R_13 = 1 / (L1 * F_13)
R_tot = R_surface + parallel_resistance(R_12+R_23, R_13)

print(f"Total radiative resistance per unit length R'_tot: {R_tot:.5} 1/m")

q_prime = h * L1 * (T1 - T_inf) + sigma * (T1**4 - T3**4) / R_tot
print(f"Heat per unit length q': {q_prime:.5} W/m")