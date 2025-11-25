import numpy as np
import matplotlib.pyplot as plt
from scipy.optimize import brentq

plt.rcParams["text.usetex"] = False
plt.rcParams["font.size"] = 11
plt.rcParams["lines.linewidth"] = 2

OUTPUT_DIR = "content/Technion/MCS1/MCS1_004/code/"

def save_plot(fig, filename):
    path = OUTPUT_DIR + filename
    plt.savefig(path, dpi=150, bbox_inches="tight")
    print(f"Saved {path}")
    plt.close(fig)

def plot_parallel_plate_voltage():
    # 1. Potential energy vs y for different V
    y = np.linspace(-0.9, 0.9, 500)
    V_PI = np.sqrt(8/27)
    
    V_values = [0, 0.2, 0.4, V_PI, 0.6, 0.7]
    
    fig1, ax1 = plt.subplots(figsize=(8, 6))
    
    for V in V_values:
        psi = 0.5 * y**2 - 0.5 * V**2 / (1 - y)
        
        style = "-"
        color = "b" # Default color
        alpha = 0.6
        label = None
        
        if np.isclose(V, V_PI):
            label = f"$\\tilde{{V}} = {V:.2f}$ (Pull-in)"
            color = "r"
            alpha = 1.0
        
        ax1.plot(y, psi, linestyle=style, color=color, label=label, alpha=alpha)

    ax1.set_xlabel(r"$\tilde{y}$")
    ax1.set_ylabel(r"$\tilde{\psi}$")
    ax1.set_title(r"Potential Energy $\tilde{\psi}$ vs $\tilde{y}$ (Parallel Plate, Voltage)")
    ax1.set_xlim([0, 1])
    ax1.set_ylim([-0.5, 0.5])
    
    ax1.grid(True, alpha=0.3)
    ax1.legend(loc='upper right')
    save_plot(fig1, "parallel_plate_voltage_potential.png")

    # 2. Equilibrium curve V vs y
    y_eq = np.linspace(0, 1, 500)
    V_sq = 2 * y_eq * (1 - y_eq)**2
    V_eq = np.sqrt(V_sq)
    
    y_stable = y_eq[y_eq <= 1/3]
    V_stable = V_eq[y_eq <= 1/3]
    y_unstable = y_eq[y_eq >= 1/3]
    V_unstable = V_eq[y_eq >= 1/3]

    fig2, ax2 = plt.subplots(figsize=(6, 5))
    ax2.plot(y_stable, V_stable, 'b-', label='Stable')
    ax2.plot(y_unstable, V_unstable, 'b--', label='Unstable')
    ax2.plot(1/3, V_PI, 'ro', label='Pull-in')
    
    ax2.set_xlabel(r"$\tilde{y}$")
    ax2.set_ylabel(r"$\tilde{V}$")
    ax2.set_title("Equilibrium Curve (Parallel Plate, Voltage)")
    ax2.grid(True, alpha=0.3)
    ax2.legend()
    save_plot(fig2, "parallel_plate_voltage_equilibrium.png")

def plot_symmetric_parallel_plate_voltage():
    # 1. Potential energy
    y = np.linspace(-0.9, 0.9, 500)
    V_values = [0, 0.2, 0.5, 0.8, 1.0, 1.2, 1.4] # Added more values
    
    fig1, ax1 = plt.subplots(figsize=(8, 6))
    for V in V_values:
        psi = 0.5 * y**2 - 0.5 * V**2 / (1 - y**2)
        color = "b"
        alpha = 0.6
        label = None
        if V == 1.0:
            color = "r"
            label = f"$\\tilde{{V}} = {V:.1f}$ (Bifurcation)"
            alpha = 1.0
            
        ax1.plot(y, psi, label=label, color=color, alpha=alpha)
        
    ax1.set_xlabel(r"$\tilde{y}$")
    ax1.set_ylabel(r"$\tilde{\psi}$")
    ax1.set_title(r"Potential Energy (Symmetric Parallel Plate, Voltage)")
    ax1.set_ylim([-1, 1])
    ax1.grid(True, alpha=0.3)
    ax1.legend()
    save_plot(fig1, "symmetric_parallel_plate_voltage_potential.png")

    # 2. Equilibrium curve
    V_range = np.linspace(0, 1, 200)
    fig2, ax2 = plt.subplots(figsize=(6, 5))
    ax2.plot(V_range, np.zeros_like(V_range), 'b-', label='Stable (y=0)')
    y_unstable_pos = np.sqrt(1 - V_range)
    y_unstable_neg = -np.sqrt(1 - V_range)
    ax2.plot(V_range, y_unstable_pos, 'b--', label='Unstable')
    ax2.plot(V_range, y_unstable_neg, 'b--')
    V_unstable_origin = np.linspace(1, 1.5, 50)
    ax2.plot(V_unstable_origin, np.zeros_like(V_unstable_origin), 'b--', alpha=0.5)

    ax2.set_xlabel(r"$\tilde{V}$")
    ax2.set_ylabel(r"$\tilde{y}$")
    ax2.set_title("Equilibrium Curve (Symmetric Parallel Plate, Voltage)")
    ax2.grid(True, alpha=0.3)
    ax2.legend()
    save_plot(fig2, "symmetric_parallel_plate_voltage_equilibrium.png")

def plot_symmetric_parallel_plate_charge():
    # Potential
    y = np.linspace(-0.9, 0.9, 500)
    Q_values = [0, 0.2, 0.5, 0.8, 1.0, 1.2, 1.4] # Added more values
    
    fig1, ax1 = plt.subplots(figsize=(8, 6))
    for Q in Q_values:
        psi = 0.5 * y**2 + 0.5 * (1 - y**2) * Q**2
        color = "b"
        alpha = 0.6
        label = None
        if Q == 1.0:
            color = "r"
            label = f"$\\tilde{{Q}} = {Q:.1f}$ (Neutral)"
            alpha = 1.0
            
        ax1.plot(y, psi, label=label, color=color, alpha=alpha)

    ax1.set_xlabel(r"$\tilde{y}$")
    ax1.set_ylabel(r"$\tilde{\psi}$")
    ax1.set_title(r"Potential Energy (Symmetric Parallel Plate, Charge)")
    # Bounds: -0.5 < psi < 1.5
    ax1.set_xlim([-1, 1])
    ax1.set_ylim([-0.5, 1.5])
    ax1.grid(True, alpha=0.3)
    ax1.legend()
    save_plot(fig1, "symmetric_parallel_plate_charge_potential.png")

def plot_symmetric_parallel_plate_charge_equilibrium():
    fig, ax = plt.subplots(figsize=(6, 5))
    Q_stable = np.linspace(0, 1, 100)
    ax.plot(Q_stable, np.zeros_like(Q_stable), 'b-', label='Stable (y=0)')
    y_neutral = np.linspace(-0.99, 0.99, 100)
    ax.plot(np.ones_like(y_neutral), y_neutral, 'r-', label='Neutral (Q=1)')
    Q_unstable = np.linspace(1, 1.5, 50)
    ax.plot(Q_unstable, np.zeros_like(Q_unstable), 'b--', label='Unstable (y=0)')
    ax.set_xlabel(r"$\tilde{Q}$")
    ax.set_ylabel(r"$\tilde{y}$")
    ax.set_title("Equilibrium Curve (Symmetric Parallel Plate, Charge)")
    ax.set_xlim([0, 1.5])
    ax.set_ylim([-1, 1])
    ax.grid(True, alpha=0.3)
    ax.legend()
    save_plot(fig, "symmetric_parallel_plate_charge_equilibrium.png")

def plot_one_sided_comb_equilibrium():
    x = np.linspace(0, 1, 100)
    y_circle = np.sqrt(1 - x**2)
    
    fig, ax = plt.subplots(figsize=(6, 6))
    
    # y=0 solution: Stable for x <= 1, Unstable for x > 1
    x_stable = np.linspace(0, 1, 100)
    x_unstable = np.linspace(1, 1.5, 50)
    
    ax.plot(x_stable, np.zeros_like(x_stable), 'b-', label='Stable (y=0)')
    ax.plot(x_unstable, np.zeros_like(x_unstable), 'b--', label='Unstable (y=0)') # Dashed for x > 1
    
    # Circle solution - unstable
    ax.plot(x, y_circle, 'b--', label='Unstable')
    ax.plot(x, -y_circle, 'b--')
    
    ax.set_xlabel(r"$\tilde{x}$")
    ax.set_ylabel(r"$\tilde{y}$")
    ax.set_title("Equilibrium (One-sided Comb, $\\tilde{O}=0, \\tilde{k}=2$)")
    
    ax.set_xlim([0, 1.5])
    ax.set_ylim([-1.1, 1.1])
    ax.grid(True, alpha=0.3)
    ax.legend()
    ax.set_aspect('equal')
    save_plot(fig, "one_sided_comb_equilibrium.png")

def plot_double_sided_comb_equilibrium():
    y = np.linspace(0, 0.99, 200)
    u = 1 - y**2
    
    k_values = [1.1, 2, 3, 4, 6, 10]
    
    # Stack plots vertically: 2 rows, 1 column
    fig, (ax1, ax2) = plt.subplots(2, 1, figsize=(6, 10))
    
    # Plot (a): Different k values
    for k in k_values:
        numerator = k * u**2 - 1
        denominator = 2 * u + u**2
        x_sq = numerator / denominator
        
        valid = x_sq >= 0
        if np.any(valid):
            x_val = np.sqrt(x_sq[valid])
            y_val = y[valid]
            
            # Plot 4 quadrants
            ax1.plot(x_val, y_val, 'b--', linewidth=1)
            ax1.plot(-x_val, y_val, 'b--', linewidth=1)
            ax1.plot(x_val, -y_val, 'b--', linewidth=1)
            ax1.plot(-x_val, -y_val, 'b--', linewidth=1)
            
            if k in [1.1]:
                ax1.text(x_val[0], y_val[0]+0.1, f"k={k}")
                
            if k in [10]:
                ax1.text(0.2, 0.9, f"k={k}")

    ax1.axhline(0, color='b', linestyle='-', label='Stable (y=0)')
    
    ax1.set_xlabel(r"$\tilde{x}$")
    ax1.set_ylabel(r"$\tilde{y}$")
    ax1.set_title("(a) Various $\\tilde{k}$")
    ax1.set_xlim([-1, 1])
    ax1.set_ylim([-1, 1])
    ax1.grid(True, alpha=0.3)

    # Plot (b): k=4 case
    k = 4
    numerator = k * u**2 - 1
    denominator = 2 * u + u**2
    x_sq = numerator / denominator
    valid = x_sq >= 0
    x_val = np.sqrt(x_sq[valid])
    y_val = y[valid]
    
    # 4 quadrants
    ax2.plot(x_val, y_val, 'b--', label='Unstable')
    ax2.plot(-x_val, y_val, 'b--')
    ax2.plot(x_val, -y_val, 'b--')
    ax2.plot(-x_val, -y_val, 'b--')
    
    ax2.axhline(0, color='b', linestyle='-', label='Stable (y=0)')
    
    ax2.plot([1, -1], [0, 0], 'ro', label='Pull-in points')
    
    ax2.set_xlabel(r"$\tilde{x}$")
    ax2.set_ylabel(r"$\tilde{y}$")
    ax2.set_title("(b) $\\tilde{k}=4$")
    ax2.set_xlim([-1, 1])
    ax2.set_ylim([-1, 1])
    ax2.grid(True, alpha=0.3)
    ax2.legend()

    plt.tight_layout()
    save_plot(fig, "double_sided_comb_equilibrium.png")

def plot_exercise_roots():
    # Unchanged
    lam = np.linspace(0, 5, 500)
    f = np.cos(lam) * np.cosh(lam) + 1
    fig, ax = plt.subplots(figsize=(8, 5))
    ax.plot(lam, f, 'b-', label=r"$\cos(\lambda)\cosh(\lambda)+1$")
    ax.axhline(0, color='k', linestyle='--', alpha=0.5)
    root = brentq(lambda x: np.cos(x)*np.cosh(x)+1, 1.5, 2.5)
    ax.plot(root, 0, 'ro', label=f"$\\lambda_1 \\approx {root:.4f}$")
    ax.set_xlabel(r"$\lambda$")
    ax.set_ylabel(r"$f(\lambda)$")
    ax.set_title("Characteristic Equation Roots")
    ax.grid(True, alpha=0.3)
    ax.legend()
    ax.set_ylim([-5, 5])
    save_plot(fig, "exercise_roots.png")

def main():
    plot_parallel_plate_voltage()
    plot_symmetric_parallel_plate_voltage()
    plot_symmetric_parallel_plate_charge()
    plot_symmetric_parallel_plate_charge_equilibrium()
    plot_one_sided_comb_equilibrium()
    plot_double_sided_comb_equilibrium()
    plot_exercise_roots()

if __name__ == "__main__":
    main()
