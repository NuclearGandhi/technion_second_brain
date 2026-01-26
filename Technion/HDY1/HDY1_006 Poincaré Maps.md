---
aliases:
---
# Analysis of Periodic Solutions

Many dynamical systems exhibit **periodic solutions** - trajectories that repeat after some period ${t}_{p}$:
$$\mathbf{x}(t)=\mathbf{x}(t+{t}_{p})\tag{6.1}$$

These periodic orbits arise in various contexts:

**Conservative systems** such as the harmonic oscillator $m\ddot{y}+ky=0$ or the pendulum $I\ddot{y}+mgr\sin y=0$ naturally possess families of periodic orbits at different energy levels. For these systems with zero energy dissipation (${y}_{e}=0$), every bounded trajectory in the neighborhood of a stable equilibrium is periodic.

**Non-conservative systems** can also exhibit isolated periodic orbits called **limit cycles**. A classic example is the Van der Pol oscillator:
$$\ddot{y}-\mu(1-y^{2})\dot{y}+y=0\tag{6.2}$$

For $\mu>0$, this system has negative damping for small amplitudes ($\lvert y \rvert<1$) and positive damping for large amplitudes ($\lvert y \rvert>1$). This creates a self-sustained oscillation where trajectories spiral toward a unique limit cycle regardless of initial conditions - the system "pumps" energy at small amplitudes and dissipates it at large amplitudes.

![[HDY1_006/HDY1_006 van der pol.png|bookhue|600]]^figure-van-der-pol
>Phase portrait of the Van der Pol oscillator showing the limit cycle (red) and trajectories spiraling toward it from both inside and outside.

**Systems with periodic excitation** of the form $\dot{\mathbf{x}}=\mathbf{f}(\mathbf{x},\mathbf{u}(t))$ where $\mathbf{u}(t)=\mathbf{u}(t+{t}_{p})$ are naturally candidates for periodic response. Examples include vibrating machinery, walking robots with periodic gait controllers, and swimming organisms.

**Autonomous systems with feedback** $\dot{\mathbf{x}}=\mathbf{f}(\mathbf{x},\mathbf{u}(\mathbf{x}))$ may possess limit cycles arising from the interplay between the dynamics and the feedback law. This is particularly common in locomotion systems where the controller induces a relative periodic orbit.

Understanding the **existence and stability** of periodic solutions is crucial for:
- Predicting long-term behavior of oscillating systems
- Designing controllers for periodic tasks (walking, running, swimming)
- Analyzing bifurcations as system parameters vary

# The Poincaré Map

The **Poincaré map** (also called the return map or first-return map) is a powerful tool for analyzing periodic solutions. It transforms the study of continuous-time dynamics into a discrete-time map, reducing the problem dimension and providing clear stability criteria.

## Definition and Construction

Consider a dynamical system:
$$\dot{\mathbf{x}}=\mathbf{f}(\mathbf{x},\mathbf{u}(\mathbf{x},t)),\qquad \mathbf{x}\in \mathbb{R}^{n}\tag{6.3}$$

We define a **Poincaré section** $\Sigma$ as a hypersurface in state space:
$$\Sigma=\{ \mathbf{x}(t):\sigma(\mathbf{x},t)=0 \}\tag{6.4}$$

where $\sigma:\mathbb{R}^{n}\times \mathbb{R}\to \mathbb{R}$ is a smooth scalar function.

![[HDY1_006 Poincaré Maps 2026-01-24 18.25.54.excalidraw.svg]]
^figure-poincare-section
>Geometric construction of the Poincaré map. A trajectory starting at $\mathbf{x}_{0}\in\Sigma$ flows according to $\boldsymbol{\varphi}(\mathbf{x}_{0},t)$ and returns to $\Sigma$ at time ${t}_{1}$, defining $\Pi(\mathbf{x}_{0})=\mathbf{x}({t}_{1})$.

The **Poincaré map** $\Pi:\Sigma\to\Sigma$ is defined as follows: for any initial condition $\mathbf{x}_{0}\in\Sigma$, we define:
$$\Pi(\mathbf{x}_{0})=\mathbf{x}({t}_{1})\tag{6.5}$$

where ${t}_{1}=\min\{ t>{t}_{0}:\mathbf{x}(t)\in\Sigma \}$ is the first return time to the section.

Common choices for the Poincaré section include:

1. **Time-periodic sampling** for systems with periodic forcing:
   $$\Sigma=\{ t=k{t}_{p},\,k\in\mathbb{N} \}$$
   This samples the state at integer multiples of the forcing period.

2. **State-based section** for autonomous systems:
   $$\Sigma=\{ \mathbf{x}:\sigma(\mathbf{x})=0 \}$$
   where $\sigma$ is some scalar function of state (e.g., $\sigma(\mathbf{x})=\dot{y}=0$ samples at velocity zero-crossings).

The section $\Sigma$ is a surface of dimension $n-1$. Due to system invariances, the effective dimension can often be further reduced. For example, in systems with translation invariance in $x$, we can define a **reduced state vector** $\mathbf{z}$ on $\Sigma$ with $\dim(\mathbf{z})<n-1$.

## Discrete-Time Dynamics

The Poincaré map transforms the continuous flow into a discrete-time dynamical system:
$$\mathbf{z}_{k+1}=\Pi(\mathbf{z}_{k})\tag{6.6}$$

where $\mathbf{z}_{k}$ represents the (reduced) state on $\Sigma$ at the $k$-th crossing.

>[!notes] Note: 
>In most cases, $\Pi(\mathbf{z})$ cannot be computed analytically - it requires numerical integration of the ODE from initial condition $\mathbf{z}_{k}$ until the next event $\sigma(\mathbf{x}(t))=0$.

## Fixed Points and Periodic Orbits

A **fixed point** $\mathbf{z}^{*}$ of the Poincaré map satisfies:
$$\mathbf{z}^{*}=\Pi(\mathbf{z}^{*})\tag{6.7}$$

This corresponds to a **periodic solution** of the original continuous-time system $\dot{\mathbf{x}}=\mathbf{f}(\mathbf{x},\mathbf{u}(\mathbf{x},t))$. The trajectory starting from $\mathbf{z}^{*}$ returns exactly to $\mathbf{z}^{*}$ after one period.

More generally, a **period-$k$ orbit** consists of $k$ distinct points $\{ \mathbf{z}^{*}_{1},\mathbf{z}^{*}_{2},\dots,\mathbf{z}^{*}_{k} \}$ that cycle through each other:
$$\Pi(\mathbf{z}^{*}_{i})=\mathbf{z}^{*}_{i+1},\qquad \Pi(\mathbf{z}^{*}_{k})=\mathbf{z}^{*}_{1}$$

This corresponds to a periodic solution with period $k{t}_{p}$ that crosses $\Sigma$ exactly $k$ times per cycle.

# Stability of Periodic Solutions

## Linearization about the Fixed Point

To analyze the local stability of a periodic orbit, we linearize the Poincaré map about its fixed point. Define the deviation from the fixed point:
$$\tilde{\mathbf{z}}=\mathbf{z}-\mathbf{z}^{*}\tag{6.8}$$

The linearized dynamics are:
$$\tilde{\mathbf{z}}_{k+1}=\mathbf{A}\tilde{\mathbf{z}}_{k}\tag{6.9}$$

where the **Jacobian matrix** (also called the monodromy matrix) is:
$$\mathbf{A}=\left.\dfrac{\mathrm{d}\Pi}{\mathrm{d}\mathbf{z}}\right|_{\mathbf{z}=\mathbf{z}^{*}}\tag{6.10}$$

The solution of the linearized system is:
$$\tilde{\mathbf{z}}_{k}=\mathbf{A}^{k}\tilde{\mathbf{z}}_{0}\tag{6.11}$$

## Stability Criterion

The behavior of $\tilde{\mathbf{z}}_{k}$ as $k\to\infty$ is determined by the eigenvalues ${\lambda}_{i}$ of $\mathbf{A}$.

>[!theorem] Theorem: Local Asymptotic Stability
>The fixed point $\mathbf{z}^{*}$ is **locally asymptotically stable** if and only if all eigenvalues of $\mathbf{A}$ lie strictly inside the unit circle:
>$$\lvert {\lambda}_{i}(\mathbf{A}) \rvert<1\qquad \forall\,i\tag{6.12}$$

This is the discrete-time analogue of the continuous-time criterion that eigenvalues must have negative real parts. The eigenvalues ${\lambda}_{i}$ are called **Floquet multipliers** of the periodic orbit.

**Physical interpretation**: Each eigenvalue ${\lambda}_{i}$ describes how perturbations along the corresponding eigenvector direction evolve from one Poincaré crossing to the next:
- $\lvert {\lambda}_{i} \rvert<1$: perturbations decay (stable direction)
- $\lvert {\lambda}_{i} \rvert>1$: perturbations grow (unstable direction)
- $\lvert {\lambda}_{i} \rvert=1$: perturbations neither grow nor decay (marginal)

## Graphical Analysis for 1D Maps

When the Poincaré map is **scalar** (1D), we can analyze it graphically. Plotting $\Pi(z)$ vs $z$:

- **Fixed points** are intersections with the line $y=z$
- **Stability** is determined by the slope $\left\lvert \dfrac{\mathrm{d}\Pi}{\mathrm{d}z}\right\rvert_{z=z^{*}}<1$

![[HDY1_006/HDY1_006 SLIP Poincare map.png|bookhue|600]]^figure-slip-poincare-map
>Poincaré map for the SLIP model showing $\bar{y}_{k+1}$ vs $\bar{y}_{k}$ for different touchdown angles ${\theta}_{0}$. Fixed points occur at intersections with the dashed line $y=x$. Stability requires the curve to cross the diagonal with slope magnitude less than 1.

For even 2D maps, graphical visualization through contour plots of $\lVert \mathbf{G}(\mathbf{z}) \rVert$ where $\mathbf{G}(\mathbf{z})=\Pi(\mathbf{z})-\mathbf{z}$ can help locate fixed points as local minima.

# Example: SLIP - Spring-Loaded Inverted Pendulum

The **SLIP model** (Spring-Loaded Inverted Pendulum) is a fundamental template for understanding dynamic legged locomotion, particularly running and hopping gaits. Despite its simplicity, it captures essential features of running dynamics observed in animals ranging from cockroaches to horses.

![[HDY1_006 Poincaré Maps 2026-01-25 22.31.07.excalidraw.svg]]^figure-slip-model
>The SLIP model: a point mass $m$ connected to a massless spring of stiffness $k$ and rest length ${\ell}_{0}$. The leg touches down at angle ${\theta}_{0}$ and the system alternates between flight and stance phases.

## Model Description

The SLIP consists of:
- A point mass $m$ representing the body
- A massless spring leg with stiffness $k$ and rest length ${\ell}_{0}$
- Coordinates $(x,y)$ for the mass position, with $\theta$ as the leg angle during stance

The dynamics are **piecewise-defined** (hybrid):

**Free flight** (leg not in contact):
$$\ddot{x}=0,\qquad \ddot{y}=-g\tag{6.13}$$

The leg angle can be set to a constant touchdown angle $\theta={\theta}_{0}$ or follow a prescribed trajectory $\theta(t)$.

**Ground contact** (when $r\leq {\ell}_{0}$ and foot touches ground):

Using polar coordinates $(r,\theta)$ centered at the foot contact point:
$$\begin{aligned}
&m\ddot{r}-mr\dot{\theta}^{2}-k({\ell}_{0}-r)+mg\cos\theta=0\\[1ex]
&mr^{2}\ddot{\theta}+2mr\dot{r}\dot{\theta}-mgr\sin\theta=0
\end{aligned}\tag{6.14}$$

The first equation is the radial force balance (spring force, centrifugal, gravity). The second is angular momentum about the foot.

## Poincaré Section

A natural choice for the Poincaré section is the **apex of flight** where vertical velocity is zero:
$$\Sigma=\{ (x,y,\dot{x},\dot{y}):\dot{y}=0,\,y>{\ell}_{0}\sin{\theta}_{0} \}\tag{6.15}$$

At apex, the state is characterized by:
- Apex height $y$ (or equivalently ${y}_{k}$ at the $k$-th apex)
- Horizontal velocity $\dot{x}$ (or equivalently ${\dot{x}}_{k}$)
- Horizontal position $x_{k}$ (often irrelevant due to translation invariance)

**Dimension reduction**: The SLIP has translation invariance in $x$, so the horizontal position is irrelevant for the periodic orbit itself. Furthermore, if we consider a fixed energy level $E=\text{const}$, then energy conservation:
$$E=\dfrac{1}{2}m(\dot{x}^{2}+\dot{y}^{2})+mgy=\dfrac{1}{2}m\dot{x}^{2}({t}_{\text{peak}})+mgy({t}_{\text{peak}})$$

reduces the apex state to a single coordinate - the apex height ${y}_{k}$.

This yields a **1D Poincaré map** of peak heights:
$${y}_{k+1}=\Pi({y}_{k})\tag{6.16}$$

## Fixed Points and Stability

Fixed points ${y}^{*}=\Pi({y}^{*})$ correspond to **symmetric periodic running gaits** where the apex height remains constant from stride to stride.

Stability depends on the slope of the Poincaré map at the fixed point:
$$\left\lvert \dfrac{\mathrm{d}\Pi}{\mathrm{d}y}\right\rvert_{{y}^{*}}<1\implies \text{stable}\tag{6.17}$$

The SLIP Poincaré map depends on the touchdown angle ${\theta}_{0}$:
- For steep angles (large ${\theta}_{0}$), the map may have no fixed points (the runner falls)
- For shallow angles (small ${\theta}_{0}$), fixed points exist but may be unstable
- At intermediate angles, stable running gaits exist

## Swing Leg Retraction

A simple control strategy that significantly improves stability is **swing leg retraction**:
$$\theta(t)={\theta}_{0}-\omega(t-{t}_{\text{peak}})\tag{6.18}$$

where $\omega>0$ is a retraction rate and ${t}_{\text{peak}}$ is the time of the previous apex. The leg sweeps backward during flight, reducing the effective touchdown angle as the body descends.

This control law flattens the Poincaré map curve near the fixed point, reducing $\lvert \mathrm{d}\Pi/\mathrm{d}y \rvert$ and improving stability. Remarkably, swing leg retraction is observed in running animals and is believed to contribute to their robust dynamic stability.

# Example: The Rimless Spoked Wheel

The **rimless wheel** is the simplest model of passive dynamic walking. It consists of $n$ massless spokes of length $l$ attached to a central hub with mass $m$ and moment of inertia ${I}_{c}$, rolling down a slope of angle $\alpha$.

![[HDY1_006 Poincaré Maps rimless wheel placeholder.svg|bookhue|600]]^figure-rimless-wheel-model
>The rimless spoked wheel with $n$ spokes of length $l$ rolling down a slope of angle $\alpha$. The angle $\theta$ is measured from the vertical to the stance leg.

## Continuous Dynamics

Between impacts, the wheel behaves as an inverted pendulum pivoting about the stance foot. The equation of motion is:
$$\ddot{\theta}-\sin(\theta+\alpha)/{{\tau}_{c}}^{2}=0\tag{6.19}$$

where the characteristic time is:
$${\tau}_{c}=\sqrt{\dfrac{ml^{2}+{I}_{c}}{mgl}}\tag{6.20}$$

This can be rewritten in the familiar pendulum form using nondimensional time $\tau=t/{\tau}_{c}$.

**Energy integral**: Multiplying equation $\text{(6.19)}$ by $\dot{\theta}$ and integrating:
$$\dot{\theta}^{2}={\dot{\theta}_{0}}^{2}+2\cos\left( \alpha-\dfrac{\pi}{n} \right)-2\cos(\alpha+\theta)\tag{6.21}$$

where ${\dot{\theta}}_{0}$ is the angular velocity immediately after an impact.

## Impact Law

When a new spoke touches the ground (at $\theta=-\pi/n$ measured from vertical), an **impulsive collision** occurs. Assuming:
- Frictionless, perfectly plastic impact (no bounce)
- Instantaneous transfer to the new stance leg

Angular momentum about the new contact point is conserved:
$$\dot{\theta}^{+}=\beta\dot{\theta}^{-}\tag{6.22}$$

where the **collision factor** is:
$$\beta=\dfrac{\cos(2\pi/n)+\kappa}{1+\kappa},\qquad \kappa=\dfrac{{I}_{c}}{ml^{2}}\tag{6.23}$$

Note that $\beta<1$ for all $n\geq 3$ and $\kappa\geq 0$, meaning energy is lost at each impact.

## Poincaré Map

We define the Poincaré section at the instant **just after impact**:
$$\Sigma=\{ (\theta,\dot{\theta}):\theta=-\pi/n,\,\dot{\theta}>0 \}\tag{6.24}$$

The state on $\Sigma$ is characterized by a single variable - the post-impact angular velocity ${\dot{\theta}}_{0}$.

The Poincaré map $\Pi:{\dot{\theta}}_{0}\mapsto{\dot{\theta}}_{0}^{+}$ (post-impact velocity maps to next post-impact velocity) is obtained by:

1. Integrating equation $\text{(6.21)}$ from $\theta=-\pi/n$ to $\theta=+\pi/n$ (one swing)
2. Applying the impact law $\text{(6.22)}$

The pre-impact velocity at $\theta=+\pi/n$ is (from energy integral):
$$\dot{\theta}_{c}^{-}=\sqrt{{\dot{\theta}_{0}}^{2}+4\sin\alpha\sin(\pi/n)}\tag{6.25}$$

After impact:
$$\Pi({\dot{\theta}}_{0})={\dot{\theta}}_{c}^{+}=\beta\sqrt{{\dot{\theta}_{0}}^{2}+4\sin\alpha\sin(\pi/n)}\tag{6.26}$$

## Fixed Point and Stability

Setting ${\dot{\theta}}^{*}=\Pi({\dot{\theta}}^{*})$:
$${\dot{\theta}}^{*}=\beta\sqrt{{{\dot{\theta}}^{*}}^{2}+4\sin\alpha\sin(\pi/n)}$$

Solving:
$${{\dot{\theta}}^{*}}^{2}=\beta^{2}{{\dot{\theta}}^{*}}^{2}+4\beta^{2}\sin\alpha\sin(\pi/n)$$
$${{\dot{\theta}}^{*}}^{2}(1-\beta^{2})=4\beta^{2}\sin\alpha\sin(\pi/n)$$

Therefore:
$${\dot{\theta}}^{*}=2\beta\sqrt{\dfrac{\sin\alpha\sin(\pi/n)}{1-\beta^{2}}}\tag{6.27}$$

**Stability**: The derivative of the Poincaré map is:
$$\dfrac{\mathrm{d}\Pi}{\mathrm{d}{\dot{\theta}}_{0}}\bigg|_{{\dot{\theta}}^{*}}=\dfrac{\beta{\dot{\theta}}^{*}}{\sqrt{{{\dot{\theta}}^{*}}^{2}+4\sin\alpha\sin(\pi/n)}}=\dfrac{\beta{\dot{\theta}}^{*}}{{\dot{\theta}}^{*}/\beta}=\beta^{2}\tag{6.28}$$

Since $\beta^{2}<1$ for any physical wheel ($n\geq 3$, $\kappa\geq 0$), the fixed point is **always stable**!

This remarkable result means that the rimless wheel naturally settles into a steady rolling gait without any control - it is **passively stable**. This insight was the foundation for the field of passive dynamic walking.

## Friction Requirements

For the no-slip assumption to hold during stance, the friction force must not exceed the friction limit. The tangential-to-normal force ratio along the periodic orbit must satisfy:
$$\left\lvert \dfrac{{\lambda}_{t}}{{\lambda}_{n}} \right\rvert\leq\mu\tag{6.29}$$

Analysis shows that this ratio reaches its maximum magnitude near the impact events. For typical parameters, a friction coefficient $\mu\gtrsim 0.3$ is sufficient to prevent slipping.

![[HDY1_006/HDY1_006 rimless wheel phase plane.png|bookhue|600]]^figure-rimless-wheel-phase-plane
>Phase plane trajectories (left) and friction force ratio (right) for the rimless wheel. The periodic orbit involves a sequence of parabolic arcs connected by impacts.

# Passive Dynamics of the Compass Biped

The **compass biped** (or compass gait walker) extends the rimless wheel concept to a system with two legs that alternate as stance and swing limbs.

![[HDY1_006 Poincaré Maps compass biped placeholder.svg|bookhue|600]]^figure-compass-biped-model
>The compass biped model: two legs of length $l$ with point masses $m$ at the feet and a hip mass ${m}_{h}$. The walker descends a slope of angle $\alpha$ through alternating single-support phases and impulsive leg exchanges.

## Model Description

The compass biped consists of:
- Two massless legs of length $l$
- Point masses $m$ at each foot
- Hip mass ${m}_{h}$ at the leg junction
- Slope angle $\alpha$

**Configuration**: During single support, the stance leg angle ${\theta}_{1}$ and swing leg angle ${\theta}_{2}$ describe the configuration. A step completes when the swing foot strikes the ground.

**Degrees of freedom**: The system has 2 DOF during single support, giving a 4D state space $(\theta_{1},\theta_{2},\dot{\theta}_{1},\dot{\theta}_{2})$.

## Poincaré Section

The natural Poincaré section is at **heel-strike** (impact + foot relabeling):
$$\Sigma=\{ ({\theta}_{1},\dot{{\theta}}_{1}):\theta_{2}=-\theta_{1},\,\dot{\theta}_{2}<0 \}\tag{6.30}$$

Due to the leg-exchange symmetry and kinematic constraint at impact, the effective state on $\Sigma$ is 2D: $({\theta}_{1},\dot{{\theta}}_{1})$ where ${\theta}_{1}$ is the stance leg angle just after impact.

## Periodic Orbits

Finding periodic gaits requires solving for fixed points of the 2D Poincaré map. Unlike the rimless wheel, this generally requires numerical methods.

![[HDY1_006/HDY1_006 compass biped phase.png|bookhue|600]]^figure-compass-biped
>Phase portrait of a stable compass biped walking cycle. The closed orbit shows the periodic evolution of $(\theta_{1},\dot{\theta}_{1})$ with impacts and foot relabeling events marked.

Research questions for the compass biped include:
- How to find periodic solutions numerically?
- How to analyze their stability?
- What happens with slip↔stick transitions?

These are addressed in the following sections on numerical methods.

# Numerical Analysis of Periodic Solutions

In most practical cases, the Poincaré map $\Pi(\mathbf{z})$ cannot be computed analytically. We must resort to numerical methods for:
1. Evaluating $\Pi(\mathbf{z})$ for a given initial condition
2. Finding fixed points $\mathbf{z}^{*}$ such that $\Pi(\mathbf{z}^{*})=\mathbf{z}^{*}$
3. Computing the Jacobian $\mathbf{A}=\mathrm{d}\Pi/\mathrm{d}\mathbf{z}$ for stability analysis

## Computing the Poincaré Map

To evaluate $\Pi(\mathbf{z}_{k})$:

1. **Set initial conditions**: Convert the reduced state $\mathbf{z}_{k}\in\Sigma$ to full state $\mathbf{x}({t}_{0})$
2. **Integrate the ODE**: Use a numerical integrator (e.g., `ode45`) with event detection
3. **Detect section crossing**: Stop integration when $\sigma(\mathbf{x}(t))=0$
4. **Extract return state**: Convert full state back to reduced state $\mathbf{z}_{k+1}$

For hybrid systems, the integration must handle discrete jumps (impacts, mode switches) by incorporating the appropriate reset maps.

## Finding Fixed Points

A fixed point satisfies $\mathbf{z}^{*}=\Pi(\mathbf{z}^{*})$, or equivalently:
$$\mathbf{G}(\mathbf{z})=\Pi(\mathbf{z})-\mathbf{z}=\mathbf{0}\tag{6.31}$$

This is a system of $n$ nonlinear equations in $n$ unknowns (where $n=\dim(\mathbf{z})$).

**MATLAB's `fsolve`** is the standard tool:

```matlab
[z_star, fval, exitflag, output, jacobian] = fsolve(@G, z0, options)
```

where `G` is a function that computes $\mathbf{G}(\mathbf{z})=\Pi(\mathbf{z})-\mathbf{z}$.

>[!notes] Notes: 
>- `fsolve` requires an initial guess $\mathbf{z}_{0}$ and finds only a single local solution
>- Multiple fixed points require multiple initial guesses or global search methods
>- For 1D maps, graphical analysis can identify good initial guesses

## Finding All Solutions

To locate all fixed points:

**1D map**: Plot $\Pi(z)$ and $G(z)=\Pi(z)-z$ over a range of $z$. Fixed points are where $\Pi(z)$ crosses the diagonal (or $G(z)$ crosses zero).

**2D map**: Compute $\lVert \mathbf{G}(\mathbf{z}) \rVert$ over a discrete grid in the $(z_{1},z_{2})$ plane. Create a height map or contour plot - fixed points appear as local minima approaching zero.

![[HDY1_006/HDY1_006 2D fixed point search.png|bookhue|600]]^figure-2d-fixed-point-search
>Contour plot of $\lVert \mathbf{G}(\mathbf{z}) \rVert$ for a 2D Poincaré map. Local minima (dark regions) indicate candidate fixed points to be refined with `fsolve`.

**Higher dimensions**: Use MATLAB's `MultiStart` with multiple random initial guesses, or continuation methods that track solution branches as parameters vary.

**Continuation method**: If a fixed point $\mathbf{z}^{*}(\mu)$ is known for parameter value $\mu$, then for a small increment $\Delta\mu$, use $\mathbf{z}^{*}(\mu)$ as the initial guess for finding $\mathbf{z}^{*}(\mu+\Delta\mu)$. This exploits the continuity of $\Pi(\mathbf{z})$ in parameters.

# Stability of Periodic Solutions - Numerical Methods

## Computing the Jacobian

After finding a fixed point $\mathbf{z}^{*}$, we need the Jacobian $\mathbf{A}=\dfrac{\mathrm{d}\Pi}{\mathrm{d}\mathbf{z}}\big|_{\mathbf{z}^{*}}$ for stability analysis.

**Finite difference approximation**: The $i$-th column of $\mathbf{A}$ is:
$$\mathbf{v}_{i}=\dfrac{\mathrm{d}\Pi}{\mathrm{d}z_{i}}\bigg|_{\mathbf{z}^{*}}\approx\dfrac{1}{\varepsilon}\left( \Pi(\mathbf{z}^{*}+\varepsilon\mathbf{e}_{i})-\mathbf{z}^{*} \right)\tag{6.32}$$

where $\mathbf{e}_{i}=[0,\dots,0,1,0,\dots,0]^{T}$ is the $i$-th standard basis vector and $\varepsilon\ll 1$ is a small perturbation (typically $\varepsilon\sim 10^{-6}$).

Thus:
$$\mathbf{A}=[\mathbf{v}_{1}\;\mathbf{v}_{2}\;\cdots\;\mathbf{v}_{n}]\tag{6.33}$$

**Using `fsolve`'s Jacobian**: MATLAB's `fsolve` can compute the Jacobian of $\mathbf{G}(\mathbf{z})$ internally. Since:
$$\mathbf{G}(\mathbf{z})=\Pi(\mathbf{z})-\mathbf{z}\implies \dfrac{\mathrm{d}\mathbf{G}}{\mathrm{d}\mathbf{z}}=\dfrac{\mathrm{d}\Pi}{\mathrm{d}\mathbf{z}}-\mathbf{I}$$

we have:
$$\mathbf{A}=\dfrac{\mathrm{d}\Pi}{\mathrm{d}\mathbf{z}}=\dfrac{\mathrm{d}\mathbf{G}}{\mathrm{d}\mathbf{z}}+\mathbf{I}\tag{6.34}$$

The eigenvalues are related by:
$${\lambda}_{i}(\mathbf{A})={\lambda}_{i}\left( \dfrac{\mathrm{d}\mathbf{G}}{\mathrm{d}\mathbf{z}} \right)+1\tag{6.35}$$

## Stability Criterion

The periodic solution is **locally asymptotically stable** if all eigenvalues ${\lambda}_{i}(\mathbf{A})$ satisfy:
$$\lvert {\lambda}_{i}(\mathbf{A}) \rvert<1\qquad \forall\,i\tag{6.36}$$

>[!notes] Note: 
>Unlike forward-time simulation which can only find stable solutions, `fsolve` can locate both stable and unstable periodic orbits. This is valuable for understanding the global structure of the dynamics and bifurcations.

## Special Cases of Jacobian Eigenvalues

**${\lambda}_{i}=0$ identically**: This can occur in hybrid systems where the Poincaré section is defined at a state that not all modes visit. For example, if $\Sigma$ is defined at slipping contact but the periodic orbit also includes a no-slip phase, the effective rank of $\mathbf{A}$ may be reduced.

**${\lambda}_{i}=1$ identically**: This indicates an **invariant coordinate** - a direction along which the map has no effect. Examples:
- Translation-invariant systems with $\mathbf{z}=(y_{k},x_{k})$: horizontal position $x$ evolves but doesn't affect the dynamics
- Systems with a conserved quantity: if $E(y_{k},\dot{x}_{k})=\text{const}$ defines a curve in $\Sigma$, motion along this curve has $\lambda=1$

**$\lvert{\lambda}_{i}\rvert=1$ at a parameter value**: This signals a **bifurcation** - the stability of the periodic orbit changes as the parameter crosses this value. Types of bifurcations include:
- **Saddle-node**: $\lambda=+1$, periodic orbit appears/disappears
- **Period-doubling**: $\lambda=-1$, period-2 orbit emerges
- **Neimark-Sacker**: $\lambda=e^{i\phi}$ (complex), quasi-periodic motion emerges

# Dynamic Legged Locomotion - Hybrid and Periodic

Dynamic legged locomotion - walking, running, hopping - fundamentally differs from quasistatic locomotion because there is **no equilibrium configuration**. The system is perpetually falling and catching itself, relying on the interplay between gravitational acceleration and ground reaction forces.

This type of locomotion is ubiquitous in:
- Animals: insects, mammals, birds
- Humans: walking, running, jumping
- Legged robots: Boston Dynamics' Spot and Atlas, RHex, various bipeds

The key insight from Poincaré map analysis is that stable periodic gaits can exist even in systems with **no feedback control** - purely passive dynamics. This concept of **orbital stability** (stability of a limit cycle rather than an equilibrium) is central to understanding efficient locomotion.

## Passive Dynamic Walking

**Passive walkers** are mechanical devices that walk down shallow slopes with no motors or control - they are powered solely by gravity. Examples include:

- **Two-link passive walker**: The simplest biped, essentially a compass gait walker
- **Passive walker with knees**: Adds knee joints for more human-like gait
- **3D passive walkers**: Extensions to three-dimensional motion

These devices demonstrate that:
1. Stable walking gaits can arise from mechanical dynamics alone
2. Efficient locomotion harnesses natural dynamics rather than fighting them
3. Control should augment, not replace, the passive dynamics

## Actuated Walking

Real walking robots and animals use actuation, but the insights from passive dynamics suggest:
- **Harness natural dynamics**: Design gaits that exploit the system's natural oscillation modes
- **Minimal intervention**: Add control only where needed to maintain stability and handle disturbances
- **Energy efficiency**: Passive-dynamic-inspired designs can be remarkably energy-efficient

# Robotic Locomotion Systems with Periodic Inputs

Many robotic locomotion systems use **periodic inputs** to generate motion:
- Kinematic actuation of joints: prescribing periodic joint trajectories
- Torque actuation: applying periodic torques
- Passive elastic joints: springs that store and release energy cyclically

The analysis framework using Poincaré maps applies directly to these systems. A key research question is:

>[!quote]
>**Find open-loop inputs that induce passive stability of periodic motion**

That is, design the periodic input $\mathbf{u}(t)=\mathbf{u}(t+{t}_{p})$ such that the resulting periodic orbit is stable without feedback.

## Example: RAPS Twistcar

The **Rotor-Actuated Passive Steering (RAPS) Twistcar** is a wheeled vehicle that propels itself through internal body oscillations.

![[HDY1_006 Poincaré Maps RAPS placeholder.svg|bookhue|600]]^figure-raps-model
>The RAPS Twistcar: periodic actuation of the middle joint angle $\psi(t)=A\sin(\omega t)$ induces steering and propulsion through the passive front wheel angle $\phi$.

**System description**:
- Prescribed periodic input: $\psi(t)=A\sin(\omega t)$
- Free passive DOF: front wheel steering angle $\phi$
- Rolling dissipation at wheels
- State vector: $\mathbf{z}=(\phi,\sigma,v)^{T}$ where $\sigma=\dot{\theta}$ and $v=\mathbf{v}_{P}\cdot\mathbf{e}'_{1}$

**Dynamics**: The reduced equations of motion have the form:
$$\dfrac{\mathrm{d}\mathbf{z}}{\mathrm{d}t}=\mathbf{f}(\mathbf{z},\psi(t),\dot{\psi}(t))\tag{6.37}$$

**Periodic solutions**: By varying the actuation frequency $\omega$, different periodic gaits emerge with different stability properties.

![[HDY1_006/HDY1_006 twistcar phi time.png|bookhue|600]]^figure-steeing-angle-twistcar
>Time evolution of the passive steering angle $\phi(t)$ for the RAPS Twistcar at different actuation frequencies. At $\omega=1.55\,\text{rad/s}$, a stable periodic solution exists. At $\omega=1.10\,\text{rad/s}$, the system converges to a different stable limit cycle.

**Bifurcation analysis**: As the frequency $\omega$ varies, the periodic solution undergoes bifurcations:

![[HDY1_006/HDY1_006 twistcar bifurcation.png|bookhue|600]]^figure-twistcar-bifurcation
>Bifurcation diagram showing the fixed point value $\bar{\phi}$ (mean steering angle) vs actuation frequency $\omega$. Solid lines indicate stable branches, dashed lines indicate unstable branches. A pitchfork bifurcation occurs near $\omega\approx 1.25\,\text{rad/s}$.

The bifurcation structure reveals:
- A symmetric solution branch ($\bar{\phi}=0$) that becomes unstable at a critical frequency
- Two asymmetric branches that emerge from the bifurcation point
- Parameter regions of stable vs unstable periodic motion

## Analysis of Locomotion Swimmers

Similar Poincaré map analysis applies to swimming locomotion in fluids:

**Multi-link swimmers**: Experiments and theory using "perfect fluid" models with kinematic joint actuation reveal frequency-dependent behavior and bifurcations.

**Passive elastic joints**: Adding springs at joints creates rich dynamics:
- Optimal actuation frequency for maximal displacement per cycle
- Stability depends on the interplay between actuation frequency and natural elastic frequency
- Bifurcations occur as frequency varies

![[HDY1_006/HDY1_006 swimmer frequency response.png|bookhue|600]]^figure-displacement-per-cycle
>Displacement per cycle vs actuation frequency for an elastic-joint swimmer. An optimal frequency exists that maximizes propulsion efficiency.

**Micro-nano robotic swimmers**: At small scales, swimmers in oscillating magnetic fields exhibit:
- Frequency-dependent stability
- 90° flip in swimming direction due to parametric excitation
- Behavior analogous to the Kapitza inverted pendulum

## Purcell's Swimmer

**Purcell's three-link swimmer** is a canonical model for low-Reynolds-number locomotion:

![[HDY1_006 Poincaré Maps Purcell placeholder.svg|bookhue|600]]^figure-purcell-swimmer
>Purcell's three-link swimmer with joint angles $\phi_{1}$ and $\phi_{2}$. The swimmer moves by executing a non-reciprocal cycle in the $(\phi_{1},\phi_{2})$ shape space.

**Near a wall**: When the swimmer operates near a boundary, the dynamics change:
- The effective drag depends on distance to the wall
- Periodic swimming gaits have different stability properties
- The distance from the wall can evolve dynamically under periodic actuation

**Shape stability under periodic torques**: Instead of prescribing joint angles, one can apply periodic torques and study whether the resulting shape trajectory is stable:
- Stable periodic shapes lead to consistent swimming motion
- Unstable shapes cause erratic behavior
- Poincaré map analysis reveals the stability boundaries

![[HDY1_006/HDY1_006 Purcell stability.png|bookhue|600]]^figure-stability-transition
>Stability transition map in the frequency-amplitude plane for Purcell's swimmer with periodic torque input. Regions of stable periodic motion are separated by bifurcation curves.

# Summary

The **Poincaré map** provides a powerful framework for analyzing periodic solutions of dynamical systems:

1. **Dimension reduction**: Converts continuous-time dynamics to a discrete-time map on a lower-dimensional section
2. **Fixed points = periodic orbits**: Periodic solutions correspond to fixed points of the Poincaré map
3. **Stability via eigenvalues**: Local stability is determined by eigenvalues of the Jacobian - all must be inside the unit circle
4. **Numerical methods**: `fsolve` finds fixed points; finite differences approximate the Jacobian
5. **Bifurcation analysis**: Tracking how fixed points and their stability change with parameters reveals the system's qualitative behavior

For **hybrid dynamical systems** (impacts, mode switches), the Poincaré map naturally incorporates discrete events, making it especially suited for analyzing:
- Legged locomotion (walking, running, hopping)
- Bouncing and impacting systems
- Systems with intermittent contact

The insights from Poincaré map analysis have practical implications for:
- Designing efficient locomotion controllers
- Understanding passive stability in mechanical systems
- Predicting bifurcations and regime changes as parameters vary
