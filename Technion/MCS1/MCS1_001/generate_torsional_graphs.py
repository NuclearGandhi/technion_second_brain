import numpy as np
import matplotlib.pyplot as plt
from scipy.optimize import fsolve

# Set up matplotlib
plt.rcParams['text.usetex'] = False
plt.rcParams['font.size'] = 11

def generate_graphs(actuation_type):
    """
    Generate equilibrium and stiffness graphs for torsional actuator.
    
    Parameters:
    -----------
    actuation_type : str
        Either 'charge' or 'voltage'
    """
    
    # Define parameters based on actuation type
    if actuation_type == 'charge':
        # Charge actuation parameters
        stiffness_func = lambda theta: (1 - theta)**2 * np.log(1 - theta)**2 - theta * np.log(1 - theta) - 2 * theta**2
        equilibrium_func = lambda theta: 2 * theta * (1 - theta) * np.log(1 - theta)**2 / ((1 - theta) * np.log(1 - theta) + theta)
        
        initial_guess = 0.7
        ylabel_stiffness = '$(1-\\tilde{\\theta})^2\\ln(1-\\tilde{\\theta})^2 - \\tilde{\\theta}\\ln(1-\\tilde{\\theta}) - 2\\tilde{\\theta}^2$'
        title_stiffness = 'Charge Actuation: Stiffness at Equilibrium = 0'
        title_equilibrium = 'Charge Actuation: Equilibrium Curve'
        ylabel_equilibrium = '$\\tilde{Q}^2$'
        variable_label = 'Q'
        
        output_stiffness = 'torsional_charge_stiffness_equilibrium.png'
        output_equilibrium = 'torsional_charge_vs_angle.png'
        
    elif actuation_type == 'voltage':
        # Voltage actuation parameters
        stiffness_func = lambda theta: 3*theta - 4*theta**2 + 3*(1-theta)**2 * np.log(1-theta)
        equilibrium_func = lambda theta: 2 * theta**3 * (1 - theta) / ((1 - theta) * np.log(1 - theta) + theta)
        
        initial_guess = 0.5
        ylabel_stiffness = '$3\\tilde{\\theta} - 4\\tilde{\\theta}^2 + 3(1-\\tilde{\\theta})^2\\ln(1-\\tilde{\\theta})$'
        title_stiffness = 'Voltage Actuation: Stiffness at Equilibrium = 0'
        title_equilibrium = 'Voltage Actuation: Equilibrium Curve'
        ylabel_equilibrium = '$\\tilde{V}^2$'
        variable_label = 'V'
        
        output_stiffness = 'torsional_voltage_stiffness_equilibrium.png'
        output_equilibrium = 'torsional_voltage_vs_angle.png'
    else:
        raise ValueError("actuation_type must be 'charge' or 'voltage'")
    
    # ========================================
    # Graph 1: Stiffness at equilibrium = 0
    # ========================================
    
    # Create theta range
    theta_range = np.linspace(0.01, 0.95, 500)
    y_values = stiffness_func(theta_range)
    
    # Find the zero crossing (critical point)
    theta_critical = fsolve(stiffness_func, initial_guess)[0]
    print(f"\n{actuation_type.capitalize()} Actuation:")
    print(f"  Critical theta: {theta_critical:.4f}")
    
    # Create figure 1
    fig1, ax1 = plt.subplots(figsize=(6, 4))
    ax1.plot(theta_range, y_values, 'b-', linewidth=2, label='$K_{eq}$ condition')
    ax1.axhline(y=0, color='k', linestyle='--', linewidth=1, alpha=0.5, label='$y=0$')
    ax1.plot(theta_critical, 0, 'ro', markersize=10, label=f'Critical point: $\\tilde{{\\theta}}={theta_critical:.2f}$')
    
    ax1.set_xlabel('$\\tilde{\\theta}$', fontsize=12)
    ax1.set_ylabel(ylabel_stiffness, fontsize=10)
    ax1.set_title(title_stiffness, fontsize=13)
    ax1.grid(True, alpha=0.3)
    ax1.legend(fontsize=10)
    ax1.set_xlim([0, 1])
    
    plt.tight_layout()
    plt.savefig(f'content/Technion/MCS1/MCS1_001/{output_stiffness}', dpi=100, bbox_inches='tight')
    print(f"  Stiffness graph saved: {output_stiffness}")
    plt.close()
    
    # ========================================
    # Graph 2: Equilibrium curve
    # ========================================
    
    # Create theta range
    theta_range2 = np.linspace(0.01, 0.95, 500)
    var_squared = equilibrium_func(theta_range2)
    
    # Find pull-in point
    var_squared_pullin = equilibrium_func(theta_critical)
    print(f"  {variable_label} at pull-in: {np.sqrt(var_squared_pullin):.4f}")
    print(f"  {variable_label}² at pull-in: {var_squared_pullin:.4f}")
    
    # Create figure 2 (with stable/unstable regions)
    fig2, ax2 = plt.subplots(figsize=(6, 4))
    
    # Split the curve at the critical point: solid before, dashed after
    stable_mask = theta_range2 <= theta_critical
    unstable_mask = theta_range2 >= theta_critical
    
    ax2.plot(theta_range2[stable_mask], var_squared[stable_mask], 'b-', linewidth=2, label='Stable equilibrium')
    ax2.plot(theta_range2[unstable_mask], var_squared[unstable_mask], 'b--', linewidth=2, label='Unstable equilibrium')
    ax2.plot(theta_critical, var_squared_pullin, 'ro', markersize=10, 
             label=f'Pull-in: $\\tilde{{\\theta}}={theta_critical:.2f}$, $\\tilde{{{variable_label}}}^2={var_squared_pullin:.2f}$')
    
    # Add vertical and horizontal lines at pull-in
    ax2.axvline(x=theta_critical, color='r', linestyle='--', linewidth=1, alpha=0.3)
    ax2.axhline(y=var_squared_pullin, color='r', linestyle='--', linewidth=1, alpha=0.3)
    
    ax2.set_xlabel('$\\tilde{\\theta}$', fontsize=12)
    ax2.set_ylabel(ylabel_equilibrium, fontsize=12)
    ax2.set_title(title_equilibrium, fontsize=13)
    ax2.grid(True, alpha=0.3)
    ax2.legend(fontsize=10)
    ax2.set_xlim([0, 1])
    ax2.set_ylim([0, max(var_squared[var_squared > 0]) * 1.1])
    
    plt.tight_layout()
    plt.savefig(f'content/Technion/MCS1/MCS1_001/{output_equilibrium}', dpi=100, bbox_inches='tight')
    print(f"  Equilibrium graph saved: {output_equilibrium}")
    plt.close()


# ========================================
# Main execution
# ========================================
if __name__ == "__main__":
    print("=" * 60)
    print("Generating Torsional Actuator Graphs")
    print("=" * 60)
    
    # Generate charge actuation graphs
    generate_graphs('charge')
    
    # Generate voltage actuation graphs
    generate_graphs('voltage')
    
    print("\n" + "=" * 60)
    print("All graphs generated successfully!")
    print("=" * 60)

