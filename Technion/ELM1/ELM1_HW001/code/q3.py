import numpy as np

# %% Given values

# Constants
R = 10  # Ohms
A = 0.072e-6  # m^2
N1 = 300
N3 = 600
x = 2e-3  # m
g1 = 2e-3  # m
g2 = 1.5e-3  # m
mu_0 = 4 * np.pi * 1e-7  # H/m

# %% Calculate reluctances

# Reluctance of g1
def calc_reluctance(length, area):
    return length / (mu_0 * area)

Rg1 = calc_reluctance(g1, A)

# Reluctance of g2
Rg2 = calc_reluctance(g2, A)

# Reluctance of x
Rx = calc_reluctance(x, A)

# %% Calculate equivalent reluctance

# Parallel combination of Rg2 and 2Rx
Rg2_parallel_2Rx = 1 / (1 / Rg2 + 1 / (2 * Rx))

# Total equivalent reluctance
Req = Rg1 + Rg2_parallel_2Rx

# %% Calculate flux and flux density

# Current through N1
I1 = 220 / R  # V / R = I

# Magnetomotive force (MMF)
MMF = N1 * I1

# Flux
phi = MMF / Req

# Flux density in g1
B_g1 = phi / A

# %% Calculate flux in the right coil (phi_3)

# Magnetomotive force (MMF) for N1
MMF1 = N1 * I1

# Calculate MMF2 using the equivalent reluctance
MMF2 = MMF1 / Req * (1 / Rg2 + 1 / (2 * Rx))**-1

# Calculate phi_3
phi_3 = MMF2 / (2 * Rx)

# %% Calculate mutual inductance M_13

# Mutual inductance formula
M_13 = (N3 * phi_3) / I1

# %% Calculate force F

# Force formula
F = (phi_3**2) / (2 * mu_0 * A)

# %% Display results

print("Results:")
print(f"Rg1 = {Rg1:.3e} H^-1")
print(f"Rg2 = {Rg2:.3e} H^-1")
print(f"Rx = {Rx:.3e} H^-1")
print(f"Req = {Req:.3e} H^-1")
print(f"I1 = {I1:.3f} A")
print(f"MMF = {MMF:.3f} A-turns")
print(f"phi = {phi:.3e} Wb")
print(f"B_g1 = {B_g1:.3e} T")
print(f"MMF1 = {MMF1:.3e} A-turns")
print(f"MMF2 = {MMF2:.3e} A-turns")
print(f"phi_3 = {phi_3:.3e} Wb")
print(f"M_13 = {M_13:.3e} H")
print(f"F = {F:.3e} N")