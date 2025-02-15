import math

# Given data
R = 1  # m
epsilon1 = 0.8
epsilon3 = 0.6
T1 = 1000  # K
T2 = 500  # K
sigma = 5.67e-8  # Stefan-Boltzmann constant

# Calculate the view factors
alpha_90 = math.pi / 2  # 90 degrees in radians
alpha_180 = math.pi  # 180 degrees in radians

F12_90 = 1 - math.sin(alpha_90 / 2)
F13_90 = math.sin(alpha_90 / 2)
F23_90 = math.sin(alpha_90 / 2)

F12_180 = 1 - math.sin(alpha_180 / 2)
F13_180 = math.sin(alpha_180 / 2)
F23_180 = math.sin(alpha_180 / 2)

# Calculate the resistances for alpha = 90 degrees
A1 = R
A2 = R
A3 = R

R1 = (1 - epsilon1) / (epsilon1 * A1)
R12_90 = 1 / (A1 * F12_90)
R13_90 = 1 / (A1 * F13_90)
R23_90 = 1 / (A2 * F23_90)

print(f"Resistance R1: {R1:.5} 1/m")
print(f"Resistance R12 for alpha = 90 degrees: {R12_90:.5} 1/m")
print(f"Resistance R13 for alpha = 90 degrees: {R13_90:.5} 1/m")

# Calculate the total resistance for alpha = 90 degrees
R_tot_90 = R1 + (R12_90 * (R13_90 + R23_90)) / (R12_90 + R13_90 + R23_90)

# Calculate the heat flux for alpha = 90 degrees
E_b1 = sigma * T1**4
E_b2 = sigma * T2**4
q_90 = (E_b1 - E_b2) / R_tot_90

print(f"Total resistance for alpha = 90 degrees: {R_tot_90:.5} 1/m^2")
print(f"Heat flux for alpha = 90 degrees: {q_90:.5} W/m^2")

# Calculate the resistances for alpha = 180 degrees
R13_180 = 1 / (A1 * F13_180)
R23_180 = 1 / (A2 * F23_180)

print(f"Resistance R13 for alpha = 180 degrees: {R13_180:.5} 1/m")

# Calculate the total resistance for alpha = 180 degrees
R_tot_180 = R1 + ((R13_180 + R23_180))

# Calculate the heat flux for alpha = 180 degrees
q_180 = (E_b1 - E_b2) / R_tot_180

print(f"Total resistance for alpha = 180 degrees: {R_tot_180:.5} 1/m^2")
print(f"Heat flux for alpha = 180 degrees: {q_180:.5} W/m^2")
