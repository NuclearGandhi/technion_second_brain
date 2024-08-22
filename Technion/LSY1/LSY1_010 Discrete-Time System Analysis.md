---
aliases:
  - z-transform
  - ROC
---
# Introduction
From [[LSY1_000 034032 Linear Systems E#Bibliography|(Lathi & Green, 2018)]]:
The counterpart of the [[LSY1_007 Laplace Transform#The Laplace Transform|Laplace transform]] for discrete-time systems is the $z$-transform. The Laplace transform converts integro-differential equations into algebraic equations. In the same way, the z-transforms changes difference equations into algebraic equations, thereby simplifying the analysis of discrete-time systems.

The behavior of discrete-time systems is similar to that of continuous-time systems (with some differences). The frequency-domain analysis of discrete-time systems is based on the fact that the response of a linear, time-invariant, discrete-time (LTID) system to an everlasting exponential $z^{n}$ is the same exponential (within a multiplicative constant) given by $H[z]z^{n}$. We then express an input $x[n]$ as a sum of (everlasting) exponentials of the form $z^{n}$.The system response to $x[n]$ is then found as a sum of the system’s responses to all these exponential components. The tool that allows us to represent an arbitrary input $x[n]$ as a sum of (everlasting) exponentials of the form $z^{n}$ is the $z$-transform.

# The $z$-Transform

We define $X(z)$, the direct $z$-transform of $x[n]$ as:
$$X(z)=\sum_{n=-\infty }^{\infty }x[n]z^{-n}$$
where $z$ is a complex variable ($z\in \mathbb{C}$). The signal $x[n]$, which is the inverse $z$-transform of $X(z)$, can be obtained from $X(z)$ by using the following inverse $z$-transformation:
$$x[n]=\dfrac{1}{2\pi j}\oint X(z)z^{n-1}\,\mathrm{d}z$$
Symbolically:
$$\begin{aligned}
X(z)=\mathcal{Z}\{ x[n] \} &  & \text{and} &  & x(t)=\mathcal{Z}^{-1}\{ X(z) \}
\end{aligned}$$
Note that
$$\begin{aligned}
\mathcal{Z}^{-1}\{ \mathcal{Z}[x[n] \}=x[n] &  & \text{and} &  & \mathcal{L}\{ \mathcal{L}^{-1}\{ X(z) \} \}=X(z)
\end{aligned}$$

## Region of Convergence (ROC)
>[!def] Definition: 
 >The **region of convergence**, also called the **region of existence**, for the the $z$-transform $X(z)$, is the set of values of $s$ (the region in the complex plane) for which the sum $\sum_{n=-\infty}^{\infty}x[n]z^{-n}$ converges.
 
# Final and Initial Values Theorems

>[!theorem] theorem: 
> Given a discrete signal $x:\mathbb{Z}\to \mathbb{F}$ with $\mathrm{supp}(x) \subset \mathbb{Z}_{+}$, the initial and final value theorems are as follows:
> 1. **Initial value theorem**:
> 	$$x[0]=\lim_{ z\in \mathbb{R},\, z \to \infty}X(z)$$
> 	assuming $x[0]$ exists.
> 2. **Final value theorem**:
> 	$$\lim_{ t \to \infty}x[n]=\lim_{ z \to 1}X(n)$$
> 	assuming $x$ is converging.


# Causality and Stability

## Jury table


>[!warning] Attention: 
 >For the exam, we won't need to use this table, Christian specifically said that using Routh table will be enough. This is why it's not in the cheat sheet.

>[!def] Definition: 
> Given the polynomial $D(z)=a_{n}z^{n}+a_{n-1}z^{n-1}+\dots+{a}_{1}z+{a}_{0}$, the associated Jury table is
> 
> $$\begin{array}{c|ccc}
>  0 & {j}_{0,1}=a_{n} & {j}_{0,2}=a_{n-1} & \dots  & j_{0,n}=a_{1} & j_{0,n+1}={a}_{0} \\[1ex]
>  & j_{0,n+1}={a}_{0} & j_{0,n}={a}_{1} & \dots  & j_{0,2}=a_{n-1} & j_{0,1}=a_{n}  \\[1ex]
> \hline 1  & j_{1,1} & j_{1,2} & \dots  & j_{1,n} \\[1ex]
>  & j_{1,n} & j_{1,n-1} & \dots  & j_{1,1} \\[1ex]
>  \vdots  & \vdots  & \vdots  \\[1ex]
> \hline n-1 & j_{n-1,1} & j_{n-1,2} \\[1ex]
>  & j_{n-1,2} & j_{n-1,1} \\[1ex]
> \hline n & j_{n,1}
>  \end{array}$$
>  
>  where for each $i=1,2,3,\dots,n$:
>  $$[j_{i,1} \,\cdots \,j_{i,n+1-i} ]=[j_{i-1,1}\, \cdots\,\, j_{i-1,n+1-i} ]-\dfrac{j_{i-1,n+2-i}}{j_{i-1,1}}[j_{i-1,n+2-i}\,\cdots \, j_{i-1,2} ]$$
>  (the $i$-th row has $n+1-i$ elements). The Jury is said to be:
>  - **regular** if all $j_{i,1}\neq 0$, and
>  - **singular** otherwise.
> 

## Necessary and Sufficient Condition for Stability

>[!theorem] Theorem: 
> Consider a polynomial in $z$ with $a_{n}>0$:
> $$D(z)=a_{n}z^{n}+a_{n-1}z^{n-1}+\dots +{a}_{1}z+{a}_{0}$$
> - $D(z)$ is [[LSY1_007 Laplace Transform#Categorizing Polynomials|Schur]] iff the associated Jury table is regular and all the elements of the first column are positive.
> - If the Jury table is regular, then $D(z)$ has no roots on the unit circle $\{ z\in \mathbb{C}\mid \lvert z \rvert=1 \}$ and the number of poles outside of the unit circle $\{ z\in \mathbb{C} \mid \lvert z \rvert>1 \}$ equals the number of negative elements in the first column of the table.
> - If the Jury table is singular, then $D(z)$ is not Schur. Is this case, we cannot say anything about the location of the poles, except that there is at least one pole in $\{ z\in \mathbb{C}\mid \lvert z \rvert\geq 1 \}$.

## Bilinear Transformation


>[!theorem] Theorem: 
 >
> The transformation $z=\dfrac{1+s}{1-s}\iff s=\dfrac{z-1}{z+1}$ enables to use the transform continuous system for the analysis of the discrete time system, such that:
> 1. for a given transfer function $D(z)$, ${s}_{0}$ is a root of $\tilde{D}(s)$ iff ${z}_{0}=(1+{s}_{0})/(1-{s}_{0})$ is a root of $D(z)$.
> 2. $D(z)$ is Schur iff $\tilde{D}(s)$ is Hurwitz.


# Exercises

## Question 1

>[!TODO] להשלים