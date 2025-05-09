---
aliases:
---
from [[IRB1_000 00350001 מבוא לרובוטיקה#ביבליוגרפיה|(Lynch & Park, 2017)]]:
# Forward Kinematics
The **forward kinematics** of a robot refers to the calculation of the position and orientation of its end-effector frame from its joint coordinates $\theta$. The following figure illustrates the forward kinematics problem for a $\mathrm{3R}$ planar open chain.


![[{49C5D564-6058-4D7C-A731-763A44DA766C}.png|bookhue|500]]
>Forward kinematics of a $\mathrm{3R}$ planar open chain. For each frame, the $\hat{\mathbf{x}}$ and $\hat{\mathbf{y}}$ is shown; the $\hat{\mathbf{z}}$-axes are parallel and out of the page. [[IRB1_000 00350001 מבוא לרובוטיקה#ביבליוגרפיה|(Lynch & Park, 2017)]].

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
>Illustration of the Denavit–Hartenberg parameters. [[IRB1_000 00350001 מבוא לרובוטיקה#ביבליוגרפיה|(Lynch & Park, 2017)]].

The first principle in assigning reference frames is that the $\hat{\mathbf{z}}_i$ axis should align with the axis of joint $i$, while the $\hat{\mathbf{z}}_{i-1}$ axis aligns with joint $i - 1$. The direction of positive rotation around each link’s $\hat{\mathbf{z}}$-axis is determined using the right-hand rule. 

Once the direction of the $\hat{\mathbf{z}}$-axis is established, the next step is to determine the origin of the reference frame for the link. This is done by identifying the line segment that intersects both $\hat{\mathbf{z}}_{i-1}$ and $\hat{\mathbf{z}}_i$ at right angles. For now, we assume this line is unique. (Special cases, like parallel axes—where the line isn’t unique—or intersecting axes—where no perpendicular exists—are discussed later.)

The origin of frame $\{i-1\}$ is placed at the point where this perpendicular line intersects joint axis $i-1$.

With the origin defined, the remaining axes of the frame follow naturally:
- The $\hat{\mathbf{x}}$-axis is oriented along the direction of the perpendicular line, pointing from axis $i-1$ to axis $i$.
- The $\hat{\mathbf{y}}$-axis is then defined by the cross product $\hat{\mathbf{x}} \times \hat{\mathbf{y}} = \hat{\mathbf{z}}$, in accordance with the right-hand rule.

The figure above shows the resulting frames $\{i\}$ and $\{i-1\}$.

With the frames defined, we now introduce four parameters that fully describe the transformation $^{i-1}{\mathbf{T}}_{i}$:

- **Link length** $a_{i-1}$: The length of the perpendicular line between axes $\hat{\mathbf{z}}_{i-1}$ and $\hat{\mathbf{z}}_i$.  
	>[!notes] Note: 
	 >Despite the name, this does *not* necessarily represent the actual physical length of the link.

 - **Link twist** $\alpha_{i}$: The angle between $\hat{\mathbf{z}}_{i-1}$ and $\hat{\mathbf{z}}_i$, measured about $\hat{\mathbf{x}}_{i}$.
 - **Link offset** $d_i$: The distance from $\hat{\mathbf{x}}_{i-1}$ to $\hat{\mathbf{x}}_{i}$ along $\hat{\mathbf{z}}_{i-1}$
 - **Joint angle** $\theta_i$: The angle from $\hat{\mathbf{x}}_{i-1}$ to $\hat{\mathbf{x}}_i$, measured around the $\hat{\mathbf{z}}_{i-1}$-axis.


These four parameters are known collectively as the **Denavit–Hartenberg parameters**. For an open-chain robotic arm with $n$ one-degree-of-freedom joints, a total of $4n$ D–H parameters fully define the **forward kinematics**.

If all joints are revolute:
- The parameters $a_{i}$, $\alpha_{i}$, and $d_i$ are constants.
- The joint angle ${\theta}_{i}$ serves as the **joint variable**.

We will now address:
- Cases where the perpendicular line is undefined or not unique.
- Scenarios with prismatic joints.
- Guidelines for selecting the ground and end-effector frames.

## When Adjacent Revolute Joint Axes Intersect

If two consecutive revolute joint axes intersect, then no single line exists that is perpendicular to both axes. In such situations, we assign the link length $a_{i} = 0$, and define the $\hat{\mathbf{x}}_{i-1}$ axis as being perpendicular to the plane formed by $\hat{\mathbf{z}}_{i-1}$ and $\hat{\mathbf{z}}_i$.

This setup yields two valid options: one that results in a positive link twist angle $\alpha_{i}$ and another that gives a negative value. Both are acceptable; the choice depends on consistency and convention.

## When Adjacent Revolute Joint Axes Are Parallel

Another special case arises when two adjacent revolute joint axes are parallel. Here, infinitely many perpendicular lines can be drawn between the axes (technically, a one-dimensional family of such lines exists), and any of them can be used to define the frame.

The general recommendation is to pick the perpendicular line that feels most physically meaningful and simplifies the D–H parameters—ideally resulting in more zeros.

## Prismatic Joints

For prismatic joints, the $\hat{\mathbf{z}}$-axis of the link frame is aligned with the direction of positive translation. This mirrors the convention used for revolute joints, where $\hat{\mathbf{z}}$ defines the axis of positive rotation.

Under this convention:
- The **link offset** $d_i$ becomes the joint variable.
- The **joint angle** ${\theta}_{i}$ is fixed.

The method for setting the origin and determining the $\hat{\mathbf{x}}$ and $\hat{\mathbf{y}}$ axes remains unchanged from the revolute joint case. See the following figure for illustration:

![[{13684895-9E3E-4686-9E47-57C9FBF64381}.png|bookhue|600]]
>Link frame assignment convention for prismatic joints. Joint $i-1$ is a revolute joint, while joint $i$ is a prismatic joint. [[IRB1_000 00350001 מבוא לרובוטיקה#ביבליוגרפיה|(Lynch & Park, 2017)]].

## Choosing the Ground and End-Effector Frames

So far, we've discussed how to assign link frames, but not how to define the ground (base) frame or the final end-effector frame. A helpful strategy is to choose these in a way that feels intuitive and results in the simplest possible D–H parameter set.

Typically:
- The **ground frame** is placed to coincide with frame $\{1\}$ when the system is in its zero (home) configuration.
- For a **revolute joint**, this leads to $a_1 = \alpha_1 = d_1 = 0$.
- For a **prismatic joint**, we get $a_1 = \alpha_1 = \theta_1 = 0$.
- The **end-effector frame** is positioned at a convenient reference point on the tool or device, chosen for clarity in task description and simplification of D–H parameters (ideally making them zero where possible).

Keep in mind, though, that not all arbitrary frame choices will work—there may be no valid set of D–H parameters that describe the transformation if the initial or final frames are chosen inconsistently. This point will be addressed in further detail.

# Manipulator Forward Kinematics
Once all the transformations $^{i-1}\mathbf{T}_{i}$, between adjacent link frames are known in terms of their D–H parameters, the forward kinematics is obtained by sequentially multiplying these link transformations. Each link frame transformation is of the form
$$\boxed {
\begin{aligned}
^{i-1}\mathbf{T}_{i} & =\mathrm{Rot}(\hat{\mathbf{x}},\alpha _{i})\mathrm{Trans}(\hat{\mathbf{x}},{a}_{i})\mathrm{Trans}(\hat{\mathbf{z}},{d}_{i})\mathrm{Rot}(\hat{\mathbf{z}},{\theta}_{i}) \\[2ex]
 & =\begin{pmatrix}
\cos\theta_i & -\sin\theta_i\cos\alpha_i & \sin\theta_i\sin\alpha_i & a_i\cos\theta_i \\
\sin\theta_i & \cos\theta_i\cos\alpha_i & -\cos\theta_i\sin\alpha_i & a_i\sin\theta_i \\
0 & \sin(\alpha_i) & \cos\alpha_i & d_i \\
0 & 0 & 0 & 1
\end{pmatrix}
\end{aligned}
 }$$

# Exercises

>[!notes] Note: 
>We prefer using the shorthand
> $$\begin{aligned}
>  & {C}_{i}:=\cos{\theta}_{i} &  & {S}_{j}:=\sin{\theta}_{i} \\[1ex]
>  & {C}_{ij}:=\cos({\theta}_{i}+{\theta}_{j}) &  & {S}_{ij}:=\sin({\theta}_{i}+{\theta}_{j})
> \end{aligned}$$
> which means, using [[BMA1_009 זהויות טריגונומטריות#חיבור וחיסור זוויות|trigonometric identities]],
> $$\begin{aligned}
>  & {C}_{1}{C}_{2}-{S}_{1}{S}_{2}={C}_{12} \\[1ex]
>  & {S}_{1}{C}_{2}+{C}_{1}{S}_{2}={S}_{12}
> \end{aligned}$$
> 

## Question 1
Given the robot shown in the figure below:

![[IRB1_002 Forward Kinematics 2025-04-30 21.44.20.excalidraw.svg]]
>Simple robot with one revolute and one prismatic joint.

Compute the last transformation $^{0}\mathbf{T}_{2}$.

**Solution**:
First, let's assign link frames.

![[IRB1_002 Forward Kinematics 2025-04-30 21.25.38.excalidraw.svg]]
>Assigning link frames.

We need to establish our coordinate frames according to the D–H parameters.

$$\begin{array}{c|ccc}
i & \alpha _{i} & {a}_{i} & {d}_{i} & {\theta}_{i} \\
\hline 1 & 90^{\circ}  & 0 & b & {\theta}_{1} \\
2 & 0  & 0 & {d}_{2} & 0
\end{array}$$

We will compute each transformation matrix using the D–H parameters from the table.

For each joint, the transformation matrix is:
$$^{i-1}\mathbf{T}_i = \begin{pmatrix}
\cos\theta_i & -\sin\theta_i\cos\alpha_i & \sin\theta_i\sin\alpha_i & a_i\cos\theta_i \\
\sin\theta_i & \cos\theta_i\cos\alpha_i & -\cos\theta_i\sin\alpha_i & a_i\sin\theta_i \\
0 & \sin(\alpha_i) & \cos\alpha_i & d_i \\
0 & 0 & 0 & 1
\end{pmatrix}$$

Computing each individual transformation matrix:

$$\begin{aligned}
 & ^{0}\mathbf{T}_1 = \begin{pmatrix}
\cos{\theta}_{1} & 0 & \sin{\theta}_{1} & b\cos{\theta}_{1} \\
\sin{\theta}_{1} & 0 & -\cos{\theta}_{1} & b\sin{\theta}_{1} \\
0 & 1 & 0 & b \\
0 & 0 & 0 & 1
\end{pmatrix} \\[1ex]
 & ^{1}\mathbf{T}_{2}=\begin{pmatrix}
1 & 0 & 0 & 0 \\
0 & 1 & 0 & 0 \\
0 & 0 & 1 & {d}_{2} \\
0 & 0 & 0 & 1
\end{pmatrix}
\end{aligned}$$
Therefore the last transformation:
$$\begin{gather}
^{0}\mathbf{T}_{2}  =\,^{0}{{\mathbf{T}_{1}}}^{2}\mathbf{T}_{2} \\[1ex]
\boxed {
 ^{0}\mathbf{T}_{2} = \begin{pmatrix}
\cos{\theta}_{1} & 0 & \sin{\theta}_{1} & {d}_{2}+b\cos{\theta}_{1} \\
\sin{\theta}_{1} & 0 & -\cos{\theta}_{1} & -{d}_{2}\cos{\theta}_{1}+b\sin{\theta}_{1} \\
0 & 1 & 0 & 0 \\
0 & 0 & 0 & 1
\end{pmatrix}
 }
\end{gather}$$

## Question 2
Compute the forward kinematics of the following manipulator:
![[IRB1_002 Forward Kinematics 2025-04-30 22.16.55.excalidraw.svg]]
>A manipulator with 2 revolute and 1 prismatic joints.

**Solution**:
First, we'll mark the $\hat{\mathbf{z}}$ axes.
![[IRB1_002 Forward Kinematics 2025-05-01 09.06.52.excalidraw.svg]]
>Marking $\hat{\mathbf{z}}$ axes along the joints' axes.

Now we can complete the other frames, starting from the world frame:
![[IRB1_002 Forward Kinematics 2025-05-01 09.10.36.excalidraw.svg]]
>Assigning all the frames according to the convention.

Now to plot all the parameters in a table:
$$\begin{array}{c|cccc}
i & \alpha _{i} & {a}_{i} & {d}_{i} & {\theta}_{i} \\
\hline 1 & -90^{\circ}  & 0 & {L}_{1} & {\theta}_{1} \\
2 & 90^{\circ}  & 0 & {d}_{2} & -90^{\circ}   \\
3 & 0^{\circ}  & 0 & {L}_{3} & {\theta}_{3}
\end{array}$$

The forward kinematics will then be:
$$\boxed {
^{0}\mathbf{T}_{3}=\small\begin{pmatrix}
-\sin{\theta}_{1}\sin{\theta}_{3} & -\sin{\theta}_{1}\cos{\theta}_{3} & -\cos{\theta}_{1} & -{L}_{3}\cos{\theta}_{1}-{d}_{2}\sin{\theta}_{1} \\
\cos{\theta}_{1}\sin{\theta}_{3} & \cos{\theta}_{1}\cos{\theta}_{3} & -\sin{\theta}_{1} & -{L}_{3}\sin{\theta}_{1}  +{d}_{2}\cos{\theta}_{1} \\
\cos{\theta}_{3} & -\sin{\theta}_{3} & 0 & {L}_{1} \\
0 & 0 & 0 & 1
\end{pmatrix}
 }$$

