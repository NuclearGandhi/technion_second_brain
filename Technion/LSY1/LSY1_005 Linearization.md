---
aliases:
---
# Introduction
Linear voltage versus current laws for resistors, force versus displacement laws for springs, force versus velocity laws for friction, etc., are only *approximations* to more complex nonlinear relationships.
Since linear systems are the exception rather than the rule, a more reasonable class of systems to study appear to be those defined by nonlinear differential equations of the form:
$$\begin{aligned}
 & \dot{\mathbf{x}}=\mathbf{f}(\mathbf{x},\mathbf{u}) & \\
 & \mathbf{y}=\mathbf{h}(\mathbf{x},\mathbf{u}) 
\end{aligned} \qquad  \mathbf{x} \in \mathbb{R}^{n},\, \mathbf{u}\in \mathbb{R}^{k},\, \mathbf{y}\in \mathbb{R}^{m} \tag{5.1}$$

It turns out that
1. one can establish properties of nonlinear DE's (differential equations) by analyzing state-space linear systems that approximate it.
2. one can design feedback controllers for nonlinear DE's by reducing the problem to one of designing controllers for state-space linear systems.

# Local Linearization Around an Equilibrium Point

>[!def] Definition: 
> A pair $(\mathbf{x}_{\text{eq}},\,\mathbf{u}_{\text{eq}})$ is called an **equilibrium point** of
>$$\begin{aligned}
 & \dot{\mathbf{x}}=\mathbf{f}(\mathbf{x},\mathbf{u}) & \\
 & \mathbf{y}=\mathbf{h}(\mathbf{x},\mathbf{u}) 
\end{aligned} \qquad  \mathbf{x} \in \mathbb{R}^{n},\, \mathbf{u}\in \mathbb{R}^{k},\, \mathbf{y}\in \mathbb{R}^{m}$$
>  if $\mathbf{f}(\mathbf{x}_{\text{eq}},\,\mathbf{u}_{\text{eq}})=0$.

In this case
 $$\begin{aligned}
\mathbf{u}(t)=\mathbf{u}_{\text{eq}} &  & \mathbf{x}(t)=\mathbf{x}_{\text{eq}} &  & \mathbf{y}(t)=\mathbf{y}_{\text{eq}}=\mathbf{h}(\mathbf{x}_{\text{eq}},\, \mathbf{u}_{\text{eq}}),\,  &  & \forall t\geq  0
\end{aligned}$$
is a solution to the $(5.1)$.

Suppose now that we apply to $(5.1)$ an input
$$\begin{aligned}
u(t)=u_{\text{eq}}+\delta u(t) &  & \forall t\geq  0
\end{aligned}$$
that is close but not equal to $\mathbf{u}_{\text{eq}}$ and that the initial condition
$$\mathbf{x}(0)=\mathbf{x}_{\text{eq}}+\delta\mathbf{x}_{\text{eq}}$$
is close but not quite equal to $\mathbf{x}_{\text{eq}}$. Then the corresponding output $\mathbf{y}(t)$ to $(5.1)$ will be close but not equal to $\mathbf{y}_{\text{eq}}=\mathbf{h}(\mathbf{x}_{\text{eq}},\,\mathbf{u}_{\text{eq}})$. To investigate hot much $\mathbf{x}(t)$ and $\mathbf{y}(t)$ are perturbed by $\delta \mathbf{u}(\cdot)$ and $\delta \mathbf{x}_{\text{eq}}$, we define
$$\begin{aligned}
\delta\mathbf{x}(t)=\mathbf{x}(t)-\mathbf{x}_{\text{eq}} &  & \delta \mathbf{y}(t)=\mathbf{y}(t)-\mathbf{y}_{\text{eq}} &  & \forall t\geq  0
\end{aligned}$$
and use $(5.1)$ to conclude that
$$\begin{aligned}
\delta \mathbf{y}=\mathbf{h}(\mathbf{x},\, \mathbf{u})-\mathbf{y}_{\text{eq}}=\mathbf{h}(\mathbf{x}_{\text{eq}}+\delta \mathbf{x},\, \mathbf{u}_{\text{eq}}+\delta \mathbf{u})-\mathbf{h}(\mathbf{x}_{\text{eq}},\, \mathbf{u}_{\text{eq}})
\end{aligned}$$
Expanding $\mathbf{h}(\cdot)$ as a [[../CAL2/CAL2_008 טיילור 2.0#טיילור של פונקציה בשני משתנים|Taylor]] series around $(\mathbf{x}_{\text{eq}},\,\mathbf{u}_{\text{eq}})$, we obtain
$$\delta \mathbf{y}=\dfrac{ \partial \mathbf{h}(\mathbf{x}_{\text{eq}},\, \mathbf{u}_{\text{eq}}) }{ \partial \mathbf{x} } \delta \mathbf{x}+\dfrac{ \partial \mathbf{h}(\mathbf{x}_{\text{eq}},\, \mathbf{u}_{\text{eq}}) }{ \partial \mathbf{u} }\delta\mathbf{u}+\mathcal{O}(\lVert \delta\mathbf{x} \rVert ^{2}) + \mathcal{O}(\lVert \delta\mathbf{u} \rVert ^{2}) $$
where the partial derivatives are actually the [[../CAL2/CAL2_011 אינטגרל רב מימדי#מטריצת היעקוביאן|Jacobian]] of the corresponding vector:
$$\begin{aligned}
 & \dfrac{ \partial \mathbf{h}(\mathbf{x},\mathbf{u}) }{ \partial \mathbf{x} } :=\left[ \left( \dfrac{ \partial h_{i}(\mathbf{x},\mathbf{u}) }{ \partial x_{j}}  \right)_{ij} \right]\in \mathbb{R}^{m\times n} \\[2ex]
  & \dfrac{ \partial \mathbf{h}(\mathbf{x},\, \mathbf{u})\ }{ \partial \mathbf{u} } :=\left[ \left( \dfrac{ \partial h_{i}(\mathbf{x},\mathbf{u}) }{ \partial u_{j} }  \right)_{ij} \right]\in \mathbb{R}^{m\times k}
\end{aligned}$$
To determine the evolution of $\delta \mathbf{x}$, we take it time derivative
$$(\dot{\delta \mathbf{x}})=\dot{\mathbf{x}}=\mathbf{f}(\mathbf{x},\, \mathbf{u})=\mathbf{f}(\mathbf{x}_{\text{eq}}+\delta \mathbf{x},\, \mathbf{u}_{\text{eq}}+\delta\mathbf{u})$$
and also expand $f(\cdot)$ as a Taylor series around $(\mathbf{x}_{\text{eq}},\,\mathbf{u}_{\text{eq}})$, which yields
$$\dot{(\delta \mathbf{x})}=\dfrac{ \partial \mathbf{f}(\mathbf{x}_{\text{eq}},\mathbf{u}_{\text{eq}}) }{ \partial \mathbf{x} }\delta\mathbf{x}+\dfrac{ \partial \mathbf{h}(\mathbf{x}_{\text{eq}},u_{\text{eq}}) }{ \partial \mathbf{u} }\delta\mathbf{u}+\mathcal{O}(\lVert \delta \mathbf{x} \rVert ^{2})+\mathcal{O}(\lVert \delta\mathbf{u} \rVert ^{2})  $$
By dropping all but the first-order terms, we obtain a **local linearization of $(5.1)$ around an equilibrium point**.

>[!def] Definition: 
> The LTI system
> $$\begin{aligned}
>  & \dot{(\delta \mathbf{x})}=\mathbf{A}\delta \mathbf{x}+\mathbf{B}\delta \mathbf{u} \\[1ex]
>  & \dot{(\delta \mathbf{y})}=\mathbf{C}\delta \mathbf{x}+\mathbf{D}\delta \mathbf{u}
> \end{aligned}$$
> 
> defined by the following Jacobian matrices
> $$\begin{aligned}
>  & \mathbf{A}=\dfrac{ \partial \mathbf{f}(\mathbf{x}_{\text{eq}}, \mathbf{u}_{\text{eq}}) }{ \partial \mathbf{x} } &  & \mathbf{B}=\dfrac{ \partial \mathbf{f}(\mathbf{x}_{\text{eq}}, \mathbf{u}_{\text{eq}})}{ \partial x }   &  & \mathbf{C}=\dfrac{ \partial \mathbf{h}(\mathbf{x}_{\text{eq}},\, \mathbf{u}_{\text{eq}}) }{ \partial \mathbf{x} } &  & \mathbf{D}=\dfrac{ \partial \mathbf{h}(\mathbf{x}_{\text{eq}}, \mathbf{u}_{\text{eq}}) }{ \partial \mathbf{u} }  
> \end{aligned}$$
> is called the **local linearization** of
> $$\begin{aligned}
>  & \dot{\mathbf{x}}=\mathbf{f}(\mathbf{x},\mathbf{u}) & \\
>  & \mathbf{y}=\mathbf{h}(\mathbf{x},\mathbf{u}) 
> \end{aligned} \qquad  \mathbf{x} \in \mathbb{R}^{n},\, \mathbf{u}\in \mathbb{R}^{k},\, \mathbf{y}\in \mathbb{R}^{m}$$
> around equilibrium point $(\mathbf{x}_{\text{eq}},\,\mathbf{u}_{\text{eq}})$.
> 

![[LSY1_005/Pasted image 20240704162910.png|book]]
>Nonlinear system (a) and its local approximation (b) obtained from a local linearization.


>[!example] Example: 
> The following mass-spring-damper system
> ![[Screenshot_20240705_134757_Samsung Notes.jpg|book]]
> [](LSY1_005/Screenshot_20240705_134757_Samsung%20Notes.jpg)ss)
> $$\begin{aligned}
>  & {m}_{1}\ddot{y}_{1}(t)+({c}_{1}+{c}_{2})\dot{y}_{1}(t)-{c}_{2}\dot{y}_{2}(t)+({k}_{1}+{k}_{2}){y}_{1}(t)-{k}_{2}{y}_{2}(t)=-{k}_{2}\xi \\[1ex]
>  & {m}_{2}\ddot{y}_{2}(t)-{c}_{2}\dot{y}_{1}(t)+{c}_{2}\dot{y}_{2}(t)-{k}_{2}{y}_{1}(t)+{k}_{2}{y}_{2}(t)=u(t)+{k}_{2}\xi
> \end{aligned}$$
> assuming zero spring and damper forces ${y}_{1}=0$ and ${y}_{2}=\xi$.
> 
> Define
> $${\mathbf{x}}=\begin{pmatrix}
> {y}_{1} \\
> {y}_{2} \\
> \dot{y}_{1} \\
> \dot{y}_{2}
> \end{pmatrix}$$
> we get:
> $$\begin{aligned}
>  & {m}_{1}\dot{x}_{3}+({c}_{1}+{c}_{2}){x}_{3}-{c}_{2}{x}_{4}+({k}_{1}+{k}_{2}){x}_{1}-{k}_{2}{x}_{2}=-{k}_{2}\xi \\[1ex]
>  & {m}_{2}\dot{x}_{4}-{c}_{2}{x}_{3}+{c}_{2}{x}_{4}-{k}_{2}{x}_{1}+{k}_{2}{x}_{2}=u+{k}_{2}\xi
> \end{aligned}$$
> Reorganizing, we get:
> $$\begin{aligned}
>  & {m}_{1}\dot{x}_{3}=-({c}_{1}+{c}_{2}){x}_{3}+{c}_{2}{x}_{4}-({k}_{1}+{k}_{2}){x}_{1}+{k}_{2}{x}_{2}-{k}_{2}\xi \\[1ex]
>  & {m}_{2}\dot{x}_{4}={c}_{2}{x}_{3}-{c}_{2}{x}_{4}+{k}_{2}{x}_{1}-{k}_{2}{x}_{2}+u+{k}_{2}\xi
> \end{aligned}$$
> Knowing that $\dot{x}_{1}={x}_{3}$ and $\dot{x}_{2}={x}_{4}$, we can now write in the matrix form:
> $$\begin{pmatrix}
> 1 & 0 & 0 & 0 \\
> 0 & 1 & 0 & 0 \\
> 0 & 0 & {m}_{1} & 0 \\
> 0 & 0 & 0 & {m}_{2}
> \end{pmatrix}\dot{\mathbf{x}}=\begin{pmatrix}
> {x}_{3} \\
> {x}_{4} \\
> -({c}_{1}+{c}_{2}){x}_{3}+{c}_{2}{x}_{4}-({k}_{1}+{k}_{2}){x}_{1}+{k}_{2}{x}_{2}-{k}_{2}\xi \\
> {c}_{2}{x}_{3}-{c}_{2}{x}_{4}+{k}_{2}{x}_{1}-{k}_{2}{x}_{2}+u+{k}_{2}\xi
> \end{pmatrix}$$
> Also, not forgetting
> $$\mathbf{y}=\begin{pmatrix}
> {x}_{1} \\
> {x}_{2}
> \end{pmatrix}$$
> In a nonlinear state-space representation $(5.1)$, we can see that:
> $$\begin{aligned}
>  & \mathbf{f}(\mathbf{x},\, u)=\begin{pmatrix}
> 1 & 0 & 0 & 0 \\
> 0 & 1 & 0 & 0 \\
> 0 & 0 & {m}_{1} & 0 \\
> 0 & 0 & 0 & {m}_{2}
> \end{pmatrix}^{-1}\begin{pmatrix}
> {x}_{3} \\
> {x}_{4} \\
> -({c}_{1}+{c}_{2}){x}_{3}+{c}_{2}{x}_{4}-({k}_{1}+{k}_{2}){x}_{1}+{k}_{2}{x}_{2}-{k}_{2}\xi \\
> {c}_{2}{x}_{3}-{c}_{2}{x}_{4}+{k}_{2}{x}_{1}-{k}_{2}{x}_{2}+u+{k}_{2}\xi
> \end{pmatrix} \\[2ex]
>  & \mathbf{h}(\mathbf{x},\, {u})=\begin{pmatrix}
> {x}_{1} \\
> {x}_{2}
> \end{pmatrix}
> \end{aligned}$$
> 
> To linearize the system, we first need to find equilibrium points - points $(\mathbf{x}_{\text{eq}},u_{\text{eq}})$ that sastisfy $\mathbf{f}(\mathbf{x}_{\text{eq}},\,u_{\text{eq}})=\mathbf{0}$. Solving, we get 2 equations in 3 variables, hence
> $$\mathbf{x}_{\text{eq}}=\begin{pmatrix}
> u_{\text{eq}}/{k}_{1} \\
> (1/{k}_{1}+1/{k}_{2})u_{\text{eq}}+\xi \\
> 0 \\
> 0
> \end{pmatrix}$$
> for every $u_{\text{eq}}\in \mathbb{R}$.
> Derivatives (Jacobians):
> $$\begin{aligned}
>  & \mathbf{A}=\dfrac{ \partial \mathbf{f} }{ \partial \mathbf{x} } =\begin{pmatrix}
> 1 & 0 & 0 & 0 \\
> 0 & 1 & 0 & 0 \\
> 0 & 0 & {m}_{1} & 0 \\
> 0 & 0 & 0 & {m}_{2}
> \end{pmatrix}^{-1}\begin{pmatrix}
> 0 & 0 & 1 & 0 \\
> 0 & 0 & 0 & 1 \\
> -{k}_{1}-{k}_{2} & {k}_{2} & -{c}_{1}-{c}_{2} & {c}_{2} \\
> {k}_{2} & -{k}_{2} & {c}_{2} & -{c}_{2}
> \end{pmatrix} \\[2ex]
>  & \mathbf{B}=\dfrac{ \partial \mathbf{f} }{ \partial u } =\begin{pmatrix}
> 1 & 0 & 0 & 0 \\
> 0 & 1 & 0 & 0 \\
> 0 & 0 & {m}_{1} & 0 \\
> 0 & 0 & 0 & {m}_{2}
> \end{pmatrix}^{-1}\begin{pmatrix}
> 0 \\
> 0 \\
> 0 \\
> 1
> \end{pmatrix} \\[2ex]
>  & \mathbf{C}=\dfrac{ \partial \mathbf{h} }{ \partial \mathbf{x} } =\begin{pmatrix}
> 1 & 0 & 0 & 0 \\
> 0 & 1 & 0 & 0
> \end{pmatrix} \\[2ex]
>  & D=\dfrac{ \partial \mathbf{h} }{ \partial u } =0
> \end{aligned}$$
> 
> Defining
> $$\begin{aligned}
> \delta \mathbf{x}=\mathbf{x}(t)-\mathbf{x}_{\text{eq}} &  & \delta u=u(t)-u_{\text{eq}}
> \end{aligned}$$
> the linearization of the system is given by
> $$\begin{aligned}
>  & \dot{(\delta \mathbf{x})}(t)=\begin{pmatrix}
> 0 & 0 & 1 & 0 \\
> 0 & 0 & 0 & 1 \\
> -({k}_{1}+{k}_{2})/{m}_{1} & {k}_{2}/{m}_{1} & -({c}_{1}+{c}_{2})/{m}_{1} &  {c}_{2}/{m}_{1} \\
> {k}_{2}/{m}_{2} & -{k}_{2}/{m}_{2} & {c}_{2}/{m}_{2} & -{c}_{2}/{m}_{2}
> \end{pmatrix}\delta \mathbf{x}(t)+\begin{pmatrix}
> 0 \\
> 0 \\
> 0 \\
> 1/{m}_{2}
> \end{pmatrix}\delta u(t) \\[2ex]
>  & \delta \mathbf{y}(t)=\begin{pmatrix}
> 1 & 0 & 0 & 0 \\
> 0 & 1 & 0 & 0
> \end{pmatrix}\delta \mathbf{x}(t)
> \end{aligned}$$
> Because the derivatives (Jacobians) are all independent of $\mathbf{x}$ and $u$, the higher derivatives are zero, and the first-order Taylor expansion is accurate. Hence, the linearization of the system is an accurate linear decsription of the mass-spring-damper system.


# Exercises

## Question 1
Consider the system shown in the following figure:

![[LSY1_005/Screenshot_20240705_145613_Samsung Notes.jpg|bookhue]]
>Seesaw system

We will take the following parameters:
$$\begin{aligned}
 & a=b=\pu{1m} &  & g=\pu{10m.s^{-2}} \\[1ex]
 & {k}_{1}={k}_{2}=\pu{6N.m^{-1}} \\[1ex]
 & {c}_{1}=\pu{7N.s.m^{-1}} &  & {c}_{2}=\pu{8N.s.m^{-1}} \\[1ex]
 & {m}_{1}=\pu{1kg} &  & {m}_{2}=\pu{2kg}
\end{aligned}$$

Assuming that the spring and dampers only elongate vertically, it can be shown that the dynamics are given by the following second order differential equation:
$$\ddot{\theta}=\dfrac{1}{6}F\cos\theta-2\sin 2\theta-5\dot{\theta}\cos ^{2}\theta-\dfrac{10}{3}\cos\theta$$

## Part a
Rewrite the dynamics in the following form:
$$\begin{aligned}
  &  \dot{\mathbf{x}}(t)=\mathbf{f}(\mathbf{x}(t),\, u(t)) \\[1ex]
   & y(t)={h}(\mathbf{x}(t),\, u(t))
\end{aligned}$$
with $\mathbf{x}=\begin{pmatrix}{x}_{1}\\{x}_{2}\end{pmatrix}=\begin{pmatrix}\theta\\\dot{\theta}\end{pmatrix}$, $u=F$, and ${y}=\theta$.

**Solution**:
Substituting $\mathbf{x}$ into the second-order ODE:
$$\dot{x}_{2}=\dfrac{1}{6}u\cos {x}_{1}-2\sin (2{x}_{1})-5{x}_{2}\cos ^{2}{x}_{1}-\dfrac{10}{3}\cos {x}_{1}$$
In matrix form:
$$\begin{pmatrix}
1 & 0 \\
0 & 1
\end{pmatrix}\dot{\mathbf{x}}=\begin{pmatrix}
{x}_{2} \\
(1/6)u\cos {x}_{1}-2\sin(2{x}_{1})-5{x}_{2}\cos ^{2}{x}_{1}-(10/3)\cos {x}_{1}
\end{pmatrix}$$
Not forgetting:
$$y={x}_{1}=\begin{pmatrix}
1 & 0
\end{pmatrix}\mathbf{x}$$
Therefore, we get:
$$\boxed{\begin{aligned}
 & \dot{\mathbf{x}}=\begin{pmatrix}
{x}_{2} \\
(1/6)u\cos {x}_{1}-2\sin(2{x}_{1})-5{x}_{2}\cos ^{2}{x}_{1}-(10/3)\cos {x}_{1}
\end{pmatrix} \\[1ex]
 & y=\begin{pmatrix}
1 & 0
\end{pmatrix}\mathbf{x}
\end{aligned} }$$


### Part b
Find $u_{\text{eq}}$ such that $x_{\text{eq}}=\begin{pmatrix}0\\0\end{pmatrix}$ is an equilibrium point.

**Solution**:
Zeroing $\mathbf{f}$:
$$\begin{pmatrix}
0 \\
0
\end{pmatrix}=\begin{pmatrix}
{x}_{2} \\
(1/6)u\cos {x}_{1}-2\sin(2{x}_{1})-5{x}_{2}\cos ^{2}{x}_{1}-(10/3)\cos {x}_{1}
\end{pmatrix}$$
Substituting ${x}_{2}=0$ into the second term, we get:
$$0=\dfrac{1}{6}u\cos {x}_{1}-2\sin(2{x}_{1})-\dfrac{10}{3}\cos {x}_{1}$$
We want to find $u_{\text{eq}}$ for $\mathbf{x}_{\text{eq}}=\begin{pmatrix}0\\0\end{pmatrix}$, therefore:
$$\begin{gathered}
0=\dfrac{1}{6}u_{\text{eq}}-\dfrac{10}{3} \\[1ex]
\boxed {
u_{\text{eq}}=\pu{20N}
 }
\end{gathered}$$

### Part c
Linearize the system around this equilibrium point.

**Solution**:
Derivatives:
$$\begin{aligned}
 & \mathbf{A}=\dfrac{ \partial \mathbf{f} }{ \partial \mathbf{x} } =\begin{pmatrix}
0 & 1\\
-(1/6)u\sin {x}_{1}-4\cos {x}_{1}+5{x}_{2}\sin 2{x}_{1}+(10/3)\sin {x}_{1} & -5\cos ^{2}{x}_{1}
\end{pmatrix} \\[2ex]
 &\mathbf{B}=\dfrac{ \partial \mathbf{f} }{ \partial u } =\begin{pmatrix}
0 \\
(1/6)\cos {x}_{1}
\end{pmatrix} \\[2ex]
 & \mathbf{C}=\dfrac{ \partial \mathbf{h} }{ \partial \mathbf{x} } = \begin{pmatrix}
0 & 1
\end{pmatrix} \\[2ex]
 & D=\dfrac{ \partial \mathbf{h} }{ \partial u } =0
\end{aligned}$$
Substituting the equilibrium point, and
$$\begin{aligned}
\delta \mathbf{x}=\mathbf{x}-\mathbf{x}_{\text{eq}} &  & \delta u=u-u_{\text{eq}}
\end{aligned}$$
we get:
$$\boxed {
\begin{aligned}
 & \dot{(\delta\mathbf{x})}(t)=\begin{pmatrix}
0 & 1 \\
-4 & -5
\end{pmatrix}\delta\mathbf{x}(t)+\begin{pmatrix}
0 \\
1/6
\end{pmatrix}\delta u(t) \\[2ex]
 & \delta y(t)=\begin{pmatrix}
0 & 1
\end{pmatrix}\delta\mathbf{x}(t)
\end{aligned}
 }$$

## Question 2
Consider the tank system shown in the following figure:
![[LSY1_005/Screenshot_20240705_161516_Obsidian.jpg|book|300]]
>Tank system

The state of the system is given by the height of the liquid level $y$. The flow rate of the entering liquid is $q_{\text{in}}$ and the flow of the exiting liquid is $q_{\text{out}}$. The dynamics are given by the equation
$$\begin{aligned}
 & q_{\text{out}}=R\sqrt{ y(t) } \\[1ex]
 & \dot{y}(t)=\dfrac{1}{S}(q_{\text{in}}(t)-q_{\text{out}}(t))
\end{aligned}$$
with $S$ being the cross-sectional area of the tank and $R$ being the resistance coefficient of the outlet.

### Part a
Rewrite the dynamics in the following form
$$\begin{aligned}
  &  \dot{x}(t)={f}({x}(t),\, u(t)) \\[1ex]
   & y(t)=h(x(t),\, u(t))
\end{aligned}$$
with $x=y$ and $u=q_{\text{in}}$

**Solution**:
Substituting $x$ and $u$ into the first-order ODE, we get:
$$\dot{x}=\dfrac{1}{S}(u-R\sqrt{ x })$$
Therefore:
$$\boxed {
\begin{aligned}
 & \dot{x}(t)=\dfrac{1}{S}(u(t)-R\sqrt{ x(t) }) \\[1ex]
 & y(t)=x(t)
\end{aligned}
 }$$

### Part b
Find all the equilibrium points $(x_{\text{eq}},\,u_{\text{eq}})$ of the system.

**Solution**:
Zeroing $f$, we get:
$$\begin{gathered}
0=\dfrac{1}{S}u-\dfrac{R}{S}\sqrt{ x } \\[1ex]
u=R\sqrt{ x } \\[1ex]
x=\dfrac{u^{2}}{R^{2}}
\end{gathered}$$
Hence, all the equilibrium points are given by
$$\begin{aligned}
\left( \dfrac{{u_{\text{eq}}}^{2}}{R^{2}},\, u_{\text{eq}} \right) &  & u_{\text{eq}}>0
\end{aligned}$$
where the condition $u_{\text{eq}}>0$ comes from the fact that $\sqrt{ x }$ isn't continuos and differentiable at $x\leq 0$.

### Part c
Linearize the system around the equilibrium point corresponding to $q_{\text{in}}=1$.

**Solution**:
The equilibrium point in this case:
$$(x_{\text{eq}},u_{\text{eq}})=\left( \dfrac{1}{R^{2}},\, 1 \right)$$
Derivatives:
$$\begin{aligned}
 & A=\dfrac{ \partial {f} }{ \partial x }=-
\dfrac{R}{S} \dfrac{1}{2\sqrt{ x }} \\[1ex]
 & B=\dfrac{ \partial f }{ \partial u } =\dfrac{1}{S} \\[1ex]
 & C=\dfrac{ \partial h }{ \partial x } =1 \\[1ex]
 & D=\dfrac{ \partial h }{ \partial u } =0
\end{aligned}$$
Substituting the equilibrium point, and
$$\begin{aligned}
\delta \mathbf{x}=\mathbf{x}-\mathbf{x}_{\text{eq}} &  & \delta u=u-u_{\text{eq}}
\end{aligned}$$
we get:
$$\boxed {
\begin{aligned}
 & \dot{(\delta x)}(t)=-\dfrac{R^{2}}{2S}\delta x(t)+\dfrac{1}{S}\delta u(t) \\[1ex]
 & \delta y(t)= \delta x(t)
\end{aligned}
 }$$
### Part d
Find the transfer function of the linearized system.

**Solution**:
According to [[LSY1_004 Linear State-Space Equation#State Space to Transfer Function|state space to transfer function]]:
$$G(s)=C(sI-A)^{-1}B+D$$
In our case:
$$\begin{gathered}
G(s)=\dfrac{1}{S}\left( s+\dfrac{R^{2}}{2S} \right)^{-1} \\[1ex]
\boxed{G(s)=\dfrac{1}{S} \dfrac{2S}{2Ss+R^{2}} }
\end{gathered}$$

## Question 3
Consider the following magentic lebitation system shown in:
![[Screenshot_20240720_100525_Samsung Notes.jpg|book|300]]
>Magnetic levitation system

The current $i$ running through a coil, having resistance $R$ and inductance $L$, creates a magnetic field, which attracts an iron ball of mass $m$. The electromagnetic force applied by the magnetic field to the ball is
$$F_{m}(t)=\alpha \dfrac{i^{2}(t)}{y^{2}(t)}$$
where $y$ given the position of the ball, and $\alpha>0$ is constant. The ball is also subject to gravity, and the force of gravity is given by:
$$F_{g}(t)=mg$$
The dynamics of the electric RL circuit are:
$$\dfrac{\mathrm{d}}{\mathrm{d}t}(Li(t))+Ri(t)=v(t)$$
### Part a
Rewrite the dynamics in the form
$$\begin{cases}
\dot{\mathbf{x}}(t)=f(x(t),u(t)) \\
y(t)=h(x(t),u(t))
\end{cases}$$
with $\mathbf{x}=\begin{pmatrix}y\\\dot{y}\\i\end{pmatrix},\,u=v,\,y=y$.

**Solution**:
The dynamics of the ball must satisfy Newton's second law:
$$\begin{aligned}
m\ddot{y} & =-F_{m}+F_{g} \\[1ex]
 & =-mg+\alpha \dfrac{i^{2}}{y^{2}}
\end{aligned}$$
The dyamics of the RL circuit must also satisfy:
$$\dfrac{\mathrm{d}}{\mathrm{d}t}(Li)+Ri=v$$

substituting $\mathbf{x}=\begin{pmatrix}y\\\dot{y}\\i\end{pmatrix},\,u=v,\,y=y$:
$$\begin{aligned}
 & {\dot{x}}_{1}={x}_{2}  \\[1ex]
& m\dot{x}_{2}=-mg+ \dfrac{{{x}_{3}}^{2}}{{{x}_{1}}^{2}} \\[1ex]
 & L\dot{x}_{3}+R{x}_{3}=u
\end{aligned}$$
In matrix form:
$$\begin{pmatrix}
\dot{x}_{1} \\[1ex]
\dot{x}_{2} \\[1ex]
\dot{x}_{3}
\end{pmatrix}=\begin{pmatrix}
{x}_{2} \\[1ex]
-g+({{{x}_{3}}^{2}})/({{m{x}_{1}}^{2}}) \\[1ex]
{(u-R{x}_{3})}/{L}
\end{pmatrix}$$