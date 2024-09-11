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

## Question 2
Match the signals in the time domain to their corresponding magnitude Fourier spectrum:
![[LSY1_008/Pasted image 20240904204111.png|book]]
>Signals in the time domain.

![[LSY1_008/Pasted image 20240904204133.png|book]]
>Signals in the frequency domain.

**Solution**:
Periodic signals are always characterized by [[LSY1_002 Signals and Convolutions#The Delta Function|Dirac]] pulses in the Fourier domain. signals $(a)$ and $(b)$ have only sinusoidal components and therefore fall into this category. The main contribution of signal $(a)$ is slower than signal $(d)$, but signal $(a)$ also has an extra high frequency component. Therefore:
$$\begin{array}{c|c}
x(t) & X(j\omega) \\
\hline(a) & (2) \\
(d) & (3)
\end{array}$$
Signals $(b)$ and $(c)$ are rectangular pulses and are therefore aperiodic. The shorter pulse is more stretched in the Fourier domain and vice versa. This is known as the [[#Basic Properties#|time scaling]] property:
$$y=x(\xi t)\implies Y(j\omega)=\dfrac{1}{\xi}X \left( \dfrac{j\omega}{\xi} \right)$$
Therefore, stretching the signal in the time domain will cause the signal to contract in the Fourier domain.
What about a shift in time as is the case signal $(b)$? If $y(t)=x(t+\tau)$, then by the [[#Basic Properties|time shift property]]:
$$\begin{aligned}
y=x(\tau+x)\implies Y(j\omega)=e^{j\omega \tau}X(j\omega)
\end{aligned}$$
Therefore, the shift in time only influences the phase of the signal and therefore has no effect on the magnitude of the spectrum $\lvert X(j\omega) \rvert$, which is what we plot in figure $(4)$.
$$\begin{array}{c|c}
x(t) & X(j\omega) \\
\hline(b) & (4) \\
(c) & (1)
\end{array}$$
## Question 3
Consider the signal $y$:
$$y=\mathbb{S}_{1/2}\mathrm{rect}-\mathbb{S}_{1/2}\mathrm{rect}\implies y(t)=\mathrm{rect}\left( t+\dfrac{1}{2} \right)-\mathrm{rect}\left( t-\dfrac{1}{2} \right)$$
where
$$\mathrm{rect}(t)=\begin{cases}
1 & \lvert t \rvert\leq  1/2 \\
0 & \text{otherwise}
\end{cases}$$
shown in the following figure:
![[LSY1_008/Pasted image 20240905104612.png|book]]
>The signal $y$

### Part a
Show that $y(t)=\dfrac{\mathrm{d}}{\mathrm{d}t}\mathrm{tent}(t)$.

**Solution**:
We know that:
$$\mathrm{tent}(t)=\begin{cases}
1-\lvert t \rvert & \lvert t \rvert \leq  1 \\[1ex]
0 & \lvert t \rvert>1
\end{cases}$$
Differentiating each section of this function yields:
$$\dfrac{\mathrm{d}}{\mathrm{d}t}\mathrm{tent}(t)=\begin{cases}
-(-1)=1 & -1\leq  t\leq  0 \\[1ex]
-1 & 0<  t\leq  1 \\[1ex]
0 &   \lvert t \rvert >  1
\end{cases}$$
Therefore:
$$y(t)=\dfrac{\mathrm{d}}{\mathrm{d}t}\mathrm{tent}(t)$$
$\blacksquare$

## Part b
Find the Fourier transform of $y$.

**Solution**:
By [[LSY1_008 Fourier Transform#Fourier Transform|definition]]:
$$\begin{aligned}
\mathcal{F}\{ y(t) \} & =\int_{-\infty }^{\infty } y(t)e^{-j\omega t} \, \mathrm{d}t  \\[1ex]
 & =\int_{-1}^{0}e^{-j\omega t}  \, \mathrm{d}t+\int_{0}^{1} -e^{-j\omega t} \, \mathrm{d}x   \\[1ex]
 & =\left[ -\dfrac{1}{j\omega}e^{-j\omega t} \right]_{-1}^{0}+\left[ \dfrac{1}{j\omega}e^{-j\omega t} \right]_{0}^{1} \\[1ex]
 & =-\dfrac{1}{j\omega}(1-e^{j\omega})+\dfrac{1}{j\omega}(e^{-j\omega}-1) \\[1ex]
 & =\dfrac{1}{\omega}(e^{j\omega}+e^{-j\omega}-2) \\[1ex]
 & =\dfrac{2\cos(\omega)-2}{j\omega} \\[1ex]
 & =\dfrac{2(1-2\sin ^{2}(\omega /2))-2}{j\omega} \\[1ex]
 & =-\dfrac{4\sin ^{2}(\omega /2)}{j\omega}
\end{aligned}$$
To get the result in the official answer, we can:
$$\begin{aligned}
\mathcal{F}\{ y(t) \} & =-j\omega \dfrac{4(\sin(\omega /2))^{2}}{j^{2}\omega ^{2}} \\[1ex]
 & =j\omega \dfrac{4(\sin(\omega /2))^{2}}{4(\omega /2)^{2}} \\[1ex]
 & =j\omega\, \mathrm{sinc}^{2} (\omega /2)
\end{aligned}$$
Therefore:
$$\boxed {
\mathcal{F}\{ y(t) \}=j\omega\, \mathrm{sinc}^{2} (\omega /2)
 }$$

### Part c
Find the Fourier transform of the following signal by the using the previous result:
$$y^{*}(t)=\mathrm{rect}\left( \dfrac{t}{a}+\dfrac{1}{2} \right)-\mathrm{rect}\left( \dfrac{t}{a}-\dfrac{1}{2} \right)\qquad  a>0$$

**Solution**:
By the [[#Basic Properties|scaling property]]:
$$\begin{gathered}
\mathcal{F}(y^{*}(t))=a\mathcal{F}\{ y(t) \}\left( aj\omega \right) \\[1ex]
\boxed {
\mathcal{F}(y^{*}(t))=a^{2}j\omega \,\mathrm{sinc}^{2} (a\omega /2)
 }
\end{gathered}$$

## Question 4
Consider $y=\mathrm{sinc}$.

### Part a
Find the Fourier transform of this signal.

**Solution**:
First, we'll show that $\mathcal{F}\{ \mathrm{\mathrm{rect}}(t) \}=\mathrm{sinc} (\omega /2)$ by [[#Fourier Transform|definition]]:
$$\begin{aligned}
\mathcal{F}\{ \mathrm{rect}(t) \} & =\int_{-\infty }^{\infty } \mathrm{rect}(t)e^{-j\omega t} \, \mathrm{d}t \\[1ex]
 & =\int_{-1/2}^{1/2} e^{-j\omega t} \, \mathrm{d}t \\[1ex]
  & =\left[ -\dfrac{1}{j\omega}e^{-j\omega t} \right]_{-1/2}^{1/2} \\[1ex]
 & =-\dfrac{1}{j\omega}e^{-(1/2)j\omega}+\dfrac{1}{j\omega}e^{(1/2)j\omega} \\[1ex]
\end{aligned}$$
By [[LSY1_004 Linear State-Space Equation#Euler's Formula|Euler's formula]]:
$$\begin{aligned}
\mathcal{F}\{ \mathrm{rect}(t) \} & =\dfrac{2j\sin(\omega /2)}{j\omega} \\[1ex]
 & =\dfrac{\sin(\omega /2)}{\omega /2} \\[1ex]
 & =\mathrm{sinc} (\omega /2)
\end{aligned}$$
Cool. Now we can use the [[#Basic Properties|time scaling property]] (and also linearity) to say:
$$\mathcal{F}\left\{  \dfrac{1}{2}\mathrm{rect}\left( \dfrac{t}{2} \right)  \right\}=\,\mathrm{sinc} (\omega)$$
Therefore, by the [[#Basic Properties|duality property]]:
$$\begin{gathered}
\mathcal{F}\{ \mathrm{sinc} (t) \}=2\pi\cdot \dfrac{1}{2}\mathrm{rect}(-\omega /2) \\[1ex]
\boxed{\mathcal{F}\{ \mathrm{sinc} (t) \}=\pi \,\mathrm{rect}(\omega /2) }
\end{gathered}$$
where the fact that $\mathrm{rect}(-t)=\mathrm{rect}(t)$ was used.

### Part b
Use Parseval's theorem
$${\lVert y \rVert _{2}}^{2}=\dfrac{1}{2\pi}{\lVert Y \rVert _{2}}^{2}$$
where ${\lVert y \rVert_{2}}^{2}=\int_{-\infty}^{\infty} \lvert y(t) \rvert^{2} \, \mathrm{d}t$ and ${{\lVert Y \rVert}_{2}}^{2}=\int_{-\infty}^{\infty} \lvert y(t) \rvert^{2} \, \mathrm{d}t$ and ${\lVert Y \rVert_{2}}^{2}=\int_{-\infty}^{\infty} \lvert Y(j\omega)^{2} \rvert \, \mathrm{d}\omega$, to calculate the $2$-norm squared of $y$.

**Solution**:
It is not trivial at all to calculate the integral of the $\mathrm{sinc^{2}(t)}$ . Luckily, we can use the given Parseval’s theorem:
$$\begin{aligned}
{\lVert y \rVert _{2}}^{2} & =\dfrac{1}{2\pi}\int_{-\infty }^{\infty } \lvert Y(j\omega) \rvert^{2} \, \mathrm{d}\omega  \\[1ex]
 & =\dfrac{1}{2\pi}\int_{-\infty }^{\infty } \lvert \pi \,\mathrm{rect}(\omega /2)  \rvert^{2}\, \mathrm{d}\omega  \\[1ex]
 & =\dfrac{\pi }{2}\int_{-1}^{1} 1 \, \mathrm{d}\omega \\[1ex]
 & =\pi
\end{aligned}$$
Which is why:
$$\boxed{{\lVert y \rVert_{2}} ^{2}=\pi }$$

## Question 5
Consider the signal $x$ defined as
$$x(t)=5\sin(2t)+0.1\cos(10t)$$

### Part a
Our signal contains a "slow" and a "fast" part. Identify them.

**Solution**:
In terms of frequency, $5\sin(2t)$ is slower because $2<10$.

### Part b
Identify the period $T$ and the fundamental frequency ${\omega}_{0}$.

**Solution**:
The period is the least common multiple of the periods of both parts. In our case it's simple because $10$ is a multiple of $2$:
$$\boxed {
{\omega}_{0}=2
 }$$
Therefore:
$$\begin{gathered}
T=\dfrac{2\pi}{{\omega}_{0}} \\[1ex]
\boxed {
T=\pi
 }
\end{gathered}$$

### Part c
Decompose this signal into its Fourier series.

**Solution**:
There are two approaches to solving this problem:
1. By [[#Fourier Series|definition]]:
	$$\begin{aligned}
X[k] & =\dfrac{1}{T}\int_{-T/2}^{T/2} x(t)e^{-j{\omega}_{0}kt} \, \mathrm{d}t  \\[1ex]
 & = \dfrac{1}{\pi}\int_{-\pi /2}^{\pi /2} (5\sin(2t)+0.1\cos(10t) )e^{-j2kt}\, \mathrm{d}t \\[1ex]
 & =\dfrac{1}{\pi}\int_{-\pi /2}^{\pi /2} (5\sin(2t)+0.1\cos(10t))(\cos(-2kt)+j\sin(-2kt)) \, \mathrm{d}t \\[1ex]
 & =\text{all hell breaks loose}
\end{aligned}$$
2. Party tricks:
	By [[LSY1_004 Linear State-Space Equation#Euler's Formula|Euler's formula]] we know that:
	$$\begin{aligned}
 & \sin(2t)=\dfrac{e^{2jt}-e^{-2jt}}{2j}=\dfrac{e^{j{\omega}_{0}t}-e^{-j{\omega}_{0}t}}{2j} \\[1ex]
 & \cos(10t)=\dfrac{e^{10jt}+e^{-10jt}}{2}=\dfrac{e^{5j{\omega}_{0}t}+e^{-5j{\omega}_{0}t}}{2}
\end{aligned}$$
	Therefore, we can write $x(t)$ in a different way:
	$$\begin{aligned}
x(t) & =\dfrac{5}{2j}(e^{j{\omega}_{0}t}-e^{-j{\omega}_{0}t})+\dfrac{1}{20}(e^{5j{\omega}_{0}t}+e^{-5j{\omega}_{0}t}) \\[1ex]
 & =-2.5je^{j{\omega}_{0}t}+2.5je^{j{\omega}_{0}t}+0.05e^{5j{\omega}_{0}t}+0.05e^{-5j{\omega}_{0}t}
\end{aligned}$$
	We have identified all of the Fourier coefficients:
	$$\boxed {
X[k]=\begin{cases}
\mp 2.5j & k=\pm 1 \\[1ex]
0.05 & k=\pm 5 \\[1ex]
0 & \text{otherwise}
\end{cases}
 }$$



### Part d
Apply the Fourier transform to this signal.

**Solution**:
Using the result from the previous part, by the [[#The Dirac Delta Property|delta function property]]:
$$\begin{aligned}
\mathcal{X}(j\omega) & =2\pi \sum_{k=-\infty }^{\infty }X[k]\delta(\omega-k{\omega}_{0})  \\[1ex]
 & =2\pi[(-2.5j+0.05)\delta(\omega-k{\omega}_{0})+(2.5j+0.05)\delta(\omega+k{\omega}_{0})] \\[1ex]
 & =2\pi[5j\delta k{\omega}_{0}+0.1\delta\omega] \\[1ex]
 & =2\pi\delta(5jk{\omega}_{0}+0.1\omega)
\end{aligned}$$
Therefore:
$$\boxed {
\mathcal{X}(j\omega)=2\pi\delta(5jk{\omega}_{0}+0.1\omega)
 }$$

## Question 6
Consider the signal $x$ defined as
$$x(t)=\lvert \sin(\omega _{x}t) \rvert$$

### Part a
Identify the period $T$ and the fundamental frequency ${\omega}_{0}$.

**Solution**:
The function repeats every $\dfrac{2\pi}{2\omega_{x}}$ units of time, therefore:
$$\begin{aligned}
T=\dfrac{\pi}{\omega_{x}}\qquad {\omega}_{0}=2\omega_{x}
\end{aligned}$$

### Part b
Decompose this signal into its Fourier series.

**Solution**:
By [[#Fourier Series|definition]]:
$$\begin{aligned}
X[k] & =\dfrac{1}{T}\int_{-T/2 }^{T/2 } \lvert \sin(\omega_{x}t) \rvert  e^{-j{\omega}_{0}k t}\, \mathrm{d}t \\[1ex]
 & =\dfrac{\omega_{x}}{\pi}\int_{-\pi/2\omega_{x}}^{0} -\sin(\omega_{x}t)e^{-j{\omega}_{0}kt} \, \mathrm{d}t+\dfrac{\omega_{x}}{\pi}\int_{0}^{\pi/2\omega_{x}}\sin(\omega_{x}t)e^{-j{\omega}_{0}kt}  \, \mathrm{d}t  
\end{aligned}$$
To solve the integral, we notice by [[LSY1_004 Linear State-Space Equation#Euler's Formula|Euler's formula]] that:
$$\begin{aligned}
\sin(\omega_{x}t)e^{-j{\omega}_{0}kt} & =\dfrac{1}{2j}(e^{j\omega_{x}t}-e^{-j\omega_{x}t})e^{-2j\omega_{x}kt} \\[1ex]
 & =\dfrac{1}{2j}(e^{j\omega_{x}t(1-2k)}-e^{j\omega_{x}t(-1-2k)})
\end{aligned}$$
Which is why:
$$\begin{aligned}
\int \sin(\omega_{x}t)e^{-j{\omega}_{0}kt} \, \mathrm{d}t  & =\dfrac{e^{j\omega_{x}t(1-2k)}}{2j\cdot j\omega_{x}(1-2k)}-\dfrac{e^{j\omega_{x}t(-1-2k)}}{2j\cdot j\omega_{x}(-1-2k)}+C \\[1ex]
 & =\dfrac{e^{j\omega_{x}t(-1-2k)}}{2\omega_{x}(-1-2k)} -\dfrac{e^{j\omega_{x}t(1-2k)}}{2\omega_{x}(1-2k)}+C \\[1ex]
 & =\dfrac{(1-2k)e^{j\omega_{x}t(-1-2k)}+(1+2k)e^{j\omega_{x}(1-2k)}}{2\omega_{x}(-1+4k^{2})}+C
\end{aligned}$$


Substituting back to $X[k]$:
$$\begin{aligned}
X[k] & =-\dfrac{\omega_{x}}{\pi}\left[ \dfrac{1-2k+1+2k-[(1-2k)e^{-j\pi(-1-2k)/2}+(1+2k)e^{-j\pi(1-2k)/2}]}{2\omega_{x}(-1+4k^{2})} \right] \\[1ex]
 & \qquad +\dfrac{\omega_{x}}{\pi}\left[ \dfrac{(1-2k)e^{j\pi(-1-2k)/2}+(1+2k)e^{j\pi(1-2k)/2}-(1-2k+1+2k)}{2\omega_{x}(-1+4k^{2})} \right]  \\[1ex]
 & =\dfrac{-4+(1-2k)(e^{-j\pi(-1-2k)/2}+e^{j\pi(-1-2k)/2})+(1+2k)(e^{-j\pi(1-2k)/2}+e^{j\pi(-1-2k)/2})}{2\pi(-1+4k^{2})} \\[1ex]
 & =\dfrac{2}{\pi(1-4k^{2})}[1+(1-2k)e^{j\pi /2}(e^{j\pi k}+e^{-j\pi k})+(1+2k)e^{-j\pi /2}(e^{j\pi k}+e^{-j\pi k})] \\[1ex]
 & =\dfrac{2}{\pi(1-4k^{2})}\left[ 1+2(1-2k)\cos(\pi k)e^{j\pi /2}+2(1+2k)\cos(\pi k)e^{-j\pi /2} \right] \\[1ex]
 & =\dfrac{2}{\pi(1-4k^{2})}[1+2(1-2k)\cos (\pi k)\cdot j+2(1+2k)\cos(\pi k)\cdot(-j)] \\[1ex]
 & =\dfrac{2}{\pi(1-4k^{2})}[1-8kj\cos(\pi k)]
\end{aligned}$$


I don't know where the second term is supposed to disappear, but in the official answer:
$$\boxed {
X[k]=\dfrac{2}{\pi(1-4k^{2})}
 }$$


### Part c
Derive the time shift property of  Fourier series: If $y=x+\tau$, then $Y[k]=e^{j{\omega}_{0}\tau k}X[k]$.

**Solution**:
If $y(t)=x(t+\tau)$, then:
$$\begin{aligned}
Y[k] & =\dfrac{1}{T}\int_{-T/2}^{T/2} y(t)e^{-j{\omega}_{0}kt} \, \mathrm{d}t  \\[1ex]
 &= \dfrac{1}{T}\int_{-T/2}^{T/2} x(t+\tau)e^{-j{\omega}_{0}kt} \, \mathrm{d}t \\[1ex]
 & =e^{j{\omega}_{0}k\tau} \dfrac{1}{T}\int_{-T/2}^{T/2} x(t+\tau)e^{-j{\omega}_{0}k(t+\tau)} \, \mathrm{d}t
\end{aligned}$$
substituting $s=t+\tau$, which means $\mathrm{d}s=\mathrm{d}t$, we get:
$$\begin{aligned}
Y[k] & =e^{j{\omega}_{0}k\tau}\underbrace{  \dfrac{1}{T}\int_{-T/2}^{T/2} x(s)e^{-j{\omega}_{0}ks} \, \mathrm{d}s }_{ X[k] }
\end{aligned}$$
Therefore:
$$Y[k]=e^{j{\omega}_{0}k\tau}X[k]$$
$$\tag*{$\blacksquare$}$$
### Part d
Use the previous results and the time shift property to derive the Fourier series of the signal in the previous part, i.e. $x(t)=\lvert \sin(\omega_{x}t+\phi) \rvert$.

**Solution**:
The time shift is equal to $\tau=\dfrac{\phi}{\omega_{x}}=\dfrac{2\phi}{{\omega}_{0}}$. Therefore, using the previous answers, we get:
$$\boxed {
X[k]=e^{2jk\phi}\dfrac{2}{\pi(1-4k^{2})}
 }$$

## Question 7
Let $x(t)$ be the $2\pi$-periodic signal such that:
$$\begin{aligned}
x(t)=t^{2} &  & -\pi\leq  t\leq  \pi
\end{aligned}$$
Determine the Fourier coefficients $X[k]$ and write down the Fourier series of $x$.

**Solution**:
The function repeats every $2\pi$ units of time, so that:
$$\begin{aligned}
T=2\pi \qquad {\omega}_{0}=1
\end{aligned}$$
By [[#Fourier Series|definition]]:
$$\begin{aligned}
X[k] & =\dfrac{1}{T}\int_{-T/2}^{T/2} t^{2}e^{-j{\omega}_{0}kt} \, \mathrm{d}t  \\[1ex]
 & =\dfrac{1}{T}\left[ \dfrac{j{\omega}_{0}kt(j{\omega}_{0}kt+2)+2}{(-j{\omega}_{0}k)^{3}}e^{-j{\omega}_{0}kt} \right]_{-T/2}^{T/2} \\[1ex]
 & =\dfrac{1}{T}\left[ -\dfrac{{{\omega}_{0}}^{2}k^{2}t^{2}+2{\omega}_{0}kt+2}{j{{\omega}_{0}}^{3}k^{3}}e^{-j{\omega}_{0}kt} \right]_{-T/2}^{T/2} \\[1ex]
 & =-\dfrac{1}{2\pi}\left[ \dfrac{k^{2}t^{2}+2kt+2}{jk^{3}}e^{-jkt} \right]_{-\pi}^{\pi} \\[1ex]
 & =-\dfrac{1}{2\pi}\left[ \dfrac{k^{2}\pi ^{2}+2k\pi+2}{jk^{3}}e^{-jk\pi}-\dfrac{k^{2}\pi ^{2}-2k\pi+2}{jk^{3}}e^{jk\pi} \right] \\[1ex]
 & =-\dfrac{1}{2\pi}\left[ \dfrac{1}{jk^{3}}(k^{2}\pi ^{2}+2k\pi+2)\cos(\pi k)-\dfrac{1}{jk^{3}}(k^{2}\pi ^{2}-2k\pi+2)\cos(\pi k) \right] \\[1ex]
 & =-\dfrac{1}{2\pi}\left[ \dfrac{4k\pi }{jk^{3}}(-1)^{k} \right] \\[1ex]
 & =-\dfrac{2}{jk^{2}}(-1)^{k}
\end{aligned}$$
Notice that specifically for $k=0$:
$$\begin{aligned}
X[0] & =\dfrac{1}{T}\int_{-T/2}^{T/2} t^{2} \, \mathrm{d}t  \\[1ex]
 & =\dfrac{1}{3T}\left[ t^{3}\vphantom{\left( \dfrac{1}{1} \right)} \right]_{-T/2}^{T/2} \\[1ex]
 & =\dfrac{\pi ^{2}}{3}
\end{aligned}$$
Therefore:
$$\boxed {
\lvert X[k] \rvert=\begin{cases}
\pi ^{2}/3 & k=0 \\[1ex]
(-1)^{k} \dfrac{2}{k^{2}} & k\neq 0
\end{cases}
 }$$

