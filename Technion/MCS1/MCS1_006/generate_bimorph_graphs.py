import numpy as np
import matplotlib.pyplot as plt

plt.rcParams["text.usetex"] = False
plt.rcParams["font.size"] = 11

def calculate_E_star(h):
    """
    Calculates the modulus ratio E* for a given thickness ratio h
    that results in maximum curvature, based on Equation (6.13a):
    E* = 1 / (3h^2 + 2h^3)
    """
    return 1 / (3 * h**2 + 2 * h**3)

def main():
    print("=" * 60)
    print("Generating bimorph curvature optimization graph")
    print("=" * 60)

    # Generate h values (thickness ratio)
    # User requested linear scale.
    # h is the independent variable here for calculation simplicity, 
    # but we are plotting E* (y) vs h (x).
    h = np.linspace(0.1, 1.5, 500)
    
    # Calculate corresponding E* values
    E_star = calculate_E_star(h)

    # Special point E* = 1, h = 0.5
    h_special = 0.5
    E_star_special = calculate_E_star(h_special) # Should be 1.0

    fig, ax = plt.subplots(figsize=(6, 5))
    
    # Plot E* vs h
    ax.plot(h, E_star, 'b-', linewidth=2, label=r"$E^* = \frac{1}{3h^2 + 2h^3}$")
    
    # Plot the special point
    ax.plot(h_special, E_star_special, 'ro', markersize=8, 
            label=rf"$h={h_special:.1f}, E^*={E_star_special:.0f}$")

    # Annotations and styling
    # User requested LaTeX labels.
    ax.set_xlabel(r"Thickness ratio $h_{\kappa, \max} = h_2/h_1$", fontsize=12)
    ax.set_ylabel(r"Modulus ratio $E^* = E^*_2/E^*_1$", fontsize=12)
    ax.set_title(r"Modulus ratio $E^*$ as a function of optimal thickness ratio $h_{\kappa, \max}$", fontsize=13)
    ax.grid(True, which="both", ls="-", alpha=0.2)
    ax.legend(fontsize=12)
    
    plt.tight_layout()
    
    # Save the figure
    output_path = "content/Technion/MCS1/MCS1_006_bimorph_optimization.png"
    plt.savefig(output_path, dpi=150, bbox_inches="tight")
    plt.close(fig)
    print(f"  Saved plot to {output_path}")

if __name__ == "__main__":
    main()
