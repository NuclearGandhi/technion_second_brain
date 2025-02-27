import numpy as np

# Given data
d = 300  # in mm
D = 900  # in mm
C = 1000  # in mm

# Calculations
phi_d = np.pi - 2 * np.arcsin((0.5 * (D - d)) / C)
phi_D = np.pi + 2 * np.arcsin((0.5 * (D - d)) / C)
L = phi_D * (D / 2) + phi_d * (d / 2) + 2 * np.sqrt(C**2 + (0.5 * (D - d))**2)

# Results
print(f"phi_d = {phi_d:.5} radians")
print(f"phi_D = {phi_D:.5} radians")
print(f"L = {L:.2} mm")
