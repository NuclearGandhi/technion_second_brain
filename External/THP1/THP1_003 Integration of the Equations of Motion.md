---
aliases:
---
# Motion in One Dimension

A system with one degree of freedom moves *in one dimension*. The most general Lagrangian for such a system (with time-independent external conditions) is:
$$\mathcal{L}=\dfrac{1}{2}a(q)\dot{q}^{2}-U(q)\tag{LL11.1}$$
where $a(q)$ is some positive function of the generalized coordinate $q$. When $q$ is simply a Cartesian coordinate $x$, this simplifies to:
$$\mathcal{L}=\dfrac{1}{2}m\dot{x}^{2}-U(x)\tag{LL11.2}$$

## Solving via Energy Conservation

For one-dimensional systems, we can solve the motion without ever writing down the equation of motion explicitly. The key insight is that **energy is conserved**:
$$E = \dfrac{1}{2}m\dot{x}^{2}+U(x) = \text{constant}$$

This is a powerful simplification. Lagrange's equation would give us a *second-order* ODE, requiring two integrations. But energy conservation already provides one integral, reducing the problem to a *first-order* ODE:
$$\dot{x} = \dfrac{\mathrm{d}x}{\mathrm{d}t} = \pm\sqrt{\dfrac{2[E-U(x)]}{m}}$$

This can be separated and integrated directly:
$$t=\sqrt{ \dfrac{m}{2} }\int  \dfrac{\mathrm{d}x}{\sqrt{ E-U(x) }}+\text{const} \tag{LL11.3} $$

The general solution of a second-order equation contains two arbitrary constants. Here they appear as:
1. The total energy $E$ (which determines *how much* energy the system has)
2. The integration constant (which determines *when* the particle is at a given position)
## Allowed Regions and Turning Points

Since kinetic energy $\frac{1}{2}m\dot{x}^2$ is always non-negative, the particle can only exist where:
$$E - U(x) \geq 0 \quad \Longrightarrow \quad U(x) \leq E$$

This has a simple graphical interpretation. Consider a potential energy curve like the one below:

![[Pasted image 20260203221608.png|bookhue|600]]^figure-u-example
>Example potential energy function $U(x)$. 

Draw a horizontal line at height $E$. The particle can only move in regions where the potential curve lies *below* this line. In [[#^figure-u-example|the figure]], a particle with energy $E$ is confined to either the range $AB$ or the region to the right of $C$.

The boundaries of these allowed regions occur where:
$$U(x)=E\tag{LL11.4}$$

At these points, all energy is potential ($T = 0$), so the velocity vanishes. The particle momentarily stops and reverses direction - hence these are called **turning points**.

>[!info] Finite vs. Infinite Motion
>- **Finite motion**: The particle is trapped between two turning points and oscillates back and forth. This occurs in a *potential well* (like region $AB$).
>- **Infinite motion**: The particle is bounded on at most one side and escapes to infinity (like the region right of $C$).

## Period of Oscillation

For finite (oscillatory) motion between turning points ${x}_{1}$ and ${x}_{2}$, the particle travels from ${x}_{1} \to {x}_{2} \to {x}_{1}$ repeatedly. By time-reversal symmetry, the time to go from ${x}_{1}$ to ${x}_{2}$ equals the time to return. Thus the period is twice the one-way travel time.

Using $\text{(LL11.3)}$, the period as a function of energy is:
$$T(E)=\sqrt{ 2m }\int_{{x}_{1}(E)}^{{x}_{2}(E)} \dfrac{\mathrm{d}x}{\sqrt{ E-U(x) }}\tag{LL11.5} $$
where ${x}_{1}(E)$ and ${x}_{2}(E)$ are the two roots of $U(x) = E$.

>[!note] Understanding the Integral
>The integrand $1/\sqrt{E - U(x)}$ is large near the turning points (where $E - U \to 0$) and smaller in the middle of the well. Physically, this makes sense: the particle moves slowly near the turning points (where it reverses direction) and faster in the middle (where kinetic energy is maximum).

# Determination of the Potential Energy from the Period of Oscillation

We now consider the **inverse problem**: given the period $T$ as a function of energy $E$, can we reconstruct the potential $U(x)$?

Mathematically, this means solving the integral equation $\text{(LL11.5)}$ for the unknown function $U(x)$, treating $T(E)$ as known input.

## Setting Up the Problem

Assume $U(x)$ has a single minimum, which we place at the origin with $U(0) = 0$:

![[Pasted image 20260204101620.png|bookhue|500]]^figure-mechanics-7
>A potential well with a single minimum at $x = 0$.

The key idea is to **invert the relationship**: instead of viewing $U$ as a function of $x$, we view $x$ as a function of $U$.

However, this inverse is **two-valued**. Looking at [[#^figure-mechanics-7|the figure]], for any given potential value $U > 0$, there are *two* positions where the potential has that value:
- ${x}_{1}(U) < 0$ on the left side of the well
- ${x}_{2}(U) > 0$ on the right side of the well

At the minimum, both branches meet: ${x}_{1}(0) = {x}_{2}(0) = 0$.

## Rewriting the Period Integral

We split the integral $\text{(LL11.5)}$ into two parts - left side and right side of the well - and change variables from $x$ to $U$:

$$T(E) =\sqrt{ 2m } \int_{0}^{E} \left[ \dfrac{\mathrm{d}{x}_{2}}{\mathrm{d}U}-\dfrac{\mathrm{d}{x}_{1}}{\mathrm{d}U} \right] \dfrac{\mathrm{d}U}{\sqrt{ E-U }} $$

>[!note] Why the Minus Sign?
>On the left branch, as $U$ increases from $0$ to $E$, $x_1$ goes from $0$ toward more negative values, so $\mathrm{d}x_1/\mathrm{d}U < 0$. The subtraction accounts for the opposite directions of the two branches.

This is an integral equation of **Abel type**. The remarkable fact is that such equations can be inverted analytically.

## The Inversion Trick

The technique is to apply an integral transform that "undoes" the $1/\sqrt{E-U}$ kernel.

**Step 1**: Divide both sides by $\sqrt{\alpha - E}$ and integrate over $E$ from $0$ to $\alpha$:
$$\int_{0}^{\alpha } \dfrac{T(E)}{\sqrt{ \alpha -E }} \, \mathrm{d}E=\sqrt{ 2m } \int_{0}^{\alpha } \int_{0}^{E} \left[ \dfrac{\mathrm{d}{x}_{2}}{\mathrm{d}U}-\dfrac{\mathrm{d}{x}_{1}}{\mathrm{d}U} \right]  \dfrac{\mathrm{d}U\,\mathrm{d}E}{\sqrt{ (\alpha -E)(E-U) }}$$

**Step 2**: On the right side, swap the order of integration. The region of integration is $0 \leq U \leq E \leq \alpha$, which can also be written as $0 \leq U \leq \alpha$ with $U \leq E \leq \alpha$:
$$\int_{0}^{\alpha } \dfrac{T(E)}{\sqrt{ \alpha -E }} \, \mathrm{d}E= \sqrt{ 2m }\int_{0}^{\alpha } \left[ \dfrac{\mathrm{d}{x}_{2}}{\mathrm{d}U}-\dfrac{\mathrm{d}{x}_{1}}{\mathrm{d}U} \right]\mathrm{d}U\int_{U}^{\alpha } \dfrac{\mathrm{d}E}{\sqrt{ (\alpha -E)(E-U) }} $$

**Step 3**: The inner integral over $E$ evaluates to a constant:
$$\int_{U}^{\alpha } \dfrac{\mathrm{d}E}{\sqrt{ (\alpha -E)(E-U) }} = \pi$$

>[!tip] Evaluating the Inner Integral
>Substitute $E = U + (\alpha - U)\sin^2\theta$. Then $\mathrm{d}E = 2(\alpha-U)\sin\theta\cos\theta\,\mathrm{d}\theta$, and the integrand simplifies to $2\,\mathrm{d}\theta$. The limits become $\theta = 0$ to $\theta = \pi/2$, giving $\pi$.

**Step 4**: The remaining integral over $U$ is now trivial:
$$\int_{0}^{\alpha } \dfrac{T(E)}{\sqrt{ \alpha -E }} \, \mathrm{d}E=\pi\sqrt{ 2m }\,[{x}_{2}(\alpha )-{x}_{1}(\alpha )] $$

Replacing $\alpha$ with $U$, we obtain the **inversion formula**:
$${x}_{2}(U)-{x}_{1}(U)=\dfrac{1}{\pi \sqrt{ 2m }}\int_{0}^{U} \dfrac{T(E)}{\sqrt{ U-E }}  \, \mathrm{d}E\tag{LL12.1} $$

## Interpretation and Uniqueness

Formula $\text{(LL12.1)}$ tells us the **width of the potential well** at each energy level - that is, the horizontal distance ${x}_{2}(U) - {x}_{1}(U)$ between the two sides of the well at height $U$.

However, it does *not* tell us where the well is positioned. We could shift the left and right branches horizontally (in opposite directions by the same amount) without changing this width. Thus, **infinitely many potentials** produce the same period function $T(E)$.

To obtain a unique solution, we need additional information. The simplest assumption is that the potential is **symmetric** about the minimum:
$${x}_{2}(U) = -{x}_{1}(U) \equiv x(U)$$

With this symmetry, $\text{(LL12.1)}$ becomes:
$$x(U)=\dfrac{1}{2\pi\sqrt{ 2m }}\int_{0}^{U} \dfrac{T(E)}{\sqrt{ U-E }}  \, \mathrm{d}E\tag{LL12.2} $$

This gives $x$ as a function of $U$, which can (in principle) be inverted to find $U(x)$.

# The Reduced Mass
A complete general solution can be obtained for an extremely important problem, that of the motion of a system consisting of two interacting particles (the *two-body problem*).
As a first step towards the solution of this problem, we shall show how it can be considerably simplified by separating the motion of the system into the motion of the center of mass and that of the particles relative to the center of mass.
The potential energy of the interaction of two particles depends only on the distance between them, i.e. on the magnitude of the difference in their radius vectors. The Lagrangian of such a system is therefore
$$\mathcal{L}=\dfrac{1}{2}{m}_{1}{\dot{\mathbf{r}}_{1}}^{2}+\dfrac{1}{2}{m}_{2}{\dot{\mathbf{r}}_{2}}^{2}-U(\lvert \mathbf{r}_{1}-\mathbf{r}_{2} \rvert )\tag{LL13.1}$$
Let $\mathbf{r}\equiv\mathbf{r}_{1}-\mathbf{r}_{2}$ be the relative position vector, and let the origin be at the center of mass, i.e. ${m}_{1}\mathbf{r}_{1}+{m}_{2}\mathbf{r}_{2}=0$. These two equations give
$$\begin{aligned}
\mathbf{r}_{1}=\dfrac{{m}_{2}\mathbf{r}}{{m}_{1}+{m}_{2}}, &  & \mathbf{r}_{2}=-\dfrac{{m}_{1}\mathbf{r}_{1}}{{m}_{1}+{m}_{2}}
\end{aligned}\tag{LL13.2}$$
Substitution in $\text{(LL13.1)}$ gives
$$\mathcal{L}=\dfrac{1}{2}m \dot{\mathbf{r}}^{2}-U(r)\tag{LL13.3}$$
where
$$m=\dfrac{{m}_{1}{m}_{2}}{{m}_{1}+{m}_{2}}\tag{LL13.4}$$
is called the *reduced mass*. The function $\text{(LL13.3)}$ is formally identical with the Lagrangian of a particle of mass $m$ moving in an externa field $U(r)$ which is symmetrical about a fixed origin.
Thus the problem of two interacting particles is equivalent to that of the motion of one particle in a given external field $U(r)$. From the solution $\mathbf{r}=\mathbf{r}(t)$ of this problem, the paths $\mathbf{r}_{1}=\mathbf{r}_{1}(t)$ and $\mathbf{r}_{2}=\mathbf{r}_{2}(t)$ of the two particles separately, relative to their common center of mass, are obtained by means of formula $\text{(LL13.2)}$.

# Motion in a Central Field
On reducing the two-body problem to one of the motion of a single body, we arrive at the problem of determining the motion of a single particle in an external field such that its potential energy depends only on the distance $r$ from some fixed point. This is called a *central* field. The force acting on the particle is $\mathbf{F}=-\partial U(r)/\partial \mathbf{r}=-(\mathrm{d}U/\mathrm{d}r)\mathbf{r}/r$; its magnitude is likewise a function of $r$ only, and its direction is everywhere that of the radius vector.
It is known that the angular momentum of any system relative to the center of such field is conserved. The angular momentum of a single particle is $\mathbf{M}=\mathbf{r}\times \mathbf{p}$. Since $\mathbf{M}$ is perpendicular to $\mathbf{r}$, the constancy of $\mathbf{M}$ shows that, throughout the motion, the radius vector of the particle lies in the plane perpendicular to $\mathbf{M}$.
Thus the path of a particle in a central field lies in one plane. Using polar coordinates $r,\,\phi$ in that plane, we can write the Lagrangian as
$$\mathcal{L}=\dfrac{1}{2}m(\dot{r}^{2}+r^{2}\dot{\phi}^{2})-U(r)\tag{LL14.1}$$
This function does not involve the coordinate $\dot{\phi}$ explicitly. Any generalized coordinate ${q}_{i}$ which does not appear explicitly in the Lagrangian is said to be *cyclic*. For such a coordinate we have, by Lagrange's equation, $(\mathrm{d}/\mathrm{d}t)\partial L/\partial \dot{q}_{i}=\partial L/\partial {q}_{i}=0$, so that the corresponding generalized momentum ${p}_{i}=\partial L/\partial \dot{q}_{i}$ is an integral of the motion. This leads to a considerable simplification of the problem of integrating the equations of motion when there are cyclic coordinates.
In the present case, the generalized momentum ${p}_{\phi}=mr^{2}\dot{\phi}$ is the same as the angular momentum ${M}_{z}=M$, and we return to the known law of conservation of angular momentum:
$$M=mr^{2}\dot{\phi}=\text{const} $$
This law has a simple geometrical interpretation in the plane motion of a single particle in a center field. The expression $\dfrac{1}{2}r\cdot r\,\mathrm{d}\phi$ is the area of the sector bounded by two neighboring radius vectors and an element of the path.

![[Pasted image 20260204151306.png|bookhue|300]]^figure-mechanics


Calling this area $\mathrm{d}f$, we can write the angular momentum of the particle as
$$M=2mf\tag{LL14.3}$$
where the derivative $f$ is called the **sectorial velocity**. Hence the conservation of angular momentum implies the constancy of the sectorial velocity: in equal times the radius vector of the particle sweeps out equal areas (*Kepler's second law*).



# Exercises

## Question 1
Determine the period of oscillations of a simple pendulum (mass $m$, string length $\ell$, gravitational acceleration $g$) as a function of amplitude.

**Solution**:
Let $\phi$ be the angle from vertical, with maximum angle ${\phi}_{0}$ (the amplitude). The energy is:
$$E=\dfrac{1}{2}m\ell ^{2}\dot{\phi}^{2} - mg\ell\cos \phi$$

At the turning point $\phi = {\phi}_{0}$, the velocity is zero, so $E = -mg\ell \cos {\phi}_{0}$.

By symmetry, the period equals four times the time to swing from $\phi=0$ to $\phi={\phi}_{0}$. Applying $\text{(LL11.5)}$:
$$T =4\sqrt{ \dfrac{\ell}{2g} } \int_{0}^{{\phi}_{0}}  \dfrac{\mathrm{d}\phi}{\sqrt{ \cos \phi-\cos {\phi}_{0} }}$$

Using the identity $\cos\phi - \cos{\phi}_{0} = 2[\sin^2(\phi_0/2) - \sin^2(\phi/2)]$:
$$T =2\sqrt{ \dfrac{\ell}{g} }\int_{0}^{{\phi}_{0}}  \dfrac{\mathrm{d}\phi}{\sqrt{ \sin ^{2}\left( \frac{1}{2}{\phi}_{0} \right)-\sin ^{2}\left( \frac{1}{2}\phi \right) }} $$

The substitution $\sin \xi=\sin(\phi/2) /\sin({\phi}_{0}/2)$ transforms this into:
$$T=4\sqrt{ \dfrac{\ell}{g} }\,K\left( \sin \dfrac{{\phi}_{0}}{2} \right)$$
where $K(k)$ is the **complete elliptic integral of the first kind**:
$$K(k)=\int_{0}^{\pi/2}\dfrac{\mathrm{d}\xi}{\sqrt{ 1-k^{2}\sin ^{2}\xi }} $$

For small amplitudes (${\phi}_{0} \ll 1$), we can expand $K$ in a Taylor series:
$$T=2\pi \sqrt{ \dfrac{\ell}{g} }\left( 1+\dfrac{1}{16}{\phi}_{0}^{2}+\dots  \right)$$

The leading term $T_0 = 2\pi\sqrt{\ell/g}$ is the familiar small-angle result. The correction shows that the period *increases* with amplitude - larger swings take longer.

## Question 2
A system consists of one particle of mass $M$ and $n$ particles with equal masses $m$. Eliminate the motion of the center of mass and so reduce the problem to one involving $n$ particles.

**Solution**:
Let $\mathbf{R}$ be the radius vector of the particle of mass $M$, and $\mathbf{R}_{a}\,(a=1,2,\dots,n)$ those of the particles of mass $m$. We put $\mathbf{r}\mathbf{_{a}\equiv\mathbf{R}_{a}}-\mathbf{R}$ and take the origin to be at the center of mass:
$$M\mathbf{R}+m\sum_{}^{} \mathbf{R}_{a}=0 $$
Hence, $\mathbf{R}=-(m/\mu)\sum_{}^{}\mathbf{r}_{a}$, where $\mu\equiv M+mn$; $\mathbf{R}_{a}=\mathbf{R}+\mathbf{r}_{a}$. Substitution in the Lagrangian $L=\dfrac{1}{2}M\dot{R}^{2}+\dfrac{1}{2}m\sum_{}^{}{\dot{\mathbf{R}}_{a}}^{2}-U$ gives
$$\mathcal{L}=\dfrac{1}{2}m\sum_{a}^{}{{\mathbf{v}_{a}}}^{2}-\dfrac{1}{2}\left( \dfrac{m^{2}}{\mu} \right)\left( \sum_{a}^{}\mathbf{v}_{a}  \right)^{2}-U,\quad \text{where}\quad \mathbf{v}_{a}\equiv \dot{\mathbf{r}}_{a} $$
The potential energy depends only on the distances between the particles, and so can be written as a function of the $\mathbf{r}\mathbf{_{a}}$.