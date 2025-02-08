import math
import scipy.optimize

# %% Parameters
S_T = 0.1  # m
S_L = 0.1  # m
U_i = 6    # m/s
T_i = 27   # °C
T_s = 200  # °C
D = 0.05   # m
L = 0.2    # m
N = 25
N_T = 5

# Air properties at T_f = 300K
rho = 1.1614  # kg/m^3
c_p = 1.007   # kJ/kg.K
mu = 184.6e-7 # Pa.s
k = 26.3e-3   # W/m.K
Pr = 0.707

# %% Part a
# Calculate maximum velocity
V_max = (S_T / (S_T - D)) * U_i
print(f"Maximum velocity V_max: {V_max:.5} m/s")

# Calculate maximum Reynolds number
Re_D_max = (rho * V_max * D) / mu
print(f"Maximum Reynolds number Re_D_max: {Re_D_max:.5}")

# Constants for Nusselt number calculation
C1 = 0.27
m = 0.63
Pr_s = 0.685

# Calculate average Nusselt number
Nu_D = C1 * (Re_D_max**m) * (Pr**0.36) * ((Pr/Pr_s)**0.25)
print(f"Average Nusselt number Nu_D: {Nu_D:.5}")

# Calculate convective heat transfer coefficient
h = (k * Nu_D) / D
print(f"Convective heat transfer coefficient h: {h:.5} W/m^2.K")

# Calculate outlet temperature
T_s_K = T_s + 273.15  # Convert to Kelvin
T_i_K = T_i + 273.15  # Convert to Kelvin
exp_term = math.exp(- (math.pi * D * N * h) / (rho * U_i * N_T * S_T * c_p * 1000))  # c_p in J/kg.K
T_o_K = T_s_K - (T_s_K - T_i_K) * exp_term
T_o = T_o_K - 273.15  # Convert back to Celsius
print(f"Outlet temperature T_o: {T_o:.5} °C")

# Calculate log mean temperature difference (ΔT_lm)
delta_T1 = T_s - T_i
delta_T2 = T_s - T_o
delta_T_lm = (delta_T1 - delta_T2) / math.log(delta_T1 / delta_T2)
print(f"Log mean temperature difference ΔT_lm: {delta_T_lm:.5} °C")

# Calculate heat transfer rate per unit length (q')
q_prime = N * (h * math.pi * D * delta_T_lm)
print(f"Heat transfer rate per unit length q': {q_prime:.5} W/m")

# Calculate total heat transfer rate (q)
q = q_prime * L
print(f"Total heat transfer rate q: {q:.5} W")

# %% Part c
# Parameters for radiation problem
epsilon1 = epsilon2 = 0.95
epsilon3 = 0.9
T3 = 200 + 273.15  # Convert to Kelvin
sigma = 5.67e-8  # Stefan-Boltzmann constant

# Areas
A1 = A2 = math.pi * D**2 / 4
A3 = math.pi * D * L

# View factors
F13 = F23 = 0.985
F31 = F32 = 0.0625
F33 = 0.875

# Emissive powers
E_b3 = sigma * T3**4

q3 = q / N  # Heat transfer rate per tube
print(f"Heat transfer rate q3: {q3:.5} W")

# Define the system of equations
def equations(vars):
    T1 = vars
    E_b1 = sigma * T1**4
    J3 = E_b3 + q3 * (1 - epsilon3) / (epsilon3 * A3)
    eq1 = (E_b1 - J3) / ((1 - epsilon3) / (epsilon3 * A3) + 1 / (A1 * F13)) - q3 / 2
    return eq1

# Solve the system of equations
T1 = scipy.optimize.fsolve(equations, T3).flatten()[0]
T1_C = T1 - 273.15  # Convert back to Celsius

print(f"Temperature T1: {T1_C:.5} °C")

# %%
