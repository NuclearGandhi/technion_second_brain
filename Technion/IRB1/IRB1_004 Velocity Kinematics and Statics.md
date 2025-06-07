---
aliases:
- Velocity Kinematics
- Manipulability Ellipsoid
- Force Ellipsoid
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
\end{pmatrix} \tag{5.1}$$

Writing the two columns of $\mathbf{J}(\boldsymbol{\theta})$ as $\mathbf{J}_1(\boldsymbol{\theta})$ and $\mathbf{J}_2(\boldsymbol{\theta})$, and the tip velocity $\dot{\mathbf{x}}$ as $\mathbf{v}_{\text{tip}}$, Equation $\text{(5.1)}$ becomes
$$\mathbf{v}_{\text{tip}} = \mathbf{J}_1(\boldsymbol{\theta})\dot{\theta}_1 + \mathbf{J}_2(\boldsymbol{\theta})\dot{\theta}_2 \tag{5.2}$$

As long as $\mathbf{J}_1(\boldsymbol{\theta})$ and $\mathbf{J}_2(\boldsymbol{\theta})$ are not collinear, it is possible to generate a tip velocity $\mathbf{v}_{\text{tip}}$ in any arbitrary direction in the $x_1$–$x_2$-plane by choosing appropriate joint velocities $\dot{\theta}_1$ and $\dot{\theta}_2$. Since $\mathbf{J}_1(\boldsymbol{\theta})$ and $\mathbf{J}_2(\boldsymbol{\theta})$ depend on the joint values $\theta_1$ and $\theta_2$, one may ask whether there are any configurations at which $\mathbf{J}_1(\boldsymbol{\theta})$ and $\mathbf{J}_2(\boldsymbol{\theta})$ become collinear. For our example the answer is yes: if $\theta_2$ is $0°$ or $180°$ then, regardless of the value of $\theta_1$, $\mathbf{J}_1(\boldsymbol{\theta})$ and $\mathbf{J}_2(\boldsymbol{\theta})$ will be collinear and the Jacobian $\mathbf{J}(\boldsymbol{\theta})$ becomes a singular matrix. Such configurations are therefore called **singularities**; they are characterized by a situation where the robot tip is unable to generate velocities in certain directions.

![[{AB038D5C-D001-40F9-9F71-5DA7045BACDE}.png|bookhue|600]]
>Mapping the set of possible joint velocities, represented as a square in the $\dot{\theta}_1$–$\dot{\theta}_2$ space, through the Jacobian to find the parallelogram of possible end-effector velocities. The extreme points $A$, $B$, $C$, and $D$ in the joint velocity space map to the extreme points $A$, $B$, $C$, and $D$ in the end-effector velocity space. [[IRB1_000 00350001 מבוא לרובוטיקה#ביבליוגרפיה|(Lynch & Park, 2017)]].

Now let's substitute ${L}_{1} = {L}_{2} = 1$ and consider the robot at two different nonsingular postures: $\boldsymbol{\theta} = (0, \pi/4)$ and $\boldsymbol{\theta} = (0, 3\pi/4)$. The Jacobians $\mathbf{J}(\boldsymbol{\theta})$ at these two configurations are
$$\mathbf{J}\begin{pmatrix} 0 \\ \pi/4 \end{pmatrix} = \begin{pmatrix} -0.71 & -0.71 \\ 1.71 & 0.71 \end{pmatrix} \quad \text{and} \quad \mathbf{J}\begin{pmatrix} 0 \\ 3\pi/4 \end{pmatrix} = \begin{pmatrix} -0.71 & -0.71 \\ 0.29 & -0.71 \end{pmatrix}$$

The Jacobian can be used to map bounds on the rotational speed of the joints to bounds on $\mathbf{v}_{\text{tip}}$, as illustrated in the figure above. Rather than mapping a polygon of joint velocities through the Jacobian as in the figure, we could instead map a unit circle of joint velocities in the $\theta_1$–$\theta_2$-plane. This circle represents an "iso-effort" contour in the joint velocity space, where total actuator effort is considered to be the sum of squares of the joint velocities. This circle maps through the Jacobian to an ellipse in the space of tip velocities, and this ellipse is referred to as the **manipulability ellipsoid**. The following figure shows examples of this mapping for the two different postures of the $\mathrm{2R}$ arm. As the manipulator configuration approaches a singularity, the ellipse collapses to a line segment, since the ability of the tip to move in one direction is lost.

![[{DB7ED9D1-6DF5-4D59-BD15-E00C12D0BB69}.png|bookhue|600]]
>Manipulability ellipsoids for two different postures of the $\mathrm{2R}$ planar open chain. [[IRB1_000 00350001 מבוא לרובוטיקה#ביבליוגרפיה|(Lynch & Park, 2017)]].

Using the manipulability ellipsoid one can quantify how close a given posture is to a singularity. For example, we can compare the lengths of the major and minor principal semi-axes of the manipulability ellipsoid, respectively denoted $\ell_{\max}$ and $\ell_{\min}$. The closer the ellipsoid is to a circle, i.e., the closer the ratio $\ell_{\max}/\ell_{\min}$ is to $1$, the more easily can the tip move in arbitrary directions and thus the more removed it is from a singularity.

The Jacobian also plays a central role in static analysis. Suppose that an external force is applied to the robot tip. What are the joint torques required to resist this external force? This question can be answered via a conservation of power argument. Assuming that negligible power is used to move the robot, the power measured at the robot's tip must equal the power generated at the joints. Denoting the tip force vector generated by the robot as $\mathbf{f}_{\text{tip}}$ and the joint torque vector by $\boldsymbol{\tau}$, the [[DYN1_005 קינטיקה של חלקיק#עבודה ואנרגיה של חלקיק|conservation of power]] then requires that
$$\mathbf{f}_{\text{tip}}^T\mathbf{v}_{\text{tip}} = \boldsymbol{\tau}^T\dot{\boldsymbol{\theta}}$$
for all arbitrary joint velocities $\dot{\boldsymbol{\theta}}$. Since $\mathbf{v}_{\text{tip}} = \mathbf{J}(\boldsymbol{\theta})\dot{\boldsymbol{\theta}}$, the equality
$$\mathbf{f}_{\text{tip}}^T\mathbf{J}(\boldsymbol{\theta})\dot{\boldsymbol{\theta}} = \boldsymbol{\tau}^T\dot{\boldsymbol{\theta}}$$
must hold for all possible $\dot{\boldsymbol{\theta}}$. This can only be true if
$$\boldsymbol{\tau} = \mathbf{J}^T(\boldsymbol{\theta})\mathbf{f}_{\text{tip}} \tag{5.3}$$

The joint torque $\boldsymbol{\tau}$ needed to create the tip force $\mathbf{f}_{\text{tip}}$ is calculated from the equation above. For our two-link planar chain example, $\mathbf{J}(\boldsymbol{\theta})$ is a square matrix dependent on $\boldsymbol{\theta}$. If the configuration $\boldsymbol{\theta}$ is not a singularity then both $\mathbf{J}(\boldsymbol{\theta})$ and its transpose are invertible, and Equation $\text{(5.3)}$ can be written
$$\mathbf{f}_{\text{tip}} = ((\mathbf{J}(\boldsymbol{\theta}))^T)^{-1}\boldsymbol{\tau} = \mathbf{J}^{-T}(\boldsymbol{\theta})\boldsymbol{\tau} \tag{5.4}$$

Using the equation above one can now determine, under the same static equilibrium assumption, what input torques are needed to generate a desired tip force, e.g., the joint torques needed for the robot tip to push against a wall with a specified normal force. For a given posture $\boldsymbol{\theta}$ of the robot at equilibrium and a set of joint torque limits such as
$$ \pu{-1 N⋅m} \leq \tau_1 \leq \pu{\pu{1N.m}}, \qquad \pu{-\pu{1N.m}} \leq \tau_2 \leq \pu{\pu{1N.m}}$$
then Equation $\text{(5.4)}$ can be used to generate the set of all possible tip forces as indicated in the following figure:

![[{8A5B9510-39CD-43EE-8D9C-727588E3FB7D}.png|bookhue|600]]
>Mapping joint torque bounds to tip force bounds. [[IRB1_000 00350001 מבוא לרובוטיקה#ביבליוגרפיה|(Lynch & Park, 2017)]].

As for the manipulability ellipsoid, a **force ellipsoid** can be drawn by mapping a unit circle "iso-effort" contour in the $\tau_1$–$\tau_2$-plane to an ellipsoid in the $f_1$–$f_2$ tip-force plane via the Jacobian transpose inverse $\mathbf{J}^{-T}(\boldsymbol{\theta})$ (see Figure 5.5). The force ellipsoid illustrates how easily the robot can generate forces in different directions.

![[{D678E277-CD05-4FC8-8207-A746E94C43FA}.png|bookhue|600]]
>Force ellipsoids for two different postures of the $\mathrm{2R}$ planar open chain. [[IRB1_000 00350001 מבוא לרובוטיקה#ביבליוגרפיה|(Lynch & Park, 2017)]].

As is evident from the manipulability and force ellipsoids, if it is easy to generate a tip velocity in a given direction then it is difficult to generate a force in that same direction, and vice versa (See the following figure). In fact, for a given robot configuration, the principal axes of the manipulability ellipsoid and force ellipsoid are aligned, and the lengths of the principal semi-axes of the force ellipsoid are the reciprocals of the lengths of the principal semi-axes of the manipulability ellipsoid.

![[{4B5F6DAC-8C60-41E1-9978-E79B6D1955E5}.png|bookhue|600]]
>Left-hand column: Manipulability ellipsoids at two different arm configurations. Right-hand column: The force ellipsoids for the same two arm configurations. [[IRB1_000 00350001 מבוא לרובוטיקה#ביבליוגרפיה|(Lynch & Park, 2017)]].

At a singularity, the manipulability ellipsoid collapses to a line segment. The force ellipsoid, on the other hand, becomes infinitely long in a direction orthogonal to the manipulability ellipsoid line segment (i.e., the direction of the aligned links) and skinny in the orthogonal direction. Consider, for example, carrying a heavy suitcase with your arm. It is much easier if your arm hangs straight down under gravity (with your elbow fully straightened at a singularity), because the force you must support passes directly through your joints, therefore requiring no torques about the joints. Only the joint structure bears the load, not the muscles generating torques. The manipulability ellipsoid loses dimension at a singularity and therefore its area drops to zero, but the force ellipsoid's area goes to infinity (assuming that the joints can support the load!).

In this chapter we present methods for deriving the Jacobian for general open chains, where the configuration of the end-effector is expressed as $\mathbf{T} \in SE(3)$ and its velocity is expressed as a twist $\mathcal{V}$ in the fixed base frame or the end-effector body frame. We also examine how the Jacobian can be used for velocity and static analysis, including identifying kinematic singularities and determining the manipulability and force ellipsoids. Later chapters on inverse kinematics, motion planning, dynamics, and control make extensive use of the Jacobian and related notions introduced in this chapter.

# Manipulator Jacobian

In the $\mathrm{2R}$ planar open chain example, we saw that, for any joint configuration $\boldsymbol{\theta}$, the tip velocity vector $\mathbf{v}_{\text{tip}}$ and joint velocity vector $\dot{\boldsymbol{\theta}}$ are linearly related via the Jacobian matrix $\mathbf{J}(\boldsymbol{\theta})$, i.e., $\mathbf{v}_{\text{tip}} = \mathbf{J}(\boldsymbol{\theta})\dot{\boldsymbol{\theta}}$. The tip velocity $\mathbf{v}_{\text{tip}}$ depends on the coordinates of interest for the tip, which in turn determine the specific form of the Jacobian. For example, in the most general case $\mathbf{v}_{\text{tip}}$ can be taken to be a six-dimensional twist, while, for pure orienting devices such as a wrist, $\mathbf{v}_{\text{tip}}$ is usually taken to be the angular velocity of the end-effector frame. Other choices for $\mathbf{v}_{\text{tip}}$ lead to different formulations for the Jacobian.

We begin with the general case where $\mathbf{v}_{\text{tip}}$ is taken to be a six-dimensional twist $\mathcal{V}$. All the derivations below are mathematical expressions of the same simple idea, embodied in Equation $\text{(5.2)}$: given the configuration $\boldsymbol{\theta}$ of the robot, the $6$-vector $\mathbf{J}_i(\boldsymbol{\theta})$, which is column $i$ of $\mathbf{J}(\boldsymbol{\theta})$, is the twist $\mathcal{V}$ when $\dot{\theta}_i = 1$ and all other joint velocities are zero.

For manipulators described using [[IRB1_002 Forward Kinematics#Assigning Link Frames|Denavit-Hartenberg parameters]], the Jacobian can be systematically derived. Each column of the Jacobian corresponds to the end-effector velocity when one joint moves with unit velocity while all other joints remain stationary.

## Jacobian Matrix for D-H Parameters

For an $n$-link open chain described by [[IRB1_002 Forward Kinematics#D-H Parameters|D-H parameters]], the forward kinematics is expressed as:
$$^0\mathbf{T}_n = \,^0\mathbf{T}_1 \,^1\mathbf{T}_2 \cdots ^{n-1}\mathbf{T}_n$$

The Jacobian matrix $\mathbf{J}(\boldsymbol{\theta}) \in \mathbb{R}^{6 \times n}$ relates the joint velocities $\dot{\boldsymbol{\theta}}$ to the end-effector twist $\mathcal{V}$ expressed in the base frame:
$$\mathcal{V} = \mathbf{J}(\boldsymbol{\theta})\dot{\boldsymbol{\theta}} \tag{5.5}$$

where $\mathcal{V} = \begin{pmatrix} \mathbf{v} \\ \boldsymbol{\omega} \end{pmatrix}$ is the 6-dimensional twist vector with $\mathbf{v}$ being the linear velocity and $\boldsymbol{\omega}$ being the angular velocity of the end-effector.

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
$$\mathbf{J}_i = \begin{pmatrix} \mathbf{J}_{Li} \\ \mathbf{J}_{Ai} \end{pmatrix} = \begin{pmatrix} \mathbf{z}_{i-1} \times (\mathbf{p}_n - \mathbf{p}_{i-1}) \\ \mathbf{z}_{i-1} \end{pmatrix} \tag{5.6}$$

**Prismatic Joint $i$:**
The $i$-th column is:
$$\mathbf{J}_i = \begin{pmatrix} \mathbf{J}_{Li} \\ \mathbf{J}_{Ai} \end{pmatrix} = \begin{pmatrix} \mathbf{z}_{i-1} \\ \mathbf{0} \end{pmatrix} \tag{5.7}$$

**Step 5: Assemble the Complete Jacobian**
$$\mathbf{J}(\boldsymbol{\theta}) = \begin{bmatrix} \mathbf{J}_1 & \mathbf{J}_2 & \cdots & \mathbf{J}_n \end{bmatrix} \tag{5.8}$$

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

### Detailed Example: Computing Cross Products

For a revolute joint, the cross product $\mathbf{z}_{i-1} \times (\mathbf{p}_n - \mathbf{p}_{i-1})$ is computed as:
$$\mathbf{z}_{i-1} \times \mathbf{r}_i = \begin{pmatrix} z_{i-1,x} \\ z_{i-1,y} \\ z_{i-1,z} \end{pmatrix} \times \begin{pmatrix} r_{i,x} \\ r_{i,y} \\ r_{i,z} \end{pmatrix} = \begin{pmatrix} z_{i-1,y} r_{i,z} - z_{i-1,z} r_{i,y} \\ z_{i-1,z} r_{i,x} - z_{i-1,x} r_{i,z} \\ z_{i-1,x} r_{i,y} - z_{i-1,y} r_{i,x} \end{pmatrix}$$

where $\mathbf{r}_i = \mathbf{p}_n - \mathbf{p}_{i-1}$ is the vector from joint $i$ to the end-effector.

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
$$\mathbf{z}_0 = \begin{pmatrix} 0 \\ 0 \\ 1 \end{pmatrix}, \quad \mathbf{p}_0 = \begin{pmatrix} 0 \\ 0 \\ 0 \end{pmatrix}$$

For frame $1$:
$$\mathbf{z}_1 = \begin{pmatrix} 0 \\ 0 \\ 1 \end{pmatrix}, \quad \mathbf{p}_1 = \begin{pmatrix} {L}_{1} c_1 \\ {L}_{1} s_1 \\ 0 \end{pmatrix}$$

For frame $2$ (end-effector):
$$\mathbf{z}_2 = \begin{pmatrix} 0 \\ 0 \\ 1 \end{pmatrix}, \quad \mathbf{p}_2 = \begin{pmatrix} {L}_{1} c_1 + {L}_{2} c_{12} \\ {L}_{1} s_1 + {L}_{2} s_{12} \\ 0 \end{pmatrix}$$

**Step 3: Compute Jacobian Columns**
For joint 1 (revolute joint):
Using the formula $\mathbf{J}_1 = \begin{pmatrix} \mathbf{z}_0 \times (\mathbf{p}_2 - \mathbf{p}_0) \\ \mathbf{z}_0 \end{pmatrix}$:

$$\mathbf{r}_1 = \mathbf{p}_2 - \mathbf{p}_0 = \begin{pmatrix} {L}_{1} c_1 + {L}_{2} c_{12} \\ {L}_{1} s_1 + {L}_{2} s_{12} \\ 0 \end{pmatrix}$$
Therefore the linear velocity:
$$\mathbf{J}_{L1} = \mathbf{z}_0 \times \mathbf{r}_1 = \begin{pmatrix} 0 \\ 0 \\ 1 \end{pmatrix} \times \begin{pmatrix} {L}_{1} c_1 + {L}_{2} c_{12} \\ {L}_{1} s_1 + {L}_{2} s_{12} \\ 0 \end{pmatrix} = \begin{pmatrix} -{L}_{1} s_1 - {L}_{2} s_{12} \\ {L}_{1} c_1 + {L}_{2} c_{12} \\ 0 \end{pmatrix}$$

For joint 2 (revolute joint):
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

