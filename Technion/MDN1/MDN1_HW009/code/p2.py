import numpy as np

# %% Question 4

# Given data
N1 = 60
N2 = 10
phi = np.radians(20)  # Convert angle to radians

# Calculate m_G
m_G = N1 / N2

# Calculate N_P_min
N_P_min = (2 / ((1 + 2 * m_G) * np.sin(phi)**2)) * (m_G + np.sqrt(m_G**2 + (1 + 2 * m_G) * np.sin(phi)**2))
print(f'N_P_min = {N_P_min:.5}')

# %% Question 5

# Given data
H = 196  # W
d2 = 10  # mm
n2 = 2400  # rpm
d3 = 14  # mm
n3 = 400  # rpm
N3 = 10 # teeth

# Calculate W_t for gear 2
W_t_2 = (60000 * H) / (np.pi * d2 * n2)  # N
print(f'W_t_2 = {W_t_2:.5} N')

# Calculate m_B for gear 2
N_P_2 = N2
m_B_2 = (N_P_2 / 2 - 1.25) / 2.25
print(f'm_B_2 = {m_B_2:.5}')

# Calculate V for gear 2
V_2 = (np.pi * d2 * n2) / 60000  # m/s
print(f'V_2 = {V_2:.5} m/s')

# Calculate V for gear 3
V_3 = (np.pi * d3 * n3) / 60000  # m/s
print(f'V_3 = {V_3:.5} m/s')

# Calculate W_t for gear 3
W_t_3 = (60000 * H) / (np.pi * d3 * n3)  # N
print(f'W_t_3 = {W_t_3:.5} N')

# Calculate m_B for gear 3
N_P_3 = N3  # Assuming N3 is the number of teeth for gear 3
m_B_3 = (N_P_3 / 2 - 1.25) / 2.25
print(f'm_B_3 = {m_B_3:.5}')

# Given data for K_v calculation
Q_v = 6

# Calculate A and B
B = (12 - Q_v)**(2/3) / 4
A = 50 + 56 * (1 - B)

print(f'B = {B:.5}')
print(f'A = {A:.5}')

# Calculate K_v for gear 2
K_v_2 = ((A + np.sqrt(200 * V_2)) / A)**B
print(f'K_v_2 = {K_v_2:.5}')

# Calculate K_v for gear 3
K_v_3 = ((A + np.sqrt(200 * V_3)) / A)**B
print(f'K_v_3 = {K_v_3:.5}')

# Given data for S_t calculation
H_B = 300

# Calculate S_t
S_t = 0.533 * H_B + 88.3  # MPa
print(f'S_t = {S_t:.5} MPa')

# Given data for Y_Z calculation
R = 0.95

# Calculate Y_Z
Y_Z = 0.658 - 0.0759 * np.log(1 - R)
print(f'Y_Z = {Y_Z:.5}')

# Given data for N calculation
L = 365 * 30.0  # hours
q = 1  # Assuming q = 1

# Calculate N for gear 2
N_2 = n2 * 60 * L * q
print(f'N_2 = {N_2:.5}')

# Calculate N for gear 3
N_3 = n3 * 60 * L * q
print(f'N_3 = {N_3:.5}')

# Calculate Y_N for gear 2
Y_N_2 = 1.3558 * N_2**(-0.0178)
print(f'Y_N_2 = {Y_N_2:.5}')

# Calculate Y_N for gear 3
Y_N_3 = 1.3558 * N_3**(-0.0178)
print(f'Y_N_3 = {Y_N_3:.5}')

Y_theta = 1
K_s = 1
K_H = 1.2
K_B = 1
K_o = 1
S_F = 1

Y_JP = 0.24

m2 = 1
m3 = 1.4

# Calculate sigma_b_all for gear 2
sigma_b_all_2 = (S_t / S_F) * (Y_N_2 / (Y_theta * Y_Z))  # MPa
print(f'sigma_b_all_2 = {sigma_b_all_2:.5} MPa')

# Calculate sigma_b_all for gear 3
sigma_b_all_3 = (S_t / S_F) * (Y_N_3 / (Y_theta * Y_Z))  # MPa
print(f'sigma_b_all_3 = {sigma_b_all_3:.5} MPa')

# Calculate the minimal b for gear 2
b_min_2 = W_t_2 * K_o * K_v_2 * K_s * K_H * K_B / (sigma_b_all_2 * Y_JP * m2)  # mm
print(f'b_min_2 = {b_min_2:.5} mm')

# Calculate the minimal b for gear 3
b_min_3 = W_t_3 * K_o * K_v_3 * K_s * K_H * K_B / (sigma_b_all_3 * Y_JP * m3)  # mm
print(f'b_min_3 = {b_min_3:.5} mm')