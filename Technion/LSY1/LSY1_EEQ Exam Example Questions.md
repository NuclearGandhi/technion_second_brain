---
aliases:
---
## Question 1
Calculate
$$h(t)=\int_{\mathbb{R}}^{} x(t-s)y(s) \, \mathrm{d}s $$
where $x(t)=\mathrm{sinc}(t)$ and $y=2\delta(t)$.

**Solution**:
The operation described here is the [[LSY1_002 Signals and Convolutions#Convolution|convolution]] of $x$ and $y$:
$$x*y=\int_{\mathbb{R}}x(t-s)y(s) \, \mathrm{d}s $$
By the [[LSY1_002 Signals and Convolutions#The Sifting Property|sifting property]], we know that:
$$(x*\delta)(t)=x(t)$$
Therefore, in our case:
$$\begin{gathered}
h(t) =(\mathrm{sinc} *2\delta) (t)\\[1ex]
\boxed {
 h(t) =2\,\mathrm{sinc} (t)
 }
\end{gathered}$$

## Question 2
What's the $L_{\infty}$-norm of $x=\exp _3(\mathbb{P}_{-1}\mathbb{1})$?

**Solution**:
First, let's [[LSY1_002 Signals and Convolutions#Standard signals|rewrite]] the function in human readable math:
$$\begin{aligned}
x(t) & =e^{3t}\mathbb{1}(-t) \\[1ex]
 & =\begin{cases}
e^{3t} & t\leq  0 \\[1ex]
 0 & t>0
\end{cases}
\end{aligned}$$
The [[LSY1_002 Signals and Convolutions#Norms|norm]] of this signal is:
$$\lVert x \rVert _{\infty }=\mathrm{supp}_{t\in \mathbb{R}}\lvert x(t) \rvert$$
because $e^{3t}$ is a monotonically increasing function, it is largest at $t=0$. Therefore:
$$\boxed {
\lVert x \rVert _{\infty }=1
 }$$

## Question 3
What's the $L_{\infty}$-norm of $x=\mathbb{P}_{-1}(\exp_{3}\cdot \mathbb{1})$?

**Solution**:
Rewriting:
$$\begin{aligned}
x(t) & =e^{-3t}\mathbb{1}(-t) \\[1ex]
 & =\begin{cases}
e^{-3t} & t\leq  0 \\[1ex]
 0 & t>0
\end{cases}
\end{aligned}$$
Therefore, the $L_{\infty}$-norm of $x$ is unbounded:
$$\boxed {
\lVert x \rVert _{\infty }=\infty 
 }$$

## Question 4
Is the continuous signal, that its spectrum is shown in the following figure, real? (Assume that $X(j\omega)$ is real).
![[LSY1_EEQ/Pasted image 20240909182345.png|book|400]]
>The relevant figure for questions 4, 5.

**Solution**:
Since the spectrum of the signal is symmetric and real, we can say that the signal itself is symmetric and real.


## Question 5
Is the signal from the previous question periodic?

**Solution**:
The frequencies of a periodic signal are represented as impulses in its spectrum. So yes, the signal is periodic.


## Question 6
Is the continuous signal, that its spectrum is shown in the following figure, real? (Assume that $X(j\omega)$ is real).

![[LSY1_EEQ/Pasted image 20240909182952.png|book|500]]
>The relevant figure for questions 6, 7.

**Solution**:
The spectrum may be real, but it isn't symmetric, meaning the the original signal isn't real.

## Question 7
Is the signal from the previous question periodic?

The frequencies of a periodic signal are represented as impulses in its spectrum. So no, the signal isn't periodic.

## Question 8
Four continuous signals $x_{i}$ and their (*not corresponding*) spectrums $y_{j}$ are shown in the following figure:
![[LSY1_EEQ/Pasted image 20240909220151.png|book]]
>Signals in time and frequency domain

Match $x_{i}$ to $y_{j}$.

**Solution**:
The signal ${x}_{1}$ is the only one that is offset from the center, meaning that one of its frequencies is $\omega=0$. The only spectrum that matches that is $Y_{2}$:
$${x}_{1}\to {Y}_{2}$$
The signal ${x}_{2}$ is the only signal that has two distinctly different frequencies, and the only spectrum that matches that is $Y_{4}$, as it has two frequencies - $\omega=2\pi,\,3\pi$ (counted as two because of symmetry):
$${x}_{2}\to {Y}_{4}$$
We are left with ${x}_{4}$ and ${x}_{3}$, with the only difference between them being that ${x}_{4}$ has a higher frequency than ${x}_{3}$. Therefore:
$$\begin{gathered}
{x}_{4}\to {Y}_{3} \\[1ex]
{x}_{3}\to {Y}_{1}
\end{gathered}$$


## Question 9
The spectrum of an analog signal $x$ is shown in the following figure:
![[LSY1_EEQ/Pasted image 20240909221359.png|book|500]]
>Spectrum of an analog signal.

Draw the spectrum of the sampled signal $\bar{x}$ such that $\bar{x}[i]=x(ih)$ for sampling period $h=\dfrac{\pi}{4}$.

**Solution**:
Because the sampling period is $h=\dfrac{\pi}{4}$, the Nyquist frequency is:
$$\omega_{n}=\dfrac{\pi}{h}=4$$
which means we need to fold around $\omega_{n}=4$:
![[LSY1_EEQ/LSY1_EEQ Exam Example Questions 2024-09-09 22.26.02.excalidraw.svg|bookhue]]
>Spectrum of the corresponding sampled signal.

## Question 10
The spectrum of an analog signal $x$ and its sampled signal $\bar{x}[i]=x(ih)$ are shown in the following figure:

![[LSY1_EEQ/Pasted image 20240910104132.png|book]]
>Spectrum of an analog signal and its sampled form.

**Solution**:
From the previous question, we know that the spectrum of the sampled signal is a result of the analog signal folding around $\omega=2$. Therefore, this is its Nyquist frequency, which is given by:
$$\begin{gathered}
\omega_{n}=\dfrac{\pi}{h} \\[1ex]
\boxed {
h=\dfrac{\pi}{2}
 }
\end{gathered}$$

## Question 11
A discrete-time signal $\bar{x}$, with sample time $h$, has been converted to an analog signal by zero-order hold:
![[LSY1_EEQ/Pasted image 20240910104826.png|book|300]]
>Analog signal $x$.

What's $\bar{x}$ in terms of elementary signals (pulse, step...)?

**Solution**:
From the definition of [[LSY1_011 Fourier Analysis of Discrete Time Signals#Digital to Analog|zero-order hold]] we see that the discrete time signal is of the form:
![[LSY1_EEQ/LSY1_EEQ Exam Example Questions 2024-09-10 10.50.17.excalidraw.svg]]
>The discrete-time signal $\bar{x}$.

From the figure:
$$\bar{x}[t]=3\mathbb{S}_{-2h}\mathrm{rect}_{2h}$$


## Question 12
A discrete-time signal $\bar{x}$, with sample time $h$, has been converted to an analog signal by $\mathrm{sinc}$-interpolator:

![[LSY1_EEQ/Pasted image 20240910110228.png|book|300]]
>Analog signal $x$.

What's $\bar{x}$ in terms of elementary signals (pulse, step...)?

**Solution**:
A pulse ([[LSY1_002 Signals and Convolutions#The Delta Function|delta function]]) going though a $\mathrm{sinc}$-interpolator yields a simple $\mathrm{sinc}$ in the continuous-time domain (times $h$). Since our $\mathrm{sinc}$ is shifted, the discrete-time signal is:
$$\bar{x}[t]=2\delta[t-2]$$


## Question 13
Can the following graph be the spectrum of a discrete-time signal?
![[LSY1_EEQ/Pasted image 20240910111400.png|book|300]]
>A  general curve.

**Solution**:
No, its bounds aren't $[-\pi,\pi]$ (or at least periodic over $2\pi$).

## Question 14
Decompose the rational function
$$H(s)=\dfrac{3s^{2}+10s+4}{s(s+1)(s+4)}$$
to partial fractions.

**Solution**:
Rewriting the function:
$$H(s)=\dfrac{A}{s}+\dfrac{B}{s+1}+\dfrac{C}{s+4}$$
By [[LSY1_007 Laplace Transform#Partial Fraction Expansion|partial fraction expansion]]:
$$\begin{aligned}
 & A=\lim_{ s \to 0} \dfrac{3s^{2}+10s+4}{(s+1)(s+4)}=\dfrac{4}{4}=1 \\[1ex]
 & B=\lim_{ s \to -1} \dfrac{3s^{2}+10s+4}{s(s+4)}=\dfrac{-3}{-3}=1 \\[1ex]
 & C=\lim_{ s \to -4} \dfrac{3s^{2}+10s+4}{s(s+1)}=\dfrac{12}{12}=1
\end{aligned}$$
Which is why:
$$\boxed{H(s)=\dfrac{1}{s}+\dfrac{1}{s+1}+\dfrac{1}{s+4} }$$


## Question 15
The function
$$K(s)=\dfrac{2(2s+3)(s-2)}{(s-1)(s+1)(s+4)}$$
Is the Laplace transform of $k:\mathbb{R}\to \mathbb{R}$ with $\mathrm{RoC}=\mathbb{C}_{1}$. Does its Fourier transform exist?

**Solution**:
We can think of [[LSY1_008 Fourier Transform#Fourier Transform|Fourier transform]] as a special case of [[LSY1_007 Laplace Transform#The Laplace Transform|the Laplace transform]] - specifically on the imaginary axis. Since the Laplace transform doesn't exist for $s=j\omega$ (because its $\mathrm{RoC}=\mathbb{C}_{1}$), we conclude that the Fourier transform must not exist.

## Question 16
Is the system $G:u\to y$ such that $y(t)=\sin(2t)u(t)$ static?

**Solution**:
Because $y(t)$ depends on the value of the input only at time $t$, it is static.

## Question 17
Is the system $G:u\to y$ such that $y(t)=\sin(2t)u(t)$ linear?

**Solution**:
For $u={\alpha}_{1}{u}_{1}+{\alpha}_{2}{u}_{2}$:
$$\begin{aligned}
y(t) & =\sin(2t)({\alpha}_{1} {u}_{1}(t)+{\alpha}_{2}{u}_{2}(t)) \\[1ex]
 &={\alpha}_{1}\sin(2t){u}_{1}(t)+{\alpha}_{2}\sin(2t){u}_{2}(t) \\[1ex]
 & ={\alpha}_{1}{y}_{1}(t)+{\alpha}_{2}{y}_{2}(t)
\end{aligned}$$
Therefore, the system is [[LSY1_003 Classification of Systems#Linearity|linear]].

## Question 18
Is the system $G:u\to y$ such that $y(t)=\sin(2t)u(t)$ time-invariant?

**Solution**:
For $\bar{u}(t)=u(t+T)$:
$$\begin{aligned}
\bar{y}(t) & =\sin(2t)\bar{u}(t) \\[1ex]
 & =\sin(2t)u(t+T) \\[1ex]
 & \neq \sin(2t)u(t)
\end{aligned}$$
Therefore, the system is [[LSY1_003 Classification of Systems#Time Invariance|time-variant]].

## Question 19
Is the system $G:u\to y$ such that $y(t)=\sin(2u(t))$ static?

**Solution**:
Because $y(t)$ depends on the value of the input only at time $t$, it is static.

## Question 20
Is the system $G:u\to y$ such that $y(t)=\sin(2u(t))$ linear?

**Solution**:
For $u={\alpha}_{1}{u}_{1}+{\alpha}_{2}{u}_{2}$:
$$\begin{aligned}
y(t) & =\sin(2{\alpha}_{1} {u}_{1}(t)+2{\alpha}_{2}{u}_{2}(t)) \\[1ex]
  & \neq \sin(2{\alpha}_{1}{u}_{1}(t))+\sin(2{\alpha}_{2}{u}_{2}(t))
\end{aligned}$$
Therefore, the system is not [[LSY1_003 Classification of Systems#Linearity|linear]].

## Question 21
Is the system $G:u\to y$ such that $y(t)=\sin(2u(t))$ time-invariant?

**Solution**:
For $\bar{u}(t)=u(t+T)$:
$$\begin{aligned}
\bar{y}(t) & =\sin(2\bar{u}(t)) \\[1ex]
 & =\sin(2u(t+T)) \\[1ex]
 & =y(t+T)
\end{aligned}$$
Therefore, the system is [[LSY1_003 Classification of Systems#Time Invariance|time-invariant]].

## Question 22
Is a linear system $G:u\to y$ such that $\dot{y}(t)+y(t)=\dot{u}(t)+u(t)$ static?

**Solution**:
In general, no, because of initial conditions ${y}_{0}={u}_{0}$. If ${u}_{0}$ depends on $t$, we may get that $y$ depends on $t$, which means it is not static.

## Question 23
Is a system that its impulse response $g$ satisfies $g(t)=\dfrac{1}{t}\mathbb{1}(t-1)$ causal?

**Solution**:
A [[LSY1_004 Linear State-Space Equation#Causality via Impulse Responses|LTI system is causal]] iff $\mathrm{supp}(g)\geq 0$, which is satisfied in our case. Therefore, the system is causal.


## Question 24
Is a system that its impulse response $g$ satisfies $g(t)=\dfrac{1}{t}\mathbb{1}(t-2)$ BIBO stable?

**Solution**:
A [[LSY1_004 Linear State-Space Equation#Stability via Impulse Responses|LTI system is BIBO stable]] iff $g\in {L}_{1}$. In our case:
$$\begin{aligned}
{L}_{1} & =\int_{-\infty }^{\infty } g(t) \, \mathrm{d}t  \\[1ex]
 & =\int_{-\infty }^{\infty } \dfrac{1}{t}\mathbb{1}(t-2) \, \mathrm{d}t \\[1ex]
  & =\int_{2}^{\infty } \dfrac{1}{t} \, \mathrm{d}t
\end{aligned}$$
Which by [[../CAL1/CAL1_009 אינטגרל מוכלל#אינטגרלים מיוחדים|special integrals]], we know isn't bounded. Therefore, the system isn't BIBO stable.

## Question 25
Is a system that its impulse response $g$ satisfies $g(t)=\dfrac{1}{1+t^{2}}\mathbb{1}(t+1)$ causal?

**Solution**:
A [[LSY1_004 Linear State-Space Equation#Causality via Impulse Responses|LTI system is causal]] iff $\mathrm{supp}(g) \subset \mathbb{R}_{+}$. In our case, $\dfrac{1}{1+t^{2}}$ is shifted by $-1$, which means the support isn't completely in $\mathbb{R}_{+}$, therefore the system isn't causal.

## Question 26
Is a system that its impulse response $g$ satisfies $g(t)=\dfrac{1}{1+t^{2}}\mathbb{1}(t-3)$ BIBO stable?

**Solution**:
A [[LSY1_004 Linear State-Space Equation#Stability via Impulse Responses|LTI system is BIBO stable]] iff $g\in {L}_{1}$. In our case:
$$\begin{aligned}
{L}_{1} & =\int_{-\infty }^{\infty } g(t) \, \mathrm{d}t  \\[1ex]
 & =\int_{-\infty }^{\infty } \dfrac{1}{1+t^{2}}\mathbb{1}(t-3) \, \mathrm{d}t \\[1ex]
  & =\int_{3}^{\infty } \dfrac{1}{1+t^{2}} \, \mathrm{d}t
\end{aligned}$$
Which by [[../CAL1/CAL1_009 אינטגרל מוכלל#אינטגרלים מיוחדים|special integrals]], we know is bounded. Therefore, the system is BIBO stable.

## Question 27
What's the transfer function of $G:v\to w$ that is described by:
$$\begin{gathered}
\ddot{w}(t)=-\dot{w}(t)-3w(t)+\dot{v}(t)-2v(t)
\end{gathered}$$

**Solution**:
Rearranging, we get:
$$\ddot{w}(t)+\dot{w}(t)-3w(t)=\dot{v}(t)-2v(t)$$
Applying the [[LSY1_007 Laplace Transform#The Laplace Transform|Laplace transform]] to both sides of the equation, we get:
$$\begin{gathered}
s^{2}W(s)+sW(s)-3W(s)=sV(s)-2V(s) \\[1ex]
\boxed {
G(s)=\dfrac{V(s)}{W(s)}=\dfrac{s-2}{s^{2}+s-3}
 }
\end{gathered}$$
## Question 28
What's the transfer function of $G:v\to w$ that is described by:
$$\begin{gathered}
w[t+2]=-w[t+1]-3w[t]+v[t+1]-2v[t]
\end{gathered}$$

**Solution**:
Rearranging, we get:
$$w[t+2]+w[t+1]+3w[t]=v[t+1]-2v[t]$$
Applying the [[LSY1_010 Discrete-Time System Analysis#The $z$-Transform|z-transform]] to both sides of the equation, we get:
$$\begin{gathered}
z^{2}W[z]+zW[z]+3W[z]=zV[z]-2V[z] \\[1ex]
\boxed {
G[z]=\dfrac{V[z]}{W[z]}=\dfrac{z-2}{z^{2}+z+3}
 }
\end{gathered}$$

## Question 29
What's the impulse response of $G:v\to w$ that is described by the equation:
$$w(t)=v(t)+2v(t-1)-8v(t-3)$$
**Solution**:
Substituting $u(t)=\delta(t)$:
$$\boxed {
g(t)=\delta(t)+2\delta(t-1)-8\delta(t-3)
 }$$
## Question 30
What's the transfer function of $G:v\to w$ that is described by:
$$\begin{gathered}
w(t)=v(t)+2v(t-1)-8v(t-3)
\end{gathered}$$

**Solution**:
Applying the [[LSY1_007 Laplace Transform#The Laplace Transform|Laplace transform]] to both sides of the equation, we get:
$$\begin{gathered}
W(s)=V(s)+2e^{-s}V(s)-8e^{-3s}V(s) \\[1ex]
\boxed {
G(s)=\dfrac{V(s)}{G(s)}=1+2e^{-s}-8e^{-3s}
 }
\end{gathered}$$


## Question 31
Is the system with transfer function
$$F(s)=\dfrac{s^{3}+2s^{2}-s+1}{s^{2}+5s+1}$$
stable and causal?

**Solution**:
The system isn't [[LSY1_007 Laplace Transform#From Laplace to Transfer Function|proper]], therefore it isn't [[LSY1_007 Laplace Transform#Causality and Stability|causal and stable]].

## Question 32
Is the system with transfer function
$$F(s)=\dfrac{s^{3}+2s^{2}-s+1}{-s^{3}-s^{2}-s-2}$$
stable and causal?

**Solution**:
To check stability and causality, we can see that all the coefficients of the denominator are non-zero and have the same sign, which means it at least satisfies the [[LSY1_007 Laplace Transform#Necessary Condition for Stability|necessary condition for stability]]. For the [[LSY1_007 Laplace Transform#Necessary and Sufficient Condition for Stability|sufficient condition]], we know that for a third-order polynomial we also need to check:
$$\begin{gathered}
{a}_{1}{a}_{2}>{a}_{0}{a}_{3} \\[1ex]
(-1)\cdot(-1)>(-2)\cdot (-1) \\[1ex]
1>2
\end{gathered}$$
Since this is not true, we conclude that the system isn't causal and stable.

## Question 33
Is the system with transfer function
$$F(s)=\dfrac{s^{3}+2s^{2}-s+1}{-s^{3}-s^{2}-2s-1}$$
stable and causal?

**Solution**:
The only difference from the previous question is that we need to recheck the
the [[LSY1_007 Laplace Transform#Necessary and Sufficient Condition for Stability|sufficient condition]]. We know that for a third-order polynomial need to make sure that:
$$\begin{gathered}
{a}_{1}{a}_{2}>{a}_{0}{a}_{3} \\[1ex]
(-2)\cdot(-1)>(-1)\cdot(-1) \\[1ex]
2>1
\end{gathered}$$
Since this is true, we conclude that the system is causal and stable.

## Question 34
Is the system with transfer function
$$H(z)=\dfrac{z^{2}+z+1}{2z+1}$$
causal?

**Solution**:
The system isn't [[LSY1_007 Laplace Transform#From Laplace to Transfer Function|proper]], therefore it [[LSY1_010 Discrete-Time System Analysis#Causality and Stability|isn't causal]].


## Question 35
Is the system with transfer function
$$H(z)=\dfrac{z^{2}+z+1}{2z+1}$$
stable?

The single pole of this system is $z=-\dfrac{1}{2}$. Since it is inside the open unity circle, it is [[LSY1_007 Laplace Transform#Categorizing Polynomials|Schur]], which means the system [[LSY1_010 Discrete-Time System Analysis#Causality and Stability|is stable]].


## Question 36
Is the system with transfer function
$$H(z)=\dfrac{z^{2}+z+1}{6z^{2}-5z+1}$$
causal?

**Solution**:
The system is [[LSY1_007 Laplace Transform#From Laplace to Transfer Function|proper]], therefore it is [[LSY1_007 Laplace Transform#Causality and Stability|causal]].

## Question 37
Is the system with transfer function
$$H(z)=\dfrac{z^{2}+z+1}{6z^{2}-5z+1}$$
stable?

**Solution**:
The poles of this system are:
$$\begin{aligned}
z & =\dfrac{5\pm \sqrt{ 25-24 }}{12}= \\[1ex]
 & =\dfrac{5\pm 1}{12}
\end{aligned}$$

Both of these poles are inside the open unit circle, which means the denominator is Schur, and the system is stable.

## Question 38
Rearranging the function:
$$\boxed {
V(s)=\dfrac{1/3}{s/3+1}
 }$$

By [[LSY1_007 Laplace Transform#First Order System Transfer Function|first-order system transfer function]]:
$$\boxed {
k_{\text{st}}=\tau=\dfrac{1}{3}
 }$$

## Question 39
Rearranging the function:
$$W(s)=\dfrac{1/4}{s^{2}+s+1/4}$$
By [[LSY1_007 Laplace Transform#Second Order System Transfer Function|second-order system transfer function]]:
$$\begin{aligned}
\omega_{n}=1/2 &  & \zeta=  1\qquad  k_{\text{st}}=1
\end{aligned}$$

## Question 40
What's the overshoot and undershoot response for the following step response, in $\%$?
![[LSY1_EEQ/Pasted image 20240910142336.png|book|300]]
>Step response.

**Solution**:
By [[LSY1_007 Laplace Transform#Characteristics of Transients|definition]]:
$$\begin{aligned}
 & \mathrm{OS}=\dfrac{3.1-2}{2}=55\% \\[1ex]
 & \mathrm{US}=-\dfrac{-1.2}{2}=60\%
\end{aligned}$$

## Question 41
What's the overshoot and undershoot response for the following step response, in $\%$?

**Solution**:
![[LSY1_EEQ/Pasted image 20240910142807.png|book|300]]
>Step response.

By [[LSY1_007 Laplace Transform#Characteristics of Transients|definition]]:
$$\begin{aligned}
 & \mathrm{OS}=0\% \\[1ex]
 & \mathrm{US}=-\dfrac{-0.75}{3}=25\%
\end{aligned}$$


## Question 42
Which of the two transfer functions ${G}_{1}(s)=\dfrac{10}{3s+1}$ and ${G}_{2}(s)=\dfrac{10}{3s+2}$ have a step response with a shorter rise time $t_{r}$?

**Solution**:
Rearranging ${G}_{2}(s)$:
$${G}_{2}(s)=\dfrac{5}{1.5s+1}$$
The [[LSY1_007 Laplace Transform#Steady-State and Transients|transient response]] is mainly shaped by $\tau$. Because ${G}_{1}$ has a larger $\tau$ ($3={\tau}_{1}>{\tau}_{2}=1.5$), We conclude that ${G}_{1}$ has a longer rise time.

## Question 43
Which of the following systems' frequency response have a larger overshoot:
$${P}_{1}(s)=\dfrac{10}{s^{2}+s+1}\qquad  {P}_{2}(s)=\dfrac{s+1}{s^{2}+s+1}$$
**Solution**:
From the [[LSY1_007 Laplace Transform#Second Order System Transfer Function|standard forms]] we know that:
$$\begin{aligned}
 & {\alpha}_{1}=0 &  & {\alpha}_{2}=1 \\[1ex]
 & \omega_{n,1}=1 &  & \omega_{n,2}=1 \\[1ex]
 & \zeta_{1}=\dfrac{1}{2} &  & \zeta_{2}=\dfrac{1}{2}
\end{aligned}$$
Because the only difference in the transient responses is $\alpha$, and we know that larger the $\alpha$ the larger the overshoot, we conclude the ${P}_{2}$ has the larger overshoot.

## Question 44
Draw the asymptotic magnitude curve of the frequency response of
$$P(s)=\dfrac{10}{(10s+1)(s+1)}$$

**Solution**:
By [[LSY1_009 Frequency Domain Analysis#Bode Diagram|Bode diagrams]]:
![[LSY1_EEQ/LSY1_EEQ Exam Example Questions 2024-09-10 14.54.40.excalidraw.svg|bookhue|500]]
>The magnitude of the frequency response

## Question 45
Given a linear system with the transform function $G(s)=\dfrac{\alpha s+1}{\beta s+1}$ and a Bode diagram:
![[LSY1_EEQ/Pasted image 20240910151552.png|book|500]]
>Bode diagram

Find $\alpha$ and $\beta$.

**Solution**:
We [[LSY1_009 Frequency Domain Analysis#General Guidelines for Asymptotic Bode|know that]] a zero in $\mathbb{C}_{0}$ adds $-90^{\circ}$ to the phase, and a pole in $\mathbb{C} \setminus \mathbb{C}_{0}$ adds $-90^{\circ}$ to the phase. From the constant magnitude we all conclude that corner frequencies of the nominator and the denominator are equal in magnitude. Therefore:
$$\alpha=-\beta=-1$$

## Question 46
Given a linear system with the transform function $G(s)=\dfrac{\alpha s+1}{s+1}$ and a Bode diagram:

![[LSY1_EEQ/Pasted image 20240910152634.png|book|500]]
>Bode diagram

Find $\alpha$.

**Solution**:
We know from the denominator about the corner frequency $\omega_{p}=1=10^{0}$, which is also [[LSY1_009 Frequency Domain Analysis#General Guidelines for Asymptotic Bode|supposed to add]] a $\pu{-20dB/dec}$ to the magnitude curve. That slope is mitigated by the corner frequency of the nominator, which we can guess is around $\omega_{p}=10^{-1}=0.1$, meaning $\alpha=\pm 10$.
We also know that a zero in $\mathbb{C} \setminus \mathbb{C}_{0}$ adds $90^{\circ}$ to the phase, which means:
$$\boxed{\alpha=10 }$$

## Question 47
Given a linear system with the transform function $G(s)=\dfrac{\alpha s+1}{s+\beta}$ and a Bode diagram:

![[LSY1_EEQ/Pasted image 20240910152748.png|book|500]]
>Bode diagram

Find $\alpha$ and $\beta$

**Solution**:
We see from the diagram that it begins with a downward slope. The only system that begins with such a slope is $\dfrac{1}{s}$, meaning that $\boxed {\beta=0}$. We are left with:
$$G(s)=\dfrac{1}{s}\cdot (\alpha s+1)$$
Since there is a corner frequency at $0.5$ (the graph passes $45^{\circ}$ at that point), we can conclude that $\alpha=\pm 2$. Because $90^{\circ}$ are added to the phase, [[LSY1_009 Frequency Domain Analysis#General Guidelines for Asymptotic Bode|we know that]] the zero is in $\mathbb{C}\setminus \mathbb{C}_{0}$. Therefore:
$$\boxed {
\alpha=2
 }$$

## Question 48
In the following figure are 3 Bode diagrams and 3 polar diagrams. Match them.
![[LSY1_EEQ/Pasted image 20240911094851.png|book]]
>Bode and polar diagrams.

**Solution**:
We can match the figures by only looking at the phase diagrams of the Bode diagrams. ${B}_{1}$ begins positive, and then goes to the negative portion around $-90^{\circ}$. The only polar diagram that matches that is ${P}_{2}$. ${B}_{2}$ is always negative, hence ${P}_{3}$, which always has a negative $\arg$ to it (if you consider $-270^{\circ}$ negative), is the matching one. We are left with ${B}_{3}$ and ${P}_{1}$, that also match because they both begin at $-90^{\circ}$:
$$\begin{array}{c|c}
\text{Bode} & \text{Pole} \\
\hline {B}_{1} & {P}_{2} \\
{B}_{2} & {P}_{3} \\
{B}_{3} & {P}_{1}
\end{array}$$

## Question 49
In the following figure are represented an input an output signal of a system - $F:u\to y$:
![[LSY1_EEQ/{56120750-6109-412F-8BD6-91C464254C4E}.png|book|500]]
>Signals $u,y$.

Match the correct Bode diagram:
![[LSY1_EEQ/{A2F428D2-3BEC-4623-AA36-61CB2ECCFD46}.png|book]]
>Bode diagrams ${G}_{1},{G}_{2},{G}_{3},{G}_{4}$.

**Solution**:
The static magnitude of the input $u$ is $\omega(0)=1$, while in the output it zeros out - $\omega(0)=0$, meaning the system has filtered that frequency out. The only graphs that filter out $\omega=0$ are ${G}_{1}$ and ${G}_{2}$.

We also see that the high frequencies in the input have been filtered out, yes the the slower frequency, with $T=\pu {1s }$, stays.
The corresponding frequency of that is $\omega=\dfrac{2\pi}{T}=2\pi\approx6.28$, and the only graph that doesn't completely filter it out is ${G}_{2}$.


## Question 50
The following graph is a polar description of a linear, time-invariant, and stable system. Its steady-state response to the input $u(t)=1+\cos({\omega}_{0}t)$ for a general ${\omega}_{0}$ is $y_{\text{ss}}(t)=\alpha+\beta \sin({\omega}_{0}t)$. Find $\alpha$ and $\beta$.

![[LSY1_EEQ/{94DAA750-D93D-4C86-AB39-529ADC88C9B2}.png|book|500]]
>Polar description of a linear system.

**Solution**:
The input can be decomposed to two different signals:
$$\begin{aligned}
{u}_{1}(t)=1 &  & \text{and} &  & {u}_{2}(t)=\cos({\omega}_{0}t)
\end{aligned}$$
The [[LSY1_007 Laplace Transform#Steady-State and Transients|steady-state]] step response is simply (because the system is stable):
$$y_{\text{1,ss}}=k_{\text{st}}$$

For the frequency input ${u}_{2}(t)$ we know that the [[LSY1_009 Frequency Domain Analysis#Frequency Response|steady-state frequency response]] is:
$$y_{2,\text{ss}}=a \lvert G(j\omega) \rvert\sin(\omega t+\phi+\arg G(j\omega))$$
In our case, $a=1,\,\omega={\omega}_{0}$ and $\phi=- 90^{\circ}$ because the input is a $\cos$. Substituting:
$$y_{2,\text{ss}}=\lvert G(j{\omega}_{0}) \rvert \sin({\omega}_{0}t- 90^{\circ} +\arg G(j{\omega}_{0}))$$
Therefore, the total steady-state response is:
$$\begin{aligned}
y_{\text{ss}} & =k_{\text{st}}+\lvert G(j{\omega}_{0}) \rvert \sin({\omega}_{0}t- 90^{\circ} +\arg G(j{\omega}_{0}))
\end{aligned}$$
Also, we know that the steady-state response is of the form:
$$y_{\text{ss}}=\alpha+\beta \sin({\omega}_{0}t)$$
Meaning:
$$\alpha+\beta \sin({\omega}_{0}t)=k_{\text{st}}+\lvert G(j{\omega}_{0}) \rvert \sin({\omega}_{0}t-90^{\circ} +\arg G(j{\omega}_{0}))$$

From here I don't really know how to explain. I want to thank from the deepness of my heart to the course instructors that provide clear and coherent explanations to what the fuck is going on with this course.

## Question 51
Given the Routh table of the polynomial $D(s)=s^{4}+4s^{3}+4s^{2}+8s+6$:
$$\begin{array}{c|ccc}
0 & 1 & 4 & 6 \\
1 & 4 & 8 \\
2 & 2 & 6 \\
3 & -4 & 0 \\
4 & 6
\end{array}$$How many roots of $D(s)$ are in $\mathbb{C}\setminus \bar{\mathbb{C}}_{0}$, and how many are in $\mathbb{C}_{0}$?

**Solution**:
According to [[LSY1_007 Laplace Transform#Necessary and Sufficient Condition for Stability|necessary condition for stability]], since there are two signs changes, there are two roots in $\mathbb{C}_{0}$, and two roots in $\mathbb{C}\setminus \bar{\mathbb{C}}_{0}$.

## Question 52
Given the Jury table of the polynomial $D(z)=z^{3}+3z^{2}+6z+2$:
$$\begin{array}{c|ccc}
0 & 1 & 3 & 6 & 2 \\
 & 2 & 6 & 3 & 1 \\
1 & -3 & -9 & 0 \\
 & 0 & -9 & -3 \\
2 & -3 & -9 \\
 & -9 & -3 \\
3 & 24
\end{array}$$How many roots of $D(s)$ are in $\mathbb{C}\setminus \bar{\mathbb{C}}_{0}$, and how many are in $\mathbb{C}_{0}$?

**Solution**:
Don't know, don't wanna know.

## Question 53
Is $(A-I)^{4}=0$ for
$$A=\begin{pmatrix}
1 & 2 & 3 & 4 \\
0 & 1 & 2 & 3 \\
0 & 0 & 1 & 0 \\
0 & 0 & 5 & 1
\end{pmatrix}$$

**Solution**:
First, we need to find the characteristic equation of $A$:
$$\begin{aligned}
\begin{vmatrix}
\lambda I-A
\end{vmatrix} & =\begin{vmatrix}
\lambda-1 & -2 & -3 & -4 \\
0 & \lambda-1 & 2 & 3 \\
0 & 0 & \lambda-1 & 0 \\
0 & 0 & 5 & \lambda-1
\end{vmatrix} & \\[3ex]
 &  =(\lambda-1)\begin{vmatrix}
\lambda-1 & -2 & -4 \\
0 & \lambda-1 & 3 \\
0 & 0 & \lambda-1
\end{vmatrix} \\[3ex]
 & =(\lambda-1)^{2}\begin{vmatrix}
\lambda-1 & -2 \\
0 & \lambda-1
\end{vmatrix} \\[1ex]
 & =(\lambda-1)^{4}
\end{aligned}$$
By [[../ALG1/ALG1_010 וקטורים עצמיים וערכים עצמיים#משפט קיילי המילטון|Cayley–Hamilton]] we know that $A$ satisfies its own characteristic equation, meaning:
$$(A-I)^{4}=0$$
$$\tag*{$\blacksquare$}$$

## Question 54
Is it possible that:
$$\exp \left[ \begin{pmatrix}
-1 & 1 \\
2 & 2
\end{pmatrix}t \right]=\begin{pmatrix}
e^{-t} & e^{2t}-e^{-t} \\
0 & e^{2t}
\end{pmatrix}$$

**Solution**:
By [[LSY1_004 Linear State-Space Equation#The Matrix Exponential|definition]]:
$$\begin{aligned}
\exp \left[ \begin{pmatrix}
-1 & 1 \\
2 & 2
\end{pmatrix}t \right] & =I+\begin{pmatrix}
-1 & 1 \\
2 & 2
\end{pmatrix}t+\begin{pmatrix}
3 & 1 \\
2 & 6
\end{pmatrix}t^{2}+\dots 
\end{aligned}$$

We can see that the lower left expression will never amount to zero, therefore the statement isn't correct.


## Question 55
Calculate
$$\phi(t)=\exp \left[ \begin{pmatrix}
1 & 0 \\
0 & -1
\end{pmatrix} \right]$$
By [[LSY1_004 Linear State-Space Equation#The Matrix Exponential|definition]]:
$$\begin{aligned}
\exp \left[ \begin{pmatrix}
1 & 0 \\
0 & -1
\end{pmatrix}t \right] & =I+\begin{pmatrix}
1 & 0 \\
0 & -1
\end{pmatrix}t+\begin{pmatrix}
1 & 0 \\
0 & 1
\end{pmatrix}t^{2}+\begin{pmatrix}
1 & 0 \\
0 & -1
\end{pmatrix}t^{3}+\dots  \\[1ex]
 & =\begin{pmatrix}
1+t+t^{2}+t^{3}+\dots  & 0 \\
0 & 1-t+t^{2}-t^{3}+\dots 
\end{pmatrix}  \\[1ex]
 & =\begin{pmatrix}
e^{t} & 0 \\
0 & e^{-t}
\end{pmatrix}
\end{aligned}$$

## Question 56
Are the following two system realizations similar?
$$\begin{cases}
\dot{x}_{2}(t)=\begin{pmatrix}
1 & 1 \\
0 & 2
\end{pmatrix}{x}_{2}(t)+\begin{pmatrix}
0 \\
1
\end{pmatrix}u(t) \\[1ex]
y(t)=\begin{pmatrix}
1 & 0
\end{pmatrix}{x}_{2}(t)
\end{cases}\qquad  \begin{cases}
\dot{x}_{1}(t)=\begin{pmatrix}
1 & 1 \\
0 & 1
\end{pmatrix}{x}_{1}(t)+\begin{pmatrix}
0 \\
1
\end{pmatrix}u(t) \\[1ex]
y(t)=\begin{pmatrix}
1 & 1
\end{pmatrix}{x}_{1}(t)
\end{cases}$$


**Solution**:
The $\mathbf{A}$ matrices in the those realizations don't have the same eigenvalues, therefore they aren't similar, which means the systems aren't similar.

## Question 57
Are the following two system realizations similar?
$$\begin{cases}
\dot{x}_{2}(t)=\begin{pmatrix}
1 & 1 \\
0 & 1
\end{pmatrix}{x}_{2}(t)+\begin{pmatrix}
0 \\
1
\end{pmatrix}u(t) \\[1ex]
y(t)=\begin{pmatrix}
1 & 0
\end{pmatrix}{x}_{2}(t)
\end{cases}\qquad  \begin{cases}
\dot{x}_{1}(t)=\begin{pmatrix}
1 & 0 \\
0 & 1
\end{pmatrix}{x}_{1}(t)+\begin{pmatrix}
0 \\
1
\end{pmatrix}u(t) \\[1ex]
y(t)=\begin{pmatrix}
1 & 1
\end{pmatrix}{x}_{1}(t)
\end{cases}$$

**Solution**:
The $\mathbf{A}$ matrices in the those realizations have the same eigenvalues:
$${\lambda}_{1,2}=1$$
But, the Identity matrix is similar only to itself, therefore $\mathbf{A}_{2}$ isn't similar to $\mathbf{A}_{1}$, which means the system aren't similar.

## Question 58
Prove that $x(t)=e^{\mathbf{A}t}{x}_{0}$ is the solution of $\dot{x}(t)=\mathbf{A}x(t)$ for initial condition $x(0)={x}_{0}$.

**Solution**:
Substituting the solution:
$$\mathbf{A}e^{\mathbf{A}(t)}\overset{ \checkmark  }{ = }\mathbf{A}e^{\mathbf{A}(t)}$$
Making sure the initial condition is satisfied:
$$\begin{gathered}
x(0)=e^{\mathbf{A}\cdot 0}{x}_{0} \\[1ex]
x(0)\overset{ \checkmark  }{ = }{x}_{0}
\end{gathered}$$



## Question 59
What's the observer realization of the transfer function $G(s)=\dfrac{3}{s^{3}+2s+1}$?

**Solution**:
By [[LSY1_004 Linear State-Space Equation#Canonical Realization|canonical realization]]:
$$\begin{array}{ccc|c}
0 & 1  & 0 & 0\\
-2 & 0 & 1 & 0 \\
-1 & 0 & 0 & 3 \\
\hline 1 & 0 & 0 & 0
\end{array}$$

## Question 60
What are the equilibrium points of the system $\dot{x}=\begin{pmatrix}1&1\\0&3\end{pmatrix}x$?

**Solution**:
The [[LSY1_005 Linearization#Local Linearization Around an Equilibrium Point|equilibrium points]] are where $f(x_{\text{eq}})=0$. In our case, $\mathbf{f}(\mathbf{x})=\begin{pmatrix}1&1\\0&3\end{pmatrix}x$, therefore:
$$\left(\begin{array}{cc|c}
1 & 1 & 0 \\
0 & 3 & 0
\end{array}\right)\xrightarrow[]{}\begin{aligned}
 & {x}_{1}=0 \\
 & {x}_{2}=0
\end{aligned}$$
Therefore the equilibrium point is $\boxed {\mathbf{x}_{\text{eq}}=\begin{pmatrix}0\\0\end{pmatrix}}$.

## Question 61
An autonomous response of a second order linear system is shown in the following figure:
![[LSY1_EEQ/{9B7A4E29-F3EE-44FF-9497-D91B3267A8A6}.png|book|250]]
>Autonomous response of the system.

Is the equilibrium point of the system asymptotically stable?

**Solution**:
No, we see from the figure that for that initial condition, the state of the system diverges, which means the system isn't stable.

## Question 62
An autonomous response of a second order linear system is shown in the following figure:

![[LSY1_EEQ/{CF0529B1-75E7-45C3-84C1-EBF584E6B1E4}.png|book|250]]
>Autonomous response of the system.

Is the equilibrium point of the system asymptotically stable?

**Solution**:
For a second-oder system to be asymptotically stable, [[LSY1_006 Lyapunov Stability#Stability for Linear State Space Models|we need both of the eigenvalues]] to be negative. From the figure we see that at least one of the eigenvalues is negative, and thus any point on its eigenvector converges to zero. But, we still don't know anything about the second eigenvalue, which might be positive. Therefore, we can't say whether the system is stable or not.

## Question 63
An autonomous response of a second order linear system is shown in the following figure:

![[LSY1_EEQ/{C5F34E17-B9A4-44B2-960B-7F12C08ABD5F}.png|book|250]]
>Autonomous response of the system.

Is the equilibrium point of the system asymptotically stable?

**Solution**:
Yes, we can see from the figure that there exists a circle around the equilibrium point where the system converges to the equilibrium point, which means the system is asymptotically stable.

## Question 64

An autonomous response of a second order linear system is shown in the following figure:

![[LSY1_EEQ/{E3F3AF10-0E51-41F7-B80A-823CD13508B9}.png|book|250]]
>Autonomous response of the system.

Is the equilibrium point of the system asymptotically stable?

**Solution**:
No, the system clearly diverges from the initial condition outwards.

## Question 65
What's the equilibrium point of $\dot{x}=(x-1)^{2}+x^{2}u^4$?

**Solution**:
We simply need to find where $0=f(x,u)=(x-1)^{2}+x^{2}u^{4}$:
$$\begin{gathered}
0=(x-1)^{2}+x^{2}u^{4} \\[1ex]
u=\pm \sqrt{ \dfrac{x-1}{x} }
\end{gathered}$$
Therefore:
$$\boxed {
u_{\text{eq}}=\pm \sqrt{ \dfrac{x_{\text{eq}}-1}{x_{\text{eq}}}  }
 }$$

## Question 66
What's the equilibrium point of $\dot{x}=\begin{pmatrix}0&0\\0&1\end{pmatrix}x+\begin{pmatrix}1\\1\end{pmatrix}u$?

**Solution**:
$$\begin{gathered}
\mathbf{f}(\mathbf{x},u)=0 \\[1ex]
\begin{pmatrix}
0 & 0 \\
0 & 1
\end{pmatrix}\mathbf{x}+\begin{pmatrix}
1 \\
1
\end{pmatrix}u=0 \\[1ex]
\begin{cases}
0+u=0 \\
{x}_{2}+u=0
\end{cases}
\end{gathered}$$
Therefore:
$$\boxed{\begin{aligned}
 & u_{\text{eq}}=0 \\
 & \mathbf{x}_{\text{eq}}=\begin{pmatrix}
{x}_{1} \\
0
\end{pmatrix}
\end{aligned} }$$

## Question 67
Given a nonlinear system:
$$\begin{cases}
\dot{x}=x^{3}-e^{u} \\[1ex]
y=e^{-x+1}
\end{cases}$$
Linearize it around the equilibrium point $(x_{\text{eq}},u_{\text{eq}})=(1,0)$ and find the transfer function of the linearized system $G_{\delta}:u_{\delta}\to y_{\delta}$.

**Solution**:
Derivatives:
$$\begin{aligned}
 & {A}=\dfrac{ \partial f(x,u) }{ \partial x }\bigg|_{\text{eq}}^{}=3x^{2}\bigg|_{\text{eq}}^{} =3 \\[1ex]
 &  {B} =\dfrac{ \partial f(x,u) }{ \partial u } \bigg|_{\text{eq}}^{} =                                           -e^{u}\bigg|_{\text{eq}}^{} =-1 \\[1ex]
 & {C}=\dfrac{ \partial h(x,u) }{ \partial x } =-e^{-x+1}\bigg|_{\text{eq}}^{} =-1 \\[1ex]
 & {D}=\dfrac{ \partial h(x,u) }{ \partial u } =0
\end{aligned}$$
Therefore, the linearized system is (where $x_{\delta}=x-x_{\text{eq}}$ and $u_{\delta}=u-u_{\text{eq}}$):
$$\boxed {
\begin{aligned}
 & \dot{x}_{\delta}=3x_{\delta}-u_{\delta} \\[1ex]
 & y_{\delta}=- x_{\delta}
\end{aligned}
 }$$
To find the transfer function, we substitute the second equation into the first one:
$$\begin{gathered}
-\dot{y}_{\delta}=-3y_{\delta}-u_{\delta} \\[1ex]
\dot{y}_{\delta}-3y_{\delta}=u_{\delta}
\end{gathered}$$
Therefore the transfer function is:
$$\boxed {
G(s)=\dfrac{1}{s-3}
 }$$

## Question 68
Is the equilibrium point of the autonomous system $\dot{x}=\begin{pmatrix}-1&1\\0&-2\end{pmatrix}x$ Lyapunov stable?

**Solution**:
Both of the eigenvalues of the system (${\lambda}_{1}=-1$ and ${\lambda}_{2}=-2$) are negative, [[LSY1_006 Lyapunov Stability#Stability for Linear State Space Models|meaning that]] the system is Lyapunov stable.


## Question 69
Is the equilibrium point of the autonomous system $\dot{x}=\begin{pmatrix}0&1\\0&-2\end{pmatrix}x$ Lyapunov stable?

**Solution**:
Both of the eigenvalues of the system (${\lambda}_{1}=0$ and ${\lambda}_{2}=-2$) satisfy $\mathrm{Re}(\lambda)\leq 0$ , [[LSY1_006 Lyapunov Stability#Stability for Linear State Space Models|meaning that]] the system is Lyapunov stable.

## Question 70
Given the linearization $\dot{x}_{\delta}=\begin{pmatrix}-1&1\\0&-2\end{pmatrix}x_{\delta}$ of a non-linear system $\dot{x}=f(x)$ around an equilibrium point $x_{\text{eq}}$, is $x_{\text{eq}}$ a Lyapunov stable equilibrium point of $\dot{x}=f(x)$?

**Solution**:
By [[LSY1_006 Lyapunov Stability#Lyapunov’s indirect method|Lyapunov's indirect method]], if both of the eigenvalues of the linearized system are on the open left half plane (which is true in our case), than the non-linear system is asymptotically stable, and thus Lyapunov stable, around the equilibrium point.

## Question 71
Given the linearization $\dot{x}_{\delta}=\begin{pmatrix}0&1\\0&-2\end{pmatrix}x_{\delta}$ of a non-linear system $\dot{x}=f(x)$ around an equilibrium point $x_{\text{eq}}$, is $x_{\text{eq}}$ a Lyapunov stable equilibrium point of $\dot{x}=f(x)$?

**Solution**:
By [[LSY1_006 Lyapunov Stability#Lyapunov’s indirect method|Lyapunov's indirect method]], If the rightmost eigenvalue of the Jacobian matrix is on the imaginary axis, then the stability conclusion is ambiguous. Therefore, we don't know.