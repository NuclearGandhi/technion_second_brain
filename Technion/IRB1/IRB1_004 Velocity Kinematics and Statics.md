---
aliases:
  - Manipulator Statics
  - Manipulability Ellipsoid
  - Force Ellipsoid
  - Static Equilibrium
  - Joint Torques
  - Manipulator Jacobian
---
from [[IRB1_000 00350001 מבוא לרובוטיקה#ביבליוגרפיה|(Lynch & Park, 2017)]]:

In a previous chapter we saw how to calculate the robot end-effector frame's position and orientation for a given set of joint positions using [[IRB1_002 Forward Kinematics|forward kinematics]]. In this chapter we examine the related problem of calculating the twist of the end-effector of an open chain from a given set of joint positions and velocities.

Before we reach the representation of the end-effector twist as $\mathcal{V} \in \mathbb{R}^6$, let us consider the case where the end-effector configuration is represented by a minimal set of coordinates $\mathbf{x} \in \mathbb{R}^m$ and the velocity is given by $\dot{\mathbf{x}} = d\mathbf{x}/dt \in \mathbb{R}^m$. In this case, the forward kinematics can be written as
$$\mathbf{x}(t) = f(\boldsymbol{\theta}(t))$$
where $\boldsymbol{\theta} \in \mathbb{R}^n$ is a set of joint variables. By the chain rule, the time derivative at time $t$ is
$$\dot{\mathbf{x}} = \frac{\partial f(\boldsymbol{\theta})}{\partial \boldsymbol{\theta}} \frac{d\boldsymbol{\theta}(t)}{dt} = \frac{\partial f(\boldsymbol{\theta})}{\partial \boldsymbol{\theta}} \dot{\boldsymbol{\theta}} = \mathbf{J}(\boldsymbol{\theta})\dot{\boldsymbol{\theta}}$$
where $\mathbf{J}(\boldsymbol{\theta}) \in \mathbb{R}^{m \times n}$ is called the **[[CAL2_011 אינטגרל רב ממדי#מטריצת היעקוביאן|Jacobian]]**. The Jacobian matrix represents the linear sensitivity of the end-effector velocity $\dot{\mathbf{x}}$ to the joint velocity $\dot{\boldsymbol{\theta}}$, and it is a function of the joint variables $\boldsymbol{\theta}$.

To provide a concrete example, consider a $\mathrm{2R}$ planar open chain with forward kinematics given by
$$\begin{aligned}
x_1 &= {L}_{1} \cos \theta_1 + {L}_{2} \cos(\theta_1 + \theta_2) \\
x_2 &= {L}_{1} \sin \theta_1 + {L}_{2} \sin(\theta_1 + \theta_2)
\end{aligned}$$

![[Pasted image 20250607143500.png|bookhue|600]]
>(Left) A $\mathrm{2R}$ robot arm. (Right) Columns 1 and 2 of the Jacobian correspond to the endpoint velocity when $\dot{\theta}_{1}=1$ (and $\dot{\theta}_{2}=0$) and when $\dot{\theta}_{2}=1$ (and $\dot{\theta}_{1}=0$), respectively. [[IRB1_000 00350001 מבוא לרובוטיקה#ביבליוגרפיה|(Lynch & Park, 2017)]].

Differentiating both sides with respect to time yields
$$\begin{aligned}
\dot{x}_1 &= -{L}_{1}\dot{\theta}_1 \sin \theta_1 - {L}_{2}(\dot{\theta}_1 + \dot{\theta}_2) \sin(\theta_1 + \theta_2) \\
\dot{x}_2 &= {L}_{1}\dot{\theta}_1 \cos \theta_1 + {L}_{2}(\dot{\theta}_1 + \dot{\theta}_2) \cos(\theta_1 + \theta_2)
\end{aligned}$$

which can be rearranged into an equation of the form $\dot{\mathbf{x}} = \mathbf{J}(\boldsymbol{\theta})\dot{\boldsymbol{\theta}}$:
$$\begin{pmatrix}
\dot{x}_1 \\
\dot{x}_2
\end{pmatrix} = \begin{pmatrix}
-{L}_{1} \sin \theta_1 - {L}_{2} \sin(\theta_1 + \theta_2) & -{L}_{2} \sin(\theta_1 + \theta_2) \\
{L}_{1} \cos \theta_1 + {L}_{2} \cos(\theta_1 + \theta_2) & {L}_{2} \cos(\theta_1 + \theta_2)
\end{pmatrix} \begin{pmatrix}
\dot{\theta}_1 \\
\dot{\theta}_2
\end{pmatrix} \tag{LP5.1}$$

Writing the two columns of $\mathbf{J}(\boldsymbol{\theta})$ as $\mathbf{J}_1(\boldsymbol{\theta})$ and $\mathbf{J}_2(\boldsymbol{\theta})$, and the tip velocity $\dot{\mathbf{x}}$ as $\mathbf{v}_{\text{tip}}$, Equation $\text{(LP5.1)}$ becomes
$$\mathbf{v}_{\text{tip}} = \mathbf{J}_1(\boldsymbol{\theta})\dot{\theta}_1 + \mathbf{J}_2(\boldsymbol{\theta})\dot{\theta}_2 \tag{LP5.2}$$

As long as $\mathbf{J}_1(\boldsymbol{\theta})$ and $\mathbf{J}_2(\boldsymbol{\theta})$ are not collinear, it is possible to generate a tip velocity $\mathbf{v}_{\text{tip}}$ in any arbitrary direction in the $x_1$–$x_2$-plane by choosing appropriate joint velocities $\dot{\theta}_1$ and $\dot{\theta}_2$. Since $\mathbf{J}_1(\boldsymbol{\theta})$ and $\mathbf{J}_2(\boldsymbol{\theta})$ depend on the joint values $\theta_1$ and $\theta_2$, one may ask whether there are any configurations at which $\mathbf{J}_1(\boldsymbol{\theta})$ and $\mathbf{J}_2(\boldsymbol{\theta})$ become collinear. For our example the answer is yes: if $\theta_2$ is $0°$ or $180°$ then, regardless of the value of $\theta_1$, $\mathbf{J}_1(\boldsymbol{\theta})$ and $\mathbf{J}_2(\boldsymbol{\theta})$ will be collinear and the Jacobian $\mathbf{J}(\boldsymbol{\theta})$ becomes a singular matrix. Such configurations are therefore called **singularities**; they are characterized by a situation where the robot tip is unable to generate velocities in certain directions.

![[{AB038D5C-D001-40F9-9F71-5DA7045BACDE}.png|bookhue|600]]^figure-possible-velocities
>Mapping the set of possible joint velocities, represented as a square in the $\dot{\theta}_1$–$\dot{\theta}_2$ space, through the Jacobian to find the parallelogram of possible end-effector velocities. The extreme points $A$, $B$, $C$, and $D$ in the joint velocity space map to the extreme points $A$, $B$, $C$, and $D$ in the end-effector velocity space. [[IRB1_000 00350001 מבוא לרובוטיקה#ביבליוגרפיה|(Lynch & Park, 2017)]].

Now let's substitute ${L}_{1} = {L}_{2} = 1$ and consider the robot at two different nonsingular postures: $\boldsymbol{\theta} = (0, \pi/4)$ and $\boldsymbol{\theta} = (0, 3\pi/4)$. The Jacobians $\mathbf{J}(\boldsymbol{\theta})$ at these two configurations are
$$\mathbf{J}\begin{pmatrix} 0 \\ \pi/4 \end{pmatrix} = \begin{pmatrix} -0.71 & -0.71 \\ 1.71 & 0.71 \end{pmatrix} \quad \text{and} \quad \mathbf{J}\begin{pmatrix} 0 \\ 3\pi/4 \end{pmatrix} = \begin{pmatrix} -0.71 & -0.71 \\ 0.29 & -0.71 \end{pmatrix}$$

The Jacobian can be used to map bounds on the rotational speed of the joints to bounds on $\mathbf{v}_{\text{tip}}$, as illustrated in the figure above. Rather than mapping a polygon of joint velocities through the Jacobian as in the figure, we could instead map a unit circle of joint velocities in the $\theta_1$–$\theta_2$-plane. This circle represents an "iso-effort" contour in the joint velocity space, where total actuator effort is considered to be the sum of squares of the joint velocities. This circle maps through the Jacobian to an ellipse in the space of tip velocities, and this ellipse is referred to as the **manipulability ellipsoid**. The following figure shows examples of this mapping for the two different postures of the $\mathrm{2R}$ arm. As the manipulator configuration approaches a singularity, the ellipse collapses to a line segment, since the ability of the tip to move in one direction is lost.

![[{DB7ED9D1-6DF5-4D59-BD15-E00C12D0BB69}.png|bookhue|600]]^figure-manipulability-ellipsoids
>Manipulability ellipsoids for two different postures of the $\mathrm{2R}$ planar open chain. [[IRB1_000 00350001 מבוא לרובוטיקה#ביבליוגרפיה|(Lynch & Park, 2017)]].

Using the manipulability ellipsoid one can quantify how close a given posture is to a singularity. For example, we can compare the lengths of the major and minor principal semi-axes of the manipulability ellipsoid, respectively denoted $\ell_{\max}$ and $\ell_{\min}$. The closer the ellipsoid is to a circle, i.e., the closer the ratio $\ell_{\max}/\ell_{\min}$ is to $1$, the more easily can the tip move in arbitrary directions and thus the more removed it is from a singularity.

The Jacobian also plays a central role in static analysis. Suppose that an external force is applied to the robot tip. What are the joint torques required to resist this external force? This question can be answered via a conservation of power argument. Assuming that negligible power is used to move the robot, the power measured at the robot's tip must equal the power generated at the joints. Denoting the tip force vector generated by the robot as $\mathbf{f}_{\text{tip}}$ and the joint torque vector by $\boldsymbol{\tau}$, the [[DYN1_005 קינטיקה של חלקיק#עבודה ואנרגיה של חלקיק|conservation of power]] then requires that
$$\mathbf{f}_{\text{tip}}^T\mathbf{v}_{\text{tip}} = \boldsymbol{\tau}^T\dot{\boldsymbol{\theta}}$$
for all arbitrary joint velocities $\dot{\boldsymbol{\theta}}$. Since $\mathbf{v}_{\text{tip}} = \mathbf{J}(\boldsymbol{\theta})\dot{\boldsymbol{\theta}}$, the equality
$$\mathbf{f}_{\text{tip}}^T\mathbf{J}(\boldsymbol{\theta})\dot{\boldsymbol{\theta}} = \boldsymbol{\tau}^T\dot{\boldsymbol{\theta}}$$
must hold for all possible $\dot{\boldsymbol{\theta}}$. This can only be true if
$$\boldsymbol{\tau} = \mathbf{J}^T(\boldsymbol{\theta})\mathbf{f}_{\text{tip}} \tag{LP5.3}$$

The joint torque $\boldsymbol{\tau}$ needed to create the tip force $\mathbf{f}_{\text{tip}}$ is calculated from the equation above. For our two-link planar chain example, $\mathbf{J}(\boldsymbol{\theta})$ is a square matrix dependent on $\boldsymbol{\theta}$. If the configuration $\boldsymbol{\theta}$ is not a singularity then both $\mathbf{J}(\boldsymbol{\theta})$ and its transpose are invertible, and Equation $\text{(LP5.3)}$ can be written
$$\mathbf{f}_{\text{tip}} = ((\mathbf{J}(\boldsymbol{\theta}))^T)^{-1}\boldsymbol{\tau} = \mathbf{J}^{-T}(\boldsymbol{\theta})\boldsymbol{\tau} \tag{LP5.4}$$

Using the equation above one can now determine, under the same static equilibrium assumption, what input torques are needed to generate a desired tip force, e.g., the joint torques needed for the robot tip to push against a wall with a specified normal force. For a given posture $\boldsymbol{\theta}$ of the robot at equilibrium and a set of joint torque limits such as
$$ \pu{-1 N⋅m} \leq \tau_1 \leq \pu{\pu{1N.m}}, \qquad \pu{-\pu{1N.m}} \leq \tau_2 \leq \pu{\pu{1N.m}}$$
then Equation $\text{(LP5.4)}$ can be used to generate the set of all possible tip forces as indicated in the following figure:

![[{8A5B9510-39CD-43EE-8D9C-727588E3FB7D}.png|bookhue|600]]^figure-joint-torque-bounds
>Mapping joint torque bounds to tip force bounds. [[IRB1_000 00350001 מבוא לרובוטיקה#ביבליוגרפיה|(Lynch & Park, 2017)]].

As for the manipulability ellipsoid, a **force ellipsoid** can be drawn by mapping a unit circle "iso-effort" contour in the $\tau_1$–$\tau_2$-plane to an ellipsoid in the $f_1$–$f_2$ tip-force plane via the Jacobian transpose inverse $\mathbf{J}^{-T}(\boldsymbol{\theta})$ (see Figure 5.5). The force ellipsoid illustrates how easily the robot can generate forces in different directions.

![[{D678E277-CD05-4FC8-8207-A746E94C43FA}.png|bookhue|600]]^figure-force-ellipsoids
>Force ellipsoids for two different postures of the $\mathrm{2R}$ planar open chain. [[IRB1_000 00350001 מבוא לרובוטיקה#ביבליוגרפיה|(Lynch & Park, 2017)]].

As is evident from the manipulability and force ellipsoids, if it is easy to generate a tip velocity in a given direction then it is difficult to generate a force in that same direction, and vice versa (See the following figure). In fact, for a given robot configuration, the principal axes of the manipulability ellipsoid and force ellipsoid are aligned, and the lengths of the principal semi-axes of the force ellipsoid are the reciprocals of the lengths of the principal semi-axes of the manipulability ellipsoid.

![[{4B5F6DAC-8C60-41E1-9978-E79B6D1955E5}.png|bookhue|600]]^figure-manipulability-and-force-ellipsoids
>Left-hand column: Manipulability ellipsoids at two different arm configurations. Right-hand column: The force ellipsoids for the same two arm configurations. [[IRB1_000 00350001 מבוא לרובוטיקה#ביבליוגרפיה|(Lynch & Park, 2017)]].

At a singularity, the manipulability ellipsoid collapses to a line segment. The force ellipsoid, on the other hand, becomes infinitely long in a direction orthogonal to the manipulability ellipsoid line segment (i.e., the direction of the aligned links) and skinny in the orthogonal direction. Consider, for example, carrying a heavy suitcase with your arm. It is much easier if your arm hangs straight down under gravity (with your elbow fully straightened at a singularity), because the force you must support passes directly through your joints, therefore requiring no torques about the joints. Only the joint structure bears the load, not the muscles generating torques. The manipulability ellipsoid loses dimension at a singularity and therefore its area drops to zero, but the force ellipsoid's area goes to infinity (assuming that the joints can support the load!).

In this chapter we present methods for deriving the Jacobian for general open chains, where the configuration of the end-effector is expressed as $\mathbf{T} \in SE(3)$ and its velocity is expressed as a twist $\mathcal{V}$ in the fixed base frame or the end-effector body frame. We also examine how the Jacobian can be used for velocity and static analysis, including identifying kinematic singularities and determining the manipulability and force ellipsoids. Later chapters on inverse kinematics, motion planning, dynamics, and control make extensive use of the Jacobian and related notions introduced in this chapter.

# Manipulator Jacobian

In the $\mathrm{2R}$ planar open chain example, we saw that, for any joint configuration $\boldsymbol{\theta}$, the tip velocity vector $\mathbf{v}_{\text{tip}}$ and joint velocity vector $\dot{\boldsymbol{\theta}}$ are linearly related via the Jacobian matrix $\mathbf{J}(\boldsymbol{\theta})$, i.e., $\mathbf{v}_{\text{tip}} = \mathbf{J}(\boldsymbol{\theta})\dot{\boldsymbol{\theta}}$. The tip velocity $\mathbf{v}_{\text{tip}}$ depends on the coordinates of interest for the tip, which in turn determine the specific form of the Jacobian. For example, in the most general case $\mathbf{v}_{\text{tip}}$ can be taken to be a six-dimensional twist, while, for pure orienting devices such as a wrist, $\mathbf{v}_{\text{tip}}$ is usually taken to be the angular velocity of the end-effector frame. Other choices for $\mathbf{v}_{\text{tip}}$ lead to different formulations for the Jacobian.

We begin with the general case where $\mathbf{v}_{\text{tip}}$ is taken to be a six-dimensional twist $\mathcal{V}$. All the derivations below are mathematical expressions of the same simple idea, embodied in Equation $\text{(LP5.2)}$: given the configuration $\boldsymbol{\theta}$ of the robot, the $6$-vector $\mathbf{J}_i(\boldsymbol{\theta})$, which is column $i$ of $\mathbf{J}(\boldsymbol{\theta})$, is the twist $\mathcal{V}$ when $\dot{\theta}_i = 1$ and all other joint velocities are zero.

For manipulators described using [[IRB1_002 Forward Kinematics#Assigning Link Frames|Denavit-Hartenberg parameters]], the Jacobian can be systematically derived. Each column of the Jacobian corresponds to the end-effector velocity when one joint moves with unit velocity while all other joints remain stationary.

## Jacobian Matrix for D-H Parameters

For an $n$-link open chain described by [[IRB1_002 Forward Kinematics#D-H Parameters|D-H parameters]], the forward kinematics is expressed as:
$$^0\mathbf{T}_n = \,^0\mathbf{T}_1 \,^1\mathbf{T}_2 \cdots ^{n-1}\mathbf{T}_n$$

The Jacobian matrix $\mathbf{J}(\boldsymbol{\theta}) \in \mathbb{R}^{6 \times n}$ relates the joint velocities $\dot{\boldsymbol{\theta}}$ to the end-effector twist $\mathcal{V}$ expressed in the base frame:
$$\mathcal{V} = \mathbf{J}(\boldsymbol{\theta})\dot{\boldsymbol{\theta}} \tag{LP5.5}$$

where $\mathcal{V} = \begin{pmatrix} \mathbf{v} \\ \boldsymbol{\omega} \end{pmatrix}$ is the 6-dimensional twist vector with $\mathbf{v}$ being the linear velocity and $\boldsymbol{\omega}$ being the angular velocity of the end-effector.

### Linear Jacobian Computation - Shortcut

For many applications, especially when dealing with planar manipulators or when only the linear velocity of the end-effector is of interest, there is a more direct approach to compute the linear part of the Jacobian. This shortcut method is based on differentiating the end-effector position vector directly.

From the forward kinematics, the position of the end-effector frame origin is:
$$\mathbf{p}_n = \mathbf{p}_n(q_1, q_2, \ldots, q_n)$$

We differentiate with respect to time using the chain rule:
$$\mathbf{v}_n = \frac{d\mathbf{p}_n}{dt} = \sum_{i=1}^{n} \frac{\partial \mathbf{p}_n}{\partial q_i} \dot{q}_i = \mathbf{J}_L \dot{\boldsymbol{q}}$$

Therefore, the $i$-th column of the linear Jacobian is:
$$\mathbf{J}_{Li} = \frac{\partial \mathbf{p}_n}{\partial q_i}$$

This shortcut is particularly useful for planar manipulators where only the linear motion is relevant, avoiding the need to compute the full $6\times n$ Jacobian.

### Systematic Algorithm for Computing the Jacobian

The systematic approach to compute the Jacobian using D-H parameters follows these steps:

**Step 1: Compute All Transformation Matrices**
For $i = 0, 1, 2, \ldots, n$, compute:
- $^0\mathbf{T}_0 = \mathbf{I}$ (identity matrix for base frame)
- $^0\mathbf{T}_i = \,^0\mathbf{T}_{i-1} \,^{i-1}\mathbf{T}_i$ for $i = 1, 2, \ldots, n$

**Step 2: Extract Frame Information**
From each transformation matrix $^0\mathbf{T}_i$, extract the frame information:
$$^0\mathbf{T}_i = \begin{pmatrix}
\mathbf{R}_i & \mathbf{p}_i \\
\mathbf{0}^T & 1
\end{pmatrix} = \begin{pmatrix}
n_{ix} & s_{ix} & a_{ix} & p_{ix} \\
n_{iy} & s_{iy} & a_{iy} & p_{iy} \\
n_{iz} & s_{iz} & a_{iz} & p_{iz} \\
0 & 0 & 0 & 1
\end{pmatrix}$$

where:
- $\mathbf{z}_i = \begin{pmatrix} a_{ix}  &  a_{iy}  &  a_{iz} \end{pmatrix}^{T}$ is the $z$-axis of frame $i$ expressed in base frame
- $\mathbf{p}_i = \begin{pmatrix} p_{ix}  &  p_{iy}  &  p_{iz} \end{pmatrix}^{T}$ is the position of frame $i$'s origin expressed in base frame

**Step 3: Initialize Base Frame**
For the base frame (frame $0$):
$$\mathbf{z}_0 = \begin{pmatrix} 0 \\ 0 \\ 1 \end{pmatrix}, \quad \mathbf{p}_0 = \begin{pmatrix} 0 \\ 0 \\ 0 \end{pmatrix}$$

**Step 4: Compute Jacobian Columns**
For each joint $i = 1, 2, \ldots, n$:

**Revolute Joint $i$:**
The $i$-th column is:
$$\mathbf{J}_i = \begin{pmatrix} \mathbf{J}_{Li} \\ \mathbf{J}_{Ai} \end{pmatrix} = \begin{pmatrix} \mathbf{z}_{i-1} \times (\mathbf{p}_n - \mathbf{p}_{i-1}) \\ \mathbf{z}_{i-1} \end{pmatrix} \tag{LP5.6}$$

**Prismatic Joint $i$:**
The $i$-th column is:
$$\mathbf{J}_i = \begin{pmatrix} \mathbf{J}_{Li} \\ \mathbf{J}_{Ai} \end{pmatrix} = \begin{pmatrix} \mathbf{z}_{i-1} \\ \mathbf{0} \end{pmatrix} \tag{LP5.7}$$

**Step 5: Assemble the Complete Jacobian**
$$\mathbf{J}(\boldsymbol{\theta}) = \begin{bmatrix} \mathbf{J}_1 & \mathbf{J}_2 & \cdots & \mathbf{J}_n \end{bmatrix} \tag{LP5.8}$$

### Physical Interpretation

Each column $\mathbf{J}_i$ represents the **instantaneous twist** of the end-effector when:
- Joint $i$ moves with unit velocity ($\dot{q}_i = 1$)
- All other joints are stationary ($\dot{q}_j = 0$ for $j \neq i$)

For **revolute joints**:
- $\mathbf{J}_{Li} = \mathbf{z}_{i-1} \times (\mathbf{p}_n - \mathbf{p}_{i-1})$: Linear velocity is tangent to the circle traced by the end-effector around the joint axis
- $\mathbf{J}_{Ai} = \mathbf{z}_{i-1}$: Angular velocity is along the joint axis

For **prismatic joints**:
- $\mathbf{J}_{Li} = \mathbf{z}_{i-1}$: Linear velocity is along the sliding direction
- $\mathbf{J}_{Ai} = \mathbf{0}$: No angular velocity contribution

For a revolute joint, the cross product $\mathbf{z}_{i-1} \times (\mathbf{p}_n - \mathbf{p}_{i-1})$ is computed as:
$$\mathbf{z}_{i-1} \times \mathbf{r}_i = \begin{pmatrix} z_{i-1,x} \\ z_{i-1,y} \\ z_{i-1,z} \end{pmatrix} \times \begin{pmatrix} r_{i,x} \\ r_{i,y} \\ r_{i,z} \end{pmatrix} = \begin{pmatrix} z_{i-1,y} r_{i,z} - z_{i-1,z} r_{i,y} \\ z_{i-1,z} r_{i,x} - z_{i-1,x} r_{i,z} \\ z_{i-1,x} r_{i,y} - z_{i-1,y} r_{i,x} \end{pmatrix}$$

where $\mathbf{r}_i = \mathbf{p}_n - \mathbf{p}_{i-1}$ is the vector from joint $i$ to the end-effector.

# Manipulator Statics

As established earlier in this chapter, the Jacobian matrix plays a central role in static analysis through the fundamental relationship (see Equation $\text{(LP5.3)}$):
$$\boldsymbol{\tau} = \mathbf{J}^T(\boldsymbol{\theta})\mathbf{f}_{\text{tip}}$$

In this section, we extend this analysis to more complex scenarios involving multiple loads, gravity effects, and practical applications.

## Multi-Body Static Analysis

### Superposition Principle

In practice, manipulators must support not only external loads but also their own weight. Using the **principle of superposition**, we can treat each force source separately and sum their contributions:

$$\boldsymbol{\tau}_{\text{total}} = \boldsymbol{\tau}_{\text{external}} + \boldsymbol{\tau}_{\text{gravity}}$$

### Gravity Effects on Links

For each link $i$ with mass $m_i$ and center of mass at position $\mathbf{p}_{c,i}$, the gravitational force contributes:
$$\boldsymbol{\tau}_{\text{gravity,i}} = \mathbf{J}_{L,i}^T(\boldsymbol{\theta}) \mathbf{f}_{g,i}$$

where $\mathbf{f}_{g,i} = m_i \mathbf{g}$ is the gravitational force on link $i$, and $\mathbf{J}_{L,i}(\boldsymbol{\theta})$ is the linear Jacobian computed for the center of mass of link $i$.

>[!notes] Important Considerations:
>- The Jacobian $\mathbf{J}_{L,i}$ for link $i$ considers only the motion of the first $i$ joints
>- The position vector extends to the center of mass of link $i$, not the end-effector
>- Link masses typically act at the geometric center or center of mass of each link

### Force Application Point Considerations

If an external force is not applied at the origin of the end-effector frame, but at a point displaced by vector $\mathbf{r}_0$, the equivalent wrench becomes:

$$\mathcal{F}_{\text{equivalent}} = \begin{pmatrix} \mathbf{f} \\ \boldsymbol{\tau} + \mathbf{r}_0 \times \mathbf{f} \end{pmatrix}$$

## Special Static Configurations

### Zero-Torque Configurations

At certain configurations, it may be possible to support external loads without any joint torques. This occurs when the external wrench lies in the null space of $\mathbf{J}^T(\boldsymbol{\theta})$:
$$\mathbf{J}^T(\boldsymbol{\theta}) \mathcal{F} = \mathbf{0}$$

Such configurations typically correspond to singular poses where the external force/torque is aligned with the lost degrees of freedom.

### Inverse Force Analysis

Using the inverse relationship from Equation $\text{(LP5.4)}$, we can determine external forces from known joint torques:
$$\mathbf{f}_{\text{tip}} = \mathbf{J}^{-T}(\boldsymbol{\theta})\boldsymbol{\tau}$$

This is valid only when $\mathbf{J}(\boldsymbol{\theta})$ is square and non-singular.

# Exercises

## Question 1
The D-H parameters of a manipulator are:

$$\begin{array}{c|cccc}
i & \alpha _{i} & {a}_{i} & {d}_{i} & {\theta}_{i} \\
\hline 1   & 0 & {L}_{1} & 0 & {\theta}_{1} \\
2 & 0 & {L}_{2} & 0 & {\theta}_{2}
\end{array}$$

### Part a
Compute the Jacobian matrix.

**Solution**:
We follow the systematic algorithm from the previous section.

**Step 1: Compute Transformation Matrices**
Using the D-H parameters, we first compute the individual transformations and then the cumulative ones:
$$\begin{aligned}
 & ^0\mathbf{T}_1  = \begin{pmatrix}
c_1 & -s_1 & 0 & {L}_{1} c_1 \\
s_1 & c_1 & 0 & {L}_{1} s_1 \\
0 & 0 & 1 & 0 \\
0 & 0 & 0 & 1
\end{pmatrix} \\[1ex]
 & ^0\mathbf{T}_2 = \,^0\mathbf{T}_1 \,^1\mathbf{T}_2 = \begin{pmatrix}
c_{12} & -s_{12} & 0 & {L}_{1} c_1 + {L}_{2} c_{12} \\
s_{12} & c_{12} & 0 & {L}_{1} s_1 + {L}_{2} s_{12} \\
0 & 0 & 1 & 0 \\
0 & 0 & 0 & 1
\end{pmatrix}
\end{aligned}$$


**Step 2: Extract Frame Information**
From the transformation matrices, we extract:

For frame $0$ (base frame):
$$\mathbf{z}_0 = \begin{pmatrix} 0 \\ 0 \\ 1 \end{pmatrix}, \qquad \mathbf{p}_0 = \begin{pmatrix} 0 \\ 0 \\ 0 \end{pmatrix}$$

For frame $1$:
$$\mathbf{z}_1 = \begin{pmatrix} 0 \\ 0 \\ 1 \end{pmatrix}, \qquad \mathbf{p}_1 = \begin{pmatrix} {L}_{1} c_1 \\ {L}_{1} s_1 \\ 0 \end{pmatrix}$$

For frame $2$ (end-effector):
$$\mathbf{z}_2 = \begin{pmatrix} 0 \\ 0 \\ 1 \end{pmatrix}, \qquad \mathbf{p}_2 = \begin{pmatrix} {L}_{1} c_1 + {L}_{2} c_{12} \\ {L}_{1} s_1 + {L}_{2} s_{12} \\ 0 \end{pmatrix}$$

**Step 3: Compute Jacobian Columns**
For joint $1$ (revolute joint):
Using the formula $\mathbf{J}_1 = \begin{pmatrix} \mathbf{z}_0 \times (\mathbf{p}_2 - \mathbf{p}_0) \\ \mathbf{z}_0 \end{pmatrix}$:

$$\mathbf{r}_1 = \mathbf{p}_2 - \mathbf{p}_0 = \begin{pmatrix} {L}_{1} c_1 + {L}_{2} c_{12} \\ {L}_{1} s_1 + {L}_{2} s_{12} \\ 0 \end{pmatrix}$$
Therefore the linear velocity:
$$\mathbf{J}_{L1} = \mathbf{z}_0 \times \mathbf{r}_1 = \begin{pmatrix} 0 \\ 0 \\ 1 \end{pmatrix} \times \begin{pmatrix} {L}_{1} c_1 + {L}_{2} c_{12} \\ {L}_{1} s_1 + {L}_{2} s_{12} \\ 0 \end{pmatrix} = \begin{pmatrix} -{L}_{1} s_1 - {L}_{2} s_{12} \\ {L}_{1} c_1 + {L}_{2} c_{12} \\ 0 \end{pmatrix}$$

For joint $2$ (revolute joint):
Using the formula $\mathbf{J}_2 = \begin{pmatrix} \mathbf{z}_1 \times (\mathbf{p}_2 - \mathbf{p}_1) \\ \mathbf{z}_1 \end{pmatrix}$:

$$\mathbf{r}_2 = \mathbf{p}_2 - \mathbf{p}_1 = \begin{pmatrix} {L}_{2} c_{12} \\ {L}_{2} s_{12} \\ 0 \end{pmatrix}$$
Therefore the linear velocity:
$$\mathbf{J}_{L2} = \mathbf{z}_1 \times \mathbf{r}_2 = \begin{pmatrix} 0 \\ 0 \\ 1 \end{pmatrix} \times \begin{pmatrix} {L}_{2} c_{12} \\ {L}_{2} s_{12} \\ 0 \end{pmatrix} = \begin{pmatrix} -{L}_{2} s_{12} \\ {L}_{2} c_{12} \\ 0 \end{pmatrix}$$

**Step 4: Assemble the Jacobian**
Since the manipulator is planar (motion restricted to the $x$-$y$ plane), we use the degenerate $2 \times 2$ linear Jacobian:
$$\boxed{\mathbf{J}_L = \begin{pmatrix}
-{L}_{1} s_1 - {L}_{2} s_{12} & -{L}_{2} s_{12} \\
{L}_{1} c_1 + {L}_{2} c_{12} & {L}_{2} c_{12}
\end{pmatrix}}$$

The full $6 \times 2$ Jacobian would be:
$$\mathbf{J} = \begin{pmatrix}
-{L}_{1} s_1 - {L}_{2} s_{12} & -{L}_{2} s_{12} \\
{L}_{1} c_1 + {L}_{2} c_{12} & {L}_{2} c_{12} \\
0 & 0 \\
0 & 0 \\
0 & 0 \\
1 & 1
\end{pmatrix}$$

but for analysis we focus on the linear part since all angular velocities are around the $z$-axis.

**Alternative Solution using the Shortcut Method:**

Since this is a planar manipulator, we can use the linear Jacobian shortcut method. From the forward kinematics, the end-effector position is:
$$\mathbf{p}_2 = \begin{pmatrix} {L}_{1} c_1 + {L}_{2} c_{12} \\ {L}_{1} s_1 + {L}_{2} s_{12} \end{pmatrix}$$

We can compute the linear Jacobian by direct differentiation:
$$\mathbf{J}_{L1} = \frac{\partial \mathbf{p}_2}{\partial \theta_1} = \begin{pmatrix} -{L}_{1} s_1 - {L}_{2} s_{12} \\ {L}_{1} c_1 + {L}_{2} c_{12} \end{pmatrix}$$

$$\mathbf{J}_{L2} = \frac{\partial \mathbf{p}_2}{\partial \theta_2} = \begin{pmatrix} -{L}_{2} s_{12} \\ {L}_{2} c_{12} \end{pmatrix}$$

This gives the same result:
$$\mathbf{J}_L = \begin{pmatrix}
-{L}_{1} s_1 - {L}_{2} s_{12} & -{L}_{2} s_{12} \\
{L}_{1} c_1 + {L}_{2} c_{12} & {L}_{2} c_{12}
\end{pmatrix}$$

### Part b
Compute the singular states of the manipulator, and determine the direction toward which the gripper cannot move in these states.

**Solution**:

Since the linear Jacobian is square, we compute:

$$\begin{aligned}
\det(\mathbf{J}_L)  & = (-{L}_{1} s_1 - {L}_{2} s_{12})({L}_{2} c_{12}) - (-{L}_{2} s_{12})({L}_{1} c_1 + {L}_{2} c_{12}) \\[1ex]
 & = {L}_{2} c_{12}(-{L}_{1} s_1 - {L}_{2} s_{12}) + {L}_{2} s_{12}({L}_{1} c_1 + {L}_{2} c_{12}) \\[1ex]
 & = -{L}_{1} {L}_{2} s_1 c_{12} + {L}_{1} {L}_{2} c_1 s_{12}  \\[1ex]
 & = {L}_{1} {L}_{2} s_{12-1}  \\[1ex]
 & = {L}_{1} {L}_{2} s_2
\end{aligned}$$

The manipulator has singular states when:
$$\boxed{s_2 = 0 \Rightarrow \theta_2 = 0°, 180°, \ldots}$$

For the loss of manipulability direction, consider $\theta_2 = 0$:
$$\mathbf{J}_L = \begin{pmatrix}
-{L}_{1} s_1 - {L}_{2} s_1 & -{L}_{2} s_1 \\
{L}_{1} c_1 + {L}_{2} c_1 & {L}_{2} c_1
\end{pmatrix} = \begin{pmatrix}
-({L}_{1} + {L}_{2}) s_1 & -{L}_{2} s_1 \\
({L}_{1} + {L}_{2}) c_1 & {L}_{2} c_1
\end{pmatrix}$$

To find the loss of manipulability direction, we compute the left null space of $\mathbf{J}_L$:
$$\mathbf{v}^T \mathbf{J}_L = \mathbf{0}$$

This gives us: $\boxed{\mathbf{v} = \begin{pmatrix} c_1 \\ s_1 \end{pmatrix}}$

The loss of manipulability direction is along the radial direction from the base to the end-effector when the arm is fully extended or folded.

## Question 2

The D-H parameters of a manipulator are:

$$\begin{array}{c|cccc}
i & \alpha _{i} & {a}_{i} & {d}_{i} & {\theta}_{i} \\
\hline 1    & 90^{\circ}  & e & h & {\theta}_{1} \\
2 & 90^{\circ}  & 0 & 0 & {\theta}_{2} \\
3 & 0 & 0 & {d}_{3} & 0
\end{array}$$

### Part a
Compute the Jacobian matrix.

**Solution**:
We follow the systematic algorithm step by step.

**Step 1: Compute Transformation Matrices**
First, let's compute each individual D-H transformation:

For joint $1$:
$$^0\mathbf{T}_1  = \begin{pmatrix}
c_1 & 0 & s_1 & e c_1 \\
s_1 & 0 & -c_1 & e s_1 \\
0 & 1 & 0 & h \\
0 & 0 & 0 & 1
\end{pmatrix}$$

For joint $2$:
$$^1\mathbf{T}_2 = \begin{pmatrix}
c_2 & 0 & s_2 & 0 \\
s_2 & 0 & -c_2 & 0 \\
0 & 1 & 0 & 0 \\
0 & 0 & 0 & 1
\end{pmatrix}$$

Now computing $^0\mathbf{T}_2 = \,^0\mathbf{T}_1 \,^1\mathbf{T}_2$:
$$\begin{aligned}
^0\mathbf{T}_2  & = \begin{pmatrix}
c_1 & 0 & s_1 & e c_1 \\
s_1 & 0 & -c_1 & e s_1 \\
0 & 1 & 0 & h \\
0 & 0 & 0 & 1
\end{pmatrix} \begin{pmatrix}
c_2 & 0 & s_2 & 0 \\
s_2 & 0 & -c_2 & 0 \\
0 & 1 & 0 & 0 \\
0 & 0 & 0 & 1
\end{pmatrix}  \\[2ex]
 & = \begin{pmatrix}
c_1 c_2 & s_1 & c_1 s_2 & e c_1 \\
s_1 c_2 & -c_1 & s_1 s_2 & e s_1 \\
s_2 & 0 & -c_2 & h \\
0 & 0 & 0 & 1
\end{pmatrix}
\end{aligned}$$

For joint 3:
$$^2\mathbf{T}_3 = \begin{pmatrix}
1 & 0 & 0 & 0 \\
0 & 1 & 0 & 0 \\
0 & 0 & 1 & d_3 \\
0 & 0 & 0 & 1
\end{pmatrix}$$

We will get:
$$\begin{aligned}
^0\mathbf{T}_3  & = \,^0\mathbf{T}_2 \,^2\mathbf{T}_3  \\[1ex]
 & = \begin{pmatrix}
c_1 c_2 & s_1 & c_1 s_2 & d_3 c_1 s_2 + e c_1 \\
s_1 c_2 & -c_1 & s_1 s_2 & d_3 s_1 s_2 + e s_1 \\
s_2 & 0 & -c_2 & h + d_3 s_2 \\
0 & 0 & 0 & 1
\end{pmatrix}
\end{aligned}$$

**Step 2: Extract Frame Information**
From the transformation matrices:

Frame $0$ (base):
$$\mathbf{z}_0 = \begin{pmatrix} 0 \\ 0 \\ 1 \end{pmatrix}, \quad \mathbf{p}_0 = \begin{pmatrix} 0 \\ 0 \\ 0 \end{pmatrix}$$

Frame $1$:
$$\mathbf{z}_1 = \begin{pmatrix} s_1 \\ -c_1 \\ 0 \end{pmatrix}, \quad \mathbf{p}_1 = \begin{pmatrix} e c_1 \\ e s_1 \\ h \end{pmatrix}$$

Frame $2$:
$$\mathbf{z}_2 = \begin{pmatrix} c_1 s_2 \\ s_1 s_2 \\ -c_2 \end{pmatrix}, \quad \mathbf{p}_2 = \begin{pmatrix} e c_1 \\ e s_1 \\ h \end{pmatrix}$$

Frame $3$ (end-effector):
$$\mathbf{z}_3 = \begin{pmatrix} c_1 s_2 \\ s_1 s_2 \\ -c_2 \end{pmatrix}, \quad \mathbf{p}_3 = \begin{pmatrix} d_3 c_1 s_2 + e c_1 \\ d_3 s_1 s_2 + e s_1 \\ h + d_3 s_2 \end{pmatrix}$$

**Step 3: Compute Jacobian Columns**

For joint 1 (revolute):
$$\mathbf{r}_1 = \mathbf{p}_3 - \mathbf{p}_0 = \begin{pmatrix} d_3 c_1 s_2 + e c_1 \\ d_3 s_1 s_2 + e s_1 \\ h + d_3 s_2 \end{pmatrix}$$
Therefore the linear velocity:
$$\mathbf{J}_{L1} = \mathbf{z}_0 \times \mathbf{r}_1 = \begin{pmatrix} 0 \\ 0 \\ 1 \end{pmatrix} \times \begin{pmatrix} d_3 c_1 s_2 + e c_1 \\ d_3 s_1 s_2 + e s_1 \\ h + d_3 s_2 \end{pmatrix} = \begin{pmatrix} -d_3 s_1 s_2 - e s_1 \\ d_3 c_1 s_2 + e c_1 \\ 0 \end{pmatrix}$$
And the angular velocity:
$$\mathbf{J}_{A1} = \mathbf{z}_0 = \begin{pmatrix} 0 \\ 0 \\ 1 \end{pmatrix}$$

For joint 2 (revolute):
$$\mathbf{r}_2 = \mathbf{p}_3 - \mathbf{p}_1 = \begin{pmatrix} d_3 c_1 s_2 \\ d_3 s_1 s_2 \\ d_3 s_2 \end{pmatrix}$$
Therefore the linear velocity:
$$\mathbf{J}_{L2} = \mathbf{z}_1 \times \mathbf{r}_2 = \begin{pmatrix} s_1 \\ -c_1 \\ 0 \end{pmatrix} \times \begin{pmatrix} d_3 c_1 s_2 \\ d_3 s_1 s_2 \\ d_3 s_2 \end{pmatrix} = \begin{pmatrix} -c_1 d_3 s_2 \\ -s_1 d_3 s_2 \\ d_3 s_2 \end{pmatrix}$$
And the angular velocity:
$$\mathbf{J}_{A2} = \mathbf{z}_1 = \begin{pmatrix} s_1 \\ -c_1 \\ 0 \end{pmatrix}$$

For joint 3 (prismatic):
Since this is a prismatic joint, we use the formula $\mathbf{J}_3 = \begin{pmatrix} \mathbf{z}_2 \\ \mathbf{0} \end{pmatrix}$, meaning:
$$\begin{aligned}
 & \mathbf{J}_{L3} = \mathbf{z}_2 = \begin{pmatrix} c_1 s_2 \\ s_1 s_2 \\ -c_2 \end{pmatrix} \\[1ex]
 & \mathbf{J}_{A3} = \begin{pmatrix} 0 \\ 0 \\ 0 \end{pmatrix}
\end{aligned}$$

**Step 4: Assemble the Complete Jacobian**
$$\boxed{\mathbf{J} = \begin{pmatrix}
-d_3 s_1 s_2 - e s_1 & -c_1 d_3 s_2 & c_1 s_2 \\
d_3 c_1 s_2 + e c_1 & -s_1 d_3 s_2 & s_1 s_2 \\
0 & d_3 s_2 & -c_2 \\
0 & s_1 & 0 \\
0 & -c_1 & 0 \\
1 & 0 & 0
\end{pmatrix}}$$
### Part b

Compute the singular states of the manipulator, and determine the loss of manipulability directions.

**Solution**:
Since the linear Jacobian is square, we compute:
$$\det(\mathbf{J}_L) = d_3^2 s_2 e - d_3^3 s_2 = d_3^2 s_2 (e - d_3)$$

The manipulator has singular states when:
$$\boxed{d_3 = 0 \text{ or } s_2 = 0 \text{ or } d_3 = e}$$

- **Case 1:** $d_3 = 0$
	The loss of manipulability direction is $\mathbf{v} = \begin{pmatrix} 0  &  0  &  1 \end{pmatrix}^{T}$ (vertical direction).

- **Case 2:** $s_2 = 0$ ($\theta_2 = 0°$ or $180°$)
	The loss of manipulability direction is $\mathbf{v} = \begin{pmatrix} -s_1  &  c_1  &  0 \end{pmatrix}^{T}$ (tangential to the base rotation).

- **Case 3:** $d_3 = e$
	This represents a specific geometric configuration where the workspace boundary is reached.

## Question 3

A manipulator with 3 joints (RRP configuration) has:
- Link masses $m_1$, $m_2$, $m_3$ located at the center of each link
- A camera with weight $w$ attached at the end-effector
- Joint variables: $\theta_1$ (revolute), $\theta_2$ (revolute), $d_3$ (prismatic)

![[IRB1_004 Velocity Kinematics and Statics 2025-06-10 08.00.21.excalidraw.svg]]^figure-q3-schema
>RRP manipulator holding a camera.

### Part a
Derive the joint torques $\tau_1$, $\tau_2$, $\tau_3$ required to maintain static equilibrium under gravity.

**Solution**:

For this RRP manipulator, we are given the $6 \times 3$ Jacobian matrix:

$$\mathbf{J} = \begin{pmatrix}
-d_3 s_1 s_2 & c_1 s_2 d_3 & c_1 s_2 \\
d_3 c_1 s_2 & s_1 c_2 d_3 & s_1 s_2 \\
0 & -d_3 s_2 & c_2 \\
0 & -s_1 & 0 \\
0 & c_1 & 0 \\
1 & 0 & 0
\end{pmatrix}$$

The transpose is:
$$\mathbf{J}^T = \begin{pmatrix}
-d_3 s_1 s_2 & d_3 c_1 s_2 & 0 & 0 & 0 & 1 \\
c_1 s_2 d_3 & s_1 c_2 d_3 & -d_3 s_2 & -s_1 & c_1 & 0 \\
c_1 s_2 & s_1 s_2 & c_2 & 0 & 0 & 0
\end{pmatrix}$$

We use the **principle of superposition** to treat each mass separately and sum their contributions.

**For the Camera Load:**
The camera experiences gravitational force $\mathbf{F}_c = \begin{pmatrix} 0  &  0  &  -w  &  0  &  0  &  0 \end{pmatrix}^{T}$ (force only, no torque).

Using the fundamental statics equation:
$$\begin{aligned}
\boldsymbol{\tau}^{(c)}  & = \mathbf{J}^T \mathbf{F}_c  \\[1ex]
 & = \begin{pmatrix}
-d_3 s_1 s_2 & d_3 c_1 s_2 & 0 & 0 & 0 & 1 \\
c_1 s_2 d_3 & s_1 c_2 d_3 & -d_3 s_2 & -s_1 & c_1 & 0 \\
c_1 s_2 & s_1 s_2 & c_2 & 0 & 0 & 0
\end{pmatrix} \begin{pmatrix} 0 \\ 0 \\ -w \\ 0 \\ 0 \\ 0 \end{pmatrix} \\[1ex]
 &  = \begin{pmatrix} 0 \\ -s_2 d_3 w \\ -w c_2 \end{pmatrix}
\end{aligned}$$

**For Link Mass $m_3$:**
Link 3 extends from joint $2$ to distance $d_3$. Its center of mass is at distance $(d_3 - {\ell}_{2})$ from joint $2$, where ${\ell}_{2}$ is the offset length.

We modify the Jacobian by changing the third joint variable from $d_3$ to $(d_3 - {\ell}_{2})$:
$$\mathbf{J}_{m_3}^T = \begin{pmatrix}
-s_1 s_2 (d_3 - {\ell}_{2}) & c_1 s_2 (d_3 - {\ell}_{2}) & 0 & 0 & 0 & 1 \\
c_1 s_2 (d_3 - {\ell}_{2}) & s_1 c_2 (d_3 - {\ell}_{2}) & -(d_3 - {\ell}_{2}) s_2 & -s_1 & c_1 & 0 \\
c_1 s_2 & s_1 s_2 & c_2 & 0 & 0 & 0
\end{pmatrix}$$
Therefore:
$$\boldsymbol{\tau}^{(m_3)} = \mathbf{J}_{m_3}^T \begin{pmatrix} 0 \\ 0 \\ -m_3 g \\ 0 \\ 0 \\ 0 \end{pmatrix} = \begin{pmatrix} 0 \\ s_2 (d_3 - {\ell}_{2}) m_3 g \\ -m_3 g c_2 \end{pmatrix}$$

**For Link Mass $m_2$:**
Link $2$ extends from joint $1$ to joint $2$. Its center of mass is at distance ${\ell}_{1}$ from the base. We shorten the last link from $d_3$ to ${\ell}_{1}$ and remove the third joint row from the Jacobian:

$$\mathbf{J}_{m_2}^T = \begin{pmatrix}
-s_1 s_2 {\ell}_{1} & c_1 s_2 {\ell}_{1} & 0 & 0 & 0 & 1 \\
c_1 s_2 {\ell}_{1} & s_1 c_2 {\ell}_{1} & -{\ell}_{1} s_2 & -s_1 & c_1 & 0
\end{pmatrix}$$
Therefore:
$$\boldsymbol{\tau}^{(m_2)} = \mathbf{J}_{m_2}^T \begin{pmatrix} 0 \\ 0 \\ -m_2 g \\ 0 \\ 0 \\ 0 \end{pmatrix} = \begin{pmatrix} 0 \\ s_2 {\ell}_{1} m_2 g \\ 0 \end{pmatrix}$$

We maintain the dimension by inserting $0$ for the third joint force.

**For Link Mass $m_1$:**
Mass $m_1$ only affects the joints between it and the ground. Since $m_1$ is the first link, it produces no torque about joint $1$. The Jacobian becomes:

$$\mathbf{J}_{m_1}^T = \begin{pmatrix} 0 & 0 & 0 & 0 & 0 & 1 \end{pmatrix}$$
Therefore:
$$\boldsymbol{\tau}^{(m_1)} = \mathbf{J}_{m_1}^T \begin{pmatrix} 0 \\ 0 \\ -m_1 g \\ 0 \\ 0 \\ 0 \end{pmatrix} = \begin{pmatrix} 0 \\ 0 \\ 0 \end{pmatrix}$$

**Superposition - Total External Torques:**
$$\begin{aligned}
\boldsymbol{\tau}_{\text{ext}} &  = \boldsymbol{\tau}^{(c)} + \boldsymbol{\tau}^{(m_3)} + \boldsymbol{\tau}^{(m_2)} + \boldsymbol{\tau}^{(m_1)} \\[2ex]
 & = \begin{pmatrix} 0 \\ -s_2 d_3 w \\ w c_2 \end{pmatrix} + \begin{pmatrix} 0 \\ -s_2 (d_3 - {\ell}_{2}) m_3 g \\ m_3 g c_2 \end{pmatrix} + \begin{pmatrix} 0 \\ -s_2 {\ell}_{1} m_2 g \\ 0 \end{pmatrix} + \begin{pmatrix} 0 \\ 0 \\ 0 \end{pmatrix} \\[2ex]
 & = \begin{pmatrix} 0 \\ -s_2 d_3 w - s_2 {\ell}_{1} m_2 g - s_2 (d_3 - {\ell}_{2}) m_3 g \\ w c_2 + m_3 g c_2 \end{pmatrix}
\end{aligned}$$

**Joint Forces and Torques Required:**
To maintain static equilibrium, the manipulator motors must produce opposite torques and forces:

$$\boxed{\boldsymbol{\tau} = -\boldsymbol{\tau}_{\text{ext}} = \begin{pmatrix} T_1 \\ T_2 \\ F_3 \end{pmatrix} = \begin{pmatrix} 0 \\ s_2 d_3 w + s_2 {\ell}_{1} m_2 g + s_2 (d_3 - {\ell}_{2}) m_3 g \\ -w c_2 - m_3 g c_2 \end{pmatrix}}$$

### Part b
Determine the specific configuration where no motor torques are required.

**Solution**:

For zero joint torques, we need:
$$\mathbf{J}_L^T \mathbf{f}_{\text{total}} = \mathbf{0}$$

This occurs when the total gravitational force is in the null space of $\mathbf{J}_L^T$, which happens at singular configurations.

For the RRP manipulator, singularities typically occur when:
$$\boxed{\theta_2 = \pm 90° \text{ and } d_3 = 0}$$

At this configuration:
- The manipulator is in a singular pose
- The gravitational forces are balanced by the manipulator's structure
- No actuator torques are required

>[!notes] Important Note:
>This configuration represents a kinematic singularity where the manipulator loses degrees of freedom, making precise control difficult.

## Question 4

For a $\mathrm{2R}$ planar manipulator with the following D–H parameters:

$$\begin{array}{c|cccc}
i & \alpha _{i} & {a}_{i} & {d}_{i} & {\theta}_{i} \\
\hline 1    & 270^{\circ}  & 0 & 0 & {\theta}_{1} \\
2 & 0  & 0 &r & 90^{\circ}  \\
\end{array}$$

![[IRB1_004 Velocity Kinematics and Statics 2025-07-04 13.44.06.excalidraw.svg]]
>The given manipulator.

The transformation matrices are given as:
$$\begin{aligned}
 & {}^0\mathbf{T}_1  = \begin{pmatrix}
c_1 & 0 & -s_1 & 0 \\
s_1 & 0 & c_1 & 0 \\
0 & -1 & 0 & 0 \\
0 & 0 & 0 & 1
\end{pmatrix} \\[2ex]
 & {}^0\mathbf{T}_2 = {}^0\mathbf{T}_1 {}^1\mathbf{T}_2 = \begin{pmatrix}
0 & -{c}_{1} & -s_1 & -r{s}_{1} \\
0 & -{s}_{1} & {c}_{1} & r{c}_{1} \\
0 & 0 & 0 & 0 \\
0 & 0 & 0 & 1
\end{pmatrix}
\end{aligned}$$


Given that the manipulator experiences:
- External force $\mathbf{F} = \begin{pmatrix} f_x  &  f_y  &  0 \end{pmatrix}^{T}$ applied to the gripper
- Known joint torques ${T}_{\theta}$ and force ${f}_{r}$.

Compute the applied external force components $f_x$ and $f_y$.

**Solution**:

This is an RP (revolute-prismatic) manipulator. From the given transformation matrices, we can derive the forward kinematics and then compute the Jacobian.

From ${}^0\mathbf{T}_2$, the end-effector position is:
$$\mathbf{p} = \begin{pmatrix} -r s_1 \\ r c_1 \\ 0 \end{pmatrix}$$

The linear Jacobian can be computed using the shortcut method by differentiating the position:
$$\begin{aligned}
\mathbf{J}_{L1} &= \frac{\partial \mathbf{p}}{\partial \theta_1} = \begin{pmatrix} -r c_1 \\ -r s_1 \\ 0 \end{pmatrix} \\[1ex]
\mathbf{J}_{L2} &= \frac{\partial \mathbf{p}}{\partial r} = \begin{pmatrix} -s_1 \\ c_1 \\ 0 \end{pmatrix}
\end{aligned}$$

Therefore, the linear Jacobian is:
$$\mathbf{J}_L = \begin{pmatrix}
-r c_1 & -s_1 \\
-r s_1 & c_1 \\
0 & 0
\end{pmatrix}$$

For a 2D planar case, we use only the first two rows:
$$\mathbf{J}_L = \begin{pmatrix}
-r c_1 & -s_1 \\
-r s_1 & c_1
\end{pmatrix}$$

Using the fundamental statics equation:
$$\boldsymbol{\tau}_{\text{ext}} = \mathbf{J}_L^T \mathbf{F}_L$$

where $\mathbf{F}_L = \begin{pmatrix} f_x \\ f_y \end{pmatrix}$ are the external forces and $\boldsymbol{\tau}_{\text{ext}}$ are the joint torques required to balance them.

The motor torques $\boldsymbol{\tau}_{\text{motor}} = \begin{pmatrix} T_\theta \\ f_r \end{pmatrix}$ act to negate the external forces, so:
$$\boldsymbol{\tau}_{\text{motor}} = -\boldsymbol{\tau}_{\text{ext}}$$

The transpose of the linear Jacobian is:
$$\mathbf{J}_L^T = \begin{pmatrix}
-r c_1 & -r s_1 \\
-s_1 & c_1
\end{pmatrix}$$

To find the external forces from the given motor torques, we compute:
$$\mathbf{F}_L = -(\mathbf{J}_L^T)^{-1} \boldsymbol{\tau}_{\text{motor}}$$

The determinant of $\mathbf{J}_L^T$ is:
$$\begin{aligned}
\det(\mathbf{J}_L^T)  & = (-r c_1)(c_1) - (-r s_1)(-s_1)  \\[1ex]
 & = -r c_1^2 - r s_1^2 \\[1ex]
 &  = -r
\end{aligned}$$

The inverse is:
$$(\mathbf{J}_L^T)^{-1} = \frac{1}{-r} \begin{pmatrix}
c_1 & r s_1 \\
s_1 & -r c_1
\end{pmatrix} = \begin{pmatrix}
-{c}_{1}/r & -s_1 \\
-{s}_{1}/r & c_1
\end{pmatrix}$$

Therefore:
$$\begin{aligned}
\begin{pmatrix} f_x \\ f_y \end{pmatrix}  & = -\begin{pmatrix}
-{c}_{1}/r & -s_1 \\
-{s}_{1}/r & c_1
\end{pmatrix} \begin{pmatrix} T_\theta \\ f_r \end{pmatrix}  \\[2ex]
 & = \begin{pmatrix}
{c}_{1}/r & s_1 \\
{s}_{1}/r & -c_1
\end{pmatrix} \begin{pmatrix} T_\theta \\ f_r \end{pmatrix}
\end{aligned}$$
So we get:
$$\boxed{\begin{aligned}
f_x &= \frac{c_1}{r} T_\theta + s_1 f_r \\[1ex]
f_y &= \frac{s_1}{r} T_\theta - c_1 f_r
\end{aligned}}$$

## Question 5

A $\mathrm{2R}$ planar manipulator with the following Jacobian is holding a weight $mg$ vertically downward at its end-effector.

$$\mathbf{J} = \begin{pmatrix}
-d_3 s_1 s_2 - e s_1 & -c_1 d_3 s_2 & c_1 s_2 \\
d_3 c_1 s_2 + e c_1 & -s_1 d_3 s_2 & s_1 s_2 \\
0 & d_3 s_2 & -c_2 \\
0 & s_1 & 0 \\
0 & -c_1 & 0 \\
1 & 0 & 0
\end{pmatrix}$$

### Part a
Find the configuration where no joint torques are required to support the weight.

**Solution**:
For zero joint torques to support the weight $mg$, we need:
$$\boldsymbol{\tau} = \mathbf{J}^T \mathbf{F} = \mathbf{0}$$

where $\mathbf{F} = \begin{pmatrix} 0 & 0 & -mg & 0 & 0 & 0 \end{pmatrix}^{T}$ is the external wrench (vertical force only).

Using the given Jacobian transpose:
$$\mathbf{J}^T = \begin{pmatrix}
-d_3 s_1 s_2 - e s_1 & d_3 c_1 s_2 + e c_1 & 0 & 0 & 0 & 1 \\
-c_1 d_3 s_2 & -s_1 d_3 s_2 & d_3 s_2 & s_1 & -c_1 & 0 \\
c_1 s_2 & s_1 s_2 & -c_2 & 0 & 0 & 0
\end{pmatrix}$$

Computing $\mathbf{J}^T \mathbf{F}$:
$$\begin{aligned}
\boldsymbol{\tau}  & = \mathbf{J}^T \mathbf{F}  \\[1ex]
 & = \small\begin{pmatrix}
(-d_3 s_1 s_2 - e s_1) \cdot 0 + (d_3 c_1 s_2 + e c_1) \cdot 0 + 0 \cdot (-mg) + 0 \cdot 0 + 0 \cdot 0 + 1 \cdot 0 \\
(-c_1 d_3 s_2) \cdot 0 + (-s_1 d_3 s_2) \cdot 0 + (d_3 s_2) \cdot (-mg) + s_1 \cdot 0 + (-c_1) \cdot 0 + 0 \cdot 0 \\
(c_1 s_2) \cdot 0 + (s_1 s_2) \cdot 0 + (-c_2) \cdot (-mg) + 0 \cdot 0 + 0 \cdot 0 + 0 \cdot 0
\end{pmatrix} \\[1ex]
 & = \begin{pmatrix}
0 \\
-mg d_3 s_2 \\
mg c_2
\end{pmatrix}
\end{aligned}$$

For zero joint torques, we need:
$$\begin{aligned}
\tau_1 &= 0  &  &  \text{(automatically satisfied)} \\[1ex]
\tau_2 &= -mg d_3 s_2 = 0 \\[1ex]
\tau_3 &= mg c_2 = 0
\end{aligned}$$

From $\tau_3 = mg c_2 = 0$:
Since $mg \neq 0$, we need $c_2 = 0$, which means:
$$\boxed{\theta_2 = \pm 90°}$$

From $\tau_2 = -mg d_3 s_2 = 0$:
Since $mg \neq 0$ and $s_2 \neq 0$ when $\theta_2 = \pm 90°$, we need:
$$\boxed{d_3 = 0}$$

Therefore, the configuration where no joint torques are required is:
$$\boxed{\theta_2 = \pm 90° \text{ and } d_3 = 0}$$

### Part b
Explain the physical interpretation of this result.

**Solution**:
The physical interpretation of this zero-torque configuration has several important aspects:

**Geometric Configuration:**
- When $\theta_2 = \pm 90°$, the second joint axis is oriented horizontally
- When $d_3 = 0$, the prismatic joint is fully retracted

**Force Transmission:**
- In this configuration, the gravitational force $mg$ acts vertically downward through the end-effector
- The manipulator's kinematic structure allows this force to be transmitted directly through the mechanical linkages
- No active joint torques are required because the force is supported by the structural elements rather than the actuators

**Singularity Condition:**
- This configuration corresponds to a kinematic singularity of the manipulator
- At singularities, certain directions of motion become impossible, but forces in specific directions can be supported without actuator effort
- The manipulator loses one or more degrees of freedom in this pose

**Physical Analogy:**
- This is similar to holding a heavy object with your arm fully extended vertically - the weight is supported by bone structure rather than muscle effort
- The gravitational force passes through the joint axes, creating no moments about those joints

**Practical Implications:**
- While this configuration requires no actuator torques, it represents a loss of manipulability
- The manipulator cannot generate motion in certain directions from this pose
- This configuration might be useful for energy-efficient load holding but problematic for precise manipulation tasks

>[!notes] Engineering Consideration:
>Although no actuator torques are required, the mechanical structure must still support the compressive or tensile loads. This configuration is useful for energy conservation but limits the manipulator's motion capabilities.
