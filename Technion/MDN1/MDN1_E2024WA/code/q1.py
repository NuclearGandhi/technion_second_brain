# %%

import numpy as np

# %% Part 1.1

# Given values
T = 1.1e6  # N.mm
f = 0.2
alpha = 12e-6  # K^-1
n = 2
d = 50  # mm
d_o = 110  # mm
E = 207e3  # MPa
l = 30  # mm
Sut = 745  # MPa

R = d / 2
r_o = d_o / 2

# Calculate delta
T_max = 2 * T
numerator = 2 * T
denominator = (np.pi / 2) * f * l * d**2 * (E / (2 * R)) * ((r_o**2 - (R)**2) / r_o**2)
delta = numerator / denominator

print(f"delta = {delta:.5} mm")

# Calculate the required temperature change
Delta_T = (2 * delta) / (d * alpha)

print(f"Delta T = {Delta_T:.5} K")

# %% Part 1.2

# %% Part 1.3

# Given values
Se = 250  # MPa
Kf = 2
Mm = 3e3  # N.m
Tm = 1.1e3  # N.m
n = 4
Sy = 470  # MPa

# Convert units
Mm = Mm * 1e3  # N.mm
Tm = Tm * 1e3  # N.mm

# Calculate d
term1 = (16 * n / np.pi) * (1 / Se) * np.sqrt(4 * (Kf * Mm)**2)
term2 = (16 * n / np.pi) * (1 / Sut) * np.sqrt(3 * (Tm)**2)
d = (term1 + term2)**(1/3)

print(f"d = {d:.2f} mm")

# Calculate sigma_max
sigma_max = np.sqrt((32 * Kf * Mm / (np.pi * d**3))**2 + 3 * (16 * Tm / (np.pi * d**3))**2)

print(f"sigma_max = {sigma_max:.2f} MPa")

# Calculate n_y
n_y = Sy / sigma_max

print(f"n_y = {n_y:.2f}")

# %% Part 1.5

# Given values
Fr = 300e3  # N
Fi = 0.25 * 336.6e3  # N
d = 0.030  # m
l = 0.025  # m
ld = 0.008  # m
Ad = 706.9e-6  # m
At = 561e-6  # m
E = 207e9  # GPa

# Calculate stiffness of the bolt
lt = l - ld
kb = (Ad * At * E) / (Ad * lt + At * ld)

# Calculate stiffness of the member
km = (0.5774 * np.pi * E * d) / (2 * np.log(5 * (0.5774 * l + 0.5 * d) / (0.5774 * l + 2.5 * d)))

# Calculate joint stiffness
C = kb / (kb + km)

# Calculate n_0
P = Fr / 2
n_0 = Fi / ((1 - C) * P)

print(f"kb = {kb:.5} N/m")
print(f"km = {km:.5} N/m")
print(f"C = {C:.5}")
print(f"n_0 = {n_0:.5}")
