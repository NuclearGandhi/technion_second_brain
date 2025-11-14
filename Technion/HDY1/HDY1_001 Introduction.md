---
aliases:
---

# Introduction to Hybrid Dynamical Systems

## What is a Hybrid Dynamical System?

>[!def] Definition:
>Hybrid dynamical systems contain heterogeneous dynamics that interact with each other and jointly determine the systems' behaviors over time. These include:
>- **Time-driven continuous-variable dynamics**: governed by physical laws, described by differential equations.
>- **Event-driven discrete-variable dynamics**: depend on "if-then-else" rules.

These two kinds of dynamics interact to generate complex behaviors such as switching when continuous variables pass thresholds and state jumping upon discrete events.

>[!example] Room Temperature Control System:
>A typical winter heating system with a thermostat set to 70°F demonstrates hybrid dynamics:
>- **Continuous dynamics**: furnace and heat flow characteristics of the room
>- **Discrete dynamics**: thermostat with "ON" and "OFF" states
>- **Interaction**: discrete state transitions are triggered by room temperature, while temperature evolution depends on the discrete state

Hybrid systems appear in many applications: manufacturing systems, chemical plants, traffic management, power grids, communication systems, and multi-robot control. They are also found in natural systems like gene regulatory networks where translation/transcription processes are continuous but gene activation is discrete.

# Lagrange Mechanics
See [[DVI1_001 מושגי יסוד ומכניקת לגראנז'#מכניקה לגראנז'ית|מכניקה לגראנז'ית]].

# Locomotion of Under-Actuated Robots

In mobile robots, the vectors of coordinates can typically be decomposed into $\mathbf{q}=[\mathbf{q}_{b},\,\mathbf{q}_{s}]^{T}$, where $\mathbf{q}_{b}\in \mathbb{R}^{{n}_{b}}$ are **body coordinates** describing position and orientation of a moving reference frame attached to the robot's main body, while $\mathbf{q}_{s}\in \mathbb{R}^{{n}_{s}}$ represent **shape coordinates**, for example internal joint angles. The mobile robot is an **under-actuated** system where the shape coordinates are controlled while the body coordinates are not directly actuated and are only affected passively and indirectly by actuation of the shape variables. The matrix equations of motion can be decomposed into sub-blocks as

$$\left[\begin{array}{c}
{\mathbf{M}}_{bb} & {\mathbf{M}}_{bs} \\
\hline {{\mathbf{M}_{bs}}}^{T} & \mathbf{M}_{ss}
\end{array}\right]\left[\begin{array}{c}
\ddot{\mathbf{q}}_{b} \\
\hline \ddot{\mathbf{q}}_{s}
\end{array}\right]+\left[\begin{array}{c}
\mathbf{B}_{b}(\mathbf{q},\,\dot{\mathbf{q}}) \\
\hline \mathbf{B}_{s}(\mathbf{q},\,\dot{\mathbf{q}})
\end{array}\right]+\left[\begin{array}{c}
\mathbf{G}_{b}(\mathbf{q}) \\
\hline \mathbf{G}_{s}(\mathbf{q})
\end{array}\right]=\left[\begin{array}{c}
\mathbf{0} \\
\hline \mathbf{F}_{\mathbf{q}_{s}}
\end{array}\right]\tag{1.1}$$

Where:
- $\mathbf{M}_{bb}$: mass matrix coupling body coordinates to body accelerations
- $\mathbf{M}_{bs}$: mass matrix coupling shape coordinates to body accelerations
- $\mathbf{M}_{ss}$: mass matrix coupling shape coordinates to shape accelerations
- $\mathbf{B}_{b}(\mathbf{q},\,\dot{\mathbf{q}})$: nonlinear velocity-dependent terms (Coriolis and centrifugal forces) for body coordinates
- $\mathbf{B}_{s}(\mathbf{q},\,\dot{\mathbf{q}})$: nonlinear velocity-dependent terms for shape coordinates
- $\mathbf{G}_{b}(\mathbf{q})$: gravitational and conservative forces on body coordinates
- $\mathbf{G}_{s}(\mathbf{q})$: gravitational and conservative forces on shape coordinates
- $\mathbf{F}_{\mathbf{q}_{s}}$: vector of actuation forces/torques at the joints of shape variables

The un-actuated body coordinates are not associated with generalized forces. System of the form $\text{(1.1)}$ is called **DAE** – Differential Algebraic Equation.

A common assumption is that the shape variables are directly controlled/prescribed, that is, $\mathbf{q}_{s}=\mathbf{q}_{s}(t)$. In such case the system in $\text{(1.1)}$ can be rearranged as:

$$\left[\begin{array}{c}
\mathbf{M}_{bb} & \mathbf{0} \\
\hline \mathbf{M}_{bs}^{T} & \mathbf{I}
\end{array}\right]\left[\begin{array}{c}
\ddot{\mathbf{q}}_{b} \\
\hline \mathbf{F}_{\mathbf{q}_{s}}
\end{array}\right]=\left[\begin{array}{c}
-\mathbf{M}_{bs}\ddot{\mathbf{q}}_{s}-\mathbf{B}_{b}-\mathbf{G}_{b} \\
\hline -\mathbf{M}_{ss}\ddot{\mathbf{q}}_{s}-\mathbf{B}_{s}-\mathbf{G}_{s}
\end{array}\right]\tag{1.2}$$

Note that the right hand side of $\text{(1.2)}$ contains only known quantities – the shape variables $\mathbf{q}_{s}$ and their derivatives, as well as body positions and velocities. Thus, the upper part of $\text{(1.2)}$ is a second order ODE for the body motion $\mathbf{q}_{b}$. The lower part of $\text{(1.2)}$ is an algebraic equation that enables extraction of the actuation forces/torques $\mathbf{F}_{\mathbf{q}_{s}}$ as a function of $\mathbf{q},\,\dot{\mathbf{q}},\,\ddot{\mathbf{q}}$. In this case one can also obtain a state equation where the state vector contains body motion only $\mathbf{z}=[\mathbf{z}_{1},\,\mathbf{z}_{2}]^{T}=[\mathbf{q}_{b},\,\dot{\mathbf{q}}_{b}]^{T}$.
