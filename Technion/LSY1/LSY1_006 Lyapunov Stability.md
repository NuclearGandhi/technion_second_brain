---
aliases:
---
# Lyapunov Stability

## Autonomous System
>[!def] Definition: 
 >A system of ODE's which does not explicitly depend on the independent variable is called an **autonomous system**.
 >$$\dot{\mathbf{x}}(t)=\mathbf{f}(\mathbf{x})$$

In the case of [[LSY1_004 Linear State-Space Equation#Linear State-Space Equation|linear state-space equation]], we get:
$$\begin{aligned}
\dot{\mathbf{x}}(t)=\mathbf{A}\mathbf{x}(t) &  & \mathbf{x}(0)=\mathbf{x}_{0}
\end{aligned}$$
which is the state equation with zero inputs. It is also known as the **unforced motion** (or autonomous motion) of the system, where the state responds only to initial conditions.

the unforced motion fully represents properties of the system, while being easier to analyze.
## Stability of Autonomous System


>[!def] Definition: 
 >Consider the following autonomous [[LSY1_001 Introduction#State-Space Linear Systems|CLTV]] system:
>$$\begin{aligned}
 & \dot{\mathbf{x}}(t)=\mathbf{f}(\mathbf{x}) &  & \mathbf{x} \in \mathbb{R}^{n}
\end{aligned}$$
>An equilibrium $\mathbf{x}_{\text{eq}}\in \mathbb{R}^{n}$ of this system is said to be:
> - **Lyapunov stable** if for every $\varepsilon>0$ there is $\delta>0$ such that if $\lVert \mathbf{x}(0)-\mathbf{x}_{\text{eq}} \rVert<\delta$, then:
> 	$$\begin{aligned}
> \lVert \mathbf{x}(t)-\mathbf{x}_{\text{eq}} \rVert<\varepsilon  &  & \forall t\geq  0
> \end{aligned}$$
> - **asymptotically stable** if it is Lyapunov stable and there is $\delta>0$ such that if $\lVert \mathbf{x}(0)-\mathbf{x}_{\text{eq}} \rVert<\delta$, then:
> 	$$\lim_{ t \to \infty}\lVert \mathbf{x}(t)-\mathbf{x}_{\text{eq}} \rVert =0$$
> 

Conceptually, the meanings of the above terms are the following:

- Lyapunov stability of an equilibrium means that solutions starting "close enough" to the equilibrium (within a distance $\delta$ from it) remain "close enough" forever (within a distance $\varepsilon$ from it). Note that this must be true for _any_ $\varepsilon$ that one may want to choose.
2. Asymptotic stability means that solutions that start close enough not only remain close enough but also eventually converge to the equilibrium.

The **region of attraction** of an asymptotically stable equilibrium is the set of initial conditions $\mathbf{x}(0)$ that generate states $\mathbf{x}$ converging to $\mathbf{x}_{\text{eq}}$. If the region of attraction is the whole $\mathbb{R}_{n}$ , then the equilibrium is said to be **globally asymptotically stable**.

## Stability for Linear State Space Models


>[!theorem] Theorem: 
> An equilibrium of the autonomous linear system $\dot{\mathbf{x}}=\mathbf{A}\mathbf{x}$ is
> - Lyapunov stable iff its [[../NUM1/NUM1_003 נורמה#נורמה-$2$ - רדיוס ספקטרלי|spectral radius]] is non-positive:
>   $$\rho(A)\in \{ s \in \mathbb{C}\mid\mathrm{Re}(s)\leq  0 \}$$
>   and every imaginary eigenvalue is simple (the [[../ALG1/ALG1_010 וקטורים עצמיים וערכים עצמיים#ריבוי גיאומטרי|geometric multiplicity]] of every pure imaginary eigenvalue equals its [[../ALG1/ALG1_010 וקטורים עצמיים וערכים עצמיים#פולינום אופייני וריבוי אלגברי|algebraic multiplicity]]).
> - asymptotically stable iff its spectral radius is negative:
> 	$$\rho(A)\in \{ s \in \mathbb{C}\mid\mathrm{Re}(s)<  0 \}$$
> 


## Lyapunov’s indirect method



>[!theorem] Theorem: 
> Let $\dot{\mathbf{x}}=\mathbf{f}(\mathbf{x})$ for a continuously differentiable $\mathbf{f}:\mathbb{R}^{n}\to \mathbb{R}^{n}$, $\mathbf{x}_{\text{eq}}\in \mathbb{R}^{n}$ be its equilibrium, and $\mathbf{A}=\dfrac{ \partial \mathbf{f}(\mathbf{x}) }{ \partial \mathbf{x} }$ be the corresponding [[../CAL2/CAL2_011 אינטגרל רב מימדי#מטריצת היעקוביאן|Jacobian]] matrix.
> 
> - If $\rho(A)\in \mathbb{C} \setminus \bar{\mathbb{C}}_{0}$ (all eigenvalues of $\mathbf{A}$ are in the the open left half-plane - OLHP), then $\mathbf{x}_{\text{eq}}$ is asymptotically stable.
> - If $\mathbf{A}$ has at least one eigenvalue in $\mathbb{C}_{0}$, then $\mathbf{x}_{\text{eq}}$ is unstable.
> 
> If the rightmost eigenvalue of the Jacobian matrix is on the imaginary axis, then the stability conclusion is ambiguous.

# Modal decomposition
A common way to analyze initial conditions for a given linear autonomous system is **modal decomposition**.

Consider the autonomous state equation
$$\begin{aligned}
\dot{\mathbf{x}}(t)=\mathbf{A}\mathbf{x}(t) &  & \mathbf{x}(0)=\mathbf{x}_{0}
\end{aligned}$$
and assume that $\mathbf{A}$ is diagonalizable with real eigenvalues. The solution is:
$$\begin{aligned}
\mathbf{x}(t) & =e^{\mathbf{A}t}{x}_{0} \\[1ex]
 & =\mathbf{T}e^{\boldsymbol{\Lambda}t}\mathbf{T}^{-1}\mathbf{x}_{0}
\end{aligned}$$
Denoting the eigenvectors $\{ \boldsymbol{\eta}_{1},\,\boldsymbol{\eta}_{2},\,\dots,\,\boldsymbol{\eta}_{n} \}$  and their inverse $\{ \mathbf{v}_{1},\,\mathbf{v}_{2},\,\dots,\,\mathbf{v}_{n} \}$, i.e:
$$\begin{aligned}
 & \mathbf{T}=\begin{pmatrix}
\boldsymbol{\eta}_{1},\, \boldsymbol{\eta}_{2},\, \dots ,\, \boldsymbol{\eta}_{n}
\end{pmatrix} &  & \mathbf{T}^{-1}=\begin{pmatrix}
\mathbf{v}_{1} \\
\mathbf{v}_{2} \\
\vdots  \\
\mathbf{v}_{n}
\end{pmatrix}
\end{aligned}$$
we can write:
$$\begin{aligned}
\mathbf{x}(t) & =\begin{pmatrix}
\boldsymbol{\eta}_{1},\, \boldsymbol{\eta}_{2},\, \dots ,\, \boldsymbol{\eta}_{n}
\end{pmatrix}\begin{pmatrix}
e^{{\lambda}_{1}t} &  & 0 \\
 & \ddots  &  \\
0 &  & e^{\lambda_{n}t}
\end{pmatrix}\begin{pmatrix}
\mathbf{v}_{1} \\
\mathbf{v}_{2} \\
\vdots  \\
\mathbf{v}_{n}
\end{pmatrix}\mathbf{x}_{0} \\[1ex]
 & =\sum _{i=1}^{n}\boldsymbol{\eta}_{i}e^{\lambda_{i}t}({\mathbf{v}_{i}}^{T}\cdot \mathbf{x}_{0})
\end{aligned}$$
Defining $\mu_{i}={\mathbf{v}_{i}}^{T}\cdot \mathbf{x}_{0}\in \mathbb{R}$, we get
$$\mathbf{x}(t)=\sum _{i=1}^{n}\boldsymbol{\eta}_{i}e^{\lambda_{i}t}\mu_{i}$$
where the initial condition only affect the constant scalar coefficients $\mu_{i}$.

The form
$$\boxed{\mathbf{x}(t)=\sum _{i=1}^{n} \boldsymbol{\eta}_{i} e^{\lambda_{i}t}\mu_{i} }$$
means that solutions to autonomous systems are a superposition of elementary exponential signals $e^{\lambda_{i}t}$, each one of which is shaped by the corresponding eigenvectors, $\boldsymbol{\eta}_{i}\in \mathbb{R}^{n}$.
The signal $\boldsymbol{\eta}_{i}e^{\lambda_{i}t}$ is known as the $i$th **mode** of the system, and the scalar $\mu_{i}$ is called the **degree of excitation** of the $i$th mode by $\mathbf{x}_{0}$.

# Exercises

## Question 1
Consider the following state space equation:
$$\dot{\mathbf{x}}(t)=\begin{pmatrix}
0 & 1 \\
3 & 2
\end{pmatrix}\mathbf{x}(t)$$

### Part a
Is the system Lyapunov stable?

**Solution**:
First, we'll find the eigenvalues:
$$\begin{vmatrix}
\lambda \mathbf{I}-\mathbf{A}
\end{vmatrix}=\begin{vmatrix}
\lambda & -1 \\
-3 & \lambda-2
\end{vmatrix}=\lambda ^{2}-2\lambda-3=(\lambda-3)(\lambda+1)=0$$
Therefore, ${\lambda}_{1}=3,\,{\lambda}_{2}=-1$, which means by [[#Lyapunov Stability|its definition]] that the system is unstable.

### Part b
Find a transformation diagonalizing the matrix $\mathbf{A}$. 

**Solution**:
The eigenvectors:
- for ${\lambda}_{1}=3$:
	$$(3\mathbf{I}-\mathbf{A})\boldsymbol{\eta}_{1}=\begin{pmatrix}
3 & -1 \\
-3 & 1
\end{pmatrix}\boldsymbol{\eta}_{1}=0$$
	we get $\boldsymbol{\eta}_{1}=\begin{pmatrix}1\\3\end{pmatrix}$
- for ${\lambda}_{1}=-1$:
	$$(\mathbf{I}-\mathbf{A})\boldsymbol{\eta}_{2}=\begin{pmatrix}
-1 & -1 \\
-3 & -3
\end{pmatrix}\boldsymbol{\eta}_{2}=0$$
	we get $\boldsymbol{\eta}_{2}=\begin{pmatrix}1\\-1\end{pmatrix}$

Therefore:
$$\boxed {
\mathbf{T}=\begin{pmatrix}
1 & 1 \\
3 & -1
\end{pmatrix}
 }$$

### Part c
Carry out the modal decomposition of the system with respect to any initial condition $\mathbf{x}(0)$.

**Solution**:
The [[#Modal decomposition]] is given by:
$$\boxed {
\mathbf{x}(t)=\boldsymbol{\eta}_{1}e^{3t}\mu_{1}+\boldsymbol{\eta}_{2}e^{-t}{\mu}_{2}
 }$$
where $\boldsymbol{\mu}_{}=\mathbf{T}^{-1}\cdot \mathbf{x}(0)$

### Part d
Find the response for the following two initial conditions. Draw the responses in a phase portrait.
- $\mathbf{x}(0)=\begin{pmatrix}1.05\\-1\end{pmatrix}$
- $\mathbf{x}(0)=\begin{pmatrix}-2\\2\end{pmatrix}$

**Solution**:
The inverse of $\mathbf{T}$:
$$\mathbf{T}^{-1}=\dfrac{1}{-4}\begin{pmatrix}
-1 & -1 \\
-3 & 1
\end{pmatrix}$$
- for $\mathbf{x}(0)=\begin{pmatrix}1.05\\-1\end{pmatrix}$, we get:
$$\begin{aligned}
 & \mu_{1}=\dfrac{1}{-4}\begin{pmatrix}
-1 \\
-1
\end{pmatrix} \begin{pmatrix}
1.05\\-1
\end{pmatrix}=-\dfrac{1}{4}(-1.05+1)=0.0125 \\[1ex]
 & {\mu}_{2}=-\dfrac{1}{4}\begin{pmatrix}
-3\\1
\end{pmatrix}\begin{pmatrix}
1.05 \\
-1
\end{pmatrix}=-\dfrac{1}{4}(-3.15-1)=1.0375
\end{aligned}$$
	Therefore, the response is:
	$$\boxed {
\mathbf{x}(t)=\begin{pmatrix}
0.0125e^{3t}+1.0375e^{-t} \\
0.0375e^{3t}-1.0375e^{-t}
\end{pmatrix}
 }$$
- for $\mathbf{x}(0)=\begin{pmatrix}-2\\2\end{pmatrix}$, we get:
	$$\begin{aligned}
 & {\mu}_{1}=-\dfrac{1}{4}\begin{pmatrix}
-1\\-1
\end{pmatrix}\begin{pmatrix}
-2 \\
2
\end{pmatrix}=-\dfrac{1}{4}(2-2)=0 \\[1ex]
 & {\mu}_{2}=-\dfrac{1}{4}\begin{pmatrix}
-3 \\
1
\end{pmatrix}\begin{pmatrix}
-2\\2
\end{pmatrix}=-\dfrac{1}{4}(6+2)=-2
\end{aligned}$$
	Therefore, the response is:
	$$\boxed {
\mathbf{x}(t)=\begin{pmatrix}
-2e^{-t} \\
2e^{-t}
\end{pmatrix}
 }$$

![[LSY1_006/Screenshot_20240711_120635_Samsung Notes.jpg|book|400]]
>Phase portrait for both initial conditions


 