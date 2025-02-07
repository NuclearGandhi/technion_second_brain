import math

# %% Parameters
L = 4  # m
d_o = 0.1  # m
d_i = 0.04  # m
k_Z = 22.6  # W/m.K
k_fuel = 10.2  # W/m.K
T_inf = 250 + 273.15  # C to K
h = 500  # W/m^2.K
A = 900e3  # W/m^5
B = 80e3  # W/m^4
C = 7000e3  # W/m^3

# %% Part a
# Calculate thermal resistances
R_Z_c = math.log(d_o / d_i) / (2 * math.pi * k_Z * L)
A_o = math.pi * d_o * L
R_conv = 1 / (h * A_o)

# Calculate heat generation rate
q_dot = lambda r: A * r**2 + B * r + C
q = 2 * math.pi * L * (A * (d_i / 2)**4 / 4 + B * (d_i / 2)**3 / 3 + C * (d_i / 2)**2 / 2)

print(f"Heat generation rate q: {q:.5} W")

# Calculate surface temperature
T_s = T_inf + q * (R_Z_c + R_conv)

print(f"Surface temperature T_s: {T_s - 273.15:.5} °C")  # Convert back to Celsius

# Calculate constants D and E
D = 0.0  # From the adiabatic boundary condition at r=0
r_i = d_i / 2
T_s_C = T_s - 273.15  # Convert surface temperature back to Celsius

print(f"Constant D: {D:.5}")

# Calculate E using the boundary condition T(r_i) = T_s
E = k_fuel * T_s_C + (A * r_i**4 / 16 + B * r_i**3 / 9 + C * r_i**2 / 4)

print(f"Constant E: {E:.5}")

# Calculate temperature at r=0
T_0 = E / k_fuel

print(f"Temperature at r=0: {T_0:.5} °C")

