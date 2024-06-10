---
aliases:
  - continuos-time signal
  - discrete-time signal
  - domain and codomains
  - state-space linear systems
  - LTI
  - LTV
  - block diagram
  - parallel inteconnection
  - cascade interconnection
  - feedback interconnection
---
# Basic Definitions

## Continuos-Time and Discrete-Time Signals
Signals may describe a wide variety of physical phenomena. For example, consider the following simple figure:
![[LSY1_001/Screenshot_20240602_101319_Samsung Notes.jpg|book|300]]
>A simple RC circuit.

 In this case, the patterns of variation over time in the source and capacitor voltages, $v_{s}$ and $v_{c}$, are examples of signals.
As another example, consider the human vocal mechanism, which produces speech by creating fluctuations in acoustic pressure.
![[LSY1_001/Screenshot_20240602_101744_Samsung Notes.jpg|book|400]]
>Example of a recording of speech. The signal represents acoustic pressure variations as a function of time the spoken word "should".

Signals are represented mathematically as functions of one or more independent variables. The following figure depicts a typical example of annual average vertical wind profile as a function of height:

![[LSY1_001/Screenshot_20240602_103523_Samsung Notes.jpg|book|400]]
>Typical annual vertical wind profile.

Throughout this book we will be considering two basic types of signals: **continuos-time signals** and **discrete-time signals**. In the case of continuous-time signals the independent variable is continuous, and thus these signals are denied for a continuum of values of independent variables. On the other hand, discrete-time signals are defined only at discrete times, and consequently, for these signals, the independent variable takes on only a discrete set of values.

![[LSY1_001/Screenshot_20240602_104334_Samsung Notes.jpg|book]]
>An example of a discrete-time signal: The weekly Dow-Jones stock market index from January 5, 1929 to January 4, 1930.

We will have frequent occasions when it will be useful to represent signals graphically. Illustration of a continuous-time signal $x(t)$ and a discrete-time signal $x[n]$ are shown in the following figure:

![[LSY1_001/Screenshot_20240602_104822_Samsung Notes.jpg|book]]
>Graphical represntations of (a) continuous-time and (b) discrete-time signals. Note that the discrete-time signal $x[n]$ is defied *only* for integer values of the independent variable.

## Domains and Codomains
We've established that signals are functions. More precisely, a signal is a function that assigns each element from its **domain** ([[../CAL1/CAL1_001 פונקציה#פונקציה|מקור]]) one element from its **codomain** ([[../CAL1/CAL1_001 פונקציה#פונקציה|תמונה]])

An example of a continuous-time domain is real number domain $\mathbb{R}$. For a discrete-time domain, a common example would be integers - $\mathbb{Z}$.

## Notation
Signals are normally denoted by lowercase letters, $u,v,w\dots$
If we would like to talk about its domains, we would write for example:
$$u:\mathbb{R}_{\geq  0}\to \mathbb{R}$$
which stands for: $u$ assigns to every element of $\mathbb{R}_{\geq 0}$ (domain) an element of $\mathbb{R}$ (codomain).

For continuous-time signals, $u(t)$ means the value of $u$ at a specific $t\in \mathbb{R}_{+}$, i.e. $u(t) \in \mathbb{R}$.
For descrete-time signals, $v[t]$ means the value of $v$ at a specific $t\in \mathbb{Z}$, i.e. $v[t]\in \mathbb{C}^{2}$.

## Basic Definitions
A subset of the domain in which a signal is nonzero is called its **support**:
$$\text{supp}(x)\equiv \{ t\in \mathbb{R}\mid x(t)\neq 0 \}$$

A signal $x$ is said to be:
- **scalar-valued** if the codomain is scalar, like $\mathbb{R}$ or $\mathbb{C}$ (we use $\mathbb{F}$ if either)
- **vector-valued** if the codomain is a vector, like $\mathbb{R}^{n}$ or $\mathbb{C}^{n}$.
- **decaying** if $\lim_{ t \to \infty}x(t)=0$.
- **converging** if $\lim_{ t \to \infty}=x(t)=x_{ss}$ for some constant $x_{ss}$ from its codomain.

# Systems as (mathematical) models
Systems are normally represented by their **models**, which express relations between involved signals in an abstract (math) language.

Such relation are derived under simplifying assumptions about systems and their operation conditions and are thus truthful only to a certain extent and under certain conditions. Models are derived
- from first principles/axioms
- phenomenologically
- from observing experimental input output relations
or combinations of those.

We often say "system" meaning its model, and our model is a (more or less accurate) approximation of the reality.

>[!example] Example - first principle modeling
 >For the following system, we would like to find a mathematical model that describes the relation between the forces and the position of the mass:
 >![[LSY1_001/Screenshot_20240602_112034_Samsung Notes.jpg|book|300]]
 >We will make the following simplifying assumptions:
 >- spring force is proportional to position differences (Hooke's law).
 >- damper force is propportional to velocity differences (viscous damping).
 >- neglecting friction, force misalignment, etc.
 >
 >Supposing zero spring and damper forces at $x=0$, by Newton's second law ($F=ma$):
>$$m\ddot{x}(t)=f(t)+f_{\text{spring}}(t)+f_{\text{damp}}(t)=f(t)-kx(t)-c\dot{x}(t)$$
>or, equivalently:
>$$m\ddot{x}(t)+c\dot{x}(t)+kx(t)=f(t)$$ 

>[!example] Example: 
 >Let
 >- $s$ be the number of susceptible individuals
 >- $i$ be the number of infection individuals
 >- $r$ be the number of removed (and immune) or deceased individuals
 >
 >The SIR model:
 >$$\begin{cases}
\dfrac{\mathrm{d}}{\mathrm{d}t}s(t)=-bs(t)i(t) & s(0)={s}_{0} & \text{(total population)} \\[1ex]
\dfrac{\mathrm{d}}{\mathrm{d}t}i(t)=bs(t)i(t)-ai(t) & i(0)=1 & \text{(patient zero, input)} \\[1ex]
\dfrac{\mathrm{d}}{\mathrm{d}t}r(t)=ai(t) & r(0)=0 & \text{(no deceased/immune}
 &  & \text{in the beginning)}
\end{cases}$$
>for some infection rate $b>0$ and recovery rate $a>0$.


# State-Space Linear Systems


> [!attention] Attention! 
> The following subject is talked about in the seconds lecture, but I personally think it should be here, because it introduces some concepts for the introductory for Simulink.

## State-Space Linear Systems

![[LSY1_001/Pasted image 20240610132600.png|book|400]]
>Block diagram representation of the linear state-space equations

A state-space representation is a mathematical model of a physical system specified as a set of input, output, and variables related by first-order differential equations or difference equations.
The state-space model can be applied in subjects such as economics, statistics, computer science and electrical engineering, and neuroscience.

A *continuous-time state-space-linear system* is defined by the following two equations:
$$\begin{aligned}
 & \dot{\mathbf{x}}(t)=\mathbf{A}(t)\mathbf{x}(t)+\mathbf{B}(t)\mathbf{u}(t) &  & \mathbf{x} \in \mathbb{R}^{n},\, \mathbf{u}\in \mathbb{R}^{k} \\
 & \mathbf{y}(t)=\mathbf{C}(t)\mathbf{x}(t)+\mathbf{D}(t)\mathbf{u}(t) &  & \mathbf{y}\in \mathbb{R}^{m}
\end{aligned}\tag{1}$$

The signals:
$$\mathbf{u}:[0,\infty )\to \mathbb{R}^{k},\qquad \mathbf{x}:[0,\infty )\to \mathbb{R}^{n},\, \qquad \mathbf{y}:[0,\infty )\to \mathbb{R}^{m}$$
are called **input**, **state**, and **output** of the system, respectively. The first, first-order differential equation, is called the **state equation** and the second one is called the **output equation**.

The matrices $\mathbf{A}(\cdot),\,\mathbf{B}(\cdot),\,\mathbf{C}(\cdot),\,\mathbf{D}(\cdot)$ are called the **state**, **input**, **output** and **feedthrough** matrices respectively.

These equations express an *input-output* relationship between the input signal $u(\cdot)$ and the output signal $y(\cdot)$. For a given input $u(\cdot)$, we need to solve the state equation to determine the state $x(\cdot)$ and then replace it in the output equation to obtain the output $y(\cdot)$.

>[!notes] Notes: 
 >For the same input $u(\cdot)$, different choices of the initial condition $x(0)$ on the state equation will result in different state trajectories $x(\cdot)$. Consequently, *one* input $u(\cdot)$ generally corresponds to *several* possible outputs $y(\cdot)$.
 
## Terminology and Notation
When the input signal $u$ takes scalar values ($k=1$) the system is called **single-input (SI)**, otherwise it is called **multiple-input (MI)**. When the output signal $y$ takes scalar values ($m=1$) the system is called **single-output (SO)**, otherwise it is called **multiple-output (MO)**.

When there is no state equation $(n=0)$ and we have simply
$$y(t)=D(t)u(t),\, \qquad  u\in \mathbb{R}^{k},\, \qquad  y\in \mathbb{R}^{m}$$
the system is called **memoryless**.

When all the matrices $A(t),\,B(t),\,C(t),\,D(t)$ are constant $\forall t\geq 0$, the system $(1)$ is called a **Linear Time-Invariant (LTI)** system. In the general case, $(1)$ is called a **Linear Time-Varying (LTV)** system to emphasize that time invariance is not being assumed.

To keep formulas short, we can abbreviate $(1)$ to
$$\begin{align}
 \dot{\mathbf{x}}=\mathbf{A}(t)\mathbf{x}+\mathbf{B}(t)\mathbf{u},\, \qquad  \mathbf{y}=\mathbf{C}(t)x+\mathbf{D}(t)\mathbf{u},\, \qquad  \mathbf{x} \in \mathbb{R}^{n},\, \mathbf{u}\in \mathbb{R}^{k},\, \mathbf{y}\in \mathbb{R}^{m} \\[1ex]\text{(CLTV)}
\end{align}$$
and in the time-invariant case, we further shorten this to
$$\begin{aligned}
\dot{\mathbf{x}}=\mathbf{A}\mathbf{x}+\mathbf{B}\mathbf{u},\, \qquad  \mathbf{y}=\mathbf{C}x+\mathbf{D}u,\, \qquad  \mathbf{x} \in \mathbb{R}^{n},\, \mathbf{u}\in \mathbb{R}^{k},\, \mathbf{y}\in \mathbb{R}^{m} \\[1ex] (\text{CLTI})
\end{aligned}$$

>[!example] Example: Mass rotating inside a cylinder
>Consider a mass rotating inside a cylinder depicted in the following figure:
>![[Pasted image 20240610134941.png|book|200]]
>[](LSY1_001/Pasted%20image%2020240610134941.png)e moment of inertia $J$, is attached to a torsion spring, whose torsion coefficient is $k_{T}$. An external torque $\tau$ acts on the mass and friction between the mass and the cylinder is assumed to generate a viscous friction torque $\tau_{c}=-c_{T}\dot{\theta}$.
>
>The Newtonian motion equation of the mass is $J\ddot{\theta}=\tau_{\text{net}}$, where $\tau_{\text{net}}$ is the net torque applied to it. In our case,
>$$\tau_{\text{net}}=\tau-k_{T}\theta-c_{T}\dot{\theta}$$
>Hence, we end up with:
>$$\boxed {
\tau(t)=J\ddot{\theta}(t)+c_{T}\dot{\theta}(t)+k_{T}\theta(t)
 }$$
 >which is the relation describing the system $\tau \to\theta$.
 >This is a system of second-order differential equations. To get a state-space representation of the system, we can write a system of first order differential equation which represent the same dynamics of the system as the second order differential equation. After [[../DEQ1/DEQ1_006 משוואות לינאריות הומוגניות מסדר גבוה#אלגוריתם שיטת הורדת הסדר|order reduction]] using the state vector
 >$$\mathbf{x}=\begin{pmatrix}
{x}_{1} \\
{x}_{2}
\end{pmatrix}=\begin{pmatrix}
\theta \\
\dot{\theta} \\
\end{pmatrix}$$ 
>the equations of the system are:
>$$\begin{aligned}
 & \dot{x}_{1}=\dot{\theta}={x}_{2} \\
 & \dot{x}_{2}=\ddot{\theta}=(\tau-k_{T}\theta-c_{T}\dot{\theta}) \dfrac{1}{J}=-\dfrac{k_{T}}{J}{x}_{1}-\dfrac{c_{T}}{J}{x}_{2}+\dfrac{1}{J}\tau
\end{aligned}$$
Our input to the system is $u=\tau$, and we can define the output of system $y$ to be the angle of the massy $y=\theta$. The state-representation of the system will be of the form:
>$$\begin{aligned}
 & \dot{\mathbf{x}}(t)=\mathbf{A} \mathbf{x}+\mathbf{B}\mathbf{u}=\begin{pmatrix}
0 & 1 \\
-k_{T}/J & -c_{T}/J
\end{pmatrix}\mathbf{x}+\begin{pmatrix}
0 \\
1/J
\end{pmatrix}\tau \\[2ex]
 & \mathbf{y}(t)=\mathbf{C}\mathbf{x}+\mathbf{D}\mathbf{u}=\begin{pmatrix}
1 & 0
\end{pmatrix}\mathbf{x}+0\cdot \tau
\end{aligned}$$

## Block Diagrams

It is convenient to represent systems by block diagrams:
![[LSY1_001/Pasted image 20240610124849.png|book]]
>Block diagrams.

The two-port blocks in the figure represent a system with input $u(\cdot)$ and output $y(\cdot)$, where the directions of the arrows specify which is which.


> [!attention] Attention!
> Although not explicitly represented in the diagram, one must keep in mind the existence of the sate, which affect the output through the initial condition.

### Interconnections
Many real systems are built as interconnections of several subsystems. One example is an audio system, which involves the interconnection of a radio receiver, compact disc player, or tape deck with an amplifier and on or more speakers. By viewing such a system as an interconnection of its components, we can use our understanding of the component systems and of how they are interconnected in order to analyze the operation and behavior of the overall system.

In the block diagrams figure, in each case there are two interconnected LTI systems that can be written as
$$\begin{array}{l l l}{{P_{1}:{\dot{\mathbf{x}}}_{1}=\mathbf{A}_{1}\mathbf{\mathbf{x}}_{1}+\mathbf{B}_{1}\mathbf{u}_{1},}}&{{\mathbf{y}_{1}}}{{=\mathbf{C}_{1}\mathbf{x}_{1}+\mathbf{D}_{1}\mathbf{u}_{1},\quad \mathbf{x}\in\mathbb{R}^{n_{1}},\ \mathbf{u}\in\mathbb{R}^{k_{1}},\ \mathbf{y}_{1}\in\mathbb{R}^{m_{1}}}}\\[1ex] {{P_{2}:{\dot{\mathbf{x}}}_{2}=\mathbf{A}_{2}\mathbf{x}_{2}+\mathbf{B}_{2}\mathbf{u}_{2},}}&{{\mathbf{y}_{2}}}{{=\mathbf{C}_{2}\mathbf{x}_{2}+\mathbf{D}_{2}\mathbf{u}_{2},\quad \mathbf{x}\in\mathbb{R}^{n_{2}},\ \mathbf{u}\in\mathbb{R}^{k_{2}},\ \mathbf{y}_{2}\in\mathbb{R}^{m_{2}}}}\end{array}$$
The general procedure to obtain the state-space for an interconnection consists of stacking the states of the individual subsystems in a tall vector $\mathbf{x}$ and computing $\dot{\mathbf{x}}$ using the state and output equation of the individual blocks. The output equation is also obtained from the output equations of the subsystems.

In $(b)$ we have $\mathbf{u}=\mathbf{u}_{1}=\mathbf{u}_{2}$ and $\mathbf{y}=\mathbf{y}_{1}+\mathbf{y}_{2}$, which corresponds to a **parallel interconnection**. This figure represents the LTI system
$$\begin{aligned}
 \begin{pmatrix}
\dot{x}_{1} \\
\dot{x}_{2}
\end{pmatrix}=\dot{\mathbf{x}} & =\begin{pmatrix}
{A}_{1} & 0 \\
0 & {A}_{2}
\end{pmatrix}\begin{pmatrix}
{x}_{1} \\
{x}_{2}
\end{pmatrix}+\begin{pmatrix}
{B}_{1} \\
{B}_{2}
\end{pmatrix}\mathbf{u} \\[2ex]
  \mathbf{y} & =\begin{pmatrix}
{C}_{1} & {C}_{2}
\end{pmatrix}\begin{pmatrix}
{x}_{1} \\
{x}_{2}
\end{pmatrix}+({D}_{1}+{D}_{2})\mathbf{u}
\end{aligned}$$
The parallel interconnection is responsible for the block diagonal structure in the matrix $\begin{pmatrix}{A}_{1} & 0\\0&{A}_{2}  \end{pmatrix}$.

In $(c)$ we have $\mathbf{u}=\mathbf{u}_{1},\,\mathbf{y}=\mathbf{y}_{2}$ and $\mathbf{z}=\mathbf{y}_{1}=\mathbf{u}_{2}$, which corresponds to a **cascade interconnection**. This figure represents the LTI system
$$\begin{aligned}
\begin{pmatrix}
\dot{x}_{1} \\
\dot{x}_{2}
\end{pmatrix}=\dot{\mathbf{x}} & =\begin{pmatrix}
{A}_{1} & 0 \\
{B}_{2}{C}_{1} & {A}_{2}
\end{pmatrix}\begin{pmatrix}
{x}_{1} \\
{x}_{2}
\end{pmatrix}+\begin{pmatrix}
{B}_{1} \\
{B}_{2}{D}_{1}
\end{pmatrix}\mathbf{u} \\[2ex]
\mathbf{y} & =\begin{pmatrix}
{D}_{2}{C}_{1} & {C}_{2}
\end{pmatrix}\begin{pmatrix}
{x}_{1} \\
{x}_{2}
\end{pmatrix}+({D}_{2}{D}_{1})\mathbf{u}
\end{aligned}$$

In $(d)$ we have $\mathbf{u}_{1}=\mathbf{u}-{y}_{1},\,\mathbf{y}=\mathbf{y}_{1}$ which corresponds to a *negative-feedback interconnection*. This figure represents the LTI system
$$\begin{aligned}
\dot{x}_{1} & =({A}_{1}-{B}_{1}(I+{D}_{1})^{-1}{C}_{1}){x}_{1}+{B}_{1}(I-(I+{D}_{1})^{-1}{D}_{1})u \\[1ex]
\mathbf{y} & =(I+{D}_{1})^{-1}{C}_{1}{x}_{1}+(I+{D}_{1})^{-1}{D}_{1}u
\end{aligned}$$

## Standard Systems
- **Gain**  systems map their input $u(\cdot)\in \mathbb{R}$ to the output $y(t)=k\,u(t)\in \mathbb{R},\,\forall t\geq 0$, for some $k\in \mathbb{R}$.
	![[LSY1_001/Pasted image 20240610151833.png|book|400]]
- **Saturation** system map their input $u(\cdot)\in \mathbb{R}$ to the output
	$$y(t)=\begin{cases}
a & u(t)<a \\
u(t) & a\leq  u(t)\leq  b \\
b & u(t)>b
\end{cases}$$
for a given $a<b$. We use the short notation $\mathrm{sat}_{a}:=\mathrm{sat}_{-[a,a]}$ for some $a>0$.
![[LSY1_001/Pasted image 20240610152046.png|book|400]]
- **Integrator** systems map their input $u(\cdot)\in \mathbb{R}$ to the solution $y(\cdot)\in \mathbb{R}$ of $\dot{\mathbf{y}}=\mathbf{u}$, which can also be written as:
	$$y(t)=\int_{-\infty }^{t} u(s) \, \mathrm{d}s $$