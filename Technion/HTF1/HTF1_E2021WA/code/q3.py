import math
from scipy.special import erfc

# %% Part a

# Given data
d = 0.003  # m
T_i = 80 + 273.15  # C to K
k = 0.1  # W/m.K
rho = 1600  # kg/m^3
cp = 2500  # J/kg.K
epsilon = 0.778
T_sur = 20 + 273.15  # C to K
h_w = 50  # W/m^2.K
sigma = 5.67e-8  # Stefan-Boltzmann constant
t1 = 120  # s
T_inf = 5 + 273.15  # C to K
t2 = 1  # s

# Calculate the heat transfer coefficient for radiation
h_r = epsilon * sigma * (T_i + T_sur) * (T_i**2 + T_sur**2)
print(f"Radiation heat transfer coefficient h_r: {h_r:.5} W/m^2.K")

# Calculate the Biot number
L_c = d / 6  # Characteristic length
Bi = h_r * L_c / k
print(f"Biot number Bi: {Bi:.5}")

# %% Part b

# Calculate the temperature at time t1
tau = (rho * cp * (d / 6)) / h_r
T1 = T_sur + (T_i - T_sur) * math.exp(-t1 / tau)
print(f"Temperature at time t1: {T1 - 273.15:.5} C")

# %% Part c

# Check Biot number for convection
Bi_conv = h_w * L_c / k
print(f"Biot number for convection Bi_conv: {Bi_conv:.5}")

L = d / 2  # Radius of the sphere

# Calculate the Fourier number
alpha = k / (rho * cp)  # Thermal diffusivity
Fo = alpha * t2 / (L**2)
print(f"Fourier number Fo: {Fo:.5}")

# %% Part d

# Calculate the Fourier number for part d
t3 = 60  # s
Fo_d = alpha * t3 / (L**2)
print(f"Fourier number for part d Fo_d: {Fo_d:.5}")

# Calculate Biot number for part d
Bi_d = h_w * d / (2 * k)
print(f"Biot number for part d Bi_d: {Bi_d:.5}")

# Calculate \theta^* in part d
zeta_1 = 1.4
C1 = 1.2
r_star = 0  # Center of the sphere
theta_star = C1 * math.exp(-zeta_1**2 * Fo_d)
print(f"Dimensionless temperature theta^*: {theta_star:.5}")

T3 = T_inf + theta_star * (T1 - T_inf)
print(f"Temperature at time t3: {T3 - 273.15:.5} C")