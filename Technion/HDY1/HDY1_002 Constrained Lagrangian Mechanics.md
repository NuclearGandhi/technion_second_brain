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
$$\mathbf{h}(\mathbf{q})=0\tag{2.1}$$
When all constraints are independent, the system's effective number of DOFs is $n=N-m$, and the system motion can, in principle, be described by a smaller set of $n=N-m$ coordinates.

Often, such formulation may be very complicated, and a $1$-to-$1$ mapping to the entire space of a system's configurations is not always possible, so the set of coordinates covers only a local sub-region of configurations. When the system's motion is described using the **unconstrained coordinates** ${q}_{1},\dots,{q}_{n}$, one should also add **constraint forces** which enforce the kinematic constraints ${h}_{j}({q}_{1},\dots,{q}_{N})=0$. Thus, the constrained equations of motion in vector form are:
$$\small\dfrac{\mathrm{d}}{\mathrm{d}t}\left( \dfrac{ \partial T }{ \partial \dot{\mathbf{q}} }  \right)-\dfrac{ \partial T }{ \partial \mathbf{q} } +\dfrac{ \partial V }{ \partial \mathbf{q} } =\mathbf{M}(\mathbf{q})\ddot{\mathbf{q}}+\mathbf{B}(\mathbf{q},\dot{\mathbf{q}})+\mathbf{G}(\mathbf{q})=\mathbf{F}_{q}+\mathbf{F}_{c} \tag{2.2}$$
Where $T(\mathbf{q},\dot{\mathbf{q}}),\,V(\mathbf{q})$ are the kinetic and potential energy of a general motion without constraints, $\mathbf{F}_{q}$ is the vector of generalized forces due to non-conservative forces, and $\mathbf{F}_{c}$ is the vector of generalized constrained forces. In order to ensure that the constraint forces do zero mechanical work, they are given as:
$$\mathbf{F}_{c}=\sum_{j=1}^{m} {\lambda}_{j}\nabla {h}_{j}(\mathbf{q}) \tag{2.3}$$
Where ${\lambda}_{j}$ are time-varying scalar magnitudes also called [[CAL2_010 נקודות אקסטרמום#כופל לגראנז'|Lagrange's multipliers]], and the direction $\nabla {h}_{j}(\mathbf{q})=\dfrac{ \partial {h}_{j} }{ \partial \mathbf{q} }$ is a gradient vector of the $j$-th scalar constraint with respect to $\mathbf{q}$. Thus, the instantaneous power of the $j$-th term of $\mathbf{F}_{c}$ in $\text{(2.3)}$ is zero:
$$\begin{aligned}
{P}_{j} & ={\lambda}_{j}\nabla {h}_{j}(\mathbf{q})\cdot \dot{\mathbf{q}} ={\lambda}_{j}\sum_{i=1}^{n} \dfrac{ \partial {h}_{j} }{ \partial {q}_{i} } \dot{q}_{i} 
 ={\lambda}_{j} \dfrac{\mathrm{d}}{\mathrm{d}t}[{h}_{j}(\mathbf{q}(t))] =0
\end{aligned}$$
Since ${h}_{j}(\mathbf{q})=0$.

In matrix form, the equation of motion with vector of constraint force magnitudes $\boldsymbol{\lambda}$ is:
$$\mathbf{M}(\mathbf{q})\ddot{\mathbf{q}}+\mathbf{B}(\mathbf{q},\dot{\mathbf{q}})+\mathbf{G}(\mathbf{q})=\mathbf{F}_{q}+\left( \dfrac{ \partial \mathbf{h} }{ \partial \mathbf{q} }  \right)^{T} \boldsymbol{\lambda}\tag{2.4}$$
Notice the last term is a matrix multiplied by a vector:
$$\underbrace{ \left( \dfrac{ \partial \mathbf{h} }{ \partial \mathbf{q} }  \right)^{T} }_{ N\times m } \underbrace{ \boldsymbol{\lambda} }_{ m\times 1 }$$

Equivalent writing as scalar equations:
$$\dfrac{\mathrm{d}}{\mathrm{d}t}\left( \dfrac{ \partial T }{ \partial \dot{q}_{i} }  \right)-\dfrac{ \partial T }{ \partial {q}_{i} } +\dfrac{ \partial V }{ \partial {q}_{i} } ={F}_{{q}_{i}}+\sum_{j=1}^{m} \dfrac{ \partial {h}_{j} }{ \partial {q}_{i} } {\lambda}_{j},\qquad i=1,\dots ,N $$

We require solving equation $\text{(2.4)}$ together with the constraints $\mathbf{h}(\mathbf{q})=0$ and find the vector $\boldsymbol{\lambda}(t)$.

Let us define
$$\mathbf{W}(\mathbf{q}):= \dfrac{ \partial \mathbf{h} }{ \partial \mathbf{q} } =\nabla \mathbf{h}(\mathbf{q}),\qquad \mathbf{W}\in \mathbb{R}^{m\times N} \tag{2.5}$$
so that $\dot{\mathbf{h}}(t)=\mathbf{W}(\mathbf{q})\dot{\mathbf{q}}$ and differentiate twice with respect to time to obtain:
$$\begin{aligned}
 & \dot{\mathbf{h}}(t)=\dfrac{ \partial \mathbf{h} }{ \partial \mathbf{q} } \dot{\mathbf{q}}=\mathbf{W}(\mathbf{q})\dot{\mathbf{q}}=0  \\[1ex]
 & \ddot{\mathbf{h}}(t)=\dot{\mathbf{W}}(\mathbf{q},\dot{\mathbf{q}}) \dot{\mathbf{q}} +\mathbf{W}(\mathbf{q})\ddot{\mathbf{q}}=0
\end{aligned}\tag{2.6}$$

Equations $\text{(2.4)}$ and $\text{(2.6)}$ can be rearranged as a system of differential-algebraic equations:
$$\begin{pmatrix}
\mathbf{M} & -\mathbf{W}^{T} \\
\mathbf{W} & 0
\end{pmatrix}\begin{pmatrix}
\ddot{\mathbf{q}} \\
\boldsymbol{\lambda}
\end{pmatrix}=\begin{pmatrix}
\mathbf{F}_{q}-\mathbf{B}-\mathbf{G} \\
-\dot{\mathbf{W}}\dot{\mathbf{q}}
\end{pmatrix} \tag{2.7}$$

Equation $\text{(2.7)}$ is a linear system suitable for numerical integration under state vector $\mathbf{z}=\begin{pmatrix}\mathbf{q} & \dot{\mathbf{q}}\end{pmatrix}^{T}$.
They form a system of $N+m$ linear equations in the unknowns $(\ddot{\mathbf{q}},\boldsymbol{\lambda})\in \mathbb{R}^{N+m}$, which can be numerically solved as a function of instantaneous configuration and velocities ($\mathbf{q},\dot{\mathbf{q}}$). If the inertia matrix $\mathbf{M}$ is non-singular (no massless links or rotating bodies with zero moment of inertia), an explicit expression for the accelerations $\ddot{\mathbf{q}}$ can be extracted from $\text{(2.4)}$ as:
$$\ddot{\mathbf{q}}=\mathbf{M}^{-1}(-\mathbf{B}-\mathbf{G}+\mathbf{F}_{q}+\mathbf{W}^{T}\boldsymbol{\lambda}) \tag{2.8}$$
And then substituted into $\text{(2.6)}$ and obtain:
$$\begin{gathered}
0=\dot{\mathbf{W}}\dot{\mathbf{q}}+\mathbf{W}\ddot{\mathbf{q}} \\[1ex]
0=\dot{\mathbf{W}}\dot{\mathbf{q}}+\mathbf{W}\mathbf{M}^{-1}(-\mathbf{B}-\mathbf{G}+\mathbf{F}_{q}+\mathbf{W}^{T}\boldsymbol{\lambda})
\end{gathered}$$

Which can rearranged as:
$$\mathbf{W}\mathbf{M}^{-1}\mathbf{W}^{T} \boldsymbol{\lambda}=\mathbf{W}\mathbf{M}^{-1}(\mathbf{B}+\mathbf{G}-\mathbf{F}_{q})-\dot{\mathbf{W}}\dot{\mathbf{q}}\tag{2.9}$$

Inverting the left-hand side matrix in $\text{(2.9)}$, the vector constraint forces magnitudes can be found as:
$$\boldsymbol{\lambda}(\mathbf{q},\dot{\mathbf{q}},t)=(\mathbf{W}\mathbf{M}^{-1}\mathbf{W}^{T})^{-1}(\mathbf{W}\mathbf{M}^{-1}(\mathbf{B}+\mathbf{G}-\mathbf{F}_{q})-\dot{\mathbf{W}}\dot{\mathbf{q}}) \tag{2.10}$$

Finally, substituting $\text{(2.10)}$ into $\text{(2.4)}$ gives a second-order ODE in $\mathbf{q}(t)$, which can be transformed into a first-order state equation for $\mathbf{z}=(\mathbf{q},\dot{\mathbf{q}},t)$.

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
>The constraint force $\boldsymbol{\lambda}(\mathbf{q},\dot{\mathbf{q}})$ can be calculated using equation $\text{(2.10)}$. Alternatively, it can be found directly from the equation of motion $\text{(2.2)}$ above for $r$, after substituting the constraint and its derivatives, $r=L,\,\dot{r}=\ddot{r}=0$, one obtains $\lambda=-mL\dot{\theta}^{2}-mg\cos\theta-{f}_{x}\sin\theta$.

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
>$$\mathbf{h}(\mathbf{q})=\mathbf{r}_{p}-x\mathbf{e}_{1}=0$$
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
> To solve $\text{(2.7)}$ we need to now:
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

