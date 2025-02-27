# %%


import numpy as np

# Given data
N_P = 20
H_BP = 450  # in HB
N_G = 100
H_BG = 250  # in HB
n_P = 720  # in rpm
phi = 20  # in degrees
psi = 25  # in degrees
m_n = 4  # in mm
b = 4  # in mm
S_F = 1.5
R = 0.9
L = 5 * 365 * 24  # in hours
eta = 0.95
K_H = 1.2

# Calculations
n_G = n_P * N_P / N_G
m_t = m_n / np.cos(np.radians(psi))

d_P = m_t * N_P
d_G = m_t * N_G

print(f"d_P = {d_P:.5} mm")
print(f"d_G = {d_G:.5} mm")

print(f"m_t = {m_t:.5} mm")
V = (np.pi * N_P * m_t * n_P) / 60000
print(f"V = {V:.5} m/s")

B = 0.25 * (12 - 7)**(2/3)
A = 50 + 56 * (1 - B)
K_V = (A + np.sqrt(200 * V)) / A

print(f"B = {B:.5}")
print(f"A = {A:.5}")
print(f"K_V = {K_V:.5}")

m_BP = (N_P / 2 - 1.25) / 2.25
m_BG = (N_G / 2 - 1.25) / 2.25
print(f"m_BP = {m_BP:.5}")
print(f"m_BG = {m_BG:.5}")

K_o = 1.25
p = np.pi * m_t
K_s = 1 / (1.189) * p**0.097

print(f"p = {p:.5}")
print(f"K_s = {K_s:.5}")

K_B = 1

Y_JP = 0.49 * 1.05
Y_JG = 0.59 * 0.94
print(f"Y_JP = {Y_JP:.5}")
print(f"Y_JG = {Y_JG:.5}")

S_tP = 0.533 * H_BP + 88.3
S_tG = 0.533 * H_BG + 88.3
print(f"S_tP = {S_tP:.5}")
print(f"S_tG = {S_tG:.5}")

Y_theta = 1
Y_Z = 0.85

N_cP = 60.0 * L * n_P * 1
N_cG = 60.0 * L * (n_P * N_P / N_G) * 1

print(f"N_cP = {N_cP:.5}")
print(f"N_cG = {N_cG:.5}")

Y_NP = 1.6831 * N_cP**-0.0323
Y_NG = 1.6831 * N_cG**-0.0323

print(f"Y_NP = {Y_NP:.5}")
print(f"Y_NG = {Y_NG:.5}")

sigma_bP_all = (S_tP / S_F) * (Y_NP / (Y_theta * Y_Z))
sigma_bG_all = (S_tG / S_F) * (Y_NG / (Y_theta * Y_Z))
print(f"sigma_bP_all = {sigma_bP_all:.5}")
print(f"sigma_bG_all = {sigma_bG_all:.5}")

# Updated equation
H_P = (b * d_P**2 * n_P * Y_JP * S_tP * Y_NP) / (19.1 * 10**3 * N_P * K_o * K_V * K_s * K_H * K_B * S_F * Y_theta * Y_Z)
H_G = (b * d_G**2 * n_G * Y_JG * S_tG * Y_NG) / (19.1 * 10**3 * N_G * K_o * K_V * K_s * K_H * K_B * S_F * Y_theta * Y_Z)

# Results
print(f"H_P = {H_P:.5}")
print(f"H_G = {H_G:.5}")

print(f"H_in = {eta * H_G:.5}")
# %%
