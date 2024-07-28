---
aliases:
  - Laplace transform
  - region of convergence
  - ROC
  - Laplace transform table
  - partial fraction expansion
  - final value theorem
  - initial value therorem
---
# Introduction
From [[LSY1_000 034032 Linear Systems E#Bibliography|(Lathi & Green, 2018)]]:
Because of the linearity property of linear time-invaraint systems, we can find the response of these systems by breaking the input $x(t)$ into several components and then summing the system response to all the components of $x(t)$. In **frequency domain analysis** we are breaking up the input $x(t)$ into exponentials of the form $e^{st}$, where the parameter $s$ is the complex frequency of the signal $e^{st}$.
The tool that makes it possible to represent arbitrary input $x(t)$ in terms of exponential components is the [[../DEQ1/DEQ1_009 טרנספורמציית לפלס#טרנספורמציית לפלס|Laplace transform]].

We can also separate the input into exponentials of the form $e^{j\omega t}$ instead of $e^{st}$. This is accomplished the Fourier transform. In a sense, the Fourier transform may be considered to be a special case of the Laplace transform with $s=j\omega$. Although this view is true most of the time, it does not always hold because of the nature of convergence of the Laplace and Fourier integrals.
# The Laplace Transform

![](https://www.youtube.com/watch?v=6MXMDrs6ZmA)

![](https://www.youtube.com/watch?v=n2y7n6jw5d0)

>[!def] Definition: 
For a signal $x(t)$, its Laplace transform $X(s)$ is defined by
$$X(s)=\int_{-\infty }^{\infty } x(t)e^{-st} \, \mathrm{d}t $$
The signal $x(t)$ is said to be the **inverse Laplace transform** of $X(s)$. It can be shown that
$$x(t)=\dfrac{1}{2\pi j}\int_{c-j\infty }^{c+j\infty } X(s) e^{st}\, \mathrm{d}s $$
where $c$ is a constant chosen to ensure the convergence of the integral.


This pair of equations is known as the **bilateral Laplace transform pair**, where $X(s)$ is the direct Laplace transform of $x(t)$ and $x(t)$ is the inverse Laplace transform $X(s)$. Symbolically,
$$\begin{aligned}
X(s)=\mathcal{L}[x(t)] &  & \text{and} &  & x(t)=\mathcal{L}^{-1}[X(s)]
\end{aligned}$$
Note that
$$\begin{aligned}
\mathcal{L}^{-1}\{ \mathcal{L}[x(t)] \}=x(t) &  & \text{and} &  & \mathcal{L}\{ \mathcal{L}^{-1}[X(s)] \}=X(s)
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
>[](LSY1_007/Pasted%20image%2020240718093739.png)b) $-e^{-at}\mathbb{1}(-t)$ have the same Laplace transform but different regions of convergence.
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
- [[../DEQ1/DEQ1_009 טרנספורמציית לפלס#טבלת טרנספורמציית לפלס|Laplace transform table]]

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
> This is a generlization of [[../BMA1/BMA1_004 אלגוריתמים נפוצים#אלגוריתם פירוק לשברים חלקיים|פירוק לשברים חלקיים]].

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

# Exercises

## Question 1
Consider the signal $y$ shown in the following figure:
![[LSY1_007/Pasted image 20240718094426.png|book]]
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

![[LSY1_007/Pasted image 20240718094741.png|book|400]]
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
\end{gathered}$$\
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
![[LSY1_007/Pasted image 20240723143354.png|book|400]]
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
![[LSY1_007/Pasted image 20240725155953.png|book|450]]
>RLC circuit

In other words, the input is the applied voltage $v_{\text{in}}$ and the output is the resistor's current $i_{R}$. Here $R=1,\,L= 1$, and $C=\dfrac{1}{8}$ are constants, referred to as the resistance, inductance, and capacitance, respectively.

### Part a
Write the transfer function $G_{RLC}(s)$ of the system.

**Solution**:
By [[../PHY2/PHY2_004 מעגלים חשמליים#חוקי קירכהוף|Kirchhoff's voltage law]],
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

![[LSY1_007/Screenshot_20240725_202406_Obsidian.jpg|book|400]]
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
