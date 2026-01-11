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