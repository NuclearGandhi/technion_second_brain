import numpy as np

# %% Parameters

# Given data
D = 0.05  # m
t = 0.005  # m
T_s = 350  # K
T_g = 750  # K
h_g = 30  # W/m^2.K
k = 400  # W/m.K
h = 30  # W/m^2.K
N = 4

# %% Part a

# Calculate the characteristic length Lc
Lc = D / 2

# Calculate the fin efficiency eta_f
m = np.sqrt(2 * h / (k * t))
eta_f = np.tanh(m * Lc) / (m * Lc)

# Calculate the overall efficiency eta_o'
A_f_prime = 2 * Lc
A_t_prime = 4 * A_f_prime + np.pi * D - 4 * t
eta_o_prime = 1 - (N * A_f_prime / A_t_prime) * (1 - eta_f)

# Calculate the total heat transfer rate q'_t
q_prime_t = eta_o_prime * h * A_t_prime * (T_g - T_s)

print(f"Characteristic length Lc: {Lc:.5} m")
print(f"m: {m:.5}")
print(f"Fin efficiency eta_f: {eta_f:.5}")
print(f"Overall efficiency eta_o': {eta_o_prime:.5}")
print(f"Total heat transfer rate q'_t: {q_prime_t:.5} W/m")
