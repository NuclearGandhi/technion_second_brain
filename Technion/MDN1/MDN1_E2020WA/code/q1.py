import numpy as np

# %% Part 1.1

T_RC = 25  # N.m
K = 0.3
d = 8  # mm
F_i = T_RC / (K * d)
print(f"F_i = {F_i:.5} kN")

# %% Part 1.2

A_d = np.pi * (d ** 2) / 4  # mm^2
A_t = 36.6  # mm^2 from table 8-1
E_b = 207  # GPa
l_t = 12  # mm
l_d = 6  # mm

k_b = (A_d * A_t * E_b) / (A_d * l_t + A_t * l_d)
print(f"k_b = {k_b:.5} kN/mm")

# %% Part 1.3

E_m = 44.8  # GPa
l = 18  # mm

k_m = (0.5774 * np.pi * E_m * d) / (2 * np.log(5 * (0.5774 * l + 0.5 * d) / (0.5774 * l + 2.5 * d)))
print(f"k_m = {k_m:.5} kN/mm")


C = k_b / (k_b + k_m)
print(f"C = {C:.5}")

T_z_max = 200  # N.m
N = 3
r_1 = 75 / 2  # mm
A_r = 32.8  # mm^2

F_G_1_max = T_z_max / (N * r_1)
print(f"F_G_1_max = {F_G_1_max:.5} kN")

tau_1_max = F_G_1_max / A_r
print(f"tau_1_max = {tau_1_max:.5} GPa")

# %% Part 1.5

C = 0.6
F_i = 11.5  # kN
F_z_max = 0.850  # kN
D_o = 530  # mm

P_T_1_max = F_z_max / N
y_1 = 87.5  # mm
y_2 = y_3 = 31.25  # mm
sum_y_j_squared = y_1**2 + 2 * y_2**2

P_M_1_max = (F_z_max * (D_o / 2) * y_1) / (sum_y_j_squared)

print(f"P_T_1_max = {P_T_1_max:.5} kN")
print(f"P_M_1_max = {P_M_1_max:.5} kN")

P_1_max = P_T_1_max + P_M_1_max
print(f"P_1_max = {P_1_max:.5} kN")

F_b1 = F_i + C * P_1_max
print(f"F_b1 = {F_b1:.5} kN")

# %% Part 1.6

F_1_max = 2  # kN
F_b1_max = 14.2  # kN
S_e = 187e-3  # GPa
S_ut = 830e-3  # GPa

tau_a = tau_m = F_1_max / (2 * A_r)
print(f"tau_a = tau_m = {tau_a:.5} MPa")

F_m = (F_b1_max + F_i) / 2
F_a = (F_b1_max - F_i) / 2

print(f"F_m = {F_m:.5} kN")
print(f"F_a = {F_a:.5} kN")

sigma_m = F_m / A_t
sigma_a = F_a / A_t

print(f"sigma_m = {sigma_m:.5} MPa")
print(f"sigma_a = {sigma_a:.5} MPa")

sigma_m_prime = np.sqrt(sigma_m**2 + 3 * tau_m**2)
sigma_a_prime = np.sqrt((sigma_a / 0.85)**2 + 3 * tau_a**2)

print(f"sigma_m_prime = {sigma_m_prime:.5} MPa")
print(f"sigma_a_prime = {sigma_a_prime:.5} MPa")

sigma_i = F_i / A_t
print(f"sigma_i = {sigma_i:.5} MPa")

n_f = (S_e * (S_ut - sigma_i)) / (S_e * (sigma_m_prime-sigma_i) + S_ut * sigma_a_prime)
print(f"n_f = {n_f:.5}")
# %%
