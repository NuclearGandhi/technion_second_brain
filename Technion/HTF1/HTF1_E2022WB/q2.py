import numpy as np

# %% Parameters

# Given data
T1 = 1700  # K
D = 0.1  # m
T2 = 600  # K
epsilon2 = 0.75
L = 0.025  # m
sigma = 5.67e-8  # W/m^2.K^4

# %% Part a

# Calculate the emissive power of surface 1
Eb1 = sigma * T1**4

print(f"Emissive power of surface 1 Eb1: {Eb1:.5} W/m^2")

# %% Part b

# Given view factor F12
F12 = 0.6

# Calculate view factors using reciprocity and summation rules
A1 = np.pi * (D / 2)**2
A2 = A1
F21 = F12
F13 = F23 = 1 - F12
F31 = (D / (4 * L)) * F13

print(f"View factor F21: {F21:.5}")
print(f"View factor F13: {F13:.5}")
print(f"View factor F31: {F31:.5}")

# %% Part c

# Constants
sigma = 5.67e-8  # W/m^2.K^4

# Calculate blackbody emissive power
Eb1 = sigma * T1**4
Eb2 = sigma * T2**4

denominator = F23 + F12 + (epsilon2 / (1 - epsilon2))

# Calculate constants for J2 as a function of J3
C1 = F23 / denominator
C2 = (F12 * Eb1 + (epsilon2 / (1 - epsilon2)) * Eb2) / denominator

print(f"Constant C1: {C1:.5} W/m^2")
print(f"Constant C2: {C2:.5}")

# %% Part d

# Given relationship for J3
J3_relation = lambda J2: 0.222 * J2 + 107210

# Calculate J2 and J3 using the system of equations
A = np.array([
    [1, -C1],
    [-0.222, 1]
])
B = np.array([
    [C2],
    [107210]
])

J2, J3 = np.linalg.solve(A, B)
J2 = J2[0]
J3 = J3[0]

print(f"J2: {J2:.5} W/m^2")
print(f"J3: {J3:.5} W/m^2")

q2 = (Eb2 - J2) / ((1 - epsilon2) / (epsilon2 * A2))
print(f"Heat flux q2: {q2:.5} W/m^2")