import math

# %% Part a

# Given data
q_h = 12e6  # W
W_t = 8e6  # W
T_s = 97 + 273.15  # C to K
h_o = 20000  # W/m^2.K
k = 50  # W/m.K
D_i = 0.03  # m
t = 0.003  # m
L = 1  # m
T_c_i = 15 + 273.15  # C to K
u_c = 10  # m/s
rho_c = 999  # kg/m^3
cp_c = 4184  # J/kg.K
mu_c = 1080e-6  # N.s/m^2
k_c = 0.598  # W/m.K
Pr = 7.56

# Calculate Reynolds number
Re_D = (rho_c * u_c * D_i) / mu_c
print(f"Reynolds number Re_D: {Re_D:.5}")

# Calculate Nusselt number and heat transfer coefficient h_i
Nu_D = 0.023 * Re_D**0.8 * Pr**0.4
h_i = (k_c / D_i) * Nu_D
print(f"Heat transfer coefficient h_i: {h_i:.5} W/m^2.K")

D_o = D_i + 2 * t
A_i = math.pi * D_i * L
A_o = math.pi * D_o * L

# Calculate the overall heat transfer coefficient U
R_cond = math.log(D_o / D_i) / (2 * k * math.pi * L)
R_conv_i = 1 / (h_i * A_i)
R_conv_o = 1 / (h_o * A_o)
U = 1 / ((R_cond + R_conv_i + R_conv_o) * A_i)
print(f"Overall heat transfer coefficient U: {U:.5} W/m^2.K")

# %% Part b

# Calculate the outlet temperature of the cooling water T_c_o

T_c_o = T_s - (T_s - T_c_i) * math.exp(- (4 * U * L) / (rho_c * u_c * D_i * cp_c))

print(f"Outlet temperature of the cooling water T_c_o: {T_c_o - 273.15:.5} C")

N = (q_h - W_t) / ((T_c_o - T_c_i) * (rho_c * u_c * cp_c * math.pi * ((D_i ** 2) / 4)))
print(f"Number of tubes N: {N:.5}")
# %%