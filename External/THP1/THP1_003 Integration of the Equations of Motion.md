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
>Example potential energy function $U(x)$. [[THP1_000 Course of Theoretical Physics - Mechanics#Bibliography|(Landau & Lifšic, 1976)]].

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
>A potential well with a single minimum at $x = 0$. [[THP1_000 Course of Theoretical Physics - Mechanics#Bibliography|(Landau & Lifšic, 1976)]].

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

We now turn to an extremely important problem: the motion of a system of two interacting particles (the *two-body problem*). Remarkably, this problem can be reduced to an equivalent one-body problem by separating the center-of-mass motion from the relative motion of the particles.

The potential energy of the interaction depends only on the distance between the two particles, i.e. on the magnitude of the difference in their radius vectors. The Lagrangian of such a system is therefore
$$\mathcal{L}=\dfrac{1}{2}{m}_{1}{\dot{\mathbf{r}}_{1}}^{2}+\dfrac{1}{2}{m}_{2}{\dot{\mathbf{r}}_{2}}^{2}-U(\lvert \mathbf{r}_{1}-\mathbf{r}_{2} \rvert )\tag{LL13.1}$$
Let $\mathbf{r}\equiv\mathbf{r}_{1}-\mathbf{r}_{2}$ be the relative position vector, and let the origin be at the center of mass, i.e. ${m}_{1}\mathbf{r}_{1}+{m}_{2}\mathbf{r}_{2}=0$. These two equations give
$$\begin{aligned}
\mathbf{r}_{1}=\dfrac{{m}_{2}\mathbf{r}}{{m}_{1}+{m}_{2}}, &  & \mathbf{r}_{2}=-\dfrac{{m}_{1}\mathbf{r}}{{m}_{1}+{m}_{2}}
\end{aligned}\tag{LL13.2}$$
Substitution in $\text{(LL13.1)}$ gives
$$\mathcal{L}=\dfrac{1}{2}m \dot{\mathbf{r}}^{2}-U(r)\tag{LL13.3}$$
where
$$m=\dfrac{{m}_{1}{m}_{2}}{{m}_{1}+{m}_{2}}\tag{LL13.4}$$
is called the *reduced mass*. The function $\text{(LL13.3)}$ is formally identical with the Lagrangian of a particle of mass $m$ moving in an external field $U(r)$ which is symmetrical about a fixed origin.
Thus the problem of two interacting particles is equivalent to that of the motion of one particle in a given external field $U(r)$. From the solution $\mathbf{r}=\mathbf{r}(t)$ of this problem, the paths $\mathbf{r}_{1}=\mathbf{r}_{1}(t)$ and $\mathbf{r}_{2}=\mathbf{r}_{2}(t)$ of the two particles separately, relative to their common center of mass, are obtained by means of formula $\text{(LL13.2)}$.

# Motion in a Central Field
On reducing the two-body problem to one of the motion of a single body, we arrive at the problem of determining the motion of a single particle in an external field such that its potential energy depends only on the distance $r$ from some fixed point. This is called a *central* field. The force acting on the particle is $\mathbf{F}=-\partial U(r)/\partial \mathbf{r}=-(\mathrm{d}U/\mathrm{d}r)\mathbf{r}/r$; its magnitude is likewise a function of $r$ only, and its direction is everywhere that of the radius vector.
It is known that the angular momentum of any system relative to the center of such a field is conserved. The angular momentum of a single particle is $\mathbf{M}=\mathbf{r}\times \mathbf{p}$. Since $\mathbf{M}$ is perpendicular to $\mathbf{r}$, the constancy of $\mathbf{M}$ shows that, throughout the motion, the radius vector of the particle lies in the plane perpendicular to $\mathbf{M}$.
Thus the path of a particle in a central field lies in one plane. Using polar coordinates $r,\,\phi$ in that plane, we can write the Lagrangian as
$$\mathcal{L}=\dfrac{1}{2}m(\dot{r}^{2}+r^{2}\dot{\phi}^{2})-U(r)\tag{LL14.1}$$
This function does not involve the coordinate $\phi$ explicitly. Any generalized coordinate ${q}_{i}$ which does not appear explicitly in the Lagrangian is said to be *cyclic*. For such a coordinate we have, by Lagrange's equation, $(\mathrm{d}/\mathrm{d}t)\partial L/\partial \dot{q}_{i}=\partial L/\partial {q}_{i}=0$, so that the corresponding generalized momentum ${p}_{i}=\partial L/\partial \dot{q}_{i}$ is an integral of the motion. This leads to a considerable simplification of the problem of integrating the equations of motion when there are cyclic coordinates.
In the present case, the generalized momentum ${p}_{\phi}=mr^{2}\dot{\phi}$ is the same as the angular momentum ${M}_{z}=M$, and we return to the known law of conservation of angular momentum:
$$M=mr^{2}\dot{\phi}=\text{const}\tag{LL14.2} $$
This law has a simple geometrical interpretation in the plane motion of a single particle in a central field. The expression $\frac{1}{2}r\cdot r\,\mathrm{d}\phi$ is the area of the sector bounded by two neighboring radius vectors and an element of the path.

![[Pasted image 20260204151306.png|bookhue|300]]^figure-mechanics
>Integration over a path. [[THP1_000 Course of Theoretical Physics - Mechanics#Bibliography|(Landau & Lifšic, 1976)]].

Calling this area $\mathrm{d}f$, we can write the angular momentum of the particle as
$$M=2m\dot{f}\tag{LL14.3}$$
where the time derivative $\dot{f}=\mathrm{d}f/\mathrm{d}t$ is called the **sectorial velocity**. Hence the conservation of angular momentum implies the constancy of the sectorial velocity: in equal times the radius vector of the particle sweeps out equal areas (*Kepler's second law*).

The complete solution of the problem of the motion of a particle in a central field is most simply obtained by starting from laws of conservation of energy and angular momentum, without writing out the equations of motion themselves.

Expressing $\dot{\phi}$ in terms of $M$ from $\text{(LL14.2)}$ and substituting in the expression for the energy, we obtain
$$\begin{align}
E & =\dfrac{1}{2}m(\dot{r}^{2}+r^{2}\dot{\phi}^{2})+U(r) \\[3ex]
 & \implies E=\dfrac{1}{2}m\dot{r}^{2}+\dfrac{1}{2} \dfrac{M^{2}}{mr^{2}}+U(r) \tag{LL14.4}
\end{align}$$
Hence
$$\dot{r}\equiv  \dfrac{\mathrm{d}r}{\mathrm{d}t}=\sqrt{ \dfrac{2}{m}[E-U(r)]-\dfrac{M^{2}}{m^{2}r^{2}} } \tag{LL14.5}$$
or, integrating,
$$t=\int_{}^{} \dfrac{1}{\sqrt{ (2/m)[E-U(r)] -M^{2}/(m^{2}r^{2})}}\,\mathrm{d}r+\text{const}  \tag{LL14.6}$$

Writing $\text{(LL14.2)}$ as $\mathrm{d}\phi=M\,\mathrm{d}t/(mr^{2})$, substituting $\mathrm{d}t$ from $\text{(LL14.5)}$ and integrating, we find
$$\phi=\int \dfrac{M/r^{2}}{\sqrt{ 2m[E-U(r)]-M^{2}/r^{2} }} \, \mathrm{d}r\tag{LL14.7} $$
Formula $\text{(LL14.6)}$ and $\text{(LL14.7)}$ give the general solution of the problem. The latter formula gives the relation between $r$ and $\phi$, i.e. the equations of the path.
Formula $\text{(LL14.6)}$ gives the distance $r$ from the center as an implicit function of time. The angle $\phi$, it should be noted, always varies monotonically with time, since $\text{(LL14.2)}$ shows that $\dot{\phi}$ can never change sign.

The expression $\text{(LL14.4)}$ shows that the radial part of the motion can be regarded as taking place in one dimension in a field where the "effective potential energy" is
$${U}_{\text{eff}}=U(r)+\dfrac{M^{2}}{2mr^{2}}\tag{LL14.8}$$
The quantity $M^{2}/(2mr^{2})$ is called the **centrifugal energy**. The values of $r$ for which
$$U(r)+\dfrac{M^{2}}{2mr^{2}}=E\tag{LL14.9}$$
determine the limits of the motion as regards distance from the center. When equation $\text{(LL14.9)}$ is satisfied, the radial velocity $\dot{r}$ is zero. This does not mean that the particle comes to rest as in true one-dimensional motion, since the angular velocity $\dot{\phi}$ is not zero. The value $\dot{r}=0$ indicates a *turning point* of the path, where $r(t)$ begins to decrease instead of increasing, or vice versa.
If the range in which $r$ may vary is limited only by the condition $r\geq {r}_{\min_{}}$, the motion is infinite: the particle comes from, and returns to, infinity.

If the range of $r$ has two limits ${r}_{\min_{}}$ and ${r}_{\max_{}}$, the motion is finite and the path lies entirely within the annulus bounded by the circles $r={r}_{\max_{}}$ and $r={r}_{\min_{}}$. This does not mean, however, that the path must be a closed curve. During the time in which $r$ varies from ${r}_{\max_{}}$ to ${r}_{\min_{}}$ and back, the radius vector turns through an angle $\Delta \phi$ which, according to $\text{(LL14.7)}$, is given by
$$\Delta \phi = 2\int_{{r}_{\min_{}}}^{{r}_{\max_{}}} \dfrac{M/r^{2}}{\sqrt{ [2m(E-U)-M^{2}/r^{2}] }}  \, \mathrm{d}r\tag{LL14.10} $$
The condition for the path to be closed is that this angle should be a rational fraction of $2\pi$, i.e. that $\Delta \phi=2\pi k/n$, where $k$ and $n$ are integers. In that case, after $n$ periods, the radius vector of the particle will have made $k$ complete revolutions and will occupy its original position, so that the path is closed.

Such cases are exceptional, however, and when the form of $U(r)$ is arbitrary the angle $\Delta \phi$ is not a rational fraction of $2\pi$. In general, therefore, the path of a particle executing a finite motion is not closed. It passes through the minimum and maximum distances an infinite number of times, and after infinite time it covers the entire annulus between the bounding circles. The path shown in the following figure is an example:

![[Pasted image 20260211174007.png|bookhue|450]]^figure-not-closed-path
>Unclosed path of a particle. [[THP1_000 Course of Theoretical Physics - Mechanics#Bibliography|(Landau & Lifšic, 1976)]].

There are two types of central field in which all finite motions take place in closed paths. They are those in which the potential energy of the particle varies as $1/r$ or as $r^{2}$. The former case is discussed shortly. The latter is that of **space oscillator**.

At a turning point the square root in $\text{(LL14.5)}$, and therefore the integrands in $\text{(LL14.6)}$ and $\text{(LL14.7)}$, change sign. If the angle $\phi$ is measured from the direction of the radius vector to the turning point, the parts of the path on each side of that point differ only in the sign of $\phi$ for each value of $r$, i.e. the path is symmetrical about the line $\phi=0$. Starting, say, from a point where $r={r}_{\max_{}}$ the particle traverses a segment of the path as far as a point with $r={r}_{\min_{}}$, then follows a symmetrically placed segment to the next point where $r={r}_{\max_{}}$, and so on. Thus the entire path is obtained by repeating identical segments forwards and backwards. This applies also to infinite paths, which consist of two symmetrical branches extending from the turning point ($r={r}_{\min_{}}$) to infinity.

The presence of the centrifugal energy when $M\neq 0$, which becomes infinite as $1/r^{2}$ when $r\to 0$, generally renders it impossible for the particle to reach the center of the field, even if the field is an attractive one. A "fall" of the particle to the center is possible only if the potential energy tends sufficiently rapidly to $-\infty$ as $r\to 0$. From the inequality
$$\dfrac{1}{2}m \dot{r}^{2}=E-U(r)-\dfrac{M^{2}}{2mr^{2}}>0$$
or $r^{2}U(r)+M^{2}/2m<Er^{2}$, it follows that $r$ can take values tending to zero only if
$$[r^{2}U(r)]_{r\to  0}<-M^{2}/2m\tag{LL14.11}$$
i.e. $U(r)$ must tend to $-\infty$ either as $-\alpha /r^{2}$ with $\alpha> M^{2}/2m$, or proportionally to $-1/r^{n}$ with $n>2$.

# Kepler's Problem

An important class of central fields is formed by those in which the potential energy is inversely proportional to $r$, and the force accordingly inversely proportional to $r^{2}$. They include the fields of Newtonian gravitational attraction and of Coulomb electrostatic interaction; the latter may be either attractive or repulsive.
Let us first consider an attractive field, where
$$U=-\dfrac{\alpha}{r} \tag{LL15.1}$$

with $\alpha$ a positive constant. The "effective" potential energy
$${U}_{\text{eff}}=-\dfrac{\alpha}{r}+\dfrac{M^{2}}{2mr^{2}}\tag{LL15.2}$$
is of the form shown in the following figure:

![[Pasted image 20260328101524.png|bookhue|400]]^figure-attractive-field-eff-potential
>Effective potential of an attractive field. [[THP1_000 Course of Theoretical Physics - Mechanics#Bibliography|(Landau & Lifšic, 1976)]].

As $r\to 0$, ${U}_{\text{eff}}$ tends to $+\infty$, and as $r\to \infty$, it tends to zero from negative values; for $r=M^{2}/m\alpha$, it has a minimum value
$${U}_{\text{eff},\, \min_{}}=-\dfrac{m\alpha ^{2}}{2M^{2}}\tag{LL15.3}$$
It is seen at once from [[#^figure-attractive-field-eff-potential|figure]] that the motion is finite for $E<0$ and infinite for $E>0$.

The shape of the path is obtained from the general formula $\text{(LL14.7)}$. Substituting there $U=-\alpha /r$ and effecting the elementary integration, we have
$$\phi=\cos^{-1} \left( \dfrac{(M/r)-(m\alpha /M)}{\sqrt{ 2mE+\dfrac{m^{2}\alpha^{2}}{M^{2}} }} \right)+\text{const} $$
Taking the origin of $\phi$ such that the constant is zero, and putting
$$p=\dfrac{M^{2}}{m\alpha },\qquad e=\sqrt{ 1+\left( \dfrac{2EM^{2}}{m\alpha ^{2}} \right) }\tag{LL15.4}$$
we can write the equation of the path as
$$\dfrac{p}{r}=1+e\cos \phi\tag{LL15.5}$$
This is the equation of a conic section with one focus at the origin. $2p$ is called the **latus rectum** of the orbit and $e$ the **eccentricity**. Our choice of the origin of $\phi$ is seen from $\text{(LL15.5)}$ to be such that the point where $\phi=0$ is the point nearest to the origin (called the **perihelion**).

In the equivalent problem of two particles interacting according to the law $\text{(LL15.1)}$, the orbit of each particle is a conic section, with one focus at the center of mass of the two particles.
It is seen from $\text{(LL15.4)}$ that, if $E<0$, then the eccentricity $e<1$, i.e. the orbit is an ellipse and the motion is finite, in accordance with what has been said in the preceding section.

![[Pasted image 20260328102618.png|bookhue|400]]^figure-ellipse-orbit
>Path of mass in an attractive potential field where $E<0$. [[THP1_000 Course of Theoretical Physics - Mechanics#Bibliography|(Landau & Lifšic, 1976)]].

According to the formula of analytical geometry, the major and minor semi-axes of the ellipse are
$$\begin{aligned}
 & a=\dfrac{p}{(1-e^{2})}=\dfrac{\alpha}{2\lvert E \rvert } \\[1ex]
 & b=\dfrac{p}{\sqrt{ 1-e^{2} }}=\dfrac{M}{\sqrt{ 2m\lvert E \rvert  }}
\end{aligned}\tag{LL15.6}$$

The least possible value of the energy is $\text{(LL15.3)}$, and then $e=0$, i.e. the ellipse becomes a circle. It may be noted that the major axis of the ellipse depends only on the energy of the particle, and not on its angular momentum. The least and greatest distances from the center of the field (the focus of the ellipse) are
$$\begin{aligned}
 & {r}_{\min_{}}=\dfrac{p}{1+e}=a(1-e) \\[1ex]
 & {r}_{\max_{}}=\dfrac{p}{1-e}=a(1+e)
\end{aligned}\tag{LL15.7}$$
These expressions, with $a$ and $e$ given by $\text{(LL15.6)}$ and $\text{(LL15.4)}$, can, of course, also be obtained directly as the roots of equation ${U}_{\text{eff}}(r)=E$.

The period $T$ of revolution in an elliptical orbit is conveniently found by using the law of conservation of angular momentum in the form of the area integral $\text{(LL14.3)}$. Integrating this equation with respect to time from zero to $T$, we have $2mf=TM$, where $f$ is the area of the orbit. For an ellipse $f=\pi ab$, and by using the formula $\text{(LL15.6)}$ we find
$$\begin{aligned}
T & =2\pi a^{3/2}\sqrt{ (m/\alpha ) }  \\[1ex]
 & =\pi\alpha \sqrt{ \dfrac{m}{2\lvert E \rvert^{3} } }
\end{aligned}\tag{LL15.8}$$
It may be noted that the period depends only on the energy of the particle.
For $E\geq 0$, the motion is infinite. If $E>0$, the eccentricity $e>1$, i.e. the path is a hyperbola with the origin as internal focus. The distance of the perihelion from the focus is
$${r}_{\min_{}}=\dfrac{p}{e+1}=a(e-1)\tag{LL15.9}$$
where $a=\dfrac{p}{e^{2}-1}=\dfrac{\alpha}{2E}$ is the "semi-axis" of the hyperbola.

![[Pasted image 20260328105442.png|bookhue|400]]^figure-hyperbola-orbit
>Path of mass in an attractive potential field where $E\geq 0$. [[THP1_000 Course of Theoretical Physics - Mechanics#Bibliography|(Landau & Lifšic, 1976)]].

If $E=0$, the eccentricity $e=1$, and the particle moves in a parabola with perihelion distance ${r}_{\min_{}}=\dfrac{1}{2}p$. This case occurs if the particle starts from rest at infinity.

The coordinates of the particle as functions of time in the orbit may be found by means of the general formula $\text{(LL14.6)}$. They may be represented in a convenient parametric form as follows.
Let us first consider elliptical orbits. With $a$ and $e$ given by $\text{(LL15.6)}$ and $\text{(LL15.4)}$ we can write the integral $\text{(LL14.6)}$ for the time as
$$\begin{aligned}
t & =\sqrt{ \dfrac{m}{2\lvert E \rvert } }\int_{}^{} \dfrac{r}{\sqrt{  -r^{2}+\left( \dfrac{\alpha}{\lvert E \rvert }  \right)r-\left( \dfrac{M^{2}}{2m\lvert E \rvert } \right)  }} \, \mathrm{d}r \\[1ex]
 & =\sqrt{ \dfrac{ma}{\alpha } }\int_{}^{} \dfrac{r}{\sqrt{ a^{2}e^{2}-(r-a)^{2} }} \, \mathrm{d}r 
\end{aligned}$$

The substitution $r-a=-ae\cos \xi$ converts the integral to
$$\begin{aligned}
t & =\sqrt{ \dfrac{ma^{3}}{\alpha } }\int_{}^{} (1-e\cos \xi) \, \mathrm{d}\xi  \\[1ex]
 & =\sqrt{ \dfrac{ma^{3}}{\alpha } }\,(\xi-e\sin \xi)+\text{const} 
\end{aligned}$$
If time is measured in such a way that the constant is zero, we have the following parametric dependence of $r$ on $t$:
$$r=a(1-e\cos \xi),\qquad t=\sqrt{ \dfrac{ma^{3}}{\alpha } }\,(\xi-e\sin \xi)\tag{LL15.10}$$
the particle being at perihelion at $t=0$. The Cartesian coordinates $x=r\cos \phi,\,y=r\sin \phi$ (the $x$ and $y$ axes being respectively parallel to the major and minor axes of the ellipse) can likewise be expressed in terms of the parameter $\xi$.


> [!Stop]
>Stopped here. Became boring.


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

## Question 3
Integrate the equations of motion for a *spherical pendulum* (a particle of mass $m$ moving on the surface of a sphere of radius $\ell$ in a gravitational field).

**Solution**:
In spherical coordinates, with the origin at the center of the sphere and the polar axis vertically downwards, the Lagrangian of the pendulum is
$$\dfrac{1}{2}m\ell ^{2}(\dot{\theta}^{2}+\dot{\phi} ^{2}\sin ^{2}\theta)+mg\ell \cos\theta\tag{EX3.1}$$
The coordinate $\phi$ is *cyclic*, and hence the generalized momentum ${p}_{\phi}$, which is the same as the $z$-component of angular momentum, is conserved:
$$m\ell ^{2}\dot{\phi} \sin ^{2}\theta={M}_{z}=\text{const} $$
The energy is
$$\begin{aligned}
E & =\dfrac{1}{2}m\ell ^{2}(\dot{\theta}^{2}+\dot{\phi}^{2}\sin ^{2}\theta)-mg\ell \cos\theta \\[1ex]
 & =\dfrac{1}{2}m\ell ^{2}\dot{\theta}^{2}+\dfrac{{M}_{z}^{2}}{2m\ell ^{2}\sin ^{2}\theta}-mg\ell \cos\theta
\end{aligned}\tag{EX3.2}$$
Hence
$$t=\int \dfrac{1}{\sqrt{ 2[E-{U}_{\text{eff}}(\theta)]/m\ell ^{2} }} \, \mathrm{d}\theta \tag{EX3.3}$$
where the *effective potential energy* is
$${U}_{\text{eff}}(\theta)=\dfrac{1}{2} \dfrac{{{{M}_{z}}}^{2}}{m\ell ^{2}\sin ^{2}\theta}-mg\ell \cos\theta$$
For the angle $\phi$ we find, using the conservation of ${M}_{z}$:
$$\phi=\dfrac{{M}_{z}}{\ell\sqrt{ 2m }} \int \dfrac{1}{\sin ^{2}\theta\sqrt{ E-{U}_{\text{eff}}(\theta) }} \, \mathrm{d}\theta \tag{EX3.4}$$
The integral $\text{(EX3.3)}$ and $\text{(EX3.4)}$ lead to elliptic integrals of the first and third kinds respectively.

The range of $\theta$ in which the motion takes place is that where $E>{U}_{\text{eff}}$, and its limits are given by the equation $E={U}_{\text{eff}}$. This is a cubic equation for $\cos\theta$, having two roots between $-1$ and $+1$; these define two circles of latitude on the sphere, between which the path lies.

