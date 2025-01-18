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

r_bP = (np.pi * d_P / N_P) * np.cos(phi)
phi_new = np.arccos((N_P / (np.pi * d_P_new)) * r_bP)

print(f'The base radius of the pinion is {r_bP:.5} mm')
print(f'The new pressure angle is {np.rad2deg(phi_new):.5} degrees')