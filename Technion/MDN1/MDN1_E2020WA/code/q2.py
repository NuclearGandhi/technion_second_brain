import sympy as sp
import numpy as np

# Given constants
C = 6
F_max = 2250.0  # N
A = 2211
m = 0.145
n = 1.3
f_work = 5.0  # Hz
G = 80 * 10**9  # Pa
rho = 7800  # kg/m^3
L_max = 0.132  # m
S_ut = 1600e6  # Pa

# Define the variable
d = sp.Symbol('d')

# Calculate S_sy
S_sy = 0.45 * A / d**m

# Calculate tau_max
tau_max = S_sy / n

# Calculate the left side of the equation
left_side = tau_max

# Calculate the right side of the equation
K_W = (4 * C - 1) / (4 * C - 4) + 0.615 / C
right_side = K_W * (8 * F_max * C) / (sp.pi * d**2)

# Equation
equation = sp.Eq(left_side, right_side)
print(f"Equation: {equation}")

# Solve for d
solution = sp.solve(equation, d)
print(f"Solution for d: {solution}")

# %% Part 2.2

d = 10e-3 # m

# Calculate N_a
f = 20 * f_work
alpha = 2
N_a = 1 / (40 * sp.pi * C * d * f_work) * sp.sqrt(G / (rho * (1 + 2 * C**2)))
print(f"N_a = {N_a.evalf()}")

# %% Part 2.3

N_a = 11

K = d * G / (8 * C**3 * N_a)
print(f"K = {K}")
L_0 = L_max + F_max / K
print(f"L_0 = {L_0:.5} m")

# %% Part 2.4

k = 50e3 # N/m
delta_L = 40e-3 # m
k_e = 0.702


F_min = F_max - k * delta_L
F_m = (F_max + F_min) / 2
F_a = (F_max - F_min) / 2

print(f"F_m = {F_m:.5} N")
print(f"F_a = {F_a:.5} N")
print(f"F_min = {F_min:.5} N")

tau_m = K_W * (8 * F_m * C) / (np.pi * d**2)
tau_a = K_W * (8 * F_a * C) / (np.pi * d**2)

print(f"tau_m = {tau_m:.5} Pa")
print(f"tau_a = {tau_a:.5} Pa")

S_sa = 398.0e6  # Pa
S_sm = 534.0e6  # Pa
S_su = 0.67 * S_ut
S_se = k_e * S_sa / (1 - (S_sm / S_su)**2)

print(f"S_se = {S_se:.5} Pa")
print(f"S_su = {S_su:.5} Pa")

n_f = 1 / ((tau_a / S_se) + (tau_m / S_su))
print(f"n_f = {n_f}")

# %% Part 2.5
