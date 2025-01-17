import math

# Given data
rho = 990  # kg/m^3
mu = 550e-6  # N.s/m^2
D = 0.04  # m
dot_m = 0.2  # kg/s
k_f = 0.63  # W/m.K
Pr = 3.65
d_s = 0.3 * 10 ** -3  # m

# Calculate the average speed
u = 4 * dot_m / (math.pi * D**2 * rho)

# Calculate Reynolds number
Re_D = rho * u * D / mu

Re_d_s = rho * u * d_s / mu

# Calculate Nusselt number using the given correlation
Nu_D = 0.3 + (0.62 * Re_d_s**0.5 * Pr**(1/3)) / (1 + (0.4 / Pr)**(2/3))**(1/4) * (1 + (Re_d_s / 282000)**(5/8))**(4/5)

# Calculate convective heat transfer coefficient
h = Nu_D * k_f / d_s

print(f"u = {u:.5} m/s")
print(f"Re_D = {Re_D:.5}")
print(f"Re_d_s = {Re_d_s:.5}")
print(f"Nu_D = {Nu_D:.5}")
print(f"h = {h:.5} W/m^2.K")


# Additional given data
L_s = 0.004 # m
q_double_prime = 70 * 10**3  # W/m^2
q_s = 0.04 # W
T_s = 35 # °C
P = 2 * math.pi * D  # Perimeter
L = 2  # m
c_p = 4181  # J/kg.K

T_m_i = T_s + q_s / (h * math.pi * d_s * L_s) - (q_double_prime * math.pi * D * L) / (2 * dot_m * c_p)

# Calculate the outlet temperature
T_m_o = T_m_i + (q_double_prime * math.pi * D * L) / (dot_m * c_p)

print(f"T_m_i = {T_m_i:.5} °C")
print(f"T_m_o = {T_m_o:.5} °C")