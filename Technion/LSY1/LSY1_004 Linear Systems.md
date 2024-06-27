---
aliases:
---
# Impulse Response
The **impulse response** of a dynamic system is its output when presented with a brief input signal ([[LSY1_002 Signals and Convolutions#The Delta Function|unit impulse]]) - $\delta (t)$. More generally, an impulse response is the reaction of any dynamic system in response to some external change.
![[LSY1_004/Pasted image 20240616155903.png|book|400]]
>The impulse response from a simple audio system. Showing, from top to bottom, the original impulse, the response after high frequency boosting, and the response after low frequency boosting.

The output of a CLTI system is completely determined by the input and the system's response to a unit impulse.
![[LSY1_004/LSY1_004 Time Domain Analysis 2024-06-16 16.23.35.excalidraw.svg]]
>We can determine the system's output $y(t)$ if we know the system's impulse response $g(t)$ and the input $f(t)$.

In fact, we can show that by *convolving* the input $u(t)$ with the impulse reponse of the system $g(t)$ we get the system's output $y(t)$:
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
>A CLTI system with the impulse response $g$ is causal iff $\sup(g)\geq 0$

**Proof**:
The response $y=g*t$ reads at every $t$ as
$$\begin{aligned}
y(t) & =\int_{-\infty }^{\infty } g(t-s)u(s) \, \mathrm{d}s \\[1ex]
 & =\underbrace{ \int_{-\infty }^{t} g(t-s)u(s) \, \mathrm{d}s }_{ \text{past and present} }+\underbrace{ \int_{t}^{\infty} g(t-s)u(s) \, \mathrm{d}s }_{ \text{future} }
\end{aligned}$$

The future term zeros out iff $g(t-s)=0$ for all $s>t$. i.e., $g(t)=0$ for all $t<0$, which is equivalent to saying $\sup(g)\geq 0$.
Thus, $y(t)$ cannot depend on $u(s)$ for $s>t$ iff $\sup(g)\geq 0$ - the system is causal.
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

>[!example] Example:  Spring Mass system
> ![[Pasted image 20240624192708.png|book]]
> >Mass-spring-damper system. The mass is connected to a spring with stiffness $k$ and a *viscous* damper with damping coefficient $c$.
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



>[!TODO] להשלים מתרגול 
 >