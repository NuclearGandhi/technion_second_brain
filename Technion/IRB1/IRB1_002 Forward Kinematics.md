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

Rather than attaching reference frames to each link in an arbitrary fashion, in the Denavit-Hartenberg convention a set of rules for assigning link frames is observed. The following figure illustrates the frame assignment convention for two adjacent revolute joints $i-1$ and $i$ that are connected by link $i-1$.

![[{8F16F6D0-67D5-4954-A5E6-A50F733825B7}.png|bookhue|500]]
>Illustration of the Denavit–Hartenberg parameters.

The first rule is that the $\hat{\mathbf{z}}_{i}$-axis coincides with joint axis $i$ and the $\hat{\mathbf{z}}_{i-1}$-axis coincides with joint axis $i-1$. The direction of positive rotation about each link's $\hat{\mathbf{z}}$-axis is determined by the right hand rule.

>[!TODO] TODO: להשלים

# Exercises
## Question 2
