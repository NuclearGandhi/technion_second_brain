---
aliases:
  - Dynamic Pull-In
  - Dynamic Pull-In Voltage
---

# Dynamic Pull-In in One DOF Actuators

The static pull-in voltage of a voltage-controlled electrostatic actuator is found from the equilibrium curve. Dynamic pull-in asks a different question: if the actuator starts from rest at the undeformed position and a voltage step is applied, what voltage is large enough that the motion cannot remain bounded by the stable well?

Consider the parallel-plate actuator with spring stiffness $k$, electrode area $A$, initial gap $g$, displacement $x$, and voltage $V$. Using the voltage-controlled potential convention from [[MCS2_002 Electromechanical Systems with N DOFs and K Voltages#Energy, Equilibrium, and Stability|the energy formulation]], the total potential is

$$
\psi
:=
\dfrac{1}{2}kx^{2}
-
\dfrac{\varepsilon_{0}A}{2(g-x)}V^{2}.
\tag{6.1}
$$

Define

$$
\tilde{x}:=\dfrac{x}{g},
\qquad
\tilde{\psi}:=\dfrac{\psi}{kg^{2}},
\qquad
\tilde{V}^{2}:=\dfrac{\varepsilon_{0}A}{kg^{3}}V^{2}.
\tag{6.2}
$$

Then

$$
\tilde{\psi}
=
\dfrac{1}{2}\tilde{x}^{2}
-
\dfrac{1}{2}
\dfrac{\tilde{V}^{2}}{1-\tilde{x}}.
\tag{6.3}
$$

The mechanical reaction force needed to hold the plate at $\tilde{x}$ is

$$
\tilde{f}
:=
\dfrac{\partial \tilde{\psi}}{\partial \tilde{x}}
=
\tilde{x}
-
\dfrac{\tilde{V}^{2}}{2(1-\tilde{x})^{2}}.
\tag{6.4}
$$

Equilibrium requires $\tilde{f}=0$, so the voltage along the static equilibrium curve is

$$
\tilde{V}^{2}
=
2\tilde{x}(1-\tilde{x})^{2}.
\tag{6.5}
$$

The stiffness along an equilibrium state is

$$
\tilde{K}
:=
\dfrac{\partial \tilde{f}}{\partial \tilde{x}}
=
1
-
\dfrac{\tilde{V}^{2}}{(1-\tilde{x})^{3}}.
\tag{6.6}
$$

The static pull-in state is therefore the limit point of $\text{(6.5)}$:

$$
\boxed{
\tilde{x}_{SPI}=\dfrac{1}{3}
},
\qquad
\boxed{
\tilde{V}^{2}_{SPI}=\dfrac{8}{27}
}.
\tag{6.7}
$$

## Energy Constraint

For the dynamic response, the kinetic energy must be included. The Hamiltonian is

$$
H
=
\dfrac{1}{2}m\dot{x}^{2}
+
\dfrac{1}{2}kx^{2}
-
\dfrac{\varepsilon_{0}A}{2(g-x)}V^{2}.
\tag{6.8}
$$

Use the normalized time and Hamiltonian

$$
\tilde{t}:=\sqrt{\dfrac{k}{m}}t,
\qquad
\dot{\tilde{x}}:=\dfrac{\mathrm{d}\tilde{x}}{\mathrm{d}\tilde{t}},
\qquad
\tilde{H}:=\dfrac{H}{kg^{2}}.
\tag{6.9}
$$

Then

$$
\tilde{H}
=
\dfrac{1}{2}\dot{\tilde{x}}^{2}
+
\dfrac{1}{2}\tilde{x}^{2}
-
\dfrac{1}{2}
\dfrac{\tilde{V}^{2}}{1-\tilde{x}}.
\tag{6.10}
$$

The voltage is applied as a step at $\tilde{t}=0$, while the plate is still at rest:

$$
\tilde{x}(0)=0,
\qquad
\dot{\tilde{x}}(0)=0.
\tag{6.11}
$$

If mechanical and electrical dissipation are neglected, $\tilde{H}$ is conserved after the voltage step.

Since

$$
\tilde{H}(0)
=
-
\dfrac{1}{2}\tilde{V}^{2},
\tag{6.12}
$$

the motion must satisfy the energy constraint

$$
D
:=
\dfrac{1}{2}\dot{\tilde{x}}^{2}
+
\dfrac{1}{2}\tilde{x}^{2}
-
\dfrac{\tilde{V}^{2}\tilde{x}}{2(1-\tilde{x})}
=0.
\tag{6.13}
$$

>[!notes] Why dynamic pull-in can occur below static pull-in
>Static pull-in asks whether a stable equilibrium exists at the applied voltage. Dynamic pull-in asks whether the step response has enough conserved energy to pass the unstable equilibrium barrier. Because a voltage step injects energy instantly, collapse can occur even when a stable static equilibrium still exists.

## Stagnation Curve

A stagnation state is a point on the trajectory where the velocity vanishes. Setting $\dot{\tilde{x}}=0$ in $\text{(6.13)}$ gives

$$
S
:=
\dfrac{1}{2}\tilde{x}^{2}
-
\dfrac{\tilde{V}^{2}\tilde{x}}{2(1-\tilde{x})}
=0.
\tag{6.14}
$$

For any fixed voltage, the stagnation equation has the roots

$$
\tilde{x}_{I}=0,
\qquad
\tilde{x}_{II}
=
\dfrac{1-\sqrt{1-4\tilde{V}^{2}}}{2},
\qquad
\tilde{x}_{III}
=
\dfrac{1+\sqrt{1-4\tilde{V}^{2}}}{2}.
\tag{6.15}
$$

Equivalently, the nonzero stagnation branch satisfies

$$
\tilde{V}^{2}
=
\tilde{x}(1-\tilde{x}).
\tag{6.16}
$$

The dynamic pull-in state is where the stagnation curve reaches its maximum voltage. At that point the stable and unstable stagnation branches coalesce, and the point also lies on the unstable branch of the static equilibrium curve:

$$
\boxed{
\tilde{x}_{DPI}=\dfrac{1}{2}
},
\qquad
\boxed{
\tilde{V}^{2}_{DPI}=\dfrac{1}{4}
}.
\tag{6.17}
$$

![[dynamic_pullin_1dof.svg|bookhue|600]]^figure-dynamic-pullin-1dof
>Equilibrium and stagnation curves of the normalized one-DOF parallel-plate actuator. The dynamic pull-in point lies on the unstable static branch and occurs before the static pull-in voltage is reached.

For the one-DOF parallel-plate actuator,

$$
\dfrac{\tilde{V}_{DPI}}{\tilde{V}_{SPI}}
=
\sqrt{\dfrac{1/4}{8/27}}
\approx
0.919.
\tag{6.18}
$$

Thus the undamped dynamic pull-in voltage is about $8\%$ lower than the static pull-in voltage.

If viscous damping is present, the actual pull-in voltage lies between the conservative dynamic value and the quasi-static value:

$$
\boxed{
\tilde{V}^{2}_{DPI}
\leq
\tilde{V}^{2}_{PI}
\leq
\tilde{V}^{2}_{SPI}
}.
\tag{6.19}
$$

# Two-DOF Actuator

Now consider a double parallel-plate actuator. Two equal moving electrodes are attached to ground by springs of stiffness $k$, and are coupled to each other by a spring of stiffness $k$. Each electrode is driven by its own voltage source.

![[MCS2_002 Electromechanical Systems with N DOFs and K Voltages 2026-05-12 18.10.30.excalidraw.svg]]^figure-two-coupled-parallel-plates
>Two couples parallel-plates actuators.

The normalized potential is

$$
\tilde{\psi}
=
\dfrac{1}{2}\tilde{x}_{1}^{2}
+
\dfrac{1}{2}\tilde{x}_{2}^{2}
+
\dfrac{1}{2}(\tilde{x}_{1}-\tilde{x}_{2})^{2}
-
\dfrac{1}{2}
\dfrac{\tilde{V}_{1}^{2}}{1-\tilde{x}_{1}}
-
\dfrac{1}{2}
\dfrac{\tilde{V}_{2}^{2}}{1-\tilde{x}_{2}}.
\tag{6.20}
$$

The reaction forces are

$$
\begin{aligned}
\tilde{f}_{1}
&=
2\tilde{x}_{1}-\tilde{x}_{2}
-
\dfrac{\tilde{V}_{1}^{2}}{2(1-\tilde{x}_{1})^{2}},
\\[1ex]
\tilde{f}_{2}
&=
2\tilde{x}_{2}-\tilde{x}_{1}
-
\dfrac{\tilde{V}_{2}^{2}}{2(1-\tilde{x}_{2})^{2}}.
\end{aligned}
\tag{6.21}
$$

Equilibrium therefore gives the voltages as functions of displacement:

$$
\begin{aligned}
\tilde{V}_{1}^{2}
&=
2(2\tilde{x}_{1}-\tilde{x}_{2})(1-\tilde{x}_{1})^{2},
\\[1ex]
\tilde{V}_{2}^{2}
&=
2(2\tilde{x}_{2}-\tilde{x}_{1})(1-\tilde{x}_{2})^{2}.
\end{aligned}
\tag{6.22}
$$

>[!notes] Voltage normalization convention
>The lecture absorbs the electrostatic factor $1/2$ into the definition of $\tilde{V}_{i}^{2}$ for this two-DOF example. Here we keep the same convention used in $\text{(6.2)}$, so the factor $1/2$ remains in the co-energy term and the equilibrium voltages in $\text{(6.22)}$ keep the leading factor $2$.

The stiffness matrix is

$$
\mathbf{K}
=
\begin{pmatrix}
2-\dfrac{\tilde{V}_{1}^{2}}{(1-\tilde{x}_{1})^{3}} & -1 \\
-1 & 2-\dfrac{\tilde{V}_{2}^{2}}{(1-\tilde{x}_{2})^{3}}
\end{pmatrix}.
\tag{6.23}
$$

Static pull-in occurs when the smaller eigenvalue of $\mathbf{K}$ vanishes. Substituting the equilibrium voltages from $\text{(6.22)}$ into $\det \mathbf{K}=0$ gives the static pull-in line in the displacement domain:

$$
3
-7\tilde{x}_{1}
-7\tilde{x}_{2}
+39\tilde{x}_{1}\tilde{x}_{2}
-12\tilde{x}_{1}^{2}
-12\tilde{x}_{2}^{2}
=0.
\tag{6.24}
$$

## Dynamic Pull-In Line

The normalized Hamiltonian is

$$
\begin{aligned}
\tilde{H}
=&
\dfrac{1}{2}\dot{\tilde{x}}_{1}^{2}
+
\dfrac{1}{2}\dot{\tilde{x}}_{2}^{2}
+
\dfrac{1}{2}\tilde{x}_{1}^{2}
+
\dfrac{1}{2}\tilde{x}_{2}^{2}
+
\dfrac{1}{2}(\tilde{x}_{1}-\tilde{x}_{2})^{2}
\\[1ex]
&-
\dfrac{1}{2}
\dfrac{\tilde{V}_{1}^{2}}{1-\tilde{x}_{1}}
-
\dfrac{1}{2}
\dfrac{\tilde{V}_{2}^{2}}{1-\tilde{x}_{2}}.
\end{aligned}
\tag{6.25}
$$

With the initial state

$$
\tilde{x}_{1}(0)=\tilde{x}_{2}(0)=0,
\qquad
\dot{\tilde{x}}_{1}(0)=\dot{\tilde{x}}_{2}(0)=0,
\tag{6.26}
$$

energy conservation gives

$$
\begin{aligned}
D
=&
\dfrac{1}{2}\dot{\tilde{x}}_{1}^{2}
+
\dfrac{1}{2}\dot{\tilde{x}}_{2}^{2}
+
\dfrac{1}{2}\tilde{x}_{1}^{2}
+
\dfrac{1}{2}\tilde{x}_{2}^{2}
+
\dfrac{1}{2}(\tilde{x}_{1}-\tilde{x}_{2})^{2}
\\[1ex]
&-
\dfrac{\tilde{V}_{1}^{2}\tilde{x}_{1}}{2(1-\tilde{x}_{1})}
-
\dfrac{\tilde{V}_{2}^{2}\tilde{x}_{2}}{2(1-\tilde{x}_{2})}
=0.
\end{aligned}
\tag{6.27}
$$

Setting the velocities to zero defines the stagnation domain. The dynamic pull-in line is obtained from the intersection of this stagnation domain with the equilibrium domain. Substituting $\text{(6.22)}$ into the stagnation condition gives

$$
2\tilde{x}_{1}^{3}
+2\tilde{x}_{2}^{3}
-\tilde{x}_{1}^{2}
-\tilde{x}_{2}^{2}
+\tilde{x}_{1}\tilde{x}_{2}
-\tilde{x}_{1}^{2}\tilde{x}_{2}
-\tilde{x}_{1}\tilde{x}_{2}^{2}
=0.
\tag{6.28}
$$

Each point on $\text{(6.28)}$ is mapped to a pair of voltages using $\text{(6.22)}$.

![[dynamic_pullin_2dof_lines.svg|bookhue|600]]^figure-dynamic-pullin-2dof-lines
>Static and dynamic pull-in lines of the double parallel-plate actuator. The dynamic line is found by intersecting the equilibrium domain with the stagnation domain.

## Alpha Lines

For multiple voltage sources, "the maximum voltage" is not unique unless a loading path in voltage space is specified. The lecture uses an alpha-line:

$$
\alpha
:=
\dfrac{\tilde{V}_{2}}{\tilde{V}_{1}},
\qquad
\tilde{V}_{1}:=\tilde{V},
\qquad
\tilde{V}_{2}:=\alpha \tilde{V}.
\tag{6.29}
$$

For a fixed $\alpha$, the actuator is again driven by one scalar voltage $\tilde{V}$. Along the stagnation domain, $\tilde{V}$ can be extracted as a function of $(\tilde{x}_{1},\tilde{x}_{2})$. The dynamic pull-in point for that alpha-line is where all displacement derivatives of this voltage vanish:

$$
\dfrac{\partial \tilde{V}}{\partial \tilde{x}_{1}}
=
\dfrac{\partial \tilde{V}}{\partial \tilde{x}_{2}}
=0.
\tag{6.30}
$$

Repeating this calculation for all $\alpha$ traces the dynamic pull-in line in voltage space. For the double parallel-plate actuator, the dynamic voltage is again about $8\%$ below the corresponding static pull-in voltage.

For $\alpha=1/2$, the stagnation equation can be viewed as a scalar voltage field over the displacement plane:

$$
\tilde{V}^{2}
=
\dfrac{
2\left[
\dfrac{1}{2}\tilde{x}_{1}^{2}
+
\dfrac{1}{2}\tilde{x}_{2}^{2}
+
\dfrac{1}{2}(\tilde{x}_{1}-\tilde{x}_{2})^{2}
\right]
}{
\dfrac{\tilde{x}_{1}}{1-\tilde{x}_{1}}
+
\alpha^{2}
\dfrac{\tilde{x}_{2}}{1-\tilde{x}_{2}}
}.
\tag{6.31}
$$

![[dynamic_pullin_2dof_alpha_stagnation.svg|book|600]]^figure-dynamic-pullin-2dof-alpha-stagnation
>Stagnation voltage map for the double parallel-plate actuator with $\alpha=1/2$. The color field shows the scalar driving voltage $\tilde{V}$, the black curves are equi-voltage contours, and the blue contour is the critical contour through the dynamic pull-in point.

>[!notes] Stagnation is necessary but not always sufficient
>The stagnation line contains all energetically possible zero-velocity states, but the actual trajectory visits only some of them. In multi-DOF systems, the pull-in voltage extracted from the stagnation-equilibrium intersection is therefore a lower bound unless the trajectory is shown to pass through the critical opening.

# Dynamic Pull-In Hyper-Surface

For a general electrostatic actuator with $N$ mechanical degrees of freedom and $K$ independent voltages, write the normalized voltage-controlled potential as

$$
\tilde{\psi}
=
\tilde{U}_{M}(\tilde{x}_{1},\ldots,\tilde{x}_{N})
-
\dfrac{1}{2}
\sum_{k=1}^{K}
\tilde{C}_{k}(\tilde{x}_{k})\tilde{V}_{k}^{2}.
\tag{6.32}
$$

Here $\tilde{U}_{M}$ is the mechanical potential and $\tilde{C}_{k}$ is the normalized capacitance associated with voltage source $k$. The unloaded state is chosen so that $\tilde{U}_{M}(0,\ldots,0)=0$.

Because the system starts from rest at the unloaded state, the stagnation function is the difference between the potential at the current state and the potential immediately after the voltage step:

$$
S
:=
\tilde{U}_{M}
-
\dfrac{1}{2}
\sum_{k=1}^{K}
\left[
\tilde{C}_{k}(\tilde{x}_{k})
-
\tilde{C}_{k}(0)
\right]
\tilde{V}_{k}^{2}
=0.
\tag{6.33}
$$

The derivatives of $S$ with respect to the mechanical coordinates are

$$
s_{i}
:=
\dfrac{\partial S}{\partial \tilde{x}_{i}}
=
\dfrac{\partial \tilde{U}_{M}}{\partial \tilde{x}_{i}}
-
\dfrac{1}{2}
\sum_{k=1}^{K}
\dfrac{\partial \tilde{C}_{k}}{\partial \tilde{x}_{i}}
\tilde{V}_{k}^{2}
=
\tilde{f}_{i}.
\tag{6.34}
$$

Therefore, an equilibrium point that also satisfies the stagnation condition is a stationary point of the voltage level on the stagnation manifold. If the capacitances are monotonic, the dynamic pull-in condition can be interpreted as an extremum of the applied voltages subject to the stagnation constraint.

The dimensional count is also useful:
- the static pull-in hyper-surface has dimension $K-1$;
- the dynamic pull-in lower-bound hyper-surface also has dimension $K-1$.

# Clamped-Clamped Beam Actuator

The same idea applies to distributed systems. A clamped-clamped beam over a fixed electrode has infinitely many mechanical DOFs, represented by the transverse deflection $y(x)$.

The total potential used in the lecture is

$$
\begin{aligned}
\psi
=&
\dfrac{E^{*}I}{2}
\int_{0}^{L}
\left(
\dfrac{\mathrm{d}^{2}y}{\mathrm{d}x^{2}}
\right)^{2}
\,\mathrm{d}x
+
\dfrac{EA}{2L}
\left[
\dfrac{1}{2}
\int_{0}^{L}
\left(
\dfrac{\mathrm{d}y}{\mathrm{d}x}
\right)^{2}
\,\mathrm{d}x
\right]^{2}
\\[1ex]
&-
\dfrac{\varepsilon_{0}wV^{2}}{2}
\int_{0}^{L}
\left[
\dfrac{1}{g-y}
+
f(w,h,g-y)
\right]
\,\mathrm{d}x.
\end{aligned}
\tag{6.35}
$$

The first term is bending energy, the second term is stretching energy caused by clamped-clamped inextensibility, and the last term is electrostatic co-energy with a fringing-field correction $f$.

Using

$$
\tilde{x}:=\dfrac{x}{L},
\qquad
\tilde{y}:=\dfrac{y}{g},
\qquad
\tilde{V}^{2}:=
\dfrac{\varepsilon_{0}wL^{4}}{E^{*}Ig^{3}}V^{2},
\qquad
\tilde{E}:=\dfrac{E}{E^{*}},
\tag{6.36}
$$

the normalized potential can be written schematically as

$$
\begin{aligned}
\tilde{\psi}
=&
\dfrac{1}{2}
\int_{0}^{1}
\left(
\dfrac{\mathrm{d}^{2}\tilde{y}}{\mathrm{d}\tilde{x}^{2}}
\right)^{2}
\,\mathrm{d}\tilde{x}
+
6\tilde{E}
\left(
\dfrac{g}{h}
\right)^{2}
\left[
\dfrac{1}{2}
\int_{0}^{1}
\left(
\dfrac{\mathrm{d}\tilde{y}}{\mathrm{d}\tilde{x}}
\right)^{2}
\,\mathrm{d}\tilde{x}
\right]^{2}
\\[1ex]
&-
\dfrac{1}{2}\tilde{V}^{2}
\int_{0}^{1}
\left[
\dfrac{1}{1-\tilde{y}}
+
\tilde{f}(\tilde{w},\tilde{h},\tilde{y})
\right]
\,\mathrm{d}\tilde{x}.
\end{aligned}
\tag{6.37}
$$

The static equilibrium curve is computed with the DIPIE idea from [[MCS2_001 DIPIE#DIPIE Algorithm|Lecture 1]]: prescribe the center deflection $\tilde{y}_{c}$ and solve for the remaining deflection field and voltage. For each equilibrium deflection, the stagnation voltage is computed from the beam version of the energy constraint. The intersection gives the dynamic pull-in lower bound.

![[clamped_beam_equilibrium_stagnation.svg|bookhue|600]]^figure-clamped-beam-equilibrium-stagnation
>Lecture-value schematic of the equilibrium and stagnation curves for a clamped-clamped beam actuator. The dynamic pull-in voltage is lower because the voltage step injects kinetic energy into the beam response.

For the simulated clamped-clamped beam in the lecture,

$$
\boxed{
\tilde{V}_{SPI}=8.2406
},
\qquad
\boxed{
\tilde{V}_{DPI}=7.5194
}.
\tag{6.38}
$$

Thus the dynamic pull-in voltage is about $9\%$ lower than the static pull-in voltage.
