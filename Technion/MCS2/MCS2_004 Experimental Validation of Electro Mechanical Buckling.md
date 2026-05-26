---
aliases:
---
>[!TODO] TODO: להוסיף שרטוט

>Schematic view of a clamped-guided beam which is subjected to both an axial load and a symmetric electrostatic field. One of the electromechanically buckled configurations is marked by the dashed lines.

Only from a mechanical perspective:
$$EIy''=-Py$$
Which can be rearranged:
$$y''+\dfrac{P}{EI}y=0$$
Which has the solution:
$$y=A\sin(\lambda x)+B\cos(\lambda x)$$
with $\lambda^{2}=P/EI$

Taking into account the boundaries:
$$\begin{aligned}
 & y(0)=0 : &  & 0=0+B\cos(0) \\[1ex]
 &  &  & \implies B=0 \\[3ex] \\
 & y(L)=0 &  & A\sin(\lambda x)+0=0 \\[1ex]
 &  &  & \implies \lambda=\dfrac{n\pi}{L}
\end{aligned}$$
where we ignored $A=0$ since it is the trivial solution.

We now have
$$P=n^{2}\pi ^{2} \dfrac{EI}{L}$$
So we know that for $P>\pi ^{2} EI/L$ we have buckling, but we still don't know $A$. In fact, to solve for $A$, we would need to perform an additional non-linear analysis of the problem, since when the beam buckles our Euler-Bernoulli assumptions do not hold.

>[!TODO] TODO: Add more explanation.

From the electrostatic perspective, we have:
$$EI \dfrac{\mathrm{d}^{4}y}{\mathrm{d}x^{4}}=q(y)$$
where:
$$q(y)=\dfrac{1}{2}{\varepsilon}_{0}bV^{2}\left[ \dfrac{1}{(g-y)^{2}}-\dfrac{1}{(g+y)^{2}} \right]$$


>[!TODO] TODO: Go over and explain the following equation:
>$$\tiny E^{*}I \dfrac{\mathrm{d}^{4}y}{\mathrm{d}x^{4}}-\sigma A \dfrac{\mathrm{d}^{2}y}{\mathrm{d}x^{2}}-EA\left[ \dfrac{1}{L}\int_{0}^{L} \dfrac{1}{2}\left( \dfrac{\mathrm{d}y}{\mathrm{d}x} \right)^{2} \, \mathrm{d}x  \right] \dfrac{\mathrm{d}^{2}y}{\mathrm{d}x^{2}}=\dfrac{1}{2}{\varepsilon}_{0}bV^{2}\left[ \dfrac{1}{(g-y)^{2}}-\dfrac{1}{(g+y)^{2}} \right]$$

In normalized form:
$$\dfrac{\mathrm{d}^{4}\tilde{y}}{\mathrm{d}\tilde{x}^{4}}-\tilde{p} \dfrac{\mathrm{d}^{2}\tilde{y}}{\mathrm{d}\tilde{x}^{2}}-\tilde{V}^{2}\tilde{y}=0$$
>[!TODO] TODO: להשלים

The general solution of the homogeneous differential equation is given by:
$$\tilde{y}(\tilde{x})={c}_{1}e^{\lambda \tilde{x}}+{c}_{2}e^{-\lambda \tilde{x}}+{c}_{3}\cos(\Lambda \tilde{x})+{c}_{4}\sin(\Lambda \tilde{x})$$
where ${c}_{1},{c}_{2},{c}_{3}$ and ${c}_{3}$ are constant parameters. The eigenvalues $\lambda$ and $\Lambda$ are given by
$$\begin{aligned}
 & \lambda=\sqrt{ \dfrac{\tilde{p}+\sqrt{ \tilde{p}^{2}+4\tilde{V}^{2} }}{2} } \\[1ex]
 & \Lambda=\sqrt{ \dfrac{-\tilde{p}+\sqrt{ \tilde{p}^{2}+4\tilde{V}^{2} }}{2} }
\end{aligned}$$
>[!TODO] TODO: להשלים

