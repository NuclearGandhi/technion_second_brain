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
>[!TODO] להשלים 
 


