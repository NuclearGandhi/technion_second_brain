---
aliases:
  - continuos-time signal
  - discrete-time signal
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
\dfrac{\mathrm{d}}{\mathrm{d}t}s(t)=-bs(t)i(t) & s(0)={s}_{0} & \text{(total population)} \\
\dfrac{\mathrm{d}}{\mathrm{d}t}i(t)=bs(t)i(t)-ai(t) & i(0)=1 & \text{(patient zero, input)} \\
\dfrac{\mathrm{d}}{\mathrm{d}t}r(t)=ai(t) & r(0)=0 & \text{(no deceased/immune} \\
 &  & \text{in the beginning)}
\end{cases}$$
>for some infection rate $b>0$ and recovery rate $a>0$.

# Interconnections of Systems
Many real systems are built as interconnections of several subsystems. One example is an audio system, which involves the interconnection of a radio receiver, compact disc player, or tape deck with an amplifier and on or more speakers. By viewing such a system as an interconnection of its components, we can use our understanding of the component systems and of how they are interconnected in order to analyze the operation and behavior of the overall system.

There are several basic system interconnections, shown in the following **block diagrams**:
![[LSY1_001/Screenshot_20240602_115311_Samsung Notes.jpg|book]]
>Interconnection of two systems: (a) series (cascase) interconnection; (b) parallel interconnection; (c) series-parallel interconnection.


In a **series** or **cascade interconnection** of two systems, the output of System 1 is the input to System 2, and the overall system transforms an input by processing it first by System 1 and then by System 2.
In a **parallel interconnection** of two systems, the same input signal is applied to Systems 1 and 2. The symbol $\oplus$ in the figure denotes addition, so that the output of the parallel interconnection is the sum of the outputs of Systems 1 and 2.

Another important type system interconnection is a **feedback interconnection**, an example of which is illustrated in the following figure:
![[LSY1_001/Screenshot_20240602_120059_Samsung Notes.jpg|book]]
>Feedback interconnection.

Here the output of System 1 is the input to System 2, while the output of System 2 is fed back and added to the external input to produce the actual input to System 1.
