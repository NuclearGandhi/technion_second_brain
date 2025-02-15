import math

# %% Part a

# Given data
V = 0.15  # m^3
T_i = 15  # °C
T_o = 55  # °C
cost_per_kwh = 0.6145  # ILS/KWH
c_p = 4.178 * 1e3  # J/kg.K
rho = 993  # kg/m^3

# Calculate the mass of the water
m = rho * V
print(f"Mass of water m: {m:.5} kg")

# Calculate the energy required to heat the water
Q_J = m * c_p * (T_o - T_i)
print(f"Energy required Q: {Q_J:.5} J")

# Convert energy to kWh
Q_kWh = Q_J / (3.6 * 1e6)
print(f"Energy required Q: {Q_kWh:.5} kWh")

# For a year
Q_kWh = Q_kWh * 365
print(f"Energy required Q: {Q_kWh:.5} kWh")

# Calculate the cost
cost = Q_kWh * cost_per_kwh
print(f"Cost of heating the water: {cost:.5} ILS")

# %% Part b

T_i = 5  # °C
T_o = 25  # °C
r_o = 80e-3  # m
r_i = 20e-3  # m
h = 100  # W/m^2.K
T_inf = -10  # °C
k = 10  # W/m.K
R_t_c = 0.05  # m.K/W

# Calculate the thermal resistance of the tube
R_cond = math.log(r_o / r_i) / (2 * math.pi * k)
print(f"Thermal resistance of conduction R_cond: {R_cond:.5} K/W")

# Calculate the thermal resistance of convection
R_conv = 1 / (2 * math.pi * r_o * h)
print(f"Thermal resistance of convection R_conv: {R_conv:.5} K/W")

# Total thermal resistance of the tube
R_L = R_cond + R_t_c
print(f"Total thermal resistance of the left side: {R_L:.5} K/W")

R_R = R_conv
print(f"Total thermal resistance of the right side: {R_R:.5} K/W")

q_prime = (T_o - T_i) / (R_L) + (T_o - T_inf) / (R_R)
print(f"Heat transfer rate per unit length q': {q_prime:.5} W/m")

# %% Part d

D = 4e-2  # m
p_o = 101325  # Pa (atmospheric pressure)
m_dot = 3  # kg/s
T_i = 25  # °C
T_o = 75  # °C
T_s_o = 100  # °C (boiling point at atmospheric pressure)
c_p = 4180  # J/kg.K (specific heat capacity of water)
mu = 577e-6  # N.s/m^2 (dynamic viscosity at 50°C)
k = 0.64  # W/m.K (thermal conductivity of water at 50°C)
Pr = 3.77  # Prandtl number of water at 50°C

# Calculate the Reynolds number
Re_D = (4 * m_dot) / (math.pi * D * mu)
print(f"Reynolds number Re_D: {Re_D:.5}")

# Calculate the Nusselt number using the Dittus-Boelter equation for turbulent flow
Nu_D = 0.023 * (Re_D**0.8) * (Pr**0.4)
print(f"Nusselt number Nu_D: {Nu_D:.5}")

# Calculate the convective heat transfer coefficient
h = Nu_D * k / D
print(f"Convective heat transfer coefficient h: {h:.5} W/m^2.K")

# Calculate the total thermal resistance
R_tot = 1 / (h * math.pi * D)
print(f"Total thermal resistance R_tot: {R_tot:.5} K/W")

# Calculate the length of the pipe
L = -(m_dot * c_p) / (h * math.pi * D) * math.log((T_s_o - T_o) / (T_s_o - T_i))
print(f"Length of the pipe L: {L:.5} m")

# %% Part e

b = 0.4  # m
a = 0.2  # m
L = 1.5  # m
k = 10  # W/m.K

C1 = (b-a) / b * L
C2 = 1/ math.log(a/b)

print(f"C1: {C1:.5}")
print(f"C2: {C2:.5}")

# %% Part f

# Given data for סעיף ו'
m_dot_c = 4.0  # kg/s
T_c_i = 40  # °C
T_c_o = 60  # °C
T_h_i = 95  # °C
T_h_o = 60  # °C
c_p = 4180  # J/kg.K (specific heat capacity of water)

# Calculate the heat transfer rate for the cold fluid
Q_c = m_dot_c * c_p * (T_c_o - T_c_i)
print(f"Heat transfer rate for the cold fluid Q_c: {Q_c:.5} W")

# Calculate the mass flow rate of the hot fluid
m_dot_h = Q_c / (c_p * (T_h_i - T_h_o))
print(f"Mass flow rate of the hot fluid m_dot_h: {m_dot_h:.5} kg/s")