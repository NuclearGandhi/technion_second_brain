---
aliases:
  - Laplace transform
  - region of convergence
  - ROC
  - Laplace transform table
  - partial fraction expansion
  - final value theorem
  - initial value theorem
  - transfer function
  - steady-state
  - transient response
  - transient characteristics
  - overshoot
  - undershoot
  - first-order system transfer function
  - second-order system transfer function
  - routh table
  - causality and stability in CLTI
  - Hurwitz
  - Schur
  - monic
---
# Introduction
From [[LSY1_000 034032 Linear Systems E#Bibliography|(Lathi & Green, 2018)]]:
Because of the linearity property of linear time-invaraint systems, we can find the response of these systems by breaking the input $x(t)$ into several components and then summing the system response to all the components of $x(t)$. In **frequency domain analysis** we are breaking up the input $x(t)$ into exponentials of the form $e^{st}$, where the parameter $s$ is the complex frequency of the signal $e^{st}$.
The tool that makes it possible to represent arbitrary input $x(t)$ in terms of exponential components is the [[DEQ1_009 טרנספורמציית לפלס#טרנספורמציית לפלס|Laplace transform]].

We can also separate the input into exponentials of the form $e^{j\omega t}$ instead of $e^{st}$. This is accomplished the Fourier transform. In a sense, the Fourier transform may be considered to be a special case of the Laplace transform with $s=j\omega$. Although this view is true most of the time, it does not always hold because of the nature of convergence of the Laplace and Fourier integrals.
# The Laplace Transform

![](https://www.youtube.com/watch?v=6MXMDrs6ZmA)

![](https://www.youtube.com/watch?v=n2y7n6jw5d0)

>[!def] Definition: 
For a signal $x(t)$, its **Laplace transform** $X(s)$ is defined by
$$X(s)=\int_{-\infty }^{\infty } x(t)e^{-st} \, \mathrm{d}t $$
The signal $x(t)$ is said to be the **inverse Laplace transform** of $X(s)$. It can be shown that
$$x(t)=\dfrac{1}{2\pi j}\int_{c-j\infty }^{c+j\infty } X(s) e^{st}\, \mathrm{d}s $$
where $c$ is a constant chosen to ensure the convergence of the integral.


This pair of equations is known as the **bilateral Laplace transform pair**, where $X(s)$ is the direct Laplace transform of $x(t)$ and $x(t)$ is the inverse Laplace transform $X(s)$. Symbolically,
$$\begin{aligned}
X(s)=\mathcal{L}\{ x(t) \} &  & \text{and} &  & x(t)=\mathcal{L}^{-1}\{ X(s) \}
\end{aligned}$$
Note that
$$\begin{aligned}
\mathcal{L}^{-1}\{ \mathcal{L}\{x(t)\} \}=x(t) &  & \text{and} &  & \mathcal{L}\{ \mathcal{L}^{-1}\{ X(s)\} \}=X(s)
\end{aligned}$$


## Region of Convergence (ROC)
>[!def] Definition: 
 >The **region of convergence**, also called the **region of existence**, for the the Laplace transform $X(s)$, is the set of values of $s$ (the region in the complex plane) for which the integral $\int_{-\infty}^{\infty} x(t)e^{-st} \, \mathrm{d}t$ converges.
 
 >[!example] Example: Laplace transform and ROC of a causal exponential
>  For a signal $x(t)=e^{-at} \mathbb{1}(t)$, find the Laplace transform $X(s)$ and its ROC.
>  
>  **Solution**:
>  By definition,
>  $$X(s)=\int_{-\infty }^{\infty} e^{-at}\mathbb{1}(t)e^{-st} \, \mathrm{d}t $$
>  Because $\mathbb{1}(t)=0$ for $t<0$ and $\mathbb{1}(t)=1$ for $t\geq 0$,
>  $$\begin{aligned}
> X(s) & =\int_{0}^{\infty } e^{-at}e^{-st} \, \mathrm{d}t  \\[1ex]
>  & =\int_{0}^{\infty } e^{-(s+a)t} \, \mathrm{d}t \\[1ex]
>  & =-\dfrac{1}{s+a}e^{-(s+a)t}\bigg|_{0}^{\infty} 
> \end{aligned}$$
> Note that $s$ is complex and as $t\to \infty$, the term $e^{-(s+a)t}$ does not necessarily vanish. Here we [[LSY1_004 Linear State-Space Equation#Euler's Formula|recall]] that for a complex number $z=\alpha+j\beta$,
> $$\begin{aligned}
> e^{-zt} & =e^{-(\alpha+j\beta)t} \\[1ex]
>  & =e^{-\alpha t}e^{-j\beta t}
> \end{aligned}$$
> Now $\lvert e^{-j\beta t} \rvert=1$ regardless of the value of $\beta t$. Therefore, as $t\to \infty$, $e^{-zt}\to 0$ only if $\alpha>0$, and $e^{-zt}\to \infty$ if $\alpha<0$. Thus,
> $$\lim_{ t \to \infty}e^{-zt}=\begin{cases}
> 0 & \mathrm{Re}(z)>0 \\[1ex]
> \infty  & \mathrm{Re}(z)<0
> \end{cases}$$
> Clearly,
> $$\lim_{ t \to \infty}e^{-(s+a)t}=\begin{cases}
> 0 & \mathrm{Re}(s+a)>0 \\[1ex]
> \infty  & \mathrm{Re}(s+a)<0
> \end{cases}$$
> Use of this result in our expression for $X(s)$ yields
> $$\begin{aligned}
> X(s)=\dfrac{1}{s+a} &  & \mathrm{Re}(s+a) >0
> \end{aligned}$$
> The ROC of $X(s)$ is $\mathrm{Re}(s)>-a$, as shown in the shaded area in the following figure:
> ![[Pasted image 20240718093739.png|book]]
>[Pasted image 20240718093739](Pasted%20image%2020240718093739.png)b) $-e^{-at}\mathbb{1}(-t)$ have the same Laplace transform but different regions of convergence.
> 
> This face means that the integral defining $X(s)$ exists only for the values of $s$ in the shaded region. For other values of $s$, the integral does not converge.

## Basic Properties


> [!NOTEs] Note:
> The region $\mathbb{C}_{\alpha}$ means $\{ s=a+jb \in \mathbb{C} \mid a>\alpha \}$.

| property        | time domain                       | $s$-domain                                 | ROC                                                   |
| --------------- | --------------------------------- | ------------------------------------------ | ----------------------------------------------------- |
| linearity       | $x={a}_{1}{x}_{1}+{a}_{2}{x}_{2}$ | $X(s)={a}_{1}{X}_{1}(s)+{a}_{2}{X}_{2}(s)$ | $\mathbb{C}_{\alpha 1} \cap \mathbb{C}_{\alpha 2}$    |
| time shift      | $y(t)=x(\tau+s)$                  | $Y(s)=e^{\tau s}X(s)$                      | $\mathbb{C}_{\alpha }$                                |
| time scaling    | $y(t)=x(at)$                      | $Y(s)=(1/a)X(s/a)$                         | $\mathbb{C}_{a\alpha}$                                |
| differentiation | $y=\dot{x}$                       | $Y(s)=sX(s)$                               | $\mathbb{C}_{\alpha}$                                 |
| convolution     | $z=x*y$                           | $Z(s)=X(s)Y(s)$                            | $\mathbb{C}_{\alpha_{x}}\cap \mathbb{C}_{\alpha_{y}}$ |

## Laplace Transform Table
- [[DEQ1_009 טרנספורמציית לפלס#טבלת טרנספורמציית לפלס|Laplace transform table]]

Some more common Laplace transforms:
 $$\displaystyle {\begin{array}{c|c|c}
& f(t)=\mathcal{L}^{-1}\{ F(s) \} & F(s)=\mathcal{L}\{ f(t) \} & \text{ROC} \\[2ex]
\hline 18 & \mathbb{1}(t)  & \dfrac{1}{s} & \mathbb{C}_{0} \\[2ex]
19 & \mathrm{rect}(t) & \dfrac{e^{s/2}-e^{-s/2}}{s} & \mathbb{C} \\[2ex]
20 & \exp_{\lambda}\mathbb{1}(t) & \dfrac{1}{s-\lambda} & \mathbb{C}_{\mathrm{Re}(\lambda)} \\[2ex]
21 & \sin(\omega_{x}t+\phi) \mathbb{1}(t) & \dfrac{s\sin \phi+\omega_{x}\cos \phi}{s^{2}+{\omega_{x}}^{2}} & \mathbb{C}_{0} \\[2ex]
22 & e^{\lambda t}\sin(\omega_{x}t+\phi)\mathbb{1}(t) & \dfrac{(s-\lambda)\sin \phi+\omega_{x}\cos \phi}{(s-\lambda)^{2}+{\omega_{x}}^{2}} & \mathbb{C}_{\lambda}
\end{array}}$$


# Partial Fraction Expansion

> [!notes] Note:
> This is a generlization of [[BMA1_004 אלגוריתמים נפוצים#אלגוריתם פירוק לשברים חלקיים|פירוק לשברים חלקיים]].

Given a ration proper $(n\geq m)$ function $F$,
$$F(s)=\dfrac{b_{m}s^{m}+b_{m-1}s^{m-1}+\dots +{b}_{1}s+{b}_{0}}{s^{n}+a_{n-1}s^{n-1}+\dots +{a}_{1}s+{a}_{0}}:=\dfrac{N(s)}{D(s)}$$
we can rewrite the function as
$$F(s)=F(\infty )+\sum_{i=1}^{k}\sum_{j=1}^{n_{i}} \dfrac{c_{ij}}{(s-p_{i})^{j}}  $$
where $p_{i}$ is the $i$th distinct **pole** of $F$ (the $ith$ root of $D(s)$) of order $n_{i}$. For a simple pole (a pole $p_{i}$ with order $n_{i}=1$) we can calculate $c_{i 1}$ as:
$$c_{i 1}=\lim_{ s \to p_{i}}(s-p_{i})F(s)$$
For higher order poles we need to do a few tricks like using coefficient comparison.
# Final and Initial Values Theorems

>[!theorem] theorem: 
>Given a continuous signal $x:\mathbb{R}\to \mathbb{F}$ with $\mathrm{supp}(x) \subset \mathbb{R}_{+}$, the initial and final value theorems are as follows:
> 1. **Initial value theorem**:
> 	$$\lim_{ t \to 0}x(t)=\lim_{ s \to \infty}sX(s)$$
> 	assuming $x(0^{+})$ exists.
> 2. **Final value theorem**:
> 	$$\lim_{ t \to \infty}x(t)=\lim_{ s \to 0}sX(s)$$
> 	assuming $x$ is converging.

# From Laplace to Transfer Function
If $G:u\to y$ is LTI, then
$$y=g*u$$
where $g=G\delta$ is the [[LSY1_004 Linear State-Space Equation#Impulse Response|impulse response]] of $G$, i.e. its response to $\delta$ applied at $t=0$. By the [[#Basic Properties|convolution]] property of the Laplace transform:
$$Y(s)=G(s)U(s)$$
In other words, [[LSY1_003 Classification of Systems#Instanteneous and Dynamic Systems|dynamic]] LTI systems in the Laplace act as the multiplication of the transformed impulse response and input.

>[!def] Definition: 
> The function
> $$G(s)=(\mathcal{L}\{ g \})(s)$$
> is called the **transfer function** of $G$. Transfer function may also be viewed as the ratio of the Laplace transforms of the output and input signals:
> $$G(s)=\dfrac{Y(s)}{U(s)}$$

In some important cases (systems described by ODEs) transfer function are of the form of a quotient of two polynomials, like
$$G(s)=\dfrac{Y(s)}{U(s)}=\dfrac{b_{m}s^{m}+b_{m-1}s^{m-1}+\dots +{b}_{1}s+{b}_{0}}{s^{n}+a_{n-1}s^{n-1}+\dots +{a}_{1}s+{a}_{0}}$$

for some $n,m \in \mathbb{Z}_{+}$, and the real coefficients $a_{i}$ and $b_{i}$. Such transfer function are said to be **rational**. Their **poles** are the roots of the denominator polynomial. The roots of the numerator are called **zeros** of $G(s)$.

The system is said to be
- **proper** if $n\geq m$,
- **strictly proper** if $n>m$,
- **bi-proper** if $n=m$,
- **non-proper** if $n<m$.

## Steady-State and Transients
Consider a continuous-time LTI $G$ with a rational transfer function. If $G$ is stable, all poles of $G(s)$ are in $\{ s \in \mathbb{C}\mid \mathrm{Re}(s)<0 \}$, so that it **holomorphic** (differentiable, but for complex functions) and bounded at $s=0$.

The Laplace transform of the **step response** (response to $u=\mathbb{1}$) is
$$Y(s)=G(s)\cdot \dfrac{1}{s}$$
Which we can also write as:
$$Y(s)=\underbrace{ \dfrac{G(s)-G(0)}{s} }_{ Y_{\text{tr}} }+\underbrace{ \dfrac{G(0)}{s} }_{ Y_{\text{ss}} }$$
- The signal $y_{\text{tr}}$ is called the **transient response**. It Laplace transform $Y_{\text{tr}}$ is rational, proper, and its singularity at $s=0$ is removable, as in:
	$$\lim_{ s \to 0}Y_{\text{tr}}(s)=\lim_{ s \to 0} \dfrac{G(s)-G(0)}{s}=G'(0)$$
	Hence, $y_{\text{tr}}$ is a superposition of *decaying* exponents and $\lim_{ t \to \infty}y_{\text{tr}}(t)=0$, meaning that the transient response vanishes asymptotically.
- The signal $y_{\text{st}}=G(0)\mathbb{1}$ is called the **steady-state response**, where $G(0)$ is called the **static gain** of $G$.
	Thus, the step response of a stable LTI system $G$ converges asymptotically to the step signal scaled by its static gain $G(0)$:
	$$\lim_{ t \to \infty }y(t)=\lim_{ s \to 0} s \dfrac{G(s)}{s}=G(0)$$
>[!notes] Note: 
 >We refer to ${G}_{0}$ as the static gain of $G$ in the unstable case as well. If $G(0)$ is finite, then we may still think of $y_{\text{ss}}=G(0)\mathbb{1}$ as the steady-state response of an unstable system. However, the transients do not decay then (might even diverge).

Practically:
1. Steady-state response shows *what* the response will eventually be, i.e:
	- what is the temperature in a thermometer,
	- what floor an elevator reaches,
	- what position the pointer of a spring scale stops.
2. Transient response shows *how* the steady state is reached.
	- how fast a thermometer catches the ambient temperature,
	- how fast and smooth an elevator moves between floors,
	- how fast the pointer of a spring scale stops.

### Characteristics of Transients

![[Pasted image 20240908152545.png|book]]
>General step response of a stable LTI system

Smoothness of transients may be measured by the:
- **overshoot**,
	$$\mathrm{OS}=\dfrac{y_{\text{peak}}-y_{\text{ss}}}{y_{\text{ss}}}>0 \qquad  (\text{in} \, \pu{\%})$$
	where $y_{\text{peak}}$ is the highest peak in the direction of $y_{\text{ss}}$.
- **undershoot**,
	$$\mathrm{US}=-\dfrac{y_{\text{us}}}{y_{\text{ss}}}>0 \qquad  (\text{in}\,\%)$$
	where $y_{\text{us}}$ is the highest peak against the direction of $y_{\text{ss}}$.


Speed of transients may be measured by the
- **rise time**, $t_{r}$ - time that takes $y$ to rise from $0.1y_{\text{ss}}$ to $0.9y_{\text{ss}}$.
- **peak time**, $t_{p}$ - time that takes $y$ to reach its highest peak.

Duration of transients may be measured by the
- **settling time**, $t_{s}$ - the smallest $t_{s}$ such that $\left\lvert  \dfrac{y(t)-y_{\text{ss}}}{y_{\text{ss}}}  \right\rvert\leq\delta,\,\forall t\geq t_{s}$,
	for a given **settling level** $\delta=\left\lvert  \dfrac{y_{\delta}}{y_{\text{ss}}}  \right\rvert$, which is usually $2\%$ or $5\%$.

## First Order System Transfer Function
The transfer function of a general first-order system takes the form
$$G(s)=\dfrac{k_{\text{st}}}{\tau s+1}$$
where $k_{\text{st}}$ is the static gain and $\tau$ is the time constant. The single pole of the system is $p=-1/\tau \in \mathbb{R}$.

For an step signal input $u=\mathbb{1}(t)$, the response would be:
$$\begin{aligned}
Y_{\text{step}}(s) & =\dfrac{k_{\text{st}}}{\tau s+1} \cdot \dfrac{1}{s} \\[1ex]
 & =k_{\text{st}}\left( \dfrac{1}{s}-\dfrac{1}{s+1/\tau} \right)
\end{aligned}$$
Taking the inverse Laplace transform of it would yield:
$$\boxed {
y_{\text{step}}(t)=k_{\text{st}}(1-e^{-t/\tau})\mathbb{1}(t)
 }$$
Just like [[PHY2_004 מעגלים חשמליים#מעגלי RC|RC circuits]].
The static gain $k_{\text{st}}$ scales the response amplitude. When $t=\tau$ and $t=3\tau$ we get
$$\begin{aligned}
y_{\text{step}}(\tau)=k_{\text{st}}(1-e^{-1})\approx 0.63k_{\text{st}}\qquad  \text{and} \qquad  y_{\text{step}}(3\tau)=k_{\text{st}}(1-e^{-3})\approx 0.95k_{\text{st}}
\end{aligned}$$
respectively. The time constant $\tau$ dictates the responsiveness of the system. 

![[Pasted image 20240906225244.png|bookhue]]
>Characteristics of a first-order system.

In steady-state, the response becomes constant:
$$y_{\text{ss}}=k_{\text{st}}$$
The transient response is shaped mainly by $\tau$, $k_{\text{st}}$ only scales is:
$$y_{\text{tr}}=-k_{\text{st}}e^{-t/\tau}$$
By the [[LSY1_007 Laplace Transform#Final and Initial Values Theorems|initial value theorem]], the slope in the beginning is:
$$\begin{aligned}
\dot{y}(0) & =\lim_{ s \to \infty} s\cdot sY(s) \\[1ex]
 & =\lim_{ s \to \infty} \dfrac{k_{\text{st}}s}{\tau s+1}
\end{aligned}$$
which means:
$$\boxed{\dot{y}(0)=\dfrac{k_{\text{st}}}{\tau} }$$


## Second Order System Transfer Function

The transfer function of a general second-order system takes the form
$$G(s)=\dfrac{k_{\text{st}}{\omega_{n}}^{2}}{s^{2}+2\zeta\omega_{n}s+{\omega_{n}}^{2}}$$
where $k_{\text{st}}$ is the static gain, $\zeta$ is the **damping ratio**, and $\omega_{n}$ is the **natural frequency**. 
$$s_{1,2}=\omega_{n}(-\zeta\pm \sqrt{ \zeta ^{2}-1 })$$


Its step response would be:
$$Y(s)=\dfrac{k_{\text{st}}{\omega_{n}}^{2}}{s^{2}+2\zeta\omega_{n}s+{\omega_{n}}^{2}} \cdot \dfrac{1}{s}$$
and the roots of its denominator are
$${s}_{1}=0\qquad  \text{and}\qquad  s_{2,3}=(-\zeta\pm \sqrt{ \zeta ^{2}-1 })\omega_{n}$$
Three cases shall be studied separately:
1. if $\zeta>1$, then $s_{2,3}$ are real and simple, which we will call **overdamped**.
2. if $\zeta=1$, then $s_{2,3}$ are real and equal, which we will call **critically damped**.
3. if $\zeta<1$, then $s_{2,3}$ and complex conjugate, , which we will call **underdamped**.

>[!notes] Note: 
 >If $\zeta=0$, then we say that system is undamped; on need in a separate analysis.

In all cases the initial slope is (by the [[LSY1_007 Laplace Transform#Final and Initial Values Theorems|initial value theorem]]):
$$\dot{y}(0)=\lim_{ s \to \infty }s\cdot sY(s)=\lim_{ s \to \infty } \dfrac{k_{\text{st}}{{\omega}_{n}}^{2}s}{s^{2}+2\zeta\omega_{n}s+{\omega_{n}}^{2}}$$
which means:
$$\boxed{\dot{y}(0)=0 }$$

**Step response of an overdamped second order system**:
The step response in this case is
$$y(t)=k_{\text{st}}(1-\beta e^{{s}_{1}t}+(\beta-1)e^{{s}_{2}t})\mathbb{1}(t)$$
where $\beta=\dfrac{1}{2}\left( \dfrac{\zeta}{\sqrt{ \zeta ^{2} }-1} +1\right)>1$.

Increasing $\omega_{n}$ will cause a fast response. Increasing $\zeta$ will cause a slower response.

![[Pasted image 20240908154539.png|bookhue]]
>Overdamped second-order system.

**Step response of a critically damped second order system**:
In this case the poles $s_{1,2}=-\omega_{n}$ and the step response is
$$y(t)=k_{\text{st}}(1-(1+\omega_{n}t)e^{-\omega_{n}t})\mathbb{1}(t)$$
Increasing $\omega_{n}$ will cause a faster response (as in overdamped system).

**Step response of an underdamped second order system**:
In this case the poles ${s}_{1},{s}_{2}\in \mathbb{C}$ are:
$$s_{1,2}=-\zeta\omega_{n}\pm j\omega_{n}\sqrt{ 1-\zeta ^{2} }=-\zeta\omega_{n}\pm j\omega_{d}$$
where $\omega_{d}=\omega_{n}\sqrt{ 1-\zeta ^{2} }$ is the **damped natural frequency**. The step response in this case is
$$y(t)=k_{\text{st}}\left( 1-\dfrac{1}{\sqrt{ 1-\zeta ^{2} }}e^{-\zeta\omega_{n}t}\sin(\omega_{d}t+\arccos \zeta) \right)\mathbb{1}(t)$$

We can notice that the response is composed of an exponential decay with $-\zeta\omega_{n}$ and an oscillation with the frequency $\omega_{d}$ (and thus the period $2\pi /\omega_{d}$).

![[Pasted image 20240908165910.png|bookhue]]
>Upper plots: underdamped second order system $\zeta=0.3$. Lower plots: Underdamped ($\zeta=0.3$), critically damped ($\zeta=1$), and overdamped ($\zeta=2.6$) systems, where $\omega_{n}=4$.

**Step response of underdamped system - effect of zeros**:
Let
$$G_{\alpha}(s)=\dfrac{k_{\text{st}}(\alpha\omega_{n}s+{{\omega}_{n}}^{2})}{s^{2}+2\zeta\omega_{n}s+{{\omega}_{n}}^{2}}$$
for $\alpha \in \mathbb{R}$. $G(s)$ is said to have a zero at $s=-\omega_{n}/a$ since $G_{\alpha}(-\omega_{n}/\alpha)=0$. In this case:
![[Pasted image 20240910192824.png|bookhue|500]]
>Effect of zero on an underdamped system.

As $\alpha$ grows:
- the overshoot $\mathrm{OS}$ increases: $y_{\alpha}(t)>{y}_{0}(t)$ for $t\leq \pi /\omega_{d}$, since $\dot{y}_{0}(t)>0$ for $t\leq \dfrac{\pi}{\omega_{d}}$,
- the raise time $t_{r}$ decreases,
- the settling time $t_{s}$ increases.


# Causality and Stability
>[!theorem] Theorem:
>A continuous-time LTI system with rational transfer function $G(s)$ is causal and I/O stable iff
>- $G(s)$ is proper and
>- $G(s)$ has all its poles in the open left half plane $\mathbb{C}\setminus \bar{\mathbb{C}}_{0}=\{ s \in \mathbb{C}\mid \mathrm{Re}(s)<0 \}$

## Categorizing Polynomials
In the case that our LTI system is represented by a rational function, the stability is determined by the locations of the roots of the denominator. It is not always easy to calculate these, but there are ways to test whether all the roots lie in the open left half plane, or in the open unit disk $\mathbb{D}_{1}$ (which will be useful to know in future subjects).

>[!def] Definition: 
 >A polynomial is said to be
 >- **Hurwitz** if all its roots are in the open left half plane.
 >- **Schur** if all its roots are in $\mathbb{D}_{1}$.
 >- **Monic** if the leading coefficient $a_{n}=1$, like
>	$$D(s)=s^{n}+a_{n-1}s^{n-1}+\dots +{a}_{1}s+{a}_{0}$$

## Routh Table

>[!def] Definition: 
> Given the polynomial
> $$D(s)=a_{n}s^{n}+a_{n-1}s^{n-1}+\dots +{a}_{1}s+{a}_{0}$$
> the associated **Routh table** is
> 
> $$\begin{array}{c|ccc}
> 0 & {r}_{0,1}=a_{n} & {r}_{0,2}=a_{n-2} & r_{0,3}=a_{n-4}  & \cdots  \\[1ex]
> 1 & r_{1,1}=a_{n-1} & r_{1,2}=a_{n-3} & r_{1,3}=a_{n-5} & \cdots  \\[1ex]
> 2 & r_{2,1} & r_{2,2} & r_{2,3} & \cdots  \\[1ex]
> \vdots  & \vdots  & \vdots  & \vdots  & \cdots  \\[1ex]
> n-2 & r_{n-2,1} & r_{n-2,2} & r_{n-2,3}  & \cdots  \\[1ex]
> n-1 & r_{n-1,1} & r_{n-1,2}  & \ \\[1ex]
> n & r_{n,1} & 
> \end{array}$$
> where for each $i=2,3,\dots,n$:
> $$[r_{i,1},\, r_{i,2},\dots ]=[r_{i-2,2},\, r_{i-2,3} ,\dots ]-\dfrac{r_{i-2,1}}{r_{i-1,1}}[r_{i-1,2},\, r_{i-1,3},\, \dots ]$$
> and if the last required column of an involved row is empty, $0$ is taken.
> According to what happens to the elements in the first column, we say that the Routh table is
> - **singular** if there exists an $i$ where: $r_{i,1}=0$
> - **regular** if for every $i$: $r_{i,1}\neq 0$

## Necessary Condition for Stability

>[!theorem] Theorem: 
> The polynomial
> $$D(s)=s^{n}+a_{n-1}s^{n-1}+\dots +{a}_{1}s+{a}_{0}$$
> is [[#Categorizing Polynomials|Hurwitz]] only if $a_{i}>0$ for all $i=0,1,\dots n-1$. In general, for polynomials that are not monic, we require that all coefficients are non zero and have the same sign.

## Necessary and Sufficient Condition for Stability

>[!theorem] Theorem: 
> Consider a polynomial
> $$D(s)=s^{n}+a_{n-1}s^{n-1}+\dots +{a}_{1}s+{a}_{0}$$
> - $D(s)$ is Hurwitz iff the associated [[#Routh Table]] is regular and all the elements of the first column have the same sign.
> - If the Routh table is regular, then $D(s)$ has no imaginary roots, and the number of poles in $\mathbb{C}_{0}$ equals the number of sign changes in the first column of the table.
> - If the Routh table is singular, then $D(s)$ is not Hurwitz. In this case, we cannot say anything about the location of the poles, except that there is at least one pole on the imaginary axis, or in $\mathbb{C}_{0}$.

**Second order polynomial**: The Routh table for a second order polynomial $D(s)={{a}_{2}}^{2}+{a}_{1}s+{a}_{0}$ is:
$$\begin{array}{c|cc}
0 & {a}_{2} & {a}_{0} \\
1 & {a}_{1} \\
2 & {a}_{0}
\end{array}$$
Thus, for $D(s)$ to be Hurwitz, we must have that ${a}_{2},{a}_{1}$ and ${a}_{0}$ are nonzero and have the same sign. Therefore, the [[#Necessary Condition for Stability]] is in this case a sufficient condition as well.

**Third order polynomial**: The Routh table for a third order polynomial $D(s)={a}_{3}s^{3}+{a}_{2}s^{2}+{a}_{1}s+{a}_{0}$ is:
$$\begin{array}{c|cc}
0 & {a}_{3} & {a}_{1} \\
a & {a}_{2} & {a}_{0} \\
2 & {a}_{1}-({a}_{3}/{a}_{2}){a}_{0} \\
3 & {a}_{0}
\end{array}$$
Requiring that all elements in the first column have the same sign leads to the following condition for $D(s)$ to be Hurwitz:
- ${a}_{0},{a}_{1},{a}_{2},{a}_{3}$ are nonzero and have the same sign and
- ${a}_{1}{a}_{2}>{a}_{0}{a}_{3}$.

# Exercises

## Question 1
Consider the signal $y$ shown in the following figure:
![[Pasted image 20240718094426.png|book]]
>signal $y(t)$

defined as
$$y(t)=\mathrm{rect}\left( t+\dfrac{1}{2} \right)-\mathrm{rect}\left( t-\dfrac{1}{2} \right)$$ 
with
$$\mathrm{rect}(t)=\begin{cases}
1 & \lvert t \rvert\leq  1/2 \\
0 & \text{otherwise}
\end{cases}$$
### Part a
Find the Laplace transform of $y$ and its ROC by calculating the Laplace transform directly.

**Solution**:
By definition:
$$\begin{aligned}
Y(s) & =\int_{-\infty }^{\infty } y(t)e^{-st} \, \mathrm{d}t  \\[1ex]
 & =\int_{-1}^{0}e^{-st}  \, \mathrm{d}t+\int_{0}^{1} -e^{-st} \, \mathrm{d}t \\[1ex]
 & =-\dfrac{1}{s}[e^{-st}]_{-1}^{0}+\dfrac{1}{s}[e^{-st}]_{0}^{1} \\[1ex]
 & =-\dfrac{1}{s}[1-e^{s}]+\dfrac{1}{s}[e^{-s}-1] \\[1ex]
 & =\dfrac{1}{s}[-1+e^{s}+e^{-s}-1] \\[1ex]
 & =\dfrac{1}{s}[-2+e^{s}+e^{-s}] \\[1ex]
 & =\dfrac{1}{s}[(e^{s/2})^{2}+(e^{-s/2})^{2}-2] \\[1ex]
 & =\dfrac{(e^{s/2}-e^{-s/2})^{2}}{s}
\end{aligned}$$
Therefore
$$\boxed {
Y(s)=\dfrac{(e^{s/2}-e^{-s/2})^{2}}{s}
 }$$
 and its ROC is $\mathbb{C}$, since it converges for every $s$.

### Part b
Find the Laplace transform of $y$ and its ROC by using the Laplace transform properties.

**Solution**:

We need to find:
$$Y(s)=\mathcal{L}\left( \mathrm{rect}\left( t+\dfrac{1}{2} \right)-\mathrm{rect}\left( t-\dfrac{1}{2} \right) \right)$$

Using the [[#Laplace Transform Table]], we know that:
$$\mathcal{L}(\mathrm{rect(t)})=\dfrac{e^{s/2}-e^{-s/2}}{s}$$
In addition, using [[#Basic Properties|time shift]] property
$$\begin{aligned}
 & \mathcal{L}\left( \text{rect}\left( t+\dfrac{1}{2} \right) \right)=e^{(1/2)s}\mathcal{L}(\mathrm{rect}(t)) \\[1ex]
 & \mathcal{L}\left( \text{rect}\left( t-\dfrac{1}{2} \right) \right)=e^{-(1/2)s}\mathcal{L}(\mathrm{rect}(t))
\end{aligned}$$
and linearity, we get:
$$\begin{aligned}
Y(s) & =e^{(1/2)s} \dfrac{e^{s/2}-e^{-s/2}}{s}-e^{-(1/2)s} \dfrac{e^{s/2}-e^{-s/2}}{s} \\[1ex]
 & = \dfrac{1}{s}(e^{s}-1)-\dfrac{1}{s}(1-e^{-s}) \\[1ex]
 & =\dfrac{1}{s}(e^{s}+e^{-s}-2) \\[1ex]
 & =\dfrac{(e^{s/2}-e^{-s/2})^{2}}{s}
\end{aligned}$$

Therefore
$$\boxed {
Y(s)=\dfrac{(e^{s/2}-e^{-s/2})^{2}}{s}
 }$$
 and its ROC is $\mathbb{C}$, since time shift doesn't change the ROC, and from linearty we get that the ROC is $\mathbb{C}_{\alpha 1}\cap \mathbb{C}_{\alpha 2}$, but the ROC of $\mathcal{L}[\mathrm{rect}(t)]$ is simply $\mathbb{C}$ already.

## Question 2

Consider the following mass-spring-damper system in the following figure:

![[Pasted image 20240718094741.png|book|400]]
>mass-spring-damper system

with:
$$\begin{aligned}
m=1 &  & k=6 &  & c=5
\end{aligned}$$

We suppose zero spring force at $x=0$ and zero initial velocity and position. By Newton's second law
$$m\ddot{x}(t)=F(t)-f_{\text{damper}}(t)-f_{\text{spring}}(t)=F(t)-c\dot{x}(t)-kx(t)$$
which is equivalent to
$$m\ddot{x}(t)+c\dot{x}(t)+kx(t)=F(t)$$

### Part a
Find the solution to the problem, i.e. the position of the mass in time, for the given input force $F=\mathbb{1}$.

**Solution**:
First, we apply the Laplace transform to the ODE, using the [[#Basic Properties|differentiation property]] and [[#Laplace Transform Table|table]]:
$$\begin{gathered}
ms^{2}X(s)+csX(s)+kX(s)=\mathcal{L}(\mathbb{1}(t)) \\[1ex]
(ms^{2}+cs+k)X(s)=\dfrac{1}{s} \\[1ex]
X(s)=\dfrac{1}{s(ms^{2}+cs+k)}
\end{gathered}$$

substituting the parameter values:

$$\begin{aligned}
X(s) & =\dfrac{1}{s(s^{2}+5s+6)} \\[1ex]
 & =\dfrac{1}{s(s+2)(s+3)}
\end{aligned}$$
We want to separate this fraction to elements we can apply the inverse Laplace transform to. we can do so using [[LSY1_007 Laplace Transform#Partial Fraction Expansion|partial fraction expansion]]:

$$X(s)=\sum _{i=1}^{3} \dfrac{c_{i}}{s-p_{i}}$$
where $c_{i}=\lim_{ s \to p_{i}}(s-p_{i})X(s)$, and the poles are $p_{1}=0,\,{p}_{2}=-2,\,{p}_{3}=-3$.
We get:
$$\begin{aligned}
 & c_{1}=\lim_{ s \to 0}X(s)=\lim_{ s \to 0} \dfrac{s}{s(s+2)(s+3)}=\dfrac{1}{6} \\[1ex]
 & {c}_{2}=\lim_{ s \to -2}X(s)=\dfrac{s+2}{s(s+2)(s+3)}=-\dfrac{1}{2} \\[1ex]
 & {c}_{3}=\lim_{ s \to -3}X(s)=\dfrac{s+3}{s(s+2)(s+3)}=\dfrac{1}{3}
\end{aligned}$$
Therefore:
$$X(s)=\dfrac{1}{6s}-\dfrac{1}{2(s+2)}+\dfrac{1}{3(s+3)}$$
Again, using the [[LSY1_007 Laplace Transform#Laplace Transform Table|Laplace transform table]] in the inverse direction, we get:
$$\boxed {
x(t)=\dfrac{1}{6}\mathbb{1}(t)-\dfrac{1}{2}e^{-2t}\mathbb{1}(t)+\dfrac{1}{3}e^{-3t}\mathbb{1}(t)
 }$$
![[Pasted image 20240723143354.png|book|400]]
>The system response

### Part b

What is the position of the mass after infinite time?

**Solution**:
Using the [[LSY1_007 Laplace Transform#Final and Initial Values Theorems|final value theorem]], we can find that:
$$\begin{aligned}
\lim_{ t \to \infty}x(t) & =\lim_{ s \to 0} sX(s) \\[1ex]
 & =\lim_{ s \to 0} s\dfrac{1}{s(s+2)(s+3)} \\[1ex]
 & =\lim_{ s \to 0} \dfrac{1}{(s+2)(s+3)} \\[1ex]
 & =\dfrac{1}{6}
\end{aligned}$$
Therefore:
$$\boxed{\lim_{ t \to \infty}x(t)=\dfrac{1}{6} }$$

## Question 3
Consider the system $G_{RLC}: v_{\text{in}}\to i_{R}$ shown in the following figure:
![[Pasted image 20240725155953.png|book|450]]
>RLC circuit

In other words, the input is the applied voltage $v_{\text{in}}$ and the output is the resistor's current $i_{R}$. Here $R=1,\,L= 1$, and $C=\dfrac{1}{8}$ are constants, referred to as the resistance, inductance, and capacitance, respectively.

### Part a
Write the transfer function $G_{RLC}(s)$ of the system.

**Solution**:
By [[PHY2_004 מעגלים חשמליים#חוקי קירכהוף|Kirchhoff's voltage law]],
$$v_{\text{in}}(t)=v_{R}(t)+v_{L}(t)=v_{R}(t)+v_{C}(t)$$
It is known that
$$\begin{aligned}
v_{R}(t)=Ri_{R}(t) &  & v_{L}(t)=L \dfrac{\mathrm{d}i_{L}(t)}{\mathrm{d}t} &  & v_{C}(t)=\dfrac{1}{C}\int_{-\infty }^{t} i_{C}(s) \, \mathrm{d}s 
\end{aligned}$$
Hence,
$$\begin{aligned}
 & v_{\text{in}}(t)=v_{R}(t)+v_{L}(t)  & & \implies v_{\text{in}}(t)=Ri_{R}(t)+L \dfrac{\mathrm{d}i_{L}}{\mathrm{d}t}(t) \\[1ex]
 & v_{\text{in}}=v_{R}(t)+v_{C}(t) &  & \implies \dot{v}_{\text{in}}(t)=R \dfrac{\mathrm{d}i_{R}(t)}{\mathrm{d}t}+\dfrac{1}{C}i_{C}(t)
\end{aligned}$$
Applying Laplace to both equations:
$$\begin{aligned}
 & V_{\text{in}}(t)=RI_{R}(s)+sLI_{L}(s) &  & \implies I_{L}(s)=\dfrac{V_{\text{in}}(t)-RI_{R}(s)}{Ls} \\[1ex]
 & sV_{\text{in}}(t)=RsI_{R}(t)+\dfrac{1}{C}I_{C}(s) &  & \implies I_{C}(s)=Cs(V_{\text{in}}(s)-RI_{R}(s))
\end{aligned}$$
By Kirchhoff's current law:
$$\begin{aligned}
I_{R}(s) & =I_{L}(s)+I_{C}(s) \\[1ex]
 & =\dfrac{V_{\text{in}}(t)-RI_{R}(s)}{Ls}+Cs(V_{\text{in}}(s)-RI_{R}(s))
\end{aligned}$$
from which:
$$RLCs^{2}I_{R}(s)+LsI_{R}(s)+RI_{R}(s)=LCs^{2}V(s)+V(s)$$
Hence, the transfer function is:
$$\begin{aligned}
G_{RLC}(s) & = \dfrac{I_{R}(s)}{V(s)} \\[1ex]
 & = \dfrac{LCs^{2}+1}{RLCs^{2}+Ls+R}
\end{aligned}$$
Substituting parameters, we get:
$$\boxed {
\begin{aligned}
G_{RLC}(s) =\dfrac{s^{2}+8}{s^{2}+8s+8}
\end{aligned}
 }$$

### Part b
Determine if the system is proper, strictly proper, bi-proper, or non-proper.

**Solution**:
In our case, $n=m$, which is why the system is [[#From Laplace to Transfer Function|bi-proper]].


### Part c
Find the zeros and poles of $G_{RLC}(s)$ and associate them with parts of the complex plane $\mathbb{C}$.

**Solution**:
- The zeros:
	$$\boxed {
z=\pm \sqrt{ 8 }j
 }$$
- The poles:
	$$\boxed {
p=-4\pm \sqrt{ 8}
 }$$

![[Screenshot_20240725_202406_Obsidian.jpg|book|400]]
>Pole-zero map. Circles mark zeros, while crosses mark poles.

### Part d
What is the system's steady-state value for step input $v_{\text{in}}=5\cdot\mathbb{1}(t)$?

**Solution**:
By the [[#Final and Initial Values Theorems|final value theorem]]:
$$\begin{aligned}
y_{ss} & =\lim_{ t \to \infty} y(t)\\[1ex]
 & =\lim_{ s \to 0}sY(s) \\[1ex]
 & =\lim_{ s \to 0}sG(s)U(s) 
\end{aligned}$$
In our case:
$$\begin{aligned}
U(s) & =\mathcal{L}\{ u(t) \}  \\[2ex]
 & =\mathcal{L}\{ 5\cdot \mathbb{1}(t) \} \\[1ex]
 & =\dfrac{5}{s}
\end{aligned}$$
Substituting back:
$$\begin{aligned}
y_{ss} & =sG(s) \dfrac{5}{s} \\[1ex]
 & =\lim_{ s \to 0}5G(s) \\[1ex]
 & =\lim_{ s \to 0} 5\dfrac{s^{2}+8}{s^{2}+8s+8} \\[1ex]
 & =5\cdot \dfrac{8}{8}
\end{aligned}$$
we get:
$$\boxed {
y_{ss}=5
 }$$


## Question 4

Consider the system $G_{T}:q_{\text{in}}\to h$ shown in the following figure:

![[Pasted image 20240908155645.png|book|250]]
>Tank system

Its input is the volumetric flow $q_{\text{in}}$ to a tank with cross-section $A$ and the output $h(t)$ is the liquid level in the tank. Assume that $q_{\text{out}}(t)=\dfrac{h(t)}{R}$, where $q_{\text{out}}$ is the outlet volumetric flow and $R$ is the flow resistance.

### Part a
Derive the transfer function $G_{T}(s)$ of the system and determine if it is proper, strictly proper, bi-proper, non-proper.

**Solution**:
The liquid level at any point in the tank is simply the volume of the liquid per cross section area:
$$h(t)=\dfrac{V}{A}$$
We know that $\dot{V}=q_{\text{in}}-q_{\text{out}}$, which means:
$$\begin{aligned}
\dot{h}(t) & =\dfrac{\dot{V}}{A} \\[1ex]
 & =\dfrac{1}{A}(q_{\text{in}}-q_{\text{out}}) \\[1ex]
 & =\dfrac{1}{A}\left( q_{\text{in}}-\dfrac{h(t)}{R} \right)
\end{aligned}$$
We can rearrange this equation to a standard form:
$$\dot{h}(t)+\dfrac{1}{RA}h(t)=\dfrac{1}{A}q_{\text{in}}$$
Applying the [[LSY1_007 Laplace Transform#The Laplace Transform|Laplace transform]], we get:
$$\begin{gathered}
sH(s)+\dfrac{1}{RA}H(s)=\dfrac{1}{A}Q(s) \\[1ex]
\left( s+\dfrac{1}{RA} \right)H(s)=\dfrac{1}{A}Q(s) \\[1ex]
\boxed {
G_{T}(s)=\dfrac{H(s)}{Q(s)}=\dfrac{R}{RAs+1}
 }
\end{gathered}$$
This transfer function is [[#From Laplace to Transfer Function|strictly proper]].

### Part b
Find the zeros and poles of $G_{T}(s)$ and associate them with specific parts of the complex plane $\mathbb{C}$.

**Solution**:
The system has no zeros, and we can see that $s=-\dfrac{1}{RA}\in \mathbb{R}$ is a pole. Since $R,A$ are positive, we know that $s$ is on the open left complex plane:
![[Pasted image 20240908204341.png|bookhue|500]]
>Pole-zero map of the tank system.



### Part c
Calculate the plot and response of the step input $q_{\text{in}}=\mathbb{1}(t)$. Find the steady-state value, initial slope , time it takes to reach $\approx63\%$ and $\approx 99\%$ from its steady-state value. Assume that $R=2$ and $A=3$.

**Solution**:
Using the assumptions, we can write our transfer function as:
$$G_{T}(s)=\dfrac{2}{6s+1}$$
We know from [[#First Order System Transfer Function|steady-state of a first-order system]] that:
$$\begin{gathered}
y_{\text{ss}}=k_{\text{st}} \\[1ex]
\boxed {
y_{\text{ss}}=2
 }
\end{gathered}$$
 And the initial slope is:
 $$\begin{gathered}
\dot{y}(0)=\dfrac{k_{\text{st}}}{\tau} \\[1ex]
\boxed {
\dot{y}(0)=\dfrac{1}{3}
 }
\end{gathered}$$
In general, the step response is:
$$\begin{gathered}
y_{\text{step}}=k_{\text{st}}(1-e^{-t/\tau}) \\[1ex]
y_{\text{step}}=2(1-e^{-t/6})
\end{gathered}$$
To find when it reaches $\approx63\%$ of its steady state value, we can simply substitute:
$$\begin{gathered}
\dfrac{63}{100}k_{\text{st}}=k_{\text{st}}(1-e^{-t/\tau}) \\[1ex]
e^{-t/\tau}=-\dfrac{37}{100} \\[1ex]
t\approx \tau
\end{gathered}$$
In the same way, for $99 \%$, we get $t\approx 5\tau$.

![[Pasted image 20240908204404.png|bookhue|500]]
>Step response of the tank system.

## Question 5
Consider the system $G_{R}:\tau \to\theta$ shown in the following figure:
![[Pasted image 20240908155713.png|book|200]]
>Rotational mass-spring-damper system

The mass whose moment of inertia, $J$, is attached to a torsion spring, whose torsion coefficient is $k_{T}$. An external torque $\tau$ acts on the mass and friction between the mass and the cylinder is assumed to generate a viscous friction torque $\tau_{c}=-c_{T}\dot{\theta}$.

### Part a
Derive the transfer function $G_{R}(s)$ of the system.

**Solution**:
By [[DYN1_007 קינטיקה של גוף קשיח#מאזן תנע זוויתי יחסי של גק"ש מישורי|angular momentum balance equation]]:
$$\begin{gathered}
\sum  M= J\ddot{\theta}  \\[1ex]
\tau-k_{T}\theta+\tau_{c}=J\ddot{\theta} \\[1ex]
J\ddot{\theta}-k_{T}\theta+c_{T}\dot{\theta}=\tau
\end{gathered}$$
Applying the [[LSY1_007 Laplace Transform#The Laplace Transform|Laplace transform]] to both sides of the equation yields:
$$\begin{gathered}
s^{2}J\Theta+sc_{T}\Theta+k_{T}\Theta=T \\[1ex]
G_{R}(s)=\dfrac{\Theta(s)}{T(s)}=\dfrac{1}{Js^{2}+c_{T}s+k_{T}}
\end{gathered}$$
We can rewrite it to fit the [[LSY1_007 Laplace Transform#Second Order System Transfer Function|known form]]:
$$\boxed {
G_{R}(s)=\dfrac{1/J}{s^{2}+(c_{T}/J)s+(k_{T}/J)}
 }$$

### Part b
Determine if the system is strictly proper, bi-proper, non-proper.

**Solution**:
The system is [[#From Laplace to Transfer Function|strictly proper]].
### Part c
Find $k_{\text{st}},\,\omega_{n},\,\zeta,\,\omega_{d},\,t_{r},\,t_{p},\,\mathrm{OS}$ and $t_{s}$ for $\delta=5\%$. Assume that $J=2,\,c_{T}=3$ and $k_{T}=10$.

**Solution**:
We know that:

$$G_{R}(s)=\dfrac{1/J}{s^{2}+(c_{T}/J)s+(k_{T}/J)s}=\dfrac{k_{\text{st}}{\omega_{n}}^{2}}{s^{2}+2\zeta\omega_{n}s+{\omega_{n}}^{2}}$$
Therefore, the natural frequency:
$$\begin{gathered}
\omega_{n}=\sqrt{ \dfrac{k_{T}}{J} } \\[1ex]
\boxed {
\omega_{n}=\sqrt{ 5 }
 }
\end{gathered}$$
And the static gain:
$$\begin{gathered}
\dfrac{1}{J}=k_{\text{st}}{\omega_{n}}^{2} \\[1ex]
\boxed {
k_{\text{st}}=10
 }
\end{gathered}$$
The damping ratio:
$$\begin{gathered}
\dfrac{c_{T}}{J}=2\zeta\omega_{n} \\[1ex]
\boxed {
\zeta\approx 0.33<1
 }
\end{gathered}$$
Since $\zeta<1$, the system is [[#Second Order System Transfer Function|underdamped]], and has a damping frequency:
$$\begin{gathered}
\omega_{d}=\omega_{n}\sqrt{ 1-\zeta ^{2} } \\[1ex]
\omega_{d}\approx 2.11
\end{gathered}$$
Its poles:
$$\begin{aligned}
s_{1,2} & =\dfrac{-c_{T}/J\pm \sqrt{ (c_{T}/J)^{2}-4k_{T}/J }}{2} \\[1ex]
 & =\dfrac{-3/2\pm \sqrt{ (3/2)^{2}-20 }}{2} \\[1ex]
 & =-\dfrac{3}{4}\pm \sqrt{ \dfrac{9/4-20}{4} } \\[1ex]
 & \approx -3/4\pm 4.44j
\end{aligned}$$
These poles are on the open left half plane, which means the system is stable:
![[Pasted image 20240908155801.png|book|500]]
>Pole-zero map of the rotational system.


Using super powers like MATLAB we can also plot the step response:
![[Pasted image 20240908155813.png|book|500]]
>Step response of the rotational system.

From the plot, we can calculate the characteristics of the transient response:
$$\begin{aligned}
 & t_{r}=0.825-0.213=0.612 \\[1ex]
 & t_{p}=1.491 \\[1ex]
 & \mathrm{OS}=\dfrac{0.133-0.1}{0.1}=33\% \\[1ex]
 & t_{s}=3.542
\end{aligned}$$


## Question 8
Consider the continuous-time LTI system with transfer function $G(s)$:
$$G(s)=\dfrac{1}{s^{3}+7s^{2}-4s+2}$$

Is this system I/O stable?

**Solution**:
According to [[#Necessary and Sufficient Condition]], We need to make sure that the Denominator's coefficient satisfy $a_{i}>0$. Since $a_{1}<0$, $D(s)$ isn't Hurwitz, which means it has roots in the right hand plane.  [[#Causality and Stablity|Therefore]] (even though it is proper), it is not stable.

## Question 9
Consider the continuous-time LTI system with transfer function $G(s)$:
$$G(s)=\dfrac{1}{s^{5}+4s^{4}+2s^{3}+2s^{2}+s+10}$$
Is this system I/O stable? If not, then where are the poles placed?

**Solution**:
All the coefficients of the denominator have the same sign, which means the system *might* be stable. The associated Routh table:
$$\begin{array}{c|cc}
0 & 1 & 2 & 1  \\
1 & 4 & 2 & 10 \\
2 & 1.5  & -1.5 & 0  \\
3 & 6 & 10 & 0  \\
4 & -4 & 0 & 0 \\
5 & 10 & 0 & 0
\end{array}$$
Since one of its elements in the first column doesn't have the same sign as the rest, $D(s)$ is not Horwitz, and the system is not stable.
Because the Routh table is regular, there are no poles on the imaginary axis, and because there are two sign changes in the first column, we must have two poles in the right half plane $\mathbb{C}_{0}$. Using MATLAB, we get:

![[Screenshot_20240801_120007_Samsung Notes.jpg|book|350]]
>Pole-zero map of $G(s)$


## Question 10
Consider the following system:
![[LSY1_008 Fourier Transform 2024-09-04 20.24.26.excalidraw.svg]]
>Inverted pendulum with torsion spring.

An inverted pendulum with length $L$ is held in place by a torsion spring with constant $k$, as can be seen in the figure. A mass $m$ is placed at the end of the rod. In addition, a torsion damper is set in place with constant $c$. Finally, an external force is acting on the mass perpendicularly to the rod.

The transfer function of the linearized system is given by
$$G(s)=\dfrac{L}{mL^{2}s^{2}+cs+(k-mgL)}$$When is this system I/O stable?

**Solution**:
The transfer function is [[LSY1_007 Laplace Transform#From Laplace to Transfer Function|proper]]. Because we are working with a second degree polynomial, the criterion for stability is that all coefficients of the numerator have the same sign. In this case, all coefficients must be positive:
$$mL^{2}>0\qquad  c>0\qquad  k-mgL>0$$
The first two conditions are always met. Therefore, the condition for stability becomes:
$$\boxed{k>mgL }$$
What this means intuitively is that the force of the spring ($k\theta$) should be larger than the moment produced by the weight of the mass ($mgL\sin\theta$).
$$k\theta>mgL\sin\theta\approx mgL\theta$$

