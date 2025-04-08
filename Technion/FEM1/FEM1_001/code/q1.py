import numpy as np
import matplotlib.pyplot as plt
from scipy.integrate import quad
import sympy as sp
from scipy.linalg import solve

plt.rcParams['text.usetex'] = True
plt.rcParams['text.latex.preamble'] = r'\usepackage{amsmath}'

# Define the analytical solution
def analytical_solution(x):
    return -x + (1.0001)/(np.log(3) - np.log(2)) * np.log((x+2)/2)

# Define symbolic variable for differentiation
x_sym = sp.Symbol('x')

# Generate symbolic Lagrange polynomials and their derivatives
def generate_lagrange_basis(n):
    nodes = np.linspace(0, 1, n)
    basis = []
    d_basis = []
    
    for i in range(n):
        phi = 1
        for j in range(n):
            if i != j:
                phi *= (x_sym - nodes[j]) / (nodes[i] - nodes[j])
        basis.append(phi)
        d_basis.append(sp.diff(phi, x_sym))
    
    # Convert to callable functions
    phi_funcs = [sp.lambdify(x_sym, phi, 'numpy') for phi in basis]
    dphi_funcs = [sp.lambdify(x_sym, dphi, 'numpy') for dphi in d_basis]
    
    return phi_funcs, dphi_funcs, nodes

# Build the Galerkin system using the weak form with 3-point Gauss integration
def build_galerkin_system(n):
    phi_funcs, dphi_funcs, nodes = generate_lagrange_basis(n)
    
    K = np.zeros((n, n))
    F = np.zeros(n)
    
    # 3-point Gaussian quadrature points and weights for [0,1]
    sqrt_3_5 = np.sqrt(3/5)
    gauss_points = np.array([0.5 - 0.5*sqrt_3_5, 0.5, 0.5 + 0.5*sqrt_3_5])
    gauss_weights = np.array([5/18, 8/18, 5/18])
    
    # Compute stiffness matrix using 3-point Gaussian quadrature
    for i in range(n):
        # Force vector - RHS is 1
        F[i] = sum(gauss_weights * np.array([phi_funcs[i](x) for x in gauss_points]))
        
        for j in range(n):
            # Stiffness matrix using weak form (integration by parts)
            integrand_vals = [(x + 2) * dphi_funcs[i](x) * dphi_funcs[j](x) for x in gauss_points]
            K[i, j] = sum(gauss_weights * np.array(integrand_vals))
    
    # Apply boundary conditions
    K[0, :] = 0
    K[0, 0] = 1
    F[0] = 0
    
    K[-1, :] = 0
    K[-1, -1] = 1
    F[-1] = 1e-4
    
    return K, F, phi_funcs

# Solve the system
def solve_galerkin(n):
    K, F, phi_funcs = build_galerkin_system(n)
    a = solve(K, F, )
    return a, phi_funcs

# Evaluate solution at points
def evaluate_solution(x, coefficients, phi_funcs):
    u = np.zeros_like(x)
    for i in range(len(coefficients)):
        u += coefficients[i] * phi_funcs[i](x)
    return u

# Calculate error
def calculate_error(u_approx, u_exact):
    return np.sqrt(np.mean((u_approx - u_exact)**2))

# Main function
def main():
    x = np.linspace(0, 1, 1000)
    u_exact = analytical_solution(x)
    
    plt.figure(figsize=(6, 4))
    plt.plot(x, u_exact, 'k-', linewidth=3, label='Analytical Solution')
    
    # Use default colors
    colors = plt.rcParams['axes.prop_cycle'].by_key()['color']
    markers = ['o', 's', '^']
    
    for idx, n in enumerate([3, 4]):
        coefficients, phi_funcs = solve_galerkin(n)
        u_approx = evaluate_solution(x, coefficients, phi_funcs)
        
        # Calculate error
        # error = calculate_error(u_approx, u_exact)
        
    
        # plt.plot(x, u_approx, f'-.', linewidth=1.5, 
        #          label=f'Galerkin N={n} (RMSE={error:.2e})')
        plt.plot(x, u_approx, f'-.', linewidth=1.5, label=f'Galerkin N={n}')
        
        # Plot nodes
        nodes = np.linspace(0, 1, n)
        node_values = evaluate_solution(nodes, coefficients, phi_funcs)
        plt.plot(nodes, node_values, markers[idx], color=colors[idx])
    
    plt.xlabel(r'$x$', fontsize=12)
    plt.ylabel(r'$u(x)$', fontsize=12)
    plt.title(r'Solution of $-\dfrac{\mathrm{d}}{\mathrm{d}x}\left( (x+2) \dfrac{\mathrm{d}u}{\mathrm{d}x} \right)=1$ using Galerkin Method', fontsize=14)
    plt.legend()
    plt.grid(True)
    plt.tight_layout()
    
    # Save figure with explicit path and error handling
    try:
        import os
        save_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'galerkin_solution.png')
        plt.savefig(save_path, dpi=300)
        print(f"Figure saved successfully to: {save_path}")
    except Exception as e:
        print(f"Error saving figure: {e}")
    
    plt.show()

if __name__ == "__main__":
    main()
