# %% Question 1

# Given data
m = 5  # module in mm
N_G = 31  # number of teeth on the gear

# Calculate the diameter of the gear
d_G = m * N_G

# Calculate the radius of the gear
r_G = d_G / 2

# Display the result
print(f'The radius of the gear is {r_G:.5} mm')

# %% Question 2

# Given data
d_P = 100  # diameter of the pinion in mm

# Calculate the addendum (height of the tooth above the pitch circle)
a = m

# Calculate the radius of the addendum circle
r_add = (d_P / 2) + a

# Display the result
print(f'The radius of the addendum circle is {r_add:.5} mm')

# %% Question 3

import math

# Given data
phi = math.radians(20)  # pressure angle in radians
r_P = d_P / 2  # radius of the pinion
C = r_P + r_G  # distance between gear centers

# Calculate the length of the line of action
L_ab = math.sqrt((r_G + a)**2 - (r_G * math.cos(phi))**2) + \
       math.sqrt((r_P + a)**2 - (r_P * math.cos(phi))**2) - \
       C * math.sin(phi)

# Display the result
print(f'The length of the line of action is {L_ab:.5} mm')

# %% Question 4

# Calculate the circular pitch
p_c = m * math.pi

# Calculate the contact ratio
m_c = L_ab / (p_c * math.cos(phi))

# Display the result
print(f'The circular pitch is {p_c:.5} mm')
print(f'The contact ratio is {m_c:.5}')

# %% Question 5

# Calculate the approximate contact ratio
m_c_approx = 1.88 - 3.2 * (1 / N_G + 1 / (d_P / m))

# Display the result
print(f'The approximate contact ratio is {m_c_approx:.5}')


