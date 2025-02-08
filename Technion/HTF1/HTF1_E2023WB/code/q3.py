import math

# %% Parameters
D = 0.1  # m
q_double_prime = 10e3  # W/m^2
T_i = 30  # °C
m_dot = 1  # kg/s

# Water properties
rho_w = 980.3  # kg/m^3
c_p = 4183  # J/kg.K
mu = 4.3e-4  # kg/m.s
k = 0.659  # W/m.K
Pr = 2.73

# %% Part a
# Calculate the outlet temperature
T_o = 100  # °C

# Calculate the length of the tube
L = (m_dot * c_p * (T_o - T_i)) / (math.pi * D * q_double_prime)
print(f"Length of the tube L: {L:.5} m")

# %% Part b
# Calculate Reynolds number
Re_D = (4 * m_dot) / (math.pi * D * mu)
print(f"Reynolds number Re_D: {Re_D:.5}")

# Calculate convective heat transfer coefficient
h = (k / D) * (0.023 * (Re_D**0.8) * (Pr**0.4))
print(f"Convective heat transfer coefficient h: {h:.5} W/m^2.K")

# Calculate surface temperature
T_s = T_o + (q_double_prime / h)
print(f"Surface temperature T_s: {T_s:.5} °C")

# %% Part c
# Parameters for the heat exchanger
T_h_i = 450  # °C
m_dot_h = 8  # kg/s
c_p_h = 1040  # J/kg.K
A = 5  # m^2

# Calculate the heat capacity rates
h_fg = 2257e3  # J/kg
C_h = m_dot_h * c_p_h  # J/K

epsilon = m_dot * h_fg / (m_dot_h * c_p_h * (T_h_i - T_o))
print(f"Effectiveness of the heat exchanger ε: {epsilon:.5}")

# Calculate NTU
NTU = 1.5

# Calculate the overall heat transfer coefficient
U = NTU * C_h / A
print(f"Overall heat transfer coefficient U: {U:.5} W/m^2.K")