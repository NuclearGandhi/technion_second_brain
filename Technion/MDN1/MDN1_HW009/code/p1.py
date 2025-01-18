# %% Question 1
import numpy as np

N_P = 15
m = 5  # mm
d_P = float(N_P * m)  # mm
print(f'd_P = {d_P:.5} mm')

n_arm = 250  # rpm
n_S = -5000 / 7  # rpm
N_S = 35

# Calculate n_P
n_P = (-(N_S / N_P) * (n_S - n_arm)) + n_arm
print(f'n_P = {n_P:.5} rpm')

# Calculate W_t,P
H = 5000  # W
W_t_P = (30000 * H) / (np.pi * d_P * n_P)  # N
print(f'W_t,P = {W_t_P:.5} N')

# %% Question 2

# Calculate W_r,P
phi = np.radians(20)  # Convert angle to radians
W_r_P = W_t_P * np.tan(phi)  # N
print(f'W_r,P = {W_r_P:.5} N')

# %% Question 3

# Given data
K_O = 1.5
K_V = 1.3
K_s = 1
K_H = 1.4
K_B = 1
Y_J = 0.25
H_B = 350
S_F = 1
Y_Z = 1
Y_theta = 1
Y_N = 0.97678

# Calculate S_t
S_t = 0.533 * H_B + 88.3  # MPa
print(f'S_t = {S_t:.5} MPa')

# Calculate sigma_b_all
sigma_b_all = (S_t / S_F) * (Y_N / (Y_theta * Y_Z))  # MPa
print(f'sigma_b_all = {sigma_b_all:.5} MPa')

# Find the maximum allowable b
b_max = W_t_P * K_O * K_V * K_s * K_H * K_B / (sigma_b_all * Y_J * m)  # mm
print(f'b_max = {b_max:.5} mm')

