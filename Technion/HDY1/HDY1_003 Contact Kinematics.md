---
aliases:
---
# Contact Kinematics
Let us begin with a mathematical representation of rigid-body contact. Let ${B}_{1}$, ${B}_{2}$ represent two rigid bodies $\mathbb{R}^{2}$ or $\mathbb{R}^{3}$. The distance between bodies is defined as ${d}_{21}=\min \{ \lvert \mathbf{r}_{2}-\mathbf{r}_{1} \rvert \}$ where $\mathbf{r}_{1}\in {B}_{1}$ and $\mathbf{r}_{2} \in {B}_{2}$. That is, minimum distance between pairs of material points of the two bodies. It can be proven that for ${d}_{21}>0$, the minimum of $\lvert \mathbf{r}_{2}-\mathbf{r}_{1} \rvert$ is attained when $\mathbf{r}_{1},\mathbf{r}_{2}$ are boundary points of ${B}_{1},{B}_{2}$, such that $\mathbf{r}_{2}-\mathbf{r}_{1}$ is directed along the common normal $\mathbf{n}_{21}$ to the boundaries of ${B}_{1},{B}_{2}$ (pointing from ${B}_{1}$ to ${B}_{2}$). Note that $\mathbf{n}_{21}$ is well defined also for the limiting case ${d}_{21}=0$, for a body with non-smooth boundary (e.g. polygon or polyhedron), the minimum distance may be attained at a vertex point.

![[HDY1_003 Contact Kinematics 2025-12-02 15.22.32.excalidraw.svg]] ^fig-3-1
>Examples of distances between rigid bodies.

If positions and orientations of ${B}_{1},{B}_{2}$ are described by a generalized coordinates $\mathbf{q}\in \mathbb{R}^{N}$, then keeping contact can be described as a holonomic constraint ${d}_{21}(\mathbf{q})=0$. When ${d}_{21}(\mathbf{q})>0$, the two bodies are separated. If a moving body ${B}_{1}$ is in contact with bodies ${B}_{2},{B}_{3}$ then its motion must satisfy two holonomic constraints ${d}_{21}(\mathbf{q})=0$ and ${d}_{31}(\mathbf{q})=0$, so the number of DOFs of the bodies' motion reduces by $2$.

Constrained motion that maintains constant distance between bodies satisfies ${d}_{21}(\mathbf{q}(t))=c$. Let $\mathbf{r}_{1}(\mathbf{q}(t))\in {B}_{1}$ and $\mathbf{r}_{2}(\mathbf{q}(t))\in {B}_{2}$ be the two closest points on the two bodies, and define the unit normal vector
$$\mathbf{n}_{21}= \dfrac{\mathbf{r}_{2}-\mathbf{r}_{1}}{\lvert \mathbf{r}_{2}-\mathbf{r}_{1} \rvert }$$
so that $\mathbf{r}_{2}-\mathbf{r}_{1}={d}_{21}\mathbf{n}_{21}$. These points may be moving relative to the bodies, i.e., not be fixed material points (for non-smooth boundaries, they may be fixed material points located at vertices). The constant distance constraint can be written as 
$$(\mathbf{r}_{2}-\mathbf{r}_{1})\cdot(\mathbf{r}_{2}-\mathbf{r}_{1})=c^{2}$$
Time-differentiation gives
$$2(\dot{\mathbf{r}}_{2}-\dot{\mathbf{r}}_{1})(\mathbf{r}_{2}-\mathbf{r}_{1})=(\mathbf{v}_{2}-\mathbf{v}_{1})\cdot {d}_{21}\mathbf{n}_{21}=0$$
This holds also for the limiting case of contact ${d}_{21}=0$ and implies that the normal relative velocity at the contact points is zero for maintaining contact,
$$(\mathbf{v}_{2}-\mathbf{v}_{1})\cdot \mathbf{n}_{21}=0$$
In most cases, the contact is *unilateral*, so that for ${d}_{21}=0$, $(\mathbf{v}_{2}-\mathbf{v}_{1})\cdot \mathbf{n}_{21}>0$ implies contact separation, while $(\mathbf{v}_{2}-\mathbf{v}_{1})\cdot \mathbf{n}_{21}<0$ implies collision between the bodies (penetration). $(\mathbf{v}_{2}-\mathbf{v}_{1})\cdot \mathbf{n}_{21}=0$ means maintaining contact.

The fact that $(\mathbf{v}_{2}-\mathbf{v}_{1})\cdot \mathbf{n}_{21}=0$ does not necessarily imply that $\mathbf{v}_{2}=\mathbf{v}_{1}$. There can be relative motion in direction(s) *tangent* to the contacting surfaces and perpendicular to $\mathbf{n}_{21}$. Such motion is called **[[DYN1_004 קינמטיקה של מערכת גופים קשיחים#מפרקים - חיבורים בין גופים קשיחים|slippage]]**. For bodies in 2D, slippage is directed along $\mathbf{t}_{21}$ - a unit tangent direction to the boundary curves of the contacting bodies. For bodies in 3D, there is a tangent plane to the two-dimensional boundary surfaces, so that slippage can be directed along a two-dimensional plane.

**No-slip contact** or **pure rolling** is where $\mathbf{v}_{2}-\mathbf{v}_{1}=0$ is always satisfied. That is, the relative velocity between the two contacting material point is always zero. Mathematically, this is represented by one holonomic constraint of contact ${d}_{21}(\mathbf{q})=0$, combined with velocity constraints of the form $\mathbf{W}(\mathbf{q})\dot{\mathbf{q}}=\mathbf{v}_{2}-\mathbf{v}_{1}=0$. Note that this does not necessarily imply that the contact points $\mathbf{r}_{1},\mathbf{r}_{2}$ are fixed material points. Examples are sphere/wheel/disc rolling on flat plane in 2D and in 3D, spinning top with spherical or sharp tip.

> [!Question] Is the no-slip constraint integrable? That is, can it be replaced by a holonomic constraint?
> In order to answer this question, we need to consider and prove the following statement:
> In pure rolling motion, the trajectories that the contact points $\mathbf{r}_{1},\mathbf{r}_{2}$ make on the boundaries of the bodies ${B}_{1}$ and ${B}_{2}$ have *equal arc lengths*.
> 
> **Proof**:
> Consider two body-fixed reference frames, $\{ \mathbf{e}_{i}' \}$ attached to ${B}_{1}$ and $\{ \mathbf{e}_{i}'' \}$ attached to ${B}_{2}$. Let $\boldsymbol{\Omega}'$ and $\boldsymbol{\Omega}''$ denote angular velocity vectors of the two reference frames. Let $b',b''$ be body-fixed points on the bodies ${B}_{1},{B}_{2}$ that are instantaneously in contact at time $t={t}_{0}$. Let $p$ denote the location of the contact point, which moves on the boundaries of the bodies ${B}_{1},{B}_{2}$ and coincides with both $b'$ and $b''$ at time $t={t}_{0}$. We can calculate velocities $\mathbf{v}_{b},\mathbf{v}_{b''}$ using [[DYN1_002 קינמטיקה של חלקיק - מערכת צירים סובבת#כלל האופרטור|differential operator's rule]] as:
> $$\begin{aligned}
>  & \mathbf{v}_{b'}=\mathbf{v}_{o}'+\dfrac{\delta \mathbf{r}_{o'b'}}{\delta t}+\boldsymbol{\Omega}'\times \mathbf{r}_{o'b'} \\[1ex]
>  & \mathbf{v}_{b''}=\mathbf{v}_{o''}+\dfrac{\delta \mathbf{r}_{o''b''}}{\delta t}+\boldsymbol{\Omega}''\times \mathbf{r}_{o''b''}
> \end{aligned} \tag{3.1}$$
> since both $b'$ and $b''$ are body-fixed points, the frame derivative terms both vanish, that is $\dfrac{\delta \mathbf{r}_{o'b'}}{\delta t}=\dfrac{\delta \mathbf{r}_{o''b''}}{\delta t}=0$. At time $t={t}_{0}$, the relative velocity at contact point vanishes, giving:
> $$\mathbf{v}_{o}'+\boldsymbol{\Omega}'\times \mathbf{r}_{o'b'}=\mathbf{v}_{o''}+\boldsymbol{\Omega}''\times \mathbf{r}_{o''b''}\tag{3.2}$$
> 
> Velocity of the moving contact point $p$ can also be derived using differential operator's rule in $\{ \mathbf{e}_{i}' \}$ and $\{ \mathbf{e}_{i}'' \}$ as:
> $$\mathbf{v}_{p}=\mathbf{v}_{o'}+\dfrac{\delta \mathbf{r}_{o'p}}{\delta t}+\boldsymbol{\Omega}'\times \mathbf{r}_{o'p}=\mathbf{v}_{o''}+\dfrac{\delta \mathbf{r}_{o''p}}{\delta t}+\boldsymbol{\Omega}''\times \mathbf{r}_{o''p} \tag{3.3}$$
> At time $t={t}_{0}$ the points $p,b,b''$ coincide, so $\mathbf{r}_{o'p}=\mathbf{r}_{o'b'}$ and $\mathbf{r}_{o''p}=\mathbf{r}_{o''b''}$. Substituting this and $\text{(3.2)}$ into $\text{(3.3)}$ gives:
> $$\dfrac{\delta \mathbf{r}_{o'p}}{\delta t}\bigg|_{\{ \mathbf{e}_{i}' \}}^{} =\dfrac{\delta \mathbf{r}_{o''p}}{\delta t}\bigg|_{\{ \mathbf{e}_{i}'' \}}^{}\tag{3.4} $$
> 
> The equated terms in $\text{(3.4)}$ mean the velocities of the contact point $p$ as measured by observers attached to the two body-fixed frames $\{ \mathbf{e}_{i}' \}$ and $\{ \mathbf{e}_{i}'' \}$. This also means that the local tangents to the boundaries of ${B}_{1}$ and ${B}_{2}$ at the contact point are equal. Note that $\text{(3.4)}$ now holds for each time $t$. The arclengths of the two paths that $p$ travel on the boundaries of ${B}_{1}$ and ${B}_{2}$ are obtained as:
> $$s'=\int_{0}^{{t}_{f}} \left\lvert  \dfrac{\delta \mathbf{r}_{o'p}}{\delta t}  \right\rvert  \, \mathrm{d}t,\qquad s''=\int_{0}^{{t}_{f}} \left\lvert  \dfrac{\delta \mathbf{r}_{o''p}}{\delta t}  \right\rvert  \, \mathrm{d}t  $$
> From $\text{(3.4)}$ we conclude that:
> $$s'=s''$$
> $$\tag*{$\blacksquare$}$$
> 
> Note that the boundary of a 3D body is a two-dimensional surface, whereas the boundary of a 2D body is a one dimensional curve, that can be parametrized by its arclength $s$.
> 
> So, is the no-slip constraint integrable?
> - Well, in 2D motion, yes! The constraint $s'=s''+c$ can be written as $h(\mathbf{q})=0$. Together with the contact constraint, they reduce the number of DOF for the relative motion to $1$, $\dot{\mathbf{q}}=\mathbf{g}_{1}(\mathbf{q}){v}_{1}$ for rolling wheel/circle in 2D, $\mathbf{q}=\begin{pmatrix}x & y & \theta\end{pmatrix}^{T}$. Contact constraint is $y=R$, pure rolling constraint is $R\dot{\theta}=\dot{x}$, integration gives $x={x}_{0}+R\theta$. Motion has 1DOF, can be parametrized by $x$ or $\theta$. Examples: [wheel on ground](https://www.f-lohmueller.de/pov_tut/animate/anim131e.htm), [planetary gear](https://grabcad.com/library/planetary-epicyclic-gear-train-animated-1#!).
> - For smooth bodies in 3D no-slip constraints are **NOT** integrable. Examples: upright rolling disc on plane, rolling sphere, rolling ellipsoid.
> - For body with non-smooth boundary in contact with a smooth body, a *vertex point* of ${B}_{1}$ will keep contact with a *fixed* point on the smooth body ${B}_{2}$. In such case, rolling is integrable also for 3D motion. Example: Euler's spinning top.
> 

# Statics of Contact Forces and Friction
Consider two rigid bodies in 2D, having a point contact. We can (uniquely) define the unit vectors $\hat{\mathbf{n}},\hat{\mathbf{t}}$ of normal and tangent directions at the contact point. The contact force, which is an internal force acting at the contact, can be decomposed into normal and tangential components as $\mathbf{f}={f}_{n}\hat{\mathbf{n}}+{f}_{t}\hat{\mathbf{t}}$. For *unilateral contact*, only compression forces are allowed, ${f}_{n}>0$ (In contrast to tension/adhesion forces which can be realized in case of vacuum, magnetic force, grippers, or chemical adhesion, surface tension, etc.).

![[HDY1_003 Contact Kinematics 2025-12-02 17.07.37.excalidraw.svg]] ^fig-3-2
>Contact forces.

When the contact is subject to compression load in normal direction, the bodies undergo small elastic deformations. Assuming that the bodies have large but finite stiffness, these deformations are localized near the contact area, and one can still consider the nominal undeformed shape of the two bodies, with small local penetration in normal direction: ${d}_{21}=-{\delta}_{n}<0$.

![[HDY1_003 Contact Kinematics 2025-12-02 21.57.13.excalidraw.svg]] ^fig-3-3
> Contact forces with penetration.

For small deformations, the normal force ${f}_{n}$ depends monotonically on normal displacement ${\delta}_{n}$. Hertz theory of contact mechanics of smooth frictionless bodies such as cylinders and ellipsoids suggests a power law of ${f}_{n}\sim{{{\delta}_{n}}}^{1.5}$. This can be linearized for small deviations about an equilibrium point to a linear spring law ${f}_{n} = {k}_{n}({\delta}_{n}-\delta)$.

Now, suppose that after applying a normal loading force ${f}_{n}$ and reaching an equilibrium of normal displacement ${\delta}_{n}$, one begins to apply a loading force ${f}_{t}$ in tangential direction, causing a tangential displacement ${\delta}_{t}$. For small loads, the force-displacement may behave linearly as ${f}_{t}=-{k}_{t}{\delta}_{t}$ and the "normal penetration cavity" deforms asymmetrically until reaching a critical tangential force ${f}_{\text{cr}}$ where the normal cavity "fails" and the bodies transition from micro- to macro- motion of slippage. Both ${k}_{t}$ and critical tangential force ${f}_{\text{cr}}$ increases for larger initial normal penetration and force.

![[HDY1_003 Contact Kinematics 2025-12-02 17.18.43.excalidraw.svg]] ^fig-3-4
>Loading force in tangential direction.

In the limit of rigid bodies, the whole segment of micro-slip motion is lumped to zero, and one can also replace the tangential displacement ${\delta}_{t}$ with the velocity ${v}_{t}={\delta}_{t}$. The simplest model for the critical load force states that it is linearly proportional to the normal force, ${f}_{\text{cr}}=\mu {f}_{n}$. The constant $\mu$ is a material/surface property called *coefficient of dry friction*. This implies that $\lvert {f}_{t} \rvert\leq \mu {f}_{n}$, which is also known as [[DVI1_002 רטט חופשי של מערכת  בדרגת חופש אחת#ריסון קולון - חיכוך יבש|Coulomb friction]].

![[HDY1_003 Contact Kinematics 2025-12-02 22.02.41.excalidraw.svg]] ^fig-3-5
>Coulomb's friction law.

The graphic description of this friction law states that the direction of friction force $\mathbf{f}$ must be bounded within a cone called **friction cone**, centered about the contact normal $\hat{\mathbf{n}}$, with half-angle of 
$$\gamma=\tan^{-1}(\mu)$$
called **friction angle**. A simple experiment for determining friction coefficient - put the body on an inclined plane, gradually increase the slope until reaching a critical slope angle $\gamma$ where the body begins to slip. This is precisely $\gamma=\tan^{-1}(\mu)$.


![[HDY1_003 Contact Kinematics 2025-12-02 22.04.08.excalidraw.svg]] ^fig-3-6
>Friction cone, friction angle.

After macro-scale slip begins, the actual friction force ${f}_{t}$ may drop a bit below ${f}_{\text{cr}}$. This is sometimes represented by different coefficients of static and dynamic friction ${\mu}_{s}>{\mu}_{d}$, such that ${f}_{t}=-{\mu}_{d}\,\mathrm{sgn}({v}_{t}){f}_{t}$ for ${v}_{t}\neq 0$. To summarize, the *static* friction force in a unilateral contact can be formulated as:
$$\begin{cases}
{f}_{n}={f}_{t}=0 &  {v}_{t}>0 & \text{(contact separation)} \\[1ex]
{f}_{n}>0 & {v}_{n}=0 & \text{(contact)} \\[1ex]
\lvert {f}_{t} \rvert \leq  {\mu}_{s}{f}_{n} & {v}_{t}=0 & \text{(no-slip)} \\[1ex]
{f}_{t}=-\mathrm{sgn}({v}_{t}){\mu}_{d}{f}_{n} & {v}_{t}\neq 0 & \text{(slip)}
\end{cases} \tag{3.5}$$



![[HDY1_003 Contact Kinematics 2025-12-05 10.47.52.excalidraw.svg]] ^fig-3-7
>Static friction force of unilateral contact

For simplicity, in many cases one does not distinguish between static and dynamic friction and assumes that ${\mu}_{s}={\mu}_{d}=\mu$. For sufficiently slow motions, it is assumed the friction force is independent of the magnitude of the slip velocity ${v}_{t}\neq 0$. When the friction force is assumed to be affected by slip *velocity*, the simplest model is linear (viscous) damping, ${f}_{t}=-c{v}_{t}$. Combining the effects of static and dynamic dry friction with high-velocity viscous friction gives rise to **Stribeck's effect**, illustrated in the following figure:

![[HDY1_003 Contact Kinematics 2025-12-05 16.59.18.excalidraw.svg]] ^fig-3-8
>Viscous damping and Stribeck's effect.

## Extension of Coulomb's Friction to 3D
The tangent is now a 2D plane, perpendicular to $\hat{\mathbf{n}}$ and the contact force is written as $\mathbf{f}={f}_{n}\hat{\mathbf{n}}+{f}_{t}$, or $\mathbf{f}_{t}=\mathbf{f}-(\mathbf{f}\cdot\hat{\mathbf{n}})\hat{\mathbf{n}}$. Coulomb's inequality states that $\lVert \mathbf{f}_{t}  \rVert\leq \mu {f}_{n}$. In components $\sqrt{ {{{f}_{x}}}^{2}+{{f}_{y}}^{2} }\leq \mu {f}_{z}$. Graphically, the direction of $\mathbf{f}$ must lie within a quadratic "ice-cream cone".

![[HDY1_003 Contact Kinematics 2025-12-05 17.07.31.excalidraw.svg]] ^fig-3-9
>3D frictional contact.



Another effect that may exist in 3D frictional contact: If the contacting bodies slightly deform to a contact region of small circular patch, tangential forces may generate added resisting "torsional moment" ${\tau}_{n}$ about $\hat{\mathbf{n}}$. Since the radius of the contact patch grows monotonically with ${f}_{n}$, this **soft finger model** assumes that $\lvert {\tau}_{n} \rvert \leq {r}_{t}\mu {f}_{n}$, where ${r}_{t}$ is the torsional friction coefficient (represents "effective" radius of the contact patch).
