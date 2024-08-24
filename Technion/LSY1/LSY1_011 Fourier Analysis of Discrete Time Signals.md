---
aliases:
---

# Introduction

>[!TODO] להשלים


From [[LSY1_000 034032 Linear Systems E#Bibliography|(Lathi & Green, 2018)]]:
In [[LSY1_008 Fourier Transform#Introduction|Fourier transform]] and [[LSY1_007 Laplace Transform#Introduction|Laplace transform]] we studies the ways of reprenting a continuous-time signal as a sum of sinusoids or excponentials. In this chapter we shall discuss similar development for discrete-time signals. Our approach is parallel to that used for a continous-time signals. We first represent a periodic $x[n]$ as a Fourier series formed by a discrete-time exponential (or sinusoid) and its harmonics.

# Discrete-Time Fourier Series (DTFS)
A continuous-time sinusoid $\cos(\omega t)$ is a periodic signal regardless of the values of $\omega$. Such is not the case for a discrete-time sinusoid $\cos(\theta n)$ (which is the same $e^{j\theta n}$). A sinusoid $\cos(\theta n)$ is peiodic only in $\dfrac{\theta}{2\pi}$ is a rational number.

# Discrete-Time Fourier Transform


>[!def] Definition: 
> A **discrete-time Fourier transform** (DTFT) is defined as
> $$X(e^{j\theta})=\sum_{t=-\infty }^{\infty}x[n]e^{-j\theta n} $$
> under some mild conditions, the inverse discrete-time Fourier transform results in:
> $$x[n]=\dfrac{1}{2\pi}\int_{-\pi}^{\pi} X(e^{j\theta})e^{j\theta t} \, \mathrm{d}\theta $$
> 

Symbolically:
$$\begin{aligned}
X(j\omega)=\mathcal{F}\{ x[n] \} &  & \text{and} &  & x[n]=\mathcal{F}^{-1}\{ X[e^{j\theta}] \}
\end{aligned}$$

# Periodic Summation
>[!TODO] להשלים

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

## Question 2
>[!TODO] להשלים