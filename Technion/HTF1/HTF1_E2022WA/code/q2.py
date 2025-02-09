import numpy as np

# %% Parameters

# Given data
cp_h = 1120  # J/kg.K
T_h_i = 1400  # K
m_dot_h = 10  # kg/s
x_c_i = 0.0
x_c_o = 1.0
T_c_o = 450  # K
m_dot_c = 3  # kg/s
U = 50  # W/m^2.K
N = 500
D = 0.025  # m

# %% Part a

# Calculate the heat transfer rate q
h_fg = 2024e3  # J/kg (from table A.6 for T_c_o = 450 K)
q = m_dot_c * h_fg

print(f"Heat transfer rate q: {q:.5} W")

# %% Part b

T_c_i = T_c_o

epsilon = q / (m_dot_h * cp_h * (T_h_i - T_c_i))
print(f"Effectiveness epsilon: {epsilon:.5}")

# %% Part c
NTU = -np.log(1 - epsilon)
print(f"Number of transfer units NTU: {NTU:.5}")

# %% Part d

L = (NTU * cp_h * m_dot_h) / (U * np.pi * D * N)
print(f"Length of heat exchanger L: {L:.5} m")