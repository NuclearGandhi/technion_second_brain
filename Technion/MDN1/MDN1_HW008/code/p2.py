import numpy as np

# Given data
N_P = 24  # number of teeth on the pinion
N_G = 60  # number of teeth on the gear
m = 4  # module in mm
phi = np.deg2rad(20)  # pressure angle in degrees

# %% Question 6

# Calculate the pitch diameters
d_P = m * N_P
d_G = m * N_G

# Calculate the center distance
C = (d_P + d_G) / 2

# Display the result
print(f'The center distance is {C:.5} mm')

# %% Question 7

# New center distance
C_new = C + 1.5

# Calculate the new pitch diameters
d_P_new = (2 * C_new) / (1 + (N_G / N_P))
d_G_new = (N_G / N_P) * d_P_new

r_P_new = d_P_new / 2

# Display the results
print(f'The new pitch diameter of the pinion is {d_P_new:.5} mm')
print(f'The new pitch diameter of the gear is {d_G_new:.5} mm')
print(f'The new radius of the pinion is {r_P_new:.5} mm')

# %% Question 8

# Calculate the base radius of the pinion
r_bP = (d_P / 2) * np.cos(phi)

# Calculate the new pressure angle
phi_new = np.arccos(r_bP / (d_P_new / 2))

print(f'The base radius of the pinion is {r_bP:.5} mm')
print(f'The new pressure angle is {np.rad2deg(phi_new):.5} degrees')

# %% Question 9

# Calculate the new base radius of the gear
r_bG = (d_G / 2) * np.cos(phi)

print(f'The base radius of the gear is {r_bG:.5} mm')

p_cG = np.pi * d_G / N_G

print(f'The circular pitch of the gear is {p_cG:.5} mm')


r_pG = r_bG / np.cos(phi)
print(f'The radius of the pitch circle of the gear is {r_pG:.5} mm')

# Calculate the new tooth thickness
inv_phi = np.tan(phi) - phi
inv_phi_new = np.tan(phi_new) - phi_new
t_new = (2 * r_bG / np.cos(phi_new)) * ((p_cG / (4 * r_pG)) + inv_phi - inv_phi_new)

print(f'The new tooth thickness is {t_new:.5} mm')