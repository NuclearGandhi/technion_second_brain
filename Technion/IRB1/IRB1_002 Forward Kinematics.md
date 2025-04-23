---
aliases:
---
from [[IRB1_000 00350001 מבוא לרובוטיקה#ביבליוגרפיה|(Lynch & Park, 2017)]]:
# Forward Kinematics
The **forward kinematics** of a robot refers to the calculation of the position and orientation of its end-effector frame from its joint coordinates $\theta$. The following figure illustrates the forward kinematics problem for a $\mathrm{3R}$ planar open chain.


![[{49C5D564-6058-4D7C-A731-763A44DA766C}.png|bookhue|500]]
>Forward kinematics of a $\mathrm{3R}$ planar open chain. For each frame, the $\hat{\mathbf{x}}$ and $\hat{\mathbf{y}}$ is shown; the $\hat{\mathbf{z}}$-axes are parallel and out of the page.

 The link lengths are ${L}_{1}$, ${L}_{2}$, and ${L}_{3}$. Choose a fixed frame $\{ 0 \}$ with origin located at the base joint as shown, and assume an end-effector frame $\{ 4 \}$ has been attached to the tip of the third link. The Cartesian position $(x,y)$ and orientation $\phi$ of the end-effector frame as functions of the joint angles $({\theta}_{1},{\theta}_{2},{\theta}_{3})$ are then given by
 $$\begin{align}
 & x={L}_{1}\cos{\theta}_{1}+{L}_{2}\cos({\theta}_{1}+{\theta}_{2})+{L}_{3}\cos({\theta}_{1}+{\theta}_{2}+{\theta}_{3}) \tag{4.1} \\[1ex]
 & y={L}_{1}\sin{\theta}_{1}+{L}_{2}\sin({\theta}_{1}+{\theta}_{2})+{L}_{3}\sin({\theta}_{1}+{\theta}_{2}+{\theta}_{3}) \tag{4.2} \\[1ex]
 & \phi={\theta}_{1}+{\theta}_{2}+{\theta}_{3}\tag{4.3}
\end{align}$$
A more systematic method of deriving the forward kinematics might involve attaching reference frames to each link
$$^{0}{T}_{4}= \,^{0}{{{T}_{1}}}^{1}{{{T}_{2}}}^{2}{{{T}_{3}}}^{3}{T}_{4}\tag{4.4}$$
where
$$\begin{aligned}
 & ^{0}{T}_{1}=\begin{pmatrix}
\cos{\theta}_{1} & -\sin{\theta}_{1} & 0 & 0 \\
\sin{\theta}_{1} & \cos{\theta}_{1} & 0 & 0 \\
0 & 0 & 1 & 0 \\
0 & 0 & 0 & 1
\end{pmatrix} &  &  ^{1}{T}_{2}=\begin{pmatrix}
\cos{\theta}_{2} & -\sin{\theta}_{2} & 0 & {L}_{1} \\
\sin{\theta}_{2} & \cos{\theta}_{2} & 0 & 0 &  \\
0 & 0 & 1 & 0 \\
0 & 0 & 0 & 1
\end{pmatrix} \\[1ex]
 & ^{2}{T}_{3}=\begin{pmatrix}
\cos{\theta}_{3} & -\sin{\theta}_{3} & 0 & {L}_{2} \\
\sin{\theta}_{3} & \cos{\theta}_{3} & 0 & 0 \\
0 & 0 & 1 & 0 \\
0 & 0 & 0 & 1
\end{pmatrix} &  & ^{3}{T}_{4}=\begin{pmatrix}
1 & 0 & 0 & {L}_{3} \\
0 & 1 & 0 & 0 \\
0 & 0 & 1 & 0 \\
0 & 0 & 0 & 1
\end{pmatrix}
\end{aligned}$$

# Assigning Link Frames
One widely used representation for the forward kinematics of open chains relies on the **Denavit–Hartenberg parameters** (D–H parameters), and this representation uses equation $\text{(4.4)}$.

The basic idea underlying the Denavit–Hartenberg approach to forward kinematics is to attach reference frames to each link of the open chain and then to derive the forward kinematics from the knowledge of the relative displacements between adjacent link frames.

Rather than attaching reference frames to each link in an arbitrary fashion, in the Denavit–Hartenberg convention a set of rules for assigning link frames is observed. The following figure illustrates the frame assignment convention for two adjacent revolute joints $i-1$ and $i$ that are connected by link $i-1$.

![[{8F16F6D0-67D5-4954-A5E6-A50F733825B7}.png|bookhue|500]]
>Illustration of the Denavit–Hartenberg parameters.

The first principle in assigning reference frames is that the $\hat{\mathbf{z}}_i$ axis should align with the axis of joint $i$, while the $\hat{\mathbf{z}}_{i-1}$ axis aligns with joint $i - 1$. The direction of positive rotation around each link’s $\hat{\mathbf{z}}$-axis is determined using the right-hand rule. 

Once the direction of the $\hat{\mathbf{z}}$-axis is established, the next step is to determine the origin of the reference frame for the link. This is done by identifying the line segment that intersects both $\hat{\mathbf{z}}_{i-1}$ and $\hat{\mathbf{z}}_i$ at right angles. For now, we assume this line is unique. (Special cases, like parallel axes—where the line isn’t unique—or intersecting axes—where no perpendicular exists—are discussed later.)

The origin of frame $\{i-1\}$ is placed at the point where this perpendicular line intersects joint axis $i-1$.

With the origin defined, the remaining axes of the frame follow naturally:
- The $\hat{\mathbf{x}}$-axis is oriented along the direction of the perpendicular line, pointing from axis $i-1$ to axis $i$.
- The $\hat{\mathbf{y}}$-axis is then defined by the cross product $\hat{\mathbf{x}} \times \hat{\mathbf{y}} = \hat{\mathbf{z}}$, in accordance with the right-hand rule.

The figure above shows the resulting frames $\{i\}$ and $\{i-1\}$.

With the frames defined, we now introduce four parameters that fully describe the transformation $^{i-1}{T}_{i}$:

- **Link length** $a_{i-1}$:
  The length of the perpendicular line between axes $\hat{\mathbf{z}}_{i-1}$ and $\hat{\mathbf{z}}_i$.  
  >[!notes] Note: 
	 >Despite the name, this does *not* necessarily represent the actual physical length of the link.

- **Link twist** $\alpha_{i-1}$:  
  The angle between $\hat{\mathbf{z}}_{i-1}$ and $\hat{\mathbf{z}}_i$, measured about $\hat{\mathbf{x}}_{i-1}$.

- **Link offset** $d_i$:  
  The distance from the intersection of $\hat{\mathbf{x}}_{i-1}$ and $\hat{\mathbf{z}}_i$ to the origin of frame $i$, measured along $\hat{\mathbf{z}}_i$, with the positive direction defined to be along the $\hat{\mathbf{z}}_{i}$-axis.

- **Joint angle** $\phi_i$:  
  The angle from $\hat{\mathbf{x}}_{i-1}$ to $\hat{\mathbf{x}}_i$, measured around the $\hat{\mathbf{z}}_i$-axis.

These four parameters are known collectively as the **Denavit–Hartenberg parameters**. For an open-chain robotic arm with $n$ one-degree-of-freedom joints, a total of $4n$ D–H parameters fully define the **forward kinematics**.

If all joints are revolute:
- The parameters $a_{i-1}$, $\alpha_{i-1}$, and $d_i$ are constants.
- The joint angle $\phi_i$ serves as the **joint variable**.

We will now address:
- Cases where the perpendicular line is undefined or not unique.
- Scenarios with prismatic joints.
- Guidelines for selecting the ground and end-effector frames.

## When Adjacent Revolute Joint Axes Intersect



>[!TODO] TODO: להשלים

# Exercises
## Question 2
