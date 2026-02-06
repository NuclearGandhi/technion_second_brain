---
aliases:
---
>[!notes] Note: 
 >For generalized coordinates, see [[DVI1_001 מושגי יסוד ומכניקת לגראנז'#דרגות חופש וקואורדינטות מוכללות|vibrations]].

# The Principle of Least Action

The most general formulation of the law governing the motion of mechanical systems is the **principle of least action**, also known as **Hamilton's principle**. According to this principle, every mechanical system is characterized by a definite function $\mathcal{L}({q}_{1},{q}_{2},\dots,{q}_{s},\dot{q}_{1},\dot{q}_{2},\dots,\dot{q}_{s},t)$, or briefly $\mathcal{L}(q,\dot{q},t)$, and the motion of the system is such that a certain condition is satisfied.

Suppose the system occupies positions defined by coordinates $q^{(1)}$ at time ${t}_{1}$ and $q^{(2)}$ at time ${t}_{2}$. The principle states that, among all possible paths connecting these two configurations, the system follows the one for which the integral
$$S=\int_{{t}_{1}}^{{t}_{2}} \mathcal{L}(q,\dot{q},t) \, \mathrm{d}t \tag{LL2.1}$$
takes a stationary (typically minimum) value. The function $\mathcal{L}$ is called the [[DVI1_001 מושגי יסוד ומכניקת לגראנז'#עיקרון המילטון המורחב|Lagrangian]] of the system, and the integral $\text{(LL2.1)}$ is called the **action**.

The fact that the Lagrangian depends only on $q$ and $\dot{q}$, but not on higher derivatives, reflects a fundamental property of mechanics: the state of a system is completely determined once the coordinates and velocities are specified.

Let us now derive the differential equations that determine the path which makes the action stationary. For simplicity, we first consider a system with only one degree of freedom, so that only one function $q(t)$ needs to be determined.

Let $q=q(t)$ be the function for which $S$ is stationary. Consider a neighboring path of the form
$$q(t)+\delta q(t)\tag{LL2.2}$$
where $\delta q(t)$ is a small perturbation, called the **variation** of $q(t)$. Since all paths must pass through the fixed endpoints, the variation must vanish at the boundaries:
$$\delta q({t}_{1})=\delta q({t}_{2})=0 \tag{LL2.3}$$

The change in the action when $q$ is replaced by $q+\delta q$ is
$$\int_{{t}_{1}}^{{t}_{2}} \mathcal{L}(q+\delta q,\dot{q}+\delta \dot{q},t) \, \mathrm{d}t-\int_{{t}_{1}}^{{t}_{2}} \mathcal{L}(q,\dot{q},t) \, \mathrm{d}t  $$

Expanding the integrand to first order in $\delta q$ and $\delta \dot{q}$ (using a Taylor expansion), we obtain the **first variation** of the action. The condition for a stationary value is that this first variation vanishes:
$$\delta S=\delta \int_{{t}_{1}}^{{t}_{2}} \mathcal{L}(q,\dot{q},t) \, \mathrm{d}t=0\tag{LL2.4} $$

Carrying out the variation explicitly:
$$\int_{{t}_{1}}^{{t}_{2}} \left( \dfrac{ \partial \mathcal{L} }{ \partial q } \delta q+\dfrac{ \partial \mathcal{L} }{ \partial \dot{q} } \delta \dot{q} \right) \, \mathrm{d}t =0$$

Since $\delta \dot{q}=\mathrm{d}(\delta q)/\mathrm{d}t$, we can integrate the second term by parts. Recall that integration by parts gives $\int u\,\mathrm{d}v = uv - \int v\,\mathrm{d}u$. Taking $u = \partial\mathcal{L}/\partial\dot{q}$ and $\mathrm{d}v = \delta\dot{q}\,\mathrm{d}t = \mathrm{d}(\delta q)$:

$$\int_{{t}_{1}}^{{t}_{2}} \dfrac{ \partial \mathcal{L} }{ \partial \dot{q} } \delta \dot{q} \, \mathrm{d}t = \left[ \dfrac{ \partial \mathcal{L} }{ \partial \dot{q} } \delta q \right]^{{t}_{2}}_{{t}_{1}} - \int_{{t}_{1}}^{{t}_{2}} \dfrac{\mathrm{d}}{\mathrm{d}t}\left(\dfrac{ \partial \mathcal{L} }{ \partial \dot{q} }\right) \delta q \, \mathrm{d}t$$

Substituting this back, we obtain:
$$\delta S=\left[ \dfrac{ \partial \mathcal{L} }{ \partial \dot{q} } \delta q \right]^{{t}_{2}}_{{t}_{1}}+\int_{{t}_{1}}^{{t}_{2}} \left( \dfrac{ \partial \mathcal{L} }{ \partial q } -\dfrac{\mathrm{d}}{\mathrm{d}t}\dfrac{ \partial \mathcal{L} }{ \partial \dot{q} }  \right)\delta q \, \mathrm{d}t=0\tag{LL2.5} $$

The boundary conditions $\text{(LL2.3)}$ ensure that the bracketed term vanishes. What remains is an integral that must be zero for *arbitrary* variations $\delta q$. By the fundamental lemma of calculus of variations, this is possible only if the integrand itself is identically zero:
$$\dfrac{\mathrm{d}}{\mathrm{d}t}\left( \dfrac{ \partial \mathcal{L} }{ \partial \dot{q} }  \right)-\dfrac{ \partial \mathcal{L} }{ \partial q } =0$$
When the system has more than one degree of freedom, we have $s$ independent coordinates ${q}_{i}(t)$. Applying the variational principle, each coordinate can be varied independently while holding the others fixed. This yields $s$ separate equations:
$$\begin{aligned}
\dfrac{\mathrm{d}}{\mathrm{d}t}\left( \dfrac{ \partial \mathcal{L} }{ \partial \dot{q}_{i} }  \right)-\dfrac{ \partial \mathcal{L} }{ \partial {q}_{i} } =0 &  & (i=1,2,\dots ,s)
\end{aligned} \tag{LL2.6}$$
These are [[DVI1_001 מושגי יסוד ומכניקת לגראנז'#משוואות אויילר-לגראנז'|Lagrange's equations]], the fundamental equations of motion in the Lagrangian formulation. Given the Lagrangian of a mechanical system, equations $\text{(LL2.6)}$ provide the relationships between accelerations, velocities, and coordinates.

Mathematically, equations $\text{(LL2.6)}$ form a system of $s$ second-order ordinary differential equations for the $s$ unknown functions ${q}_{i}(t)$. The general solution therefore contains $2s$ arbitrary constants, which are determined by specifying initial conditions - typically the values of all coordinates and velocities at some initial time.

## Additivity of the Lagrangian

Consider a mechanical system consisting of two parts $A$ and $B$. A **closed** (or **isolated**) system is one that does not interact with any external bodies. If each part were isolated, it would have its own Lagrangian, ${\mathcal{L}}_{A}$ and ${\mathcal{L}}_{B}$ respectively. When the two parts are separated by a distance so large that their mutual interaction becomes negligible, the Lagrangian of the combined system approaches:
$$\lim\mathcal{L}=\mathcal{L}_{A}+\mathcal{L}_{B}\tag{LL2.7}$$

This **additivity property** reflects a fundamental physical requirement: the equations of motion for non-interacting subsystems must be independent of each other. Quantities describing part $A$ should not appear in the equations for part $B$, and vice versa.

Note that multiplying a Lagrangian by an arbitrary constant does not change the equations of motion. One might therefore think that the Lagrangians of different isolated systems could be scaled by different constants. However, the additivity property eliminates this freedom - all Lagrangians must be scaled by the same constant for the combined system to have a well-defined Lagrangian. This residual freedom simply corresponds to choosing the units in which the Lagrangian is measured.

## Gauge Freedom of the Lagrangian

There is an important ambiguity in the definition of the Lagrangian. Consider two Lagrangians $\mathcal{L}'(q,\dot{q},t)$ and $\mathcal{L}(q,\dot{q},t)$ that differ by the total time derivative of some function $f(q,t)$:
$$\mathcal{L}'(q,\dot{q},t)=\mathcal{L}(q,\dot{q},t)+\dfrac{\mathrm{d}}{\mathrm{d}t}f(q,t)\tag{LL2.8}$$

The corresponding actions are related by:
$$\small\begin{aligned}
S' & =\int_{{t}_{1}}^{{t}_{2}} \mathcal{L}'(q,\dot{q},t) \, \mathrm{d}t =\int_{{t}_{1}}^{{t}_{2}} \mathcal{L}(q,\dot{q},t) \, \mathrm{d}t+\int_{{t}_{1}}^{{t}_{2}} \dfrac{\mathrm{d}f}{\mathrm{d}t} \, \mathrm{d}t=S+f(q^{(2)},{t}_{2})-f(q^{(1)},{t}_{1})  
\end{aligned}$$

The two actions differ only by boundary terms that depend on the fixed endpoints. Since these terms are constants (not functions of the path), they contribute nothing to the variation: $\delta S' = \delta S$. Therefore, both Lagrangians yield identical equations of motion.

This means the Lagrangian is not unique - it is defined only up to an additive total time derivative of any function of coordinates and time.

>[!example] Example: Equivalent Lagrangians
>Consider a free particle in one dimension with the standard Lagrangian:
>$$\mathcal{L} = \dfrac{1}{2}m\dot{x}^2$$
>
>Adding the total derivative of $f(x,t) = mx$ gives:
>$$\mathcal{L}' = \dfrac{1}{2}m\dot{x}^2 + m\dot{x} = \dfrac{1}{2}m\dot{x}^2 + m\dot{x}$$
>
>Both Lagrangians produce the same equation of motion: $m\ddot{x} = 0$.

>[!tip] Practical Use
>This gauge freedom is useful for simplifying problems. If a Lagrangian contains awkward terms that can be written as total time derivatives, they can be dropped without affecting the physics. This is particularly helpful when transforming between coordinate systems or when deriving conservation laws.

>[!notes] Note: 
 >1. For Galileo's relativity principle, see [[PHY1_004 תנועה הרמונית ומערכות ייחוס#טרנספורמציית גלילאו|Galilean transformation]].
 >2. For the Lagrangian of a free particle and a system of particles, see [[DVI1_001 מושגי יסוד ומכניקת לגראנז'#משוואות אויילר-לגראנז'|vibrations]].
