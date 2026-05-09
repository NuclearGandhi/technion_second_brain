---
aliases:
---
# Distributed Systems and Beam Theory
In [[MCS1_001 מבוא|the introductory course]], we analyzed microsystems using lumped-parameter models. That is, models in which we simply had a spring stiffness $k$, a parallel-plate capacitor with gap $g$, and a single degree of freedom $x$. The problem with these models is that they assume that the entire structure deforms uniformly.

Real MEMS beams, however, are **distributed systems** with infinitely many degrees of freedom. The deflection $y(x)$ varies continuously along the beam, and the electrostatic pressure $q(x)$ acting on it depends on the local gap, which itself depends on the local deflection. To model this coupling faithfully, we must solve a boundary-value problem rather than a single algebraic equation.

## Euler-Bernoulli Beam Theory
As developed in [[MCS1_003 לינאריות קורה בכפיפה|beam bending theory]], the Euler-Bernoulli assumption relates the bending moment $M(x)$ at a cross-section to the local curvature $\kappa$ through:
$$\dfrac{1}{\rho(x)}=\kappa(x)=\dfrac{M(x)}{EI}\tag{1.1}$$

where $E$ is Young's modulus, $I$ is the second moment of the beam cross-section, and $\rho$ is the radius of curvature. The exact curvature for an inextensible beam is:
$$\kappa=\dfrac{1}{\rho}=\dfrac{\mathrm{d}\theta}{\mathrm{d}s}$$
where $\theta$ is the rotation angle of the beam centerline and $s$ is the arc-length coordinate along the beam. For large rotation angles, the governing equation becomes the **Elastica equation**:

$$EI \dfrac{\mathrm{d}\theta}{\mathrm{d}s}=M(s)\tag{1.2}$$

In most practical cases, the curvature can be approximated as:
$$\kappa=\dfrac{1}{\rho}=\dfrac{y''}{[1+(y')^{2}]^{3/2}}$$
This expression is essentially a change of coordinates: in $(s,\theta)$ coordinates one can describe beam shapes - such as beams that loop over themselves - that cannot be expressed as a single-valued function $y(x)$.

For small slopes (where $\lvert y' \rvert<0.1$, as discussed in [[MCS1_003 לינאריות קורה בכפיפה#לינאריות מכנית של קורה שלוחה|mechanical linearity of a cantilever]]), this simplifies to:

$$\kappa\approx y''\tag{1.3}$$

## Deriving the Beam Equation
Consider a beam of length $L$ with flexural rigidity $EI$, subjected to a distributed load $q(x)$ and a point load $P$ at its tip. The bending moment at position $x$ can be written as:
$$EIy''(x)=P(L-x)+\int_{x}^{L} q(\xi)(\xi-x) \, \mathrm{d}\xi \tag{1.4}$$
This expression states that the moment at $x$ equals the contribution from the point load (force $P$ times lever arm $L-x$) plus the integrated contribution of the distributed load.
Differentiating once with respect to $x$ yields the shear force:
$$EIy'''(x)=-P-\int_{x}^{L} q(\xi) \, \mathrm{d}\xi\tag{1.5} $$
where we applied the [[CAL1_008 אינטגרל מסוים#נוסחת ניוטון-לייבניץ|Newton-Leibniz rule]]. Differentiating once more gives the known fourth-order beam equation:
$$EIy''''(x)=q(x)\tag{1.6}$$
This is the fundamental governing equation for static beam deflection under distributed loading. For an electrostatic actuator, $q(x)$ is the electrostatic pressure, which itself depends on $y(x)$, making the problem nonlinear.

# Finite Difference Approximation
To solve the beam equation numerically, we discretize the beam into equally spaced nodes separated by distance $h$, and approximate the derivatives using [[NUM1_010 גזירה נומרית#פיתוח שיטות בעזרת טור טיילור|finite differences]].

## Symmetric (Central) Differences
We start from the Taylor expansions of $y$ at neighboring nodes about ${y}_{i}$:
$$\begin{aligned}
y_{i+1} &= y_{i} + h\,y'_{i} + \dfrac{h^{2}}{2}y''_{i} + \dfrac{h^{3}}{6}y'''_{i} + \dfrac{h^{4}}{24}y''''_{i} + \cdots \\[1ex]
y_{i-1} &= y_{i} - h\,y'_{i} + \dfrac{h^{2}}{2}y''_{i} - \dfrac{h^{3}}{6}y'''_{i} + \dfrac{h^{4}}{24}y''''_{i} - \cdots \\[1ex]
y_{i+2} &= y_{i} + 2h\,y'_{i} + 2h^{2}y''_{i} + \dfrac{4h^{3}}{3}y'''_{i} + \dfrac{2h^{4}}{3}y''''_{i} + \cdots \\[1ex]
y_{i-2} &= y_{i} - 2h\,y'_{i} + 2h^{2}y''_{i} - \dfrac{4h^{3}}{3}y'''_{i} + \dfrac{2h^{4}}{3}y''''_{i} - \cdots
\end{aligned}$$

By rearranging these expressions one can obtain the central difference formulas. These provide second-order accuracy $\mathcal{O}(h^{2})$ for derivatives at node $i$:
$$\begin{align}
 & y'_{i}\approx \dfrac{y_{i+1}-y_{i-1}}{2h}+\mathcal{O}(h^{2}) \tag{1.7} \\[1ex]
 & y''_{i}\approx \dfrac{y_{i-1}-2y_{i}+y_{i+1}}{h^{2}}+\mathcal{O}(h^{2}) \tag{1.8} \\[1ex]
 & y'''_{i}\approx \dfrac{-y_{i-2}+2y_{i-1}-2y_{i+1}+y_{i+2}}{2h^{3}}+\mathcal{O}(h^{2}) \tag{1.9} \\[1ex]
 & y''''_{i}\approx \dfrac{y_{i-2}-4y_{i-1}+6y_{i}-4y_{i+1}+y_{i+2}}{h^{4}}+\mathcal{O}(h^{2}) \tag{1.10}
\end{align}$$

Looking at $\text{(1.10)}$, we see that the coefficients that multiply the nodal values are $[1,-4,6,-4,1]$. This array is called a **stencil**. Different order-of-accuracy and different finite differences methods have different stencils. It is these stencils that repeat themselves later in the numerical calculation and define the shape of the matrices.

## Backward (One-Sided) Differences

At boundaries where central differences cannot be applied (because nodes to one side do not exist), we resort to backward differences. These are also $\mathcal{O}(h^{2})$ but use only nodes on one side:

$$\begin{align}
 & y'_{i}\approx \dfrac{3y_{i}-4y_{i-1}+y_{i-2}}{2h}+\mathcal{O}(h^{2}) \tag{1.11} \\[1ex]
 & y''_{i}\approx \dfrac{-y_{i-3}+4y_{i-2}-5y_{i-1}+2y_{i}}{h^{2}}+\mathcal{O}(h^{2}) \tag{1.12} \\[1ex]
 & y'''_{i}\approx \dfrac{-5y_{i-4}+18y_{i-3}-24y_{i-2}+14y_{i-1}-3y_{i}}{2h^{3}}+\mathcal{O}(h^{2}) \tag{1.13} \\[1ex]
 & y''''_{i}\approx \dfrac{3y_{i-5}-14y_{i-4}+26y_{i-3}-24y_{i-2}+11y_{i-1}-2y_{i}}{h^{4}}+\mathcal{O}(h^{2}) \tag{1.14}
\end{align}$$
# The Clamped-Clamped Beam Actuator

We now apply the beam theory to a clamped-clamped beam suspended above a fixed electrode, with an initial gap $g$ between them.

![[MCS2_001 DIPIE 2026-04-15 22.39.28.excalidraw.svg]]^figure-clamped-clamped-actuator
>Clamped-clamped beam actuator system


When voltage $V$ is applied between the beam and the electrode, an electrostatic pressure develops that pulls the beam downward.

The governing equation couples the mechanical beam equation with the electrostatic pressure:
$$EIy''''(x)=\dfrac{1}{2} \dfrac{{\varepsilon}_{0}b}{(g-y)^{2}}V^{2}\tag{1.15}$$

where $b$ is the beam width (into the page), $g$ is the initial gap, and $y(x)$ is the beam deflection toward the electrode. The right-hand side is the electrostatic pressure from a parallel-plate capacitor model applied locally - at each point $x$, the gap is $g-y(x)$, and the local pressure is $\dfrac{1}{2}{\varepsilon}_{0}E^{2}_{\text{field}}\cdot b$ where ${E}_{\text{field}}=V/(g-y)$.

Moving to dimensionless variables, we define:
$$\tilde{x}:=x/L,\qquad \tilde{y}=y/g$$

For a rectangular cross-section with width $b$ and thickness $t$ we have $I=bt^{3}/12$. Substituting:
$$\dfrac{EI}{L^{4}} \dfrac{\mathrm{d}^{4}\tilde{y}}{\mathrm{d}\tilde{x}^{4}}=\dfrac{1}{2} \dfrac{{\varepsilon}_{0}b}{g^{2}(1-\tilde{y})^{2}}V^{2}$$

Rearranging to isolate the normalized voltage parameter:
$$\tilde{y}''''=\dfrac{1}{2} \dfrac{\tilde{V}^{2}}{(1-\tilde{y})^{2}}\tag{1.16}$$

where we defined the normalized voltage:
$$\tilde{V}^{2}=\dfrac{{\varepsilon}_{0}bL^{4}}{EIg^{3}}V^{2}= \dfrac{12{\varepsilon}_{0}L^{4}}{Et^{3}g^{3}}V^{2}\tag{1.17}$$

We discretize the beam using $n$ internal nodes equally spaced by $h=1/(n+1)$ (in normalized coordinates). The clamped-clamped boundary conditions are $\tilde{y}_{0}=\tilde{y}_{n+1}=0$ (zero displacement) and $\tilde{y}'_{0}=\tilde{y}'_{n+1}=0$ (zero slope).

Applying the fourth-derivative stencil $[1,-4,6,-4,1]$ at each internal node yields a *banded* linear system. The stencil at node $i$ reads:
$$\dfrac{\tilde{y}_{i-2}-4\tilde{y}_{i-1}+6\tilde{y}_{i}-4\tilde{y}_{i+1}+\tilde{y}_{i+2}}{h^{4}}=\dfrac{1}{2} \dfrac{\tilde{V}^{2}}{(1-\tilde{y}_{i})^{2}}$$

As a concrete small example, consider a beam discretized with nodes $i=0,1,\dots,6$, where nodes $0$ and $6$ are the clamped ends (boundary nodes) and nodes $1$ through $5$ are the five internal unknowns. The stencil at each node $i$ involves $\tilde{y}_{i-2},\dots,\tilde{y}_{i+2}$, so writing one equation per node requires the extended vector $[\tilde{y}_{-2},\tilde{y}_{-1},\tilde{y}_{0},\dots,\tilde{y}_{6},\tilde{y}_{7},\tilde{y}_{8}]$, where $\tilde{y}_{-2},\tilde{y}_{-1}$ and $\tilde{y}_{7},\tilde{y}_{8}$ are **ghost nodes** - fictitious nodes outside the beam needed to complete the stencil at the boundary rows:

$$\small\begin{pmatrix}
1 & -4 & 6 & -4 & 1 & 0 & 0 & 0 & 0 & 0 & 0 \\
0 & 1 & -4 & 6 & -4 & 1 & 0 & 0 & 0 & 0 & 0 \\
0 & 0 & 1 & -4 & 6 & -4 & 1 & 0 & 0 & 0 & 0 \\
0 & 0 & 0 & 1 & -4 & 6 & -4 & 1 & 0 & 0 & 0 \\
0 & 0 & 0 & 0 & 1 & -4 & 6 & -4 & 1 & 0 & 0 \\
0 & 0 & 0 & 0 & 0 & 1 & -4 & 6 & -4 & 1 & 0 \\
0 & 0 & 0 & 0 & 0 & 0 & 1 & -4 & 6 & -4 & 1
\end{pmatrix}\begin{pmatrix}
\tilde{y}_{-2} \\
\tilde{y}_{-1} \\
\tilde{y}_{0} \\
\tilde{y}_{1} \\
\tilde{y}_{2} \\
\tilde{y}_{3} \\
\tilde{y}_{4} \\
\tilde{y}_{5} \\
\tilde{y}_{6} \\
\tilde{y}_{7} \\
\tilde{y}_{8}
\end{pmatrix}=\dfrac{h^{4}\tilde{V}^{2}}{2}\begin{pmatrix}
\dfrac{1}{(1-\tilde{y}_{0})^{2}} \\
\dfrac{1}{(1-\tilde{y}_{1})^{2}} \\
\dfrac{1}{(1-\tilde{y}_{2})^{2}} \\
\dfrac{1}{(1-\tilde{y}_{3})^{2}} \\
\dfrac{1}{(1-\tilde{y}_{4})^{2}} \\
\dfrac{1}{(1-\tilde{y}_{5})^{2}} \\
\dfrac{1}{(1-\tilde{y}_{6})^{2}} \\
\end{pmatrix} $$

The ghost node values are determined by the **zero-slope (clamped) boundary condition** $\tilde{y}'=0$ at each end. Approximating this condition with a central difference at the left boundary node ($i=0$):
$$\tilde{y}'_{0}=\dfrac{\tilde{y}_{1}-\tilde{y}_{-1}}{2h}=0\implies \tilde{y}_{-1}=\tilde{y}_{1}$$
Applying the same argument one step further (zero slope at the same point implies the displacement profile is locally even about the clamped node):
$$\dfrac{\tilde{y}_{2}-\tilde{y}_{-2}}{4h}\approx 0\implies \tilde{y}_{-2}=\tilde{y}_{2}$$
The right boundary gives the symmetric result: $\tilde{y}_{7}=\tilde{y}_{5}$ and $\tilde{y}_{8}=\tilde{y}_{4}$. In other words, the zero-slope condition makes the ghost nodes mirror images of their counterparts across the clamp - not because the beam problem is left-right symmetric, but because each clamped end locally enforces a reflective condition on the displacement field.

Therefore we can now write:
$$\small\begin{pmatrix}
0 & 0 & 6 & -8 & 2 & 0 & 0 & 0 & 0 & 0 & 0 \\
0 & 0 & -4 & 7 & -4 & 1 & 0 & 0 & 0 & 0 & 0 \\
0 & 0 & 1 & -4 & 6 & -4 & 1 & 0 & 0 & 0 & 0 \\
0 & 0 & 0 & 1 & -4 & 6 & -4 & 1 & 0 & 0 & 0 \\
0 & 0 & 0 & 0 & 1 & -4 & 6 & -4 & 1 & 0 & 0 \\
0 & 0 & 0 & 0 & 0 & 1 & -4 & 7 & -4 & 0 & 0 \\
0 & 0 & 0 & 0 & 0 & 0 & 2 & -8 & 6 & 0 & 0
\end{pmatrix}\begin{pmatrix}
\tilde{y}_{-2} \\
\tilde{y}_{-1} \\
\tilde{y}_{0} \\
\tilde{y}_{1} \\
\tilde{y}_{2} \\
\tilde{y}_{3} \\
\tilde{y}_{4} \\
\tilde{y}_{5} \\
\tilde{y}_{6} \\
\tilde{y}_{7} \\
\tilde{y}_{8}
\end{pmatrix}=\dfrac{h^{4}\tilde{V}^{2}}{2}\begin{pmatrix}
\dfrac{1}{(1-\tilde{y}_{0})^{2}} \\
\dfrac{1}{(1-\tilde{y}_{1})^{2}} \\
\dfrac{1}{(1-\tilde{y}_{2})^{2}} \\
\dfrac{1}{(1-\tilde{y}_{3})^{2}} \\
\dfrac{1}{(1-\tilde{y}_{4})^{2}} \\
\dfrac{1}{(1-\tilde{y}_{5})^{2}} \\
\dfrac{1}{(1-\tilde{y}_{6})^{2}} \\
\end{pmatrix} $$

Due to displacement boundary condition ($\tilde{y}_{0}=\tilde{y}_{6}=0$) we can eliminate their corresponding columns. We are left with:

$$\small\begin{pmatrix}
7 & -4 & 1 & 0 & 0  \\
-4 & 6 & -4 & 1 & 0 \\
1 & -4 & 6 & -4 & 1 \\
0 & 1 & -4 & 6 & -4 \\
0 & 0 & 1 & -4 & 7
\end{pmatrix}\begin{pmatrix}
\tilde{y}_{1} \\
\tilde{y}_{2} \\
\tilde{y}_{3} \\
\tilde{y}_{4} \\
\tilde{y}_{5} \\
\end{pmatrix}=\dfrac{h^{4}\tilde{V}^{2}}{2}\begin{pmatrix}
\dfrac{1}{(1-\tilde{y}_{1})^{2}} \\
\dfrac{1}{(1-\tilde{y}_{2})^{2}} \\
\dfrac{1}{(1-\tilde{y}_{3})^{2}} \\
\dfrac{1}{(1-\tilde{y}_{4})^{2}} \\
\dfrac{1}{(1-\tilde{y}_{5})^{2}} \\
\end{pmatrix}$$
For any number of nodes, the resulting system can be written as:
$$[\mathbf{K}]\{ \tilde{\mathbf{y}} \}=\dfrac{\tilde{V}^{2}h^{4}}{2}\left\{  \dfrac{1}{(1-\tilde{y}_{i})^{2}}  \right\}\tag{1.18}$$
where $[]$ stands for matrix and $\{  \}$ stands for column vectors.
$[\mathbf{K}]$ here is the following penta-diagonal stiffness matrix with the pattern:
$$\mathbf{K}=\begin{pmatrix} 7 & -4 & 1 & &  \\
-4 & 6 & -4 & 1 &  \\
1 & -4 & 6 & -4 & \ddots  \\
 & \ddots & \ddots & \ddots & \ddots  \\
& & 1 & -4 & 7 \end{pmatrix}$$

# Solving the Nonlinear System

## Voltage Iteration (VI) Method

The system in $\text{(1.18)}$ is nonlinear because the right-hand side depends on $\tilde{\mathbf{y}}$. The simplest approach is **fixed-point iteration**, also called **voltage iteration (VI)**: given a voltage $\tilde{V}$, start with an initial guess $\tilde{\mathbf{y}}^{(0)}$ (typically zero), evaluate the right-hand side, solve the linear system for $\tilde{\mathbf{y}}^{(1)}$, and repeat:
$$[\mathbf{K}]\tilde{\mathbf{y}}^{(k+1)}=\dfrac{\tilde{V}^{2}h^{4}}{2}\left\{  \dfrac{1}{(1-{{\tilde{y}_{i}}}^{(k)})^{2}}  \right\} \tag{1.19}$$
This iteration converges when the mechanical restoring force dominates the electrostatic force - i.e., when the system is on the **stable equilibrium branch**. Near and beyond pull-in, the iteration diverges because the electrostatic force grows faster than the mechanical restoring force.

The convergence behavior of voltage iteration is shown in [[#^figure-vi-convergence|figure]] below for a range of normalized voltages $\tilde{V}=[1{:}11,\;11.5,\;11.8,\;11.85]$, solved on a mesh of $n=1023$ internal nodes.

![[MCS2_001/vi_convergence.png|bookhue|600]]^figure-vi-convergence
>Convergence of the midpoint displacement under voltage iteration. Each curve corresponds to a different normalized voltage $\tilde{V}$. Lower voltages converge in a few iterations; convergence degrades sharply as $\tilde{V}\to \tilde{V}_{\text{PI}}$.

For low voltages ($\tilde{V}\leq 5$), the iteration converges exponentially in just $3$ to $5$ iterations. As the voltage increases toward the pull-in voltage, convergence slows dramatically. $\tilde{V}=11$ requires roughly $15$ iterations, and $\tilde{V}=11.8$ needs over $25$. The topmost curve ($\tilde{V}=11.85$) barely converges within $30$ iterations, indicating that this voltage is very close to (or slightly above) pull-in.

The physical interpretation is straight-forward: at low voltages, the electrostatic force is a small perturbation to the stiffness matrix and the fixed-point iteration contracts rapidly. Near pull-in, the electrostatic "softening" almost cancels the mechanical stiffness, making the contraction ratio approach $1$.

By sweeping through these converged solutions, we can trace the **equilibrium curve $\tilde{V}$** vs. midpoint displacement $\tilde{y}_{\text{mid}}$:

![[MCS2_001/vi_equilibrium.png|bookhue|600]]^figure-vi-equilibrium
>Equilibrium curve obtained by voltage iteration. Only the stable branch is accessible - the curve terminates near pull-in without revealing what happens beyond.

The equilibrium curve flattens as it approaches pull-in, and voltage iteration simply cannot continue past this point. This presents a fundamental limitation: voltage iteration **cannot access the unstable equilibrium branch** of the displacement-voltage curve. It also cannot pinpoint the pull-in voltage precisely, since convergence degrades severely in its vicinity. For engineering design, where knowing the exact pull-in parameters is critical, we need a better algorithm.

## DIPIE Algorithm

The Displacement Iteration Pull-In Extraction (DIPIE) algorithm, introduced in [[MCS1_000 00350041 מכניקת מיקרו-מערכות#ביבליוגרפיה|(Bochobza-Degani et al., 2002)]],  overcomes the limitations of voltage iteration by **inverting the problem**: instead of prescribing the voltage and solving for displacement, we prescribe a displacement at a chosen node and solve for the voltage that produces it.

This is conceptually analogous to the difference between load-controlled and displacement controlled testing in mechanics. In a displacement-controlled experiment, we can trace the entire force-displacement curve - including the descending (unstable) branch - because we directly control the independent variable.
Similarly, DIPIE can trace both stable and unstable equilibrium branches.

The discretized equilibrium equations for the clamped-clamped beam are:
$$\tilde{y}''''_{i}=\dfrac{1}{2} \dfrac{\tilde{V}^{2}}{(1-\tilde{y}_{i})^{2}},\qquad i=1,\dots ,n\tag{1.20}$$
where all nodes share the same voltage $\tilde{V}$. The key insight of DIPIE is to **relax this uniformity constraint**. Instead of requiring a single voltage $\tilde{V}$ at all nodes, we allow each node to have its own local voltage $\tilde{V}_{i}$:

$$\tilde{y}_{i}''''=\dfrac{1}{2} \dfrac{\tilde{V}_{i}^{2}}{(1-\tilde{y}_{i})^{2}},\qquad i=1,\dots ,n\tag{1.21}$$


>[!Question] How can relaxing the voltage uniformity comply with the physics? In reality, the voltage *is* uniform across the beam, so how does allowing different nodal voltages help? 
>The key insight is that the non-uniform nodal voltages are an *intermediate* artifact of the iteration, not the final answer. During the iteration, the displacement field $\tilde{y}_{i}$ is not yet at equilibrium, so if we back-calculate what voltage each node "thinks" it sees, we get different values at different nodes. As the iteration converges, the displacement field approaches the true equilibrium shape, and the nodal voltages all converge to the *same* value - the true applied voltage. The variance $\Delta \tilde{V}^{2}_{i}$ is a measure of how far the current iterate is from equilibrium: it vanishes at convergence.

From these local voltages, we can estimate the average voltage:
$$\tilde{V}^{2}=\dfrac{1}{n} \sum_{i=1}^{n}{{\tilde{V}_{i}}}^{2}=\dfrac{1}{n}\sum_{i=1}^{n}2\tilde{y}_{i}''''(1-\tilde{y}_{i})^{2}\tag{1.22}  $$

Now rewriting equation $\text{(1.21)}$ using the average voltage plus a local variance:
$$\tilde{y}_{i}''''=\dfrac{1}{2} \dfrac{\tilde{V}^{2}+\Delta {{\tilde{V}_{i}}}^{2}}{(1-\tilde{y}_{i})^{2}} \tag{1.23}$$
where $\Delta {{\tilde{V}_{i}}}^{2}={{\tilde{V}_{i}}}^{2}-\tilde{V}^{2}$ is the variance of the local voltage from the average. The $n$ equations in $\text{(1.23)}$ are linearly dependent through $\text{(1.22)}$, so any set of $n-1$ equations is linearly independent. We therefore **extract one node**, node $k$, from the system. For the symmetric clamped-clamped beam, the natural choice is the **midpoint node** $k=(n+1)/2$.

We prescribe the displacement at the midpoint: $\tilde{y}_{k}=\tilde{y}_{\text{mid}}$ (a given value between $0$ and $1$). The remaining $n-1$ equations become:
$$\tilde{y}_{i}''''=\dfrac{1}{2} \dfrac{\tilde{V}^{2}}{(1-\tilde{y}_{i})^{2}}+\dfrac{1}{2} \dfrac{\Delta {{\tilde{V}_{i}}}^{2}}{(1-\tilde{y}_{i})^{2}},\qquad i\neq k$$

The crucial observation is that as the iteration converges, the nodal voltage variance $\Delta {{\tilde{V}_{i}}}^{2}$ **vanishes** - all nodes settle on the same voltage.
The converged solution therefore satisfies the original uniform voltage equation.

### Iterative Procedure
The DIPIE iteration proceeds as follows:
1. **Initialize**: Set $\tilde{y}_{k}=\tilde{y}_{\text{mid}}$ (prescribed). Guess the remaining displacements (e.g., by solving $[\mathbf{K}]\tilde{\mathbf{y}}=-[\mathbf{K}]_{:,k}\tilde{y}_{\text{mid}}$ with row $k$ removed).
2. **Compute local voltages**: From the current displacement field, compute:
	$${{\tilde{V}_{i}}}^{2}=2 \dfrac{[\mathbf{K}\tilde{\mathbf{y}}]_{i}}{h^{4}}(1-\tilde{y}_{i})^{2}$$
3. **Compute average voltage**:
	$$\tilde{V}^{2}=\dfrac{1}{n} \sum_{i=1}^{n}{{\tilde{V}_{i}}}^{2} $$
4. **Solve for displacements**: With $\tilde{y}_{k}$ fixed and the average voltage known, solve the reduced $(n-1)\times(n-1)$ system:
	$$[\mathbf{K}_{}]_{\text{red}}\tilde{\mathbf{y}}_{\text{red}}=\dfrac{\tilde{V}^{2}h^{4}}{2}\left\{  \dfrac{1}{(1-\tilde{y}_{i})^{2}}  \right\}_{\text{red}}-[\mathbf{K}]_{:,k}\tilde{y}_{\text{mid}}$$
5. **Repeat** from step 2 until convergence.

### Why DIPIE Works Beyond Pull-In

The physical intuition is as follows. In voltage iteration, we fix the *cause* (voltage) and solve for the *effect* (displacement). Near pull-in, a tiny voltage increment produces a large displacement change, and beyond pull-in, no equilibrium exists for a given voltage - the beam snaps to the electrode. The iteration reflects this instability by diverging.

In DIPIE, we fix the *effect* (midpoint displacement) and solve for the *cause* (voltage). For every midpoint displacement between $0$ and $1$, there exists exactly one equilibrium voltage. The mapping from displacement to voltage is single-valued and smooth, even through the pull-in point. This is why DIPIE converges everywhere - it parameterizes the equilibrium curve by a monotonic variable (displacement) rather than a non-monotonic one (voltage).

### Equilibrium Curve

By sweeping $\tilde{y}_{\text{mid}}$ from $0$ to just below $1$, DIPIE traces the **complete equilibrium curve**, as shown in [[#^figure-dipie-equilibrium|figure]] below.


![[MCS2_001/dipie_equilibrium.png|bookhue|600]]^figure-dipie-equilibrium
>Full equilibrium curve obtained by the DIPIE algorithm ($n=1023$ nodes). The solid blue line is the stable branch; the dashed red line is the unstable branch. The dot marks the pull-in point at $\tilde{y}_{\text{mid}}\approx 0.39$, $\tilde{V}_{\text{PI}}\approx 11.80$.

The curve has two branches:
- **Stable branch** (solid blue): from $\tilde{y}_{\text{mid}}=0$ up to the pull-in displacement. Here $\mathrm{d}\tilde{V}/\mathrm{d}\tilde{y}_{\text{mid}}>0$. That is, the voltage increases with displacement. Any perturbation away from equilibrium is restored by the net force balance.
- **Unstable branch** (dashed red): beyond pull in. Here $\mathrm{d}\tilde{V}/\mathrm{d}\tilde{y}_{\text{mid}}<0$ - the voltage *decreases* with displacement. The maximum of $\tilde{V}$ along the curve defines the **pull-in voltage** $\tilde{V}_{\text{PI}}$. A tiny perturbation from these equilibria causes the beam to snap either to the electrode or back to the stable branch.

On the unstable branch, to maintain equilibrium at a displacement _closer_ to the electrode, you actually have to **decrease** the voltage. Why? Because the gap is so small that a high voltage would provide way too much force for the beam to resist. You have to "turn down" the voltage to keep the beam from snapping.

# General Governing Equation

The simple beam equation $\text{(1.15)}$ neglects two effects that become important at larger deflections:

1. **Residual stress** $\sigma_{0}$: fabrication processes often leave a residual in-plane stress in the beam, which acts as an axial load.
2. **Mid-plane stretching**: as the beam deflects, its centerline stretches (recall from [[MCS1_003 לינאריות קורה בכפיפה#תרגיל 2|the string model]] that stretching produces a nonlinear restoring force proportional to $\Delta^{3}$).