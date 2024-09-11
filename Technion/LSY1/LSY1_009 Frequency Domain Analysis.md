---
aliases:
  - frequency domain analysis
  - bode diagram
  - polar diagram
  - Nyquist diagram
  - guidelines for asymptotic Bode
---
# Frequency Response
>[!theorem] Theorem: 
> Let $G:u\to y$ be a stable [[LSY1_001 Introduction#State-Space Linear Systems|CLTI]] system. Its response to the *sinusoidal* test input $u$ such that
> $$u(t)=a\sin(\omega t+\phi)\mathbb{1}(t)$$
> in steady state, is also sinusoidal. Specifically:
> $$y_{\text{ss}}(t)=a \lvert G(j\omega) \rvert\sin(\omega t+\phi+\mathrm{arg}G(j\omega))$$
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

The Bode diagram is a way of visualizing $\lvert G(j\omega) \rvert$ and $\arg(G(j\omega))$. In order to draw the Bode diagram by hand we actually draw the asymptotic diagram. For example, the following figure shows the Bode diagram of the transfer function:
$$G(s)=\dfrac{1}{s+1}$$

![[LSY1_009/Pasted image 20240906172408.png|book|500]]
>Real and Asymptotic Bode Diagram

The Bode diagram's horizontal axis is the frequency $\omega$ in logarithmic scale. The magnitude part represented in $\pu{dB}$ and the phase part in $\pu{deg}$. $\pu{dB}$ is the unit **decibel** and is defined as:
$$k_{(\pu{dB})}=20\log k\iff k=10^{k_{(\pu{dB})}/20}$$
We also define $\pu{dec}$, **decade**, which is the distance of $10$ units ($10$ scales on the horizontal axis).

## Steps to Create an Asymptotic Diagram
1. Decomposing the system into the product of sub-system.
	$$G(s)={G}_{1}(s)\cdot {G}_{2}(s)\cdots G_{m}(s)$$
	Where each one of these subsystem $i\in 1,2,\dots,m$ are first and second order systems of the form:
	$$G_{i}(s)=\dfrac{1}{s},\, s,\, \dfrac{1}{as+b},\, as+b,\, \dfrac{1}{as^{2}+bs+c},\, as^{2}+bs+c$$
2. Every first order system of the form $\dfrac{1}{as+b}$ we convert to
	$$\dfrac{k_{\pu{st}}}{\tau s+2}$$
	where $\text{st}$ stands for static gain. Every first order system of the form $as+b$ we convert to
	$$k_{\pu{st}}(\tau s+1)$$
	In the same way, we convert second order systems of the form $\dfrac{1}{as^{2}+bs+c}$ to
	$$\dfrac{k_{\pu{st}}{\omega_{n}}^{2}}{s^{2}+2\zeta\omega_{n}s+{\omega_{n}}^{2}}=\dfrac{k_{\pu{st}}}{(s/\omega_{n})^{2}+2\zeta(s/\omega_{n})+1}$$
	and second order systems of the form $as^{2}+bs+c$ to
	$$\dfrac{k_{\pu{st}}(s^{2}+2\zeta\omega_{n}s+{\omega_{n}}^{2})}{{\omega_{n}}^{2}}=(s/\omega_{n})^{2}+2\zeta(s/\omega_{n})+1$$

3. We unite all the static gains by multiplying all $k_{\pu{st}}$ elements, getting:
	$$G(s)=k\cdot \mathcal{G}_{1}(s)\cdot \mathcal{G}_{2}(s)\cdots \mathcal{G}_{m}(s)$$
	Where $\mathcal{G}_{i}(s)$ are the standard transfer functions.
4. Using the figures below, we draw the asymptotic Bode diagram of the system as a combination of the Bodes of the standard systems.
	![[LSY1_009/Pasted image 20240906173733.png|book|500]]
	>Bode diagram for $G(s)=k$. The magnitude is a straight horizontal line with a constant gain of $k_{\pu{(dB)}}=20\log k$. The phase is $0^{\circ}$.
	
	![[LSY1_009/Pasted image 20240906181533.png|book|500]]
	>Bode diagram for $G(s)=\dfrac{1}{s}$. The magnitude is a straight line that crosses the horizontal axis at $\pu{1 rad /sec}$ and has a slope of $\pu{-20dB/dec}$. The phase is constant at $-90^{\circ}$.
	
	![[LSY1_009/Pasted image 20240906222634.png|book|500]]
	>Bode diagram for $G(s)=s$. The magnitude is a straight line that crosses the horizontal axis at $\pu{1 rad/sec}$ and has a slope of $\pu{20dB/dec}$. The phase is constant at $90^{\circ}$.
	
	![[LSY1_009/Pasted image 20240906222832.png|book|500]]
	>Bode diagram for $G(s)=\dfrac{1}{\tau s+1}$. The magnitude is constant at $\pu{0dB}$ until the corner frequency of $\omega_{p}=\dfrac{1}{\tau}$, after which it is a straight line with slope $\pu{-20dB/dec}$.
	>The phase is constant at $0^{\circ}$ until $0.1\omega_{p}$ after which it is a straight line that crosses $-45^{\circ}$ at a frequency $\omega_{p}$, and at $10\omega_{p}$ again constant at $-90^{\circ}$.
	
	![[LSY1_009/Pasted image 20240906224020.png|book|500]]
	>Bode diagram for $G(s)=\tau s+1$. The magnitude is constant at $\pu{0dB}$ until the corner frequency of $\omega_{p}=\dfrac{1}{\tau}$, after which it is a straight line with slope $\pu{20dB/dec}$.
	>The phase is constant at $0^{\circ}$ until $0.1\omega_{p}$, after which it is a straight line that crosses $45^{\circ}$ at frequency $\omega_{p}$, and at $10\omega_{p}$ again constant at $90^{\circ}$.


### General Guidelines for Asymptotic Bode
- Each pole adds $\pu{-20dB/dec}$ to the magnitude's slope (over high frequencies).
- Each zero adds $\pu{+20dB/dec}$ to the magnitude's slope (over high frequencies).
- Each pole in $\mathbb{C}\setminus \mathbb{C}_{0}$ adds a phase lag of $-90^{\circ}$.
- Each pole in $\mathbb{C}_{0}$ adds a phase lag of $+90^{\circ}$.
- Each zero in $\mathbb{C}\setminus \mathbb{C}_{0}$ adds a phase lag of $+90^{\circ}$.
- Each zero in $\mathbb{C}_{0}$ adds a phase lag of $-90^{\circ}$.

# Polar Diagram

The polar diagram is another way to represent the frequency response of the system. Similarly to the Bode diagram, the polar diagram shows $G(j\omega)$. But, unlike the Bode diagram which is comprised of two parts (magnitude and phase), the polar diagram is comprised of only one graph where we can see the real and imaginary parts $\mathrm{{Re}}G(j\omega),\,\mathrm{Im} G(j\omega)$ as a function of the frequency which **isn't** shown directly on the graph.


![[LSY1_009/Pasted image 20240907151022.png|book|500]]
>Polar diagram of $G(s)=\dfrac{1}{s+1}$.



Similarly to the Bode diagram, we can extract the magnitude and phase of the system for a given frequency from the polar diagram. But, here we do not know the actual frequency. The magnitude at a given point $\lvert G(j\omega) \rvert$ is the distance of that point from the origin. The phase $\arg G(j\omega)$ is the angle between the line connecting that point to the origin, and the positive direction of the real axis.
When looking back at the Bode diagram of the [[#Bode Diagram|first system]] showcased, we see that the magnitude decreases monotonically. This can also be seen in the polar diagram as the distance from the origin decreases until it reaches $0$. The system's phase also decreases which can again be seen in the polar diagram.

# Filters
Using the frequency response we can design filters to shape the spectra of signals. 4 categories of filters are generally used:
1. **Low-pass Filters**: filters that pass signals with a frequency lower than a selected cutoff frequency $\omega _b$, and attenuate signals with frequencies higher than the cutoff frequency.
	$$\lvert G(j\omega) \rvert\geq    \dfrac{1}{\sqrt{ 2 }} \iff \omega\leq  \omega_{b}$$
2. **High-pass Filters**: filters that pass signals with frequency higher than a certain cutoff frequency $\omega_{c}$ and attenuate signals with frequencies lower than the cutoff frequency:
	   $$\lvert G(j\omega) \rvert\geq  \dfrac{1}{\sqrt{ 2 }}\iff\omega\geq  \omega_{c}$$
3. **Band-pass Filters**: filters that pass frequencies within a certain range and attenuate frequencies outside that range.
	$$\lvert G(j\omega) \rvert\geq  \dfrac{1}{\sqrt{ 2 }}\iff\omega \in [{\omega}_{1},\, {\omega}_{2}]$$
4. **Band-pass Filters**: filters that pass frequencies outside a certain range and attenuate frequencies in that range.
	$$\lvert G(j\omega) \rvert\geq  \dfrac{1}{\sqrt{ 2 }}\iff\omega \notin [({\omega}_{1},{\omega}_{2})]$$

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

$$\begin{aligned}
 & {G}_{1}(0)=\dfrac{1}{1^{2}}=1\\[1ex]
 & {G}_{1}(0.1j/\tau) =\dfrac{1}{(0.1j+1)^{2}}=\dfrac{1}{-0.1+0.2j+1}=\dfrac{0.9-0.2j}{0.85}\\[1ex]
 & {G}_{1}(j/\tau)=\dfrac{1}{(j+1)^{2}}=\dfrac{1}{-1+2j+1}=-\dfrac{2j}{4}=-\dfrac{1}{2}j \\[1ex]
 & {G}_{1}(3j/\tau)=\dfrac{1}{(3j+1)^{2}}=\dfrac{1}{-9+6j+1}=\dfrac{-8-6j}{100} \\
 & {G}_{1}(\infty  )=\dfrac{1}{\infty }=0
\end{aligned}$$


Therefore:
$$\begin{array}{c|c}
\omega & 0 & {\omega}_{1}=0.1/\tau & {\omega}_{2}=1/\tau & {\omega}_{3}=3/\tau & \infty  \\[1ex]
\hline \lvert {G}_{1}(j\omega) \rvert  & 1 & \approx 0.99 & 0.5 & 0.1 & 0 \\[1ex]
\hline \mathrm{arg}({G}_{1}(j\omega)) & 0^{\circ}  & \approx -11^{\circ}  & -90^{\circ}  & \approx -143^{\circ}  & -180^{\circ} 
\end{array}$$


![[LSY1_009/Pasted image 20240906231510.png|book|500]]
>Asymptotic Bode diagram of ${G}_{1}(s)$. 

![[LSY1_009/Pasted image 20240906231612.png|book|500]]
>Several points of polar plot of ${G}_{1}(s)$

![[LSY1_009/Pasted image 20240906231748.png|book|500]]
>Actual polar plot of ${G}_{1}(s)$

### Part b

$${G}_{2}(s)=\dfrac{k}{s(\tau s+1)} \qquad  \tau>0,\, k>0$$

**Solution**:
The steps here are similar to those taken in the previous system. 

$$\begin{aligned}
 & {G}_{2}(0)=\dfrac{k}{0}=\infty \\[1ex]
 & {G}_{2}(0.1j/\tau ) =\dfrac{\tau k}{0.1j(0.1j+1)}=\dfrac{\tau k}{-0.01+0.1j}=\dfrac{\tau k(-0.01-0.1j)}{0.0101}\\[1ex]
 & {G}_{2}(j/\tau)=\dfrac{\tau k}{j(j+1)}=\dfrac{\tau k}{-1+j}=\dfrac{\tau k(-1-j)}{2} \\[1ex]
 & {G}_{2}(3j/\tau )=\dfrac{\tau k}{3j(3j+1)}= \dfrac{\tau k}{-9+3j}=\dfrac{\tau k(-9-3j)}{ 90 } \\
 & {G}_{2}(\infty  )=\dfrac{k}{\infty  }=0
\end{aligned}$$


Therefore:
$$\begin{array}{c|c}
\omega & 0 & {\omega}_{1}=0.1/\tau & {\omega}_{2}=1/\tau & {\omega}_{3}=3/\tau & \infty  \\[1ex]
\hline \lvert {G}_{2}(j\omega) \rvert  & \infty  & \approx 9.95k\tau & k\tau /\sqrt{ 2 } & \approx 0.11k\tau & 0 \\[1ex]
\hline \mathrm{arg}({G}_{2}(j\omega)) & 0^{\circ}  & \approx -95^{\circ}  & -135^{\circ}  & \approx -161^{\circ}  & -180^{\circ} 
\end{array}$$

![[LSY1_009/Pasted image 20240907105319.png|book|500]]
>Asymptotic Bode diagram of ${G}_{2}(s)$

![[LSY1_009/Pasted image 20240907105440.png|book|500]]
>Several point of polar plot of ${G}_{2}(s)$

![[LSY1_009/Pasted image 20240907105518.png|book|500]]
>Actual polar plot of ${G}_{2}(s)$

### Part c
$${G}_{3}(s)=\dfrac{{\tau}_{2}s+1}{{\tau}_{1}s+1}$$
For ${\tau}_{1}=\dfrac{1}{3}$ and ${\tau}_{2}=\dfrac{5}{3}$ and then for ${\tau}_{1}=\dfrac{5}{3}$ and ${\tau}_{2}=\dfrac{1}{3}$.

**Solution**:
This transfer function can be presented as
$${G}_{3}(s)=({\tau}_{2}s+1)\cdot \dfrac{1}{{\tau}_{1}s+1}$$
which is the cascade of a first-order system and the inverse of another first-order system. Their asymptotic plots of the former are in shown [[#Steps to Create an Asymptotic Diagram]]. The form of the convolution of such plots depends on the relation between ${\tau}_{1}$ and ${\tau}_{2}$.
- If $\dfrac{1}{3}={\tau}_{1}<{\tau}_{2}=\dfrac{5}{3}$, the effect of the zero precedes that of the pole (as $\omega$ increases). Hence, the magnitude start at $\pu{0dB}$ (this is the static gain), then get up at $\omega_{c 2}=\dfrac{1}{{\tau}_{2}}=\dfrac{3}{5}$, and then becomes flat again at $\omega_{c 1}=\dfrac{1}{{\tau}_{1}}=3$.
	![[LSY1_009/Pasted image 20240907112030.png|book|500]]
	>Asymptotic Bode diagram of ${G}_{3}(s)$ for $\dfrac{1}{3}={\tau}_{1}<{\tau}_{2}=\dfrac{5}{3}$.
	
	To construct the polar plot:
	$$\begin{aligned}
	 & {G}_{3}(0)=1 \\[1ex]
	 & {G}_{3}(0.1j/{\tau}_{1})= \dfrac{0.5j+1}{0.1j+1}=\dfrac{(0.5j+1)(-0.1j+1)}{1.01}=\dfrac{1.05+0.4j}{1.01} \\[1ex]
	 & {G}_{3}(j/{\tau}_{1})=\dfrac{5j+1}{j+1}=\dfrac{(5j+1)(-j+1)}{2}=\dfrac{6+4j}{2} \\[1ex]
	 & {G}_{3}(3j/\tau)=\dfrac{15j+1}{3j+1}=\dfrac{(15j+1)(-3j+1)}{10}=\dfrac{46+12j}{10} \\[1ex]
	 & {G}_{3}(\infty )=\dfrac{5\infty}{\infty }=5
	\end{aligned}$$
	Therefore:
	$$\begin{array}{c|c}
	\omega & 0 & {\omega}_{1}=0.1/{\tau}_{1} & {\omega}_{2}=1/{\tau}_{1} & {\omega}_{3}=3/{\tau}_{1} & \infty  \\[1ex]
	\hline \lvert {G}_{3}(j\omega) \rvert  & 0  & \approx 1.11 & \approx 3.61 & \approx 4.75 & 5 \\[1ex]
	\hline \mathrm{arg}({G}_{3}(j\omega)) & 0^{\circ}  & \approx 21^{\circ}  & \approx 33^{\circ}  & \approx 15 ^{\circ}  & 0^{\circ} 
	\end{array}$$
	![[LSY1_009/Pasted image 20240907114434.png|book|500]]
	>Several points of polar plot of ${G}_{3}(s)$ for $\dfrac{1}{3}={\tau}_{1}<{\tau}_{2}=\dfrac{5}{3}$.

	![[LSY1_009/Pasted image 20240907114454.png|book|500]]
	>Actual polar plot for ${G}_{3}$ for $\dfrac{1}{3}={\tau}_{1}<{\tau}_{2}=\dfrac{5}{3}$
	
- If $\dfrac{5}{3}={\tau}_{1}>{\tau}_{2}=\dfrac{1}{3}$, the effect of the pole precedes that of the zero (as $\omega$ increase). Hence, the magnitude starts at $\pu{0dB}$ (this is the static gain), then gets down at $\omega_{c 1}=\dfrac{1}{{\tau}_{1}}=0.6$ and then become flat again at $\omega_{c 2}=\dfrac{1}{{\tau}_{2}}=3$.
	![[LSY1_009/Pasted image 20240907112638.png|book|500]]
	>Asymptotic Bode diagram of ${G}_{3}(s)$ for $\dfrac{5}{3}={\tau}_{1}>{\tau}_{2}=\dfrac{1}{3}$.
	
	We can construct the polar plot in a similar manner to the previous case.
	![[LSY1_009/Pasted image 20240907114940.png|book|500]]
	>Several points of polar plot of ${G}_{3}(s)$ for $\dfrac{5}{3}={\tau}_{1}>{\tau}_{2}=\dfrac{1}{3}$.
	
	![[LSY1_009/Pasted image 20240907114953.png|book|500]]
	>Actual polar plot for ${G}_{3}$ for $\dfrac{5}{3}={\tau}_{1}>{\tau}_{2}=\dfrac{1}{3}$.
	

## Question 3
A signal $u$ passes a stable system $F(s)$, whose frequency response is presented by its polar plot in the following figure:
![[LSY1_009/Pasted image 20240907115205.png|book|500]]
>Polar plot of $F(j\omega)$.

The magnitude $\lvert F(j\omega) \rvert$ is a monotonically decreasing function of $\omega$. Denote by $y$ the resulting output signal, i.e. $y=F(s)u$.

### Part a
Find $y(t)$ for $u(t)=2\sin(t)$.

**Solution**:
By the [[#Frequency Response|Frequency Response Theorem]]:
$$y_{}(t)=a \lvert G(j\omega) \rvert \sin(\omega t+\phi+\arg G(j\omega))$$
In our case, $a=2,\,\phi=0$ and $\omega=1$. From the figure we can also conclude that 
$\lvert F(j) \rvert=0.5$ and $\arg F(j)=\pi$. Therefore:
$$\begin{gathered}
y(t)=2\cdot 0.5\sin(t+\pi) \\[1ex]
\boxed{y(t)=-\sin(t) }
\end{gathered}$$

### Part b
Find $y(t)$ for $u(t)=\sin\left( \dfrac{2}{3}t+2 \right)+3\sin\left( \dfrac{1}{10}t+0.356 \right)$.

**Solution**:
In this case, we can simply sum the the frequency response of each sinusoid. For $\sin\left( \dfrac{2}{3}t+2 \right)$, $a=1,\,\phi=2,\,\omega=\dfrac{2}{3}$. Therefore, from the figure, we see that $\lvert F(2j/3) \rvert=0.6923$ and $\arg F\left( 2j/3 \right)=-2.223$, which is why:
$$\begin{aligned}
{y}_{1}(t) & =0.6923\sin\left( \dfrac{2}{3}t+2-2.223 \right) \\[1ex]
 & =0.6923\sin\left( \dfrac{2}{3}t-0.223 \right)
\end{aligned}$$

For $3\sin\left( \dfrac{1}{10}t+0.356 \right)$, $a=3,\,\phi=0.356,\,\omega=\dfrac{1}{10}$. From the figure, $\lvert F(0.1j)=0.9901 \rvert$ and $\arg F(0.1)=-0.356$, which is why:
$$\begin{aligned}
{y}_{2}(t) & =3\cdot 0.9901\sin(0.1t+0.356-0.356) \\[1ex]
 & =2.9708\sin(0.1t)
\end{aligned}$$

Therefore, resulting output signal is:
$$\boxed {
y(t)=0.6923\sin\left( \dfrac{2}{3}t-0.223 \right)+2.9708\sin(0.1t)
 }$$

### Part c
In what frequency range harmonic $u$'s are attenuated by at least a factor of $5$?

**Solution**:
For the harmonic $u$'s to be attenuated by at least a factor of $5$, the following condition has to to be valid: $\lvert F(j\omega) \rvert\leq \dfrac{1}{5}$. From the figure, we see that's true for $\boxed{\omega\geq 2 }$.


## Question 4
Three sensors, ${H}_{1}(s),\,{H}_{2}(s)$ and ${H}_{3}(s)$, were tested on the same signal:
![[LSY1_009/Pasted image 20240907153452.png|bookhue|500]]
>Block diagram of the systems.

The results (measurements) were saved, see parts of them, in the time interval $t\in[20,30]$, in the following figure:
![[LSY1_009/Pasted image 20240907153615.png|bookhue]]
>Measurements in the time interval $t\in[20,30]$.

)Unfortunately, the information about what sensor each measurement belo 17 to got lost. Fortunately, we still have frequency response plots of each sensor:

![[LSY1_009/Pasted image 20240907153730.png|bookhue|500]]
>Sensor frequency responses.

Use it to reconstruct the lost information.

**Solution**:
All measurements are already in steady state. By the [[#Frequency Response Theorem]], the steady-state response of the $n$-th measurement is:
$$y_{m,n}(t)=5H_{n}(0)+2\lvert H_{n}(j) \rvert\cos(t+\arg H_{n}(j))+3\lvert H_{n}(5j) \rvert\sin(5t+\arg H_{n}(5j))$$
The $\color{magenta} \text{magenta}$ plot contains $2$ harmonics: an offset (i.e. $\omega=0$) and $\omega=5$ (its period is $\approx \pu{1.25s}\approx \dfrac{2\pi}{5}$). In other words, the harmonic at $\omega=1$ is filtered out by the sensor. The only frequency response the zeroes out $\omega=1$ is the $\color{green} \text{green}$
line, which belongs to ${H}_{2}(s)$.

Now, both $\color{olive} \text{lime}$ and $\color{cyan} \text{cyan}$ plots have the harmonic at $\omega=5$ filtered out in them, consistently with the zero gains of ${H}_{1}(j\omega)$ and ${H}_{3}(j\omega)$ at $\omega=5$. Measurements $y_{m,i}$ and $y_{m,j}$ have identical offsets (consistently with the identical static gains of ${H}_{1}(s)$ and ${H}_{3}(s)$), but different amplitudes of harmonics with $\omega=1$ in them. This difference must be manifested in different gains of he frequency responses of the remaining sensors at $\omega=1$. That is indeed what we can see in the $\color{CadetBlue}\text{blue}$ and $\color{red}\text{red}$ lines there. We end up with:

$$ \begin{array}{c|c}
\text{Measurements} & \text{Sensor frequency responses} \\
\hline y_{m,k} & {H}_{2}(j\omega) \\
y_{m,j}  & {H}_{3}(j\omega) \\
y_{m,i} & {H}_{1}(j\omega)
\end{array} $$


## Question 5
Given is a system represented by an ODE:
$$\ddot{y}(t)+2\dot{y}(t)+y(t)=\dot{u}(t)+2u(t)$$
and the input:
$$u(t)=\delta(t)+(t-4)+2\sin (2t)$$
Find the system response in steady state to the input $u$.

**Solution**:
We perform the [[LSY1_007 Laplace Transform#The Laplace Transform|Laplace transform]] on the the ODE:
$$s^{2}Y(s)+2sY+Y=sU+2U$$
thus, the transfer function of the system is:
$$G(s)=\dfrac{s+2}{s^{2}+2s+1}$$
The poles of the system are $s=-1$, which means it is [[LSY1_007 Laplace Transform#Necessary and Sufficient Condition for Stability|stable]]. Since the system is also linear, the output will be a superposition of the $3$ responses: The impulse response, the step response, and the sinusoidal response:
$$y(t)=y_{\delta}(t)+y_{\text{step}}(t)+y_{\text{sin}}(t)$$

- The system is stable, so in steady state the [[LSY1_004 Linear State-Space Equation#Impulse Response|impulse response]] decays to zero:
	$$y_{\delta}(t)=0$$
- For the same reason, the [[LSY1_007 Laplace Transform#Steady-State and Transients|step response]] converges to the static gain:
	$$\begin{aligned}
y_{\text{step}}(t) & =G(0) \\[1ex]
 & =2
\end{aligned}$$
- Due to the [[#Frequency Response|Frequency Response Theorem]], the response to a sinusoidal input will converge to a sinusoidal signal:
	$$\begin{aligned}
y_{\sin}(t) & =a \lvert G(j\omega) \rvert\sin(\omega t+\phi+\mathrm{arg}G(j\omega)) \\[1ex]
 & = 2\lvert G(2j) \rvert \sin(2t+\arg G(2j))
\end{aligned}$$
	Let's find $G(2j)$:
	$$G(2j)=\dfrac{2j+2}{-4+4j+1}=\dfrac{2j+2}{4j-3}=\dfrac{(2j+2)(-3-4j)}{25}=\dfrac{2-14j}{25}$$
	Which is why:
	$$y_{\sin}(t)=\dfrac{4\sqrt{ 2 }}{5}\sin\left( 2t-1.49 \right)$$

Summing all the responses, we get:
$$\boxed{y(t)=2+\dfrac{4\sqrt{ 5 }}{2}\sin(2t-1.49) }$$
![[LSY1_009/Pasted image 20240907172621.png|book|500]]
>Plots for the different responses that make up $y(t)$.


## Question 6
Given is the below transfer function:
$$G(s)=\dfrac{256s}{(s+2)(s+8)^{2}}$$

Plot the asymptotic magnitude Bode diagram.

**Solution**:
We first unpack the system into its basic first and second order subsystem:
$$G(s)=256 \cdot s  \cdot\dfrac{1}{s+2}\cdot \dfrac{1}{(s+8)^{2}}$$
We now transform each of the subsystem into their [[#Steps to Create an Asymptotic Diagram|standard form]]:
$$\begin{aligned}
G(s) & =256\cdot s\cdot \dfrac{1/2}{s/2+1}\cdot \dfrac{1/64}{(s/8+1)^{2}} \\[1ex]
 & =2\cdot s\cdot \dfrac{1}{s/2+1}\cdot \dfrac{1}{(s/8+1)^{2}}
\end{aligned}$$
We now have 4 subsystems:
$$\begin{aligned}
{G}_{1}(s)=2 &  & {G}_{2}(s)=s &  & {G}_{3}(s)=\dfrac{1}{s/2+1} &  & {G}_{4}(s)=\dfrac{1}{(s/8+1)^{2}}
\end{aligned}$$

We can now analyze each of the subsystems separately:
- The first system is a static gain:
	$$\lvert {G}_{1}(j\omega) \rvert=2$$
	Its magnitude is ${M}_{1(\pu{dB})}=20\log 2\approx 6$.
	![[LSY1_009/Pasted image 20240907183933.png|book|400]]
	>Asymptotic Bode diagram of ${G}_{1}(s)$.
- The second system is a differentiator:
	$$\lvert {G}_{2}(j\omega) \rvert=\omega$$
	thus the magnitude is ${M}_{2\pu{(dB)}}=20\log\omega$ and we get a straight line with slope $\pu{20dB}$.
	![[LSY1_009/Pasted image 20240907184129.png|book|400]]
	>Asymptotic bode diagram of ${G}_{2}(s)$.
- The third system ${G}_{3}(s)$ is a [[#Filters|Low-pass Filter]]:
	  $$\begin{aligned}
	\lvert {G}_{3}(j\omega) \rvert & =\left\lvert \dfrac{1}{j\omega /2+1} \right\rvert \\[1ex]
	 & =\left\lvert  \dfrac{-0.5\omega j+1}{0.25\omega ^{2}+1}  \right\rvert \\[1ex]
	 & =\dfrac{1}{\sqrt{ \tau ^{2}\omega ^{2}+1 }} \\[1ex]
	 & =\dfrac{1}{\sqrt{ 0.25\omega ^{2}+1 }}
	\end{aligned}$$
	so the magnitude in $\pu{dB}$ will be:
	$$\begin{aligned}
	{M}_{3\pu{(dB)}} & =20\log \dfrac{1}{0.25\omega ^{2}+1} \\[1ex]
	 & =20\log(0.25\omega ^{2}+1)^{-0.5} \\[1ex]
	 & =-10\log(0.25\omega ^{2}+1)
	\end{aligned}$$
	It has a slope of $\pu{-20dB/dec}$ after the corner frequency of $\omega_{p}=\pu{2dB/dec}$.
	![[LSY1_009/Pasted image 20240907185924.png|book|500]]
	>Asymptotic (and real) Bode diagram of ${G}_{3}(s)$.
	
- The fourth system is also a Low-pass filter but of order $2$. Similarly, we get a gain of:
	$${M}_{4(\pu{dB})}=-20\log(0.015\omega ^{2}+1)$$
	The slope of the system after the corner frequency of $\omega_{p}=\pu{8rad/sec}$, is $\pu{-40dB/dec}$.
	![[LSY1_009/Pasted image 20240907191144.png|book|400]]
	>Asymptotic (and real) Bode diagram of ${G}_{4}(s)$.
	

We can now cascade all the asymptotic Bodes and get the asymptotic Bode of the original system:
$$\mathrm{slope}\,[\pu{dB/dec]}=\begin{cases}
20 & 0\leq  \omega\leq  2 \\
0 & 2\leq  \omega\leq  8 \\
-40 & \omega\geq  8
\end{cases}$$
![[LSY1_009/Pasted image 20240907191406.png|book|500]]
>Asymptotic (and real) Bode plot of the $G(s)$.


