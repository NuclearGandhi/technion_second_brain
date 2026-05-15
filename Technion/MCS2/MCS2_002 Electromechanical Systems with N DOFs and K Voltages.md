---
aliases:
  - KN and alpha lines
  - Voltage-free pull-in
---
# Electromechanical Systems with N DOFs and K Voltages

The previous note, [[MCS2_001 DIPIE]], dealt mostly with a single voltage source: one voltage parameter $\tilde{V}$ controls a distributed actuator, and the equilibrium curve can be drawn as voltage versus a representative displacement. In that setting, pull-in is a point on a curve.

This lecture generalizes the picture. A microsystem may have $N$ mechanical degrees of freedom and $K$ independent voltage sources. The equilibrium set is then not a curve in the usual sense, but a higher-dimensional object.

## Energy, Equilibrium, and Stability
Let ${q}_{1},\dots,{q}_{N}$ be generalized mechanical coordinates, and let ${V}_{1},\dots,{V}_{K}$ be independent voltage sources. With voltage-controlled electrodes, the total potential is

$$\psi({q}_{1},\dots,{q}_{N},{V}_{1},\dots,{V}_{K})=
U({q}_{1},\dots,{q}_{N})
-\dfrac{1}{2}{C}_{k}({q}_{1},\dots,{q}_{N}){{{V}_{k}}}^{2}
\tag{2.1}$$

where repeated voltage indices are summed using [[SLD2_001 טנזור המאמץ#עיקרון הסכימה של איינשטיין|Einstein's summation convention]]:

$${C}_{k}({q}_{1},{q}_{2},\dots ,{q}_{N}){{{V}_{k}}}^{2}=\sum_{k=1}^{K}{C}_{k}({q}_{1},{q}_{2},\dots ,{q}_{N}){{{V}_{k}}}^{2} $$

Here $U$ is the elastic potential energy and ${C}_{k}$ is the capacitance associated with electrode $k$. The minus sign is important: for voltage control, the voltage source does work on the system, so the electrostatic contribution lowers the effective potential.

The generalized reaction force is

$$
{f}_{i}=\dfrac{\partial \psi}{\partial {q}_{i}}
=\dfrac{\partial U}{\partial {q}_{i}}
-\dfrac{1}{2}\dfrac{\partial {C}_{k}}{\partial {q}_{i}}{{{V}_{k}}}^{2},
\qquad i=1,\dots,N
\tag{2.2}
$$

At equilibrium ${f}_{i}=0$, so

$$
\dfrac{\partial U}{\partial {q}_{i}}
=\dfrac{1}{2}\dfrac{\partial {C}_{k}}{\partial {q}_{i}}{{{V}_{k}}}^{2},
\qquad i=1,\dots,N
\tag{2.3}
$$

Equation $\text{(2.3)}$ is a force balance: elastic restoring force on the left, electrostatic generalized force on the right.

The tangent stiffness matrix is the Hessian of the total potential:

$$
\begin{aligned}
{K}_{ij}
&=\dfrac{\partial^{2}\psi}{\partial {q}_{i}\partial {q}_{j}} \\[1ex]
&=\dfrac{\partial^{2}U}{\partial {q}_{i}\partial {q}_{j}}
-\dfrac{1}{2}\dfrac{\partial^{2}{C}_{k}}{\partial {q}_{i}\partial {q}_{j}}{{{V}_{k}}}^{2}
\end{aligned}
\tag{2.4}
$$

Since $[\mathbf{K}]$ is symmetric, it has real eigenvalues. We order them as

$$ {\lambda}_{1}\leq{\lambda}_{2}\leq\dots\leq{\lambda}_{N} $$

The smallest eigenvalue is the stability indicator:
- the equilibrium is **stable** if ${\lambda}_{1}>0$;
- it is **unstable** if ${\lambda}_{1}<0$;
- it is **neutral** if ${\lambda}_{1}=0$.
- it is in **critical stability** if ${\lambda}_{1}=0$ AND ${\lambda}_{1}<0$ in a near state which can be reached without changing the loading.

Pull-in occurs at a critical equilibrium where the smallest eigenvalue vanishes:

$$ {\lambda}_{1}=0 $$

The associated eigenvector ${\boldsymbol{\beta}}_{1}$ is the critical displacement direction. Physically, this is the deformation mode in which the system has just lost stiffness.

>[!notes] Why the eigenvalue matters
>A "variation" means a small virtual change in the displacement coordinates. If the equilibrium point is $\mathbf{q}_{0}$, we perturb it to $\mathbf{q}_{0}+\delta\mathbf{q}$. The first variation is the linear change in potential energy, $\delta\psi=\dfrac{\partial\psi}{\partial {q}_{i}}\delta {q}_{i}$. At equilibrium this term is zero, because the generalized forces vanish. The next term is the second variation:
>$$\delta^{2}\psi=\dfrac{1}{2}\delta {q}_{i}{K}_{ij}\delta {q}_{j}$$
>This quadratic term tells us whether every small displacement raises $\psi$ or whether there is a direction in which $\psi$ decreases.

## Pull-In as a Singular Stiffness Condition
A necessary condition for a critical state is

$$ \det([\mathbf{K}])=0 \tag{2.5} $$

This condition alone is not enough. It only says that some eigenvalue is zero. To identify pull-in, we must also verify that the vanishing eigenvalue is the smallest one and that the state is reachable from the stable equilibrium domain without changing the loading path.

The pull-in states are therefore found by solving the equilibrium equations $\text{(2.3)}$ together with

$$ \det([\mathbf{K}])=0 $$

and then checking the eigenvalues.

## Voltage-Free Equilibrium Equations
The direct equilibrium equations contain the voltage variables. For many purposes, it is better to eliminate them and describe equilibrium directly in displacement space.

Multiply $\text{(2.3)}$ by $\dfrac{\partial {C}_{p}}{\partial {q}_{i}}$ and sum over $i$:

$$
\dfrac{\partial {C}_{p}}{\partial {q}_{i}}
\dfrac{\partial U}{\partial {q}_{i}}
=
\dfrac{1}{2}
\left[
\dfrac{\partial {C}_{p}}{\partial {q}_{i}}
\dfrac{\partial {C}_{k}}{\partial {q}_{i}}
\right]{{{V}_{k}}}^{2}
\tag{2.6}
$$

Define the $K\times K$ matrix

$$
{A}_{pk}:=
\dfrac{\partial {C}_{p}}{\partial {q}_{i}}
\dfrac{\partial {C}_{k}}{\partial {q}_{i}}
\tag{2.7}
$$

If $K\leq N$ and $[\mathbf{A}]$ is invertible, the squared voltages can be recovered from the displacement coordinates:

$$
\dfrac{1}{2}{{{V}_{k}}}^{2}
=
{A}^{-1}_{kp}
\dfrac{\partial {C}_{p}}{\partial {q}_{i}}
\dfrac{\partial U}{\partial {q}_{i}}
\tag{2.8}
$$

Substituting these voltages back into the equilibrium and stiffness expressions gives equations that depend only on the mechanical coordinates. This is the **voltage-free** representation.

>[!notes] What is gained by eliminating the voltages?
>The voltage-free form separates the geometry of the equilibrium domain from the choice of voltage loading. It lets us find critical displacement configurations first, then map them back to the voltages that produce them.

## Dimensionality of the Domains
For a single-DOF, single-voltage actuator, the equilibrium set is a one-dimensional curve in the $(q,V)$ plane, and pull-in is a point on that curve.

For a system with $N$ mechanical coordinates and $K$ independent voltage sources:
- the equilibrium set is a $K$-dimensional hyper-volume in an $(N+K)$-dimensional space;
- the pull-in set is a $(K-1)$-dimensional hyper-surface inside that equilibrium set.

This is why multi-electrode pull-in is not described by one voltage value. For two independent voltages, pull-in is a line. For three independent voltages, pull-in is a surface.

# Example: Coupled Parallel-Plate Actuator

![[MCS2_002 Electromechanical Systems with N DOFs and K Voltages 2026-05-12 18.10.30.excalidraw.svg]]^figure-two-coupled-parallel-plates
>Two couples parallel-plates actuators.


Consider two coupled parallel-plate actuators with two generalized displacements ${q}_{1},{q}_{2}$ and two uncoupled electrodes. The capacitances are

$$
{C}_{i}=\dfrac{{\varepsilon}_{0}A}{g-{q}_{i}},
\qquad i=1,2
\tag{2.9}
$$

The mechanical potential is

$$
{U}_{M}
=
\dfrac{1}{2}{k}_{1}{{{q}_{1}}}^{2}
+\dfrac{1}{2}{k}_{12}({q}_{1}-{q}_{2})^{2}
+\dfrac{1}{2}{k}_{2}{{{q}_{2}}}^{2}
\tag{2.10}
$$

For the symmetric case ${k}_{1}={k}_{12}={k}_{2}=k$, define

$$
\tilde{q}_{i}=\dfrac{{q}_{i}}{g},
\qquad
\tilde{\psi}=\dfrac{\psi}{kg^{2}},
\qquad
{{\tilde{V}_{i}}}^{2}
=
\dfrac{{\varepsilon}_{0}A}{2kg^{3}}{{{V}_{i}}}^{2}
\tag{2.11}
$$

The normalized total potential becomes

$$
\tilde{\psi}
={{\tilde{q}_{1}}}^{2}
-\tilde{q}_{1}\tilde{q}_{2}
+{{\tilde{q}_{2}}}^{2}
-\dfrac{{{\tilde{V}_{1}}}^{2}}{1-\tilde{q}_{1}}
-\dfrac{{{\tilde{V}_{2}}}^{2}}{1-\tilde{q}_{2}}
\tag{2.12}
$$

Taking derivatives with respect to $\tilde{q}_{1}$ and $\tilde{q}_{2}$ gives the equilibrium equations:

$$
\begin{aligned}
{{\tilde{V}_{1}}}^{2}
&=(2\tilde{q}_{1}-\tilde{q}_{2})(1-\tilde{q}_{1})^{2} \\[1ex]
{{\tilde{V}_{2}}}^{2}
&=(2\tilde{q}_{2}-\tilde{q}_{1})(1-\tilde{q}_{2})^{2}
\end{aligned}
\tag{2.13}
$$

These equations already show that not every displacement pair is physically reachable. Since squared voltages cannot be negative,

$$
2\tilde{q}_{1}-\tilde{q}_{2}\geq 0,
\qquad
2\tilde{q}_{2}-\tilde{q}_{1}\geq 0
\tag{2.14}
$$

so the equilibrium projection in displacement space is restricted to the wedge between $\tilde{q}_{2}=2\tilde{q}_{1}$ and $\tilde{q}_{2}=\tilde{q}_{1}/2$.

The stability matrix is

$$
[\mathbf{K}]
=
\begin{pmatrix}
2-\dfrac{2{{\tilde{V}_{1}}}^{2}}{(1-\tilde{q}_{1})^{3}} & -1 \\
-1 & 2-\dfrac{2{{\tilde{V}_{2}}}^{2}}{(1-\tilde{q}_{2})^{3}}
\end{pmatrix}
\tag{2.15}
$$

Substituting $\text{(2.13)}$ into $\text{(2.15)}$ and setting $\det([\mathbf{K}])=0$ yields

$$
12{{\tilde{q}_{1}}}^{2}
+12{{\tilde{q}_{2}}}^{2}
-39\tilde{q}_{1}\tilde{q}_{2}
+7\tilde{q}_{1}
+7\tilde{q}_{2}
-3
=0
\tag{2.16}
$$

This equation describes singular stiffness states. Part of it is the actual pull-in boundary, where ${\lambda}_{\min}=0$. Another part lies inside the unstable domain and corresponds to ${\lambda}_{\max}=0$.

![[MCS2_002/coupled_parallel_plate_q_domain.svg|bookhue|600]]^figure-coupled-parallel-plate-q-domain
>Projection of the coupled parallel-plate equilibrium domain onto displacement space. The reachable equilibrium domain is the wedge between the zero-voltage boundary lines. The red curve is the pull-in line, where ${\lambda}_{\min}=0$. The magenta curve is another singular-stiffness curve, but it has ${\lambda}_{\max}=0$ and is not the stable-domain pull-in boundary.

In this graph each point corresponds to a unique displacement state. The stable region starts near the origin, where the stiffness matrix is positive definite. Moving outward eventually reaches the red curve. Crossing it makes one stiffness eigenvalue negative, so the equilibrium becomes unstable.

The two straight black lines are not stability boundaries. They are **zero-voltage boundaries**:

$$
\tilde{V}_{1}=0 \Longleftrightarrow \tilde{q}_{2}=2\tilde{q}_{1},
\qquad
\tilde{V}_{2}=0 \Longleftrightarrow \tilde{q}_{2}=\dfrac{1}{2}\tilde{q}_{1}
\tag{2.17}
$$

Outside this wedge one of the squared voltages in $\text{(2.13)}$ becomes negative, so there is no real voltage pair that can hold the actuator at that displacement.

Suppose, for example, that the system is on the $\tilde{V}_{2}=0$ boundary. That is a system which is equivalent to the one discussed in [[MCS1_001 מבוא|the preceeding course]]. Notice the red pull-in curve intersects it exactly at $\tilde{q}_{1}=1/3$. The fact that $\tilde{q}_{2}=1/6$ at that point as well is simply due to the ${k}_{12}$ spring that couples between the two plates.

The blue contours are **equi-$\tilde{V}_{1}$** curves: along each curve the value of $\tilde{V}_{1}$ is constant while $\tilde{V}_{2}$ changes. The green dashed contours are **equi-$\tilde{V}_{2}$** curves. These are the two-voltage analogue of the horizontal "fixed voltage" slices in [[MCS2_001 DIPIE#^figure-dipie-equilibrium|figure]]: if one voltage is held constant, the equilibrium state moves along the corresponding iso-voltage curve as the other voltage is varied.

The orange curves are **equi-$\tilde{\psi}$** curves, meaning constant total potential after substituting the equilibrium voltages. They do not define loading paths by themselves. Instead, they help visualize the energy landscape on the equilibrium surface. Near pull-in, the energy curvature in one direction goes to zero, which is the same statement as ${\lambda}_{\min}\to 0$.

## Voltage Projection
Mapping the same equilibrium states through $\text{(2.13)}$ gives a projection onto the $({\tilde{V}_{1}},{\tilde{V}_{2}})$ plane.

![[MCS2_002/coupled_parallel_plate_voltage_projection.svg|bookhue|600]]^figure-coupled-parallel-plate-voltage-domain
>Projection of the same equilibrium domain onto voltage space. The map from displacement space to voltage space folds the equilibrium surface, so stable and unstable equilibria can overlap in the projection.

This is why the voltage-space figure in the lecture is visually harder to understand. The plotted region is not a single sheet. It is a projection of a two-dimensional equilibrium surface, and the projection folds over itself. A point in voltage space may correspond to more than one displacement equilibrium, with different stability.

The red curve is still the pull-in line. It is the boundary of the stable operating range in voltage space: if the applied voltages cross this boundary along a given loading direction, no stable equilibrium remains on that loading path.

## $\alpha$-Lines
When $K>N$, the voltage-free elimination above is not enough: there are more voltage variables than mechanical equilibrium equations. Even when $K\leq N$, plotting the full equilibrium object may still be difficult. The $\alpha$-line strategy handles this by fixing the **direction** of the voltage vector and varying only its magnitude.

For two voltage sources, an $\alpha$-line can be written as

$$
\tilde{V}_{2}=\alpha \tilde{V}_{1}
$$

More generally, choose a direction vector

$$
\boldsymbol{\alpha}=({\alpha}_{1},{\alpha}_{2},\dots,{\alpha}_{K})
$$

and write

$$
\tilde{V}_{k}={\alpha}_{k}\tilde{V}
$$

where $\tilde{V}$ is a single scalar loading amplitude. The multi-voltage problem is now sliced into a one-parameter problem along a ray in voltage space.

![[MCS2_002/alpha_lines_voltage_projection.svg|bookhue|600]]^figure-alpha-lines-voltage-projection
>$\alpha$-lines in the voltage projection. Each line fixes a voltage ratio and asks how far one can move along that direction before reaching the pull-in boundary.

The interpretation is direct:
- $\alpha=0$ means only electrode $1$ is driven;
- $\alpha=\infty$ means only electrode $2$ is driven;
- $\alpha=1$ is symmetric actuation;
- intermediate slopes describe mixed actuation.

For a selected $\alpha$, the pull-in voltage is found where that line reaches the pull-in boundary. Sweeping $\alpha$ traces the entire pull-in line in the two-voltage problem. In a three-voltage problem, the same idea sweeps a two-dimensional pull-in surface.

>[!notes] Why these are called lines
>The name does not mean the mechanical trajectory is a straight line in displacement space. It means the voltage vector moves along a straight line in voltage space. The corresponding displacement path can be curved and may pass through complicated stable and unstable regions.

# Example: Interdigitated-Fingers Actuator

![[MCS2_002 Electromechanical Systems with N DOFs and K Voltages 2026-05-12 21.16.50.excalidraw.svg]]
>Interdigitated fingers actuator with crab-leg suspension. The well-known comb drive is a special case for which ${V}_{1}={V}_{2}$.

Consider an interdigitated-fingers actuator with crab-leg suspension. The familiar comb-drive case is recovered when the two side voltages are equal, $\tilde{V}_{1}=\tilde{V}_{2}$.

Let $\tilde{q}_{1}$ be the axial overlap displacement and $\tilde{q}_{2}$ be the transverse displacement normalized by the gap. The transverse coordinate is therefore bounded by $-1<\tilde{q}_{2}<1$. A compact normalized potential for this model is

$$
\tilde{\psi}
=
\dfrac{1}{2}{{\tilde{q}_{1}}}^{2}
+\dfrac{1}{2}\kappa {{\tilde{q}_{2}}}^{2}
-(1+\tilde{q}_{1})
\left[
\dfrac{{{\tilde{V}_{1}}}^{2}}{1-\tilde{q}_{2}}
+\dfrac{{{\tilde{V}_{2}}}^{2}}{1+\tilde{q}_{2}}
\right]
\tag{2.18}
$$
Where
$$\begin{aligned}
 & \tilde{\psi}=\dfrac{\psi}{{k}_{1}OL^{2}}, &  & {{\tilde{V}_{i}}}^{2}=\dfrac{{N}_{t}{\varepsilon}_{0}b}{2{k}_{1}gOL}{{{V}_{i}}}^{2} \\[1ex]
 & \tilde{q}_{1}=\dfrac{{q}_{1}}{OL}, &  & \tilde{q}_{2}=\dfrac{{q}_{2}}{g} \\[1ex]
 & \kappa=\dfrac{{k}_{2}}{{k}_{1}} \dfrac{g^{2}}{OL^{2}}
\end{aligned}\tag{2.19}$$


To derive the stiffness matrix, differentiate the potential $\text{(2.18)}$ at fixed voltages. The first derivatives are

$$
\begin{aligned}
\dfrac{\partial \tilde{\psi}}{\partial \tilde{q}_{1}}
&=
\tilde{q}_{1}
-\left[
\dfrac{{{\tilde{V}_{1}}}^{2}}{1-\tilde{q}_{2}}
+\dfrac{{{\tilde{V}_{2}}}^{2}}{1+\tilde{q}_{2}}
\right] \\[1ex]
\dfrac{\partial \tilde{\psi}}{\partial \tilde{q}_{2}}
&=
\kappa\tilde{q}_{2}
-(1+\tilde{q}_{1})
\left[
\dfrac{{{\tilde{V}_{1}}}^{2}}{(1-\tilde{q}_{2})^{2}}
-\dfrac{{{\tilde{V}_{2}}}^{2}}{(1+\tilde{q}_{2})^{2}}
\right]
\end{aligned}
\tag{2.20}
$$

Solving the two equilibrium equations for the voltages gives

$$
\begin{align}
{{\tilde{V}_{1}}}^{2}
&=
\dfrac{(1-\tilde{q}_{2})^{2}}{2(1+\tilde{q}_{1})}
\left[
{{\tilde{q}_{1}}}^{2}+\tilde{q}_{1}
+\kappa{{\tilde{q}_{2}}}^{2}+\kappa\tilde{q}_{2}
\right]\tag{2.21} \\[1ex]
{{\tilde{V}_{2}}}^{2}
&=
\dfrac{(1+\tilde{q}_{2})^{2}}{2(1+\tilde{q}_{1})}
\left[
{{\tilde{q}_{1}}}^{2}+\tilde{q}_{1}
+\kappa{{\tilde{q}_{2}}}^{2}-\kappa\tilde{q}_{2}
\right] \tag{2.22}
\end{align}
$$

The tangent stiffness matrix is the Hessian:

$$
[\mathbf{K}]
=
\begin{pmatrix}
\dfrac{\partial^{2}\tilde{\psi}}{\partial {{\tilde{q}_{1}}}^{2}} &
\dfrac{\partial^{2}\tilde{\psi}}{\partial \tilde{q}_{1}\partial \tilde{q}_{2}} \\[2ex]
\dfrac{\partial^{2}\tilde{\psi}}{\partial \tilde{q}_{2}\partial \tilde{q}_{1}} &
\dfrac{\partial^{2}\tilde{\psi}}{\partial {{\tilde{q}_{2}}}^{2}}
\end{pmatrix}
\tag{2.23}
$$

Therefore

$$
\begin{aligned}
 & {K}_{11}=1 \\[1ex]
 & {K}_{12}={K}_{21}=
-\dfrac{{{\tilde{V}_{1}}}^{2}}{(1-\tilde{q}_{2})^{2}}
+\dfrac{{{\tilde{V}_{2}}}^{2}}{(1+\tilde{q}_{2})^{2}} \\[1ex]
 & {K}_{22}=
\kappa-2(1+\tilde{q}_{1})\left[
\dfrac{{{\tilde{V}_{1}}}^{2}}{(1-\tilde{q}_{2})^{3}}
+\dfrac{{{\tilde{V}_{2}}}^{2}}{(1+\tilde{q}_{2})^{3}}\right]
\end{aligned}
\tag{2.24}
$$



In the MATLAB code, the voltages in $\text{(2.20)}$ and $\text{(2.21)}$ are substituted into these entries before computing the eigenvalues of $[\mathbf{K}]$.

The pull-in equation is derived in the form
$$\kappa ^{2}{{\tilde{q}_{2}}}^{4}-[5\kappa(1+\tilde{q}_{1})^{2}+\kappa ^{2}]{{\tilde{q}_{2}}}^{2}-[2\tilde{q}_{1}(1+\tilde{q}_{1})-\kappa](1+\tilde{q}_{1})^{2}=0\tag{2.25}$$

![[MCS2_002/interdigitated_fingers_q_domain.svg|bookhue|600]]^figure-interdigitated-fingers-q-domain
>Projection of the interdigitated-fingers equilibrium domain onto displacement space for $\kappa=1$. The red curve is the pull-in line. The vertical line $\tilde{q}_{2}=0$ is the comb-drive direction, where $\tilde{V}_{1}=\tilde{V}_{2}$ and the electrostatic force is mainly axial. The side regions are excluded because one of the required squared voltages becomes negative.

The meaning of this figure is the same as in the coupled parallel-plate example, but the geometry is different. The two side electrodes create forces in opposite transverse directions. Equal voltages cancel the transverse component and pull the shuttle in the axial direction. Unequal voltages introduce a transverse bias, so the equilibrium path bends toward one side gap.

The dashed and dotted curves are iso-voltage curves. The red pull-in line is where the smallest eigenvalue of the stiffness matrix vanishes.

%%
The vector ${\boldsymbol{\beta}}_{PI}$ marks the local deformation direction that loses stiffness first.
%%

## Connection to DIPIE
The $\alpha$-line strategy is especially useful for distributed actuators, such as a clamped-clamped beam with multiple electrodes. The full problem has many displacement degrees of freedom and several voltage sources.

A practical workflow is:
1. Choose a voltage direction $\boldsymbol{\alpha}$.
2. Substitute $\tilde{V}_{k}={\alpha}_{k}\tilde{V}$ so the problem has one voltage amplitude.
3. Use a displacement-controlled solver such as DIPIE to trace equilibria along that slice.
4. Compute the stability matrix at each equilibrium.
5. Identify the point where ${\lambda}_{\min}=0$.
6. Sweep over many $\boldsymbol{\alpha}$ directions to reconstruct the pull-in line or surface.

This is the conceptual reason the lecture combines $\alpha$-lines with DIPIE. DIPIE gives access to unstable equilibrium states that voltage iteration cannot trace, while $\alpha$-lines organize a multi-voltage system into controlled one-dimensional slices.

>[!notes] What to remember
>For one voltage, pull-in is a point on an equilibrium curve. For two voltages, pull-in is a curve in voltage space. For three voltages, it is a surface. The stability condition is always the same: the smallest eigenvalue of the tangent stiffness matrix goes to zero.
