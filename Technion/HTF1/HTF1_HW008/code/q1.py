import math

# %% Part a

# Given data
T_c_i = 25 + 273.15  # Convert to Kelvin
T_c_o = 80 + 273.15  # Convert to Kelvin
rho = 987  # kg/m^3
u = 0.8  # m/s
d = 0.01  # m
c_p_c = 4182  # J/kg.K
N_t = 150  # Number of tubes

# Calculate q
A_t = (math.pi / 4) * d**2 * N_t
q = rho * u * A_t * c_p_c * (T_c_o - T_c_i)

# Given additional data
T_b = 100 + 273.15  # Convert to Kelvin
h_o = 5000  # W/m^2.K
mu = 528e-6  # Pa.s
k_f = 645e-3  # W/m.K
Pr = 3.42
N_p = 4  # Number of passes

# Calculate Reynolds number
Re_D = (rho * u * d) / mu

# Check if flow is turbulent
if Re_D > 2300:
    # Calculate Nusselt number for turbulent flow
    Nu_D = 0.023 * Re_D**(4/5) * Pr**0.4
else:
    raise ValueError("Flow is not turbulent")

# Calculate internal convection coefficient
h_i = (k_f * Nu_D) / d

# Calculate overall heat transfer coefficient
U = (h_i * h_o) / (h_i + h_o)

# Calculate log mean temperature difference (assuming counterflow)
delta_T_lm_CF = ((T_b - T_c_o) - (T_b - T_c_i)) / math.log((T_b - T_c_o) / (T_b - T_c_i))

# Calculate length of the tubes
L = q / (U * math.pi * d * N_t * delta_T_lm_CF)

print(f"q: {q:.5} W")
print(f"h_i: {h_i:.5} W/m^2.K")
print(f"U: {U:.5} W/m^2.K")
print(f"delta_T_lm_CF: {delta_T_lm_CF:.5} K")
print(f"L: {L:.5} m")

# %% Part b
# Given updated data
u_new = 0.5  # m/s

# Recalculate Reynolds number with new velocity
Re_D_new = (rho * u_new * d) / mu

# Check if flow is turbulent
if Re_D_new > 2300:
    # Calculate Nusselt number for turbulent flow
    Nu_D_new = 0.023 * Re_D_new**(4/5) * Pr**0.4
else:
    raise ValueError("Flow is not turbulent")

# Calculate new internal convection coefficient
h_i_new = (k_f * Nu_D_new) / d

# Calculate new overall heat transfer coefficient
U_new = (h_i_new * h_o) / (h_i_new + h_o)

# Calculate T_c,o
T_h = T_b  # Assuming T_h is the same as T_b
T_c_o_new = T_h - (T_h - T_c_i) * math.exp(-U_new * math.pi * d * N_t * L / (rho * u_new * A_t * c_p_c))

print(f"Re_D_new: {Re_D_new:.5}")
print(f"h_i_new: {h_i_new:.5} W/m^2.K")
print(f"U_new: {U_new:.5} W/m^2.K")
print(f"T_c_o_new: {T_c_o_new - 273.15:.5} °C")  # Convert back to Celsius for output


