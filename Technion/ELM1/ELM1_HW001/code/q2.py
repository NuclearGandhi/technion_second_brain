# %%

import numpy as np

# %% Given values

# Current and impedances
I0_mag = 12  # A
I0_angle = 70  # degrees
Z1 = 0.5 + 2j  # Ω
Z2_mag = 1.5  # Ω
Z2_angle = -22  # degrees
Z3 = 0.8 - 12.2j  # Ω

# %% Convert to complex form

# Convert I0 to complex form
I0_rad = np.radians(I0_angle)
I0 = I0_mag * np.exp(1j * I0_rad)
I0_rect = I0_mag * (np.cos(I0_rad) + 1j * np.sin(I0_rad))

# Convert Z2 to complex form
Z2_rad = np.radians(Z2_angle)
Z2 = Z2_mag * np.exp(1j * Z2_rad)
Z2_rect = Z2_mag * (np.cos(Z2_rad) + 1j * np.sin(Z2_rad))

print(f"I0 = {I0_rect.real:.3f} + {I0_rect.imag:.3f}j A")
print(f"Z2 = {Z2_rect.real:.3f} + {Z2_rect.imag:.3f}j Ω")

# %% Calculate voltage and currents

# Calculate parallel impedance
Y_total = 1/Z1 + 1/Z2 + 1/Z3  # Total admittance
Z_total = 1/Y_total  # Total impedance

# Calculate voltage
V = I0 * Z_total

# Calculate currents
I1 = V / Z1
I2 = V / Z2
I3 = V / Z3

# %% Display results

# Format voltage in polar form
V_mag = np.abs(V)
V_angle = np.degrees(np.angle(V))

# Format currents in rectangular and polar form
I1_mag = np.abs(I1)
I1_angle = np.degrees(np.angle(I1))

I2_mag = np.abs(I2)
I2_angle = np.degrees(np.angle(I2))

I3_mag = np.abs(I3)
I3_angle = np.degrees(np.angle(I3))

print("\nResults:")
print(f"V = {V.real:.3f} + {V.imag:.3f}j V")
print(f"V = {V_mag:.3f}∠{V_angle:.2f}° V")

print(f"\nI1 = {I1.real:.3f} + {I1.imag:.3f}j A")
print(f"I1 = {I1_mag:.3f}∠{I1_angle:.2f}° A")

print(f"\nI2 = {I2.real:.3f} + {I2.imag:.3f}j A")
print(f"I2 = {I2_mag:.3f}∠{I2_angle:.2f}° A")

print(f"\nI3 = {I3.real:.3f} + {I3.imag:.3f}j A")
print(f"I3 = {I3_mag:.3f}∠{I3_angle:.2f}° A")

# Verify results using KCL
I_sum = I1 + I2 + I3
print(f"\nI1 + I2 + I3 = {I_sum.real:.3f} + {I_sum.imag:.3f}j A")
print(f"I0 = {I0.real:.3f} + {I0.imag:.3f}j A")
print(f"Difference = {abs(I_sum - I0):.6f} A")