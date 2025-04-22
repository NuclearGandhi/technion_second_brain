import numpy as np
import matplotlib.pyplot as plt
from scipy.linalg import solve
import os

# Set up matplotlib to use LaTeX formatting
plt.rcParams.update({
    "text.usetex": True,
    "font.family": "serif",
    "font.serif": ["Computer Modern Roman"]
})

def exact_solution(x):
    """
    Analytical solution to the ODE:
    -d/dx[(x+2)*du/dx] = 1, 0<x<2
    u(0) = 0
    (x+2)*du/dx|x=2 = 0
    
    Integrating once: -(x+2)*du/dx = x + C1
    At x=2: -(2+2)*du/dx|x=2 = 0 = 2 + C1 => C1 = -2
    So: -(x+2)*du/dx = x-2
    Thus: du/dx = -(x-2)/(x+2)
    
    Integrating again: u = ∫(-(x-2)/(x+2)) dx = -x + 4*ln(x+2) + C2
    At x=0: u(0) = 0 = 0 + 4*ln(2) + C2 => C2 = -4*ln(2)
    
    Final solution: u(x) = -x + 4*ln(x+2) - 4*ln(2)
    """
    return -x + 4*np.log(x+2) - 4*np.log(2)

def fem_solution(N):
    """
    FEM solution with N elements
    """
    # Element size
    h = 2.0 / N
    
    # Node coordinates
    nodes = np.linspace(0, 2, N+1)
    
    # Global stiffness matrix and mass matrix
    K = np.zeros((N+1, N+1))
    M = np.zeros((N+1, N+1))
    
    # Assembly process
    for e in range(N):
        # Element nodes
        x_e = nodes[e]
        x_e1 = nodes[e+1]
        
        # Local stiffness matrix
        K_local = ((x_e + x_e1)/2 + 2) * np.array([[1, -1], [-1, 1]]) / h
        
        # Local mass matrix (for load vector)
        M_local = h/6 * np.array([[2, 1], [1, 2]])
        
        # Assembly to global matrices
        K[e:e+2, e:e+2] += K_local
        M[e:e+2, e:e+2] += M_local
    
    # Force vector (constant force = 1)
    f = np.ones(N+1)
    
    # Apply load vector
    F = M @ f
    
    # Apply boundary conditions
    # u(0) = 0 (Dirichlet)
    K_reduced = K[1:, 1:]
    F_reduced = F[1:] - K[1:, 0] * 0  # u(0) = 0
    
    # Solve the system
    u_reduced = solve(K_reduced, F_reduced)
    
    # Full solution vector
    u = np.zeros(N+1)
    u[1:] = u_reduced
    
    return nodes, u

# Get the directory of the current script file
script_dir = os.path.dirname(os.path.abspath(__file__))

# Plot the solutions
plt.figure(figsize=(600/100, 400/100), dpi=100)

# Exact solution
x_exact = np.linspace(0, 2, 100)
y_exact = exact_solution(x_exact)
plt.plot(x_exact, y_exact, 'k-', label=r'$\mathrm{Exact\ Solution}$', linewidth=2)

# FEM solutions
for N in [1, 2, 3]:
    nodes, u = fem_solution(N)
    plt.plot(nodes, u, 'o-', label=r'$\mathrm{FEM}\ (N=%d)$' % N, markersize=8)

plt.xlabel(r'$x$', fontsize=14)
plt.ylabel(r'$u(x)$', fontsize=14)
plt.title(r'$\mathrm{Comparison\ of\ FEM\ Solutions}$', fontsize=15)
plt.legend(fontsize=12)
plt.grid(True)
plt.tight_layout()

# Save the figure in the same directory as this script
output_path = os.path.join(script_dir, 'fem-comparison.png')
plt.savefig(output_path, dpi=100, bbox_inches='tight')
plt.show()

# Print numerical values for comparison
print(r"x\tExact\t\tN=1\t\tN=2\t\tN=3")
print("-" * 60)

for i, x in enumerate(np.linspace(0, 2, 5)):
    exact = exact_solution(x)
    
    # Interpolate FEM solutions at x
    fem1_nodes, fem1_u = fem_solution(1)
    fem2_nodes, fem2_u = fem_solution(2)
    fem3_nodes, fem3_u = fem_solution(3)
    
    # Simple linear interpolation
    def interpolate(nodes, u, x):
        if x <= nodes[0]:
            return u[0]
        if x >= nodes[-1]:
            return u[-1]
        for i in range(len(nodes)-1):
            if nodes[i] <= x <= nodes[i+1]:
                t = (x - nodes[i]) / (nodes[i+1] - nodes[i])
                return (1-t) * u[i] + t * u[i+1]
        return None
    
    fem1 = interpolate(fem1_nodes, fem1_u, x)
    fem2 = interpolate(fem2_nodes, fem2_u, x)
    fem3 = interpolate(fem3_nodes, fem3_u, x)
    
    print(f"{x:.1f}\t{exact:.6f}\t{fem1:.6f}\t{fem2:.6f}\t{fem3:.6f}")