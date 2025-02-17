import numpy

# %% Part b

# Given data
R = 1000  # Ohms
V_S = 12  # Volts
I_S = 0.02  # Amperes
f = 1e6  # Hz
C = 200e-12  # Farads
L = 20e-3  # Henrys

# Angular frequency
omega = 2 * numpy.pi * f

# Impedances
Z_C = 1 / (1j * omega * C)
Z_L = 1j * omega * L

print(f"Z_C: {Z_C:.5} Ohms")
print(f"Z_L: {Z_L:.5} Ohms")

# %% Part c

Z_C = -500j # Ohms
Z_L = 200000j # Ohms

# Parallel impedance of R and Z_C
Z_parallel = (R * Z_C) / (R + Z_C)

# Voltage output using node voltage method
V_out = (V_S / (R))  * Z_parallel + (I_S)  * Z_parallel

V_out_mag = numpy.abs(V_out)
V_out_phase = numpy.angle(V_out)

# Print results
print(f"V_out: {V_out:.5} Volts")

print(f"V_out_mag: {V_out_mag:.5} Volts")
print(f"V_out_phase: {V_out_phase:.5} rads")

# %% Part d

# New resistance value
R_new = 2 * R

# Parallel impedance of 2R and Z_C
Z_parallel_new = (R_new * Z_C) / (R_new + Z_C)

# Voltage output using node voltage method
V_out_new = (V_S / R_new) * Z_parallel_new + I_S * Z_parallel_new

V_out_new_mag = numpy.abs(V_out_new)
V_out_new_phase = numpy.angle(V_out_new)

# Print results
print(f"V_out_new: {V_out_new:.5} Volts")
print(f"V_out_new_mag: {V_out_new_mag:.5} Volts")
print(f"V_out_new_phase: {V_out_new_phase:.5} rads")

# %% Part e

# Given data
R = 1000  # Ohms
L = 50e-3  # Henrys
C = 500e-12  # Farads
f_V = 1e6  # Hz
f_I = 1.1e6  # Hz

# Angular frequencies
omega_V = 2 * numpy.pi * f_V
omega_I = 2 * numpy.pi * f_I

# Impedances
Z_C_V = 1 / (1j * omega_V * C)
Z_L_V = 1j * omega_V * L

Z_C_I = 1 / (1j * omega_I * C)
Z_L_I = 1j * omega_I * L

# Print results
print(f"Z_C_V: {Z_C_V:.5} Ohms")
print(f"Z_L_V: {Z_L_V:.5} Ohms")
print(f"Z_C_I: {Z_C_I:.5} Ohms")
print(f"Z_L_I: {Z_L_I:.5} Ohms")

Z_parallel_I = (R * Z_C_I) / (R + Z_C_I)

V_out_I = I_S * Z_parallel_I
V_out_I_mag = numpy.abs(V_out_I)
V_out_I_phase = numpy.angle(V_out_I)

print(f"V_out_I: {V_out_I:.5} Volts")
print(f"V_out_I_mag: {V_out_I_mag:.5} Volts")
print(f"V_out_I_phase: {V_out_I_phase:.5} rads")

Z_parallel_V = (R * Z_C_V) / (R + Z_C_V)

V_out_V = (V_S / R) * Z_parallel_V
V_out_V_mag = numpy.abs(V_out_V)
V_out_V_phase = numpy.angle(V_out_V)

print(f"V_out_V: {V_out_V:.5} Volts")
print(f"V_out_V_mag: {V_out_V_mag:.5} Volts")
print(f"V_out_V_phase: {V_out_V_phase:.5} rads")
