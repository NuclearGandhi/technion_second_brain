import numpy as np
import matplotlib.pyplot as plt
from scipy.optimize import brentq


plt.rcParams["text.usetex"] = False
plt.rcParams["font.size"] = 11


def tilde_K_eq(x_tilde: np.ndarray) -> np.ndarray:
    numerator = 4 * x_tilde**3 - 18 * x_tilde**2 + 30 * x_tilde - 15
    denominator = 4 * x_tilde**3 - 18 * x_tilde**2 + 28 * x_tilde - 15
    return numerator / denominator


def tilde_Q_sq(x_tilde: np.ndarray) -> np.ndarray:
    numerator = x_tilde * (4 * x_tilde**2 - 12 * x_tilde + 9)
    denominator = 2 * x_tilde**2 - 6 * x_tilde + 5
    return numerator / denominator


def main() -> None:
    print("=" * 60)
    print("Generating normalized graphs for the stepped actuator (charge)")
    print("=" * 60)

    x_range = np.linspace(0.01, 0.98, 500)

    # Critical point where tilde_K_eq crosses zero inside 0<x<1
    theta_critical = brentq(tilde_K_eq, 0.5, 0.95)
    print(f"  Critical displacement: tilde_x = {theta_critical:.4f}")

    # Figure 1: stiffness at equilibrium
    y_stiffness = tilde_K_eq(x_range)
    fig1, ax1 = plt.subplots(figsize=(6, 4))
    ax1.plot(x_range, y_stiffness, "b-", linewidth=2, label=r"$\tilde{K}_{eq}$")
    ax1.axhline(0, color="k", linestyle="--", linewidth=1, alpha=0.5, label="$y=0$")
    ax1.plot(
        theta_critical,
        0,
        "ro",
        markersize=10,
        label=rf"Pull-in: $\tilde{{x}}={theta_critical:.2f}$",
    )
    ax1.set_xlabel(r"$\tilde{x}$", fontsize=12)
    ax1.set_ylabel(r"$\tilde{K}_{eq}$", fontsize=12)
    ax1.set_title("Normalized stiffness at equilibrium (charge actuation)", fontsize=13)
    ax1.set_xlim([0, 1])
    ax1.grid(True, alpha=0.3)
    ax1.legend(fontsize=10)
    plt.tight_layout()
    stiffness_path = (
        "content/Technion/MCS1/MCS1_HW002/MCS1_HW002_linear_charge_stiffness.png"
    )
    plt.savefig(stiffness_path, dpi=100, bbox_inches="tight")
    plt.close(fig1)
    print(f"  Saved stiffness plot to {stiffness_path}")

    # Figure 2: equilibrium curve
    Q_sq = tilde_Q_sq(x_range)
    Q_sq_critical = tilde_Q_sq(theta_critical)

    fig2, ax2 = plt.subplots(figsize=(6, 4))
    stable_mask = x_range <= theta_critical
    unstable_mask = x_range >= theta_critical
    ax2.plot(
        x_range[stable_mask],
        Q_sq[stable_mask],
        "b-",
        linewidth=2,
        label="Stable equilibrium",
    )
    ax2.plot(
        x_range[unstable_mask],
        Q_sq[unstable_mask],
        "b--",
        linewidth=2,
        label="Unstable equilibrium",
    )
    ax2.plot(
        theta_critical,
        Q_sq_critical,
        "ro",
        markersize=10,
        label=(
            rf"$\tilde{{x}}_{{PI}}={theta_critical:.2f}$, "
            rf"$\tilde{{Q}}^2_{{PI}}={Q_sq_critical:.2f}$"
        ),
    )
    ax2.axvline(theta_critical, color="r", linestyle="--", linewidth=1, alpha=0.3)
    ax2.axhline(Q_sq_critical, color="r", linestyle="--", linewidth=1, alpha=0.3)
    ax2.set_xlabel(r"$\tilde{x}$", fontsize=12)
    ax2.set_ylabel(r"$\tilde{Q}^{2}$", fontsize=12)
    ax2.set_title("Normalized equilibrium curve (charge actuation)", fontsize=13)
    ax2.set_xlim([0, 1])
    positive_vals = Q_sq[Q_sq > 0]
    ax2.set_ylim([0, positive_vals.max() * 1.1 if positive_vals.size else 1])
    ax2.grid(True, alpha=0.3)
    ax2.legend(fontsize=10)
    plt.tight_layout()
    equilibrium_path = (
        "content/Technion/MCS1/MCS1_HW002/MCS1_HW002_linear_charge_equilibrium.png"
    )
    plt.savefig(equilibrium_path, dpi=100, bbox_inches="tight")
    plt.close(fig2)
    print(f"  Saved equilibrium plot to {equilibrium_path}")


if __name__ == "__main__":
    main()

