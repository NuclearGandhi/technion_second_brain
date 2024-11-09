---
aliases:
  - frequency folding
  - analog to digital
  - digital to analog
  - DTFT
  - periodic summation
  - Nyquist frequency
  - zero-order hold
---

# Introduction
From [[LSY1_000 034032 Linear Systems E#Bibliography|(Lathi & Green, 2018)]]:
In [[LSY1_008 Fourier Transform#Introduction|Fourier transform]] and [[LSY1_007 Laplace Transform#Introduction|Laplace transform]] we studies the ways of representing a continuous-time signal as a sum of sinusoids or exponentials. In this chapter we shall discuss similar development for discrete-time signals. Our approach is parallel to that used for a continous-time signals. We first represent a periodic $x[n]$ as a Fourier series formed by a discrete-time exponential (or sinusoid) and its harmonics.

The signal $\alpha[t]=ae^{j\theta t}:\mathbb{Z}\to \mathbb{C}$, for $\alpha \in \mathbb{C}$ and $\theta \in \mathbb{R}$ is called a discrete harmonic signal with frequency $\theta$, amplitude $\lvert a \rvert$, and initial phase $\arg(a)$:

![[Pasted image 20240910194422.png|bookhue|500]]
>A general discrete harmonic signal.

# A/D and D/A Conversion

## Analog to Digital

A conversion of a continuous-time (analog) signal, say $x$, to a discrete-time (digital) signal, say $\bar{x}$, is known as **sampling**. If for all $i\in \mathbb{Z}$
$$\bar{x}[i]=x(s_{i}),\, \qquad  s_{i}<s_{i+1}$$
then the term **ideal sampling** is used. If $s_{i}=ih$ for some $h>0$, we say that the sampling is periodic and call $h$ the **sampling period/interval**.

Sampling frequently (but not always) a **lossy process**, meaning some information about the analog signal $x$ is lost. For example:

![[{618A7062-F644-4678-944F-E805DAC1953E}.png|book]]
>Information loss on an analog signal.

## Digital to Analog
A conversion of a discrete-time (digital) signal, say $\bar{x}$, to a continuous-time (analog) signal, say $x$, is known a **hold** (interpolation). We will mainly deal with **zero-order hold**, which acts as:
$$x(t)=\bar{x}[i],\, \qquad  \forall t\in (s_{i},\, s_{i+1})$$
For example:
![[Pasted image 20240911172913.png|bookhue]]


# Discrete-Time Fourier Transform


>[!def] Definition: 
> A **discrete-time Fourier transform** (DTFT) is defined as
> $$X(e^{j\theta})=\sum_{t=-\infty }^{\infty}x[n]e^{-j\theta n} $$
> under some mild conditions, the inverse discrete-time Fourier transform results in:
> $$x[n]=\dfrac{1}{2\pi}\int_{-\pi}^{\pi} X(e^{j\theta})e^{j\theta t} \, \mathrm{d}\theta $$
> 

Symbolically:
$$\begin{aligned}
X(e^{j\theta})=\mathcal{F}\{ x[n] \} &  & \text{and} &  & x[n]=\mathcal{F}^{-1}\{ X[e^{j\theta}] \}
\end{aligned}$$

## Basic Properties

| property      | time domain                       | frequency domain                                                         |
| ------------- | --------------------------------- | ------------------------------------------------------------------------ |
| linearity     | $x={a}_{1}{x}_{1}+{a}_{2}{x}_{2}$ | $X(e^{j\theta})={a}_{1}{X}_{1}(e^{j\theta})+{a}_{2}{X}_{2}(e^{j\theta})$ |
| time shift    | $y=x(\tau+x)$                     | $Y(e^{j\theta})=e^{j\theta \tau }X(e^{j\theta})$                         |
| time reversal | $y=x(-t)$                         | $X\left(e^{-j\theta} \right)$                                            |
| conjugation   | $y=\bar{x}$                       | $Y(e^{j\theta})=\overline{X(e^{-j\theta})}$                              |
| modulation    | $y=xe^{j{\theta}_{0}t}$           | $Y(e^{j\theta})=X(e^{j(\theta-{\theta}_{0})})$                           |
| convolution   | $z=x*y$                           | $Z(e^{j\theta})=X(e^{j\theta})Y(e^{j\theta})$                            |

# Periodic Summation

The ideal sampler maps continuous-time signals $x:\mathbb{R}\to \mathbb{R}$ to discrete signals $\bar{x}:\mathbb{Z}\to \mathbb{R}$ as
$$\bar{x}[i]=x(ih),\, \qquad  \forall i$$
for a given sampling period $h>0$ (we assume periodic sampling hereafter). We may also think in terms of the sampling frequency $\omega_{s}=2\pi /h$.

**A key question**: What is lost by transforming the signal domain from $\mathbb{R}$ to $\mathbb{Z}$?

![[Pasted image 20240910195542.png|bookhue|400]]
>Sampling $y$ with a general sampling period h.

![[Pasted image 20240910195525.png|bookhue|400]]
>Sampling $x$ with a general sampling period $h$. We got that exact same sampled function even though the original continuous-time function isn't the same.

![](https://www.youtube.com/watch?v=A-19SxqZ8Qs)
>SmarterEveryDay loosing his kids in a science museum

![](https://www.youtube.com/watch?v=pWjdWCePgvA)
>Washing machine dude explaining signals


>[!def] Definition: 
>Consider a function $x:\mathbb{R}\to \mathbb{F}$. Its **periodic summation** with period $T$ is:
>$$x_{T}(t)=\sum_{i\in \mathbb{Z}}^{} x(t+iT) $$

>[!notes] Note:
>The function $x_{T}:\mathbb{R}\to \mathbb{F}$ is $T$-periodic.

>[!example] Example: 
>If $x=\mathrm{tent}$, then:
>![[{E225BD95-1285-4C0D-9645-FEA29F63986A}.png|bookhue]]

Let $x$ be a continuous-time signal with the frequency response $X$, say:
![[{528FFE1C-9E4D-47F3-9176-3B1D9C59860A}.png|bookhue|400]]
>Frequency response $X(j\omega)$.

And consider its periodic summation with the period $T=2\pi /h$:
$$X_{2\pi /h}(j\omega)=\sum_{i\in \mathbb{Z}}^{}X\left( j\left( \omega+\dfrac{2\pi}{h}i \right) \right) $$
![[{36A61FD2-1CD1-450F-9984-9AF02C8FCD7F}.png|bookhue|400]]
>Periodic summation $X_{2\pi /h}(j\omega)$.

Because this function is periodic, it can be expanded into a [[LSY1_008 Fourier Transform#Fourier Series|Fourier series]] with fundamental frequency ${\omega}_{0}=\dfrac{2\pi}{T}=h$. After some algebra, we conclude that the Fourier coefficients are:
$$X_{2\pi /h}[k]=hx(-kh)$$
Meaning that the periodic summation can also be described as the sum:
$$X_{2\pi /h}(j\omega)=h\sum_{i\in Z}^{} x(ih)e^{-j(h\omega)i} $$

At the same time, the [[#Discrete-Time Fourier Transform|DTFT]] of $\bar{x}$ (where $\bar{x}[i]=x(ih)$) satisfies
$$\begin{aligned}
\bar{X}(e^{j\theta}) & =\sum_{i\in \mathbb{Z}}^{} \bar{x}[i]e^{-j\theta i}  \\[1ex]
 & =\sum_{i\in \mathbb{Z}}^{}x(ih)e^{-j\theta i} 
\end{aligned}$$
Hence, the DTFT of the sampled signal $\bar{x}$ satisfies
$$\bar{X}(e^{j\theta})=\dfrac{1}{h}X_{2\pi /h}\left( j  \dfrac{\theta}{h} \right)=\dfrac{1}{h}\sum_{i\in \mathbb{Z}}^{}X\left( j \dfrac{\theta+2\pi i}{h} \right) $$
Which is the periodic summation, whose period equals the sampling frequency $\omega_{s}=2\pi /h$, of the spectrum of the continuous-time $x$, scaled by the factor $1/h$ both in amplitude and in frequency.

![[{32BE35E0-EA82-4C1B-BEF1-A39556B7DC7E}.png|bookhue]]
>Method of finding $\bar{X}(e^{j\omega h})$.

Meaning that spectrum of a sampled signal will always be periodic. Because it is periodic, we usually focus on the range $\theta \in[-\pi,\pi]$, where $\theta=\omega h$:

![[{5911FAD0-FCFD-4234-BD97-DF45017D97C7}.png|bookhue|300]]
>Change of variables $\theta=\omega h$ for convenience.

>[!notes] Note: 
 >This periodic spectrum is not a action we are doing to better understand they system, it is a thing that happens, a phenomenon called **aliasing**, which is a result of the fact that the sampling rate we are using is too slow to capture all the data we need.

We define the **Nyquist frequency** $\omega_{n}=\dfrac{\pi}{h}=\dfrac{\omega_{s}}{2}$, where we can think of it as the frequency at which the spectrum of the original signal "folds" upon:

![[{0F874A3D-4E41-4166-BCFE-6383A1834CF0}.png|bookhue]]
>Demonstration of frequency folding.

# Exercises

## Question 1
Let $x=\mathrm{rect}_{2N}$, i.e:
$$x[t]=\begin{cases}
1 & \lvert t \rvert\leq  N \\
0 & \text{otherwise}
\end{cases}$$


![[Screenshot_20240822_112925_Samsung Notes.jpg|book|400]]
>Discrete-time signal $x[i]$, for $N=10$.

**Solution**:
We can write $x$ as a sum of shifted step signals $\mathbb{1}[t]$:
$$x=\mathbb{1}[t+N]-\mathbb{1}[t-N-1]$$

We know that:
$$\mathcal{F}\{ \mathbb{1}[t] \}=\dfrac{1}{1-e^{-j\theta}}+\pi\delta(\theta)$$
also the time shift property of the DTFT:
$$y=x[\tau+t]\implies Y(e^{j\theta})=e^{j\theta \tau}X(e^{j\theta})$$

Using these we have:
$$X(e^{j\theta})=e^{j\theta N} \dfrac{1}{1-e^{j\theta}}+e^{j\theta N}\pi\delta(\theta)-e^{-j\theta(N+1)} \dfrac{1}{1-e^{-j\theta}}-e^{-j\theta(N+1)}\pi\delta(\theta)$$

Using the [[LSY1_002 Signals and Convolutions#The Sifting Property|sifting property]] of the delta function, we know that $x(t)\delta(t)=x(0)\delta(t)$. Therefore:
$$\begin{aligned}
X(e^{j\theta}) & =e^{j\theta N} \dfrac{1}{1-e^{-j\theta}}+\pi\delta(\theta)-e^{-j\theta(N+1)} \dfrac{1}{1-e^{-j\theta}}-\pi\delta(\theta) \\[1ex]
 & =e^{j\theta N} \dfrac{1}{1-e^{-j\theta}} -e^{-j\theta(N+1)} \dfrac{1}{1-e^{-j\theta}} \\[1ex]
 & =\dfrac{e^{j\theta N}-e^{-j\theta(N+1)}}{1-e^{-j\theta}}
\end{aligned}$$
Multiplying the numerator and denominator by $e^{j\theta/2}$:
$$\begin{aligned}
X(e^{j\theta}) & =\dfrac{e^{j\theta(N+1/2)}-e^{-j\theta(N+1/2)}}{e^{j\theta /2}-e^{-j\theta /2}} \\[1ex]
 & =\dfrac{j\sin[\theta(N+1/2)]+j[\sin\theta(N+1/2)]}{j\sin(\theta /2)+j\sin(\theta /2)} \\[1ex]
 & =\dfrac{\sin[\theta(N+1/2)]}{\sin(\theta /2)}
\end{aligned}$$
To conclude:
$$\boxed {
X(e^{j\theta})=\dfrac{\sin[\theta(N+1/2)]}{\sin(\theta /2)}
 }$$


![[Screenshot_20240822_115831_Samsung Notes.jpg|book|400]]
>The plot of $X(e^{j\theta})$ for $N=10$.

