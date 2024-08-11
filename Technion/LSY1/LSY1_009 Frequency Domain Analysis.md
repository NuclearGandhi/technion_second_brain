---
aliases:
  - frequency domain analysis
---
>[!TODO] להשלים

# Frequency Response
>[!theorem] Theorem: 
> Let $G:u\to y$ be a stable [[LSY1_001 Introduction#State-Space Linear Systems|CLTI]] system. Its response to the *sinusoidal* test input $u$ such that
> $$u(t)=a\sin(\omega t+\phi)\mathbb{1}(t)$$
> in steady state, is also sinusoidal. Specifically:
> $$y_{ss}(t)=a \lvert G(j\omega) \rvert\sin(\omega t+\phi+\mathrm{arg}G(j\omega))$$
> where $\lvert G(j\omega) \rvert$ is the gain (magnitude), and $\mathrm{arg}G(j\omega)$ is the phase of the frequency response $G(j\omega)$ of $G$.

The gain and the phase of the frequency response of $G$ can be calculated as:
$$\begin{aligned}
\lvert G(j\omega) \rvert=\sqrt{ x^{2}+y^{2} } &  & \mathrm{arg}(G(j\omega))=\begin{cases}
\arctan\left( \dfrac{y}{x} \right) &  & x>0 \\[1ex]
\arctan\left( \dfrac{y}{x} \right)+\pi &  & x<0,\, y\geq  0 \\[1ex]
\arctan\left( \dfrac{y}{x} \right)-\pi &  & x<0,\, y<0 \\[1ex]
+\dfrac{\pi}{2} &  & x=0,\, y>0 \\[1ex]
-\dfrac{\pi}{2} &  & x=0,\, y<0 \\[1ex]
\text{undefined} &  & x=0,\, y=0
\end{cases}
\end{aligned}$$
where $x:=\mathrm{Re}\,G(j\omega)$ and $y:= \mathrm{}\,G(j\omega)$.

# Bode Diagram

# Exercises

## Question 1
Draw the asymptotic Bode magnitude plots of the transfer function
$$G(s)=\dfrac{k}{({\tau}_{1}s+1)({\tau}_{2}s+2)}$$
where ${\tau}_{1}>0$ and ${\tau}_{2}>0$.

**Solution**:
We can decompose $G$ to
$$G={G}_{0}\cdot {G}_{1}\cdot {G}_{2}$$
where:
$$\begin{aligned}
{G}_{0}=k &  & {G}_{1}=\dfrac{1}{{\tau}_{1}s+1} &  & {G}_{2}=\dfrac{1}{{\tau}_{2}s+2}
\end{aligned}$$
The transfer function ${G}_{0}(s)=k$ is static, whose magnitude bode diagram is the straight horizontal line at the level $20\log k$ (because on the Bode diagram, the amplitude is shown in $\pu{dB}$).

![[LSY1_009/Screenshot_20240808_110631_Samsung Notes.jpg|book|500]]
>Bode diagram for ${G}_{0}$

The two other transfer functions are first-order transfer functions with the unit static gain of the form $\dfrac{1}{(\tau s+1)}$. The asymptotic magnitude Bode plot of these kinds of transfer functions comprises two straight lines: A horizontal one at $\pu{0dB}$ in the low-frequency range, up to the cutoff frequency $\omega_{c}=\dfrac{1}{\tau}$, and a straight line starting at $\omega_{c}$ and decaying with the slope of $\pu{-20deg/dec}$.

![[LSY1_009/Screenshot_20240808_111720_Samsung Notes 2.jpg|book|500]]
>Bode diagram for $G(s)=1/(\tau s+1)$.

Because we are in a logarithmic graph, the magnitude plot of $G={G}_{0}\cdot {G}_{1}\cdot {G}_{2}$ (a **cascade**) is simply the superposition of their individual Body magnitude plots. So, if $\dfrac{1}{{\tau}_{1}}<\dfrac{1}{{\tau}_{2}}$:
![[LSY1_009/Screenshot_20240808_112158_Samsung Notes 1.jpg|book|500]]
>Bode diagram for $G(s)$; dotted lines correspond to actual Bode plots.

## Question 2
Draw the Bode and polar plots for the following transfer functions:

### Part a
$${G}_{1}(s)=\dfrac{1}{(\tau s+1)^{2}},\, \qquad \tau>0$$
**Solution**:
Let us see what happens at specific frequency points ${\omega}_{1}=0.1/\tau,\,{\omega}_{2}=1/\tau,\,{\omega}_{3}=3/\tau$:
$$\begin{array}{c|c}
\omega & 0 & {\omega}_{1}=0.1/\tau & {\omega}_{2}=1/\tau & {\omega}_{3}=3/\tau & \infty  \\[1ex]
\hline \lvert {G}_{1}(j\omega) \rvert  & 1 & \approx 0.99 & 0.5 & 0.1 & 0 \\[1ex]
\hline \mathrm{arg}({G}_{1}(j\omega)) & 0^{\circ}  & \approx -11^{\circ}  & -90^{\circ}  & \approx -143^{\circ}  & -180^{\circ} 
\end{array}$$
