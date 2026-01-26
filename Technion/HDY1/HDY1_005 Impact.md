---
aliases:
---
# Point Particle - 1D Impact

## Compliant Contact Model

Consider a particle with a single DOF $q=x$, where motion is restricted to 1D with a unilateral contact constraint $h(q)=x\geq 0$. When the particle collides with the constraint surface, we model the contact using a compliant (spring) model that assumes small deformations and high stiffness.

![[HDY1_005 Impact 2026-01-06 20.18.58.excalidraw.svg]]^figure-contact-model
>Compliant contact model for 1D impact.

The equation of motion during contact is piecewise-defined:
$$m\ddot{x}=f(x)=\begin{cases}
0 & x>0 \\
-kx & x\leq  0
\end{cases}\tag{5.1}$$
At the collision time ${t}_{c}$, the initial conditions are $x({t}_{c})=0$ and $\dot{x}({t}_{c})=-{v}_{0}<0$, where the negative sign indicates approach toward the constraint.

For $x\leq 0$, the equation $m\ddot{x}=-kx$ is a simple harmonic oscillator. Defining the natural frequency ${\omega}_{n}=\sqrt{k/m}$, the general solution is:
$$x(t)=A\cos({\omega}_{n}(t-{t}_{c}))+B\sin({\omega}_{n}(t-{t}_{c}))$$

Applying initial conditions $x({t}_{c})=0$ and $\dot{x}({t}_{c})=-{v}_{0}$:
- From $x({t}_{c})=0$: $A=0$
- From $\dot{x}({t}_{c})=-{v}_{0}$: $B{\omega}_{n}=-{v}_{0}$, so $B=-{v}_{0}/{\omega}_{n}$

Therefore:
$$\begin{align}
 & x(t)=-\dfrac{{v}_{0}}{{\omega}_{n}}\sin\left( {\omega}_{n}(t-{t}_{c}) \right) \\[3ex]
 & \implies x(t)=-{\delta}_{\max}\sin\left( \sqrt{ \dfrac{k}{m} }(t-{t}_{c}) \right)\tag{5.2}
\end{align}$$

where the **maximal deformation** is:
$${\delta}_{\max}=\dfrac{{v}_{0}}{{\omega}_{n}}=\sqrt{ \dfrac{m}{k} }{v}_{0}\tag{5.3}$$

This result has a clear physical interpretation: higher mass or velocity leads to deeper penetration, while higher stiffness reduces penetration.

![[HDY1_005 Impact 2026-01-09 11.07.07.excalidraw.svg]]^figure-fully-elastic
>Full elastic contact.


The contact ends at the **release time** ${t}_{r}$ when $x({t}_{r})=0$ and $\dot{x}({t}_{r})>0$. From equation $\text{(5.2)}$, $x=0$ when $\sin({\omega}_{n}(t-{t}_{c}))=0$, i.e., when ${\omega}_{n}(t-{t}_{c})=n\pi$ for integer $n$. The first release (after collision) occurs at $n=1$:
$$\Delta {t}_{r}={t}_{r}-{t}_{c}=\dfrac{\pi}{{\omega}_{n}}=\pi\sqrt{ \dfrac{m}{k} }\tag{5.4}$$

The velocity at release is:
$$\dot{x}({t}_{r})=-{v}_{0}\cos({\omega}_{n}\Delta {t}_{r})=-{v}_{0}\cos(\pi)=+{v}_{0}$$

For a purely elastic spring with no damping, the particle rebounds with the same speed it had before impact.

The maximum contact force occurs at maximum deformation:
$${f}_{\max}=k{\delta}_{\max}=k\sqrt{ \dfrac{m}{k} }{v}_{0}=\sqrt{ mk }{v}_{0}\tag{5.5}$$

In the limit of rigid bodies, $k\to \infty$, we observe:
- **Contact duration**: $\Delta {t}_{r}\sim 1/\sqrt{k}\to 0$ - instantaneous collision
- **Deformation**: ${\delta}_{\max}\sim 1/\sqrt{k}\to 0$ - negligible deformations (rigid)
- **Contact force**: ${f}_{\max}\sim \sqrt{k}\to \infty$ - infinite impulse force

However, the **velocity jump is finite**: $\dot{x}(t^{-}_{c})=-{v}_{0}$ and $\dot{x}(t^{+}_{c})=+{v}_{0}$.

For instantaneous collisions, we use the impulse-momentum relation:
$$m\Delta v=\Lambda=\int_{t^{-}_{c}}^{t^{+}_{c}} f(t) \, \mathrm{d}t \tag{5.6}$$

where $\Lambda$ is the **[[DYN1_008 טנזור האינרציה#מתקף והתנגשות בגק"ש|impulse]]** (integral of force over time). Even though $f\to\infty$ as $k\to\infty$, the impulse remains finite:
$$\Lambda = m(\dot{x}^{+}-\dot{x}^{-})=m({v}_{0}-(-{v}_{0}))=2m{v}_{0}$$

This is the key insight for rigid-body impact: we work with impulses rather than forces.

## Kelvin-Voigt Contact Model

When adding a damper in parallel with the spring, we obtain the Kelvin-Voigt model:
$$m\ddot{x}=-kx-c\dot{x}\qquad \text{for } t<{t}_{r}\tag{5.7}$$

![[HDY1_005 Impact 2026-01-09 11.13.54.excalidraw.svg]]^figure-kelvin-voigt
>Kelvin-Voigt contact model with spring and damper in parallel.

With initial conditions $x({t}_{c})=0$ and $\dot{x}({t}_{c})=-{v}_{0}<0$, the nature of the solution depends on the **damping ratio**:
$$\zeta=\dfrac{c}{2\sqrt{ mk }}\tag{5.8}$$

For $\zeta<1$, the characteristic equation $ms^{2}+cs+k=0$ has complex roots:
$$s=-\zeta{\omega}_{n}\pm i{\omega}_{d}$$
where ${\omega}_{n}=\sqrt{k/m}$ is the natural frequency and ${\omega}_{d}={\omega}_{n}\sqrt{1-\zeta^{2}}$ is the damped natural frequency.

The general solution is:
$$x(t)=e^{-\zeta{\omega}_{n}(t-{t}_{c})}\left[ A\cos({\omega}_{d}(t-{t}_{c}))+B\sin({\omega}_{d}(t-{t}_{c})) \right]$$

Applying initial conditions:
- From $x({t}_{c})=0$: $A=0$
- From $\dot{x}({t}_{c})=-{v}_{0}$: $B{\omega}_{d}=-{v}_{0}$

Therefore:
$$x(t)=-\dfrac{{v}_{0}}{{\omega}_{d}}e^{-\zeta{\omega}_{n}(t-{t}_{c})}\sin({\omega}_{d}(t-{t}_{c}))\tag{5.9}$$

The velocity is:
$$\dot{x}(t)=-{v}_{0}e^{-\zeta{\omega}_{n}(t-{t}_{c})}\left[\cos({\omega}_{d}(t-{t}_{c}))-\dfrac{\zeta}{\sqrt{1-\zeta^{2}}}\sin({\omega}_{d}(t-{t}_{c}) \right]\tag{5.10}$$

![[HDY1_005 Impact 2026-01-09 11.16.33.excalidraw.svg]]^figure-underdamped-case
>Underdamped case.


A subtle issue arises when defining the release time ${t}_{r}$. Two natural definitions are:

1. **Kinematic definition**: $x({t}_{r})=0$ (contact surface reached)
2. **Dynamic definition**: $f({t}_{r})=0$ (zero contact force)

For the Kelvin-Voigt model, these two definitions are **inconsistent**:

- If we define ${t}_{r}$ by $x({t}_{r})=0$, then at that instant:
  $$f({t}_{r})=-kx({t}_{r})-c\dot{x}({t}_{r})=-c\dot{x}({t}_{r})<0$$
  The force is **tensile** (attractive), which is inconsistent with a unilateral contact.

- If we define ${t}_{r}$ by $f({t}_{r})=0$, then:
  $$0=-kx({t}_{r})-c\dot{x}({t}_{r}) \implies x({t}_{r})=-\dfrac{c}{k}\dot{x}({t}_{r})<0$$
  We have $x({t}_{r})<0$, meaning we release while still in compression (immediate release of spring energy).

![[HDY1_005 Impact 2026-01-09 11.19.17.excalidraw.svg]]
>Comparison of kinematic and dynamic release conditions for Kelvin-Voigt model.

Using the kinematic definition $x({t}_{r})=0$, from equation $\text{(5.9)}$:
$$\sin({\omega}_{d}\Delta{t}_{r})=0 \implies {\omega}_{d}\Delta{t}_{r}=\pi$$

Therefore:
$$\Delta{t}_{r}=\dfrac{\pi}{{\omega}_{d}}=\dfrac{\pi}{{\omega}_{n}\sqrt{1-\zeta^{2}}}$$

The velocity at release from equation $\text{(5.10)}$:
$$\dot{x}({t}_{r})=-{v}_{0}e^{-\zeta{\omega}_{n}\Delta{t}_{r}}\cos(\pi)={v}_{0}\exp\left( -\dfrac{\pi\zeta}{\sqrt{1-\zeta^{2}}} \right)$$

The **coefficient of restitution** is:
$$e=\dfrac{\dot{x}({t}_{r})}{{v}_{0}}=\exp\left( -\dfrac{\pi\zeta}{\sqrt{1-\zeta^{2}}} \right)\tag{5.11}$$

This elegant result shows that $e$ depends **only on the damping ratio** $\zeta$:
- For $\zeta\to 0$ (no damping): $e\to 1$ (perfectly elastic)
- For $\zeta\to 1$ (critical damping): $e\to 0$ (perfectly plastic)


## Hunt-Crossley Nonlinear Contact Model

The inconsistency in release conditions for the Kelvin-Voigt model motivates Hunt-Crossley's nonlinear force law:
$$f=-kx^{n}-cx^{n}\dot{x}=-x^{n}(k+c\dot{x})\tag{5.12}$$

For Hertzian contact theory, $n=3/2$.

This model resolves the release time issue: when $x({t}_{r})=0$, automatically $f({t}_{r})=0$ as well, since the force is proportional to $x^{n}$.

**Advantages**:
- Consistent release conditions: $x({t}_{r})=0$ and $f({t}_{r})=0$ simultaneously
- More physically realistic for contact between curved surfaces

**Disadvantages**:
- Nonlinear dependence on initial velocity ${v}_{0}$
- No closed-form analytic expression for $e$ (except for $n=1$, which reduces to Kelvin-Voigt)

For practical applications, numerical integration is typically required to determine the coefficient of restitution.

# Lagrangian Formulation of Frictionless Impact

## General Framework

Consider a multi-body system with $N$ degrees of freedom, described by generalized coordinates $\mathbf{q}\in \mathbb{R}^{N}$. A unilateral contact constraint is given by $d(\mathbf{q})\geq 0$, with normal velocity:
$$\dot{d}={v}_{n}=\mathbf{w}_{n}(\mathbf{q})\dot{\mathbf{q}}\tag{5.13}$$
where $\mathbf{w}_{n}=\dfrac{\partial d}{\partial\mathbf{q}}$ is a row vector.

**Collision** occurs at time ${t}_{c}$ when:
$$d(\mathbf{q}({t}_{c}))=0 \quad \text{and} \quad \dot{d}({t}_{c})<0$$

During collision, the constrained Lagrange equations are:
$$\mathbf{M}(\mathbf{q})\ddot{\mathbf{q}}+\mathbf{B}(\mathbf{q},\dot{\mathbf{q}})+\mathbf{G}(\mathbf{q})=\mathbf{F}_{q}+\mathbf{W}^{T}(\mathbf{q})\lambda\tag{5.14}$$

## Velocity Jump Equation

For an instantaneous collision ($\Delta t \to 0$), we integrate the equations of motion:
$$\begin{aligned}
\Delta \dot{\mathbf{q}} & = \dot{\mathbf{q}}(t^{+}_{c})-\dot{\mathbf{q}}(t^{-}_{c}) \\[1ex]
 & =\int_{t^{-}_{c}}^{t^{+}_{c}}\ddot{\mathbf{q}}(t)  \, \mathrm{d}t \\[1ex]
 & =\int_{t^{-}_{c}}^{t^{+}_{c}}\mathbf{M}^{-1}(\mathbf{W}^{T}\lambda+\mathbf{F}_{q}-\mathbf{B}-\mathbf{G})  \, \mathrm{d}t 
\end{aligned}$$

**Key assumptions** for $\Delta t \to 0$:
1. **No configuration change**: $\mathbf{q}(t^{+}_{c})=\mathbf{q}(t^{-}_{c}):=\mathbf{q}_{c}$ (localized contact deformations)
2. **Constant matrices**: $\mathbf{M}(\mathbf{q}(t))=\mathbf{M}(\mathbf{q}_{c}):=\mathbf{M}_{c}$ and $\mathbf{W}(\mathbf{q}(t))=\mathbf{W}(\mathbf{q}_{c}):=\mathbf{W}_{c}$
3. **Impulsive force dominance**: In the rigid-body limit $k\to \infty$, $\lvert \mathbf{W}^{T}_{c}\lambda \rvert \gg \lVert\mathbf{F}_{q}\rVert,\lVert\mathbf{B}\rVert,\lVert\mathbf{G}\rVert$

Under these assumptions:
$$\dot{\mathbf{q}}^{+} =\dot{\mathbf{q}}^{-}+\mathbf{M}^{-1}_{c}\mathbf{W}^{T}_{c}\boldsymbol{\Lambda}\tag{5.15}$$

where $\boldsymbol{\Lambda}=\int_{t^{-}_{c}}^{t^{+}_{c}}\lambda \, \mathrm{d}t$ is the **contact impulse**.

## Restitution Law

The coefficient of restitution relates pre- and post-impact normal velocities:
$${v}_{n}(t^{+}_{c})=-e{v}_{n}(t^{-}_{c})\tag{5.16}$$

In matrix form:
$$\mathbf{W}_{c}\dot{\mathbf{q}}^{+}=-e\mathbf{W}_{c}\dot{\mathbf{q}}^{-}$$

Substituting equation $\text{(5.15)}$:
$$\begin{gathered}
\mathbf{W}_{c}(\dot{\mathbf{q}}^{-}+\mathbf{M}^{-1}_{c}\mathbf{W}^{T}_{c}\boldsymbol{\Lambda}) =-e\mathbf{W}_{c}\dot{\mathbf{q}}^{-} \\[1ex]
(\mathbf{W}_{c}\mathbf{M}^{-1}_{c}\mathbf{W}^{T}_{c})\boldsymbol{\Lambda}=-(1+e)\mathbf{W}_{c}\dot{\mathbf{q}}^{-} \\[1ex]
(\mathbf{W}_{c}\mathbf{M}^{-1}_{c}\mathbf{W}^{T}_{c})\boldsymbol{\Lambda}=-(1+e)v^{-}_{n}
\end{gathered}$$

Solving for the impulse:
$$\boldsymbol{\Lambda}=-\dfrac{1+e}{\mathbf{W}_{c}\mathbf{M}^{-1}_{c}\mathbf{W}^{T}_{c}}v^{-}_{n}\tag{5.17}$$

Since $v^{-}_{n}<0$ (approaching), and $\mathbf{W}_{c}\mathbf{M}^{-1}_{c}\mathbf{W}^{T}_{c}>0$ (positive definite mass matrix), we have $\boldsymbol{\Lambda}>0$ (compressive impulse).

## Impact Map

Substituting $\boldsymbol{\Lambda}$ back into equation $\text{(5.15)}$:
$$\dot{\mathbf{q}}^{+} =\dot{\mathbf{q}}^{-}-\dfrac{(1+e)}{\mathbf{W}_{c}\mathbf{M}^{-1}_{c}\mathbf{W}^{T}_{c}}\mathbf{M}^{-1}_{c}\mathbf{W}^{T}_{c}\mathbf{W}_{c}\dot{\mathbf{q}}^{-}$$

Defining the **impact map** matrix:
$$\mathbf{P}(\mathbf{q}_{c},e):=\mathbf{I}-\dfrac{1+e}{\mathbf{W}_{c}\mathbf{M}^{-1}_{c}\mathbf{W}^{T}_{c}}\mathbf{M}^{-1}_{c}\mathbf{W}^{T}_{c}\mathbf{W}_{c}\tag{5.18}$$

We obtain the compact form:
$$\dot{\mathbf{q}}^{+}=\mathbf{P}(\mathbf{q}_{c},e)\dot{\mathbf{q}}^{-}\tag{5.19}$$

>[!example] Example: Falling / Bouncing Rod
>
>Consider a rod of mass $m$, length $2\ell$, and moment of inertia ${I}_{c}$ about its center of mass. The rod makes frictionless contact with a horizontal surface at one endpoint.
>
>![[HDY1_005 Impact 2026-01-09 11.57.01.excalidraw.svg]]^figure-falling-rod
>>Bouncing rod configuration with contact at endpoint.
>
>**Coordinate System**: We define $(x,y)$ as the position of the contact point and $\theta$ as the rod angle. Thus $\mathbf{q}=(x,y,\theta)^{T}$.
>
>**Constraint**: The contact distance is $d(\mathbf{q})=y$, giving:
>$$\mathbf{W}(\mathbf{q})=\begin{pmatrix}0 & 1 & 0\end{pmatrix}$$
>
>**Kinematics**: The center of mass position and velocity are:
>$$\begin{aligned}
> & \mathbf{r}_{c}=(x+\ell \cos\theta)\mathbf{e}_{1}+(y+\ell \sin\theta)\mathbf{e}_{2} \\[1ex]
> & \mathbf{v}_{c}=(\dot{x}-\ell \dot{\theta}\sin\theta)\mathbf{e}_{1}+(\dot{y}+\ell\dot{\theta}\cos\theta)\mathbf{e}_{2}
>\end{aligned}$$
>
>**Energies**:
>$$\begin{aligned}
>V & =mg\mathbf{r}_{c}\cdot \mathbf{e}_{2} \\[1ex]
> & =mg(y+\ell \sin\theta) \\[3ex]
>T & =\dfrac{1}{2}(m\mathbf{v}_{c}\cdot \mathbf{v}_{c}+{I}_{c}\omega ^{2}) \\[1ex]
> & =\dfrac{1}{2}m[\dot{x}^{2}+\dot{y}^{2}+\ell ^{2}\dot{\theta}^{2}+2\ell\dot{\theta}(\dot{y}\cos\theta-\dot{x}\sin\theta)]+\dfrac{1}{2}{I}_{c}\dot{\theta}^{2}
>\end{aligned}$$
>
>**Mass Matrix**:
>$$\mathbf{M}(\mathbf{q})=\begin{pmatrix}
>m & 0 & -m\ell \sin\theta \\
>0 & m & m\ell \cos\theta \\
>-m\ell \sin\theta & m\ell \cos\theta & {I}_{c}+m\ell ^{2}
>\end{pmatrix}$$
>
>**Inverse Mass Matrix** (required for impulse calculation):
>The relevant quantity is $\mathbf{W}_{c}\mathbf{M}^{-1}_{c}\mathbf{W}^{T}_{c}$. Using the formula for the inverse of a $3\times 3$ matrix and extracting the $(2,2)$ element:
>$$\mathbf{W}_{c}\mathbf{M}^{-1}_{c}\mathbf{W}^{T}_{c}=\dfrac{{I}_{c}+m\ell ^{2}\cos ^{2}{\theta}_{c}}{m{I}_{c}}$$
>
>**Contact Impulse**: From equation $\text{(5.17)}$:
>$$\begin{aligned}
>\Lambda & =-\dfrac{1+e}{\mathbf{W}_{c}\mathbf{M}^{-1}_{c}\mathbf{W}^{T}_{c}}\mathbf{W}_{c}\dot{\mathbf{q}}^{-} \\[1ex]
> & =\dfrac{(1+e)m{I}_{c}}{{I}_{c}+m\ell ^{2}\cos ^{2}{\theta}_{c}}(-\dot{y}^{-})>0
>\end{aligned}$$
>
>**Post-Impact Velocities**: Applying the impact map:
>$$\begin{pmatrix}
>\dot{x}^{+} \\
>\dot{y}^{+} \\
>\dot{\theta}^{+}
>\end{pmatrix}=\begin{pmatrix}
>\dot{x}^{-}+\dfrac{(1+e)m\ell ^{2}\cos{\theta}_{c}\sin{\theta}_{c}}{{I}_{c}+m\ell ^{2}\cos ^{2}{\theta}_{c}}\dot{y}^{-} \\[1ex]
>-e\dot{y}^{-} \\[1ex]
>\dot{\theta}^{-}+\dfrac{(1+e)m\ell \cos{\theta}_{c}}{{I}_{c}+m\ell ^{2}\cos ^{2}{\theta}_{c}}\dot{y}^{-}
>\end{pmatrix}$$
>
>**Conservation of Horizontal COM Velocity**:
>
>Looking at the result for $\dot{y}^{+}=-e\dot{y}^{-}$ (simple restitution in normal direction), we can prove that the horizontal velocity of the center of mass is conserved:
>$$\dot{x}^{+}-\ell\dot{\theta}^{+}\sin{\theta}_{c}=\dot{x}^{-}-\ell\dot{\theta}^{-}\sin {\theta}_{c}$$
>
>To show this, we substitute the post-impact velocities:
>$$\begin{aligned}
>\dot{x}^{+}-\ell\dot{\theta}^{+}\sin{\theta}_{c} &= \left(\dot{x}^{-}+\dfrac{(1+e)m\ell ^{2}\cos{\theta}_{c}\sin{\theta}_{c}}{{I}_{c}+m\ell ^{2}\cos ^{2}{\theta}_{c}}\dot{y}^{-}\right) \\[1ex]
>&\quad -\ell\sin{\theta}_{c}\left(\dot{\theta}^{-}+\dfrac{(1+e)m\ell \cos{\theta}_{c}}{{I}_{c}+m\ell ^{2}\cos ^{2}{\theta}_{c}}\dot{y}^{-}\right) \\[1ex]
>&= \dot{x}^{-}-\ell\dot{\theta}^{-}\sin{\theta}_{c} + \dfrac{(1+e)m\ell\cos{\theta}_{c}\sin{\theta}_{c}}{{I}_{c}+m\ell ^{2}\cos ^{2}{\theta}_{c}}\dot{y}^{-}(\ell-\ell) \\[1ex]
>&= \dot{x}^{-}-\ell\dot{\theta}^{-}\sin{\theta}_{c}
>\end{aligned}$$
>
>This result follows from the fact that the impulsive force acts purely in the **normal direction** (frictionless contact), and therefore cannot change the horizontal component of linear momentum. The quantity $\dot{x}_{c}=\dot{x}-\ell\dot{\theta}\sin\theta$ is precisely the horizontal velocity of the center of mass.
>
>**Plastic Collision ($e=0$)**:
>
>For $e=0$, we get $\dot{y}^{+}=0$, but $\dot{x}^{+}$ and $\dot{\theta}^{+}\neq 0$. This means **not all kinetic energy vanishes** in a plastic collision - only the normal component of velocity at the contact point is arrested. The rod continues to move horizontally and rotate.

# Hybrid Dynamical Systems

## Definition

A **hybrid system** (HS) for state $\mathbf{x}\in \mathbb{R}^{n}$ is defined by:
$$\begin{cases}
\dot{\mathbf{x}}=\mathbf{f}(\mathbf{x},t) & \mathbf{x}(t)\in C & \text{flow set} \\
\mathbf{x}(t^{+})=\mathbf{g}(\mathbf{x}(t^{-})) & \mathbf{x}(t^{-})\in D & \text{jump set (guard)}
\end{cases}\tag{5.20}$$

Often, the jump set $D$ lies at the boundary of the flow set $C$.

## Solutions of Hybrid Systems

A **solution** of a hybrid system consists of:
1. A continuous trajectory $\mathbf{x}(t)$
2. A sequence of jump times $\{ 0<{t}_{1}<{t}_{2}<{t}_{3}\dots \}$

such that:
- Between jumps: $\dot{\mathbf{x}}(t)=\mathbf{f}(\mathbf{x},t)$ and $\mathbf{x}(t)\in C$ for ${t}_{k}\leq t\leq {t}_{k+1}$
- At jumps: $\mathbf{x}(t^{+}_{k})=\mathbf{g}(\mathbf{x}(t^{-}_{k}))$ where $\mathbf{x}(t^{-}_{k})\in D$

## Mechanical Systems as Hybrid Systems

For mechanical systems with state $\mathbf{x}=(\mathbf{q},\dot{\mathbf{q}})\in \mathbb{R}^{2N}$, the flow function $\mathbf{f}$ may be piecewise-defined:

$$\mathbf{f}(\mathbf{x})=\begin{cases}
\mathbf{f}_{1}(\mathbf{x}) & \mathbf{x}\in {C}_{1}=\{ (\mathbf{q},\dot{\mathbf{q}}):d(\mathbf{q})>0 \} & \text{(free flight)}\\[1ex]
\mathbf{f}_{2}(\mathbf{x}) & \mathbf{x}\in {C}_{2}=\{ (\mathbf{q},\dot{\mathbf{q}}):d(\mathbf{q})=0,\,\dot{d}=0,\,\lambda>0\} & \text{(contact)}
\end{cases}$$

**Guard (jump set)**:
$$D=\{ (\mathbf{q},\dot{\mathbf{q}}):d(\mathbf{q})=0 \quad\text{and}\quad \dot{d}(\mathbf{q},\dot{\mathbf{q}})<0\}$$

**Reset/jump map** for frictionless impact:
$$\mathbf{g}(\mathbf{q},\dot{\mathbf{q}})=(\mathbf{q},\mathbf{P}(\mathbf{q}_{c},e)\dot{\mathbf{q}})\tag{5.21}$$

For frictional impact, the reset map may have multiple branches:
$$\mathbf{g}(\mathbf{x})=\begin{cases}
\mathbf{g}_{1}(\mathbf{x}) & \mathbf{x}\in {D}_{1}  & \text{sticking impact}\\
\mathbf{g}_{2}(\mathbf{x}) & \mathbf{x}\in {D}_{2}  & \text{slipping impact}
\end{cases}$$

>[!example] Example: Zeno's Paradox - The Bouncing Ball
>
>A remarkable property of hybrid systems is that they may have **infinitely many jump times** $\{ {t}_{k} \}$, $k=1,\dots,\infty$, all accumulating in a **finite amount of time**. This phenomenon is known as **Zeno's paradox** (named after the Greek philosopher Zeno of Elea).
>
>Consider a bouncing ball with coordinates $\mathbf{q}=(x,y)$:
>
>![[HDY1_005 Impact 2026-01-09 12.01.39.excalidraw.svg]]^figure-bouncing-ball
>>Bouncing ball undergoing repeated impacts.
>
>**Flow dynamics** (for $y>0$):
>$$\ddot{y}=-g,\qquad \ddot{x}=0$$
>
>**Jump** (when $y=0$ and $\dot{y}<0$):
>$$\begin{aligned}
> & \dot{y}(t^{+}_{k})=-e\dot{y}(t^{-}_{k}) \\[1ex]
> & \dot{x}(t^{+}_{k})=\dot{x}(t^{-}_{k})
>\end{aligned}$$
>where $e\in(0,1)$.
>
>**Analysis**: For initial state $y(0)={h}_{0}>0$ and $\dot{y}(0)=0$:
>
>*First flight* ($0\leq t<{t}_{1}$):
>$$y(t)={h}_{0}-\dfrac{1}{2}gt^{2}$$
>
>Setting $y({t}_{1})=0$:
>$${t}_{1}=\sqrt{ \dfrac{2{h}_{0}}{g} },\qquad \dot{y}(t^{-}_{1})=-g{t}_{1}=-\sqrt{ 2g{h}_{0} }$$
>
>*First impact*:
>$$\dot{y}(t^{+}_{1})=-e\dot{y}(t^{-}_{1})=e\sqrt{ 2g{h}_{0} }$$
>
>*Second flight* (${t}_{1}<t<{t}_{2}$):
>$$y(t)=\dot{y}(t^{+}_{1})(t-{t}_{1})-\dfrac{1}{2}g(t-{t}_{1})^{2}$$
>
>Setting $y({t}_{2})=0$ gives a quadratic with positive root:
>$${t}_{2}-{t}_{1}=\dfrac{2\dot{y}(t^{+}_{1})}{g}$$
>
>At the second impact:
>$$\dot{y}(t^{-}_{2})=-\dot{y}(t^{+}_{1})$$
>
>This follows from energy conservation during free flight: the ball reaches the same speed when returning to the ground as it had when leaving.
>
>*Second impact*:
>$$\dot{y}(t^{+}_{2})=-e\dot{y}(t^{-}_{2})=e\dot{y}(t^{+}_{1})=e^{2}\sqrt{2g{h}_{0}}$$
>
>**Recursive Pattern**: The recursive law is:
>$$\dot{y}^{+}_{k+1}=e\dot{y}^{+}_{k}=e^{k}\dot{y}^{+}_{1}$$
>
>which is a **decaying geometric series**.
>
>**Time gaps between impacts**:
>$$\begin{aligned}
>{\Delta}_{k} & ={t}_{k+1}-{t}_{k} \\[1ex]
> & =\dfrac{2\dot{y}^{+}_{k}}{g} \\[1ex]
> & =\dfrac{2e^{k-1}\dot{y}^{+}_{1}}{g}
>\end{aligned}$$
>
>**Peak heights**:
>$${h}_{k+1} =\dfrac{(\dot{y}^{+}_{k})^{2}}{2g}=e^{2}{h}_{k} \implies {h}_{k}=e^{2k}{h}_{0}$$
>
>This is because the maximum height is reached when all kinetic energy converts to potential energy: $\dfrac{1}{2}m(\dot{y}^{+}_{k})^{2}=mg{h}_{k+1}$.
>
>**Finite Accumulation Time**:
>$$\begin{aligned}
>{t}_{\infty } & ={t}_{1}+\sum_{k=1}^{\infty}{\Delta}_{k}  \\[1ex]
> & ={t}_{1}+\dfrac{2\dot{y}^{+}_{1}}{g}\sum_{k=0}^{\infty}e^{k} \\[1ex]
> & ={t}_{1}+\dfrac{2\dot{y}^{+}_{1}}{g}\cdot\dfrac{1}{1-e} \\[1ex]
> & =\sqrt{ \dfrac{2{h}_{0}}{g} }\cdot \dfrac{1+e}{1-e}<\infty 
>\end{aligned}$$
>
>**Limiting cases**:
>- As $e\to 0$ (plastic): ${t}_{\infty}\to{t}_{1}=\sqrt{2{h}_{0}/g}$ (single impact)
>- As $e\to 1$ (elastic): ${t}_{\infty}\to\infty$ (infinite bouncing time)
>
>**What happens for $t>{t}_{\infty}$?**
>
>At the accumulation time, we have:
>$$d({t}_{\infty})\to 0,\qquad \dot{d}({t}_{\infty})\to 0$$
>
>The ball comes to rest on the surface. For $t>{t}_{\infty}$, the system transitions to **constrained motion** (persistent contact) with $y=\dot{y}=0$.

# Impact with Friction and Slippage

## Point Particle Impact in 2D

Consider a point particle colliding with a surface where friction is present. The relative velocity and impulse vectors are decomposed into tangential and normal components:

![[HDY1_005 Impact 2026-01-20 15.22.51.excalidraw.svg]]

>General impact configuration with friction showing tangential and normal directions.

**Relative velocity vector**:
$$\mathbf{v}={v}_{t}\mathbf{e}_{t}+{v}_{n}\mathbf{e}_{n}\tag{5.22}$$

**Impulse vector**:
$$\boldsymbol{\Lambda}={\Lambda}_{t}\mathbf{e}_{t}+{\Lambda}_{n}\mathbf{e}_{n}\tag{5.23}$$

**Impulse-momentum balance**:
$$\boldsymbol{\Lambda}=m\Delta \mathbf{v}=m(\mathbf{v}^{+}-\mathbf{v}^{-})\tag{5.24}$$

For given pre-impact velocity $\mathbf{v}^{-}$, we need to find the impulse $\boldsymbol{\Lambda}$ and the post-impact velocity $\mathbf{v}^{+}$ (2 scalar unknowns).

In the **normal direction**, we apply the standard restitution law:
$$v^{+}_{n}=-{e}_{n}v^{-}_{n},\qquad {e}_{n}\in[0,1]\tag{5.25}$$

By analogy, one might suggest a **tangential restitution** law:
$$v^{+}_{t}=-{e}_{t}v^{-}_{t}\tag{5.26}$$

But what is the valid range of ${e}_{t}$?

The change in kinetic energy is:
$$\begin{aligned}
\Delta T & =T^{+}-T^{-} \\[1ex]
 & =\dfrac{1}{2}m[(v^{+}_{t})^{2}+(v^{+}_{n})^{2}]-\dfrac{1}{2}m[(v^{-}_{t})^{2}+(v^{-}_{n})^{2}] \\[1ex]
 & =\dfrac{1}{2}m[({e}_{t}^{2}-1)(v^{-}_{t})^{2}+({e}_{n}^{2}-1)(v^{-}_{n})^{2}]
\end{aligned}\tag{5.27}$$

For physical consistency, we require $\Delta T\leq 0$ (energy cannot be created during impact). This gives ${e}_{t}\in[-1,1]$.

Is ${e}_{t}$ with negative values physical? Perhaps not directly, but it is a convenient mathematical abstraction that captures velocity reversal in the tangential direction.

The friction bound on impulses is:
$$\lvert {\Lambda}_{t} \rvert\leq \mu{\Lambda}_{n}\tag{5.28}$$

This is justified because $\boldsymbol{\Lambda}=\int \boldsymbol{\lambda}(t) \, \mathrm{d}t$ and Coulomb's law $\lvert {\lambda}_{t} \rvert\leq \mu{\lambda}_{n}$ applies at each instant.

From the impulse-momentum relations:
$$\begin{aligned}
 & {\Lambda}_{n}=m\Delta {v}_{n}=-m(1+{e}_{n})v^{-}_{n} \\[1ex]
 & {\Lambda}_{t}\, =m\Delta {v}_{t}=-m(1+{e}_{t})v^{-}_{t}
\end{aligned}\tag{5.29}$$

Substituting into the friction bound:
$$\left\lvert  \dfrac{{\Lambda}_{t}}{{\Lambda}_{n}}  \right\rvert =\dfrac{(1+{e}_{t})\lvert v^{-}_{t}\rvert}{(1+{e}_{n})\lvert v^{-}_{n} \rvert }\leq  \mu\tag{5.30}$$

**Special case ${e}_{t}={e}_{n}$**: The friction bound becomes:
$$\dfrac{\lvert v^{-}_{t}\rvert}{\lvert v^{-}_{n} \rvert}\leq \mu$$

This means that the negative of the incoming velocity $-\mathbf{v}^{-}$ must lie inside a friction cone.

**General case ${e}_{t}\neq {e}_{n}$**: The friction bound becomes:
$$\dfrac{\lvert v^{-}_{t}\rvert}{\lvert v^{-}_{n} \rvert}\leq \dfrac{(1+{e}_{n})}{(1+{e}_{t})}\mu$$

This defines a different cone, scaled by the ratio of restitution factors.

**Problem**: For shallow collision angles (large $\lvert v^{-}_{t}\rvert/\lvert v^{-}_{n}\rvert$), there is a conflict with friction bounds. Should we set ${\Lambda}_{t}=\pm\mu {\Lambda}_{n}$ and give up the tangential restitution law $v^{+}_{t}=-{e}_{t}v^{-}_{t}$?

## Naive Impact Law with Friction

A simpler approach assumes:
- **Normal direction**: $v^{+}_{n}=-{e}_{n}v^{-}_{n}$, giving ${\Lambda}_{n}=-m(1+{e}_{n})v^{-}_{n}$
- **Tangential direction**:
$${\Lambda}_{t}=\begin{cases}
0 & \text{if } v^{-}_{t}=0 \quad (\text{no slip} \to v^{+}_{t}=0) \\[1ex]
-\sigma \mu{\Lambda}_{n} & \text{if } \sigma=\mathrm{sgn}(v^{-}_{t})\neq 0 \quad (\text{slip})
\end{cases}\tag{5.31}$$

Consider $v^{-}_{n}=-{v}_{0}<0$ and $v^{-}_{t}=\varepsilon {v}_{0}>0$ with $0<\varepsilon\ll 1$ (nearly normal impact).

![[HDY1_005 Impact 2026-01-23 16.32.23.excalidraw.svg]]^figure-almost-vertical-impact
>Almost vertical impact

**Impulses**:
$${\Lambda}_{n}=m(1+{e}_{n}){v}_{0},\qquad {\Lambda}_{t}=-\mu m(1+{e}_{n}){v}_{0}$$

**Post-impact velocities**:
$$v^{+}_{n}={e}_{n}{v}_{0},\qquad v^{+}_{t}=v^{-}_{t}+\dfrac{{\Lambda}_{t}}{m}=[\varepsilon-(1+{e}_{n})\mu]{v}_{0}$$

**Energy change**:
$$\begin{aligned}
\Delta T & =T^{+}-T^{-} \\[1ex]
 & =\dfrac{1}{2}m{v}_{0}^{2}\left[(\varepsilon-(1+{e}_{n})\mu)^{2}+{e}_{n}^{2}-1-\varepsilon ^{2}\right]
\end{aligned}$$

Taking $\varepsilon \to 0$:
$$\Delta T=\dfrac{1}{2}m{v}_{0}^{2}\left[(1+{e}_{n})^{2}\mu ^{2}+{e}_{n}^{2}-1\right]\tag{5.32}$$

**Unphysical result**: For $\mu ^{2}>\dfrac{1-{e}_{n}^{2}}{(1+{e}_{n})^{2}}=\dfrac{1-{e}_{n}}{1+{e}_{n}}$, we get $\Delta T>0$ - energy is *created* during impact!

**Why did this happen?** We assumed ${\Lambda}_{t}=-\sigma \mu{\Lambda}_{n}$ with constant $\sigma=\mathrm{sgn}(v^{-}_{t})$. But notice that $v^{+}_{t}=[\varepsilon-(1+{e}_{n})\mu]{v}_{0}<0$ for small $\varepsilon$, meaning $\mathrm{sgn}(v^{+}_{t})\neq \mathrm{sgn}(v^{-}_{t})$. The velocity changes sign during impact!

## Corrected Model: Impact as a Process

The key insight is that collision is a **process** occurring over some fast time interval $t\in[{t}_{c},{t}_{f}]$, with different stages.

**Impulses accumulate in time**:
$$\boldsymbol{\Lambda}(t)=\int_{{t}_{c}}^{t} \boldsymbol{\lambda}(t') \, \mathrm{d}t'\tag{5.33}$$

**Velocities evolve**:
$$\mathbf{v}(t)=\mathbf{v}^{-}+\dfrac{1}{m}\boldsymbol{\Lambda}(t)=\mathbf{v}^{-}+\dfrac{1}{m}\int_{{t}_{c}}^{t} \boldsymbol{\lambda}(t') \, \mathrm{d}t'\tag{5.34}$$

**Tangential force follows instantaneous Coulomb law**:
$${\lambda}_{t}(t)=\begin{cases}
-\mathrm{sgn}({v}_{t}(t))\mu{\lambda}_{n}(t) & {v}_{t}(t)\neq 0 \quad (\text{slipping})\\[1ex]
0 & {v}_{t}(t)=0 \quad (\text{sticking})
\end{cases}\tag{5.35}$$

We analyze the impact process in the $({\Lambda}_{t},{\Lambda}_{n})$ plane:
$$({\Lambda}_{t}(t),{\Lambda}_{n}(t))=\int_{{t}_{c}}^{t} ({\lambda}_{t}(t'),{\lambda}_{n}(t')) \, \mathrm{d}t' $$

![[HDY1_005 Impact 2026-01-20 15.29.57.excalidraw.svg]]

>Impact analysis in the $({\Lambda}_{t},{\Lambda}_{n})$ impulse plane showing the s-line, t-line, and friction cone constraints.

**Initial conditions**: $v^{-}_{n}=-{v}_{0}<0$, $v^{-}_{t}=\varepsilon {v}_{0}>0$, with ${\Lambda}_{t}(0)={\Lambda}_{n}(0)=0$.

**Key lines in the impulse plane**:

1. **S-line (sticking line)**: The locus where ${v}_{t}=0$. From $v_{t}(t)=v^{-}_{t}+{\Lambda}_{t}(t)/m=0$:
$${\Lambda}_{t}=-mv^{-}_{t}\tag{5.36}$$

2. **T-line (termination line)**: The locus where ${v}_{n}=-{e}_{n}v^{-}_{n}$. From ${v}_{n}(t)=v^{-}_{n}+{\Lambda}_{n}(t)/m=-{e}_{n}v^{-}_{n}$:
$${\Lambda}_{n}=-m(1+{e}_{n})v^{-}_{n}\tag{5.37}$$

**Impact trajectory in the impulse plane**:

During slipping with ${v}_{t}>0$, the friction law gives ${\lambda}_{t}=-\mu{\lambda}_{n}$, so:
$$\dfrac{\mathrm{d}{\Lambda}_{t}}{\mathrm{d}{\Lambda}_{n}}=\dfrac{{\lambda}_{t}}{{\lambda}_{n}}=-\mu$$

The trajectory moves along a line of slope $-\mu$ (inside the friction cone).

**Case 1: Sticking before termination** - If the trajectory reaches the s-line before the t-line:
- Phase 1 (slipping): Follow slope $-\mu$ until reaching s-line where ${v}_{t}=0$
- Phase 2 (sticking): Move vertically (${\Lambda}_{t}=\text{const}$) until reaching t-line

**Case 2: Termination before sticking** - If the trajectory reaches the t-line first:
- Only slipping phase along slope $-\mu$

**Case 3: Velocity reversal** - For shallow angles, the trajectory may:
- First slip with ${v}_{t}>0$ (slope $-\mu$)
- Reach ${v}_{t}=0$
- Continue slipping with ${v}_{t}<0$ (slope $+\mu$)


**Total impulse**: The final impulse $\boldsymbol{\Lambda}=\boldsymbol{\Lambda}({t}_{f})$ is found at the intersection of the trajectory with the t-line:
$$\mathbf{v}^{+}=\mathbf{v}^{-}+\dfrac{1}{m}\boldsymbol{\Lambda}$$

## Chatterjee's Algebraic Law

Chatterjee proposed a simple algebraic law that captures the essential physics without tracking the full impulse trajectory.

**Algorithm**:

1. **Compute candidate impulse** $\hat{\boldsymbol{\Lambda}}$ assuming both tangential and normal restitution:
$$\hat{\Lambda}_{n}=-m(1+{e}_{n})v^{-}_{n},\qquad \hat{\Lambda}_{t}=-m(1+{e}_{t})v^{-}_{t}\tag{5.38}$$

2. **Check friction feasibility**: If $\lvert \hat{\Lambda}_{t} \rvert\leq \mu\hat{\Lambda}_{n}$, the impulse is feasible:
$$\boldsymbol{\Lambda}=\hat{\boldsymbol{\Lambda}}$$

3. **Otherwise, project onto friction cone**: If the candidate impulse violates friction bounds:
$${\Lambda}_{t}=\mathrm{sgn}(\hat{\Lambda}_{t})\mu\hat{\Lambda}_{n},\qquad {\Lambda}_{n}=\hat{\Lambda}_{n}\tag{5.39}$$

The result is:
- $v^{+}_{n}=-{e}_{n}v^{-}_{n}$ (normal restitution always satisfied)
- $v^{+}_{t}=0$ when sliding stops at impact, or $v^{+}_{t}\neq -{e}_{t}v^{-}_{t}$ when friction limits the tangential impulse

![[HDY1_005 Impact 2026-01-20 15.41.37.excalidraw.svg]]
>Chatterjee's algebraic law: the candidate impulse $\hat{\boldsymbol{\Lambda}}$ is projected onto the friction cone when it violates friction bounds.

**Energy consistency**: One can verify that this law always satisfies $\Delta T\leq 0$, avoiding the unphysical energy creation of the naive model.

# Lagrangian Formulation of Impact with Friction (2D)

## General Framework

Consider a multi-body system with coordinates $\mathbf{q}\in \mathbb{R}^{N}$ and a unilateral contact $d(\mathbf{q})\geq 0$. In 2D, we define:
- **Normal velocity**: ${v}_{n}=\dot{d}=\mathbf{w}_{n}(\mathbf{q})\dot{\mathbf{q}}$
- **Tangential velocity**: ${v}_{t}=\mathbf{w}_{t}(\mathbf{q})\dot{\mathbf{q}}$

Combining these into vector form:
$$\mathbf{v}=\begin{pmatrix}{v}_{t}\\{v}_{n}\end{pmatrix},\qquad \mathbf{W}=\begin{bmatrix}\mathbf{w}_{t}\\\mathbf{w}_{n}\end{bmatrix}\implies \mathbf{v}=\mathbf{W}\dot{\mathbf{q}}\tag{5.40}$$

The impulse vector is:
$$\boldsymbol{\Lambda}=\begin{pmatrix}{\Lambda}_{t}\\{\Lambda}_{n}\end{pmatrix}\tag{5.41}$$

## Impulse-Momentum Relation

The velocity jump is:
$$\begin{align}
\Delta\dot{\mathbf{q}} & =\dot{\mathbf{q}}(t^{+}_{c})-\dot{\mathbf{q}}(t^{-}_{c}) \\[1ex]
 & =\mathbf{M}^{-1}_{c}\mathbf{W}^{T}_{c}\boldsymbol{\Lambda}\tag{5.42}
\end{align}$$

The contact velocity jump is:
$$\begin{align}
\Delta\mathbf{v} & =\mathbf{v}^{+}-\mathbf{v}^{-}=\mathbf{W}_{c}\Delta\dot{\mathbf{q}} \\[1ex]
 & =\mathbf{W}_{c}\mathbf{M}^{-1}_{c}\mathbf{W}^{T}_{c}\boldsymbol{\Lambda} \\[1ex]
 & =\mathbf{A}_{c}\boldsymbol{\Lambda}\tag{5.43}
\end{align}$$

where the **collision matrix** is:
$$\mathbf{A}_{c}=\mathbf{W}_{c}\mathbf{M}^{-1}_{c}\mathbf{W}^{T}_{c}\tag{5.44}$$

This is a $2\times 2$ symmetric positive semi-definite matrix:
$$\mathbf{A}_{c}=\begin{bmatrix}A_{11} & A_{12}\\A_{12} & A_{22}\end{bmatrix}=\mathbf{A}^{T}_{c}\geq 0$$

>[!example] Example: Single Rigid Body Impact
>
>Consider a rigid body with mass $m$, moment of inertia ${I}_{c}$, and radius of gyration $\rho=\sqrt{{I}_{c}/m}$ (so ${I}_{c}=m\rho^{2}$).
>
>![[HDY1_005 Impact 2026-01-23 16.55.50.excalidraw.svg]]^figure-single-rigid-body-example
>>Single rigid body impact configuration. $P$ is the contact point, $c$ is the center of mass.
>
>**Coordinates**: $\mathbf{q}=(x,y,\theta)^{T}$ where $(x,y)$ is the position of the center of mass $c$.
>
>The contact point $P$ is located at $\mathbf{r}_{Pc}={r}_{t}\mathbf{e}_{t}+{r}_{n}\mathbf{e}_{n}$ relative to $c$.
>
>**Contact velocities**: The velocity of point P is:
>$$\begin{aligned}
\mathbf{v}_{P} & =\mathbf{v}_{c}+\boldsymbol{\omega}\times\mathbf{r}_{Pc} \\[1ex]
  & =\dot{x}\mathbf{e}_{t}+\dot{y}\mathbf{e}_{n}+\dot{\theta}\mathbf{e}_{3}\times({r}_{t}\mathbf{e}_{t}+{r}_{n}\mathbf{e}_{n})
\end{aligned}$$
>
>Expanding the cross product (with frame $(\mathbf{e}_{t},\mathbf{e}_{n})$ aligned with contact directions):
>$$\mathbf{v}_{P}=(\dot{x}+\dot{\theta}{r}_{n})\mathbf{e}_{t}+(\dot{y}-\dot{\theta}{r}_{t})\mathbf{e}_{n}$$
>
>Therefore:
>$${v}_{t}=\dot{x}+\dot{\theta}{r}_{n},\qquad {v}_{n}=\dot{y}-\dot{\theta}{r}_{t}$$
>
>**Constraint matrix**:
>$$\mathbf{v}=\mathbf{W}(\mathbf{q})\dot{\mathbf{q}}\implies \mathbf{W}_{c}=\begin{bmatrix}1 & 0 & {r}_{n}\\0 & 1 & -{r}_{t}\end{bmatrix}\tag{5.45}$$
>
>**Mass matrix**: For a rigid body with COM at $(x,y)$:
>$$\mathbf{M}_{c}=\begin{bmatrix}m & 0 & 0\\0 & m & 0\\0 & 0 & m\rho^{2}\end{bmatrix}\tag{5.46}$$
>
>**Collision matrix**:
>$$\begin{aligned}
>\mathbf{A}_{c}&=\mathbf{W}_{c}\mathbf{M}^{-1}_{c}\mathbf{W}^{T}_{c}\\[1ex]
>&=\begin{bmatrix}1 & 0 & {r}_{n}\\0 & 1 & -{r}_{t}\end{bmatrix}\begin{bmatrix}1/m & 0 & 0\\0 & 1/m & 0\\0 & 0 & 1/(m\rho^{2})\end{bmatrix}\begin{bmatrix}1 & 0\\0 & 1\\{r}_{n} & -{r}_{t}\end{bmatrix}\\[1ex]
>&=\dfrac{1}{m\rho^{2}}\begin{bmatrix}{r}_{n}^{2}+\rho^{2} & {r}_{n}{r}_{t}\\{r}_{n}{r}_{t} & {r}_{t}^{2}+\rho^{2}\end{bmatrix}
>\end{aligned}\tag{5.47}$$
>
>**Physical interpretation**:
>- Diagonal terms $A_{11}$ and $A_{22}$ represent "effective inverse masses" for tangential and normal impulse response
>- Off-diagonal term $A_{12}={r}_{n}{r}_{t}/(m\rho^{2})$ represents **coupling** between tangential impulse and normal velocity change (and vice versa)
>
>**Special case: ${r}_{t}=0$ or ${r}_{n}=0$** - The collision matrix becomes diagonal, and there is no coupling between tangential and normal directions.

## Fully-Plastic Impact Law

For fully-plastic impact (${e}_{n}=0$), the post-impact normal velocity is zero: $v^{+}_{n}=0$.

From $\mathbf{v}^{+}=\mathbf{0}=-\mathbf{A}_{c}\boldsymbol{\Lambda}$:
$$\boldsymbol{\Lambda}=-\mathbf{A}^{-1}_{c}\mathbf{v}^{-}\tag{5.48}$$

The generalized velocity jump is:
$$\begin{aligned}
\dot{\mathbf{q}}^{+} & =\dot{\mathbf{q}}^{-}+\Delta\dot{\mathbf{q}} \\[1ex]
 & =\dot{\mathbf{q}}^{-}+\mathbf{M}^{-1}_{c}\mathbf{W}^{T}_{c}\boldsymbol{\Lambda}
\end{aligned}$$

Substituting $\boldsymbol{\Lambda}$:
$$\begin{align}
\dot{\mathbf{q}}^{+} & =\dot{\mathbf{q}}^{-}-\mathbf{M}^{-1}_{c}\mathbf{W}^{T}_{c}\mathbf{A}^{-1}_{c}\mathbf{W}_{c}\dot{\mathbf{q}}^{-} \\[1ex]
 & =(\mathbf{I}-\mathbf{M}^{-1}_{c}\mathbf{W}^{T}_{c}\mathbf{A}^{-1}_{c}\mathbf{W}_{c})\dot{\mathbf{q}}^{-}\tag{5.49}
\end{align}$$

## Energy Balance with Friction

The kinetic energy change is:
$$\Delta T=\dfrac{1}{2}\dot{\mathbf{q}}^{+T}\mathbf{M}_{c}\dot{\mathbf{q}}^{+}-\dfrac{1}{2}\dot{\mathbf{q}}^{-T}\mathbf{M}_{c}\dot{\mathbf{q}}^{-}$$

Substituting $\dot{\mathbf{q}}^{+}=\dot{\mathbf{q}}^{-}+\mathbf{M}^{-1}_{c}\mathbf{W}^{T}_{c}\boldsymbol{\Lambda}$:
$$\begin{aligned}
\Delta T&=\dfrac{1}{2}(\dot{\mathbf{q}}^{-}+\mathbf{M}^{-1}_{c}\mathbf{W}^{T}_{c}\boldsymbol{\Lambda})^{T}\mathbf{M}_{c}(\dot{\mathbf{q}}^{-}+\mathbf{M}^{-1}_{c}\mathbf{W}^{T}_{c}\boldsymbol{\Lambda})-\dfrac{1}{2}\dot{\mathbf{q}}^{-T}\mathbf{M}_{c}\dot{\mathbf{q}}^{-}\\[1ex]
&=\dfrac{1}{2}\boldsymbol{\Lambda}^{T}\mathbf{W}_{c}\mathbf{M}^{-1}_{c}\mathbf{W}^{T}_{c}\boldsymbol{\Lambda}+\dot{\mathbf{q}}^{-T}\mathbf{W}^{T}_{c}\boldsymbol{\Lambda}\\[1ex]
&=\dfrac{1}{2}\boldsymbol{\Lambda}^{T}\mathbf{A}_{c}\boldsymbol{\Lambda}+\mathbf{v}^{-T}\boldsymbol{\Lambda}
\end{aligned}$$

Using $\mathbf{W}_{c}\dot{\mathbf{q}}^{-}=\mathbf{v}^{-}$:
$$\Delta T=\dfrac{1}{2}\boldsymbol{\Lambda}^{T}\mathbf{A}_{c}\boldsymbol{\Lambda}+\boldsymbol{\Lambda}^{T}\mathbf{v}^{-}\tag{5.50}$$

**For fully-plastic impact** with $\boldsymbol{\Lambda}=-\mathbf{A}^{-1}_{c}\mathbf{v}^{-}$:
$$\begin{align}
\Delta T & =\dfrac{1}{2}\mathbf{v}^{-T}\mathbf{A}^{-1}_{c}\mathbf{v}^{-}-\mathbf{v}^{-T}\mathbf{A}^{-1}_{c}\mathbf{v}^{-} \\[1ex]
 & =-\dfrac{1}{2}\mathbf{v}^{-T}\mathbf{A}^{-1}_{c}\mathbf{v}^{-}\leq 0\tag{5.51}
\end{align}$$

Since $\mathbf{A}_{c}$ is positive definite, $\mathbf{A}^{-1}_{c}$ is also positive definite, confirming $\Delta T\leq 0$ (energy is dissipated).

>[!Question] What about friction constraints $\lvert {\Lambda}_{t}\rvert\leq\mu{\Lambda}_{n}$? And nonzero restitution $v^{+}_{n}=-{e}_{n}v^{-}_{n}$ with ${e}_{n}>0$? 
>
>These require more sophisticated treatment - either the impulse plane analysis described earlier, or advanced methods like Routh's graphical method, which handles the interplay between friction and restitution during the impact process.

# Detailed Algebraic Impact Law (Chatterjee)

Consider a general Lagrangian system where the velocity jump is governed by the collision matrix $\mathbf{A}_{c}$:
$$\Delta \mathbf{v}=\mathbf{v}^{+}-\mathbf{v}^{-}=\mathbf{A}_{c}\boldsymbol{\Lambda}\tag{5.52}$$

where $\mathbf{A}_{c}=\begin{bmatrix}A_{11} & A_{12} \\ A_{12} & A_{22}\end{bmatrix}$.

We define two reference impulse vectors:

1.  **Frictionless impulse** $\boldsymbol{\Lambda}^{I}$: The impulse that results in zero normal velocity ($v^{+}_{n}=0$) assuming no friction (${\Lambda}_{t}=0$).
    $$\boldsymbol{\Lambda}^{I}=\begin{pmatrix}0 \\ -v^{-}_{n}/A_{22}\end{pmatrix}\tag{5.53}$$

2.  **Completely plastic impulse** $\boldsymbol{\Lambda}^{II}$: The impulse that results in zero contact velocity ($\mathbf{v}^{+}=\mathbf{0}$).
    $$\boldsymbol{\Lambda}^{II}=-\mathbf{A}^{-1}_{c}\mathbf{v}^{-}\tag{5.54}$$

We construct a **candidate impulse** $\hat{\boldsymbol{\Lambda}}$ that combines these reference impulses with restitution coefficients:
$$\hat{\boldsymbol{\Lambda}}=(1+{e}_{n})\boldsymbol{\Lambda}^{I}+(1+{e}_{t})(\boldsymbol{\Lambda}^{II}-\boldsymbol{\Lambda}^{I})\tag{5.55}$$

This candidate impulse satisfies the kinematic restitution laws:
$$v^{+}_{n}=-{e}_{n}v^{-}_{n}, \qquad v^{+}_{t}=-{e}_{t}v^{-}_{t}\tag{5.56}$$

>[!notes] Note: 
>The tangential part holds strictly only if $\mathbf{A}_{c}$ is diagonal or ${e}_{t}={e}_{n}$).

### Friction-Bounded Impulse

To satisfy Coulomb's friction bound $\lvert {\Lambda}_{t} \rvert \leq \mu {\Lambda}_{n}$, Chatterjee proposes a modified impulse:
$$\boldsymbol{\Lambda}=(1+{e}_{n})\boldsymbol{\Lambda}^{I}+\kappa(\boldsymbol{\Lambda}^{II}-\boldsymbol{\Lambda}^{I})\tag{5.57}$$

where the coefficient $\kappa$ is determined by:
$$\kappa=\begin{cases}
1+{e}_{t} & \text{if } \lvert \hat{\Lambda}_{t} \rvert \leq \mu\hat{\Lambda}_{n} \\
\dfrac{\mu(1+{e}_{n}){\Lambda}^{I}_{n}}{\lvert \Lambda^{II}_{t} \rvert-\mu(\Lambda^{II}_{n}-\Lambda^{I}_{n})} & \text{otherwise}
\end{cases}\tag{5.58}$$

**Geometric Interpretation**:
- If the candidate impulse $\hat{\boldsymbol{\Lambda}}$ is inside the friction cone, we use it directly ($\boldsymbol{\Lambda}=\hat{\boldsymbol{\Lambda}}$).
- If not, we project $\hat{\boldsymbol{\Lambda}}$ onto the "closest" edge of the friction cone along the direction of the vector $(\boldsymbol{\Lambda}^{II}-\boldsymbol{\Lambda}^{I})$.

This formulation ensures energy consistency ($\Delta T \leq 0$) for any $-1 \leq {e}_{t} \leq 1$ and $0 \leq {e}_{n} \leq 1$.

# Routh's Graphical Method for General Systems

Routh's method treats impact as a continuous process in the impulse plane $(\Lambda_{t}, \Lambda_{n})$. For a general system with coupling ($A_{12} \neq 0$), the analysis is more complex than for a point mass.

### Process Evolution
During the collision interval $[0, \Delta t]$, the accumulated impulse $\boldsymbol{\Lambda}(t)$ and contact velocity $\mathbf{v}(t)$ evolve as:
$$\mathbf{v}(t)=\mathbf{v}^{-}+\mathbf{A}_{c}\boldsymbol{\Lambda}(t)\tag{5.59}$$
or in components:
$$\begin{pmatrix}v_{t}(t) \\ v_{n}(t)\end{pmatrix}=\begin{pmatrix}v^{-}_{t} \\ v^{-}_{n}\end{pmatrix}+\begin{bmatrix}A_{11} & A_{12} \\ A_{12} & A_{22}\end{bmatrix}\begin{pmatrix}\Lambda_{t}(t) \\ \Lambda_{n}(t)\end{pmatrix}$$

### Key Lines in the Impulse Plane

We identify specific lines in the $(\Lambda_{t}, \Lambda_{n})$ plane that define flow regions and boundaries:

1.  **Line of Full Compression ($c$-line)**: Defined by $v_{n}(t)=0$.
    $$v^{-}_{n}+A_{12}\Lambda_{t}+A_{22}\Lambda_{n}=0\tag{5.60}$$
    Crossing this line marks the transition from the **compression phase** ($v_{n}<0$) to the **restitution phase** ($v_{n}>0$). The accumulated normal impulse at this point is $\Lambda_{nc}$.

2.  **Line of Sticking ($s$-line)**: Defined by $v_{t}(t)=0$.
    $$v^{-}_{t}+A_{11}\Lambda_{t}+A_{12}\Lambda_{n}=0\tag{5.61}$$
    On this line, the contact point sticks.

3.  **Friction Cone Edges**: defined by $\Lambda_{t}=\pm \mu \Lambda_{n}$.

4.  **Termination Line ($t$-line)**: Defines when the collision ends ($t=\Delta t$). Its position depends on the definition of ${e}_{n}$:
    *   **Newton's (Kinematic) Restitution**: $v^{+}_{n}=-{e}_{n}v^{-}_{n}$. The line is parallel to the $c$-line:
        $$v^{-}_{n}+A_{12}\Lambda_{t}+A_{22}\Lambda_{n}=-{e}_{n}v^{-}_{n}\tag{5.62}$$
    *   **Poisson's (Impulse) Restitution**: Defined by the ratio of impulses during restitution and compression phases: ${e}_{n}=(\Lambda_{nf}-\Lambda_{nc})/\Lambda_{nc}$. This gives a horizontal termination line:
        $$\Lambda_{n}(t_{f})=(1+{e}_{n})\Lambda_{nc}\tag{5.63}$$
    *   **Stronge's (Energetic) Restitution**: Ratio of work done during restitution to work done during compression. Used when energy consistency is critical in complex systems.

> [!info] Newton vs. Poisson
> For a point particle (diagonal $\mathbf{A}_{c}$), Newton and Poisson definitions are equivalent. For coupled systems ($A_{12} \neq 0$), they differ. Poisson's definition guarantees energy consistency ($\Delta T \leq 0$), while Newton's may occasionally violate it for certain parameters.

### Algorithm for Impulse Accumulation

To solve the impact problem graphically or numerically:

1.  **Start at origin**: $(\Lambda_{t}, \Lambda_{n})=(0,0)$.
2.  **Determine initial slip direction**: Check $\mathrm{sgn}(v^{-}_{t})$.
3.  **March upwards** (increasing $\Lambda_{n}$):
    *   If slipping ($v_{t} \neq 0$): Move along the friction cone edge $\Lambda_{t}=-\mathrm{sgn}(v_{t})\mu\Lambda_{n}$.
    *   If sticking ($v_{t}=0$): If the $s$-line lies *inside* the friction cone, move along the $s$-line. If not, slip along the appropriate cone edge.
4.  **Monitor crossings**:
    *   If $s$-line is crossed: Velocity $v_{t}$ reverses sign. Slip direction changes (move to opposite cone edge).
    *   If $c$-line is crossed ($v_{n}=0$): Record current normal impulse $\Lambda_{nc}$.
5.  **Terminate**:
    *   Stop when the **Total Normal Impulse** reaches the value defined by the termination line (e.g., $\Lambda_{n}=(1+{e}_{n})\Lambda_{nc}$ for Poisson).
6.  **Result**: The point reached in the plane gives the final impulse $\boldsymbol{\Lambda}$, determining the post-impact velocity $\mathbf{v}^{+}$.

This method resolves paradoxes like **Painlevé's paradox** (where rigid body dynamics equations have no solution or non-unique solutions), by treating impact as a proper evolution process.

![[HDY1_005 Impact 2026-01-20 17.15.42.excalidraw.svg]]^figure-rigid-body-impulse-accumulation
>Routh method for rigid body impact.