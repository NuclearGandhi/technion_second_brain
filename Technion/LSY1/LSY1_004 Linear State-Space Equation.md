---
aliases:
  - linear state-space equation
  - impulse response
  - matrix exponential
  - transfer function
  - physical realization
  - canonical realization
  - Euler's formula
---

# Impulse Response
The **impulse response** of a dynamic system is its output when presented with a brief input signal ([[LSY1_002 Signals and Convolutions#The Delta Function|unit impulse]]) - $\delta (t)$. More generally, an impulse response is the reaction of any dynamic system in response to some external change.
![[LSY1_004/Pasted image 20240616155903.png|book|400]]
>The impulse response from a simple audio system. Showing, from top to bottom, the original impulse, the response after high frequency boosting, and the response after low frequency boosting.

The output of a CLTI system is completely determined by the input and the system's response to a unit impulse.
![[LSY1_004/LSY1_004 Time Domain Analysis 2024-06-16 16.23.35.excalidraw.svg]]
>We can determine the system's output $y(t)$ if we know the system's impulse response $g(t)$ and the input $f(t)$.

In fact, we can show that by *convolving* the input $u(t)$ with the impulse response of the system $g(t)$ we get the system's output $y(t)$:
$$y(t)=(g*u)(t)$$


>[!example] Examples:
>1. For the gain system $y(t)=ku(t)$, the impulse response is:
>	$$g(t)=k\delta(t)$$
>2. For the delay system $y(t)=u(t-\tau)$, the impulse response is:
>	$$g(t)=\delta(t-\tau)$$
>3. For the integrator system $y(t)=\int_{-\infty}^{t} u(s) \, \mathrm{d}s$, the impulse response is:
>	$$g(t)=\int_{-\infty }^{t} \delta(s) \, \mathrm{d}s=\mathbb{1}(t) $$
>4. For the finite-memory integrator $y(t)=\int_{t-\mu}^{t} u(s) \, \mathrm{d}s$, the impulse response is:
>	$$g(t)=\int_{t-\mu}^{t}\delta(s)  \, \mathrm{d}s=\mathrm{rect}_{\mu}(t-\mu /2)$$

## Causality via Impulse Responses

> [!theorem] Theorem
>A CLTI system with the impulse response $g$ is causal iff $\mathrm{supp}(g)\subset \mathbb{R}_{+}$.

**Proof**:
The response $y=g*t$ reads at every $t$ as
$$\begin{aligned}
y(t) & =\int_{-\infty }^{\infty } g(t-s)u(s) \, \mathrm{d}s \\[1ex]
 & =\underbrace{ \int_{-\infty }^{t} g(t-s)u(s) \, \mathrm{d}s }_{ \text{past and present} }+\underbrace{ \int_{t}^{\infty} g(t-s)u(s) \, \mathrm{d}s }_{ \text{future} }
\end{aligned}$$

The future term zeros out iff $g(t-s)=0$ for all $s>t$. i.e., $g(t)=0$ for all $t<0$, which is equivalent to saying $\mathrm{supp}(g)\subset \mathbb{R}_{+}$.
Thus, $y(t)$ cannot depend on $u(s)$ for $s>t$ iff $\mathrm{supp}(g)\subset \mathbb{R}_{+}$ - the system is causal.
$$\tag*{$\blacksquare$}$$


## Stability via Impulse Responses
 
> [!theorem] Theorem
> A CLTI system $G$ with impulse response $g$ is BIBO stable iff $g\in {L}_{1}$. If the system is BIBO stable, then $\lVert G \rVert_{\infty}=\lVert g \rVert_{1}$

>[!notes] Notes: 
 >1. The mere decaying of $g$ might not be enough for the BIBO stability of $G$. For example, if
 >	$$\begin{aligned}
g(t)=\dfrac{1}{1+t}\mathbb{1}(t) &  & u(t)=\mathbb{1}(t)\in L_{\infty }
\end{aligned}$$
>then for all $t\geq 0$
>$$\begin{aligned}
y(t) & =\int_{-\infty }^{t} \dfrac{1}{1+t-s}\mathbb{1}(t) \, \mathrm{d}s \\[1ex]
 & =\int_{0}^{t} \dfrac{1}{1+t-s}  \, \mathrm{d}s \\[1ex]
 & =-\ln(1+t-s)\bigg|_{0}^{t}  \\[1ex]
 & =\ln(1+t)
\end{aligned}$$
>and it is not bounded. Hence, this system is not BIBO stable (and indeed $g\notin{L}_{1}$).
>2. The ${L}_{2}$-stability is not easy to verify directly in terms of the impulse response (need frequency domain).

# Linear State-Space Equation

In [[LSY1_001 Introduction#State-Space Linear Systems|state-space linear systems]] we were to introduced to the **CLTI state-space equation**. In the case of SISO (single-input, single-output), we have the following first-order differential system:
$$\begin{aligned}
  & \dot{x}(t)=\mathbf{A}x(t)+\mathbf{B}u(t) \\
 & y(t)=\mathbf{C}x(t)+Du(t)
\end{aligned}$$
Where $\mathbf{A}\in \mathbb{R}^{n\times n},\,\mathbf{B}\in \mathbb{R}^{n},\,\mathbf{C}\in \mathbb{R}^{1\times n},\,D\in \mathbb{R}$.
This quadruple is called a **state-space realization** of the system.
Although we have shown the the solution of a linear set of differential equations defines a linear input/output system, we have not fully computed the solution of the system.
In fact, it can be shown that the solution of such  system is:
$$y(t)=\int_{-\infty }^{t} \mathbf{C}e^{\mathbf{A}(t-s)}\mathbf{B}u(s) \, \mathrm{d}s+Du(t) $$
Where we have a **matrix exponential** - $e^{\mathbf{A}}$. To show that this is the solution of the given ODE, we first need to go over what is a matrix exponential.
## The Matrix Exponential
![](https://www.youtube.com/watch?v=O85OWBJ2ayo&t=4s)

>[!def] Definition: 
 >The **matrix exponential** is defined as the infinite series
 >$$e^{X}=I+X+\dfrac{1}{2}X^{2}+\dfrac{1}{3!}X^{3}+\dots =\sum_{k=0}^{\infty} \dfrac{1}{k!}X^{k} $$
 >where $X \in \mathbb{R}^{n\times n}$.
 
 It can be shown that the series in the definition converges for any matrix $X \in \mathbb{R}^{n\times n}$ in the same way that the normal exponential is defined for any scalar $a\in \mathbb{R}$.

>[!example] Example: 
>Compute the matrix $e^{\mathbf{A}t}$ if the matrix $\mathbf{A}$ has the form
>1. $$\mathbf{A}=\begin{pmatrix}
1 & 0 \\
0 & 2
\end{pmatrix}$$
>2. $$\mathbf{A}=\begin{pmatrix}
0 &  1\\
0 & 0
\end{pmatrix}$$
>
>**Solution**:
>1. $$\begin{aligned}
e^{\mathbf{A}t} & =I+\begin{pmatrix}
1 & 0\\0 & 2
\end{pmatrix}t+\dfrac{1}{2}\begin{pmatrix}
1 & 0 \\
0 & 4
\end{pmatrix}t^{2}+\dfrac{1}{3!}\begin{pmatrix}
1 & 0 \\
0 & 8
\end{pmatrix}t^{3}+\dots \\[2ex]
 & =\begin{pmatrix}
1+t+\dfrac{1}{2}t^{2}+\dfrac{1}{3!}t^{3}+\dots  & 0 \\
0 & 1+2t+\dfrac{1}{2}(2t)^{2}+\dfrac{1}{3!}(2t)^{3}+\dots 
\end{pmatrix} \\[2ex]
 & =\boxed {
\begin{pmatrix}
e^{t} & 0 \\
0 & e^{2t}
\end{pmatrix}
 }
\end{aligned}$$
>2. $$\begin{aligned}
e^{\mathbf{A}t} & =I+\begin{pmatrix}
0 & 1 \\
0 & 0
\end{pmatrix}t+\dfrac{1}{2}\begin{pmatrix}
0 & 1 \\
0 & 0
\end{pmatrix}t^{2}+\dfrac{1}{3!}\begin{pmatrix}
0 & 1 \\
0 & 0
\end{pmatrix}t^{3}+\dots  \\[2ex]
 & =\boxed {
\begin{pmatrix}
1 & e^{t} \\
0 & 1
\end{pmatrix}
 }
\end{aligned}$$


### Properties of the Matrix Exponential
- $(e^{\mathbf{A}t})^{T}=e^{\mathbf{A}^{T}t}$
- $e^{\mathbf{A}t}$ is [[../ALG1/ALG1_009 טרנספורמציות לינאריות#סינגולריות|nonsingular]] for every $\mathbf{A}$, with $(e^{\mathbf{A}t})^{-1}=e^{-\mathbf{A}t}$
- $e^{\mathbf{A}_{1}t}e^{\mathbf{A}_{2}t}=e^{(\mathbf{A}_{1}+\mathbf{A}_{2})t}$ iff $\mathbf{A}_{1}$ and $\mathbf{A}_{2}$ commute
- If $\mathbf{A}$ is [[../ALG1/ALG1_003 מטריצות#מטריצה אלכסונית|diagonal]]/[[../ALG1/ALG1_003 מטריצות#מטריצה משולשת עליונה ותחתונה|triangular]], then so is $e^{\mathbf{A}t}$, with diagonal elements $e^{a_{ii}t}$.
- $\dfrac{\mathrm{d}}{\mathrm{d}t}e^{\mathbf{A}t}=\mathbf{A}e^{\mathbf{A}t}=e^{\mathbf{A}t}A$

## Euler's Formula
>[!formula] formula: 
>**Euler's formula** states that
>$$e^{j\theta}=\cos\theta+j\sin\theta$$
>![[Pasted image 20240624205655.png|book|400]]


> [!attention] Attention!
> We write $j$ instead of $i$ because of aliens.
> These aliens refer to themselves as 'electrical engineers'. They use $i$ to denote their precious little electrical current. Very confusing.

Some important identities derived from this definition are:
$$\boxed {
\begin{aligned}
 & \sin\theta=\dfrac{e^{j\theta}-e^{-j\theta}}{2j} &  &  \cos\theta=\dfrac{e^{j\theta}+e^{-j\theta}}{2}
\end{aligned}
 }$$
### Special Matrix Exponential
Let
$$\mathbf{A}=\begin{pmatrix}
0 & \omega \\
-\omega & 0
\end{pmatrix}$$
Finding its eigenvalues and eigenvectors, we get:
$$\begin{gathered}
\mathbf{A}=\mathbf{T}\boldsymbol{\Lambda}\mathbf{T}^{-1} \\[2ex]
\begin{pmatrix}
0 & \omega \\
-\omega & 0
\end{pmatrix}=\begin{pmatrix}
-j & j \\
1 & 1
\end{pmatrix}\begin{pmatrix}
j\omega & 0 \\
0 & -j\omega
\end{pmatrix}\begin{pmatrix}
-j & j \\
1 & 1
\end{pmatrix}^{-1}
\end{gathered}$$
Which is why its exponential:
$$\begin{aligned}
e^{\mathbf{A}t}  & =\begin{pmatrix}
-j & j \\
1 & 1
\end{pmatrix}\begin{pmatrix}
e^{j\omega t} & 0 \\
0 & e^{-j\omega t}
\end{pmatrix}\begin{pmatrix}
-j & j \\
1 & 1
\end{pmatrix}^{-1} \\[2ex]
 & =\dfrac{1}{2}\begin{pmatrix}
e^{j\omega t}+e^{-j\omega t} & -j(e^{j\omega t}-e^{-j\omega t}) \\
j(e^{j\omega t}-e^{-j\omega t}) & e^{j\omega t}+e^{-j\omega t}
\end{pmatrix}
\end{aligned}$$
Applying [[#Euler's Formula]], we get
$$e^{\mathbf{A}t}=\begin{pmatrix}
\cos(\omega t) & \sin(\omega t) \\
-\sin(\omega t) & \cos(\omega t)
\end{pmatrix}$$
Because of the equality $e^{(\sigma \mathbf{I}+\mathbf{A})t}=e^{\sigma t}e^{\mathbf{A}t}$, we can say that:
$$\boxed{\exp\left[ \begin{pmatrix}
\sigma & \omega \\
-\omega & \sigma
\end{pmatrix} t\right] =e^{\sigma t}\begin{pmatrix}
\cos(\omega t) & \sin(\omega t) \\
-\sin(\omega t) & \cos(\omega t)
\end{pmatrix}}$$


## Calculating the Matrix Exponent

It won't always be simple to calculate $e^{\mathbf{A}t}$ for any given $\mathbf{A}$ using the definition. An easier way would be to [[../ALG1/ALG1_010 וקטורים עצמיים וערכים עצמיים#לכסון|diagonalize]] $\mathbf{A}$, and then use a special property of diagonalizable matrices:
$$\mathbf{A}=T\boldsymbol{\Lambda}T^{-1}\implies e^{\mathbf{A}t}=Te^{\boldsymbol{\Lambda}t}T^{-1}$$
which would simple entail the calculation of multiplying 3 matrices.
Another way would be to do it via [[../ALG1/ALG1_010 וקטורים עצמיים וערכים עצמיים#משפט קיילי המילטון|Cayley-Hamilton]]:
$$e^{\mathbf{A}t}=\sum_{i=0}^{n-1}g_{i}A^{i} $$
where
$$\begin{gathered}
g_{i}=e^{\lambda_{i}}V^{-1} &  & V^{}=\begin{pmatrix}
1 & 1 & \dots  & 1 \\
{\lambda}_{1} & {\lambda}_{2} & \dots  & \lambda_{n} \\
\vdots  & \vdots  & \ddots  & \vdots  \\
{\lambda}_{1}^{n-1} & {\lambda}_{2}^{n-1} & \dots & \lambda_{n}^{n-1}
\end{pmatrix}
\end{gathered}$$
The matrix $V$ is called the [[../ALG1/ALG1_008 הדטרמיננטה#דטרמיננטת ונדרמונד|Vandermonde matrix]]. We won't go about how the Cayley-Hamilton method is derived, but be assured, it has something to do with Cayley-Hamilton theorem.

### Real Diagonalization of a Matrix with Complex Eigenvalues

In both cases we need to find the [[../ALG1/ALG1_010 וקטורים עצמיים וערכים עצמיים#ערכים עצמיים ווקטורים עצמיים|eigenvalues]] of $\mathbf{A}$. If it has only real-valued eigenvalues, we're good - we already know how to approach such [[../ALG1/ALG1_010 וקטורים עצמיים וערכים עצמיים#לכסון|cases]].
But, if there is a pair of complex eigenvalues $\lambda_{i},\,\bar{\lambda}_{i}=\sigma\pm\omega j$, then we also have two complex conjugate eigenvectors $\mathbf{v}_{i},\bar{\mathbf{v}}_{i}=\boldsymbol{\alpha} \pm j\boldsymbol{\beta}$ where $\boldsymbol{\alpha},\boldsymbol{\beta}\in \mathbb{R}^{n}$ are real valued vectors.

We now show a special representation of the matrix called **real diagonalization** of a matrix with complex eigenvalues. We first define two linear combinations of our eigenvectors:
$$\begin{aligned}
\dfrac{\mathbf{v}_{i}+\bar{\mathbf{v}}_{i}}{2}\boldsymbol{\alpha} &  & \text{and} &  & \dfrac{\mathbf{v}_{i}-\bar{\mathbf{v}}_{i}}{2j}=\boldsymbol{\beta}
\end{aligned}$$
Defining
$$\begin{aligned}
\mathbf{T}=\begin{pmatrix}
\boldsymbol{\alpha} & \boldsymbol{\beta}
\end{pmatrix}  &  & \text{and} &  & \hat{\boldsymbol{\Lambda}}=\begin{pmatrix}
\sigma & \omega \\
-\omega & \sigma
\end{pmatrix}
\end{aligned}$$
we get that
$$\mathbf{A}=\mathbf{T} \hat{\boldsymbol{\Lambda}}\mathbf{T}^{-1}$$
When this form of "diagonalizing" of the entire matrix $\mathbf{A}$, we get $\boldsymbol{\Lambda}$ with either real eigenvalues or block of $2\times 2$ $\hat{\boldsymbol{\Lambda}}$-s on the main diagonal:
$$\boldsymbol{\Lambda}=\begin{pmatrix}
{\lambda}_{1} & 0 & 0 & 0 & \dots  \\
0 & {\sigma}_{2} & {\omega}_{2} & 0 & \dots  \\
0 & -{\omega}_{2} & {\sigma}_{2} & 0 & \dots  \\
0 & 0 & 0 & {\lambda}_{3} & \dots  \\
\vdots  & \vdots  & \vdots  & \vdots  & \ddots 
\end{pmatrix}$$
Now, we know that:
$$e^{\mathbf{A}t}=\mathbf{T}e^{\hat{\mathbf{A}}t}\mathbf{T}^{-1}=\mathbf{T}e^{\sigma t}\begin{pmatrix}
\cos(\omega t) & \sin(\omega t) \\
-\sin(\omega t) & \cos(\omega t)
\end{pmatrix}\mathbf{T}^{-1}$$
## Solution to State-Equation
Consider the function
$$x(t)=\int_{-\infty }^{t} e^{\mathbf{A}(t-s)}\mathbf{B}u(s) \, \mathrm{d}s $$

According to the [[../CAL1/CAL1_008 אינטגרל מסוים#נוסחת ניוטון-לייבניץ|Liebniz integral rule]], and the [[../CAL2/CAL2_006 נגזרות של פונקציות בשני משתנים#כלל השרשרת|chain rule]],
$$\dfrac{\mathrm{d}}{\mathrm{d}t}\int_{a(t)}^{b(t)} f(s,t) \, \mathrm{d}s=\int_{a(t)}^{b(t)} \dfrac{ \partial  }{ \partial t } f(s,t) \, \mathrm{d}s+\dfrac{\mathrm{d}b(t)}{\mathrm{d}t}f(b(t),\, t)-\dfrac{\mathrm{d}a(t)}{\mathrm{d}t}f(a(t),t)  $$
and the relation $\dfrac{ \partial  }{ \partial t }e^{\mathbf{A}(t-s)}=\mathbf{A}e^{\mathbf{A}(t-s)}$, we have that
$$\begin{aligned}
\dot{x}(t) & =\int_{-\infty }^{t} \mathbf{A}e^{\mathbf{A}(t-s)}\mathbf{B}u(s) \, \mathrm{d}s+e^{\mathbf{A}(t-t)}\mathbf{B}u(t)  \\[1ex]
 & =\mathbf{A}x(t)+\mathbf{B}u(t)
\end{aligned}$$
Which is exactly the state equation. We can plug it into the [[#Linear State-Space Equation]], to get its solution:
$$\boxed{y(t)=\int_{-\infty }^{t} \mathbf{C}e^{\mathbf{A}(t-s)}\mathbf{B}u(s) \, \mathrm{d}s +Du(t) }$$
and the [[#Impulse Response]] is given by:
$$\boxed {
g(t)=D\delta(t)+\mathbf{C}e^{\mathbf{A}t}\mathbf{B}\mathbb{1}(t)
 }$$

>[!example] Example:  Mass-Spring-Damper System
> ![[Pasted image 20240624192708.png|book]]
> >mass-spring-damper system. The mass is connected to a spring with stiffness $k$ and a *viscous* damper with damping coefficient $c$.
> 
> The input $u(t)$ to this system is the force applied to the mass, and the output is the position of the mass.
> Supposing zero spring and damper forces at $y=0$, by [[../PHY1/PHY1_003 חוקי ניוטון#חוק ניוטון השני|Newton's second law]]:
> $$m\ddot{y}(t)=u(t)-c\dot{y}(t)-c\dot{y}(t)$$
> Introducing the vector $x(t)=\begin{pmatrix}y(t)\\\dot{y}(t)\end{pmatrix}$ allows to describe the system by state-space representation:
> $$\begin{aligned}
>  & \dot{\mathbf{x}}(t)=\begin{pmatrix}
> 0 & 1 \\
> -k/m & -c/m
> \end{pmatrix}\mathbf{x}(t)+\begin{pmatrix}
> 0 \\
> 1/m
> \end{pmatrix}u(t) \\[2ex]
>  & y(t)=\begin{pmatrix}
> 1 & 0
> \end{pmatrix}\mathbf{x}(t)
> \end{aligned}$$
> If $m=1$:
> $$\begin{aligned}
>  & \dot{\mathbf{x}}(t)=\begin{pmatrix}
> 0 & 1 \\
> -k & -c
> \end{pmatrix}\mathbf{x}(t)+\begin{pmatrix}
> 0 \\
> 1
> \end{pmatrix}u(t) \\[2ex]
>  & y(t)=\begin{pmatrix}
> 1 & 0
> \end{pmatrix}\mathbf{x}(t)
> \end{aligned}$$
> We would like to find the impulse response of this system. Therefore, we need to look at $\mathbf{A}$:
> [[../ALG1/ALG1_010 וקטורים עצמיים וערכים עצמיים#ערכים עצמיים ווקטורים עצמיים|Eigenvalues]] of $\mathbf{A}$:
> 	$$\begin{gathered}
> \begin{vmatrix}
> \lambda \mathbf{I}-\mathbf{A}
> \end{vmatrix}=0 \\[1ex]
> \begin{vmatrix}
> \lambda & -1 \\
> k & \lambda+c
> \end{vmatrix}=0 \\[1ex]
> \lambda ^{2}+c\lambda+k=0 \\[1ex]
> {\lambda}_{1,2}=\dfrac{-c\pm \sqrt{ c^{2}-4k }}{2}
> \end{gathered}$$
> - If $c\neq 4k$, then ${\lambda}_{1}\neq{\lambda}_{2}$:
> 	$\mathbf{A}$ can be written as
> 	$$\mathbf{A}=\begin{pmatrix}
> {\lambda}_{1} & {\lambda}_{2} \\
> k & k
> \end{pmatrix}\begin{pmatrix}
> {\lambda}_{1} & 0 \\
> 0 & {\lambda}_{2}
> \end{pmatrix} \dfrac{1}{k({\lambda}_{1}-{\lambda}_{2})}\begin{pmatrix}
> k & -{\lambda}_{2} \\
> -k & {\lambda}_{1}
> \end{pmatrix}$$
> 	and its matrix exponential is
> 	$$e^{\mathbf{A}t}=\begin{pmatrix}
> {\lambda}_{1} & {\lambda}_{2} \\
> k & k
> \end{pmatrix}\begin{pmatrix}
> e^{{\lambda}_{1}t} & 0 \\
> 0 & e^{{\lambda}_{2}t}
> \end{pmatrix} \dfrac{1}{k({\lambda}_{1}-{\lambda}_{2})}\begin{pmatrix}
> k & -{\lambda}_{2} \\
> -k & {\lambda}_{1}
> \end{pmatrix}$$
> 	Therefore, the impulse response is:
> 	$$\begin{aligned}
> g(t) & =\begin{pmatrix}
> 1 & 0
> \end{pmatrix}\begin{pmatrix}
> {\lambda}_{1} & {\lambda}_{2} \\
> k & k
> \end{pmatrix}\begin{pmatrix}
> e^{{\lambda}_{1}t} & 0 \\
> 0 & e^{{\lambda}_{2}t}
> \end{pmatrix} \dfrac{1}{k({\lambda}_{1}-{\lambda}_{2})}\begin{pmatrix}
> k & -{\lambda}_{2} \\
> -k & {\lambda}_{1}
> \end{pmatrix}\begin{pmatrix}
> 0 \\
> 1
> \end{pmatrix}\mathbb{1}(t) \\[1ex]
>  & =\dfrac{1}{\sqrt{ c^{2}-4k }}(e^{{\lambda}_{1}t}-e^{{\lambda}_{2}t})\mathbb{1}(t)
> \end{aligned}$$
> 	If $c^{2}>4k$, we get ${\lambda}_{1}=\dfrac{-c+\sqrt{ c^{2}-4k }}{2}<0,\,{\lambda}_{2}=\dfrac{-c-\sqrt{ c^{2}-4k }}{2}<0$, and the impulse response looks like
> 	![[Pasted image 20240624201424.png|book]]
> 	which we call this *overdamping* - If the damping coefficient is significantly larger than the spring stiffness, when we jerk the mass to the right (we give it an impulse), the mass will slowly return back to its original position.
> 	
> 	If $c^{2}<4k$, we get ${\lambda}_{1}=\dfrac{-c+j\sqrt{ \lvert c^{2}-4k \rvert }}{2}$ and ${\lambda}_{2}=\dfrac{-c+j\sqrt{ \lvert c^{2}-4k \rvert }}{2}$. Let $\omega=\dfrac{\sqrt{ \lvert c^{2}-4k \rvert }}{2}$, then the impulse response is
> 	$$g(t)=\dfrac{1}{\omega}e^{-(c/2)t}\sin(\omega t)$$
> 	that looks like
> 	![[Pasted image 20240624210531.png|book]]
> 	which we call *underdamping* - when we jerk the mass to the right, the mass will oscillate back and forth.
> - If $c^{2}=4k$, then ${\lambda}_{1}={\lambda}_{2}=-\dfrac{c}{2}=-\sqrt{ k }$ and
> 	$$\begin{aligned}
>  & \mathbf{A}=\begin{pmatrix}
> 0 & 1 \\
> -k & -2\sqrt{ k }
> \end{pmatrix}=\begin{pmatrix}
> \sqrt{ k } & 1 \\
> -k & 0
> \end{pmatrix}\begin{pmatrix}
> -\sqrt{ k } & 1 \\
> 0 & -\sqrt{ k }
> \end{pmatrix} \dfrac{1}{k}\begin{pmatrix}
> 0 & -1 \\
> k & \sqrt{ k }
> \end{pmatrix} \\[2ex]
>  & e^{\mathbf{A}t}=\begin{pmatrix}
> \sqrt{ k } & 1 \\
> -k & 0
> \end{pmatrix}e^{-\sqrt{ k }t}\begin{pmatrix}
> 1 & t \\
> 0 & 1
> \end{pmatrix} \dfrac{1}{k}\begin{pmatrix}
> 0 & -1 \\
> k & \sqrt{ k }
> \end{pmatrix} \\[2ex]
>  & g(t)=te^{-\sqrt{ k }t}\mathbb{1}(t)
> \end{aligned}$$
> 	$g(t)$ look like
> 	![[Pasted image 20240624210944.png|book]]
> 	and is called *critical damping* - the boundary between overdamping and underdamping.
> 	![](https://www.youtube.com/watch?v=99ZE2RGwqSM)

# Transfer Function

A **transfer function** is a function that models the system's output for each possible input.
## Transfer Function to State Space

### Physical realization
Given a system with following **transfer function**:
$$\mathbf{y}^{(n)}+a_{n-1}\mathbf{y}^{(n-1)}+\dots +a_{2}\ddot{\mathbf{y}}+{a}_{1}\dot{\mathbf{y}}+{a}_{0}\mathbf{y}=b\mathbf{u}$$
then its possible state-space realization is:
$$\left( \begin{array}{c|c}
A & B \\
\hline C & D
\end{array} \right)=\left( \begin{array}{cccc|c}
0 & 1 & \dots  & 0 & 0 \\
\vdots  & \vdots  & \ddots  & \vdots  & \vdots \\
0 & 0 & \dots  & 1 & 0 \\
-{a}_{0} & -{a}_{1} & \dots  & -a_{n-1} & 1 \\
\hline1 & 0 & \dots  & 0 & 0
\end{array} \right)$$

### Canonical Realization

For the following ODE:
$$\mathbf{y}^{(n)}+a_{n-1}\mathbf{y}^{(n-1)}+\dots +a_{2}\ddot{\mathbf{y}}+{a}_{1}\dot{\mathbf{y}}+{a}_{0}\mathbf{y}=b_{n-1}\mathbf{u}^{(n-1)}+\dots +{b}_{2}\ddot{\mathbf{u}}+{b}_{1}\dot{\mathbf{u}}+{b}_{0}\mathbf{u}$$

The state-space realization discussed above, known as the **companion form**, is:
$$\left( \begin{array}{c|c}
A & B \\
\hline C & D
\end{array} \right)=\left( \begin{array}{cccc|c}
0 & 1 & \dots  & 0 & 0 \\
\vdots  & \vdots  & \ddots  & \vdots  & \vdots \\
0 & 0 & \dots  & 1 & 0 \\
-{a}_{0} & -{a}_{1} & \dots  & -a_{n-1} & b \\
\hline {b}_{0} & {b}_{1} & \dots  & b_{n-1} & 0 
\end{array} \right)$$
Its space-state realization in **observer form** has
$$\left( \begin{array}{c|c}
A & B \\
\hline C & D
\end{array} \right)=\left( \begin{array}{cccc|c}
-a_{n-1} & 1 & \dots  & 0 & b_{n-1} \\
\vdots  & \vdots  & \ddots  & \vdots  & \vdots  \\
-{a}_{1} & 0 & \dots  & 1 & {b}_{1} \\
-{a}_{0} & 0 & \dots  & 0 & {b}_{0} \\
\hline 1 & 0 & \dots  & 0 & 0
\end{array} \right)$$

If on the right side of the equation there is an $n$ derivative of $u$, that is there is a term $b_{n}u^{(n)}$ where $b_{n}\neq 0$, we can write the same canonical realization as for the system with $b_{n}=0$, and simple change $D=b_{n}$.


# Exercises
## Question 1
Consider the matrix:
$$\mathbf{A}=\begin{pmatrix}
4 & 0 & 1 \\
-1 & -6 & -2 \\
5 & 0 & 0
\end{pmatrix}$$

### Part a
Find the diagonalizing transformation of $\mathbf{A}$ (if the real form if it exists).

**Solution**:
First, calculate the characteristic polynomial:
$$\begin{gathered}
\begin{vmatrix}
\lambda \mathbf \\
{I}-\mathbf{A}
\end{vmatrix}=0 \\[1ex]
\begin{vmatrix}
\lambda-4 & 0 & -1 \\
1 & \lambda+6 & 2 \\
-5 & 0 & \lambda
\end{vmatrix} \\[1ex]
-5\begin{vmatrix}
0 & -1 \\
\lambda+6 & 2
\end{vmatrix}+ \lambda \begin{vmatrix}
\lambda-4 & 0 \\
1 & \lambda+6
\end{vmatrix}=0 \\[1ex]
-5(\lambda+6) +\lambda(\lambda-4)(\lambda+6)=0 \\[1ex]
(\lambda+6)[-5+\lambda ^{2}-4\lambda]=0 \\[1ex]
(\lambda+6)(\lambda-5)(\lambda+1)=0 \\[1ex]
\lambda=5,\, -6,\, -1
\end{gathered}$$
Now we can calculate the eigenvectos:
- For ${\lambda}_{1}=-6$:
	$$\begin{gathered}
(-6\mathbf{I}-\mathbf{A})\mathbf{v}=0 \\[1ex]
\begin{pmatrix}
-6-4 & 0 & -1 \\
1 & -6+6 & 2 \\
-5 & 0 & -6
\end{pmatrix}\mathbf{v}=0 \\[1ex]
\begin{pmatrix}
-10 & 0 & -1 \\
1 & 0 & 2 \\
-5 & 0 & -6
\end{pmatrix}\mathbf{v}=0 \\[1ex]
\mathbf{v}=\begin{pmatrix}
0 \\
1 \\
0
\end{pmatrix}
\end{gathered}$$
- For ${\lambda}_{2}=5$:
	$$\begin{gathered}
(5\mathbf{I}-\mathbf{A})\mathbf{v}=0 \\[1ex]
\begin{pmatrix}
5-4 & 0 & -1 \\
1 & 5+6 & 2 \\
-5 & 0 & 5
\end{pmatrix}\mathbf{v}=0 \\[1ex]
\begin{pmatrix}
1 & 0 & -1 \\
1 & 11 & 2 \\
-5 & 0 & 5
\end{pmatrix}\mathbf{v}=0 \\[1ex]
\mathbf{v}=\begin{pmatrix}
11 \\
-3 \\
11
\end{pmatrix}
\end{gathered}$$
- For ${\lambda}_{3}=-1$:
	$$\begin{gathered}
(-1\mathbf{I}-\mathbf{A})\mathbf{v}=0 \\[1ex]
\begin{pmatrix}
-1-4 & 0 & -1 \\
1 & -1+6 & 2 \\
-5 & 0 & -1
\end{pmatrix}\mathbf{v}=0 \\[1ex]
\begin{pmatrix}
-5 & 0 & -1 \\
1 & 5 & 2 \\
-5 & 0 & -1
\end{pmatrix}\mathbf{v}=0 \\[1ex]
\mathbf{v}=\begin{pmatrix}
-5 \\
-9 \\
25
\end{pmatrix}
\end{gathered}$$
Hence, the diagonalizing transformation of $\mathbf{A}$:
$$\boxed {
\mathbf{T}=\begin{pmatrix}
0 & 11 & -5 \\
1 & -3 & -9 \\
0 & 11 & 25
\end{pmatrix}
 }$$
And:
$$\boxed {
\boldsymbol{\Lambda}_{A}=\mathbf{T}^{-1}\mathbf{A}\mathbf{T}=\begin{pmatrix}
-6 &0 &0  \\
0 & 5 & 0 \\
 0& 0 & -1
\end{pmatrix}
 }$$
### Part b
Calculate the matrix exponent $e^{\mathbf{A}t}$ using diagonalization.

**Solution**:
We'll [[#Calculating the Matrix Exponent|find]] $e^{\boldsymbol{\Lambda}t}$ first:

$$e^{\boldsymbol{\Lambda}t}=\begin{pmatrix}
e^{-6t} & 0 & 0 \\
0 & e^{-5t} & 0 \\
0 & 0 & e^{-t}
\end{pmatrix}$$
All that's left is pain:
$$\boxed {
e^{\mathbf{A}t}=\mathbf{T}e^{\boldsymbol{\Lambda }t}\mathbf{T}^{-1}
 }$$
### Part c
Calculate the matrix exponent $e^{\mathbf{A}t}$ using Cayley-Hamilton.

**Solution**:
According to [[#Calculating the Matrix Exponent|Cayley-Hamilton]], we know that:
$$e^{\mathbf{A}t}=\sum_{i=0}^{2}g_{i}\mathbf{A}^{i} $$
	Using $\lambda_{i}$, we can find that these coefficients satisfy:
	$$\begin{aligned}
 & e^{{\lambda}_{1}t}={g}_{0}+{g}_{1}{\lambda}_{1}+{g}_{2}{{\lambda}_{1}}^{2} \\[1ex]
 & e^{{\lambda}_{2}t}={g}_{0}+{g}_{1}{\lambda}_{2}+{g}_{2}{{\lambda}_{2}}^{2} \\[1ex]
 & e^{{\lambda}_{3}t}={g}_{0}+{g}_{1}{\lambda}_{3}+{g}_{2}{{\lambda}_{3}}^{2}
\end{aligned}$$
We can write it as:
$$\begin{gathered}
\begin{pmatrix}
e^{-6t} \\
e^{5t} \\
e^{-t}
\end{pmatrix}=\begin{pmatrix}
{g}_{0} \\
{g}_{1} \\
{g}_{1}
\end{pmatrix}\begin{pmatrix}
1 & 1 & 1 \\
{\lambda}_{1} & {\lambda}_{2} & {\lambda}_{3} \\
{{\lambda}_{1}}^{2} & {{\lambda}_{2}}^{2} & {{\lambda}_{3}}^{2}
\end{pmatrix} \\[1ex]
\begin{pmatrix}
e^{-6t} \\
e^{5t} \\
e^{-t}
\end{pmatrix}=\begin{pmatrix}
{g}_{0} \\
{g}_{1} \\
{g}_{1}
\end{pmatrix}\begin{pmatrix}
1 & 1 & 1 \\
-6 & 5 & -1 \\
36 & 25 & 1
\end{pmatrix} 
\end{gathered}$$
We can move $\mathbf{g}$ to the left side:
$$\begin{pmatrix}
{g}_{0} \\
{g}_{1} \\
{g}_{2}
\end{pmatrix}=\begin{pmatrix}
e^{-6t} \\
e^{5t} \\
e^{-t}
\end{pmatrix}\begin{pmatrix}
1 & 1 & 1 \\
-6 & 5 & -1 \\
36 & 25 & 1
\end{pmatrix}^{-1}$$
Remember the obscure matrix operation to find its inverse, the [[../ALG1/ALG1_008 הדטרמיננטה#אלגוריתם מציאת הופכי ע"י הצמדה|adjoint matrix]]? Here you go:
$$\begin{pmatrix}
{g}_{0} \\
{g}_{1} \\
{g}_{2}
\end{pmatrix}=\begin{pmatrix}
e^{-6t} \\
e^{5t} \\
e^{-t}
\end{pmatrix} \dfrac{1}{330}\mathrm{adj}\begin{pmatrix}
1 & 1 & 1 \\
-6 & 5 & -1 \\
36 & 25 & 1
\end{pmatrix}$$

And we get:
$$\begin{aligned}
 & {g}_{0}=\dfrac{1}{330}(-30e^{-6t}+330e^{-t}+30e^{5t}) \\[1ex]
 & {g}_{1}=\dfrac{1}{330}(6e^{-t}-11e^{-t}+5e^{5t}) \\[1ex]
 & {g}_{2}=\dfrac{1}{330}(-24e^{-6t}-11e^{-t}+35e^{5t})
\end{aligned}$$
All that's left is pain:
$$\boxed {
e^{\mathbf{A}t}={g}_{0}\mathbf{I}+{g}_{1}\mathbf{A}+{g}_{2}\mathbf{A}^{2}
 }$$

## Question 2

Consider the following ODE:
$$\ddot{y}+2\dot{y}+5y=u$$

### Part a
Perform a reduction of order to the ODE and write it down in state-space form.

**Solution**:
Define:
$$\begin{gathered}
\begin{pmatrix}
{x}_{1} \\
{x}_{2}
\end{pmatrix}=\begin{pmatrix}
y \\
\dot{y}
\end{pmatrix} \\[1ex]
\begin{pmatrix}
\dot{{x}_{1}} \\
\dot{{x}_{2}}
\end{pmatrix}=\begin{pmatrix}
{x}_{2} \\
u-5{x}_{1}-2{x}_{2}
\end{pmatrix}
\end{gathered}$$
In [[LSY1_001 Introduction#State-Space Linear Systems|state-space form]]:
$$\boxed {
\begin{aligned}
 & \dot{\mathbf{x}}=\begin{pmatrix}
0 & 1 \\
-5 & -2
\end{pmatrix}\mathbf{x}+\begin{pmatrix}
0 \\
1
\end{pmatrix}\mathbf{u} \\[1ex]
 & y=\begin{pmatrix}
1 & 0
\end{pmatrix}\mathbf{x}
\end{aligned}
 }$$

### Part b
Find the diagonalizing transformation (in the real form if it exists) of the $\mathbf{A}$ matrix

**Solution**:
First, we'll find the eigenvalues:
$$\begin{gathered}
\begin{aligned}
\begin{vmatrix}
\lambda \mathbf{I}-\mathbf{A}
\end{vmatrix}=\begin{vmatrix}
\lambda & -1 \\
5 & \lambda+2
\end{vmatrix}=\lambda ^{2}+2\lambda+5=0
\end{aligned} \\[1ex]
{\lambda}_{1,2}=\dfrac{-2\pm \sqrt{ 4-20 }}{2}=-1\pm 2j
\end{gathered}$$
The corresponding eigenvectors:
- for ${\lambda}_{1}=-1+2j$:
	$$\begin{pmatrix}
(-1+2j)\mathbf{I}-\mathbf{A}
\end{pmatrix}\mathbf{v}_{1}=\begin{pmatrix}
-1+2j & -1 \\
5 & 1+2j
\end{pmatrix}\mathbf{v}_{1}=0$$
	If we choose $v_{1,2}=1$, we get
$$v_{1,1}=-1/5-(2/5)j$$
	therefore:
	$$\mathbf{v}_{1}=\begin{pmatrix}
-1/5 \\
1
\end{pmatrix}+\begin{pmatrix}
-2/5 \\
0
\end{pmatrix}j$$
- for ${\lambda}_{2}=-1-2j$:
	$$\begin{pmatrix}
(-1-2j)\mathbf{I}-\mathbf{A}
\end{pmatrix}\mathbf{v}_{2}=\begin{pmatrix}
-1-2j & -1 \\
5 & 1-2j
\end{pmatrix}\mathbf{v}_{2}=0$$
	If we choose $v_{2,2}=2$, we get
	$$v_{2,1}=-1/5+(2/5)j$$
	therefore:
	$$\mathbf{v}_{2}=\begin{pmatrix}
-1/5 \\
1
\end{pmatrix}+\begin{pmatrix}
2/5 \\
0
\end{pmatrix}j$$

Since we have complex eigenvectors, we need to perform a [[#Real Diagonalization of a Matrix with Complex Eigenvalues|real diagonalization]]. Define:
$$\begin{aligned}
\boldsymbol{\alpha}=\begin{pmatrix}
-1/5 \\
1
\end{pmatrix}  &  & \boldsymbol{\beta}=\begin{pmatrix}
-2/5 \\
0
\end{pmatrix}
\end{aligned}$$
Therefore:
$$\mathbf{T}=\begin{pmatrix}
\boldsymbol{\alpha} & \boldsymbol{\beta}
\end{pmatrix}=\begin{pmatrix}
-1/5 & -2/5 \\
1 & 0
\end{pmatrix}$$
And the real diagonal matrix is:
$$\boxed {
\boldsymbol{\Lambda}=\begin{pmatrix}
-1 & 2 \\
-2 & -1
\end{pmatrix}
 }$$

### Part c
Find the matrix exponential $e^{\mathbf{A}t}$.

**Solution**:
We know that:
$$e^{\mathbf{A}t}=\mathbf{T}e^{\boldsymbol{\Lambda}t}\mathbf{T}^{-1}$$
Substituting from previous answers:
$$\begin{aligned}
e^{\mathbf{A}t} & =\begin{pmatrix}
-1/5 & -2/5 \\
1 & 0
\end{pmatrix}\exp\left[\begin{pmatrix}
-1 & 2 \\
-2 & -1
\end{pmatrix}t\right]\begin{pmatrix}
-1/5 & -2/5 \\
1 & 0
\end{pmatrix}^{-1}
\end{aligned}$$
For a $2\times 2$ matrix, we can calculate the inverse using [[../ALG1/ALG1_008 הדטרמיננטה#אלגוריתם מציאת הופכי ע"י הצמדה|adjoint matrix]]:
$$\begin{aligned}
e^{\mathbf{A}t} & =\begin{pmatrix}
-1/5 & -2/5 \\
1 & 0
\end{pmatrix}e^{-t}\begin{pmatrix}
\cos (2t) & \sin(2t) \\
-\sin(2t) & \cos(2t)
\end{pmatrix} \dfrac{1}{2/5}\begin{pmatrix}
0  & 2/5 \\
-1 & -1/5
\end{pmatrix}  \\[2ex]
 & =\begin{pmatrix}
-1/5 & -2/5 \\
1 & 0
\end{pmatrix}e^{-t}\begin{pmatrix}
\cos (2t) & \sin(2t) \\
-\sin(2t) & \cos(2t)
\end{pmatrix} \dfrac{1}{2}\begin{pmatrix}
0  & 2 \\
-5 & -1
\end{pmatrix}
\end{aligned}$$
we get:
$$\boxed{e^{\mathbf{A}t}=\dfrac{1}{2}e^{-t}\begin{pmatrix}
\sin(2t)+2\cos(2t) & \sin(2t) \\
-5\sin(2t) & 2\cos(2t)-\sin(2t)
\end{pmatrix} }$$

### Part d
Find the impulse response. hint:
$$y(t)=\mathbf{C}\int_{-\infty }^{t} e^{\mathbf{A}(t-s)}\mathbf{B}\mathbf{u}(s) \, \mathrm{d}s+D\mathbf{u}(t) $$

**Solution**:
The [[#Impulse Response]] $g$ is given by:
$$g(t)=\mathbf{C}e^{\mathbf{A}t}\mathbf{B}\mathbb{1}(t)+D\delta(t)$$
In our case:
$$\begin{aligned}
g(t) & =\begin{pmatrix}
1 & 0
\end{pmatrix}e^{\mathbf{A}t}\begin{pmatrix}
0 \\
1
\end{pmatrix}\mathbb{1}(t) \\[2ex]
 & =\begin{pmatrix}
1 & 0
\end{pmatrix}\dfrac{1}{2}e^{-t}\begin{pmatrix}
\sin(2t)+2\cos(2t) & \sin(2t) \\
-5\sin(2t) & 2\cos(2t)-\sin(2t)
\end{pmatrix}\begin{pmatrix}
0 \\
1
\end{pmatrix}\mathbb{1}(t) \\[2ex]
 & =\dfrac{1}{2}e^{-t}\begin{pmatrix}
\sin(2t)+2\cos(2t) & \sin(2t)
\end{pmatrix}\begin{pmatrix}
0 \\
1
\end{pmatrix}\mathbb{1}(t)
\end{aligned}$$
we get:
$$\boxed{g(t)=\dfrac{1}{2}e^{-t}\sin(2t)\mathbb{1}(t) }$$

### Part e
Determine whether this system is BIBO stable.

**Solution**:
To find whether a system is [[#Stability via Impulse Responses|BIBO]] stable, we can check if $g\in L_{1}$:
$$\lVert g \rVert _{1}=\int_{-\infty }^{\infty } \lvert \dfrac{1}{2}e^{-t}\sin(2t)\mathbb{1}(t)  \rvert\,\mathrm{d}t= \dfrac{1}{2} \int_{0 }^{\infty } \lvert e^{-t}\sin(2t) \rvert \, \mathrm{d}t  $$
We know that $\sin(2t)\leq1$. Therefore, we get
$$\begin{aligned}
\dots \leq  \dfrac{1}{2}\int_{0}^{\infty } \lvert e^{-t} \rvert \, \mathrm{d}t=-\dfrac{e^{-\infty }}{2}+\dfrac{e^{-0}}{2}=\dfrac{1}{2} 
\end{aligned}$$
and can conclude that $g\in {L}_{1}$. That is, the system is BIBO stable.

## Question 3
Let $A$ be the matrix:
$$A=\begin{pmatrix}
1 & 2 & -8 \\[1ex]
0 & -1 & 4 \\
0 & -1 & -1
\end{pmatrix}$$

### Part a
Find the diagonalizing transformation (in the real form if it exists).

**Solution**:

We first find the eigenvectors and eigenvalues:
$$\begin{vmatrix}
\lambda-1 & -2 & 8 \\
0 & \lambda+1 & -4 \\
0 & 1 & \lambda+1
\end{vmatrix}=(\lambda-1)\begin{vmatrix}\lambda+1 & -4 \\
1 & \lambda+1
\end{vmatrix}=(\lambda-1)(\lambda ^{2}+2\lambda+5)$$
Therefore, the eigenvalues are:
$${\lambda}_{1}=1,\, {\lambda}_{2}=-1+2j,\, {\lambda}_{3}=-1-2j$$
Now, to find the eigenvectors:
- For ${\lambda}_{1}=1$:
	$$\left(\begin{array}{ccc|c}
0 & -2 & 8  & 0\\
0 & 2 & -4  & 0\\
0 & 1 & 2 & 0
\end{array}\right)\xrightarrow[]{}\left(\begin{array}{ccc|c}
0 & -2 & 8 & 0 \\
0 & 0 & 4 & 0 \\
0 & 0 & 6 & 0
\end{array}\right)\xrightarrow[]{}\left(\begin{array}{ccc|c}
0 & 1 & -4 & 0 \\
0 & 0 & 1 & 0
\end{array}\right)$$
	which means $\boldsymbol{\eta}_{1}=\begin{pmatrix}1\\0\\0\end{pmatrix}$
- For ${\lambda}_{2}=-1+2j$:
	$$\begin{aligned}
	 & \left(\begin{array}{ccc|c}
	-2+2j & -2 & 8 & 0 \\
	0 & 2j & -4  & 0\\
	0 & 1 & 2j & 0
	\end{array}\right) \xrightarrow[]{}\left(\begin{array}{ccc|c}
	-2+2j & -2 & 8 & 0 \\
	0 & 2j & -4 & 0 \\
	0 & 0 & 0 & 0
	\end{array}\right) \\[3ex]
	 & \qquad  \xrightarrow[]{}\left(\begin{array}{ccc|c}
	-1+1j & -1 & 4 & 0 \\
	0 & j & -2 & 0 \\
	0 & 0 & 0  & 0
	\end{array}\right)
	\end{aligned}$$
	which means $\boldsymbol{\eta}_{2}=\begin{pmatrix}1+3j\\-2j\\1\end{pmatrix}$
- For ${\lambda}_{3}=-1-2j$, we know that $\boldsymbol{\eta}_3$ is the complex conjugate of $\boldsymbol{\eta}_{2}$, which means $\boldsymbol{\eta}_{3}=\begin{pmatrix}1-3j\\2j\\1\end{pmatrix}$.

The [[#Real Diagonalization of a Matrix with Complex Eigenvalues|real diagonal]] matrix is:
$$\boxed {
\boldsymbol{\Lambda}=\begin{pmatrix}
1 & 0 & 0 \\
0 & -1 & 2 \\
0 & -2 & -1
\end{pmatrix}
 }$$
And the transformation matrix is:
$$\boxed {
\mathbf{T}=\begin{pmatrix}
1 & 1 & 3 \\
0  & 0 & -2\\
0 & 1 & 0
\end{pmatrix}
 }$$

### Part b
Find the matrix exponential $e^{At}$.

**Solution**:
Now we can find the [[#Calculating the Matrix Exponent|matrix exponent]]:
$$\begin{aligned}
e^{\mathbf{A}t} &=\mathbf{T}e^{\boldsymbol{\Lambda}t}\mathbf{T}^{-1} \\[1ex]
 & =\begin{pmatrix}
1 &  1 & 3 \\
0 & 0 & -2 \\
0 & 1 & 0
\end{pmatrix}\begin{pmatrix}
e^{t} & 0 & 0 \\
0 & e^{-t}\cos(2t) & e^{-t}\sin(2t) \\
 & -e^{-t}\sin(2t) & e^{-t}\cos(2t)
\end{pmatrix}\begin{pmatrix}
1 & 1 & 3 \\
0 & 0 & -2 \\
0 & 1 & 0
\end{pmatrix}^{-1}
\end{aligned}$$

No real point in developing this any further.

## Question 4
Given the following second-order differential equation
$$\ddot{y}(t)+y(t)=u(t)$$
### Part a
Find a physical state-space realization.

**Solution**:
Define
$$\mathbf{x}=\begin{pmatrix}
{x}_{1} \\
{x}_{2}
\end{pmatrix}=\begin{pmatrix}
y \\
\dot{y}
\end{pmatrix}$$
so we can write (using [[../DEQ1/DEQ1_006 משוואות לינאריות הומוגניות מסדר גבוה#אלגוריתם שיטת הורדת הסדר|reduction of order]]):
$$\begin{gathered} 
\dot{x}_{2}(t)+{x}_{1}(t)=u(t) \\[1ex]
\dot{x}_{2}=-{x}_{1}(t)+u(t) \\[1ex]
\Updownarrow \\
\begin{pmatrix}
\dot{x}_{1} \\
\dot{x}_{2}
\end{pmatrix}=\begin{pmatrix}
0 & 1 \\
-1 & 0
\end{pmatrix}\begin{pmatrix}
{x}_{1} \\
{x}_{2}
\end{pmatrix}+\begin{pmatrix}
0 \\
1
\end{pmatrix}u(t)
\end{gathered}$$
Or, using the [[#Physical realization|formula]]:
$$\boxed {
\begin{aligned}
\mathbf{A}=\begin{pmatrix}
0 & 1 \\
-1 & 0
\end{pmatrix}  &  & \mathbf{B}=\begin{pmatrix}
0 \\
1
\end{pmatrix} &  & \mathbf{C}=\begin{pmatrix}
1 & 0
\end{pmatrix} &  & D=0
\end{aligned}
 }$$

### Part b
Use this state-space model to calculate the impulse response of the system.

**Solution**:
The impulse response can be [[#Solution to State-Equation|given]] by:
$$g(t)=D\delta(t)+\mathbf{C}e^{\mathbf{A}t}\mathbf{B}\mathbb{1}(t)$$
In our case:
$$g(t)=\begin{pmatrix}
1 & 0
\end{pmatrix}\exp\left[ \begin{pmatrix}
0 & 1 \\
-1 & 0
\end{pmatrix} t\right]\begin{pmatrix}
0 \\
1
\end{pmatrix} \mathbb{1}(t)$$
We have [[#Special Matrix Exponential|seen]] that
$$\exp\left[ \begin{pmatrix}
\sigma & \omega \\
-\omega & \sigma
\end{pmatrix}t \right]=e^{\sigma t}\begin{pmatrix}
\cos(\omega t) & \sin(\omega t) \\
-\sin(\omega t) & \cos(\omega t)
\end{pmatrix}$$
so in our case:
$$\begin{gathered}
g(t)=\begin{pmatrix}
1 & 0
\end{pmatrix}e^{0}\begin{pmatrix}
\cos t & \sin t \\
-\sin t & \cos t
\end{pmatrix}\begin{pmatrix}
0 \\
1
\end{pmatrix}\mathbb{1}(t) \\[1ex]
\boxed {
g(t)=\sin t\,\mathbb{1}(t)
 }
\end{gathered}$$


## Question 5
Consider the following ODE:
$$\ddot{y}(t)+5\dot{y}(t)+6y(t)=\ddot{x}(t)+2\dot{x}(t)+x(t)$$

### Part a
Find the state-space realization in companion form.

**Solution**:
According to the [[#Canocial Realization|formula]]:
$$\begin{aligned}
\mathbf{A}=\begin{pmatrix}
0 & 1 \\
-6 & -5
\end{pmatrix} &  & \mathbf{B}=\begin{pmatrix}
0 \\
1
\end{pmatrix} &  & \mathbf{C}=\begin{pmatrix}
1 & 2
\end{pmatrix} &  & D=1
\end{aligned}$$

### Part b
Use the following transformation matrix to get a similar realization:
	$$\mathbf{T}=\begin{pmatrix}
1 & 2 \\
-7 & 1
\end{pmatrix}$$

What does this similar realization correspond to?

**Solution**:
The inverse of $\mathbf{T}$ (using [[../ALG1/ALG1_008 הדטרמיננטה#אלגוריתם מציאת הופכי ע"י הצמדה|adjoint]]):
$$\mathbf{T}^{-1}=\dfrac{1}{1+14}\begin{pmatrix}
1 & -2 \\
7 & -1
\end{pmatrix}=\dfrac{1}{15}\begin{pmatrix}
1 & -2 \\
7 & -1
\end{pmatrix}$$

So the similar realization:
$$\begin{aligned}
\mathbf{A}' & =\mathbf{T}\mathbf{A}\mathbf{T}^{-1}=\begin{pmatrix}
1 & 2 \\
-7 & 1
\end{pmatrix}\begin{pmatrix}
0 & 1 \\
-6 & -5
\end{pmatrix} \dfrac{1}{15}\begin{pmatrix}
1 & -2 \\
7 & 1
\end{pmatrix} \\[2ex]
 & =\dfrac{1}{15}\begin{pmatrix}
-12 & -9 \\
-6 & -12
\end{pmatrix}\begin{pmatrix}
1 & -2 \\
7 & 1
\end{pmatrix} \\[2ex]
 & =\dfrac{1}{15}\begin{pmatrix}
-75 & 15 \\
-90 & 0
\end{pmatrix} \\[2ex]
 & =\begin{pmatrix}
-5 & 1 \\
-6 & 0
\end{pmatrix}
\end{aligned}$$
The similar realization correspond the observer form of the canonical realization.