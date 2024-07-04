---
aliases:
---


# Introduction
Linear voltage versus current laws for resistors, force versus displacement laws for springs, force versus velocity laws for friction, etc., are only *approximations* to more complex nonlinear relationships.
Since linear systems are the exception rather than the rule, a more reasonable class of systems to study appear to be those defined by nonlinear differential equations of the form:
$$\begin{aligned}
\dot{\mathbf{x}}=\mathbf{f}(\mathbf{x},\mathbf{u}) &  & \mathbf{y}=\mathbf{h}(\mathbf{x},\mathbf{u})  &  & \mathbf{x} \in \mathbb{R}^{n},\, \mathbf{u}\in \mathbb{R}^{k},\, \mathbf{y}\in \mathbb{R}^{m}
\end{aligned} \tag{5.1}$$

It turns out that
1. one can establish properties of nonlinear DE's (differential equations) by analyzing state-space linear systems that approximate it.
2. one can design feedback controllers for nonlinear DE's by reducing the problem to one of designing controllers for state-space linear systems.

# Local Linearization Around an Equilibrium Point

>[!def] Definition: 
> A pair $(\mathbf{x}_{\text{eq}},\,\mathbf{u}_{\text{eq}})$ is called an **equilibrium point** of a $(5.1)$ DE if $\mathbf{f}(\mathbf{x}_{\text{eq}},\,\mathbf{u}_{\text{eq}})=0$.


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
>[!TODO] להשלים 