---
aliases:
  - causality
  - time-invariance
  - memoryless system
  - system stablitiy
---

# Causality
All state-space systems introduced so far (both LTV and LTI) have the property that the output *before* some time $t$ does not depend on the input *after* $t$. Such systems are called *causal*.

>[!def] Definition: 
 >The state-space system (CLTV) is **causal** in the sense that given any two input signal $\mathbf{u}$ and $\bar{\mathbf{u}}$ that
>$$
> \bar{\mathbf{u}}(t)=u(t),\, \qquad  \forall 0\leq  t<T
> $$
>for some time $T>0$, if $u\to y$ then there exists an output $\bar{\mathbf{y}}$ such that $\bar{\mathbf{u}}\to \bar{\mathbf{y}}$ and
>$$
> \bar{y}(t)=y(t),\qquad  \forall 0\leq  t<T
> $$


![[Pasted image 20240611131750.png|book]]
>Causality: For two inputs $\mathbf{u}$ and $\bar{\mathbf{u}}$ that are equal to each other up to some $T$, there must exist two outputs that are also equal to each other up to the same time $T$.

Any practical system that operates in real time must necessarily be causal. We do not yet know how to build a system that can respond to future inputs. A noncausal system is prphetic system that knows the future input and acts on it in the present. Thus, if we apply an input starting at $t=0$ to a noncausal system, the output would begin even before $t=0$.

![[Screenshot_20240614_135501_Obsidian.jpg]]

The foregoing discussion may suggest that noncausal systems have no practical purpose. This is not the case; they are valuable in the study of systems for several reasons. Noncausal systems *are* realizable when the independent variable is other than "time" (e.g., *space*). Consider, for example, an electric field $\mathbf{E}(x)$ that is present at every point on the $x$ axis from $x=-\infty$ to $\infty$. In this case the input (i.e., the charge density $q(x)$) starts at $x=0$, but its output (the electric field $E(x)$) begins before $x=0$. Clearly, this space-charge system is noncausal.
# Time Invariance
A key difference between the LTV and LTI systems introduced so far is that the latter have the property that time shifting of their inputs results in the time shifting of the output. This property justifies the terminology *time-varying* versus *time-invariant* for these systems.

>[!def] Definition: 
 >The state-space system (CLTI) is *time-invariant* in the sense that given any two input signals $\mathbf{u}$ and $\bar{\mathbf{u}}$ such that:
 >$$
> \bar{\mathbf{u}}(t)=\mathbf{u}(t+T),\, \qquad  \forall t\geq  0
> $$
 >for some time $T>0$, if $u\to y$ then there exists an output $\bar{\mathbf{y}}$ such that $\bar{\mathbf{u}}\to \bar{\mathbf{y}}$ and
 >$$
> \bar{\mathbf{y}}(t)=y(t+T),\, \qquad  \forall t\geq  0
> $$
 
![[Pasted image 20240611142852.png|book]]
>Time invariance: For an input $\mathbf{u}$ with output $\mathbf{y}$, for every time shifted version $\bar{\mathbf{u}}$ of $\mathbf{u}$ there must exist an output $\bar{\mathbf{y}}$ that is a time shifted version $\mathbf{y}$.

# Linearity
Both the LTV and LTI system have the property that they can be viewed as [[ALG1_009 טרנספורמציות לינאריות#טרנספורמציות לינאריות|linear]] maps from their inputs to appropriate outputs. This justifies the qualifier *linear* in LTV and LTI.


>[!def] Definition: 
>The state-space system (CLTV) is **linear** in the sense that given any two input signals ${\mathbf{u}}_{1}$ and ${\mathbf{u}}_{2}$ and scalars $\alpha,\,\beta \in \mathbb{R}$, if ${\mathbf{u}}_{1}\to {\mathbf{y}}_{1}$ and $\mathbf{u}_{2}\to\mathbf{y}_{2}$, then $\alpha \mathbf{u}_{1}+\beta \mathbf{u}_{2}\to\alpha\mathbf{y}_{1}+\beta\mathbf{y}_{2}$.


>[!example] Example: Lineary of Constant-Coefficient Linear Differential Equations
>Show that the system descrined the equation
> $$
> \dfrac{\mathrm{d}y(t)}{\mathrm{d}t}+3y(t)=x(t)
> $$
> is linear.
> **Solution**:
> Let the system response to the inputs ${x}_{1}(t)$ and ${x}_{2}(t)$ be ${y}_{1}(t)$ and ${y}_{2}(t)$, reprectively. Then
>$$
> \begin{aligned}
> \dfrac{\mathrm{d}{y}_{1}(t)}{\mathrm{d}t}+3{y}_{1}(t)=3{y}_{1}(t)={x}_{1}(t) & &  \text{and} &  & \dfrac{\mathrm{d}{y}_{2}(t)}{\mathrm{d}t}+3{y}_{2}(t)={x}_{2}(t)
> \end{aligned}
> $$
> Multiplying the first equation by ${k}_{1}$, the second by ${k}_{2}$, and adding them yield
> $$
> \dfrac{\mathrm{d}}{\mathrm{d}t}[{k}_{1}{y}_{1}(t)={k}_{2}{y}_{2}(t)]+3[{k}_{1}{y}_{1}(t)+{k}_{2}{y}_{2}(t)]={k}_{1}{x}_{1}(t)+{k}_{2}{x}_{2}(t)
> $$
> But this equation is the system equation with
>$$
> \begin{aligned}
> x(t)={k}_{1}{x}_{1}(t)+{k}_{2}{x}_{2}(t) &  & \text{and} &  & y(t)={k}_{1}{y}_{1}(t)+{k}_{2}{y}_{2}(t)
> \end{aligned}
> $$
> Thereforce, the system is linear.

# Instanteneous and Dynamic Systems
A system's output at any instant $t$ generally depends on the entire past inputs. However, in a special class of systems, the output at any instant $t$ depends only on its input at that instant. Such systems are said to be **instantenous**, **static** or **memoryless** systems. Otherwise, the system is said to be **dynamic**. A system whose response at $t$ is completely determined by the input signals over the past $T$ seconds is a **finite-memory system** with a memory of $T$ seconds.

>[!example] Example: Assessing System Memory
>Determine whether the following systems are memoryless:
>1.
>	$$
>	y(t-1)=2x(t-1)
>	$$
>2.
>	$$
>	y(t)=\dfrac{\mathrm{d}}{\mathrm{d}t}x(t)
>	$$
>3.
>	$$
>	y(t)=(t-1)x(t)
>	$$
>	
>	**Solution**:
>	
>1. in this case, the output at time $t-1$ is just twice the input at the same time $t-1$. Since the output at a particular time depends only on the strength of the input at the same time, the system is memoryless.
>2. Although it appears that the output $y(t)$ at time $t$ depends on the input $x(t)$ at the same time $t$, we know that the slope (derivative) of $x(t)$ cannot be determined solely from a single point. There must be some memory, even if infinitesimally small, involved. This is confirmed by using the funamental theorem of calculus to express the system as
>	$$
>	y(t)=\lim_{ T \to 0} \dfrac{x(t)-x(t-T)}{T}
>	$$
>	Since the output at a particular time depends on more than just the input at the same time, the system is not memoryless.
>3. The output $y(t)$ at time $t$ is just the input $x(t)$ at the same time multiplied by the coefficient $t-1$. Since the output at a particular time depends only on the strength of the input at the same time, the system is memoryless.

# Stable and Unstable Systems
Systems can also be classified as **stable** or **unstable** systems.

>[!def] Definition: 
> A continuous-time system $u\to y$ is said to be **$L_{q}$-stable** if there are $\gamma,\beta \geq 0$ such that 
> $$
> \left \| y \right \|_{q}\leq\gamma \lVert u \rVert_{q}+\beta 
> $$
> for $q\in \mathbb{N}$ and $\forall u\in L_{q}$.
> $L_{q}$-stability implies that $y\in L_{q}$ for all $u\in L_{q}$.

>[!notes] Notes: 
 >For the signals, $L$ stands for their [[LSY1_002 Signals and Convolutions#Norms|norms]].

If every *bounded input* applied at the input terminal results in a *bounded output*, the system is said to be **stable externally**. External stability can be ascertained by measurements at the external terminals (inputs and output) of the system. This type of stability is also known as **$L_{\infty}$-stability**, or the stability in the **BIBO** (bounded-input/bounded-output) sense.

For linear systems, we can always take $\beta=0$. i.e., a linear system is $L_{q}$-stable if
$$
\lVert y \rVert _{q}\leq  \gamma \lVert u \rVert _{q}
$$

>[!example] Example: 
>Showing that a system is stable might not be easy. But in some cases it is:
>If $y(t)=u(t-\tau)$ (A delay system), while $\tau=\text{const}$, then
>$$
> \lVert y \rVert _{\infty }= \sup_{t\in \mathbb{R}}\left|y(t)\right|=\sup_{t\in \mathbb{R}}\left|u(t-\tau)\right|=\sup_{t\in \mathbb{R}}\left|u(t)\right|=\lVert u \rVert _{\infty }
> $$
> and
> $$
> \lVert y \rVert _{2}=\int_{-\infty }^{\infty} \left|y(t)\right|^{2} \, \mathrm{d}t =\int_{-\infty }^{\infty} \left|u(t-\tau)\right|^{2} \, \mathrm{d}t\underset{ s=t-\tau }{ = }\int_{-\infty }^{\infty} \left|u(s)\right|^{2} \, \mathrm{d}s=\lVert u \rVert _{2}  
> $$
> Thus, $\mathbf{D}_{\tau}$ with a constant $\tau$ is both ${L}_{2}$ and $L_{\infty}$-stable.

>[!example] Example: 
>Showing that a system is unstable may be easier. One "just" needs to dream up a destabilizing input.
>If $u=\mathbb{1}\in L_{\infty}$, then
>$$
> y(t)=\int_{-\infty }^{t} \mathbb{1}(s) \, \mathrm{d}s=\int_{0}^{t}  \, \mathrm{d}s=t\mathbb{1}(t)=\mathrm{ramp}(t)  
> $$
>Because $\mathrm{ramp}\notin L_{\infty}$, the integrator is not BIBO stable.

## Induced Norm
>[!def] Definition: 
 >Let $G:u\to y$ be a stable CLTI system. The smallest $\gamma$ for which the inequality above holds true is called the **$L_{q}$-[[NUM1_003 נורמה#נורמה של מטריצה|induced norm]]** of $G$:
 >$$
> \lVert G \rVert _{q}:=\sup_{u\neq 0} \dfrac{\lVert Gu \rVert _{q}}{\lVert u \rVert_{q} }=\sup_{\lVert u \rVert _{q}=1}\lVert Gu \rVert _{q}
> $$
 
 >[!example] Example: 
 >For the delay system $\mathbf{D}_{\tau}$ with constant $\tau$ from the previous example, the induced norm is:
 >$$
> \lVert \mathbf{D} \rVert_{\infty }=\lVert \mathbf{D} \rVert _{2}=1 
> $$
 
# Exercises

## Question 1

Classify the models $G:u\to y$ below in terms of linearity, time invariance, (except the systems in items $1$ and $2$) causality.
1. $y(t)=t\dot{u}(t)$
	Linear, but not time invariant:
	$$
	y(t+s)=(t+s)\dot{u}(t+s)\neq t\dot{u}(t+s)
	$$
2. $y(t)=u(t)\dot{u}(t)$
	Non-linear: for $u={\alpha}_{1}{u}_{1}+{\alpha}_{2}{u}_{2}$
	$$
	\begin{gathered}
	\alpha {y}_{1}(t)+\beta {y}_{2}(t)=\alpha{u}_{1}(t){\dot{u}}_{1}(t)+\beta{u}_{2}(t)\dot{u}_{2}(t) \\
	\neq \\
	({\alpha}{u}_{1}(t)+\beta {u}_{2}(t))(\alpha \dot{u}_{1}(t)+\beta \dot{u}_{2}(t))=u(t)\dot{u}(t)=y(t)
	\end{gathered}
	$$
	Time invariant.
3. $y(t)=u(t+1)$
	Linear, time invariant and *not* causal:
	The signal at time $t_{c}$ depends on $u$ at time $t_{c}+1$.
4. $y(t)=2u(t)+1$
	Non-linear: for $u=\alpha {u}_{1}+\beta {u}_{2}$
	$$
	\begin{gathered}
	\alpha {y}_{1}(t)+\beta {y}_{2}(t)={\alpha}_{1}(2{u}_{1}(t)+1)+{\alpha}_{2}(2{u}_{2}(t)+1) \\
	\neq  \\
	2(\alpha {u}_{1}(t)+\beta {u}_{2}(t))+1=2u(t)+1=y(t)
	\end{gathered}
	$$
	time invariant and causal.
5. $y(t)=\begin{cases}u(t) & 0<t\leq 1 \\ 0  & \text{otherwise} \end{cases}$
	Linear, time invariant, and causal.
6. $y(t)=5$
	Linear, time invariant, and causal.



