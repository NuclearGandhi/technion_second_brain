---
aliases:
---
# Introduction
From [[LSY1_000 034032 Linear Systems E#Bibliography|(Lathi & Green, 2018)]]:
Electrical engineers instinctively think of signals in terms of their frequency spectra and think of systems in terms of their frequency response. Most teenagers know about the audible portion of audio signals having a bandwidth of about 20 kHz and the need for good-quality speakers to respond up to 20 kHz. This is basically thinking in the frequency domain. 
In the following chapter we discuss spectral representation of signals, where signals are expressed as a sum of sinusoids or exponentials. Actually, we touched on this topic in the [[LSY1_007 Laplace Transform#Introduction|previous chapter]]. Recall that the Laplace transform of a continuous-time signal is its spectral representation in terms of exponentials (or sinusoids) of complex frequencies. However, in the earlier chapters we were concerned mainly with system representation; the spectral representation of signals was incidental to the system analysis. Spectral analysis of signals is an important topic in its own right, and now we turn to this subject.
In this chapter we show that a periodic signal can be represented as a sum of sinusoids (or exponentials) of various frequencies.

# Fourier Series

![](https://www.youtube.com/watch?v=r6sGWTCMz2k)

A [[../CAL1/CAL1_001 פונקציה#פונקציה מחזורית|periodic signal]] $x(t)$ with period ${T}$ has the property
$$x(t)=x(t+{T})$$
for all $t$. The *smallest* values of ${T}$ that satisfies this periodicity condition is the *fundamental period* of $x(t)$.

![[LSY1_008/Pasted image 20240802175436.png|book]]
>A periodic signal of period ${T}_{0}$

It can be shown that:
>[!theorem] Theorem: 
> If $x:\mathbb{R}\to \mathbb{R}$ is $T$-periodic and continuous, then we can decompose it into a **Fourier series**
> $$x(t)=\sum_{k=-\infty }^{+\infty }X[k]e^{j{\omega}_{0}kt} $$
> where
> $$X[k]=\dfrac{1}{T}\int_{-T/2}^{T/2} x(t)e^{-j{\omega}_{0}kt} \, \mathrm{d}t $$
> and
> $${\omega}_{0}=\dfrac{2\pi}{T}$$
> $X[k]$ are known as the **Fourier coefficients** of $x$ and ${\omega}_{0}$ is known as its **fundamental frequency**.

The expansion
$$x(t)=\sum_{k=-\infty }^{+\infty }X[k]e^{j{\omega}_{0}kt} $$
means that every $T$-periodic $x$ is a linear combination of elementary harmonics
$$\alpha_{x,k}(t):=e^{j{\omega}_{0}kt}$$
whose frequencies are multiples of the fundamental frequency ${\omega}_{0}=\dfrac{2\pi}{T}$.
A $T$-periodic $x$ and be equivalently represented by $X$, known as the **frequency-domain representation** of $x$.

# Fourier Transform

![](https://www.youtube.com/watch?v=spUNpyF58BY)

>[!def] Definition: 
> For a signal $x(t)$, its **Fourier transform** $X(j\omega)$ is defined by
> $$X(j\omega)=\int_{-\infty }^{\infty } x(t)e^{-j\omega t} \, \mathrm{d}t $$
> Under some mild conditions, the inverse Fourier transform is
> $$x(t)=\dfrac{1}{2\pi }\int_{\infty }^{\infty } X(j\omega) e^{j\omega t}\, \mathrm{d}\omega $$
> where $c$ is a constant chosen to ensure the convergence of the integral.

Symbolically:
$$\begin{aligned}
X(j\omega)=\mathcal{F}[x(t)] &  & \text{and} &  & x(t)=\mathcal{F}^{-1}[X(j\omega)]
\end{aligned}$$


## Basic Properties


| property        | time domain                       | frequency domain                                             |
| --------------- | --------------------------------- | ------------------------------------------------------------ |
| linearity       | $x={a}_{1}{x}_{1}+{a}_{2}{x}_{2}$ | $X(j\omega)={a}_{1}{X}_{1}(j\omega)+{a}_{2}{X}_{2}(j\omega)$ |
| duality         | $y=X(t)$                          | $Y(j\omega)=2\pi x(-\omega)$                                 |
| time shift      | $y=x(\tau+x)$                     | $Y(j\omega)=e^{j\omega \tau}X(j\omega)$                      |
| time scaling    | $y=x(\xi t)$                      | $\dfrac{1}{\xi}X\left( \dfrac{j\omega}{\xi} \right)$         |
| conjugation     | $y=\bar{x}$                       | $Y(j\omega)=\overline{X(-j\omega)}$                          |
| modulation      | $y=xe^{j{\omega}_{0}t}$           | $Y(j\omega)=X(j(\omega-{\omega}_{0}))$                       |
| differentiation | $y=\dot{x}$                       | $Y(j\omega)=j\omega X(j\omega)$                              |
| convolution     | $z=x*y$                           | $Z(j\omega)=X(j\omega)Y(j\omega)$                            |


### The Dirac Delta Property
if $x(t)=\delta(t)$, then by the [[LSY1_002 Signals and Convolutions#The Sifting Property|sifting property]]:
$$\begin{aligned}
X(j\omega) & =\int_{-\infty }^{\infty } \delta(t)e^{-j\omega t} \, \mathrm{d}t  \\[1ex]
 & =e^{-j\omega t}\bigg|_{0}^{}   \\[1ex]
 & =1
\end{aligned}$$
i.e. $\mathcal{F}\{ \delta \}$ contains all elementary harmonics $\alpha_{x,\omega}=\dfrac{1}{2\pi}e^{j\omega t}$.

There are several consequences to this property:
- if $y\equiv 1$, then by duality and evenness of $y$:
	$$Y(j\omega)=2\pi\delta(\omega)$$
- by modulation, if $y=e^{j{\omega}_{0}t}$, then:
	$$Y(j\omega)=2\pi\delta(\omega-{\omega}_{0})$$
- by linearity, if $y(t)=\sin({\omega}_{0}t+\phi)$, then:
	$$Y(j\omega)=\pi e^{j(\pi /2-\phi)}\delta(\omega+{\omega}_{0})-\pi e^{j(\pi /2+\phi)}\delta(\omega-{\omega}_{0})$$
# Exercises

## Question 1
Consider the signal $x$ defined as
$$x(t)=\lvert \sin(\omega_{x}t+\phi) \rvert$$
![[LSY1_008/Pasted image 20240802182658.png|book]]
### Part a
Identify the period $T$ and the fundamental frequency ${\omega}_{0}$.

**Solution**:
The period of $\sin(\omega_{x}t+\phi)$ is simply $\dfrac{2\pi}{\omega_{x}}$. Since the given signal is taken in its absolute:
$$T=\dfrac{\pi}{\omega_{x}}$$
The fundamental frequency is therefore:
$$\begin{aligned}
{\omega}_{0} & =\dfrac{2\pi}{T} \\[1ex]
 & =2\omega_{x}
\end{aligned}$$

### Part b
Decompose this signal into its Fourier series.

**Solution**:
By its [[#Fourier Series|definition]]:
$$\begin{aligned}
X[k] & =\dfrac{1}{T}\int_{-T/2}^{T/2}\lvert \sin(\omega_{x}t+\phi) \rvert e^{-j{\omega}_{0}kt}  \, \mathrm{d}t 
\end{aligned}$$
Notice that the function inside the modulus ($\lvert  \rvert$) is positive when $0<\omega_{x}t+\phi<\pi$.
Because the given signal is periodic, we can shift it by $T/2-\dfrac{\phi}{\omega_{x}}$, and still get the same integral
$$X[k]=\dfrac{1}{T}\int_{-\phi/\omega_{x}}^{T-\phi/\omega_{x}}  \sin(\omega_{x}t+\phi)e^{-j{\omega}_{0}kt}\,\mathrm{d}t $$
thus ridding us of the modulus ($\lvert  \rvert$). 

Using [[LSY1_004 Linear State-Space Equation#Euler's Formula|euler's formula]]:
$$\begin{aligned}
X[k] & =\dfrac{1}{T}\int_{-\phi/\omega_{x}}^{T-\phi/\omega_{x}}  \dfrac{e^{j(\omega_{x}t+\phi)}-e^{-j(\omega_{x}t+\phi)}}{2j}   e^{-j{\omega}_{0}kt} \, \mathrm{d}t \\[1ex]
 & =\dfrac{1}{2jT}\int_{-\phi/\omega_{x}}^{T-\phi/\omega_{x}} e^{j[(\omega_{x}-{\omega}_{0}k)t+\phi]}-e^{j[(-\omega_{x}-{\omega}_{0}k)t-\phi]} \, \mathrm{d}t
\end{aligned}$$
since ${\omega}_{0}=2\omega_{x}$:
$$\begin{aligned}
X[k] & =\dfrac{1}{2jT}\int_{-\phi/\omega_{x}}^{T-\phi/\omega_{x}} e^{j[(\omega_{x}-2\omega_{x}k)t+\phi]}-e^{j[(-\omega_{x}-2\omega_{x}k)t-\phi]} \, \mathrm{d}t  \\[2ex]
 & =\dfrac{e^{j\phi}}{2jT}\int_{-\phi/\omega_{x}}^{T-\phi/\omega_{x}} e^{j\omega_{x}t(1-2k)}  \, \mathrm{d}t-\dfrac{e^{-j\phi}}{2jT}\int_{-\phi/\omega_{x}}^{T-\phi/\omega_{x}} e^{-j\omega_{x}t(1+2k)} \, \mathrm{d}t  \\[2ex]
 & =\dfrac{e^{j\phi}}{2jT}\cdot \dfrac{1}{j\omega _{x}(1-2k)}\left[ e^{(1-2k)j\omega_{x}t}\vphantom{\left( \dfrac{1}{1} \right)} \right]_{-\phi/\omega_{x}}^{T-\phi/\omega_{x}} \\[1ex]
 & \qquad +\dfrac{e^{-j\phi}}{2jT}\cdot \dfrac{1}{j\omega_{x}(1+2k)}\left[ e^{-(1+2k)j\omega_{x}t}\vphantom{\left( \dfrac{1}{1} \right)} \right]_{-\phi/\omega_{x}}^{T-\phi/\omega_{x}}
\end{aligned}$$
Because $T\omega_{x}=\pi$:
$$\begin{aligned}
e^{(1-2k)j\omega_{x}(T-\phi/\omega_{x})} & =e^{(1-2k)j\omega_{x}(\pi /\omega_{x}-\phi/\omega_{x})} \\[1ex]
 & =e^{(1-2k)j(\pi-\phi)}
\end{aligned}\qquad  \begin{aligned}
e^{(1-2k)j\omega_{x}(-\phi/\omega_{x})}  & =e^{-(1-2k)j\phi} \\[1ex]
 & \phantom{e^{(1-)}}
\end{aligned}$$

Therefore:
$$\begin{aligned}
X[k] & =\dfrac{e^{j\phi}}{2j(\pi /\omega_{x})}\cdot \dfrac{e^{(1-2k)j(\pi-\phi)}-e^{-(1-2k)j\phi}}{j\omega_{x}(1-2k)} \\[1ex]
 & \qquad +\dfrac{e^{-j\phi}}{2j(\pi /\omega_{x})}\cdot \dfrac{e^{-(1+2k)j(\pi-\phi)}-e^{(1+2k)j\phi}}{j\omega_{x}(1+2k)} \\[2ex]
 & =\dfrac{e^{j\phi}}{2\pi j^{2}}\cdot \dfrac{e^{-(1-2k)j\phi}(e^{(1-2k)j\pi}-1)}{1-2k}+\dfrac{e^{-j\phi}}{2\pi j^{2}}\cdot \dfrac{e^{(1+2k)j\phi}(e^{-(1+2k)j\pi}-1)}{1+2k} \\[2ex]
 & =-\dfrac{1}{2\pi}\left[ \dfrac{e^{j\phi}}{1-2k}e^{-(1-2k)j\phi}(e^{(1-2k)j\pi}-1)+\dfrac{e^{-j\phi}}{1+2k}e^{(1+2k)j\phi}(e^{-(1+2k)j\pi}-1) \right]
\end{aligned}$$
Since $k\in \mathbb{Z}$, by Euler's formula:
$$\begin{aligned}
e^{(1-2k)j\pi}=-1 &  & e^{-(1+2k)j\pi}=-1
\end{aligned}$$
Therefore:
$$\begin{aligned}
X[k] & =\dfrac{1}{\pi}\left( \dfrac{e^{j\phi}}{1-2k}e^{-(1-2k)j\phi} +\dfrac{e^{-j\phi}}{1+2k}e^{(1+2k)j\phi}\right) \\[2ex]
 & =\dfrac{1}{\pi}\left( \dfrac{e^{2kj\phi}}{1-2k} +\dfrac{e^{2kj\phi}}{1+2k}\right) \\[2ex]
 & =\dfrac{e^{2kj\pi}}{\pi}\left( \dfrac{1+2k+1-2k}{1-4k^{2}} \right) \\[2ex]
 & =\dfrac{2e^{j\phi k}}{(1-4k^{2})\pi}
\end{aligned}$$

To conclude:
$$\boxed {
x(t)=\sum _{k=-\infty }^{\infty } \dfrac{2e^{j\phi k}}{(1-4k^{2})\pi}e^{j\omega _{0}kt}
 }$$

![[LSY1_008/Pasted image 20240803103050.png|book]]
>Partial Fourier series - $x_{N}(t)=\sum_{k=-N}^{N}X[k]e^{j{\omega}_{0}kt}$


### Part c
Apply the Fourier transform to this signal.

**Solution**:
We know that $x(t)$ can be represented as a sum of its Fourier series  $\sum_{k=-\infty}^{\infty}X[k]e^{-j{\omega}_{0}k t}$. Therefore:
$$\mathcal{X}(j\omega)=\mathcal{F}\left\{ \sum_{k=-\infty }^{\infty} X[k]e^{-j{\omega}_{0}kt} \right\}$$
By the linearity of the Fourier transform;
$$\mathcal{X}(j\omega)=\sum_{k=-\infty }^{\infty }X[k] \mathcal{F}\{ e^{-j{\omega}_{0}kt} \}$$
By the [[#The Dirac Delta Property|dirac delta property]]:
$$\mathcal{X}(j\omega)=\sum_{k=-\infty }^{\infty }X[k]\cdot 2\pi\delta(\omega-k{\omega}_{0}) $$
Using the answer for the previous part, we see that:
$$\begin{aligned}
\mathcal{X}(j\omega) & =2\pi \sum_{k=-\infty }^{\infty } \dfrac{2e^{2j\phi k}}{(1-4k^{2})\pi}\cdot\delta(\omega-k{\omega}_{0})
\end{aligned}$$
Therefore:
$$\boxed {
\mathcal{X}(j\omega)=4\sum_{k=-\infty }^{\infty } \dfrac{e^{2j\phi k}}{1-4k^{2}}\delta(\omega-k{\omega}_{0}) 
 } $$

![[LSY1_008/Pasted image 20240803142518.png|book]]
>The Fourier spectrum


