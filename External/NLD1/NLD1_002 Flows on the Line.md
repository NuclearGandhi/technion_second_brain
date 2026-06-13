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

![[Pasted image 20260613161424.png|bookhue|600]]
>Graphical analysis of $\text{(SS2.1)}$. [[#Bibliography|(Strogatz, 2019)]].

