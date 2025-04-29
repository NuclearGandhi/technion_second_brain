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

def analytical_solution(x, alpha=1.0, sigma=0.05, qbar=0.05):
    """
    Analytical solution for the normalized fin problem:
    -theta''(x) + alpha*theta(x) = 0
    -theta'(0) = qbar
    theta'(1) + sigma*theta(1) = 0
    """
    m = np.sqrt(alpha)
    denom = m * np.sinh(m) + sigma * np.cosh(m)
    num = np.cosh(m * (1 - x)) + (sigma / m) * np.sinh(m * (1 - x))
    return (qbar / m) * num / denom

def fem_solution(N, alpha=1.0, sigma=0.05, qbar=0.05):
    """
    FEM solution for the normalized fin problem with N elements
    """
    h = 1.0 / N
    nodes = np.linspace(0, 1, N+1)
    K = np.zeros((N+1, N+1))
    M = np.zeros((N+1, N+1))
    # Assembly
    for e in range(N):
        x0 = nodes[e]
        x1 = nodes[e+1]
        he = x1 - x0
        # Local stiffness (from theta' * theta')
        K_local = (1/he) * np.array([[1, -1], [-1, 1]])
        # Local mass (from alpha * theta * theta)
        M_local = (he/6) * np.array([[2, 1], [1, 2]])
        # Assemble
        K[e:e+2, e:e+2] += K_local
        M[e:e+2, e:e+2] += M_local
    # Global system: (K + alpha*M) a = F
    A = K + alpha * M
    F = np.zeros(N+1)
    # Neumann BC at x=0: -theta'(0) = qbar
    F[0] += qbar
    # Robin BC at x=1: theta'(1) + sigma*theta(1) = 0
    # This adds sigma to the last diagonal entry
    A[-1, -1] += sigma
    # Solve
    a = solve(A, F)
    return nodes, a

# Get the directory of the current script file
script_dir = os.path.dirname(os.path.abspath(__file__))

plt.figure(figsize=(600/100, 400/100), dpi=100)

# Analytical solution
x_exact = np.linspace(0, 1, 200)
y_exact = analytical_solution(x_exact)
plt.plot(x_exact, y_exact, 'k--', label=r'Analytical', linewidth=4)

# FEM solutions
for N in [2, 12]:
    nodes, u = fem_solution(N)
    plt.plot(nodes, u, 'o-', label=fr'FEM ($N={N}$)', markersize=5)

plt.xlabel(r'$x$', fontsize=14)
plt.ylabel(r'$\theta(x)$', fontsize=14)
plt.title(r'Comparison of Analytical and FEM Solutions', fontsize=15)
plt.legend(fontsize=12)
plt.grid(True)
plt.tight_layout()

output_path = os.path.join(script_dir, 'fin-comparison.png')
plt.savefig(output_path, dpi=100, bbox_inches='tight')
plt.show()
