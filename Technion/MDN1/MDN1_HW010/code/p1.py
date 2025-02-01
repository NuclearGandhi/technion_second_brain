import numpy as np

# Given data
H = 1750  # W
n_P = 2000  # rpm
N_P = 20
N_G = 40
phi = np.radians(20)  # Convert angle to radians
psi = np.radians(35)  # Convert angle to radians
m = 2.5  # mm

# Calculate d_P
d_P = N_P * m  # mm

# Calculate phi_t
phi_t = np.arctan(np.tan(phi) / np.cos(psi))
print(f'phi_t = {np.degrees(phi_t):.5} degrees')

# Calculate W_t,P
W_t_P = (60000 * H) / (np.pi * d_P * n_P)  # N
print(f'W_t,P = {W_t_P:.5} N')

# Calculate W_r,P
W_r_P = W_t_P * np.tan(phi_t)  # N
print(f'W_r,P = {W_r_P:.5} N')

# Given data for Question 2
H_B = 250
L = 5 * 365 * 24  # hours
R = 0.99

m_B = (N_G / 2 - 1.25) / 2.25  # mm
print(f'm_B = {m_B:.5}')

# Calculate S_t
S_t = 0.533 * H_B + 88.3  # MPa
print(f'S_t = {S_t:.5} MPa')

# Calculate Y_N
N_cycles = 60.0 * L * n_P  # Number of cycles
print(f'N_cycles = {N_cycles:.5}')

Y_N = 1.3558 * N_cycles**(-0.0178)
print(f'Y_N = {Y_N:.5}')

# Given constants
K_O = 1.5
K_V = 1.3
K_s = 1
K_H = 1.2
K_B = 1
Y_J = 0.98 * 0.45  # Adjusted Y_J
print(f'Y_J = {Y_J:.5}')

# Calculate sigma_b_all
sigma_b_all = (S_t / 1) * (Y_N / (1 * 1))  # MPa
print(f'sigma_b_all = {sigma_b_all:.5} MPa')

# Calculate minimum allowable b
b_min = W_t_P * K_O * K_V * K_s * K_H * K_B / (sigma_b_all * Y_J * m)  # mm
print(f'b_min = {b_min:.5} mm')
