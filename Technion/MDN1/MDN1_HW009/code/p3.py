import numpy as np

# %% Question 6

d2 = 100  # mm
n2 = 800  # rpm
d4 = 39.474  # mm
n4 = 533.33  # rpm
N2 = 20
N4 = 18

V2 = np.pi * d2 * n2 / 60000  # m/s
V4 = np.pi * d4 * n4 / 60000  # m/s

print(f"V2: {V2:.5} m/s")
print(f"V4: {V4:.5} m/s")

# Constants for K_v calculation
A = 59.773
B = 0.82548

# Calculate K_v for each pinion
Kv2 = ((A + np.sqrt(200 * V2)) / A) ** B
Kv4 = ((A + np.sqrt(200 * V4)) / A )** B

print(f"K_v2: {Kv2:.5}")
print(f"K_v4: {Kv4:.5}")

# Calculate m_B for each pinion
m_B2 = (N2 / 2 - 1.25) / 2.25
m_B4 = (N4 / 2 - 1.25) / 2.25

print(f"m_B2: {m_B2:.5}")
print(f"m_B4: {m_B4:.5}")

# Constants for \sigma_{b,\text{all}} calculation
St = 301.5  # MPa
SF = 1
Y_theta = 1
Y_Z = 0.83277
Y_N = 0.97678

# Calculate \sigma_{b,\text{all}} for each pinion
sigma_b_all_2 = (St / SF) * (Y_N / (Y_theta * Y_Z))
sigma_b_all_4 = (St / SF) * (Y_N / (Y_theta * Y_Z))

print(f"sigma_b_all_2: {sigma_b_all_2:.5} MPa")
print(f"sigma_b_all_4: {sigma_b_all_4:.5} MPa")

# Constants for minimum H calculation
Ko = 1
Ks2 = 1.0986
Ks4 = 1
KH = 1
KB = 1
YJ = 0.25
b = 45  # mm
m = 5  # mm

# Calculate minimum H for each pinion
H_min_2 = (sigma_b_all_2 * np.pi * d2 * n2 * b * m * YJ) / (60000 * Ko * Kv2 * Ks2 * KH * KB)
H_min_4 = (sigma_b_all_4 * np.pi * d4 * n4 * b * m * YJ) / (60000 * Ko * Kv4 * Ks4 * KH * KB)

print(f"H_min_2: {H_min_2:.5} W")
print(f"H_min_4: {H_min_4:.5} W")

# in kW
H_min_2 /= 1000
H_min_4 /= 1000

print(f"H_min_2: {H_min_2:.5} kW")
print(f"H_min_4: {H_min_4:.5} kW")
