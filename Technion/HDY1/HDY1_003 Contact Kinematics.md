---
aliases:
  - Contact Kinematics
---
# Contact Kinematics
Let us begin with a mathematical representation of rigid-body contact. Let ${B}_{1}$ and ${B}_{2}$ represent two rigid bodies in $\mathbb{R}^{2}$ or $\mathbb{R}^{3}$. The distance between bodies is defined as
$$d_{21}=\min_{\mathbf{r}_{1}\in B_{1},\ \mathbf{r}_{2}\in B_{2}} \lVert \mathbf{r}_{2}-\mathbf{r}_{1} \rVert.$$
That is, the minimum distance between pairs of material points of the two bodies. It can be proven that for $d_{21}>0$, a minimizing pair $\mathbf{r}_{1},\mathbf{r}_{2}$ is attained at boundary points of $B_{1},B_{2}$, such that $\mathbf{r}_{2}-\mathbf{r}_{1}$ is directed along the common normal $\mathbf{n}_{21}$ to the boundaries of $B_{1},B_{2}$ (pointing from $B_{1}$ to $B_{2}$). Note that $\mathbf{n}_{21}$ is also well defined in the limiting case $d_{21}=0$. For a body with a non-smooth boundary (e.g. a polygon or polyhedron), the minimum distance may be attained at a vertex.

![[HDY1_003 Contact Kinematics 2025-12-02 15.22.32.excalidraw.svg]]^figure-rigid-body-distances
>Examples of distances between rigid bodies.

If the positions and orientations of $B_{1},B_{2}$ are described by generalized coordinates $\mathbf{q}\in \mathbb{R}^{N}$, then maintaining contact can be described as a holonomic constraint $d_{21}(\mathbf{q})=0$. When $d_{21}(\mathbf{q})>0$, the two bodies are separated. If a moving body $B_{1}$ is in contact with bodies $B_{2}$ and $B_{3}$, then (when the constraints are independent) its motion must satisfy two holonomic constraints $d_{21}(\mathbf{q})=0$ and $d_{31}(\mathbf{q})=0$, so the number of DOFs reduces by $2$.

Constrained motion that maintains constant distance between bodies satisfies ${d}_{21}(\mathbf{q}(t))=c$. Let $\mathbf{r}_{1}(\mathbf{q}(t))\in {B}_{1}$ and $\mathbf{r}_{2}(\mathbf{q}(t))\in {B}_{2}$ be the two closest points on the two bodies, and define the unit normal vector
$$\mathbf{n}_{21}= \dfrac{\mathbf{r}_{2}-\mathbf{r}_{1}}{\lvert \mathbf{r}_{2}-\mathbf{r}_{1} \rvert }$$
so that $\mathbf{r}_{2}-\mathbf{r}_{1}={d}_{21}\mathbf{n}_{21}$. These points may be moving relative to the bodies, i.e., not be fixed material points (for non-smooth boundaries, they may be fixed material points located at vertices). The constant distance constraint can be written as 
$$(\mathbf{r}_{2}-\mathbf{r}_{1})\cdot(\mathbf{r}_{2}-\mathbf{r}_{1})=c^{2}$$
Time-differentiation gives
$$2(\dot{\mathbf{r}}_{2}-\dot{\mathbf{r}}_{1})\cdot(\mathbf{r}_{2}-\mathbf{r}_{1})=0$$
Using $\mathbf{r}_{2}-\mathbf{r}_{1}=d_{21}\mathbf{n}_{21}$, we get (for $d_{21}>0$) the standard normal-velocity condition
$$({\mathbf{v}}_{2}-{\mathbf{v}}_{1})\cdot \mathbf{n}_{21}=0.$$
This holds also for the limiting case of contact ${d}_{21}=0$ and implies that the normal relative velocity at the contact points is zero for maintaining contact,
$$({\mathbf{v}}_{2}-{\mathbf{v}}_{1})\cdot \mathbf{n}_{21}=0.$$
In most cases, the contact is *unilateral*, so that for ${d}_{21}=0$, $(\mathbf{v}_{2}-\mathbf{v}_{1})\cdot \mathbf{n}_{21}>0$ implies contact separation, while $(\mathbf{v}_{2}-\mathbf{v}_{1})\cdot \mathbf{n}_{21}<0$ implies collision between the bodies (penetration). $(\mathbf{v}_{2}-\mathbf{v}_{1})\cdot \mathbf{n}_{21}=0$ means maintaining contact.

>[!notes] Note: 
> This is a *sign convention* statement. Since $\mathbf{n}_{21}$ points from $B_{1}$ to $B_{2}$, a positive relative normal velocity means the gap is opening (separation), and a negative one means the gap is closing (impact/penetration tendency).

The fact that $(\mathbf{v}_{2}-\mathbf{v}_{1})\cdot \mathbf{n}_{21}=0$ does not necessarily imply that $\mathbf{v}_{2}=\mathbf{v}_{1}$. There can be relative motion in direction(s) *tangent* to the contacting surfaces and perpendicular to $\mathbf{n}_{21}$. Such motion is called **[[DYN1_004 קינמטיקה של מערכת גופים קשיחים#מפרקים - חיבורים בין גופים קשיחים|slippage]]**. For bodies in 2D, slippage is directed along $\mathbf{t}_{21}$ - a unit tangent direction to the boundary curves of the contacting bodies. For bodies in 3D, there is a tangent plane to the two-dimensional boundary surfaces, so that slippage can be directed along a two-dimensional plane.

**No-slip contact** (or **pure rolling**) is where $\mathbf{v}_{2}-\mathbf{v}_{1}=0$ is always satisfied. That is, the relative velocity between the two contacting material points is always zero. Mathematically, this is represented by a holonomic contact constraint $d_{21}(\mathbf{q})=0$, combined with velocity constraints of the form $\mathbf{W}(\mathbf{q})\dot{\mathbf{q}}=\mathbf{v}_{2}-\mathbf{v}_{1}=0$.

>[!notes] Note: 
>“No slip” means *both* the normal component and the tangential component of the relative velocity vanish. So pure rolling is stronger than “maintaining contact”, which only enforces the normal component to vanish.

Note that this does not necessarily imply that the contact points $\mathbf{r}_{1},\mathbf{r}_{2}$ are fixed material points. Examples include a sphere/wheel/disc rolling on a flat plane (in 2D and in 3D), and a spinning top with a spherical or sharp tip.

>[!question] Question: Is the no-slip constraint integrable? That is, can it be replaced by a holonomic constraint?
> In order to answer this question, we need to consider and prove the following statement:
> In pure rolling motion, the trajectories that the contact points $\mathbf{r}_{1},\mathbf{r}_{2}$ make on the boundaries of the bodies ${B}_{1}$ and ${B}_{2}$ have *equal arc lengths*.
> 
> **Proof**:
> Consider two body-fixed reference frames, $\{ \mathbf{e}_{i}' \}$ attached to ${B}_{1}$ and $\{ \mathbf{e}_{i}'' \}$ attached to ${B}_{2}$. Let $\boldsymbol{\Omega}'$ and $\boldsymbol{\Omega}''$ denote angular velocity vectors of the two reference frames. Let $b',b''$ be body-fixed points on the bodies ${B}_{1},{B}_{2}$ that are instantaneously in contact at time $t={t}_{0}$. Let $p$ denote the location of the contact point, which moves on the boundaries of the bodies ${B}_{1},{B}_{2}$ and coincides with both $b'$ and $b''$ at time $t={t}_{0}$. We can calculate velocities $\mathbf{v}_{b'},\mathbf{v}_{b''}$ using [[DYN1_002 קינמטיקה של חלקיק - מערכת צירים סובבת#כלל האופרטור|differential operator's rule]] as:
> $$\begin{aligned}
>  & \mathbf{v}_{b'}=\mathbf{v}_{o'}+\dfrac{\delta \mathbf{r}_{o'b'}}{\delta t}+\boldsymbol{\Omega}'\times \mathbf{r}_{o'b'} \\[1ex]
>  & \mathbf{v}_{b''}=\mathbf{v}_{o''}+\dfrac{\delta \mathbf{r}_{o''b''}}{\delta t}+\boldsymbol{\Omega}''\times \mathbf{r}_{o''b''}
> \end{aligned} \tag{3.1}$$
> Since both $b'$ and $b''$ are body-fixed points, the frame derivative terms vanish, i.e. $\dfrac{\delta \mathbf{r}_{o'b'}}{\delta t}=\dfrac{\delta \mathbf{r}_{o''b''}}{\delta t}=0$. At time $t={t}_{0}$, the relative velocity at the contact point vanishes, giving:
> $$\mathbf{v}_{o'}+\boldsymbol{\Omega}'\times \mathbf{r}_{o'b'}=\mathbf{v}_{o''}+\boldsymbol{\Omega}''\times \mathbf{r}_{o''b''}\tag{3.2}$$
> 
> Velocity of the moving contact point $p$ can also be derived using differential operator's rule in $\{ \mathbf{e}_{i}' \}$ and $\{ \mathbf{e}_{i}'' \}$ as:
> $$\mathbf{v}_{p}=\mathbf{v}_{o'}+\dfrac{\delta \mathbf{r}_{o'p}}{\delta t}+\boldsymbol{\Omega}'\times \mathbf{r}_{o'p}=\mathbf{v}_{o''}+\dfrac{\delta \mathbf{r}_{o''p}}{\delta t}+\boldsymbol{\Omega}''\times \mathbf{r}_{o''p} \tag{3.3}$$
> At time $t={t}_{0}$ the points $p,b',b''$ coincide, so $\mathbf{r}_{o'p}=\mathbf{r}_{o'b'}$ and $\mathbf{r}_{o''p}=\mathbf{r}_{o''b''}$. Substituting this and $\text{(3.2)}$ into $\text{(3.3)}$ gives:
> $$\dfrac{\delta \mathbf{r}_{o'p}}{\delta t}\bigg|_{\{ \mathbf{e}_{i}' \}}^{} =\dfrac{\delta \mathbf{r}_{o''p}}{\delta t}\bigg|_{\{ \mathbf{e}_{i}'' \}}^{}\tag{3.4} $$
> 
> The equated terms in $\text{(3.4)}$ are the velocities of the contact point $p$ as measured by observers attached to the two body-fixed frames $\{ \mathbf{e}_{i}' \}$ and $\{ \mathbf{e}_{i}'' \}$. Note that $\text{(3.4)}$ holds for each time $t$.
> 
> The arc lengths of the two paths that $p$ travels on the boundaries of ${B}_{1}$ and ${B}_{2}$ are obtained as:
> $$s'=\int_{0}^{{t}_{f}} \left\lvert  \dfrac{\delta \mathbf{r}_{o'p}}{\delta t}  \right\rvert  \, \mathrm{d}t,\qquad s''=\int_{0}^{{t}_{f}} \left\lvert  \dfrac{\delta \mathbf{r}_{o''p}}{\delta t}  \right\rvert  \, \mathrm{d}t  $$
> From $\text{(3.4)}$ we conclude that:
> $$s'=s''$$
> $$\tag*{$\blacksquare$}$$
> 
> Note that the boundary of a 3D body is a two-dimensional surface, whereas the boundary of a 2D body is a one dimensional curve, that can be parametrized by its arclength $s$.
> 
> So, is the no-slip constraint integrable?
> - In 2D motion, yes. The constraint $s'=s''+c$ can be written as $h(\mathbf{q})=0$. Together with the contact constraint it reduces the number of DOFs for the relative motion to $1$.
> 
>   For example, for a wheel rolling on the ground in 2D, $\mathbf{q}=\begin{pmatrix}x & y & \theta\end{pmatrix}^{T}$. The contact constraint is $y=R$, and the pure rolling constraint is $R\dot{\theta}=\dot{x}$. Integrating gives $x=x_{0}+R\theta$. The motion has 1 DOF and can be parameterized by $x$ or by $\theta$. Examples: [wheel on ground](https://www.f-lohmueller.de/pov_tut/animate/anim131e.htm), [planetary gear](https://grabcad.com/library/planetary-epicyclic-gear-train-animated-1#!).
> - For smooth bodies in 3D no-slip constraints are **NOT** integrable. Examples: upright rolling disc on plane, rolling sphere, rolling ellipsoid.
> - For a body with a non-smooth boundary in contact with a smooth body, a *vertex point* of ${B}_{1}$ will keep contact with a *fixed* point on the smooth body ${B}_{2}$. In such a case, rolling is integrable also for 3D motion. Example: Euler's spinning top.
> 

## Statics of Contact Forces and Friction
Consider two rigid bodies in 2D, having a point contact. We can (uniquely) define the unit vectors $\hat{\mathbf{n}},\hat{\mathbf{t}}$ of normal and tangent directions at the contact point. The contact force, which is an internal force acting at the contact, can be decomposed into normal and tangential components as $\mathbf{f}={f}_{n}\hat{\mathbf{n}}+{f}_{t}\hat{\mathbf{t}}$. For *unilateral contact*, only compression forces are allowed, ${f}_{n}\geq 0$ (in contrast to tension/adhesion forces which can be realized in case of vacuum, magnetic force, grippers, or chemical adhesion, surface tension, etc.).

![[HDY1_003 Contact Kinematics 2025-12-02 17.07.37.excalidraw.svg]]^figure-contact-forces
>Contact forces.

When the contact is subject to compression load in normal direction, the bodies undergo small elastic deformations. Assuming that the bodies have large but finite stiffness, these deformations are localized near the contact area, and one can still consider the nominal undeformed shape of the two bodies, with small local penetration in normal direction: ${d}_{21}=-{\delta}_{n}<0$.

![[HDY1_003 Contact Kinematics 2025-12-02 21.57.13.excalidraw.svg]]^figure-contact-penetration
> Contact forces with penetration.

For small deformations, the normal force ${f}_{n}$ depends monotonically on the normal displacement ${\delta}_{n}$. Hertz theory of contact mechanics of smooth frictionless bodies such as cylinders and ellipsoids suggests a power law of ${f}_{n}\sim{{{\delta}_{n}}}^{1.5}$. Around an operating point ${\delta}_{n,0}$, this can be linearized to a spring law of the form
$$f_{n}\approx f_{n,0}+k_{n}(\delta_{n}-\delta_{n,0}).$$

Now, suppose that after applying a normal loading force ${f}_{n}$ and reaching an equilibrium normal displacement ${\delta}_{n}$, one begins to apply a loading force ${f}_{t}$ in the tangential direction, causing a tangential displacement ${\delta}_{t}$. For small loads, the force-displacement may behave linearly as ${f}_{t}=-{k}_{t}{\delta}_{t}$ and the "normal penetration cavity" deforms asymmetrically until reaching a critical tangential force ${f}_{\text{cr}}$ where the normal cavity "fails" and the bodies transition from micro- to macro-scale slippage. Both ${k}_{t}$ and the critical tangential force ${f}_{\text{cr}}$ increase for larger initial normal penetration and force.

![[HDY1_003 Contact Kinematics 2025-12-02 17.18.43.excalidraw.svg]]^figure-tangential-loading
>Loading force in tangential direction.

In the limit of rigid bodies, the whole segment of micro-slip motion is lumped to zero, and one can replace the tangential displacement ${\delta}_{t}$ with the tangential slip velocity ${v}_{t}=\dot{\delta}_{t}$. The simplest model for the critical tangential force states that it is linearly proportional to the normal force, ${f}_{\text{cr}}=\mu {f}_{n}$. The constant $\mu$ is a material/surface property called the *coefficient of dry friction*. This implies that $\lvert {f}_{t} \rvert\leq \mu {f}_{n}$, which is also known as [[DVI1_002 רטט חופשי של מערכת  בדרגת חופש אחת#ריסון קולון - חיכוך יבש|Coulomb friction]].

![[HDY1_003 Contact Kinematics 2025-12-02 22.02.41.excalidraw.svg]]^figure-coulomb-friction-law
>Coulomb's friction law.

The graphic description of this friction law states that the direction of friction force $\mathbf{f}$ must be bounded within a cone called **friction cone**, centered about the contact normal $\hat{\mathbf{n}}$, with half-angle of 
$$\gamma=\tan^{-1}(\mu)$$
called **friction angle**. A simple experiment for determining the friction coefficient is to put the body on an inclined plane and gradually increase the slope until reaching a critical angle $\gamma$ where the body begins to slip. This is precisely $\gamma=\tan^{-1}(\mu)$.


![[HDY1_003 Contact Kinematics 2025-12-02 22.04.08.excalidraw.svg]]^figure-friction-cone
>Friction cone, friction angle.

After macro-scale slip begins, the actual friction force ${f}_{t}$ may drop a bit below ${f}_{\text{cr}}$. This is sometimes represented by different coefficients of static and dynamic friction ${\mu}_{s}>{\mu}_{d}$, such that
$$f_{t}=-\mu_{d}\,\mathrm{sgn}(v_{t})\,f_{n}\qquad\text{for }v_{t}\neq 0.$$
To summarize, the friction law in a unilateral contact can be formulated as:
$$\begin{cases}
{f}_{n}={f}_{t}=0 &  {v}_{n}>0 & \text{(contact separation)} \\[1ex]
{f}_{n}\geq 0 & {v}_{n}=0 & \text{(contact)} \\[1ex]
\lvert {f}_{t} \rvert \leq  {\mu}_{s}{f}_{n} & {v}_{t}=0 & \text{(no-slip)} \\[1ex]
{f}_{t}=-\mathrm{sgn}({v}_{t}){\mu}_{d}{f}_{n} & {v}_{t}\neq 0 & \text{(slip)}
\end{cases} \tag{3.5}$$

![[HDY1_003 Contact Kinematics 2025-12-05 10.47.52.excalidraw.svg]]^figure-unilateral-friction-law
>Static friction force of unilateral contact

For simplicity, in many cases one does not distinguish between static and dynamic friction and assumes that ${\mu}_{s}={\mu}_{d}=\mu$. For sufficiently slow motions, it is assumed the friction force is independent of the magnitude of the slip velocity ${v}_{t}\neq 0$. When the friction force is assumed to be affected by slip *velocity*, the simplest model is linear (viscous) damping, ${f}_{t}=-c{v}_{t}$. Combining the effects of static and dynamic dry friction with high-velocity viscous friction gives rise to **Stribeck's effect**, illustrated in the following figure:

![[HDY1_003 Contact Kinematics 2025-12-05 16.59.18.excalidraw.svg]]^figure-stribeck-effect
>Viscous damping and Stribeck's effect.

### Extension of Coulomb's Friction to 3D
The tangent is now a 2D plane, perpendicular to $\hat{\mathbf{n}}$. The contact force is written as $\mathbf{f}=f_{n}\hat{\mathbf{n}}+\mathbf{f}_{t}$, where $\mathbf{f}_{t}\perp \hat{\mathbf{n}}$, or equivalently
$$\mathbf{f}_{t}=\mathbf{f}-(\mathbf{f}\cdot\hat{\mathbf{n}})\hat{\mathbf{n}}.$$
Coulomb's inequality states that $\lVert \mathbf{f}_{t} \rVert\leq \mu f_{n}$. In components (assuming $\hat{\mathbf{n}}=\hat{\mathbf{z}}$), $\sqrt{f_{x}^{2}+f_{y}^{2}}\leq \mu f_{z}$. Graphically, the direction of $\mathbf{f}$ must lie within a quadratic "ice-cream cone".

![[HDY1_003 Contact Kinematics 2025-12-05 17.07.31.excalidraw.svg]]^figure-3d-frictional-contact
>3D frictional contact.



Another effect that may exist in 3D frictional contact: If the contacting bodies slightly deform to a contact region of small circular patch, tangential forces may generate added resisting "torsional moment" ${\tau}_{n}$ about $\hat{\mathbf{n}}$. Since the radius of the contact patch grows monotonically with ${f}_{n}$, this **soft finger model** assumes that $\lvert {\tau}_{n} \rvert \leq {r}_{t}\mu {f}_{n}$, where ${r}_{t}$ is the torsional friction coefficient (represents "effective" radius of the contact patch).

## Graphical Analysis of Force Statics in 2D
When a static body/structure is subject to *two* external forces (vectors) and no external torques (i.e. [[SLD1_003 מסבכים, מסגרות ומכונות#מסבכים|two-force member]]), the forces are equal and opposite, and must be directed along the line connecting the two points where the forces act.

In the case of *three* external forces and no external pure torques, the lines of action of the three forces must intersect at a common point, OR all three forces must be parallel and anti-parallel (this is actually a limit of the general case with intersection point approaching infinity).

![[HDY1_003 Contact Kinematics 2025-12-09 15.21.27.excalidraw.svg]]^figure-three-force-equilibrium
>Three-force equilibrium.

Observe the following rigid object supported by two given frictionless point contacts ($\mu=0$).

![[HDY1_003 Contact Kinematics 2025-12-09 15.45.08.excalidraw.svg]]^figure-two-contacts-force-statics
>2D force statics.

Gravity acts at the body's center-of-mass $c$. Where should $c$ be located for static equilibrium?

What if we do have frictional contacts? What if instead of gravity, we'd like to know whether the contacts can support some general force?



![[HDY1_003 Contact Kinematics 2025-12-09 15.46.43.excalidraw.svg]]^figure-general-2d-force-statics-problem
>General 2D force statics problem.

To answer these, we'll learn about two methods: **Linear Programming** and **Moment Labeling**. But first, we need to understand **Polyhedral Cones**.

### Polyhedral Cones
A vector $\mathbf{w}\in \mathbb{R}^{3}$ which represents a load of force and a moment generated by a force $\mathbf{f}$ acting at a point $\mathbf{r}$ is called **wrench**, and defined as:
$$\mathbf{w}=\begin{pmatrix}
{f}_{x} \\
{f}_{y} \\
\hat{\mathbf{z}}\cdot(\mathbf{r}\times \mathbf{f})
\end{pmatrix}=\lambda \begin{pmatrix}
{u}_{x} \\
{u}_{y} \\
\hat{\mathbf{z}}\cdot(\mathbf{r}\times \hat{\mathbf{u}})
\end{pmatrix}=\lambda \hat{\mathbf{w}} \tag{3.6}$$

Where
$$\hat{\mathbf{u}}:=\dfrac{\mathbf{f}}{\lvert \mathbf{f} \rvert },\qquad \hat{\mathbf{w}}:=\begin{pmatrix}
{u}_{x} \\
{u}_{y} \\
\hat{\mathbf{z}}\cdot(\mathbf{r}\times\hat{\mathbf{u}})
\end{pmatrix}$$
The "normalized" vector $\hat{\mathbf{w}}$ represents the force's **line of action**. Note that $\hat{\mathbf{w}}$ is not a unit vector. In the analogous 3D spatial case, a vector of the form $\begin{pmatrix}\hat{\mathbf{u}} & \mathbf{r}\times \hat{\mathbf{u}}\end{pmatrix}^{T}\in \mathbb{R}^{6}$ is called **Plücker coordinates**, which represent a spatial line in 3D.

>[!notes] Note: 
 >A wrench packages “force + where it acts” into a single vector. In 2D, once you know the force direction and its moment about a reference point, you have effectively described the force’s line of action.

**Claim:** every load of total force and torque in 2D is equivalent to a single force + line of action. The only exception is pure torque with zero total force, which is a limit case where the action line goes to infinity. 3D analogue of this claim is that every load of total force and torque in 3D is equivalent to a single force + line of action + torque about the line of action. This is the origin of the term "wrench". Similarly, any rigid-body motion in 3D is equivalent to pure translation about a spatial line + rotation about the same line. This motion is called a "[[DYN1_003 קינמטיקה של גוף קשיח#תנועה בורגית רגעית וציר סיבוב רגעי|screw]]", and 3D rigid-body velocity or infinitesimal motion is called a "twist".

In many cases, the force is unidirectional as in unilateral contact which supports only compression forces ${f}_{n}\geq 0$. This is represented by adding the inequality $\lambda \geq 0$ to $\text{(3.6)}$, which now represents a directed line in 2D. Given a collection of $N$ unilateral forces having directed action lines which are represented by $\hat{\mathbf{w}}_{i}$, then the set of all wrenches (total force + moment) which can be generated by the sum of these forces is given by:

$$W=\{ {\lambda}_{1}\hat{\mathbf{w}}_{1}+\dots +{\lambda}_{N}\hat{\mathbf{w}}_{N}\mid {\lambda}_{1},\dots ,{\lambda}_{N}\geq  0 \} \tag{3.7}$$

We now state that the $W$ from $\text{(3.7)}$ is a **convex cone**:

>[!def] Definition: 
>A set $C\subseteq \mathbb{R}^{n}$ is a **cone** if for any $\mathbf{v}\in C$ we have $\alpha \mathbf{v}\in C$ for any scalar $\alpha\geq 0$. That is, $C$ is invariant under positive scaling. Note that $C$ contains the origin by definition.

>[!def] Definition: 
>A set $C \subseteq \mathbb{R}^{n}$ is **convex** if for any $\mathbf{v}_{1},\mathbf{v}_{2}\in C$ we have $\lambda \mathbf{v}_{1}+(1-\lambda)\mathbf{v}_{2}\in C$ for any scalar $0\leq \lambda \leq 1$. That is, the straight line segment connecting $\mathbf{v}_{1}$ and $\mathbf{v}_{2}$ is entirely contained in $C$.

>[!info] Corollary: 
>A set $C \subseteq \mathbb{R}^{n}$ is a **convex cone** if for any $\mathbf{v}_{1},\mathbf{v}_{2}\in C$ we have ${\alpha}_{1}\mathbf{v}_{1}+{\alpha}_{2}\mathbf{v}_{2}\in C$ for any scalars ${\alpha}_{1},{\alpha}_{2}\geq 0$.

![[Circular-pyramid.png|bookhue|500]]^figure-nonpolyhedral-convex-cone
>Convex cone that is not a conic hull of finitely many generators. [(Wikipedia)](https://en.wikipedia.org/wiki/Convex_cone).

 
![[Polyhedral-cone.png|bookhue|500]]^figure-polyhedral-convex-cone
>Convex cone generated by the conic combination of the three black vectors. [(Wikipedia)](https://en.wikipedia.org/wiki/Convex_cone).


![[Cone-not-convex.png|bookhue|500]]^figure-cone-not-convex
>A cone (the union of two rays) that is not a convex cone. [(Wikipedia)](https://en.wikipedia.org/wiki/Convex_cone).

More specifically, a convex cone of the form $\text{(3.7)}$ is called a **polyhedral convex cone** (PCC): it can be constructed from non-negative combinations of a *finite* set of **generators**.

>[!theorem] Theorem: 
 >Any polyhedral convex cone from $\text{(3.7)}$ can be defined using an equivalent form:
>  $$W=\{ \mathbf{w}\in \mathbb{R}^{n}\mid {{\mathbf{a}_{i}}}^{T}\mathbf{w}\leq  0,\, i=1,\dots ,m \}=\{ \mathbf{w}\in \mathbb{R}^{n} \mid \mathbf{A}\mathbf{w}\leq  0 \} \tag{3.8}$$
>  Where $\mathbf{A}$ is a constant matrix of dimensions $m\times n$ whose rows are the contact vectors ${{\mathbf{a}_{i}}}^{T}$.
> 

Interpretation: Intersection of $m$ half spaces in $\mathbb{R}^{n}$ bounded by hyperplanes ${{\mathbf{a}_{i}}}^{T}\mathbf{w}=0$ which form the "facets" of the PCC, whereas the "generators" $\mathbf{w}_{i}$ in $\text{(3.7)}$ form the "edges" of the PCC.


>[!def] Definition: 
 >A **convex polyhedral set (CPS)** is defined as:
>$$W=\{ \mathbf{w}\in \mathbb{R}^{n}\mid {{\mathbf{a}_{i}}}^{T}\mathbf{w}\leq  b_{i},\ i=1,\dots,m \}=\{ \mathbf{w}\in \mathbb{R}^{n}\mid \mathbf{A}\mathbf{w}\leq  \mathbf{b} \} \tag{3.9}$$

Note that $\text{(3.8)}$ is a special case of $\text{(3.9)}$ but not vice versa, since $W$ in $\text{(3.9)}$ is not necessarily a cone. An equivalent formulation of CPS is:
$$W=\{ {\lambda}_{1}\hat{\mathbf{w}}_{1}+\dots +{\lambda}_{N}\hat{\mathbf{w}}_{N}\mid{\lambda}_{1},\dots ,{\lambda}_{N}\geq 0 \quad \text{and}\quad {\lambda}_{1}+\dots +{\lambda}_{N}=1 \} \tag{3.10}$$
### Linear Programming

>[!TODO] TODO: להשלים


### The Moment Labeling Method
This is a method for graphical representation of polyhedral convex cones of wrenches spanned by action lines of unilateral forces in 2D. Consider a PCC defined as in $\text{(3.7)}$. We now define two sets of points in the 2D plane as:
$$\begin{aligned}
 & {P}_{+}(W)=\left\{  \mathbf{p} \in \mathbb{R}^{2}\mid\hat{\mathbf{z}}\cdot[(\mathbf{r}-\mathbf{p})\times\hat{\mathbf{u}}]\geq  0 \quad \text{for every}\quad \begin{pmatrix}
\hat{\mathbf{u}} \\
\hat{\mathbf{z}}\cdot(\mathbf{r}\times \hat{\mathbf{u}})
\end{pmatrix} \in W \right\} \\[3ex]
 & {P}_{-}(W)=\left\{  \mathbf{p} \in \mathbb{R}^{2}\mid\hat{\mathbf{z}}\cdot[(\mathbf{r}-\mathbf{p})\times\hat{\mathbf{u}}]\leq    0 \quad \text{for every}\quad \begin{pmatrix}
\hat{\mathbf{u}} \\
\hat{\mathbf{z}}\cdot(\mathbf{r}\times \hat{\mathbf{u}})
\end{pmatrix} \in W \right\}
\end{aligned} \tag{3.12}$$

We arbitrarily define that positive torque is counterclockwise (CCW). Graphically, this means that:
- ${P}_{+}(W)$ is a set of all points $\mathbf{p}$ such that any directed force line in $W$ generates *non-negative* moment about $\mathbf{p}$.
- ${P}_{-}(W)$ is a set of all points $\mathbf{p}$ such that any directed force line in $W$ generates *non-positive* moment about $\mathbf{p}$.

For example, if $W$ contains a **single** force line $\hat{\mathbf{w}}$, then ${P}_{+}(W)$ is the half-plane lying to the left side of the line $\hat{\mathbf{w}}$, and ${P}_{-}(W)$ is the half-plane lying at the right side of the line $\hat{\mathbf{w}}$ (right and left relative to the line's arrow direction). The line $\hat{\mathbf{w}}$ is contained in both sets ${P}_{+}(W),\,{P}_{-}(W)$ as the boundary of semi-infinite half-planes.

![[HDY1_003 Contact Kinematics 2025-12-10 22.45.47.excalidraw.svg]]^figure-moment-labeling-p-plus-p-minus
>The sets ${P}_{+}(W),\,{P}_{-}(W)$.

Now we show how one can construct the sets ${P}_{+}(W),\,{P}_{-}(W)$ for a general PCC, where $W$ is defined as a sum in $\text{(3.7)}$, in an iterative way. First, we express $W$ as a "sum" of simpler PCC's. We define the sum of two PCC sets as: ${W}_{1}+{W}_{2}=\{ \mathbf{w}_{1}+\mathbf{w}_{2}\mid \mathbf{w}_{1}\in {W}_{1} \quad\text{and}\quad\mathbf{w}_{2}\in {W}_{2}\}$. It can be shown that it also contains ${\alpha}_{1}\mathbf{w}_{1}+{\alpha}_{2}\mathbf{w}_{2}$ for any ${\alpha}_{1},{\alpha}_{2}\geq 0$.

>[!theorem] Theorem: 
 >The fundamental theorem of moment labeling method says:
 >$$\begin{aligned}
 & {P}_{+}({W}_{1}+{W}_{2})={P}_{+}({W}_{1})\cap {P}_{+}({W}_{2}) \\[1ex]
 & {P}_{-}({W}_{1}+{W}_{2})={P}_{-}({W}_{1})\cap {P}_{-}({W}_{2})
\end{aligned} \tag{3.13}$$

Thus, if the wrench set $W$ is defined in $\text{(3.7)}$ as a positive combination of directed action lines $\hat{\mathbf{w}}_{i}$ for $i=1,\dots,N$, then:
$$W=\{ {\lambda}_{1}\hat{\mathbf{w}}_{1}\mid {\lambda}_{1}\geq 0 \}+\dots+\{ {\lambda}_{N}\hat{\mathbf{w}}_{N}\mid {\lambda}_{N}\geq 0 \}$$
Now, ${P}_{+}(W),\,{P}_{-}(W)$ can be constructed iteratively by intersection of $N$ half-planes associated with each different directed line $\hat{\mathbf{w}}_{i}$. Therefore, these sets form convex polygons in $\mathbb{R}^{2}$, possibly unbounded. We get the following characterization. The set of wrenches in $W$ is characterized by all directed force lines in $\mathbb{R}^{2}$ which pass at the right side of ${P}_{+}(W)$ and at the left side of ${P}_{-}(W)$.

The set of loads that can be resisted/balanced by wrenches in $W$ is characterized by all directed force lines in $\mathbb{R}^{2}$ which pass at the left side of ${P}_{+}(W)$ and at the right side of ${P}_{-}(W)$. That is, all directed force lines such that the entire set ${P}_{+}(W)$ lies at the right side of the line while the entire set of ${P}_{-}(W)$ lies at the left side of the line.

>[!notes] Note: 
>The analysis only guarantees that a static equilibrium solution *exists*. It does not tell us whether it will *actually happen*. The equilibrium may not be stable, for example.

>[!example] Example: 
> Given the following body with two frictionless unilateral contacts, find all the loads that can be resisted.
> 
> ![[HDY1_003 Contact Kinematics 2025-12-12 11.16.24.excalidraw.svg]]^figure-example-two-frictionless-contacts
> >A body with two frictionless unilateral contacts.
> 
> **Solution**:
> First, we assign $+$ and $-$ to each side of each action line. That is, the ${P}_{+}(W)$ and ${P}_{-}(W)$ for each $\hat{\mathbf{n}}_{i}$:
> ![[HDY1_003 Contact Kinematics 2025-12-12 11.36.41.excalidraw.svg]]^figure-example-half-plane-assignments
> >${P}_{+}(W)$ and ${P}_{-}(W)$ assignment for each $\hat{\mathbf{n}}_{i}$.
> 
> Now we can construct the general ${P}_{+}(W)$ and ${P}_{-}(W)$ for the system simply as the intersection as described in $\text{(3.13)}$:
> ![[HDY1_003 Contact Kinematics 2025-12-12 11.40.41.excalidraw.svg]]^figure-example-intersection-p-plus-p-minus
> >${P}_{+}(W)$ and ${P}_{-}(W)$ of the whole system.
> 
> We know all directed force lines that can be resisted are such that the entire set ${P}_{+}(W)$ lies at the *right* side of the line while the entire set of ${P}_{-}(W)$ lies at the *left* side of the line.
> ![[HDY1_003 Contact Kinematics 2025-12-12 11.48.52.excalidraw.svg]]^figure-example-resistable-force-lines
> >All force lines that can be resisted by the frictionless unilateral contacts.
> 

>[!example] Example:
> Given the following trapezoidal object with two *frictional* unilateral contacts, determine whether the object can be lifted under gravity.
> 
> ![[HDY1_003 Contact Kinematics 2025-12-12 12.01.02.excalidraw.svg]]^figure-example-frictional-contacts-object
> >A body with frictional unilateral contacts.
> 
> **Solution**:
> ![[HDY1_003 Contact Kinematics 2025-12-12 12.31.46.excalidraw.svg]]^figure-example-friction-cone-assignments
> >${P}_{+}(W)$ and ${P}_{-}(W)$ assignment for each $\hat{\mathbf{n}}_{i}$.
> 
> ![[HDY1_003 Contact Kinematics 2025-12-12 12.38.39.excalidraw.svg]]^figure-example-frictional-intersection
> >${P}_{+}(W)$ and ${P}_{-}(W)$ of the whole system.
> 
> From the figure above we can see that the only force lines which can be resisted are upwards forces (remember, ${P}_{-}(W)$ must lie to the left of the line, and ${P}_{+}(W)$ must lie to right of the line). Therefore, gravity won't be resisted by the contact forces, no matter how strong the grip is on the object.
> 
> But, if the friction cones are larger, we get that ${P}_{+}={P}_{-}=\varnothing$:
> ![[HDY1_003 Contact Kinematics 2025-12-12 12.55.10.excalidraw.svg]]^figure-example-large-friction-cones
> >A case of large friction cones.
> 
> Now, any line has ${P}_{+}$ to its "right" and ${P}_{-}$ to its "left". Therefore, any load can be resisted by the contact points, including gravity.