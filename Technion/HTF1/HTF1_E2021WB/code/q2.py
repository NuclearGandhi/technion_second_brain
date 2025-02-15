import math

# %% Part a

# Given data
D = 0.05  # m
T_h_i = 10 + 273.15  # C to K
T_h_o = 100 + 273.15  # C to K
dot_m = 2  # kg/s
c_p = 4184  # J/kg.K
L_h = 8  # m
k_f = 0.65  # W/m.K
mu = 489e-6  # N.s/m^2
Pr = 3.15
t1 = 10  # s
rho = 984.25  # kg/m^3

# Calculate the heat transfer rate q
q = dot_m * c_p * (T_h_o - T_h_i)
print(f"Heat transfer rate q: {q:.5} W")

# %% Part b

# Calculate the heat flux q''
A_h = math.pi * D * L_h
q_double_prime = q / A_h
print(f"Heat flux q'': {q_double_prime:.5} W/m^2")

# Calculate Reynolds number
Re_D = (4 * dot_m) / (math.pi * D * mu)
print(f"Reynolds number Re_D: {Re_D:.5}")

# Calculate Nusselt number and heat transfer coefficient h
Nu_D = 0.023 * Re_D**0.8 * Pr**0.4
h = (k_f / D) * Nu_D
print(f"Heat transfer coefficient h: {h:.5} W/m^2.K")

# Calculate the surface temperature T_s
T_s = T_h_o + (q_double_prime / h)
print(f"Surface temperature T_s: {T_s - 273.15:.5} C")

# %% Part c

# Calculate the velocity of the fluid
A_t = math.pi * (D / 2)**2
u = dot_m / (rho * A_t)
print(f"Velocity of the fluid u: {u:.5} m/s")

# Calculate the length of the sterilization zone L_s
L_s = u * t1
print(f"Length of the sterilization zone L_s: {L_s:.5} m")
