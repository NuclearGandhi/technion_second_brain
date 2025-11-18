---
aliases:
- Manipulator Dynamics
- Forward Dynamics
- Inverse Dynamics
- Lagrangian Robotics
- Mass Matrix
- Coriolis Forces
- Centripetal Forces
---

from [[IRB1_000 00350001 מבוא לרובוטיקה#ביבליוגרפיה|(Lynch & Park, 2017)]]:

In this chapter we study once again the motions of open-chain robots, but this time taking into account the forces and torques that cause them; this is the subject of robot dynamics. The associated dynamic equations – also referred to as the equations of motion – are a set of second-order differential equations of the form

$$\boldsymbol{\tau} = \mathbf{M}(\boldsymbol{\theta})\ddot{\boldsymbol{\theta}} + \mathbf{h}(\boldsymbol{\theta}, \dot{\boldsymbol{\theta}}) \tag{LP8.1}$$

where $\boldsymbol{\theta} \in \mathbb{R}^n$ is the vector of joint variables, $\boldsymbol{\tau} \in \mathbb{R}^n$ is the vector of joint forces and torques, $\mathbf{M}(\boldsymbol{\theta}) \in \mathbb{R}^{n \times n}$ is a symmetric positive-definite mass matrix, and $\mathbf{h}(\boldsymbol{\theta}, \dot{\boldsymbol{\theta}}) \in \mathbb{R}^n$ are forces that lump together centripetal, Coriolis, gravity, and friction terms that depend on $\boldsymbol{\theta}$ and $\dot{\boldsymbol{\theta}}$.

One should not be deceived by the apparent simplicity of these equations; even for "simple" open chains, e.g., those with joint axes that are either orthogonal or parallel to each other, $\mathbf{M}(\boldsymbol{\theta})$ and $\mathbf{h}(\boldsymbol{\theta}, \dot{\boldsymbol{\theta}})$ can be extraordinarily complex.

Just as a distinction was made between a robot's [[IRB1_002 Forward Kinematics|forward]] and [[IRB1_003 Inverse Kinematics|inverse kinematics]], it is also customary to distinguish between a robot's **forward** and **inverse dynamics**.

**Forward Dynamics Problem:** Determining the robot's acceleration $\ddot{\boldsymbol{\theta}}$ given the state $(\boldsymbol{\theta}, \dot{\boldsymbol{\theta}})$ and the joint forces and torques:

$$\ddot{\boldsymbol{\theta}} = \mathbf{M}^{-1}(\boldsymbol{\theta})(\boldsymbol{\tau} - \mathbf{h}(\boldsymbol{\theta}, \dot{\boldsymbol{\theta}})) \tag{LP8.2}$$

**Inverse Dynamics Problem:** Finding the joint forces and torques $\boldsymbol{\tau}$ corresponding to the robot's state and a desired acceleration, i.e., Equation $\text{(LP8.1)}$.

A robot's dynamic equations are typically derived in one of two ways:
1. **Newton–Euler formulation**: Direct application of Newton's and Euler's dynamic equations for a rigid body
2. **Lagrangian dynamics formulation**: Derived from the kinetic and potential energy of the robot

The Lagrangian formalism is conceptually elegant and quite effective for robots with simple structures, e.g., with three or fewer degrees of freedom. For general open chains, the Newton–Euler formulation leads to efficient recursive algorithms for both the inverse and forward dynamics.

# Lagrangian Formulation

## Basic Concepts

As developed in [[DVI1_001 מושגי יסוד ומכניקת לגראנז'#משוואות אויילר-לגראנז'|Lagrangian mechanics]], the Lagrangian approach for manipulator dynamics follows these steps:

1. **Choose generalized coordinates** $\mathbf{q} \in \mathbb{R}^n$ that describe the system's configuration
2. **Define the Lagrangian function** as:
   $$L(\mathbf{q}, \dot{\mathbf{q}}) = T(\mathbf{q}, \dot{\mathbf{q}}) - V(\mathbf{q}) $$
   where $T$ is kinetic energy and $V$ is potential energy
3. **Apply the Euler-Lagrange equations**:
   $$\boldsymbol{\tau} = \frac{\mathrm{d}}{\mathrm{d}t}\left(\frac{\partial L}{\partial \dot{\mathbf{q}}}\right) - \frac{\partial L}{\partial \mathbf{q}} \tag{LP8.3}$$

For manipulators, the generalized coordinates are typically the joint variables $\mathbf{q} = \boldsymbol{\theta}$, and the generalized forces are the joint torques $\boldsymbol{\tau}$, since $\boldsymbol{\tau}^T\dot{\boldsymbol{\theta}}$ corresponds to power.

Consider a planar 2R open chain moving in the presence of gravity, as shown in the following figure. The chain moves in the $x$–$y$-plane, with gravity $g$ acting in the $-y$-direction.

![[{71F9C757-6CA5-4541-8F2E-D792CBEE0D35}.png|bookhue|600]]^figure-2r-gravity
>(Left) A $\mathrm{2R}$ open chain under gravity. (Right) At $\theta = (0, \pi/2)$. [[IRB1_000 00350001 מבוא לרובוטיקה#ביבליוגרפיה|(Lynch & Park, 2017)]].

To keep things simple, the two links are modeled as point masses $m_1$ and $m_2$ concentrated at the ends of each link.

**Position and Velocity Analysis:**

The position and velocity of the link-$1$ mass:
$$\begin{pmatrix} x_1 \\ y_1 \end{pmatrix} = \begin{pmatrix} L_1 \cos \theta_1 \\ L_1 \sin \theta_1 \end{pmatrix}, \quad \begin{pmatrix} \dot{x}_1 \\ \dot{y}_1 \end{pmatrix} = \begin{pmatrix} -L_1 \sin \theta_1 \\ L_1 \cos \theta_1 \end{pmatrix} \dot{\theta}_1$$

The position and velocity of the link-$2$ mass:
$$\begin{aligned}
 & \begin{pmatrix} x_2 \\ y_2 \end{pmatrix} = \begin{pmatrix} L_1 \cos \theta_1 + L_2 \cos(\theta_1 + \theta_2) \\ L_1 \sin \theta_1 + L_2 \sin(\theta_1 + \theta_2) \end{pmatrix} \\[3ex]
 & \begin{pmatrix} \dot{x}_2 \\ \dot{y}_2 \end{pmatrix} = \begin{pmatrix} -L_1 \sin \theta_1 - L_2 \sin(\theta_1 + \theta_2) & -L_2 \sin(\theta_1 + \theta_2) \\ L_1 \cos \theta_1 + L_2 \cos(\theta_1 + \theta_2) & L_2 \cos(\theta_1 + \theta_2) \end{pmatrix} \begin{pmatrix} \dot{\theta}_1 \\ \dot{\theta}_2 \end{pmatrix}
\end{aligned}$$


**Energy Analysis:**

The kinetic energy terms:
$$\begin{aligned}
T_1 &= \frac{1}{2}m_1(\dot{x}_1^2 + \dot{y}_1^2) = \frac{1}{2}m_1 L_1^2 \dot{\theta}_1^2 \\[3ex]
T_2 &= \frac{1}{2}m_2(\dot{x}_2^2 + \dot{y}_2^2) \\[1ex]
&= \frac{1}{2}m_2\left[(L_1^2 + 2L_1 L_2 \cos \theta_2 + L_2^2)\dot{\theta}_1^2 + 2(L_2^2 + L_1 L_2 \cos \theta_2)\dot{\theta}_1 \dot{\theta}_2 + L_2^2 \dot{\theta}_2^2\right]
\end{aligned}$$

The potential energy terms:
$$\begin{aligned}
V_1 &= m_1 g y_1 = m_1 g L_1 \sin \theta_1 \\[1ex]
V_2 &= m_2 g y_2 = m_2 g(L_1 \sin \theta_1 + L_2 \sin(\theta_1 + \theta_2))
\end{aligned}$$

**Dynamic Equations:**

Applying the Euler-Lagrange equations $\text{(LP8.3)}$ and gathering terms into the standard form:

$$\boldsymbol{\tau} = \mathbf{M}(\boldsymbol{\theta})\ddot{\boldsymbol{\theta}} + \underbrace{ \mathbf{c}(\boldsymbol{\theta}, \dot{\boldsymbol{\theta}}) + \mathbf{g}(\boldsymbol{\theta}) }_{ \mathbf{h}(\boldsymbol{\theta},\dot{\boldsymbol{\theta}}) } \tag{LP8.10}$$

where:

**Mass Matrix:**
$$\mathbf{M}(\boldsymbol{\theta}) = \begin{pmatrix}
m_1 L_1^2 + m_2(L_1^2 + 2L_1 L_2 \cos \theta_2 + L_2^2) & m_2(L_1 L_2 \cos \theta_2 + L_2^2) \\
m_2(L_1 L_2 \cos \theta_2 + L_2^2) & m_2 L_2^2
\end{pmatrix}$$

**Coriolis and Centripetal Terms:**
$$\mathbf{c}(\boldsymbol{\theta}, \dot{\boldsymbol{\theta}}) = \begin{pmatrix}
-m_2 L_1 L_2 \sin \theta_2 (2\dot{\theta}_1 \dot{\theta}_2 + \dot{\theta}_2^2) \\
m_2 L_1 L_2 \dot{\theta}_1^2 \sin \theta_2
\end{pmatrix}$$

**Gravitational Terms:**
$$\mathbf{g}(\boldsymbol{\theta}) = \begin{pmatrix}
(m_1 + m_2)L_1 g \cos \theta_1 + m_2 g L_2 \cos(\theta_1 + \theta_2) \\
m_2 g L_2 \cos(\theta_1 + \theta_2)
\end{pmatrix}$$

The complete equations of motion are:
$$\begin{aligned}
\tau_1 &= (m_1 L_1^2 + m_2(L_1^2 + 2L_1 L_2 \cos \theta_2 + L_2^2))\ddot{\theta}_1 \\
&\quad + m_2(L_1 L_2 \cos \theta_2 + L_2^2)\ddot{\theta}_2 - m_2 L_1 L_2 \sin \theta_2(2\dot{\theta}_1 \dot{\theta}_2 + \dot{\theta}_2^2) \\
&\quad + (m_1 + m_2)L_1 g \cos \theta_1 + m_2 g L_2 \cos(\theta_1 + \theta_2) \\[2ex]
\tau_2 &= m_2(L_1 L_2 \cos \theta_2 + L_2^2)\ddot{\theta}_1 + m_2 L_2^2 \ddot{\theta}_2 + m_2 L_1 L_2 \dot{\theta}_1^2 \sin \theta_2 \\
&\quad + m_2 g L_2 \cos(\theta_1 + \theta_2)
\end{aligned} \tag{LP8.9}$$

The equations reveal that the equations of motion are:
- **Linear** in $\ddot{\boldsymbol{\theta}}$ (accelerations)
- **Quadratic** in $\dot{\boldsymbol{\theta}}$ (velocities) 
- **Trigonometric** in $\boldsymbol{\theta}$ (positions)

This is true in general for serial chains containing revolute joints.

Joint coordinates $(\theta_1, \theta_2)$ are not in an inertial frame, so accelerations contain terms that are quadratic in joint velocities:

- **Centripetal terms**: Containing $\dot{\theta}_i^2$ - arise from rotation of individual joints
- **Coriolis terms**: Containing $\dot{\theta}_i \dot{\theta}_j$ $(i \neq j)$ - arise from interaction between joint motions

>[!notes] Important Insight:
>$\ddot{\boldsymbol{\theta}} = 0$ does not mean zero acceleration of the link masses, due to the centripetal and Coriolis terms.

Consider the arm at configuration $(\theta_1, \theta_2) = (0, \pi/2)$. Assuming $\ddot{\boldsymbol{\theta}} = 0$, the acceleration of $m_2$ can be written as:

$$\begin{pmatrix} \ddot{x}_2 \\ \ddot{y}_2 \end{pmatrix} = \underbrace{\begin{pmatrix} -L_1 \dot{\theta}_1^2 \\ -L_2 \dot{\theta}_1^2 - L_2 \dot{\theta}_2^2 \end{pmatrix}}_{\text{centripetal terms}} + \underbrace{\begin{pmatrix} 0 \\ -2L_2 \dot{\theta}_1 \dot{\theta}_2 \end{pmatrix}}_{\text{Coriolis terms}}$$

![[{9F998493-6322-4C5E-AA01-61CA14E91014}.png|bookhue|600]]^figure-centripetal-coriolis
>Accelerations of $m_2$ when $\boldsymbol{\theta} = (0, \pi/2)$ and $\ddot{\boldsymbol{\theta}} = 0$. (Left) The centripetal acceleration when $\dot{\theta}_2 = 0$. (Middle) The centripetal acceleration when $\dot{\theta}_1 = 0$. (Right) When both joints are rotating, the acceleration includes Coriolis effects. [[IRB1_000 00350001 מבוא לרובוטיקה#ביבליוגרפיה|(Lynch & Park, 2017)]].

**Physical meaning:**
- **Centripetal accelerations** pull $m_2$ toward each joint center to maintain circular motion
- **Coriolis acceleration** arises from the interaction between joint motions - as joint 2 rotates, $m_2$ gets closer to joint 1, reducing its moment of inertia about joint 1

## Understanding the Mass Matrix

The kinetic energy $\frac{1}{2} \dot{\boldsymbol{\theta}}^T\mathbf{M}(\boldsymbol{\theta})\dot{\boldsymbol{\theta}}$ is a generalization of the familiar expression $\frac{1}{2} mv^Tv$ for a point mass. The fact that the mass matrix $\mathbf{M}(\boldsymbol{\theta})$ is positive definite, meaning that $\dot{\boldsymbol{\theta}}^T\mathbf{M}(\boldsymbol{\theta})\dot{\boldsymbol{\theta}} > 0$ for all $\dot{\boldsymbol{\theta}} \neq 0$, is a generalization of the fact that the mass of a point mass is always positive, $m > 0$. In both cases, if the velocity is nonzero, the kinetic energy must be positive.

On the one hand, for a point mass with dynamics expressed in Cartesian coordinates as $\mathbf{f} = m\ddot{\mathbf{x}}$, the mass is independent of the direction of acceleration, and the acceleration $\ddot{\mathbf{x}}$ is always "parallel" to the force, in the sense that $\ddot{\mathbf{x}}$ is a scalar multiple of $\mathbf{f}$. A mass matrix $\mathbf{M}(\boldsymbol{\theta})$, on the other hand, presents a different effective mass in different acceleration directions, and $\ddot{\boldsymbol{\theta}}$ is not generally a scalar multiple of $\boldsymbol{\tau}$ even when $\dot{\boldsymbol{\theta}} = 0$.

To visualize the direction dependence of the effective mass, we can map a unit ball of joint accelerations $\{\ddot{\boldsymbol{\theta}} | \ddot{\boldsymbol{\theta}}^T\ddot{\boldsymbol{\theta}} = 1\}$ through the mass matrix $\mathbf{M}(\boldsymbol{\theta})$ to generate a joint force–torque ellipsoid when the mechanism is at rest ($\dot{\boldsymbol{\theta}} = 0$).

![[{D9B890EF-B7F6-41EC-BD4A-2FE74EAC977F}.png|bookhue|600]]^figure-mass-ellipsoids
>(Bold lines) A unit ball of accelerations in $\ddot{\boldsymbol{\theta}}$ maps through the mass matrix $\mathbf{M}(\boldsymbol{\theta})$ to a torque ellipsoid that depends on the configuration of the 2R arm. These torque ellipsoids may be interpreted as mass ellipsoids. The mapping is shown for two arm configurations: $(0°, 90°)$ and $(0°, 150°)$. (Dotted lines) A unit ball in $\boldsymbol{\tau}$ maps through $\mathbf{M}^{-1}(\boldsymbol{\theta})$ to an acceleration ellipsoid. [[IRB1_000 00350001 מבוא לרובוטיקה#ביבליוגרפיה|(Lynch & Park, 2017)]].

The torque ellipsoid can be interpreted as a direction-dependent mass ellipsoid: the same joint acceleration magnitude $\|\ddot{\boldsymbol{\theta}}\|$ requires different joint torque magnitudes $\|\boldsymbol{\tau}\|$ depending on the acceleration direction. The directions of the principal axes of the mass ellipsoid are given by the eigenvectors $\mathbf{v}_i$ of $\mathbf{M}(\boldsymbol{\theta})$ and the lengths of the principal semi-axes are given by the corresponding eigenvalues $\lambda_i$. The acceleration $\ddot{\boldsymbol{\theta}}$ is only a scalar multiple of $\boldsymbol{\tau}$ when $\boldsymbol{\tau}$ is along a principal axis of the ellipsoid.

It is easier to visualize the mass matrix if it is represented as an effective mass of the end-effector, since it is possible to feel this mass directly by grabbing and moving the end-effector. If you grabbed the endpoint of the 2R robot, depending on the direction you applied force to it, how massy would it feel?

Let us denote the effective mass matrix at the end-effector as $\boldsymbol{\Lambda}(\boldsymbol{\theta})$, and the velocity of the end-effector as $\mathbf{V} = (\dot{x}, \dot{y})$. We know that the kinetic energy of the robot must be the same regardless of the coordinates we use, so

$$\frac{1}{2} \dot{\boldsymbol{\theta}}^T\mathbf{M}(\boldsymbol{\theta})\dot{\boldsymbol{\theta}} = \frac{1}{2} \mathbf{V}^T\boldsymbol{\Lambda}(\boldsymbol{\theta})\mathbf{V} \tag{LP8.20}$$

Assuming the Jacobian $\mathbf{J}(\boldsymbol{\theta})$ satisfying $\mathbf{V} = \mathbf{J}(\boldsymbol{\theta})\dot{\boldsymbol{\theta}}$ is invertible, Equation $\text{(LP8.20)}$ can be rewritten as follows:

$$\begin{aligned}
\mathbf{V}^T\boldsymbol{\Lambda}\mathbf{V} &= (\mathbf{J}^{-1}\mathbf{V})^T\mathbf{M}(\mathbf{J}^{-1}\mathbf{V}) \\[1ex]
&= \mathbf{V}^T(\mathbf{J}^{-T}\mathbf{M}\mathbf{J}^{-1})\mathbf{V}
\end{aligned}$$

In other words, the end-effector mass matrix is

$$\boldsymbol{\Lambda}(\boldsymbol{\theta}) = \mathbf{J}^{-T}(\boldsymbol{\theta})\mathbf{M}(\boldsymbol{\theta})\mathbf{J}^{-1}(\boldsymbol{\theta}) \tag{LP8.21}$$

The endpoint acceleration $(\ddot{x}, \ddot{y})$ is a scalar multiple of the force $(f_x, f_y)$ applied at the endpoint only if the force is along a principal axis of the ellipsoid. Unless $\boldsymbol{\Lambda}(\boldsymbol{\theta})$ is of the form $cI$, where $c > 0$ is a scalar and $I$ is the identity matrix, the mass at the endpoint feels different from a point mass.

>[!info] Important Note:
>The ellipsoidal interpretations of the relationship between forces and accelerations defined here are only relevant at zero velocity, where there are no Coriolis or centripetal terms.


