---
aliases:
---
# Introduction
Because of the linearity property of linear time-invaraint systems, we can find the response of these systems by breaking the input $x(t)$ into several components and then summing the system response to all the components of $x(t)$. In **frequency domain analysis** we are breaking up the input $x(t)$ into exponentials of the form $e^{st}$, where the parameter $s$ is the complex frequency of the signal $e^{st}$.
The tool that makes it possible to represent arbitrary input $x(t)$ in terms of exponential components is the [[../DEQ1/DEQ1_009 טרנספורמציית לפלס#טרנספורמציית לפלס|Laplace transform]].

We can also separate the input into exponentials of the form $e^{j\omega t}$ instead of $e^{st}$. This is accomplished the Fourier transform. In a sense, the Fourier transform may be considered to be a special case of the Laplace transform with $s=j\omega$. Although this view is true most of the time, it does not always hold because of the nature of convergence of the Laplace and Fourier integrals.
# The Laplace Transform
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

