"""Kinematics helpers for LRB1 Delta robot lab 1.

The equations follow Robert L. Williams II, "The Delta Parallel Robot:
Kinematics Solutions" (2016), revolute-input Delta robot section.
"""

from __future__ import annotations

from dataclasses import dataclass
from pathlib import Path
from typing import Iterable, Literal, Sequence

import matplotlib.pyplot as plt  # type: ignore[reportMissingImports]
import numpy as np  # type: ignore[reportMissingImports]


Branch = int | Sequence[int]


@dataclass(frozen=True)
class DeltaParams:
    """DeltaKin geometric parameters.

    All lengths are in the same units. The default example uses millimeters.
    """

    L: float
    l: float
    h: float
    s_B: float
    s_P: float

    def __post_init__(self) -> None:
        if self.L <= 0 or self.l <= 0 or self.s_B <= 0 or self.s_P <= 0:
            raise ValueError("L, l, s_B, and s_P must be positive")
        if self.h < 0:
            raise ValueError("h must be non-negative")

    @property
    def w_B(self) -> float:
        return np.sqrt(3.0) * self.s_B / 6.0

    @property
    def u_B(self) -> float:
        return np.sqrt(3.0) * self.s_B / 3.0

    @property
    def w_P(self) -> float:
        return np.sqrt(3.0) * self.s_P / 6.0

    @property
    def u_P(self) -> float:
        return np.sqrt(3.0) * self.s_P / 3.0

    @property
    def a(self) -> float:
        return self.w_B - self.u_P

    @property
    def b(self) -> float:
        return self.s_P / 2.0 - np.sqrt(3.0) * self.w_B / 2.0

    @property
    def c(self) -> float:
        return self.w_P - self.w_B / 2.0


def base_points(params: DeltaParams) -> np.ndarray:
    """Return B_i hip points in the fixed base frame {B}."""

    w_B = params.w_B
    return np.array(
        [
            [0.0, -w_B, 0.0],
            [np.sqrt(3.0) * w_B / 2.0, w_B / 2.0, 0.0],
            [-np.sqrt(3.0) * w_B / 2.0, w_B / 2.0, 0.0],
        ]
    )


def platform_points(params: DeltaParams) -> np.ndarray:
    """Return P_i ankle points in the moving platform frame {P}."""

    return np.array(
        [
            [0.0, -params.u_P, 0.0],
            [params.s_P / 2.0, params.w_P, 0.0],
            [-params.s_P / 2.0, params.w_P, 0.0],
        ]
    )


def inverse_efg(x: float, y: float, z: float, params: DeltaParams) -> np.ndarray:
    """Return the DeltaKin E_i, F_i, G_i coefficients."""

    L = params.L
    l = params.l
    a = params.a
    b = params.b
    c = params.c

    return np.array(
        [
            [
                2.0 * L * (y + a),
                2.0 * z * L,
                x**2 + y**2 + z**2 + a**2 + L**2 + 2.0 * y * a - l**2,
            ],
            [
                -L * (np.sqrt(3.0) * (x + b) + y + c),
                2.0 * z * L,
                x**2
                + y**2
                + z**2
                + b**2
                + c**2
                + L**2
                + 2.0 * (x * b + y * c)
                - l**2,
            ],
            [
                L * (np.sqrt(3.0) * (x - b) - y - c),
                2.0 * z * L,
                x**2
                + y**2
                + z**2
                + b**2
                + c**2
                + L**2
                + 2.0 * (-x * b + y * c)
                - l**2,
            ],
        ],
        dtype=float,
    )


def inverse_kinematics(
    x: float,
    y: float,
    z: float,
    params: DeltaParams,
    branch: Branch = -1,
) -> np.ndarray:
    """Return motor angles theta_1, theta_2, theta_3 in radians."""

    branches = _branches(branch)
    theta = np.empty(3, dtype=float)

    for i, (E_i, F_i, G_i) in enumerate(inverse_efg(x, y, z, params)):
        discriminant = E_i**2 + F_i**2 - G_i**2
        if discriminant < -1e-9:
            raise ValueError(f"leg {i + 1}: target is outside the workspace")

        denominator = G_i - E_i
        if abs(denominator) < 1e-12:
            raise ValueError(f"leg {i + 1}: tangent-half-angle singularity")

        t_i = (-F_i + branches[i] * np.sqrt(max(discriminant, 0.0))) / denominator
        theta[i] = 2.0 * np.arctan(t_i)

    return theta


def forward_kinematics(
    theta1: float,
    theta2: float,
    theta3: float,
    params: DeltaParams,
    solution: Literal["lower_z", "upper_z", "both"] = "lower_z",
) -> np.ndarray:
    """Return platform position from motor angles."""

    theta = np.array([theta1, theta2, theta3], dtype=float)
    A = elbow_points(theta, params)
    sphere_centers = A - platform_points(params)

    line_point, line_direction = _sphere_center_line(sphere_centers)
    roots = _line_sphere_intersections(
        line_point,
        line_direction,
        sphere_centers[0],
        params.l,
    )
    positions = np.array([line_point + root * line_direction for root in roots])

    if solution == "both":
        return positions
    if solution == "lower_z":
        return positions[np.argmin(positions[:, 2])]
    if solution == "upper_z":
        return positions[np.argmax(positions[:, 2])]
    raise ValueError(f"unknown solution selector: {solution}")


def elbow_points(theta: np.ndarray, params: DeltaParams) -> np.ndarray:
    """Return A_i points for the three upper arms."""

    L = params.L
    w_B = params.w_B
    return np.array(
        [
            [0.0, -w_B - L * np.cos(theta[0]), -L * np.sin(theta[0])],
            [
                np.sqrt(3.0) * (w_B + L * np.cos(theta[1])) / 2.0,
                (w_B + L * np.cos(theta[1])) / 2.0,
                -L * np.sin(theta[1]),
            ],
            [
                -np.sqrt(3.0) * (w_B + L * np.cos(theta[2])) / 2.0,
                (w_B + L * np.cos(theta[2])) / 2.0,
                -L * np.sin(theta[2]),
            ],
        ]
    )


def plot_axis_motion(
    axis: Literal["x", "y", "z"],
    start: float,
    stop: float,
    samples: int,
    fixed: dict[str, float],
    params: DeltaParams,
    branch: Branch = -1,
    output_path: str | Path | None = None,
) -> np.ndarray:
    """Plot theta_1, theta_2, theta_3 while moving along one Cartesian axis."""

    if axis not in {"x", "y", "z"}:
        raise ValueError("axis must be one of: x, y, z")

    values = np.linspace(start, stop, samples)
    theta = np.full((samples, 3), np.nan, dtype=float)

    for row, value in enumerate(values):
        point = {
            "x": fixed.get("x", 0.0),
            "y": fixed.get("y", 0.0),
            "z": fixed.get("z", 0.0),
        }
        point[axis] = float(value)

        try:
            theta[row] = inverse_kinematics(
                point["x"],
                point["y"],
                point["z"],
                params,
                branch=branch,
            )
        except ValueError:
            theta[row] = np.nan

    fig, ax = plt.subplots(figsize=(6, 4), dpi=100)
    for leg in range(3):
        ax.plot(values, np.rad2deg(theta[:, leg]), label=fr"$\theta_{leg + 1}$")

    ax.set_xlabel(f"${axis}$ [mm]")
    ax.set_ylabel(r"$\theta_i$ [deg]")
    ax.set_title(f"Motor angles for motion along {axis.upper()}")
    ax.grid(True)
    ax.legend()
    fig.tight_layout()

    if output_path is not None:
        fig.savefig(output_path, dpi=100)
        plt.close(fig)
    else:
        plt.show()

    return theta


def save_requested_graphs(output_dir: str | Path, params: DeltaParams | None = None) -> None:
    """Save the three requested preparation graphs for X, Y, and Z motion."""

    params = example_params() if params is None else params
    output_dir = Path(output_dir)
    output_dir.mkdir(parents=True, exist_ok=True)

    graph_specs = {
        "x": {"start": -250.0, "stop": 250.0, "fixed": {"y": 0.0, "z": -900.0}},
        "y": {"start": -250.0, "stop": 250.0, "fixed": {"x": 0.0, "z": -900.0}},
        "z": {"start": -1050.0, "stop": -750.0, "fixed": {"x": 0.0, "y": 0.0}},
    }

    for axis, spec in graph_specs.items():
        plot_axis_motion(
            axis=axis,
            start=spec["start"],
            stop=spec["stop"],
            samples=100,
            fixed=spec["fixed"],
            params=params,
            branch=-1,
            output_path=output_dir / f"lrb1_delta_motion_{axis}.png",
        )


def example_params() -> DeltaParams:
    """Return the ABB FlexPicker IRB 360-1/1600 example from DeltaKin."""

    return DeltaParams(
        L=524.0,
        l=1244.0,
        h=131.0,
        s_B=567.0,
        s_P=76.0,
    )


def _sphere_center_line(centers: np.ndarray) -> tuple[np.ndarray, np.ndarray]:
    c1, c2, c3 = centers
    linear_matrix = 2.0 * np.vstack([c2 - c1, c3 - c1])
    rhs = np.array([c2 @ c2 - c1 @ c1, c3 @ c3 - c1 @ c1])

    _, singular_values, vh = np.linalg.svd(linear_matrix)
    if singular_values[-1] < 1e-12:
        raise ValueError("forward kinematics is singular for these angles")

    line_point = np.linalg.lstsq(linear_matrix, rhs, rcond=None)[0]
    line_direction = vh[-1] / np.linalg.norm(vh[-1])
    return line_point, line_direction


def _line_sphere_intersections(
    line_point: np.ndarray,
    line_direction: np.ndarray,
    center: np.ndarray,
    radius: float,
) -> np.ndarray:
    delta = line_point - center
    b = 2.0 * float(line_direction @ delta)
    c = float(delta @ delta - radius**2)
    discriminant = b**2 - 4.0 * c

    if discriminant < -1e-10:
        raise ValueError("forward kinematics has no real solution")

    discriminant = max(discriminant, 0.0)
    sqrt_disc = np.sqrt(discriminant)
    return np.array([(-b - sqrt_disc) / 2.0, (-b + sqrt_disc) / 2.0])


def _branches(branch: Branch) -> np.ndarray:
    if isinstance(branch, Iterable) and not isinstance(branch, (str, bytes)):
        branches = np.asarray(list(branch), dtype=int)
    else:
        branches = np.full(3, int(branch), dtype=int)

    if branches.shape != (3,) or not np.all(np.isin(branches, [-1, 1])):
        raise ValueError("branch must be -1, +1, or a 3-value sequence of them")
    return branches


if __name__ == "__main__":
    save_requested_graphs(Path(__file__).with_name("figures"))
