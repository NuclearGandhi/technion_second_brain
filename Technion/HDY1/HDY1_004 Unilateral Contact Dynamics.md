---
aliases:
---
# Dynamics with a Single Unilateral Frictionless Contact
Consider a mechanical system of rigid bodies (robot / mechanism with links and joint) subject to a single unilateral contact constraint. The system's **unconstrained** (redundant) coordinates are $\mathbf{q}\in \mathbb{R}^{N}$ and the contact is represented by a unilateral inequality of distance ${d}_{21}(\mathbf{q})\geq 0$, where ${d}_{21}(\mathbf{q})=\lVert \mathbf{r}_{2}(\mathbf{q})-\mathbf{r}_{1}(\mathbf{q}) \rVert$ is the distance between two closest points on the system's two rigid bodies / links.

When the system moves while keeping persistent contact ${d}_{21}(\mathbf{q}(t))=0$, this gives dynamic equations with a holonomic constraint:
$$\mathbf{M}(\mathbf{q})\ddot{\mathbf{q}}+\mathbf{B}(\mathbf{q},\dot{\mathbf{q}})+\mathbf{G}(\mathbf{q})=\mathbf{F}_{q}+\mathbf{W}^{T}(\mathbf{q})\lambda\tag{4.1}$$
Where
$$\mathbf{W}(\mathbf{q})=\dfrac{\mathrm{d}}{\mathrm{d}\mathbf{q}}({d}_{21})$$
We now prove that the physical meaning of $\lambda$ is the normal (compression) force acting at the contact. Recall that the distance ${d}_{21}$ is attained along the common normal direction $\hat{\mathbf{n}}(\mathbf{q})$ to the two contacting surfaces. Therefore, one can rewrite ${d}_{21}(\mathbf{q})=[\mathbf{r}_{2}(\mathbf{q})-\mathbf{r}_{1}(\mathbf{q})]\cdot\hat{\mathbf{n}}(\mathbf{q})=\hat{\mathbf{n}}^{T}\mathbf{r}_{21}$. Therefore, the gradient $\mathbf{W}$ is:
$$\mathbf{W}(\mathbf{q})=\dfrac{\mathrm{d}}{\mathrm{d}\mathbf{q}}({d}_{21})=\hat{\mathbf{n}}^{T}\left( \dfrac{\mathrm{d}}{\mathrm{d}\mathbf{q}}\mathbf{r}_{21} \right)+\left( \dfrac{\mathrm{d}\hat{\mathbf{n}}}{\mathrm{d}\mathbf{q}} \right)^{T}\mathbf{r}_{21}$$

The second term is identically zero. To see why, note that since $\hat{\mathbf{n}}$ is a unit vector, $\hat{\mathbf{n}}\cdot\hat{\mathbf{n}}=1$. Differentiating with respect to ${q}_{i}$ gives $2 \dfrac{\partial\hat{\mathbf{n}}}{\partial{q}_{i}}\cdot\hat{\mathbf{n}}=0$, meaning the derivative of a unit vector is always perpendicular to itself. Now, since the distance ${d}_{21}$ is measured along the normal direction, we have $\mathbf{r}_{21}={d}_{21}\hat{\mathbf{n}}$. Therefore, the $i$-th element of $\left( \dfrac{\mathrm{d}\hat{\mathbf{n}}}{\mathrm{d}\mathbf{q}} \right)^{T}\mathbf{r}_{21}$ is:
$$\dfrac{\partial\hat{\mathbf{n}}}{\partial{q}_{i}}\cdot\mathbf{r}_{21}={d}_{21}\left( \dfrac{\partial\hat{\mathbf{n}}}{\partial{q}_{i}}\cdot\hat{\mathbf{n}} \right)=0$$

Therefore, the generalized force associated with the constraint is $\mathbf{W}^{T}(\mathbf{q})\lambda=\left( \dfrac{\mathrm{d}}{\mathrm{d}\mathbf{q}}\mathbf{r}_{21} \right)^{T}(\lambda\hat{\mathbf{n}})$. This highlights the physical meaning of $\lambda$ - magnitude of the normal force acting at the contact point. The values of $\lambda$ can be found by differentiating the velocity-constraint $\dot{d}(t)=\mathbf{W}(\mathbf{q})\dot{\mathbf{q}}=0$ in time to obtain $\ddot{d}(t)=\dot{\mathbf{W}}\dot{\mathbf{q}}+\mathbf{W}\ddot{\mathbf{q}}=0$ and substituting into $\text{(4.1)}$ to obtain:

$$\lambda(\mathbf{q},\dot{\mathbf{q}},t)=(\mathbf{W}\mathbf{M}^{-1}\mathbf{W}^{T})^{-1}(\mathbf{W}\mathbf{M}^{-1}(\mathbf{B}+\mathbf{G}-\mathbf{F}_{q})-\dot{\mathbf{W}}\dot{\mathbf{q}})\tag{4.2}$$

In the case of a *unilateral* contact, the normal force must be non-negative $\lambda\geq 0$. We will explore what happens when the system's motion $\mathbf{q}(t)$ reaches a time ${t}_{s}$ such that
$$\lambda({t}_{s})=0\qquad \text{and}\quad \dot{\lambda}({t}_{s})<0\tag{4.3}$$
The contact state changes to *separation* - unconstrained motion. The equations of motion for $t\geq {t}_{s}$ are the same as $(4.1)$, but with $\lambda=0$. That is, the constraint ${d}_{21}(\mathbf{q})=0$ is no longer enforced. Choosing a state vector $\mathbf{x}=(\mathbf{q},\dot{\mathbf{q}})$, the state equation of the system's dynamics now takes a piecwise-defined form:
$$\dot{\mathbf{x}}=\tiny\begin{pmatrix}
\dot{\mathbf{q}} \\
\ddot{\mathbf{q}}
\end{pmatrix}=\begin{cases}
\mathbf{f}_{1}(\mathbf{x},t) & d(\mathbf{q})=0 & \text{and} & \dot{d}(\mathbf{q},\dot{\mathbf{q}})=0 & \text{and} & \lambda(\mathbf{q},\dot{\mathbf{q}})>0 & \text{(contact)} \\
\mathbf{f}_{2}(\mathbf{x},t) & \text{otherwise} &  & &  &  & \text{(separation)}
\end{cases}\tag{4.4}$$
>[!Question] Does equation $\text{(4.3)}$ completely describe the system's dynamic behavior?
>No! Although this equation can describe the transition from contact to separation, it does not describe the transition from separation to contact. In the transition from separation to contact may, and probably will, include *impact*, which will actually jump us to a different place in the state space. That is **hybrid dynamics**. At the time ${t}_{c}$ of this transition we have $d({t}_{c})=0,\,\dot{d}({t}_{c})<0$. In order to avoid inter-penetration between rigid bodies there must be a jump in $\dot{\mathbf{q}}$ in order to enforce $\dot{d}(t^{+}_{c})\geq 0$ in order to prevent rigid-body penetration (Rigid-body impacts will be covered later). The system's behavior can be best described by a graph of state transitions:
>![[HDY1_004 Unilateral Contact Dynamics 2025-12-24 22.52.12.excalidraw.svg]]^figure-state-transition-graph
>>State transition graph.


>[!Question] Is the state transition "contact to separation" at $t={t}_{s}$ well defined?  
>That is, for times $t\leq {t}_{s}$, does the solution satisfy $d(\mathbf{q}(t))\geq 0$? Is it possible that penetration occurs, i.e. $d(\mathbf{q}(t^{+}_{s}))<0$?
>Right before separation ($t=t^{-}_{s}$), we have $d=\dot{d}=\ddot{d}=0$. We know that $\lambda(t)$ changes continuously at time ${t}_{s}$, so that $\lambda(t^{-}_{s})=\lambda(t^{+}_{s})=0$. But $\dot{\lambda}$ jumps such that $\dot{\lambda}(t^{-}_{s})<0$ and $\dot{\lambda}(t^{+}_{s})=0$. From $\text{(4.1)}$, this implies that $\mathbf{q},\dot{\mathbf{q}},\ddot{\mathbf{q}}$ also changes continuously at ${t}_{s}$, so that $d(t^{+}_{s})=\dot{d}(t^{+}_{s})=\ddot{d}(t^+_{s})=0$. But what about the third order, $\dddot{d}(t^{+}_{s})$?
>
>Since the inertia matrix $\mathbf{M}$ is positive (semi-) definite, we know that $\mathbf{W}\mathbf{M}^{-1}\mathbf{W}^{T}\geq 0$. Defining $A(\mathbf{q},\dot{\mathbf{q}}):=\mathbf{W}\mathbf{M}^{-1}(\mathbf{B}+\mathbf{G}-\mathbf{F}_{q})-\dot{\mathbf{W}}\dot{\mathbf{q}}$,  from $\text{(4.2)}$ and $\text{(4.3)}$ we obtain that $A(t^{+}_{s})=0$ and $\dot{A}(t^{+}_{s})<0$. Time-derivatives of the distance $d(t)$ are obtained at $\dot{d}(t)=\mathbf{W}(\mathbf{q},\dot{\mathbf{q}})$ and $\ddot{d}(t)=\dot{\mathbf{W}}\dot{\mathbf{q}}+\mathbf{W} \ddot{\mathbf{q}}$. During separation for $t>{t}_{s}$ one can substitute $\lambda=0$ into $\text{(4.2)}$ to obtain $\ddot{\mathbf{q}}=\mathbf{M}^{-1}(\mathbf{F}_{q}-\mathbf{B}-\mathbf{G})$. This precisely gives that $\ddot{d}(t)=-A(t)$. Therefore, one obtains that $\dddot{d}(t^{+}_{s})=-\dot{A}(t^{+}_{s})>0$, so that separation indeed continues.
>
>**Answer**: The state transition "contact to separation" at $t={t}_{s}$ is well defined.


# Dynamics with a No-Slip Contact (with unbounded/sufficiently large friction)

The system's unconstrained coordinates $\mathbf{q}\in \mathbb{R}^{N}$. The contact is represented by a unilateral inequality of distance $d(\mathbf{q})\geq 0$, in normal direction, which gives a velocity constraint $\dot{d}=\mathbf{w}_{n}\dot{\mathbf{q}}=0$ where $\mathbf{w}_{n}=\dfrac{\mathrm{d}}{\mathrm{d}\mathbf{q}}d(\mathbf{q})$. The no-slip conditions are imposed by velocity constraint(s) of the form $\mathbf{v}_{t}=\mathbf{W}_{t}(\mathbf{q})\dot{\mathbf{q}}=0$. One can compose $\mathbf{W}=\begin{pmatrix}\mathbf{W}_{t} & \mathbf{w}_{n}\end{pmatrix}^{T}$ so that all velocity constraints are joined as $\mathbf{W}(\mathbf{q})\dot{\mathbf{q}}=0$. In the case of 2D motion, ${v}_{t}$ is scalar and $\mathbf{W}_{t}$ is a row vector, and the no-slip constraint is integrable.

>[!example] Example: Wheel on ground in 2D
> Given below is a simple case of a wheel rolling on the ground with a no-slip constraint:
> 
>![[HDY1_004 Unilateral Contact Dynamics 2025-12-26 16.32.02.excalidraw.svg]]^figure-wheel-on-ground-2D
>> Wheel on ground in 2D.
> 
> 
> Defining our coordinates as $\mathbf{q}=(x,y,\theta)^{T}$, our holonomic constraint is $d(\mathbf{q})=y-R=0$. The holonomic $\mathbf{w}_{n}$ is a row vector:
> $$\begin{aligned}
> \mathbf{w}_{n} & =\dfrac{\mathrm{d}}{\mathrm{d}\mathbf{q}}d(\mathbf{q}) \\[1ex]
>  & =\begin{pmatrix}
> 0 & 1 & 0
> \end{pmatrix}
> \end{aligned}$$
> The absolute velocity of the point contact is:
> $$\begin{aligned}
> \mathbf{v}_{P} & =\mathbf{v}_{c}+\boldsymbol{\omega}\times \mathbf{r}_{Pc} \\[1ex]
>  & =\dot{x}\mathbf{e}_{1}+\dot{y}\mathbf{e}_{2}+(\dot{\theta}\mathbf{e}_{3})\times(-R\mathbf{e}_{2}) \\[1ex]
>  & =(\dot{x}+R\dot{\theta})\mathbf{e}_{1}+\dot{y}\mathbf{e}_{2} \\[1ex]
>  & ={v}_{t}\mathbf{e}_{t}+{v}_{n}\mathbf{e}_{n}
> \end{aligned}$$
> The non-holonomic constraint as a result of the no-slip constraint is:
> $$\begin{gathered}
> {v}_{t}=0 \\[1ex]
> (\dot{x}+R\dot{\theta})=0 \\[1ex]
> \begin{pmatrix}
> 1 & 0 & R
> \end{pmatrix}\dot{\mathbf{q}}=0 \\[1ex]
> \mathbf{W}_{t}\dot{\mathbf{q}}=0
> \end{gathered}$$
> Therefore:
> $$\mathbf{W}(\mathbf{q})=\begin{pmatrix}
> 1 & 0 & R \\
> 0 & 1 & 0
> \end{pmatrix}$$

We know we can write the equations of motion in the form of [[HDY1_002 Constrained Lagrangian Mechanics|equation]] $\text{(2.12)}$:
$$\mathbf{M}(\mathbf{q})\ddot{\mathbf{q}}+\mathbf{B}(\mathbf{q},\dot{\mathbf{q}})+\mathbf{G}(\mathbf{q})=\mathbf{F}_{q}+\mathbf{W}^{T}(\mathbf{q})\boldsymbol{\lambda}$$
When the system moves while keeping persistent no-slip contact, the constraint dynamic equations are:
$$\mathbf{M}(\mathbf{q})\ddot{\mathbf{q}}+\mathbf{B}(\mathbf{q},\dot{\mathbf{q}})+\mathbf{G}(\mathbf{q})=\mathbf{F}_{q}+{{\mathbf{w}_{t}}}^{T}(\mathbf{q})\boldsymbol{\lambda}_{t}+{{\mathbf{w}_{n}}}^{T}{\lambda}_{n} \tag{4.5}$$
The constraint force vector is composed as $\boldsymbol{\lambda}=\begin{pmatrix}\boldsymbol{\lambda}_{t}&{\lambda}_{n}\end{pmatrix}^{T}$. In case of 2D motion, ${\lambda}_{t}$ is also a scalar. Expression for the vector of constraint forces $\boldsymbol{\lambda}(\mathbf{q},\dot{\mathbf{q}})$ can be extracted as in equation $\text{(4.2)}$ above. For *unilateral* contact, the normal force must satisfy ${\lambda}_{n}\geq 0$. When this constraint is violated, one expects a state transition to separation state. If there is bounded friction, Coulomb's law imposes the additional constraint $\lVert \boldsymbol{\lambda}_{t} \rVert\leq \mu{\lambda}_{n}$ in 3D or $\lvert {\lambda}_{t} \rvert\leq \mu{\lambda}_{n}$ in 2D. When this constraint is violated, the contact begins to **slip**, and this transition generally occurs *before* separation. The reason is that as ${\lambda}_{n}$ decreases toward zero, the friction cone $\lvert {\lambda}_{t} \rvert\leq \mu{\lambda}_{n}$ shrinks. Unless ${\lambda}_{t}$ also decreases at least as fast, which is not generally the case, the friction bound will be exceeded while ${\lambda}_{n}>0$, triggering slippage before separation can occur.

It is sometimes tempting to assume "ideal no-slip contact", without any transition to slippage, just to separation. This is equivalent to assuming "infinite friction", so that slippage is ignored, assuming that crossing ${\lambda}_{n}=0$ leads directly to separation. The problem is that *this does not always work*, as demonstrated in the following example.

## The Falling Pencil Problem

Based on "Wobbling, toppling, and forces of contact"^[McGeer, T., & Palmer, L. H. (1989). Wobbling, toppling, and forces of contact. *American Journal of Physics*, 57(12), 1089–1098.].

The figure below shows a slender rod having mass $m$, length $2\ell$ and moment of inertia ${I}_{c}$ with respect to its center-of-mass $c$ which is located at its midpoint (mass distribution is symmetric about $c$ but not necessarily uniform). The rod stands under gravity and its lower endpoint makes a *no-slip* contact with a *rough* surface.

![[HDY1_004 Unilateral Contact Dynamics 2025-12-26 16.53.12.excalidraw.svg]]^figure-falling-pencil-system
>Falling pencil system.

At the initial time, the rod is in upright (unstable) position $\theta(0)=0$ and is given a small initial angular velocity $\dot{\theta}(0)={\omega}_{0}>0$. Assuming no-slip contact, we wish to find conditions guaranteeing that the rod reaches a state where the normal contact force vanishes, and to find the contact's normal acceleration at that state in order to make sure that separation indeed occurs. That is, check that the state transition contact to separation is well defined.

First, we choose the vector of generalized coordinates $\mathbf{q}=(x,y,\theta)$ where $x,y$ are positions of the rod's lower endpoint, which are constrained to satisfy the holonomic constraints $x=y=0$. Thus, the velocity constraints are:
$$\begin{gathered}
\dot{x} =\begin{pmatrix}
1 & 0 & 0
\end{pmatrix}\dot{\mathbf{q}} \\[1ex]
0=\mathbf{w}_{t}\dot{\mathbf{q}}
\end{gathered}$$
and:
$$\begin{gathered}
\dot{y}=\begin{pmatrix}
0 & 1 & 0
\end{pmatrix}\dot{\mathbf{q}} \\[1ex]
0=\mathbf{w}_{n}\dot{\mathbf{q}}
\end{gathered}$$
Next, we derive the constrained dynamic equations by formulating the kinetic and potential energies under constraint-free motion (even though the constrained motion has 1-DOF).

Center-of-mass position and velocity vector:
$$\begin{aligned}
 & \mathbf{r}_{c}=(x-\ell \sin\theta)\mathbf{e}_{1}+(y+\ell \cos\theta)\mathbf{e}_{2} \\[1ex]
 & \mathbf{v}_{c}=(\dot{x}-\ell\dot{\theta}\cos\theta)\mathbf{e}_{1}+(\dot{y}-\ell\dot{\theta}\sin\theta)\mathbf{e}_{2}
\end{aligned}$$

The energies:
$$\begin{aligned}
T & =\dfrac{1}{2}(m\mathbf{v}_{c}\cdot \mathbf{v}_{c}+{I}_{c}\omega ^{2}) \\[1ex]
 & =\dfrac{1}{2}m\left[\dot{x}^{2}+\dot{y}^{2}+\ell ^{2}\dot{\theta}^{2}-2\ell\dot{\theta}(\dot{x}\cos\theta+\dot{y}\sin\theta)\right]+\dfrac{1}{2}{I}_{c}\dot{\theta}^{2} \\[3ex]
V & =mg\mathbf{r}_{c}\cdot \mathbf{e}_{2} \\[1ex]
 & =mg(y+\ell \cos\theta)
\end{aligned}$$

From this, we obtain Lagrange's equations of constrained motion (equation $\text{(4.5)}$):
$$\mathbf{M}(\mathbf{q})\ddot{\mathbf{q}}+\mathbf{B}(\mathbf{q},\dot{\mathbf{q}})+\mathbf{G}(\mathbf{q})=\mathbf{F}_{q}+{{\mathbf{w}_{t}}}^{T}(\mathbf{q})\boldsymbol{\lambda}_{t}+{{\mathbf{w}_{n}}}^{T}{\lambda}_{n} \tag{4.6}$$
where:
$$\begin{aligned}
\mathbf{M} & =\begin{pmatrix}
m & 0 & -m\ell \cos\theta \\
0 & m & -m\ell \sin\theta \\
-m\ell \cos \theta & -m\ell \sin\theta & {I}_{c}+m\ell ^{2}
\end{pmatrix} \\[1ex]
\mathbf{B} & =\begin{pmatrix}
m\ell\dot{\theta}^{2}\sin\theta \\
-m\ell\dot{\theta}^{2}\cos\theta \\
0
\end{pmatrix} \\[1ex]
 \mathbf{G} & =\begin{pmatrix}
0 \\
mg \\
-mg\ell \sin\theta
\end{pmatrix}
\end{aligned}$$

Substituting the time-derivates of the constraints $\ddot{x}=\ddot{y}=0$ into the 3rd row of $\text{(4.6)}$ gives an equation which does not contain the constraint forces. In fact, this is an inverted pendulum equation:
$$({I}_{c}+m\ell ^{2})\ddot{\theta}-mg\ell \sin\theta=0\tag{4.7}$$
Substituting the time-derivates of the constraints $\ddot{x}=\ddot{y}=0$ into the second row of the $\text{(4.6)}$ gives an expression for the normal contact force:
$${\lambda}_{n}(\theta,\dot{\theta},\ddot{\theta})=-m\ell \ddot{\theta}\sin\theta-m\ell\dot{\theta}^{2}\cos\theta+mg\tag{4.8}$$
We now isolate the acceleration $\ddot{\theta}$ from $\text{(4.7)}$ and substitute into $\text{(4.8)}$ to obtain:
$${\lambda}_{n}(\theta ,\dot{\theta})=mg-\dfrac{m^{2}\ell ^{2}}{{I}_{c}+m\ell ^{2}}g\sin ^{2}\theta-m\ell\dot{\theta}^{2}\cos\theta \tag{4.9}$$
Multiplying $\text{(4.7)}$ by $\dot{\theta}$ we obtain:
$$({I}_{c}+m\ell ^{2})\ddot{\theta}\dot{\theta}-mg\ell\dot{\theta}\sin\theta=\dfrac{\mathrm{d}}{\mathrm{d}t}\left[ \dfrac{1}{2}({I}_{c}+m\ell ^{2})\dot{\theta}^{2}+mg\ell \cos\theta \right]=0$$

This is precisely the conservation of total mechanical energy $\dot{T}+\dot{V}=0$ for an inverted pendulum with fixed hinge, so that $T+V=\text{const}$. Substituting the initial potential and kinetic energies we obtain
$$\begin{gather}
T+V ={T}_{0}+{V}_{0} \\[1ex]
\dfrac{1}{2}({I}_{c}+m\ell ^{2})\dot{\theta}^{2}+mg\ell \cos\theta=\dfrac{1}{2}({I}_{c}+m\ell ^{2}){{{\omega}_{0}}}^{2}+mg\ell \tag{4.10}
\end{gather}$$

From $\text{(4.10)}$, we can isolate $\dot{\theta}^{2}$ and substitute into $\text{(4.9)}$ to obtain an expression for ${\lambda}_{n}$ as a function of $\theta$ only:
$${\lambda}_{n}(\theta)=mg\left[ 1-\dfrac{m\ell ^{2}}{{I}_{c}+m\ell ^{2}}[\sin ^{2}\theta+2\cos\theta(1-\cos\theta)] \right]-m\ell{{{\omega}_{0}}}^{2}\cos\theta\tag{4.11}$$
At the initial time we have from $\text{(4.11)}$ that ${\lambda}_{n}(0)=mg-m\ell{{{\omega}_{0}}}^{2}$, so we require that ${{{\omega}_{0}}}^{2}<g/\ell$ in order to ensure initial contact, ${\lambda}_{n}(0)>0$. In order to guarantee that contact separation (${\lambda}_{n}=0$) is reached during motion, it is sufficient to consider the limit case where ${\omega}_{0}\to 0^{+}$ is negligible, since increasing will further decrease ${\lambda}_{n}$. Therefore, $\text{(4.11)}$ gives:
$${\lambda}_{n}(\theta)=mg[1-\alpha F(\theta)]\tag{4.12}$$
where $\alpha=\dfrac{m\ell ^{2}}{{I}_{c}+m\ell ^{2}}$ and
$$F(\theta)=\sin ^{2}\theta+2\cos\theta(1-\cos\theta)$$

Note that the nondimensional mass distribution parameter $\alpha$ lies within the range $0.5\leq\alpha\leq 1$. Three example cases are:
- Point mass concentrated at the rod's center - ${I}_{c}=0,\,\alpha=1$.
- Uniform mass distribution - ${I}_{c}=m\ell ^{2}/3,\,\alpha=3/4$.
- Symmetric point masses at the rod's ends - ${I}_{c}=m\ell ^{2},\,\alpha=1/2$.

Substituting $z=\cos\theta$, the function $F$ from $\text{(4.12)}$ becomes $F(\theta)=1+2z-3z^{2},\,z\in[0,1]$, and it is easy to prove that $F(\theta)$ attains maximal value of $4/3$ for $\theta=\cos^{-1}(1/3)=70.5^{\circ}$, i.e. $z=1/3$.

Thus, from $\text{(4.12)}$ we find that for $\alpha\geq 3/4$, there exists a value $\theta={\theta}_{s}\in(0,\pi /2)$ for which contact separation is attained, ${\lambda}_{n}({\theta}_{s})=0$. The physical meaning of $\alpha\geq 3/4$ is that the rod's mass is more "centered" than uniformly distributed. For example, a sharp-double-ended pencil.

In fact, if we increase initial velocity ${\omega}_{0}$, we can reach contact separation at any desired value of $\theta$. We denote the contact separation time by ${t}_{s}$, so that $\theta({t}_{s})={\theta}_{s}$. After that time, $t\geq t^{+}_{s}$, the rod is supposed to begin contact-free flight motion, 3-DOF. This motion satisfies the same equation of unconstrained motion $\text{(4.6)}$ with zero contact forces ${\lambda}_{t}={\lambda}_{n}=0$. We now calculate the normal acceleration of the rod's end, $\ddot{y}(t^{+}_{s})$. From $\text{(4.6)}$ with zero contact forces, one obtains $\ddot{\mathbf{q}}=-\mathbf{M}^{-1}(\mathbf{B}+\mathbf{G})$. Substituting the expressions of $\mathbf{M},\mathbf{B},\mathbf{G}$ in $\text{(4.6)}$ one obtains:
$$\ddot{y}(t^{+}_{s})=\ell\dot{\theta}^{2}({t}_{s})\cos{\theta}_{s}-g\tag{4.13}$$
Note that unlike the case of frictionless contact, the accelerations $\ddot{\mathbf{q}}$ change discontinuously at separation since the tangential force ${\lambda}_{t}$ jumps to zero at $t={t}_{s}$. However, the velocity $\dot{\theta}$ changes continuously at ${t}_{s}$ and we can substitute the relation $\text{(4.10)}$ which holds also at $t={t}_{s}$ (assuming ${\omega}_{0} \to 0$) into $\text{(4.13)}$ to obtain an expression that depends on ${\theta}_{s}$ only:
$$\ddot{y}(t^{+}_{s})=g[2\alpha \cos{\theta}_{s}(1-\cos{\theta}_{s})-1]\tag{4.14}$$
It can be proven that $\ddot{y}(t^{+}_{s})<0$ holds for any ${\theta}_{s}(0,\pi /2)$ and $\alpha \in(1/2,1)$ (substitute $z=\cos{\theta}_{s}$). This gives a **paradox**: the constrained equations imply that no-slip contact is impossible at $t>{t}_{s}$ since ${\lambda}_{n}({t}_{s})=0$ and $\dot{\lambda}_{n}(t^{-}_{s})<0$, but the unconstrained equations of contact-free flight imply that separation is impossible since $\ddot{y}(t^{+}_{s})<0$, in contradiction to non-penetration of rigid bodies. That is, the contact to separation transition is ill-defined!

The obvious way to resolve this paradox is to consider a **finite** coefficient of friction, and transition to *slippage* when the constraint $\lvert {\lambda}_{t} \rvert\leq \mu {\lambda}_{n}$ is reached. Note that when ${\lambda}_{n}\to 0$, this no-slip constraint is generally violated *before* separation.

For a better explanation, watch the following [talk](https://www.birs.ca/events/2014/5-day-workshops/14w5147/videos/watch/201402170910-Ruina.html).

# Dynamics with a Slipping Contact
In the case of a *slipping* contact, due to Coulomb's law for slipping (if we are assuming Coulomb friction), we can define $\sigma=\mathrm{sgn}({v}_{t})=\pm 1$, such that:
$${\lambda}_{t}=-\sigma \mu{\lambda}_{n}$$
Plugging into $\text{(4.6)}$:

$$\mathbf{M}(\mathbf{q})\ddot{\mathbf{q}}+\mathbf{B}(\mathbf{q},\dot{\mathbf{q}})+\mathbf{G}(\mathbf{q})=\mathbf{F}_{q}+({{\mathbf{w}_{n}}}-\sigma \mu \mathbf{w}_{t})^{T}{\lambda}_{n} \tag{4.15}$$

Assuming $\mathbf{M}$ is non-singular, we can write:
$$\ddot{\mathbf{q}}=\mathbf{M}^{-1}(\mathbf{F}_{q}-\mathbf{B}-\mathbf{G}+(\mathbf{w}_{n}-\sigma \mu \mathbf{w}_{t})^{T}{\lambda}_{n})$$
Differentiating normal constraint $\mathbf{w}_{n}\dot{\mathbf{q}}=0$, we get
$$\dot{\mathbf{w}}_{n}\dot{\mathbf{q}}+\mathbf{w}_{n}\ddot{\mathbf{q}}=0$$
substituting into the expression for $\ddot{\mathbf{q}}$ we get:
$$\dot{\mathbf{w}}_{n}\dot{\mathbf{q}}+\mathbf{w}_{n}\mathbf{M}^{-1}(\mathbf{F}_{q}-\mathbf{B}-\mathbf{G}+(\mathbf{w}_{n}-\sigma \mu \mathbf{w}_{t})^{T}{\lambda}_{n})=0$$

Rearranging:
$$\underbrace{ \mathbf{w}_{n}\mathbf{M}^{-1}(\mathbf{w}_{n}-\sigma \mu \mathbf{w}_{t})^{T} }_{ \alpha (\mathbf{q},\sigma,\mu) }{\lambda}_{n}=\underbrace{ \mathbf{w}_{n}\mathbf{M}^{-1}(\mathbf{B}+\mathbf{G}-\mathbf{F}_{q})-\dot{\mathbf{w}}_{n}\dot{\mathbf{q}} }_{ \beta(\mathbf{q},\dot{\mathbf{q}}) }\tag{4.16}$$
Which allows us to write:
$${\lambda}_{n}=\dfrac{\beta(\mathbf{q},\dot{\mathbf{q}})}{\alpha (\mathbf{q},\sigma,\mu)}\geq  0\tag{4.17}$$
The physical meaning of $\alpha$ and $\beta$ is as follows:
- **$\alpha$** represents the *effective compliance* of the system in the normal direction, accounting for coupling between normal and tangential directions due to friction. It can be interpreted as the normal acceleration response per unit normal force. When $\alpha>0$, applying a normal contact force causes the bodies to accelerate apart (normal behavior). When $\alpha<0$, the friction coupling is so strong that a normal contact force causes the bodies to accelerate *toward* each other - a paradoxical response.
- **$\beta$** represents the *free normal acceleration* - the normal acceleration that would occur at the contact point if there were no contact force (${\lambda}_{n}=0$). It captures the combined effect of inertial forces ($\mathbf{B}$), gravity ($\mathbf{G}$), and applied forces ($\mathbf{F}_{q}$) on the tendency of the contact to separate or persist.

But, what happens if $\alpha(\mathbf{q}(t),\sigma,\mu)\to 0$? Well, we get ${\lambda}_{n}\to \infty$. Is it this possible? How do we handle singularity?

For the frictionless case $\mu=0$, we have $\alpha=\mathbf{w}_{n}\mathbf{M}^{-1}\mathbf{w}^{T}_{n}>0$, but for high $\mu$ and $\sigma=\pm1$ (take $\mathbf{q}=\mathbf{q}_{0}$ and $\sigma=\mathrm{sgn}(\mathbf{w}\mathbf{M}^{-1}\mathbf{w}^{T}_{t}(\mathbf{q}_{0}))$), meaning for high $\mu$ we can get $\alpha<0$.

For example, the [[#The Falling Pencil Problem|the slipping pencil]]:
$$\mathbf{q}=(x,y,\theta),\, \mathbf{w}_{t}=\begin{pmatrix}
1 & 0 & 0
\end{pmatrix},\, \mathbf{w}_{n}=\begin{pmatrix}
0 & 1 & 0
\end{pmatrix}$$
We get:
$$\begin{aligned}
 & \mathbf{M}=\begin{pmatrix}
m & 0 & -m\ell \cos\theta \\
0 & m & -m\ell \sin\theta \\
-m\ell \cos\theta & -m\ell \sin\theta & {I}_{c}+m\ell ^{2}
\end{pmatrix} \\[3ex]
 & \mathbf{B}=\begin{pmatrix}
m\ell\dot{\theta}^{2}\sin\theta \\
-m\ell\dot{\theta}^{2}\cos\theta \\
0
\end{pmatrix} \\[3ex]
 & \mathbf{G}=\begin{pmatrix}
0 \\
mg \\
-mg\ell \sin\theta
\end{pmatrix}
\end{aligned}$$
In that example, $\alpha$ would be:
$$\begin{aligned}
\alpha (\mathbf{q},\sigma,\mu) & =\mathbf{w}_{n}\mathbf{M}^{-1}(\mathbf{w}_{n}-\sigma \mu \mathbf{w}_{t})^{T} \\[1ex]
 & =\dfrac{{I}_{c}+m\ell ^{2}(\sin ^{2}\theta-\sigma \mu \sin\theta \cos\theta)}{m\ell ^{2}}
\end{aligned}$$

$\beta$ would be:
$$\begin{aligned}
\beta (\mathbf{q},\dot{\mathbf{q}}) & =\mathbf{w}_{n}\mathbf{M}^{-1}(\mathbf{B}+\mathbf{G}-\cancel{ \mathbf{F}_{q} })-\cancel{ \dot{\mathbf{w}}_{n}\dot{\mathbf{q}} } \\[1ex]
 & =g-\ell\dot{\theta}^{2}\cos\theta
\end{aligned}$$

For the frictionless limit $\mu \to 0$, we get $\alpha \to ({I}_{c}+m\ell ^{2}\sin ^{2}\theta)/(m\ell^{2})>0$ (except for the degenerate case of a point mass at $\theta=0$). This confirms that without friction, $\alpha$ remains positive and no paradox occurs.

However, as friction increases, the term $-\sigma \mu \sin\theta \cos\theta$ in the expression for $\alpha$ can eventually make $\alpha$ negative. The critical question is: for what friction coefficient ${\mu}_{\min_{}}$ does $\alpha$ first reach zero?

To find this critical friction coefficient, we solve for $\alpha=0$. Substituting the trigonometric identities $\sin ^{2}\theta=\dfrac{1-\cos 2\theta}{2}$ and $\sin\theta \cos\theta=\dfrac{1}{2}\sin 2\theta$, and introducing the friction angle $\gamma$ where $\mu=\tan\gamma$, we obtain:
$$\cos(2\theta-\gamma)=\dfrac{2{I}_{c}+m\ell ^{2}}{m\ell ^{2}\sqrt{ 1+\mu ^{2} }}\leq   1$$
Which means:
$$\mu \geq   \sqrt{ \left( \dfrac{2{I}_{c}+m\ell ^{2}}{m\ell ^{2}} \right)^{2}-1 }:={\mu}_{\min_{}}$$

For a uniform rod ${I}_{c}=m\ell ^{2}/3$, we get ${\mu}_{\min_{}}=4/3$, which is quite high. As we move ${I}_{c}\to 0$, that is, change the distribution of the rod to be a point mass in the center, we get ${\mu}_{\min_{}}\to 0$.

We reach a singularity if $\alpha(\mathbf{q}(t))\to 0$, because then ${\lambda}_{n}\to \infty$.
For $\beta(\mathbf{q}(t),\dot{\mathbf{q}}(t))\to 0$, we get ${\lambda}_{n}\to 0$, which means contact separation... maybe?

For separation, we need to verify that ${a}_{n}=\dot{v}_{n}=\dot{\mathbf{w}}_{n}\dot{\mathbf{q}}+\mathbf{w}_{n} \ddot{\mathbf{q}}>0$.
We get:
$${a}_{n}=\dot{\mathbf{w}}_{n}\dot{\mathbf{q}}+\mathbf{w}_{n}\mathbf{M}^{-1}(\mathbf{F}_{q}-\mathbf{B}-\mathbf{G}+\cancel{ (\mathbf{w}_{n}-\sigma \mu \mathbf{w}_{t})^{T}{\lambda}_{n} })>0$$
For transition case ${d}_{n}={v}_{n}=0$, we get a consistent slip if ${\lambda}_{n}=\dfrac{\beta(\mathbf{q},\dot{\mathbf{q}})}{\alpha(\mathbf{q},\sigma,\mu)}>0$, and consistent separation if ${\alpha}_{n}=-\beta(\mathbf{q},\dot{\mathbf{q}})>0$.

The following table summarizes all possible combinations of signs of $\alpha$ and $\beta$, and their implications for whether slip or separation can occur consistently:

| **Case** | $\mathrm{sgn}(\alpha)$ | $\mathrm{sgn}(\beta)$ | Slip Consistency ${\lambda}_{n}=\beta /\alpha>0$ | Separation Consistency ${a}_{n}=-\beta>0$ | Contact State     |
| -------- | ---------------------- | --------------------- | ------------------------------------------------ | ----------------------------------------- | ----------------- |
| 1        | $+$                    | $+$                   | Yes                                              | No                                        | Slip              |
| 2        | $+$                    | $-$                   | No                                               | Yes                                       | Separation        |
| 3        | $-$                    | $+$                   | No                                               | No                                        | ==inconsistency== |
| 4        | $-$                    | $-$                   | Yes                                              | Yes                                       | ==indeterminacy== |

The 3rd and 4th cases are paradoxes. For the 3rd case (inconsistency), neither slip nor separation is physically possible - there is no solution to the rigid-body equations. For the 4th case (indeterminacy), both slip and separation satisfy the equations - there are multiple solutions. These paradoxes are collectively known as the **Painlevé paradox**, named after Paul Painlevé who first identified them in 1895 while studying the motion of a slender rod sliding on a rough surface^[Painlevé, P. (1895). Sur les lois du frottement de glissement. *Comptes Rendus de l'Académie des Sciences*, 121, 112–115.]. The paradox arises whenever $\alpha(\mathbf{q},\sigma ,\mu)<0$, which occurs when friction coupling is sufficiently strong.

We now can now draw a more general state transition graph than we have previously seen in [[#^figure-state-transition-graph|figure]]:

![[HDY1_004 Unilateral Contact Dynamics 2025-12-30 16.32.15.excalidraw.svg]]^figure-general-state-transitions
>General state transition graph for unilateral contact with friction. The graph includes transitions between contact (no-slip), slipping, and separation states.
