---
aliases:
---
# Constrained Lagrangian Mechanics

Euler-Lagrange equations are used to formulate the dynamics of mechanical systems, which often consist of a kinematic chain of rigid links connected by joints. Kinematic connections are often represented by constraints which reduce the number of the system's DOFs.
There are two main limitations of these equations in their standard formulation:
- They require a minimal number of generalized coordinates, equal to the number of the system's DOF. This may complicate formulation of the system's kinematics and dynamics, especially for mechanisms composed of closed kinematic chains.
- Secondly, the equations contain no information about reaction forces which are required for enforcing the kinematic constraints. This is because Euler-Lagrange's equations are derived from energy balance whereas typical reaction forces generate zero mechanical work (enforcing zero relative velocities at joints, or act in a direction perpendicular to relative motion in frictionless contacts).

In some cases, it is important to formulate expressions for constraint forces, whether for mechanical design purposes (preventing failure of the links) or in cases where the kinematic constraints represent unilateral contacts that add inequalities on contact forces (e.g. only compressive or only tensile forces are possible). Another more complicated case is **non-holonomic constraints** which limit the subspace of permissible directions of velocities depending on the system's instantaneous configuration. In such cases, the system's number of DOF is not reduced.

# Systems with Holonomic Constraints

>[!example] Example: 
> How many DOFs does the following 4-bar mechanism have?
> ![[HDY1_002 Constrained Lagrangian Mechanics 2025-11-18 15.13.04.excalidraw.svg]]^figure-four-bar
>>A grounded 4-bar mechanism.
>
> **Solution**:
> Each free bar has $3$ DOFs - two of them for position and one for orientation. Therefore the whole system essentially, if not constrained, has $3\times 3=9$ DOFs (the fourth bar, the ground, isn't free).
>
> Each connection between two links, removes $2$ degrees of freedom - they constrain the position of the end of each bar to another. Since there are four such connections, we are left with $9-8=1$ DOF.
> 
> We have many different choices which general coordinate to use to describe this DOF:
>![[HDY1_002 Constrained Lagrangian Mechanics 2025-11-18 15.59.47.excalidraw.svg]]^figure-coordinate-choices
>>Some different choices of general coordinates.
> 
> Some of these choices may be poor choices in the context of analysis.
> 
> Additionally, sometimes we'd actually prefer to use more coordinates than the number of DOFs to avoid singularities and simplify the analysis.
> 

Each rigid connection between two particles or rigid bodies by a joint which imposes limitations on relative motion can be written as a holonomic constraint. We choose coordinates ${q}_{1},\dots,{q}_{N}$ which represent the motion *without* accounting for the constraints. The constraints are represented by $m$ equalities of the form ${h}_{j}({q}_{1},\dots,{q}_{n})=0$ where $j=1,\dots,m$ or in vector form as:
$$\mathbf{h}(\mathbf{q})=0$$
When all constraints are independent, the system's effective number of DOFs is $n=N-m$, and the system motion can, in principle, be described by a smaller set of $n=N-m$ coordinates.

Often, such formulation may be very complicated, and a $1$-to-$1$ mapping to the entire space of a system's configurations is not always possible, so the set of coordinates covers only a local sub-region of configurations. When the system's motion is described using the **unconstrained coordinates** ${q}_{1},\dots,{q}_{n}$, one should also add **constraint forces** which enforce the kinematic constraints ${h}_{j}({q}_{1},\dots,{q}_{N})=0$. Thus, the constrained equations of motion in vector form are:
$$\small\dfrac{\mathrm{d}}{\mathrm{d}t}\left( \dfrac{ \partial T }{ \partial \dot{\mathbf{q}} }  \right)-\dfrac{ \partial T }{ \partial \mathbf{q} } +\dfrac{ \partial V }{ \partial \mathbf{q} } =\mathbf{M}(\mathbf{q})\ddot{\mathbf{q}}+\mathbf{B}(\mathbf{q},\dot{\mathbf{q}})+\mathbf{G}(\mathbf{q})=\mathbf{F}_{q}+\mathbf{F}_{c} \tag{2.1}$$
Where $T(\mathbf{q},\dot{\mathbf{q}}),\,V(\mathbf{q})$ are the kinetic and potential energy of a general motion without constraints, $\mathbf{F}_{q}$ is the vector of generalized forces due to non-conservative forces, and $\mathbf{F}_{c}$ is the vector of generalized constraint forces. In order to ensure that the constraint forces do zero mechanical work, they are given as:
$$\mathbf{F}_{c}=\sum_{j=1}^{m} {\lambda}_{j}\nabla {h}_{j}(\mathbf{q}) \tag{2.2}$$
Where ${\lambda}_{j}$ are time-varying scalar magnitudes also called [[CAL2_010 נקודות אקסטרמום#כופל לגראנז'|Lagrange's multipliers]], and the direction $\nabla {h}_{j}(\mathbf{q})=\dfrac{ \partial {h}_{j} }{ \partial \mathbf{q} }$ is a gradient vector of the $j$-th scalar constraint with respect to $\mathbf{q}$. Thus, the instantaneous power of the $j$-th term of $\mathbf{F}_{c}$ in $\text{(2.3)}$ is zero:
$$\begin{aligned}
{P}_{j} & ={\lambda}_{j}\nabla {h}_{j}(\mathbf{q})\cdot \dot{\mathbf{q}} ={\lambda}_{j}\sum_{i=1}^{n} \dfrac{ \partial {h}_{j} }{ \partial {q}_{i} } \dot{q}_{i} 
 ={\lambda}_{j} \dfrac{\mathrm{d}}{\mathrm{d}t}[{h}_{j}(\mathbf{q}(t))] =0
\end{aligned}$$
Since ${h}_{j}(\mathbf{q})=0$.

In matrix form, the equation of motion with vector of constraint force magnitudes $\boldsymbol{\lambda}$ is:
$$\mathbf{M}(\mathbf{q})\ddot{\mathbf{q}}+\mathbf{B}(\mathbf{q},\dot{\mathbf{q}})+\mathbf{G}(\mathbf{q})=\mathbf{F}_{q}+\left( \dfrac{ \mathrm{d} \mathbf{h} }{ \mathrm{d} \mathbf{q} }  \right)^{T} \boldsymbol{\lambda}\tag{2.3}$$
Notice the last term is a matrix multiplied by a vector:
$$\underbrace{ \left( \dfrac{ \mathrm{d} \mathbf{h} }{ \mathrm{d} \mathbf{q} }  \right)^{T} }_{ N\times m } \underbrace{ \boldsymbol{\lambda} }_{ m\times 1 }$$

Equivalent writing as scalar equations:
$$\dfrac{\mathrm{d}}{\mathrm{d}t}\left( \dfrac{ \partial T }{ \partial \dot{q}_{i} }  \right)-\dfrac{ \partial T }{ \partial {q}_{i} } +\dfrac{ \partial V }{ \partial {q}_{i} } ={F}_{{q}_{i}}+\sum_{j=1}^{m} \dfrac{ \partial {h}_{j} }{ \partial {q}_{i} } {\lambda}_{j},\qquad i=1,\dots ,N \tag{2.4}$$

We require solving equation $\text{(2.3)}$ together with the constraints $\mathbf{h}(\mathbf{q})=0$ and find the vector $\boldsymbol{\lambda}(t)$.

Let us define
$$\mathbf{W}(\mathbf{q}):= \dfrac{ \partial \mathbf{h} }{ \partial \mathbf{q} } =\nabla \mathbf{h}(\mathbf{q}),\qquad \mathbf{W}\in \mathbb{R}^{m\times N}$$
so that $\dot{\mathbf{h}}(t)=\mathbf{W}(\mathbf{q})\dot{\mathbf{q}}$ and differentiate twice with respect to time to obtain:
$$\begin{aligned}
 & \dot{\mathbf{h}}(t)=\dfrac{ \partial \mathbf{h} }{ \partial \mathbf{q} } \dot{\mathbf{q}}=\mathbf{W}(\mathbf{q})\dot{\mathbf{q}}=0  \\[1ex]
 & \ddot{\mathbf{h}}(t)=\dot{\mathbf{W}}(\mathbf{q},\dot{\mathbf{q}}) \dot{\mathbf{q}} +\mathbf{W}(\mathbf{q})\ddot{\mathbf{q}}=0
\end{aligned}\tag{2.5}$$

Equations $\text{(2.3)}$ and $\text{(2.5)}$ can be rearranged as a system of differential-algebraic equations:
$$\begin{pmatrix}
\mathbf{M} & -\mathbf{W}^{T} \\
\mathbf{W} & 0
\end{pmatrix}\begin{pmatrix}
\ddot{\mathbf{q}} \\
\boldsymbol{\lambda}
\end{pmatrix}=\begin{pmatrix}
\mathbf{F}_{q}-\mathbf{B}-\mathbf{G} \\
-\dot{\mathbf{W}}\dot{\mathbf{q}}
\end{pmatrix} \tag{2.6}$$

Equation $\text{(2.6)}$ is a linear system suitable for numerical integration under state vector $\mathbf{z}=\begin{pmatrix}\mathbf{q} & \dot{\mathbf{q}}\end{pmatrix}^{T}$.
They form a system of $N+m$ linear equations in the unknowns $(\ddot{\mathbf{q}},\boldsymbol{\lambda})\in \mathbb{R}^{N+m}$, which can be numerically solved as a function of instantaneous configuration and velocities ($\mathbf{q},\dot{\mathbf{q}}$). If the inertia matrix $\mathbf{M}$ is non-singular (no massless links or rotating bodies with zero moment of inertia), an explicit expression for the accelerations $\ddot{\mathbf{q}}$ can be extracted from $\text{(2.3)}$ as:
$$\ddot{\mathbf{q}}=\mathbf{M}^{-1}(-\mathbf{B}-\mathbf{G}+\mathbf{F}_{q}+\mathbf{W}^{T}\boldsymbol{\lambda}) \tag{2.7}$$
And then substituted into $\text{(2.5)}$ and obtain:
$$\begin{gathered}
0=\dot{\mathbf{W}}\dot{\mathbf{q}}+\mathbf{W}\ddot{\mathbf{q}} \\[1ex]
0=\dot{\mathbf{W}}\dot{\mathbf{q}}+\mathbf{W}\mathbf{M}^{-1}(-\mathbf{B}-\mathbf{G}+\mathbf{F}_{q}+\mathbf{W}^{T}\boldsymbol{\lambda})
\end{gathered}$$

Which can rearranged as:
$$\mathbf{W}\mathbf{M}^{-1}\mathbf{W}^{T} \boldsymbol{\lambda}=\mathbf{W}\mathbf{M}^{-1}(\mathbf{B}+\mathbf{G}-\mathbf{F}_{q})-\dot{\mathbf{W}}\dot{\mathbf{q}}\tag{2.8}$$

Inverting the left-hand side matrix in $\text{(2.8)}$, the vector constraint forces magnitudes can be found as:
$$\boldsymbol{\lambda}(\mathbf{q},\dot{\mathbf{q}},t)=(\mathbf{W}\mathbf{M}^{-1}\mathbf{W}^{T})^{-1}(\mathbf{W}\mathbf{M}^{-1}(\mathbf{B}+\mathbf{G}-\mathbf{F}_{q})-\dot{\mathbf{W}}\dot{\mathbf{q}}) \tag{2.9}$$

Finally, substituting $\text{(2.9)}$ into $\text{(2.3)}$ gives a second-order ODE in $\mathbf{q}(t)$, which can be transformed into a first-order state equation for $\mathbf{z}=(\mathbf{q},\dot{\mathbf{q}},t)$.

>[!example] Example: 2D pendulum
>
>Given a 2D pendulum:
>![[HDY1_002 Constrained Lagrangian Mechanics 2025-11-18 16.28.38.excalidraw.svg]]^figure-2d-pendulum
>>Simple 2D pendulum.
>
>We describe the motion with two ($N=2$) polar general coordinates $\mathbf{q}=\begin{pmatrix}r & \theta\end{pmatrix}^{T}$, and with one $(m=1)$ holonomic constraint:
>$$h(\mathbf{q})=r-L=0$$
>The kinematics:
>$$\begin{aligned}
> & \mathbf{r}=r\sin\theta\,\mathbf{e}_{1}-r\cos\theta\,\mathbf{e}_{2} \\[1ex]
> & \dot{\mathbf{r}}=[\dot{r}\sin\theta+r\dot{\theta}\cos \theta]\mathbf{e}_{1}+[-\dot{r}\cos \theta+r\dot{\theta}\sin\theta]\mathbf{e}_{2}
>\end{aligned}$$
>The energies:
>$$\begin{aligned}
> & T=\dfrac{1}{2}m \mathbf{\dot{r}}^{2} \\[1ex]
> & \phantom{T}=\dots =\dfrac{1}{2}m(\dot{r}^{2}+r^{2}\dot{\theta}^{2}) \\[3ex]
> & V=mgh-mgr\cos\theta
>\end{aligned}$$
>
>The power:
>$$\begin{aligned}
{P}_{\text{nc}} & =\mathbf{f}\cdot \dot{\mathbf{r}} \\[1ex]
> & =({f}_{x}\mathbf{e}_{1})\cdot \dot{\mathbf{r}} \\[1ex]
> & ={f}_{x}\dot{r}\sin\theta+{f}_{x}r\dot{\theta}\cos\theta
>\end{aligned}$$
>The $\mathbf{W}$ matrix:
>$$\begin{aligned}
>\mathbf{W}(\mathbf{q}) & =\nabla \mathbf{h}(\mathbf{q}) \\[1ex]
> & =\dfrac{ \partial \mathbf{h} }{ \partial \mathbf{q} }  \\[1ex]
> & =\begin{pmatrix}
>1 \\
>0
>\end{pmatrix}
>\end{aligned}$$
>Now applying $\text{(2.4)}$:
>- for $i=1,\,{q}_{1}=r$:
>   $$\begin{aligned}
>	 & \dfrac{\mathrm{d}}{\mathrm{d}t}\left( \dfrac{ \partial T }{ \partial \dot{r} }  \right)=m\ddot{r} \\[1ex]
>	 & \dfrac{ \partial T }{ \partial r } =mr\dot{\theta}^{2} \\[1ex]
>	 & \dfrac{ \partial V }{ \partial r } =-mg\cos\theta \\[1ex]
>	 & {F}_{r}=\dfrac{ \partial {P}_{\text{nc}} }{ \partial r } ={f}_{x}\sin\theta \\[1ex]
>	 & {F}_{c,r}={\lambda}_{1} \dfrac{ \partial h }{ \partial r }={\lambda}_{1}
>	\end{aligned}$$
>	We get:
>	$$m\ddot{r}-mr\dot{\theta}^{2}-mg\cos\theta={f}_{x}\sin \theta+{\lambda}_{1}$$
>	
>- for $i=2,\,{q}_{2}=\theta$:
>	$$\begin{aligned}
>	& \dfrac{\mathrm{d}}{\mathrm{d}t}\left( \dfrac{ \partial T }{ \partial \dot{\theta} }  \right)=mr^{2}\ddot{\theta}+2mr \dot{r}\dot{\theta} \\[1ex]
>	& \dfrac{ \partial T }{ \partial \theta } =0 \\[1ex]
>	& \dfrac{ \partial V }{ \partial \theta } =mgr\sin\theta \\[1ex]
>	& {F}_{\theta}= \dfrac{ \partial {P}_{\text{nc}} }{ \partial \dot{\theta} } ={f}_{x}r\cos\theta \\[1ex]
>	& {F}_{c\theta}= {\lambda}_{1} \dfrac{ \partial h }{ \partial \theta } =0
>	\end{aligned}$$
>	We get:
>	$$mr^{2}\ddot{\theta}+2mr \dot{r}\dot{\theta}+mgr\sin\theta={f}_{x}r\cos\theta$$
>In matrix notation:
>$$\underbrace{ \begin{pmatrix}
>m & 0 \\
>0 & mr^{2}
>\end{pmatrix} }_{ \mathbf{M}(\mathbf{q}) }\underbrace{ \begin{pmatrix}
>\ddot{r} \\
>\ddot{\theta}
>\end{pmatrix} }_{ \ddot{\mathbf{q}} }+\underbrace{ \begin{pmatrix}
>-mr\dot{\theta}^{2} \\
>2mr \dot{r}\dot{\theta}
>\end{pmatrix} }_{ \mathbf{B}(\dot{\mathbf{q}},\mathbf{q}) }+\underbrace{ \begin{pmatrix}
>-mg\cos\theta \\
>mgr\sin\theta
>\end{pmatrix} }_{ \mathbf{G}(\mathbf{q}) }=\underbrace{ \begin{pmatrix}
>{f}_{x}\sin\theta \\
>{f}_{x}r\cos\theta
>\end{pmatrix} }_{ \mathbf{F}_{q} }+\underbrace{ \begin{pmatrix}
>{\lambda}_{1} \\
>0
>\end{pmatrix} }_{ \mathbf{F}_{c}=\mathbf{W}(\mathbf{q})^{T}\boldsymbol{\lambda} }$$
>
>The constraint force $\boldsymbol{\lambda}(\mathbf{q},\dot{\mathbf{q}})$ can be calculated using equation $\text{(2.9)}$. Alternatively, it can be found directly from the equation of motion $\text{(2.1)}$ above for $r$, after substituting the constraint and its derivatives, $r=L,\,\dot{r}=\ddot{r}=0$, one obtains $\lambda=-mL\dot{\theta}^{2}-mg\cos\theta-{f}_{x}\sin\theta$.

>[!Question]- What does $\lambda$ mean here? What are its units? Does $\lambda>0$ mean tension or compression?
>Note that the "virtual power" of constraint force is ${P}_{j}={\lambda}_{j} \dfrac{ \partial {h}_{j} }{ \partial \mathbf{q} }\dot{\mathbf{q}}={\lambda}_{j}{h}_{j}$. This implies that $\lambda>0$ is directed to increase $h$.
>Because $h=r-L$ measures the difference between the current link length and the prescribed length, its gradient is the radial unit vector. The multiplier $\lambda$ therefore multiplies a dimensionless gradient and has the units of force (newtons). The generalized constraint force contributed to the $r$-equation is $\lambda\,\mathbf{e}_{r}$; a positive value pushes the pendulum bob outward (compression along the rod) while a negative value corresponds to tension that pulls the bob toward the pivot. The physical tension in the rod is $T=-\lambda$, so $T>0$ implies $\lambda<0$.


>[!example] Example: Slider-crank mechanism
>
>Given the following slider-crank mechanism:
>![[HDY1_002 Constrained Lagrangian Mechanics 2025-11-18 16.51.13.excalidraw.svg]]^figure-slider-crank
>>Simple slider-crank mechanism.
>
>We describe the motion with three ($N=3$) general coordinates $\mathbf{q}=\begin{pmatrix}\theta & \phi & x\end{pmatrix}^{T}$, and with two $m=2$ holonomic constraints:
>$$\mathbf{h}(\mathbf{q})=\mathbf{r}_{P}-x\mathbf{e}_{1}=0$$
>Therefore the system's effective number of DOF is $n=N-m=1$. We write:
>$$\begin{aligned}
> & \mathbf{r}_{c 1}={L}_{1}\cos\theta \,\mathbf{e}_{1}+{L}_{1}\sin\theta\,\mathbf{e}_{2} \\[1ex]
> & \dot{\mathbf{r}}_{c 1}=-{L}_{1}\dot{\theta}\sin\theta\,\mathbf{e}_{1}+{L}_{1}\dot{\theta}\cos\theta\,\mathbf{e}_{2} \\[1ex]
> & {\dot{\mathbf{r}}_{c 1} }^{2} ={{{L}_{1}}}^{2}\dot{\theta}^{2} \\[3ex]
> & \mathbf{r}_{c 2}=[2{L}_{1}\cos\theta-{L}_{2}\cos \phi]\mathbf{e}_{1}+[2{L}_{1}\sin\theta-{L}_{2}\sin \phi]\mathbf{e}_{2} \\
> & \dot{\mathbf{r}}_{c 2}=[-2{L}_{1}\dot{\theta}\sin\theta+{L}_{2}\dot{\phi}\sin \phi]\mathbf{e}_{1}+[2{L}_{1}\dot{\theta}\cos\theta-{L}_{2}\dot{\phi}\cos \phi]\mathbf{e}_{2} \\[1ex]
> & {\dot{\mathbf{r}}_{c 2} }^{2}=4{{{L}_{1}}}^{2}\dot{\theta}^{2}+{{{L}_{2}}}^{2}\dot{\phi}^{2}-4{L}_{1}{L}_{2}\dot{\theta}\dot{\phi}\cos(\theta-\phi) \\[3ex]
> & \mathbf{r}_{3}=x\mathbf{e}_{1} \\[1ex]
> & \dot{\mathbf{r}}_{3}=\dot{x}\mathbf{e}_{1} \\[1ex]
> & {\dot{\mathbf{r}}_{3}}^{2}=\dot{x}^{2}
>\end{aligned}$$
>
>The energies and power of non-conservative forces:
>$$\begin{aligned}
> & T=\small \dfrac{1}{2}{m}_{1}{\dot{\mathbf{r}}_{c 1}}^{2}+\dfrac{1}{2}{I}_{1}{{\boldsymbol{\omega}_{1}}}^{2}+\dfrac{1}{2}{m}_{2}{\dot{\mathbf{r}}_{c 2}}^{2}+\dfrac{1}{2}{I}_{2}{{\boldsymbol{\omega}_{2}}}^{2}+\dfrac{1}{2}{m}_{3}{\dot{\mathbf{r}}_{3}}^{2} \\[1ex]
> &\phantom{T} =\small \dfrac{1}{2}({m}_{1}{{{L}_{1}}}^{2}+{I}_{1})\dot{\theta}^{2}+\dfrac{1}{2}{m}_{2}[4{{{L}_{1}}}^{2}\dot{\theta}^{2}+{{{L}_{2}}}^{2}\dot{\phi}^{2}-4{L}_{1}{L}_{2}\dot{\theta}\dot{\phi}\cos(\theta-\phi)]+\dfrac{1}{2}{m}_{3}\dot{x}^{2} \\[3ex]
> & V=-{m}_{1}(\mathbf{r}_{c 1}\cdot(-g\mathbf{e}_{2}))-{m}_{2}(\mathbf{r}_{c 2}\cdot(-g\mathbf{e}_{2})) \\[1ex]
> & \phantom{V}={m}_{1}g{L}_{1}\sin\theta+{m}_{2}g[2{L}_{1}\sin\theta-{L}_{2}\sin \phi] \\[3ex]
> & {P}_{\text{nc}}=\tau\dot{\theta}+\mathbf{f}\cdot \dot{\mathbf{r}}_{3}=\tau\dot{\theta}+f\dot{x}
>\end{aligned}$$
>
>The holonomic equations:
>$$\begin{gathered}
> & \mathbf{h}(\mathbf{q}) =\mathbf{r}_{P}-x\mathbf{e}_{1}=0 \\[1ex]
> & \mathbf{h}(\mathbf{q})=\begin{pmatrix}
>2{L}_{1}\cos\theta-2{L}_{2}\cos \phi-x \\
>2{L}_{1}\sin\theta-2{L}_{2}\sin \phi
>\end{pmatrix}_{m\times 1}=0
>\end{gathered}$$
>
>The $\mathbf{W}$ matrix:
>$$\begin{aligned}
> \mathbf{W}(\mathbf{q}) & =\dfrac{ \partial \mathbf{h} }{ \partial \mathbf{q} }  \\[1ex]
>  & =\begin{pmatrix}
> \dfrac{ \partial \mathbf{h} }{ \partial \theta }  & \dfrac{ \partial \mathbf{h} }{ \partial \phi }  & \dfrac{ \partial \mathbf{h} }{ \partial x } 
> \end{pmatrix}_{m\times N} \\[1ex]
>  & =\begin{pmatrix}
> -2{L}_{1}\sin\theta & 2{L}_{2}\sin \phi & -1 \\
> 2{L}_{1}\cos\theta & -2{L}_{2}\cos \phi & 0
> \end{pmatrix}_{m\times N}
> \end{aligned}$$
> Therefore:
> $$\dot{\mathbf{W}}=\begin{pmatrix}
> -2{L}_{1}\dot{\theta}\cos\theta & 2{L}_{2}\dot{\phi}\cos \phi & 0 \\
> -2{L}_{1}\dot{\theta}\sin\theta & 2{L}_{2}\dot{\phi}\sin \phi & 0
> \end{pmatrix}_{m\times N}$$
> To solve $\text{(2.6)}$ we need to now:
> $$\begin{aligned}
>  & \mathbf{M}(\mathbf{q})=\dfrac{ \partial ^{2}T }{ \partial \dot{\mathbf{q}}^{2} } =\begin{pmatrix}
> {I}_{1}+{m}_{1}{{{L}_{1}}}^{2}+4{m}_{2}{{{L}_{1}}}^{2} & -2{m}_{2}{L}_{1}{L}_{2}\cos(\theta-\phi) & 0 \\
> -2{m}_{2}{L}_{1}{L}_{2}\cos(\theta-\phi) & {I}_{2}+{m}_{2}{{{L}_{2}}}^{2} & 0 \\
> 0 & 0 & {m}_{3}
> \end{pmatrix} \\[3ex]
>  & \mathbf{B}(\dot{\mathbf{q}},\mathbf{q})=\dfrac{ \partial ^{2}T }{ \partial \dot{\mathbf{q}}\partial \mathbf{q} } \dot{\mathbf{q}}-\dfrac{ \partial T }{ \partial \mathbf{q} }=\begin{pmatrix}
> -2{m}_{2}{L}_{1}{L}_{2}\sin(\theta-\phi)\dot{\phi}^{2} \\
> 2{m}_{2}{L}_{1}{L}_{2}\cos(\theta-\phi)\dot{\theta}^{2} \\
> 0
> \end{pmatrix} \\[3ex]
>  & \mathbf{G}(\mathbf{q})=\dfrac{ \partial V }{ \partial \mathbf{q} } =\begin{pmatrix}
> ({m}_{1}{L}_{1}+2{m}_{2}{L}_{1})g\cos\theta \\
> -{m}_{2}{L}_{2}\cos \phi \\
> 0
> \end{pmatrix} \\[3ex]
>  & \mathbf{F}_{q}=\dfrac{ \partial {P}_{\text{nc}} }{ \partial \dot{\mathbf{q}} } =\begin{pmatrix}
> \tau \\
> 0 \\
> f
> \end{pmatrix} \\[3ex]
>  & \mathbf{F}_{c}=\small\mathbf{W}^{T}\boldsymbol{\lambda}=\begin{pmatrix}
> -2{L}_{1}\sin\theta & 2{L}_{1}\cos\theta \\
> 2{L}_{2}\sin \phi & -2{L}_{2}\cos \phi \\
> -1 & 0
> \end{pmatrix}_{N\times m}\begin{pmatrix}
> {\lambda}_{1} \\
> {\lambda}_{2}
> \end{pmatrix}=\begin{pmatrix}
> -2{L}_{1}{\lambda}_{1}\sin\theta+2{L}_{1}{\lambda}_{2}\cos\theta \\
> 2{L}_{2}{\lambda}_{1}\sin \phi-2{L}_{2}{\lambda}_{2}\cos \phi \\
> -{\lambda}_{1}
> \end{pmatrix}
> \end{aligned}$$
> 

>[!Question]- What are the physical units and meaning of vector $\boldsymbol{\lambda}$?
>Each entry of $\boldsymbol{\lambda}=\begin{pmatrix}\lambda_{1} & \lambda_{2}\end{pmatrix}^{T}$ enforces one scalar holonomic constraint, so both multipliers carry the units of force. Constraint $h_{1}$ closes the horizontal loop through the slider, hence $\lambda_{1}$ is the reaction transmitted along the slider direction and produces $F_{c,x}=-\lambda_{1}$. Constraint $h_{2}$ enforces the vertical alignment of the crank-pin and slider, so $\lambda_{2}$ represents the vertical reaction at the joint; when mapped via $\mathbf{F}_{c}=\mathbf{W}^{T}\boldsymbol{\lambda}$ it injects torques into the $\theta$ and $\phi$ equations through the geometry factors $2L_{1}$ and $2L_{2}$. Solving for $\boldsymbol{\lambda}$ therefore yields the Cartesian joint forces acting between the crank, connecting rod, and slider.

# Systems with Non-Holonomic Constraints

A nonholonomic constraint imposes equalities involving of the system's instantaneous velocities $\dot{\mathbf{q}}$. General form $f(\mathbf{q},\dot{\mathbf{q}})=0$. In this class we consider only constraints of the form (called **Pfaffian** constrains):
$${\eta}_{j}(\mathbf{q},\dot{\mathbf{q}})=\mathbf{w}_{j}(\mathbf{q})\dot{\mathbf{q}}=0\qquad \qquad j=1,\dots ,m\tag{2.10}$$
The meaning of $\text{(2.10)}$ is that at each instantaneous configuration $\mathbf{q}$ of the system, the direction of the vector of generalized quantities $\dot{\mathbf{q}}$ is constrained to lie within a subspace of dimensions $N-m$, and has $m$ directions of "forbidden" motion. In matrix form, $\text{(2.10)}$, can be written as:
$$\mathbf{W}(\mathbf{q})\dot{\mathbf{q}}=0\qquad \mathbf{W}(\mathbf{q})=[\mathbf{w}_{1}(\mathbf{q}),\dots ,\mathbf{w}_{m}(\mathbf{q})^{T}]\in \mathbb{R}^{m\times N} \tag{2.11}$$

Just as in case holonomic constraints, the generalized forces enforcing constraints of the form $\text{(2.11)}$ are $\mathbf{F}_{c}=\mathbf{W}(\mathbf{q})^{T}\boldsymbol{\lambda}$ where $\boldsymbol{\lambda}\in \mathbb{R}^{m}$ where $\boldsymbol{\lambda}\in \mathbb{R}^{m}$ is a vector of Lagrange's multipliers, magnitude of constraint forces. The work rate (power) done by constraint forces is again zero $\mathbf{F}_{c}\cdot \dot{\mathbf{q}}=\boldsymbol{\lambda}^{T}\mathbf{W}(\mathbf{q})\dot{\mathbf{q}}=\sum_{j=1}^{m}{\lambda}_{j}{\eta}_{j}=0$. Hence, the constrained equations of motion take the form:
$$\mathbf{M}(\mathbf{q})\ddot{\mathbf{q}}+\mathbf{B}(\mathbf{q},\dot{\mathbf{q}})+\mathbf{G}(\mathbf{q})=\mathbf{F}_{q}+\mathbf{W}(\mathbf{q})^{T}\boldsymbol{\lambda}\tag{2.12}$$

>[!example] Example: Chaplygin's Sleigh
>![[HDY1_002 Constrained Lagrangian Mechanics 2025-11-25 17.12.40.excalidraw.svg]]^figure-chaplygins-sleight
>>A rigid body with a blade edge represented by a point $p$ that cannot slip sideways in body-fixed $\mathbf{e}_{2}'$ direction.
> We use the rotating system:
> $$\begin{cases}
> \mathbf{e}_{1}'=\cos\theta\,\mathbf{e}_{1}+\sin\theta\,\mathbf{e}_{2} \\
> \mathbf{e}_{2}'=-\sin\theta\,\mathbf{e}_{1}+\cos\theta\,\mathbf{e}_{2}
> \end{cases}$$
> The position of the center of mass:
> $$\begin{aligned}
>  & \mathbf{r}_{c}=x\mathbf{e}_{1}+y\mathbf{e}_{2} \\[1ex]
>  & \dot{\mathbf{r}}_{c}=\dot{x}\mathbf{e}_{1}+\dot{y}\mathbf{e}_{2}
> \end{aligned}$$
> The position and velocity of $p$:
> $$\begin{aligned}
>  & \mathbf{r}_{p}=\mathbf{r}_{c}-b\mathbf{e}_{1}'=[x-b\cos\theta]\mathbf{e}_{1}+[y-b\sin\theta]\mathbf{e}_{2} \\[1ex]
>  & \dot{\mathbf{r}}_{p}=[\dot{x}+b\dot{\theta}\sin\theta]\mathbf{e}_{1}+[\dot{y}-b\dot{\theta}\cos\theta]\mathbf{e}_{2}
> \end{aligned}$$
> The kinetic energy:
> $$\begin{aligned}
> T & =\dfrac{1}{2}m\dot{\mathbf{r}}_{c}^{2}+\dfrac{1}{2}{I}_{c}\boldsymbol{\omega}^{2} \\[1ex]
>  & =\dfrac{1}{2}m(\dot{x}^{2}+\dot{y}^{2})+\dfrac{1}{2}{I}_{c}\dot{\theta}^{2}
> \end{aligned}$$
> And the potential energy is simply $V=0$.
> 
> The **non-holonomic** skid condition:
> $$\boxed {
> \mathbf{v}_{p}\cdot \mathbf{e}'_{2}=0
>  }$$
> Meaning point $p$ cannot move in the $\mathbf{e}_{2}'$ direction - the sleigh cannot skid.
> We want to write this constraint in the form of $\text{(2.11)}$. Substituting $\mathbf{v}_{p}$ and $\mathbf{e}_{2}'$:
> $$\begin{gathered}
> -[\dot{x}+b\dot{\theta}\sin\theta]\sin\theta+[\dot{y}-b\dot{\theta}\cos\theta]\cos\theta=0 \\[1ex]
> -\dot{x}\sin\theta-b\dot{\theta}\sin ^{2}\theta+\dot{y}\cos\theta-b\dot{\theta}\cos ^{2}\theta=0 \\[1ex]
> -\dot{x}\sin\theta+\dot{y}\cos\theta-b\dot{\theta}=0 \\[1ex]
> \underbrace{ \begin{pmatrix}
> -\sin\theta & \cos\theta & -b
> \end{pmatrix}_{m\times N} }_{ \mathbf{W}(\mathbf{q}) }\underbrace{ \begin{pmatrix}
> \dot{x} \\
> \dot{y} \\
> \dot{\theta}
> \end{pmatrix} }_{ \dot{\mathbf{q}} }=0
> \end{gathered}$$
> 
> The mass matrix:
> $$\begin{aligned}
>  & \mathbf{M}(\mathbf{q})=\dfrac{ \partial ^{2}T }{ \partial \dot{\mathbf{q}}^{2} } =\begin{pmatrix}
> m & 0 & 0 \\
> 0 & m & 0 \\
> 0 & 0 & {I}_{c}
> \end{pmatrix} \\[1ex]
>  & \implies \mathbf{M}^{-1}=\begin{pmatrix}
> 1/m & 0 & 0 \\
> 0 & 1/m & 0 \\
> 0 & 0 & 1/{I}_{c}
> \end{pmatrix}
> \end{aligned}$$
> 
> The $\mathbf{W}$ matrix:
> $$\begin{aligned}
>  & \mathbf{W}=\begin{pmatrix}
> -\sin\theta & \cos\theta & -b
> \end{pmatrix} \\[1ex]
>  & \implies \dot{\mathbf{W}}=\begin{pmatrix}
> -\dot{\theta}\cos\theta & -\dot{\theta}\sin\theta & 0
> \end{pmatrix}
> \end{aligned}$$
> 
> The equations of motion:
> $$\begin{cases}
> \mathbf{M}(\mathbf{q})\ddot{\mathbf{q}}+\cancel{ \mathbf{B}(\dot{\mathbf{q}},\mathbf{q}) }+\cancel{ \mathbf{G}(\mathbf{q}) }=\cancel{ \mathbf{F}_{q} }+\mathbf{F}_{c} \\[1ex]
> \ddot{\mathbf{h}}(\mathbf{q})=\dot{\mathbf{W}}\dot{\mathbf{q}}+\mathbf{W}\ddot{\mathbf{q}}=0
> \end{cases}$$
> 
> After substitutions we get:
> $$\lambda=-\dfrac{m{I}_{c}}{mb^{2}+{I}_{c}}\dot{\theta}(\dot{x}\cos\theta+\dot{y}\sin\theta)$$
> 
> 


Note that differentiation of *any* holonomic constraints $\mathbf{h}(\mathbf{q})=0$ with respect to time will give $\left( \dfrac{ \partial \mathbf{h} }{ \partial \mathbf{q} } \right)\dot{\mathbf{q}}=\mathbf{W}(\mathbf{q})\dot{\mathbf{q}}=0$. That is, a holonomic constraint can also be written as a velocity constraint as in $\text{(2.11)}$. For example, point particle in 2D has $N=2$ and $\mathbf{q}=\begin{pmatrix}x & y\end{pmatrix}^{T}$. The scalar velocity constraint $x \dot{x}+y \dot{y}=0$ comes from differentiation of the holonomic constraint $x^{2}+y^{2}=\ell ^{2}$, which represent motion along a circular arc, i.e., pendulum in 2D. The fundamental difference is that if $\text{(2.11)}$ comes from differentiating a holonomic constraint, then the actual number of system's DOFs is *reduced* and the system's motion can effectively be described by $N-m$ coordinates. In such case, the velocity constraints are said to be *integrable* and not "truly" nonholonomic. For "true" nonholonomic constraints, the system can reach all $N$-dimensional space of configurations $\mathbf{q}$ in spite of the $m$ constraints on velocities (only the *trajectories* are limited). A mathematical condition to check whether a system of constraints as in $\text{(2.11)}$ is integrable or truly nonholonomic is beyond the scope of this course.

# Under-Actuated Robots with Nonholonomic Constraints
In under-actuated robots, only part of the degrees-of-freedom are directly actuated, whereas the rest of them are passive. Therefore, the generalized coordinates can be decomposed into passive and actuated coordinates as
$$\mathbf{q}=\begin{pmatrix}
\mathbf{q}_{p} \\
\mathbf{q}_{a}
\end{pmatrix}^{T}$$
where $\mathbf{q}_{p}\in \mathbb{R}^{{n}_{p}},\,\mathbf{q}_{a}\in \mathbb{R}^{{n}_{a}}$, A particular case is "locomotion systems" [[HDY1_001 Introduction#Locomotion of Under-Actuated Robots|where one distinguishes between body coordinates and shape coordinates]], but this is not always aligned with the partition into actuated and passive DOFs. For instance, some shape variables might be passive.

Nonholonomic constrains on velocities of the form $\mathbf{W}(\mathbf{q})\dot{\mathbf{q}}=0$ can be decomposed into sub-blocks as $\mathbf{W}=\begin{pmatrix}\mathbf{W}_{p}&\mathbf{W}_{a}\end{pmatrix}^{T}$, where $\mathbf{W}_{p}\in \mathbb{R}^{m\times {n}_{p}},\,\mathbf{W}_{a}\in \mathbb{R}^{m\times {n}_{a}}$:
$$\mathbf{W}(\mathbf{q})\dot{\mathbf{q}}=\mathbf{W}_{p}(\mathbf{q})\dot{\mathbf{q}}_{p}+\mathbf{W}_{a}(\mathbf{q})\dot{\mathbf{q}}_{a}=0 \tag{2.13}$$

If the number of constrains is "sufficiently large" such that $m={n}_{p}$, then the system is called "kinematic". If one assumes that the actuated coordinates $\mathbf{q}_{a}(t)$ can be directly prescribed/controlled, the motion is governed by a first-order differential system:
$$\dot{\mathbf{q}}_{a}=-\mathbf{W}_{p}(\mathbf{q})^{-1}\mathbf{W}_{a}(\mathbf{q})\dot{\mathbf{q}}_{a}\tag{2.14}$$
That is, the motion of $\mathbf{q}_{p}(t)$ can be dictated indirectly. Note that one has to verify that $\mathbf{W}_{p}$ is invertible.

In case where $m<{n}_{p}$, the system is not kinematic, and one has to consider the *dynamic* equations of motion $\text{(2.6)}$ or $\text{(2.12)}$. The matrix-form equations of motion $\text{(2.3)}$ and $\text{(2.5)}$ can be decomposed into blocks (matrix form):

$$\tiny\begin{cases}
\left(\begin{array}{c|c}
\mathbf{M}_{pp} & \mathbf{M}_{pa} \\
\hline {\mathbf{M}_{pa}}^{T} & \mathbf{M}_{aa}
\end{array}\right)\left(\begin{array}{c}
\ddot{\mathbf{q}}_{p} \\
\hline \ddot{\mathbf{q}}_{a}
\end{array}\right)+\left(\begin{array}{c}
\mathbf{B}_{p}(\mathbf{q},\dot{\mathbf{q}}) \\
\hline \mathbf{B}_{a}(\mathbf{q},\dot{\mathbf{q}})
\end{array}\right)+\left(\begin{array}{c}
\mathbf{G}_{p}(\mathbf{q}) \\
\hline \mathbf{G}_{a}(\mathbf{q})
\end{array}\right)=\left(\begin{array}{c}
\mathbf{0} \\
\hline \mathbf{F}_{\mathbf{q}_{a}}
\end{array}\right)+\left(\begin{array}{c}
\mathbf{W}_{p}^{T} \\
\hline \mathbf{W}_{a}^{T}
\end{array}\right)\boldsymbol{\lambda} \\[1ex]
\ddot{\mathbf{W}}_{p}\dot{\mathbf{q}}_{p}+\mathbf{W}_{p}\ddot{\mathbf{q}}_{p}+\dot{\mathbf{W}}_{a}\dot{\mathbf{q}}_{a}+\mathbf{W}_{a}\ddot{\mathbf{q}}_{a}=0
\end{cases} \tag{2.15}$$
Can also be written as:

$$\left(\begin{array}{c}
\mathbf{M}_{pp} & \mathbf{M}_{pa} & -\mathbf{W}_{p}^{T} \\
{\mathbf{M}_{pa}}^{T} & \mathbf{M}_{aa} & -\mathbf{W}_{a}^{T} \\
\mathbf{W}_{p} & \mathbf{W}_{a} & \mathbf{0}_{m\times m}
\end{array}\right)\left(\begin{array}{c}
\ddot{\mathbf{q}}_{p} \\
\ddot{\mathbf{q}}_{a} \\
\boldsymbol{\lambda}
\end{array}\right)=\left(\begin{array}{c}
-\mathbf{B}_{p}-\mathbf{G}_{p} \\
\mathbf{F}_{\mathbf{q}_{a}}-\mathbf{B}_{a}-\mathbf{G}_{a} \\
 -\dot{\mathbf{W}}_{p}\dot{\mathbf{q}}_{p}-\dot{\mathbf{W}}_{a}\dot{\mathbf{q}}_{a}
\end{array}\right)\tag{2.15}$$

Now assuming that the shape variables $\mathbf{q}_{a}(t)$ are directly prescribed, $\text{(2.15)}$ can be rearranged such that the unknowns are body accelerations $\ddot{\mathbf{q}}_{p}$, actuation torques $\mathbf{F}_{\mathbf{q}_{a}}$, and constraint forces $\boldsymbol{\lambda}$:

$$\tiny\left(\begin{array}{c}
\mathbf{M}_{pp} & \mathbf{0}_{{n}_{p}\times {n}_{a}} & -\mathbf{W}_{p}^{T} \\
{\mathbf{M}_{pa}}^{T} & -\mathbf{I}_{{n}_{a}\times {n}_{a}} & -\mathbf{W}_{a}^{T} \\
\mathbf{W}_{p} & \mathbf{0}_{{m}\times {n}_{a}} & \mathbf{0}_{m\times m}
\end{array}\right)\left(\begin{array}{c}
\ddot{\mathbf{q}}_{p} \\
\mathbf{F}_{\mathbf{q}_{a}} \\
\boldsymbol{\lambda}
\end{array}\right)_{(N+m)\times 1}=\left(\begin{array}{c}
-\mathbf{M}_{pa}\ddot{\mathbf{q}}_{a}-\mathbf{B}_{p}-\mathbf{G}_{p} \\
-\mathbf{M}_{aa}\ddot{\mathbf{q}}_{a}-\mathbf{B}_{a}-\mathbf{G}_{a} \\
-\dot{\mathbf{W}}_{a}\dot{\mathbf{q}}_{a}-\dot{\mathbf{W}}_{p}\dot{\mathbf{q}}_{p}
\end{array}\right)\tag{2.16}$$

Note that the right side of $\text{(2.16)}$ contains known values of shape variables $\mathbf{q}_{a}(t)$ and their time-derivatives, as well as body positions and velocities, $\mathbf{q}_{p},\,\dot{\mathbf{q}}_{p}$. Thus, $\text{(2.16)}$ is a second-order differential-algebraic system which gives a state equation for the body motion $\mathbf{q}_{p}(t)$ in case that $\mathbf{q}_{a}(t)$ is the prescribed control input. Riding toys examples:

![](https://www.youtube.com/watch?v=69s3_OlS94A)

![](https://www.youtube.com/watch?v=_nVTAlvg73c)

![](https://www.youtube.com/watch?v=SQFILNf8h-c)

# Elimination of Nonholonomic Constraints and Constraint Forces
Given $m$ nonholonomic constraints on velocities in the form $\mathbf{W}(\mathbf{q})\dot{\mathbf{q}}=0$, one can define $N-m$ generalized velocity directions $\mathbf{g}_{i}(\mathbf{q})$ that satisfy the constraints $\mathbf{W}(\mathbf{q})\mathbf{g}_{i}(\mathbf{q})=0$, for $i=1,\dots N-m$ and magnitudes ${v}_{1},\dots,{v}_{N-m}$, so that  the permissible velocity $\dot{\mathbf{q}}$ is given by:
$$\dot{\mathbf{q}}=\sum_{i=1}^{N-m} \mathbf{g}_{i}(\mathbf{q}){v}_{i}=\mathbf{S}(\mathbf{q})\mathbf{v} \tag{2.17} $$

Where $\mathbf{v}=\begin{pmatrix}{v}_{1} &\dots&{v}_{N-m} \end{pmatrix}^{T}$ and the columns of $\mathbf{S}(\mathbf{q})$ are $\mathbf{g}_{i}(\mathbf{q})$, which span the nullspace $\mathbf{W}(\mathbf{q})$, so that $\mathbf{W}(\mathbf{q})\mathbf{S}(\mathbf{q})=0_{m\times(N-m)}$. Differentiating $\text{(2.17)}$ in time gives $\ddot{\mathbf{q}}=\dot{\mathbf{S}}\mathbf{v}+\mathbf{S} \dot{\mathbf{v}}$. Substituting this into $\text{(2.12)}$ and pre-multiplying by $\mathbf{S}^{T}$ gives:
$$\mathbf{S}^{T}\mathbf{M}(\dot{\mathbf{S}}\mathbf{v}+\mathbf{S}\dot{\mathbf{v}})+\mathbf{S}^{T}\mathbf{B}(\mathbf{q},\mathbf{v})+\mathbf{S}^{T}\mathbf{G}(\mathbf{q})=\mathbf{S}^{T}\mathbf{F}_{q}$$
Note that the constraint forces $\boldsymbol{\lambda}$ have been eliminated in $\text{(2.18)}$ due to the relation $\mathbf{S}^{T}\mathbf{W}^{T}=0$. The combined equations $\text{(2.17)}$ and $\text{(2.18)}$ form state equations for the state vector $(\mathbf{q},\mathbf{v})$. That is, the system's order is reduced from $2N$ in $\text{(2.6)}$ to $2N-m$, while the unknowns of instantaneous accelerations are $\dot{\mathbf{v}}\in \mathbb{R}^{N-m}$ instead of $N+m$ instantaneous unknowns $(\ddot{\mathbf{q}},\boldsymbol{\lambda})$ in $\text{(2.6)}$. The choice of $\mathbf{g}_{i}(\mathbf{q})$ in $\text{(2.17)}$ is not unique, but one has to verify that $\mathbf{S}(\mathbf{q})$ has full rank. That is, the vectors $\mathbf{g}_{i}(\mathbf{q})$ are linearly independent for all $\mathbf{q}$.

In cases where the system satisfies additional symmetries, equation $\text{(2.18)}$ does not depend on $\mathbf{q}$, and can be analyzed independently of $\text{(2.17)}$ as state equations are in $\mathbf{v}$ only.

Revising the Chaplygin's Sleigh, since the number of DOF is $N=3$, and we have $m=1$ constraint, there are $n=N-m=2$ directions of allowed velocities $\mathbf{g}_{i}(\mathbf{q})$. The natural choice is:
1. Pure translation along $\mathbf{e}_{1}'$ axis at speed ${u}_{1}$, so that
	$$\begin{cases}
\mathbf{v}_{c}={u}_{1}\mathbf{e}_{1}' \\
\dot{\theta}=0
\end{cases}$$
2. Pure rotation about the blade $p$ at angular velocity, so that $\mathbf{v}_{c}=\mathbf{v}_{p}+\boldsymbol{\omega}\times \mathbf{r}_{pc}=b\dot{\theta}\mathbf{e}_{2}'$,

We can write:
$$\begin{aligned}
\dot{\mathbf{q}} & =\begin{pmatrix}
\cos\theta \\
\sin\theta \\
0
\end{pmatrix}{u}_{1}+\begin{pmatrix}
-b\sin\theta \\
b\cos\theta \\
1
\end{pmatrix}\dot{\theta} \\[1ex]
 & =\underbrace{ \begin{pmatrix}
\cos\theta & -b\sin\theta \\
\sin\theta & b\cos\theta \\
0 & 1
\end{pmatrix}_{N\times(N-m)} }_{ \mathbf{S}(\mathbf{q}) }\begin{pmatrix}
{u}_{1} \\
\dot{\theta}
\end{pmatrix}
\end{aligned}$$

Therefore:
$$\dot{\mathbf{S}}=\begin{pmatrix}
-\sin\theta & -b\cos\theta \\
\cos\theta & -b\sin\theta \\
0 & 1
\end{pmatrix}\dot{\theta}$$

Additionally:
$$\begin{gathered}
\dot{\mathbf{q}}=\mathbf{S}(\mathbf{q})\mathbf{v} \\
\ddot{\mathbf{q}}=\dot{\mathbf{S}}\mathbf{v}+\mathbf{S}\dot{\mathbf{v}}
\end{gathered}$$

Where the columns of $\mathbf{S}(\mathbf{q})$ are $\mathbf{g}_{i}(\mathbf{q})$ which span the nullspace of $\mathbf{W}(\mathbf{q})$, so that $\mathbf{W}(\mathbf{q})\mathbf{S}(\mathbf{q})=0_{m\times(N-m)}$. Due to this relation, we get
$$\mathbf{S}^{T}\mathbf{F}_{c}=\mathbf{S}^{T}\mathbf{W}^{T}\boldsymbol{\lambda}=(\mathbf{W}\mathbf{S})^{T}\boldsymbol{\lambda}=\mathbf{0}_{(N-m)\times 1}$$

Substituting this relation into the EOM, and pre-multiplying by $\mathbf{S}^{T}$ gives:
$$\begin{gathered}
\mathbf{S}^{T}\mathbf{M}(\dot{\mathbf{S}}\mathbf{v}+\mathbf{S}\dot{\mathbf{v}})+\cancel{ \mathbf{S}^{T}\mathbf{B}(\mathbf{v},\mathbf{q}) }+\cancel{ \mathbf{S}^{T}\mathbf{G}(\mathbf{q}) }=\cancel{ \mathbf{S}^{T}\mathbf{F}_{q} } \\[3ex]
\underbrace{ \begin{pmatrix}
m & 0 \\
0 & mb^{2}+{I}_{c}
\end{pmatrix} }_{ \mathbf{S}^{T}\mathbf{M}\mathbf{S} }\underbrace{ \begin{pmatrix}
\dot{u}_{1} \\
\ddot{\theta}
\end{pmatrix} }_{ \dot{\mathbf{v}} }+\underbrace{ \begin{pmatrix}
0 & -bm\dot{\theta} \\
bm\dot{\theta} & 0
\end{pmatrix} }_{ \mathbf{S}^{T}\mathbf{M}\dot{\mathbf{S}} }\begin{pmatrix}
{u}_{1} \\
\dot{\theta}
\end{pmatrix}=\mathbf{0} \\[3ex]
\begin{pmatrix}
\dot{u}_{1} \\
\ddot{\theta}
\end{pmatrix}=\begin{pmatrix}
0 & b\dot{\theta} \\
-\dfrac{mb\dot{\theta}}{mb^{2}+{I}_{c}} & 0
\end{pmatrix}\begin{pmatrix}
{u}_{1} \\
\dot{\theta}
\end{pmatrix}
\end{gathered}$$

The equations of motion are:
$$\begin{cases}
\dot{u}_{1}={f}_{1}(u,\omega)=b\omega ^{2} & \text{where}  & \omega:=\dot{\theta} \\
\dot{\omega}={f}_{2}(u,\omega)=-\beta {u}_{1}\omega & \text{where} & \beta:= \dfrac{mb}{mb^{2}+{I}_{c}}
\end{cases}$$
It's easy to see that the equilibrium points rest on the line $(u^{*}_{1},0)$. The Jacobian:
$$\mathbf{J}=\dfrac{ \partial \mathbf{f} }{ \partial \mathbf{v} } =\begin{pmatrix}
\dfrac{ \partial {f}_{1} }{ \partial {u}_{1} }  & \dfrac{ \partial {f}_{1} }{ \partial \omega }  \\
\dfrac{ \partial {f}_{2} }{ \partial {u}_{1} }  & \dfrac{ \partial {f}_{2} }{ \partial \omega } 
\end{pmatrix}=\begin{pmatrix}
0 & 2b\omega \\
-\beta\omega & -\beta {u}_{1}
\end{pmatrix}$$
There under equilibrium:
$$\mathbf{J}\bigg|_{(u^{*}_{1},0)}^{}=\begin{pmatrix}
0 & 0 \\
0 & -\beta {u}_{1}
\end{pmatrix} $$
We conclude that:
$$\begin{cases}
\forall u^{*}_{1}<0\implies \text{unstable} \\
\forall u^{*}_{1}>0\implies \text{stable}
\end{cases}$$
That is, the forward motion of the Sleigh is stable, while the reverse is unstable.
Note that the kinetic energy of the system is conserved, so expressing $T$ in terms of ${u}_{1},\omega$ we have:
$$\begin{aligned}
T & =\dfrac{1}{2}\dot{\mathbf{q}}^{T}\mathbf{M}\dot{\mathbf{q}} \\[1ex]
 & =\dfrac{1}{2}\mathbf{v}\mathbf{S}^{T}\mathbf{M}\mathbf{S} \mathbf{v} \\[1ex]
 & =\dfrac{1}{2}(m {{{u}_{1}}}^{2}+(mb^{2}+{I}_{c})\omega ^{2}) =\text{const} 
\end{aligned}$$
This implies that the solution trajectories move along ellipse arcs in $({u}_{1},\omega)$ plane. Each ellipse corresponds to the initial (conserved) energy level.

![[HDY1_002/chaplygin_phase_plane.png|bookhue|600]]^figure-chaplygin-phase-plane
>Phase plane of Chaplygin's Sleigh. Stable equilibria in solid red, unstable in dashed red.

Note the remarkable difference from pendulum dynamics: similar phase plane of elliptic trajectories, but here energy conservation does NOT imply marginal stability and periodic solution, a unique feature of nonholonomic system!

Physically - the  sleigh converges to pure translation along the blade's direction, such that the blade is *behind* the center of mass.