---
aliases:
---

# Introduction

>[!TODO] להשלים


From [[LSY1_000 034032 Linear Systems E#Bibliography|(Lathi & Green, 2018)]]:
In [[LSY1_008 Fourier Transform#Introduction|Fourier transform]] and [[LSY1_007 Laplace Transform#Introduction|Laplace transform]] we studies the ways of representing a continuous-time signal as a sum of sinusoids or exponentials. In this chapter we shall discuss similar development for discrete-time signals. Our approach is parallel to that used for a continous-time signals. We first represent a periodic $x[n]$ as a Fourier series formed by a discrete-time exponential (or sinusoid) and its harmonics.

The signal $\alpha[t]=ae^{j\theta t}:\mathbb{Z}\to \mathbb{C}$, for $\alpha \in \mathbb{C}$ and $\theta \in \mathbb{R}$ is called a discrete harmonic signal with frequency $\theta$, amplitude $\lvert a \rvert$, and initial phase $\arg(a)$:

![[LSY1_011/Pasted image 20240910194422.png|bookhue|500]]
>A general discrete harmonic signal.

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

![[LSY1_011/Pasted image 20240910195542.png|bookhue|400]]
>Sampling $y$ with a general sampling period h.

![[LSY1_011/Pasted image 20240910195525.png|bookhue|400]]
>Sampling $x$ with a general sampling period $h$. We got that exact same sampled function even though the original continuous-time function isn't the same.




>[!TODO] TODO: להשלים
# Exercises

## Question 1
Let $x=\mathrm{rect}_{2N}$, i.e:
$$x[t]=\begin{cases}
1 & \lvert t \rvert\leq  N \\
0 & \text{otherwise}
\end{cases}$$


![[LSY1_011/Screenshot_20240822_112925_Samsung Notes.jpg|book|400]]
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


![[LSY1_011/Screenshot_20240822_115831_Samsung Notes.jpg|book|400]]
>The plot of $X(e^{j\theta})$ for $N=10$.

