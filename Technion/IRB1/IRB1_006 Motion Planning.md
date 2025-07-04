---
aliases:
- Motion Planning
- Path Planning
- Configuration Space
- C-space
- Piano Mover's Problem
---
from [[IRB1_000 00350001 מבוא לרובוטיקה#ביבליוגרפיה|(Lynch & Park, 2017)]]:

Motion planning is the problem of finding a robot motion from a start state to a goal state that avoids obstacles in the environment and satisfies other constraints, such as joint limits or torque limits. Motion planning is one of the most active subfields of robotics, and it is the subject of entire books. The purpose of this chapter is to provide a practical overview of a few common techniques, using robot arms and mobile robots as the primary example systems. The chapter begins with a brief overview of motion planning. This is followed by foundational material including configuration space obstacles and graph search. We conclude with summaries of several different planning methods.

![[Pasted image 20250627163005.png|400]]
>A robot arm executing an obstacle-avoiding motion plan. The motion plan was generated using MoveIt! and visualized using rviz in ROS (the Robot Operating System).  [[IRB1_000 00350001 מבוא לרובוטיקה#ביבליוגרפיה|(Lynch & Park, 2017)]].

![[Pasted image 20250627163028.png|bookhue|500]]
>A car-like mobile robot executing parallel parking. [[IRB1_000 00350001 מבוא לרובוטיקה#ביבליוגרפיה|(Lynch & Park, 2017)]].

# Overview of Motion Planning

>[!def] Definition:
>**Configuration space**, or **C-space** for short, is a space where every point corresponds to a unique configuration $\mathbf{q}$ of the robot, and every configuration of the robot can be represented as a point in C-space.

For example, the configuration of a robot arm with $n$ joints can be represented as a list of $n$ joint positions, $\mathbf{q} = (\theta_1, \ldots, \theta_n)$. The **free C-space** $\mathcal{C}_{\text{free}}$ consists of the configurations where the robot neither penetrates an obstacle nor violates a joint limit. In this chapter, unless otherwise stated, we assume that $\mathbf{q}$ is an $n$-vector and that $\mathcal{C} \subset \mathbb{R}^n$. With some generalization, the concepts of this chapter apply to non-Euclidean C-spaces such as $\mathcal{C} = SE(3)$.

The control inputs available to drive the robot are written as an $m$-vector $\mathbf{u} \in U \subset \mathbb{R}^m$, where $m = n$ for a typical robot arm. If the robot has second-order dynamics, such as that for a robot arm, and the control inputs are forces (equivalently, accelerations), the state of the robot is defined by its configuration and velocity, $\mathbf{x} = (\mathbf{q}, \mathbf{v}) \in \mathcal{X}$. For $\mathbf{q} \in \mathbb{R}^n$, typically we write $\mathbf{v} = \dot{\mathbf{q}}$. If we can treat the control inputs as velocities, the state $\mathbf{x}$ is simply the configuration $\mathbf{q}$. The notation $\mathbf{q}(\mathbf{x})$ indicates the configuration $\mathbf{q}$ corresponding to the state $\mathbf{x}$, and $\mathcal{X}_{\text{free}} = \{\mathbf{x} | \mathbf{q}(\mathbf{x}) \in \mathcal{C}_{\text{free}}\}$.

The equations of motion of the robot are written
$$\dot{\mathbf{x}} = f(\mathbf{x}, \mathbf{u}) \tag{LP10.1}$$

or, in integral form,
$$\mathbf{x}(T) = \mathbf{x}(0) + \int_0^T f(\mathbf{x}(t), \mathbf{u}(t))dt \tag{LP10.2}$$

## Types of Motion Planning Problems

>[!def] Definition:
>Given an initial state $\mathbf{x}(0) = \mathbf{x}_{\text{start}}$ and a desired final state $\mathbf{x}_{\text{goal}}$, find a time $T$ and a set of controls $\mathbf{u} : [0, T] \to U$ such that the motion $\text{(LP10.2)}$ satisfies $\mathbf{x}(T) = \mathbf{x}_{\text{goal}}$ and $\mathbf{q}(\mathbf{x}(t)) \in \mathcal{C}_{\text{free}}$ for all $t \in [0, T]$.

It is assumed that a feedback controller is available to ensure that the planned motion $\mathbf{x}(t)$, $t \in [0, T]$, is followed closely. It is also assumed that an accurate geometric model of the robot and environment is available to evaluate $\mathcal{C}_{\text{free}}$ during motion planning. There are many variations of the basic problem; some are discussed below.

**Path Planning versus Motion Planning**: The **path planning problem** is a subproblem of the general motion planning problem. Path planning is the purely geometric problem of finding a collision-free path $\mathbf{q}(s)$, $s \in [0, 1]$, from a start configuration $\mathbf{q}(0) = \mathbf{q}_{\text{start}}$ to a goal configuration $\mathbf{q}(1) = \mathbf{q}_{\text{goal}}$, without concern for the dynamics, the duration of motion, or constraints on the motion or on the control inputs.
It is assumed that the path returned by the path planner can be time scaled to create a feasible trajectory. This problem is sometimes called the **piano mover's problem**, emphasizing the focus on the geometry of cluttered spaces.

**Control Inputs**: $m = n$ versus $m < n$. If there are fewer control inputs $m$ than degrees of freedom $n$, then the robot is incapable of following many paths, even if they are collision-free. For example, a car has $n = 3$ (the position and orientation of the chassis in the plane) but $m = 2$ (forward-backward motion and steering); it cannot slide directly sideways into a parking space.

**Online versus Offline**: A motion planning problem requiring an immediate result, perhaps because obstacles appear, disappear, or move unpredictably, calls for a fast, **online** planner. If the environment is static then a slower **offline** planner may suffice.

**Optimal versus Satisficing**: In addition to reaching the goal state, we might want the motion plan to minimize (or approximately minimize) a cost $J$, e.g.,
$$J = \int_0^T L(\mathbf{x}(t), \mathbf{u}(t))dt$$

For example, minimizing with $L = 1$ yields a time-optimal motion while minimizing with $L = \mathbf{u}^T(t)\mathbf{u}(t)$ yields a "minimum-effort" motion.

**Exact versus Approximate**: We may be satisfied with a final state $\mathbf{x}(T)$ that is sufficiently close to $\mathbf{x}_{\text{goal}}$, e.g., $\|\mathbf{x}(T) - \mathbf{x}_{\text{goal}}\| < \epsilon$.

**With or Without Obstacles**: The motion planning problem can be challenging even in the absence of obstacles, particularly if $m < n$ or optimality is desired.

## Properties of Motion Planners

Planners must conform to the properties of the motion planning problem as outlined above. In addition, planners can be distinguished by the following properties.

**Multiple-Query versus Single-Query Planning**: If the robot is being asked to solve a number of motion planning problems in an unchanging environment, it may be worth spending the time building a data structure that accurately represents $\mathcal{C}_{\text{free}}$. This data structure can then be searched to solve multiple planning queries efficiently. **Single-query planners** solve each new problem from scratch.

**"Anytime" Planning**: An **anytime planner** is one that continues to look for better solutions after a first solution is found. The planner can be stopped at any time, for example when a specified time limit has passed, and the best solution returned.

**Completeness**: A motion planner is said to be **complete** if it is guaranteed to find a solution in finite time if one exists, and to report failure if there is no feasible motion plan. A planner is **resolution complete** if it is guaranteed to find a solution if one exists at the resolution of a discretized representation of the problem, such as the resolution of a grid representation of $\mathcal{C}_{\text{free}}$. A planner is **probabilistically complete** if the probability of finding a solution, if one exists, tends to 1 as the planning time goes to infinity.

**Computational Complexity**: The computational complexity refers to characterizations of the amount of time the planner takes to run or the amount of memory it requires. These are measured in terms of the description of the planning problem, such as the dimension of the C-space or the number of vertices in the representation of the robot and obstacles. For example, the time for a planner to run may be exponential in $n$, the dimension of the C-space. The computational complexity may be expressed in terms of the average case or the worst case. Some planning algorithms lend themselves easily to computational complexity analysis, while others do not.

# Foundations

Before discussing motion planning algorithms, we establish concepts used in many of them: configuration space obstacles, collision detection, graphs, and graph search.

## Configuration Space Obstacles

Determining whether a robot at a configuration $\mathbf{q}$ is in collision with a known environment generally requires a complex operation involving a CAD model of the environment and robot. There are a number of free and commercial software packages that can perform this operation, and we will not delve into them here. For our purposes, it is enough to know that the workspace obstacles partition the configuration space $\mathcal{C}$ into two sets, the free space $\mathcal{C}_{\text{free}}$ and the obstacle space $\mathcal{C}_{\text{obs}}$, where $\mathcal{C} = \mathcal{C}_{\text{free}} \cup \mathcal{C}_{\text{obs}}$. Joint limits are treated as obstacles in the configuration space. With the concepts of $\mathcal{C}_{\text{free}}$ and $\mathcal{C}_{\text{obs}}$, the path planning problem reduces to the problem of finding a path for a point robot among the obstacles $\mathcal{C}_{\text{obs}}$. If the obstacles break $\mathcal{C}_{\text{free}}$ into separate connected components, and $\mathbf{q}_{\text{start}}$ and $\mathbf{q}_{\text{goal}}$ do not lie in the same connected component, then there is no collision-free path.

The explicit mathematical representation of a C-obstacle can be exceedingly complex, and for that reason C-obstacles are rarely represented exactly. Despite this, the concept of C-obstacles is very important for understanding motion planning algorithms. The ideas are best illustrated by examples.

### A 2R Planar Arm

![[Pasted image 20250628135206.png|bookhue|600]]
>(Left) The joint angles of a 2R robot arm. (Middle) The arm navigating among obstacles A, B, and C. (Right) The same motion in C-space. Three intermediate points, 4, 7, and 10, along the path are labeled. [[IRB1_000 00350001 מבוא לרובוטיקה#ביבליוגרפיה|(Lynch & Park, 2017)]].

The figure above shows a 2R planar robot arm, with configuration $\mathbf{q} = (\theta_1, \theta_2)$, among obstacles A, B, and C in the workspace. The C-space of the robot is represented by a portion of the plane with $0 \leq \theta_1 < 2\pi$, $0 \leq \theta_2 < 2\pi$. The topology of the C-space is a torus (or doughnut) since the edge of the square at $\theta_1 = 2\pi$ is connected to the edge $\theta_1 = 0$; similarly, $\theta_2 = 2\pi$ is connected to $\theta_2 = 0$. The square region of $\mathbb{R}^2$ is obtained by slicing the surface of the doughnut twice, at $\theta_1 = 0$ and $\theta_2 = 0$, and laying it flat on the plane.

The C-space on the right in the figure shows the workspace obstacles A, B, and C represented as C-obstacles. Any configuration lying inside a C-obstacle corresponds to penetration of the obstacle by the robot arm in the workspace. A free path for the robot arm from one configuration to another is shown in both the workspace and C-space. The path and obstacles illustrate the topology of the C-space. Note that the obstacles break $\mathcal{C}_{\text{free}}$ into three connected components.

### A Circular Planar Mobile Robot

![[Pasted image 20250628140027.png|bookhue|600]]
>(a) A circular mobile robot (open circle) and a workspace obstacle (gray triangle). The configuration of the robot is represented by $(x, y)$, the center of the robot. (b) In the C-space, the obstacle is "grown" by the radius of the robot and the robot is treated as a point. Any $(x, y)$ configuration outside the bold line is collision-free. [[IRB1_000 00350001 מבוא לרובוטיקה#ביבליוגרפיה|(Lynch & Park, 2017)]].

The figure above shows a top view of a circular mobile robot whose configuration is given by the location of its center, $(x, y) \in \mathbb{R}^2$. The robot translates (moves without rotating) in a plane with a single obstacle. The corresponding C-obstacle is obtained by "growing" (enlarging) the workspace obstacle by the radius of the mobile robot. Any point outside this C-obstacle represents a free configuration of the robot.

![[Pasted image 20250628140112.png|bookhue|400]]
>The "grown" C-space obstacles corresponding to two workspace obstacles and a circular mobile robot. The overlapping boundaries mean that the robot cannot move between the two obstacles. [[IRB1_000 00350001 מבוא לרובוטיקה#ביבליוגרפיה|(Lynch & Park, 2017)]].

The figure above shows the workspace and C-space for two obstacles, indicating that in this case the mobile robot cannot pass between the two obstacles.

# Exercises
## Question 1

The given manipulator is at rest at $\theta_0 = 25^{\circ}$. The manipulator must be moved to $\theta_f = 100^{\circ}$ in 5 seconds. Compute the coefficients of the polynomial:

$$\theta(t) = a_n t^n + a_{n-1} t^{n-1} + \ldots + a_1 t + a_0$$

that will cause the manipulator to arrive at its final angle with zero angular velocity.

**Solution**:

This is a motion planning problem in the joint space.

**Joint value constraints** are given at initial and final points:
- $\theta(0) = 25^{\circ}$, $\theta(5) = 100^{\circ}$
- $\dot{\theta}(0) = 0$, $\dot{\theta}(5) = 0$

Since there are $c = 4$ constraints, we need a polynomial of degree $n = c - 1 = 3$:

$$\theta(t) = a_3 t^3 + a_2 t^2 + a_1 t + a_0, \quad t \in [0, 5]$$

**Given constraints:**
- $t_0 = 0$, $t_f = 5$
- $\theta_0 = \theta(t_0) = 25^{\circ}$, $\theta_f = \theta(t_f) = 100^{\circ}$
- $\dot{\theta}_0 = \dot{\theta}(0) = 0$ , $\dot{\theta}_f = \dot{\theta}(5) = 0$

**Derivative of the polynomial:**
$$\dot{\theta}(t) = 3a_3 t^2 + 2a_2 t + a_1$$

**Applying the constraints:**

Applying $\theta(0) = 25^{\circ}$:
$$\begin{gathered}
a_3(0)^3 + a_2(0)^2 + a_1(0) + a_0 = 25^{\circ} \\[1ex]
\boxed{a_0 = 25^{\circ}}
\end{gathered}$$

Applying $\dot{\theta}(0) = 0$:
$$\begin{gathered}
3a_3(0)^2 + 2a_2(0) + a_1 = 0 \\[1ex]
\boxed{a_1 = 0}
\end{gathered}$$
For $\theta(5) = 100^{\circ}$:
$$\begin{gathered}
a_3(5)^3 + a_2(5)^2 + 25 = 100^{\circ} \\[1ex]
125a_3 + 25a_2 = 75
\end{gathered}$$

Applying $\dot{\theta}(5) = 0$
$$\begin{gathered}
3a_3(5)^2 + 2a_2(5) = 0 \\[1ex]
75a_3 + 10a_2 = 0
\end{gathered}$$


**Solving the system of equations:**
From equations 3 and 4:
$$\begin{aligned}
125a_3 + 25a_2 &= 75 \\[1ex]
75a_3 + 10a_2 &= 0
\end{aligned}$$

Solving: $a_2 = -9$, $a_3 = \frac{6}{5}$

**Final polynomial:**
$$\boxed{\theta(t) = \frac{6}{5}t^3 - 9t^2 + 25^{\circ}, \quad t \in [0,5]\,\pu{s}}$$

**Results Analysis:**

**Manipulator Angular Velocity:** $\dot{\theta}(t) = \frac{18}{5}t^2 - 18t$
- Starts and ends at zero as required
- Has intermediate velocity changes

**Manipulator Angular Acceleration:** $\ddot{\theta}(t) = \frac{36}{5}t - 18$

>[!notes] Note:
>The planned path requires non-smooth angular acceleration at the start and finish, which will require (infinitely) high motor torques! **Conclusion:** Add constraints for accelerations in practical applications.

>[!info] Conclusion: Joint Space Planning
>**When to use:** Plan a path in joint space when the gripper's motion is simple or unimportant.
>
>**Pros:**
>- No danger of reaching singular points
>- The gripper's position can be computed directly using forward kinematics
>
>**Cons:**
>- Hard to generate a meaningful path for the gripper

## Question 2

Compute a piecewise linear path for the gripper between the points:

**Initial point:** $\mathbf{p}_0 = [x_0, y_0]^T = [1.5a, b]^T$  
**Final point:** $\mathbf{p}_f = [x_f, y_f]^T = [-2.5a, 2b]^T$

Starting and ending with zero velocity and acceleration, given that $d \in [a, 3a] = [2, 6]$.

![[IRB1_002 Forward Kinematics 2025-04-30 21.25.38.excalidraw.svg]]
>The given manipulator.

**Solution**:

Since the path planning is in **Cartesian space**, we must first compute the gripper workspace and ensure any planned path is within it.

**Workspace Analysis:**
The workspace is determined by the manipulator's geometric constraints, showing the reachable area for the gripper.

![[IRB1_005 Motion Planning 2025-06-28 15.56.00.excalidraw.svg]]
>The gripper's workspace.

**Piecewise Linear Path:**
Since we cannot move the gripper along a single linear segment between the two points, we add an **intermediate point** $\mathbf{p}_m$.

The path consists of two segments:
1. From $\mathbf{p}_0$ to $\mathbf{p}_m$
2. From $\mathbf{p}_m$ to $\mathbf{p}_f$

![[IRB1_005 Motion Planning 2025-06-28 16.02.05.excalidraw.svg]]
>The gripper's path. (green) Path with intermediate point. (red) Linear segment.

For each linear segment, we have **six requirements** for each coordinate:

**Position constraints:**
- $x(t_0) = x_0$, $x(t_f) = x_f$
- $y(t_0) = y_0$, $y(t_f) = y_f$

**Velocity constraints:**
- $\dot{x}(t_0) = 0$, $\dot{x}(t_f) = 0$
- $\dot{y}(t_0) = 0$, $\dot{y}(t_f) = 0$

**Acceleration constraints:**
- $\ddot{x}(t_0) = 0$, $\ddot{x}(t_f) = 0$
- $\ddot{y}(t_0) = 0$, $\ddot{y}(t_f) = 0$


With $c = 6$ constraints, we need a polynomial of degree $n = c - 1 = 5$:

For each segment, we plan $x(t)$ first, then use $y(t) = y(x(t))$.

**Segment Planning:**

**First segment:**
- Start: $\mathbf{p}_0$, End: $\mathbf{p}_m$
- Time: $t \in [0, T_1]$
- Functions: $x_1(t)$, $y_1(t)$

**Second segment:**
- Start: $\mathbf{p}_m$, End: $\mathbf{p}_f$  
- Time: $t \in [0, T_2]$
- Functions: $x_2(t)$, $y_2(t)$

**Complete path:**
$$\begin{aligned}
x(t) &= \begin{cases}
x_1(t), & t \in [0, T_1] \\
x_2(t), & t \in [T_1, T_1+T_2]
\end{cases} \\[1ex]
y(t) &= \begin{cases}
y_1(t), & t \in [0, T_1] \\
y_2(t), & t \in [T_1, T_1+T_2]
\end{cases}
\end{aligned}$$

We control the manipulator's joints through motors. To find the joint values, velocities, and accelerations that cause the gripper to move along the designed path:

**Joint Values (Inverse Kinematics):**
The joint values are computed by solving inverse kinematics, solved in [[IRB1_003 Inverse Kinematics#Question 1|a previous tutorial]]:

$$\begin{aligned}
\theta_1(t) &= \text{atan2}[y(t), x(t)] - \text{atan2}[b, \sqrt{x^2(t) + y^2(t) - b^2}] + 90^{\circ} \\[1ex]
d_2(t) &= \sqrt{x^2(t) + y^2(t) - b^2}
\end{aligned}$$

**Joint Velocities and Accelerations:**
Using the **linear Jacobian matrix**:

$$\mathbf{J}_L = \begin{pmatrix}
-d_1 \sin\theta_1 - b\cos\theta_1 & \cos\theta_1 \\
d_1 \cos\theta_1 - b\sin\theta_1 & \sin\theta_1
\end{pmatrix}$$

**Joint velocities:**
$$\dot{\mathbf{q}} = \mathbf{J}_L^{-1}\dot{\mathbf{P}}$$

**Joint accelerations:**
$$\ddot{\mathbf{q}} = \mathbf{J}_L^{-1}\ddot{\mathbf{P}} - \mathbf{J}_L^{-1}\dot{\mathbf{J}}_L\dot{\mathbf{q}}$$


**Jacobian inverse:**
$$\mathbf{J}_L^{-1} = -\dfrac{1}{{d}_{2}}\begin{pmatrix}
-{c}_{1} & -{s}_{1} \\
-b{c}_{1}-{d}_{2}{s}_{1} & -b{s}_{1}+{d}_{2}{c}_{1}
\end{pmatrix}$$

**Velocity calculation:**
$$\begin{pmatrix}
\dot{\theta}_1(t) \\
\dot{d}_2(t)
\end{pmatrix} =-\dfrac{1}{{d}_{2}}\begin{pmatrix}
-{c}_{1} & -{s}_{1} \\
-b{c}_{1}-{d}_{2}{s}_{1} & -b{s}_{1}+{d}_{2}{c}_{1}
\end{pmatrix} \begin{pmatrix}
\dot{x}(t) \\
\dot{y}(t)
\end{pmatrix}$$

where $c_1 = \cos\theta_1$ and $s_1 = \sin\theta_1$.

>[!info] Conclusions: Cartesian Space Planning
>**When to use:** Plan a path in Cartesian space when the gripper's motion is important.
>
>**Pros:**
>- Easy to visualize the gripper's path
>- Easy to avoid obstacles in the workspace
>
>**Cons:**
>- Requires drawing the gripper workspace
>- Requires translation to joint values using inverse kinematics

