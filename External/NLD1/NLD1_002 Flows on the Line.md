---
aliases:
---
# Introduction
We shall introduce the general system
$$\begin{aligned}
 & \dot{x}_{1}={f}_{1}({x}_{1},\dots ,{x}_{n}) \\[1ex]
 & \dot{x}_{n}={f}_{n}({x}_{1},\dots ,{x}_{n})
\end{aligned}$$
Its solutions could be visualizes as trajectories flowing through an $n$-dimensional phase space with coordinates $({x}_{1},\dots,{x}_{n})$.

1. The word *system* is being used here in the sense of a dynamical system, not in the classical sense of a collection of two or more equations. Thus, even a single equation can be a "system".
2. We do not allow $f$ to depend explicitly on time. Time-dependent or "nonautonomous" equations of the form $\dot{x}=f(x,t)$ are more complicated, because one needs *two* pieces of information, $x$ and $t$, to predict the future state of the system. Thus, $\dot{x}=f(x,t)$ should really regarded as a two-dimensional or second-order system.

# A Geometric Way of Thinking
Consider the following nonlinear differential equation:
$$\dot{x}=\sin x\tag{SS2.1}$$
We separate the variables and then integrate:
$$\mathrm{d}t=\dfrac{\mathrm{d}x}{\sin x}$$
which implies
$$\mathrm{d}t=\dfrac{\mathrm{d}x}{\sin x}$$
which implies
$$\begin{aligned}
t & =\int \csc x \, \mathrm{d}x  \\[1ex]
 & =-\ln \left\lvert  \dfrac{1}{\sin x}+\cot x  \right\rvert +C
\end{aligned}$$
To evaluate the constant $C$, suppose that $x={x}_{0}$ at $t=0$. Then $C=\ln \left\lvert  \dfrac{1}{\sin {x}_{0}}+\cot {x}_{0}  \right\rvert$. Hence the solution is
$$t=\ln \left\lvert  \dfrac{\csc {x}_{0}+\cot {x}_{0}}{\csc x+\cot x}  \right\rvert \tag{SS2.2}$$
This result is exact, but a headache to interpret. For example, can you answer the following questions?
1. Suppose ${x}_{0}=\pi /4$; describe the qualitative features of the solution $x(t)$ for all $t<0$. In particular, what happens as $t \to \infty$?
2. For an *arbitrary* initial condition ${x}_{0}$, what is the behavior as $x(t)$ as $t \to \infty$.

In contrast, a *graphical analysis* of $\text{(SS2.1)}$ is clear and simple, as shown in [[#^figure-2-1-1|figure]]. We think of $t$ as time, $x$ as the position of an imaginary particle moving along the real line, and $\dot{x}$ as the velocity of that particle. Then the differential equations $\dot{x}=\sin x$ represents a *vector field* on the line: it dictates the velocity vector $\dot{x}$ at each $x$. To sketch the vector field, it is convenient to plot $\dot{x}$ versus $x$, and then draw arrows on the $x$-axis to indicate the corresponding velocity vector at each $x$.

![[Pasted image 20260613161424.png|bookhue|600]]^figure-2-1-1
>Graphical analysis of $\text{(SS2.1)}$. [[#Bibliography|(Strogatz, 2019)]].

A more physical way to think about the vector field is to imagine that fluid is flowing steadily along the $x$-axis with a velocity that varies from place to place, according to the rule $\dot{x}=\sin x$. As shown in [[#^figure-2-1-1|figure]], the *flow* is to the right when $\dot{x}>0$ and to the left when $\dot{x}<0$. At points where $\dot{x}=0$, there is no flow; such points are therefore called *fixed points*. One can see that there are *stable* fixed points called *attractors* or *sinks*, and there are *unstable* fixed points called *repellers* or *sources*.

This approach allows us to answer the question above as follows:
1. [[#^figure-2-1-1|Figure]] shows that a particle starting at ${x}_{0}=\pi /4$ moves to the right faster and faster until it crosses $x=\pi / 2$ (where $\sin x$ reaches its maximum). Then the particle starts slowing down and eventually approaches the stable fixed point $x=\pi$ from the left. Thus, the qualitative form of the solution is as shown in [[#^figure-2-1-2|figure]].
	Note that the curve is concave up at first, and then concave down; this corresponds to the initial acceleration for $x<\pi  / 2$, followed by the deceleration toward $x=\pi$.


![[Pasted image 20260613221746.png|bookhue|600]]^figure-2-1-2
>Solution of $\text{(SS2.1)}$ for ${x}_{0}=\pi / 4$. [[#Bibliography|(Strogatz, 2019)]].

The same reasoning applies to any initial condition ${x}_{0}$. [[#^figure-2-1-1|Figure]] shows that if $\dot{x}>0$ initially, the particle heads to the right and asymptotically approaches the nearest stable fixed point. Similarly, if $\dot{x}<0$ initially, the particle approaches the nearest stable fixed point to its left. If $\dot{x}=0$, then $x$ remains constant. The qualitative form of the solution for any initial condition is sketched in 

![[Pasted image 20260613222348.png|bookhue|400]]
>Various solutions of $\text{(SS2.1)}$ for different initial conditions ${x}_{0}$. [[#Bibliography|(Strogatz, 2019)]].

>[!notes] Notes: 
 >From here on out, the chapter repeats a lot of material covered in [[LSY1_000 034032 Linear Systems E|Linear Systems]], [[DVI1_000 00340051 דינמיקה ותנודות|Vibrations]], and more.

 