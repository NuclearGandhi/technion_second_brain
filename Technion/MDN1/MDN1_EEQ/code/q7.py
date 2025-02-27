# %%

import numpy as np

# Given values
P = 2500.0  # N
n = 2.5
Sy = 35.2e6  # Pa
b = 99e-3  # m
d = 123e-3  # m

# Calculate centroid
x_bar = b**2 / (2 * (b + d))
y_bar = (d * (d / 2) + b * d) / (b + d)

print(f"x_bar = {x_bar:.5} m")
print(f"y_bar = {y_bar:.5} m")

# Calculate area and polar moment of inertia
A_star = (b + d)
Ju = ((b + d)**4 - 6 * b**2 * d**2) / (12 * (b + d))

print(f"A = {A_star:.5} m^2")
print(f"Ju = {Ju:.5} m^3")

V = P
T = (0.1+(d-y_bar)) * P

print(f"V = {V:.5} N")
print(f"T = {T:.5} N.m")

# Calculate shear stress due to pure shear
tau_V = np.array([0, V / A_star, 0])

print(f"tau_V = {tau_V}^-1 Pa")

# Calculate distances from centroid
r1 = np.array([(d - y_bar), (b - x_bar), 0])
r2 = np.array([(d - y_bar), -x_bar, 0])
r3 = np.array([-y_bar, -x_bar, 0])

print(f"r1 = {r1}")
print(f"r2 = {r2}")
print(f"r3 = {r3}")


# Calculate shear stress due to torsion at extreme points
tau_1_T = T * np.cross([0, 0, 1], r1) / Ju
tau_2_T = T * np.cross([0, 0, 1], r2)/ Ju
tau_3_T = T * np.cross([0, 0, 1], r3) / Ju

print(f"tau_1_T = {tau_1_T} N/m")
print(f"tau_2_T = {tau_2_T} N/m")
print(f"tau_3_T = {tau_3_T} N/m")

# Calculate total shear stress at point 1 (most critical point)
tau_1 = tau_V + tau_1_T

print(f"tau_1 = {tau_1} N/m")
print(f"tau_1 = {np.linalg.norm(tau_1)} N/m")

# Calculate safety factor
h = (n * np.sqrt(6) * np.linalg.norm(tau_1)) / Sy

print(f"h = {h:.5} m")

# %%
