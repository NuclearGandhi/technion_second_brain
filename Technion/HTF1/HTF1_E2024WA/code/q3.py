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

print(f"View factor F_13: {F_13:.5}")
print(f"View factor F_23: {F_23:.5}")

# Calculate the resistances
A1 = math.pi * D_i
A3 = math.pi * D_o

R1 = 1 / (epsilon1 * A1)
R3 = 1 / (epsilon3 * A3)
