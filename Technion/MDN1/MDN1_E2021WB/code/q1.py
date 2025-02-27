# %% Part a
import numpy as np

# Given data
N_A = 20
N_B = 50
N_C = 20
N_D = 60
H = 10e3  # in kW
n_in = 720  # in rpm
phi = 20  # in degrees
psi_1 = 30  # in degrees
m_n1 = 3  # in mm
psi_2 = 25  # in degrees
m_n2 = 5  # in mm
S_sy = 790  # in MPa
S_ut = 965  # in MPa

# Calculations
m_t2 = m_n2 / np.cos(np.radians(psi_2))
n_out = n_in * (N_A / N_B) * (N_C / N_D)

print(f"m_t2 = {m_t2:.2f}")
print(f"n_out = {n_out:.2f}")

W_t2 = (19.1 * 10**3 * H) / (N_D * m_t2 * n_out)

phi_t2 = np.degrees(np.arctan(np.tan(np.radians(phi)) / np.cos(np.radians(psi_2))))
print(f"phi_t2 = {phi_t2:.2f}")

W_r2 = W_t2 * np.tan(np.radians(phi_t2))
W_a2 = W_t2 * np.tan(np.radians(psi_2))

# Calculate W_t1
m_t1 = m_n1 / np.cos(np.radians(psi_1))
W_t1 = (19.1 * 10**3 * H) / (N_A * m_t1 * n_in)
W_a1 = W_t1 * np.tan(np.radians(psi_1))

# Total axial force
W_a = -W_a1 + W_a2

# Results
print(f"W_t2 = {W_t2:.2f}")
print(f"W_r2 = {W_r2:.2f}")
print(f"W_a2 = {W_a2:.2f}")
print(f"W_t1 = {W_t1:.2f}")
print(f"W_a1 = {W_a1:.2f}")
print(f"W_a = {W_a:.2f}")


