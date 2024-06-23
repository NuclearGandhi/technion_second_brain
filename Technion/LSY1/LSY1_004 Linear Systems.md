---
aliases:
---
# Impulse Response
The **impulse response** of a dynamic system is its output when presented with a brief input signal ([[LSY1_002 Signals and Convolutions#The Delta Function|unit impulse]]) - $\delta (t)$. More generally, an impulse response is the reaction of any dynamic system in response to some external change.
![[LSY1_004/Pasted image 20240616155903.png|book|400]]
>The impulse response from a simple audio system. Showing, from top to bottom, the original impulse, the response after high frequency boosting, and the response after low frequency boosting.

The output of a CLTI system is completly determined by the input and the system's response to a unit impulse.
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
Although we have shown the the solution of a linear set of differential equations defines a linear input/output system, we have not fully computed the solution of the system.
In fact, it can be shown that the solution of such  system is:
$$y(t)=\int_{-\infty }^{t} \mathbf{C}e^{\mathbf{A}(t-s)}\mathbf{B}u(s) \, \mathrm{d}s+Du(t) $$
Where we have a **matrix exponential** - $e^{\mathbf{A}}$. To show that this is the solution of the given ODE, we first need to go over what is a matrix exponential.
# The Matrix Exponential
![](https://www.youtube.com/watch?v=O85OWBJ2ayo&t=4s)

>[!def] Definition: 
 >The **matrix exponential** is defined as the infinite series
 >$$e^{X}=I+X+\dfrac{1}{2}X^{2}+\dfrac{1}{3!}X^{3}+\dots =\sum_{k=0}^{\infty} \dfrac{1}{k!}X^{k} $$
 >where $X \in \mathbb{R}^{n\times n}$.
 
 It can be shown that the series in the definition converges for any matrix $X \in \mathbb{R}^{n\times n}$ in the same way that the normal exponential is defined for any scalar $a\in \mathbb{R}$.

>[!example] Example: 
>Compute the matrix $e^{At}$ if the matrix $A$ has the form
>1. $$A=\begin{pmatrix}
1 & 0 \\
0 & 2
\end{pmatrix}$$
>2. $$\begin{pmatrix}
0 &  1\\
0 & 0
\end{pmatrix}$$
>
>**Solution**:


>[!TODO] להשלים 
 >