import math

# Given data
T1 = 500  # K
epsilon1 = 0.8
epsilon2 = 0.8
T3 = 350  # K
epsilon3 = 0.7
D_i = 1  # m
D_o = 3  # m

# Calculate the view factors
F_31 = 0.75
F_32 = 0.25

F_13 = (4/3) * (D_i/D_o) * F_31
F_23 = (4) * (D_i/D_o) * F_32

# Calculate F_12
F_22 = 1 - (2 * math.sqrt(2) / math.pi)
F_12 = (2 * math.sqrt(2) / math.pi) - (1/3)

print(f"View factor F_13: {F_13:.5}")
print(f"View factor F_23: {F_23:.5}")
print(f"View factor F_12: {F_12:.5}")

# Calculate the resistances
A1 = math.pi * (3/4) * D_o
A2 = math.pi * (1/4) * D_o
A3 = math.pi * D_i

R1 = (1 - epsilon1) / (epsilon1 * A1)
R3 = (1 - epsilon3) / (epsilon3 * A3)
R12 = 1 / (A1 * F_12)
R13 = 1 / (A1 * F_13)
R23 = 1 / (A2 * F_23)

print(f"Resistance R1: {R1:.5}")
print(f"Resistance R3: {R3:.5}")
print(f"Resistance R12: {R12:.5}")
print(f"Resistance R13: {R13:.5}")
print(f"Resistance R23: {R23:.5}")

# Calculate the blackbody emissive powers
sigma = 5.67e-8  # Stefan-Boltzmann constant
E_b1 = sigma * T1**4
E_b3 = sigma * T3**4

# Solve the system of equations to find J1, J2, and J3
A = [
    [1/R1 + 1/R12 + 1/R13, -1/R12, -1/R13],
    [-1/R12, 1/R12 + 1/R23, -1/R23],
    [-1/R13, -1/R23, 1/R3 + 1/R13 + 1/R23]
]
B = [E_b1/R1, 0, E_b3/R3]

# Use numpy to solve the linear system
import numpy as np
J = np.linalg.solve(A, B)
J1, J2, J3 = J

print(f"J1: {J1:.5}")
print(f"J2: {J2:.5}")
print(f"J3: {J3:.5}")

# Calculate the heat flux q3
q3 = (J3 - E_b3) / R3
print(f"Heat flux q3: {q3:.5} W/m^2")

# Given data for section ג
cp = 5000  # J/kg.K
Ti = 10 + 273.15  # C to K
To = 50 + 273.15  # C to K
L = 42  # m

# Calculate the mass flow rate
q3_total = q3 * L
mdot = q3_total / (cp * (To - Ti))

print(f"Mass flow rate mdot: {mdot:.5} kg/s")

# Given data for section ד
T3 = 350  # K
To = 50 + 273.15  # C to K
Ti = 10 + 273.15  # C to K
D_i = 1  # m
L = 42  # m

# Calculate the heat transfer coefficient h
As = math.pi * D_i * L
h = -mdot * cp / (As) * math.log((T3 - To) / (T3 - Ti))

print(f"Heat transfer coefficient h: {h:.5} W/m^2.K")

