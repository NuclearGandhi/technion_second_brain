---
aliases:
---
from [[IRB1_000 00350001 מבוא לרובוטיקה#ביבליוגרפיה|(Lynch & Park, 2017)]]:
# Inverse Kinematics

For a general $n$ degree-of-freedom open chain with [[IRB1_002 Forward Kinematics#Manipulator Forward Kinematics|forward kinematics]] $\mathbf{T}(\theta)$, where $\theta \in \mathbb{R}^n$, the **inverse kinematics problem** can be stated as follows: given a homogeneous transformation $\mathbf{X} \in SE(3)$, find solutions $\theta$ that satisfy $\mathbf{T}(\theta) = \mathbf{X}$.

To highlight the main features of the inverse kinematics problem, let us examine the two-link planar open chain of the following figure as a motivational example.

![[{5C54CB44-C5A2-4AD9-A46E-E797DDFFB1D5}.png|bookhue|350]]
>Inverse kinematics of a $\mathrm{2R}$ planar open chain. (a) A workspace, and lefty and righty configurations. [[IRB1_000 00350001 מבוא לרובוטיקה#ביבליוגרפיה|(Lynch & Park, 2017)]].

Considering only the position of the end-effector and ignoring its orientation, the forward kinematics can be expressed as
$$
\begin{pmatrix} x \\ y \end{pmatrix} = \begin{pmatrix} L_1 \cos \theta_1 + L_2 \cos(\theta_1 + \theta_2) \\ L_1 \sin \theta_1 + L_2 \sin(\theta_1 + \theta_2) \end{pmatrix} \tag{LP6.1}
$$
Assuming $L_1 > L_2$, the set of reachable points, or the **workspace**, is an annulus of inner radius $L_1 - L_2$ and outer radius $L_1 + L_2$. Given some end-effector position $(x, y)$, it is not hard to see that there will be either zero, one, or two solutions depending on whether $(x, y)$ lies in the exterior, boundary, or interior of this annulus, respectively. When there are two solutions, the angle at the second joint (the “elbow” joint) may be positive or negative. These two solutions are sometimes called “lefty” and “righty” solutions, or “elbow-up” and “elbow-down” solutions.

Finding an explicit solution $(\theta_1, \theta_2)$ for a given $(x, y)$ is also not difficult. For this purpose, we will find it useful to introduce the two-argument arctangent function $\mathrm{atan2}(y, x)$, which returns the angle from the origin to a point $(x, y)$ in the plane. It is similar to the inverse tangent $\tan^{-1}(y/x)$, but whereas $\tan^{-1}(y/x)$ is equal to $\tan^{-1}(-y/-x)$, and therefore $\tan^{-1}$ only returns angles in the range $(-\pi/2, \pi/2)$, the $\mathrm{atan2}$ function returns angles in the range $(-\pi, \pi]$. For this reason, $\mathrm{atan2}$ is sometimes called the four-quadrant arctangent.

We also recall the law of cosines,
$$ c^2 = a^2 + b^2 - 2ab \cos C $$
where $a, b,$ and $c$ are the lengths of the three sides of a triangle and $C$ is the interior angle of the triangle opposite the side of length $c$.

![[{DBA8CCD7-A27C-4E2F-B266-DF047137D7A8}.png|bookhue|400]]
>Geometric solution.

Referring to the figure above, angle $\beta$, restricted to lie in the interval $[0, \pi]$, can be determined from the law of cosines,
$$ L_1^2 + L_2^2 - 2L_1L_2 \cos \beta = x^2 + y^2 $$
from which it follows that
$$ \beta = \arccos\left( \frac{L_1^2 + L_2^2 - x^2 - y^2}{2L_1L_2} \right) $$
Also from the law of cosines,
$$ \alpha = \arccos\left( \frac{x^2 + y^2 + L_1^2 - L_2^2}{2L_1 \sqrt{x^2 + y^2}} \right) $$
The angle $\gamma$ is determined using the two-argument arctangent function, $\gamma = \mathrm{atan2}(y, x)$. With these angles, the righty solution to the inverse kinematics is
$$ \theta_1 = \gamma - \alpha, \quad \theta_2 = \pi - \beta $$
and the lefty solution is
$$ \theta_1 = \gamma + \alpha, \quad \theta_2 = \beta - \pi $$
If $x^2 + y^2$ lies outside the range $[(L_1 - L_2)^2, (L_1 + L_2)^2]$ then no solution exists.

This simple motivational example illustrates that, for open chains, the inverse kinematics problem may have multiple solutions; this situation is in contrast with the forward kinematics, where a unique end-effector displacement $\mathbf{T}$ exists for given joint values $\theta$. In fact, three-link planar open chains have an infinite number of solutions for points $(x, y)$ lying in the interior of the workspace; in this case the chain possesses an extra degree of freedom and is said to be **kinematically redundant**.

In this chapter we first consider the inverse kinematics of spatial open chains with six degrees of freedom. At most a finite number of solutions exists in this case, and we consider two popular structures – the PUMA and Stanford robot arms – for which analytic inverse kinematic solutions can be easily obtained. For more general open chains, we adapt the [[NUM1_005 משוואות לא לינאריות במשתנה אחד#אלגוריתם שיטת ניוטון|Newton–Raphson]] method to the inverse kinematics problem. The result is an iterative numerical algorithm which, provided that an initial guess of the joint variables is sufficiently close to a true solution, converges quickly to that solution.

## Analytic Inverse Kinematics

We begin by writing the forward kinematics of a spatial six-dof open chain using the Denavit-Hartenberg method:
$$ \mathbf{T}(\theta) = ^{0}\mathbf{T}_{1}(\theta_1) \, ^{1}\mathbf{T}_{2}(\theta_2) \, ^{2}\mathbf{T}_{3}(\theta_3) \, ^{3}\mathbf{T}_{4}(\theta_4) \, ^{4}\mathbf{T}_{5}(\theta_5) \, ^{5}\mathbf{T}_{6}(\theta_6) $$
where each $^{i-1}\mathbf{T}_{i}(\theta_i)$ represents the homogeneous transformation matrix from frame $i-1$ to frame $i$ as a function of joint variable $\theta_i$. Given some desired end-effector frame $\mathbf{X} \in SE(3)$, the inverse kinematics problem is to find solutions $\theta \in \mathbb{R}^6$ satisfying $\mathbf{T}(\theta) = \mathbf{X}$. In the following subsections we derive analytic inverse kinematic solutions for the PUMA and Stanford arms.

### 6R PUMA-Type Arm

We first consider a $\mathrm{6R}$ arm of the PUMA type. Referring the figure below, when the arm is placed in its zero position:
1. the two shoulder joint axes intersect orthogonally at a common point, with joint axis 1 aligned in the $\hat{\mathbf{z}}_0$-direction and joint axis 2 aligned in the $-\hat{\mathbf{y}}_0$-direction;
2. joint axis 3 (the elbow joint) lies in the $\hat{\mathbf{x}}_0–\hat{\mathbf{y}}_0$-plane and is aligned parallel with joint axis 2;
3. joint axes 4, 5, and 6 (the wrist joints) intersect orthogonally at a common point (the wrist center) to form an orthogonal wrist and, for the purposes of this example, we assume that these joint axes are aligned in the $\hat{\mathbf{z}}_0$-, $\hat{\mathbf{y}}_0$-, and $\hat{\mathbf{x}}_0$-directions, respectively.

The lengths of links 2 and 3 are $a_2$ and $a_3$, respectively. The arm may also have an offset at the shoulder.

![[{0584C559-0A56-41B0-A8C6-3C6727E818F1} 2.png|bookhue|600]]
> Inverse position kinematics of a $\mathrm{6R}$ PUMA-type arm. [[IRB1_000 00350001 מבוא לרובוטיקה#ביבליוגרפיה|(Lynch & Park, 2017)]].

![[{C7F3E13E-B663-49D5-9224-EDC146F56525}.png|bookhue|600]]
> A $\mathrm{6R}$ PUMA-type arm with a shoulder offset. [[IRB1_000 00350001 מבוא לרובוטיקה#ביבליוגרפיה|(Lynch & Park, 2017)]].

The inverse kinematics problem for PUMA-type arms can be decoupled into inverse-position and inverse-orientation subproblems, as we now show. We first consider the simple case of a zero-offset PUMA-type arm. Referring to the first figure and expressing all vectors in terms of fixed-frame coordinates, denote the components of the wrist center $\mathbf{p} \in \mathbb{R}^3$ by $\mathbf{p} = (p_x, p_y, p_z)^T$. Projecting $\mathbf{p}$ onto the $\hat{\mathbf{x}}_0–\hat{\mathbf{y}}_0$-plane, it can be seen that
$$ \theta_1 = \mathrm{atan2}(p_y, p_x) $$
Note that a second valid solution for $\theta_1$ is given by
$$ \theta_1 = \mathrm{atan2}(p_y, p_x) + \pi $$
when the original solution for $\theta_2$ is replaced by $\pi - \theta_2$. As long as $p_x, p_y \neq 0$ both these solutions are valid. When $p_x = p_y = 0$ the arm is in a singular configuration (see the figure below), and there are infinitely many possible solutions for $\theta_1$.

![[{90B154F0-92A5-488E-AF2B-3C50A22AF7DC} 1.png|bookhue|150]]
> Singular configuration of the zero-offset $\mathrm{6R}$ PUMA-type arm. [[IRB1_000 00350001 מבוא לרובוטיקה#ביבליוגרפיה|(Lynch & Park, 2017)]].

If there is an offset $d_1 \neq 0$, then in general there will be two solutions for $\theta_1$, the righty and lefty solutions. As seen from the figure, $\theta_1 = \phi - \alpha$ where $\phi = \mathrm{atan2}(p_y, p_x)$ and $\alpha = \mathrm{atan2}(d_1, \sqrt{r^2 - d_1^2})$, with $r = \sqrt{p_x^2 + p_y^2}$. The second solution is given by
$$ \theta_1 = \pi + \mathrm{atan2}(p_y, p_x) + \mathrm{atan2}(-\sqrt{p_x^2 + p_y^2 - d_1^2}, d_1) $$
Determining angles $\theta_2$ and $\theta_3$ for the PUMA-type arm now reduces to the inverse kinematics problem for a planar two-link chain:
$$ \begin{aligned}
\cos \theta_3  & =\dfrac{r^{2}-{{{d}_{1}}}^{2}+{{{p}_{z}}}^{2}-{{{a}_{2}}}^{2}-{{{a}_{3}}}^{2}}{2{a}_{2}{a}_{3}} \\[1ex]
 & = \frac{p_x^2 + p_y^2 + p_z^2 - d_1^2 - a_2^2 - a_3^2}{2a_2a_3} = D
\end{aligned} $$
Using $D$ defined above, $\theta_3$ is given by
$$ \theta_3 = \mathrm{atan2}(\pm\sqrt{1 - D^2}, D) $$
and $\theta_2$ can be obtained in a similar fashion as
$$ \begin{aligned}
\theta_2  & =\mathrm{atan2}({p}_{z},\sqrt{ r^{2}-{{{d}_{1}}}^{2}}-\mathrm{atan2}({a}_{3}{s}_{3},{a}_{2}+{a}_{3}{c}_{3}) \\[1ex]
 & = \mathrm{atan2}(p_z, \sqrt{p_x^2 + p_y^2 - d_1^2}) - \mathrm{atan2}(a_3s_3, a_2 + a_3c_3)
\end{aligned} $$
where $s_3 = \sin \theta_3$ and $c_3 = \cos \theta_3$. The two solutions for $\theta_3$ correspond to the well-known elbow-up and elbow-down configurations for the two-link planar arm. In general, a PUMA-type arm with an offset will have four solutions to the inverse position problem, as shown in the following figure;
![[{C7E17746-F9B6-49F8-ABDC-28253CE4BE41}.png|bookhue|500]]
>Four possible inverse kinematics solutions for the $\mathrm{6R}$ PUMA-type arm with shoulder offset. [[IRB1_000 00350001 מבוא לרובוטיקה#ביבליוגרפיה|(Lynch & Park, 2017)]].

the postures in the upper panel are lefty solutions (elbow-up and elbow-down), while those in the lower panel are righty solutions (elbow-up and elbow-down).

We now solve the inverse orientation problem of finding $(\theta_4, \theta_5, \theta_6)$ given the end-effector orientation. This problem is completely straightforward: having found $(\theta_1, \theta_2, \theta_3)$, the forward kinematics can be manipulated into the form

$$ ^{3}\mathbf{T}_{4} \, ^{4}\mathbf{T}_{5} \, ^{5}\mathbf{T}_{6} = (^{0}\mathbf{T}_{1} \, ^{1}\mathbf{T}_{2} \, ^{2}\mathbf{T}_{3})^{-1} \mathbf{X} = (^{2}\mathbf{T}_{3})^{-1} (^{1}\mathbf{T}_{2})^{-1} (^{0}\mathbf{T}_{1})^{-1} \mathbf{X} \tag{LP6.2} $$
where $\mathbf{X}$ is the desired end-effector transformation and the right-hand side is now known. The transformation matrices $^{3}\mathbf{T}_{4}$, $^{4}\mathbf{T}_{5}$, and $^{5}\mathbf{T}_{6}$ correspond to rotations about the wrist joint axes:
- $^{3}\mathbf{T}_{4}$: rotation about the $\hat{\mathbf{z}}$-axis by angle $\theta_4$
- $^{4}\mathbf{T}_{5}$: rotation about the $\hat{\mathbf{y}}$-axis by angle $\theta_5$  
- $^{5}\mathbf{T}_{6}$: rotation about the $\hat{\mathbf{x}}$-axis by angle $\theta_6$

Denoting the rotation matrix component of the right-hand side of Equation $\text{(LP6.2)}$ by $\mathbf{R}$, the wrist joint angles $(\theta_4, \theta_5, \theta_6)$ can be determined as the solution to
$$ \mathrm{Rot}(\hat{\mathbf{z}}, \theta_4)\mathrm{Rot}(\hat{\mathbf{y}}, \theta_5)\mathrm{Rot}(\hat{\mathbf{x}}, \theta_6) = \mathbf{R} $$

### Stanford-Type Arms

If the elbow joint in a $\mathrm{6R}$ PUMA-type arm is replaced by a prismatic joint, as shown in the following figure, we then have an $\mathrm{RRPRRR}$ Stanford-type arm. Here we consider the inverse position kinematics for the arm of the figure; the inverse orientation kinematics is identical to that for the PUMA-type arm and so is not repeated here.

![[{79C17852-35A2-4BBF-9352-F4C468D9BFC8}.png|bookhue|500]]
> The first three joints of a Stanford-type arm. [[IRB1_000 00350001 מבוא לרובוטיקה#ביבליוגרפיה|(Lynch & Park, 2017)]].

The first joint variable $\theta_1$ can be found in similar fashion to the PUMA-type arm: $\theta_1 = \mathrm{atan2}(p_y, p_x)$ (provided that $p_x$ and $p_y$ are not both zero). The variable $\theta_2$ is then found from the figure above to be
$$ \theta_2 = \mathrm{atan2}(s, r) $$
where $r = \sqrt{p_x^2 + p_y^2}$ and $s = p_z - d_1$. Similarly to the case of the PUMA-type arm, a second solution for $\theta_1$ and $\theta_2$ is given by
$$ \theta_1 = \pi + \mathrm{atan2}(p_y, p_x), \quad \theta_2 = \pi - \mathrm{atan2}(s, r) $$
The translation distance $\theta_3$ (which is the joint variable for the prismatic joint) is found from the relation $(\theta_3 + a_2)^2 = r^2 + s^2$ as
$$ \theta_3 = \sqrt{r^2 + s^2} - a_2 = \sqrt{p_x^2 + p_y^2 + (p_z - d_1)^2} - a_2 $$
Ignoring the negative square root solution for $\sqrt{r^2+s^2}$ (as $\theta_3+a_2$ typically represents a positive length), we obtain two solutions to the inverse position kinematics as long as the wrist center $\mathbf{p}$ does not intersect the $\hat{\mathbf{z}}_0$-axis of the fixed frame. If there is an offset then, as in the case of the PUMA-type arm, there will be lefty and righty solutions.

# Exercises

## Question 1

Compute the inverse kinematics of the following manipulator:

![[IRB1_002 Forward Kinematics 2025-04-30 21.25.38.excalidraw.svg]]
>Simple robot with one revolute and one prismatic joint.

The forward kinematics are:
$$ ^{0}\mathbf{T}_{2} = \begin{pmatrix}
{c}_{1} & 0 & {s}_{1} & {d}_{2}+b{c}_{1} \\
{s}_{1} & 0 & -{c}_{1} & -{d}_{2}{c}_{1}+b{s}_{1} \\
0 & 1 & 0 & 0 \\
0 & 0 & 0 & 1
\end{pmatrix}$$
where ${c}_{1}:=\cos{\theta}_{1}$ and ${s}_{1}:=\sin{\theta}_{1}$.

**Solution**:
Given ${p}_{x}$ and ${p}_{y}$, we want to move the robot so that:
$$\begin{aligned}
 & {p}_{x}={d}_{2}+b{c}_{1} \\
 & {p}_{y}=-{d}_{2}{c}_{1}+b{s}_{1}
\end{aligned}$$
Meaning, we need to find ${d}_{2}$ and ${\theta}_{1}$. Squaring both equations we get
$$\begin{gathered}
{{{p}_{x}}}^{2}+{{{p}_{y}}}^{2}=(b^{2}{{{c}_{1}}}^{2}+2b{c}_{1}{d}_{2}{s}_{1}+{{{d}_{2}}}^{2}{{{s}_{1}}}^{2})+(b^{2}{{{s}_{1}}}^{2}-2b{c}_{1}{d}_{2}{s}_{1}+{{{d}_{2}}}^{2}{{{c}_{1}}}^{2}) \\[1ex]
{{{p}_{x}}}^{2}+{{{p}_{y}}}^{2}=b^{2}+{{{d}_{2}}}^{2} \\[1ex]
\boxed {
{d}_{2}=\pm \sqrt{ {{{p}_{x}}}^{2}+{{{p}_{y}}}^{2}-b^{2} }
 }
\end{gathered}$$

Now that we know ${d}_{2}$, we can't write our system of equations in a matrix form:
$$\begin{pmatrix}
{p}_{x} \\
{p}_{y}
\end{pmatrix}=\begin{pmatrix}
b & {d}_{2} \\
-{d}_{2} & b
\end{pmatrix}\begin{pmatrix}
{c}_{1} \\
{s}_{1}
\end{pmatrix}$$
Solving for ${c}_{1}$ and ${s}_{1}$ (inversing the matrix), we get:
$$\begin{aligned}
 & {c}_{1}=\dfrac{b{p}_{x}-{d}_{2}{p}_{y}}{b^{2}+{{{d}_{2}}}^{2}} \\[1ex]
 & {s}_{1}=\dfrac{{d}_{2}{p}_{x}+b{p}_{y}}{b^{2}+{{{d}_{2}}}^{2}}
\end{aligned}$$
Therefore:
$$\boxed {
\begin{aligned}
{\theta}_{1} & =\mathrm{atan2}({s}_{1},{c}_{1}) \\[1ex]
 & =\mathrm{atan2}\left( \dfrac{{d}_{2}{p}_{x}+b{p}_{y}}{b^{2}+{{{d}_{2}}}^{2}},\, \dfrac{b{p}_{x}-{d}_{2}{p}_{y}}{b^{2}+{{{d}_{2}}}^{2}} \right)
\end{aligned}
 }$$

## Question 2

Given the following manipulator:
![[IRB1_003 Inverse Kinematics 2025-05-23 10.57.40.excalidraw.svg]]
>Simple manipulator.
### Part a

Compute the inverse kinematics.

**Solution**:
Denoting the frames according to the [[IRB1_002 Forward Kinematics#Assigning Link Frames|D–H method]]:
![[IRB1_003 Inverse Kinematics 2025-05-23 10.42.39.excalidraw.svg]]
>Assigning frames.

Therefore, the table:
$$\begin{array}{c|cccc}
i & \alpha _{i} & {a}_{i} & {d}_{i} & {\theta}_{i} \\
\hline 1  & 90^{\circ} & e & h & {\theta}_{1} \\
2 & 90^{\circ}  & 0 & 0 & {\theta}_{2} \\
3 & 0 & 0 & {d}_{3} & 0
\end{array}$$
The forward kinematics are:
$$^{0}\mathbf{T}_{3}=\begin{pmatrix}
{c}_{1}{c}_{2}{c}_{3}+{s}_{1}{s}_{3} & -{c}_{1}{c}_{2}{s}_{3}+{s}_{1}{c}_{3} & {c}_{1}{s}_{2} & {d}_{3}{c}_{1}{s}_{2}+e{c}_{1} \\
{s}_{1}{c}_{2}{c}_{3}-{c}_{1}{s}_{3} & -{s}_{1}{c}_{2}{s}_{3}-{c}_{1}{c}_{3} & {s}_{1}{s}_{2} & {d}_{3}{s}_{1}{s}_{2}+e{s}_{2} \\
{s}_{2}{c}_{3} & -{s}_{2}{s}_{3} & -{c}_{2} & -{d}_{3}{c}_{2}+h \\
0 & 0 & 0 & 1
\end{pmatrix}$$

Given ${p}_{x}$, ${p}_{y}$ and ${p}_{z}$ we want to move the robot so that:
$$\begin{align}
 & {p}_{x}={d}_{3}{c}_{1}{s}_{2}+e{c}_{1} \tag{E2.1} \\[1ex]
 & {p}_{y}={d}_{3}{s}_{1}{s}_{2}+e{s}_{2} \tag{E2.2}\\[1ex]
 & {p}_{z}=-{d}_{3}{c}_{2}+h\tag{E2.3}
\end{align}$$
First, we compute ${\theta}_{1}$. From $\text{(E2.1)}$ and $\text{(E2.2)}$:
$$\begin{aligned}
 & {c}_{1}=\dfrac{{p}_{x}}{{d}_{3}{s}_{2}+e} &  & {s}_{1}=\dfrac{{p}_{y}}{{d}_{3}{s}_{2}+e}
\end{aligned}$$
Therefore:
$$\begin{aligned}
{\theta}_{1} & =\mathrm{atan2}({s}_{1},{c}_{1}) \\[1ex]
 & =\mathrm{atan2}\left( \dfrac{{p}_{y}}{{d}_{3}{s}_{2}+e},\dfrac{{p}_{x}}{{d}_{3}{s}_{2}+e} \right)
\end{aligned}$$
Thing is, we don't know ${d}_{3}$ or ${\theta}_{2}$ - that's a problem. But, we note the denominators are identical. So maybe in the $\mathrm{atan2}$ they cancel out? Well, no, because:
$${\theta}_{1}=\mathrm{atan2}\left( \dfrac{{p}_{y}}{{d}_{3}{s}_{2}+e},\dfrac{{p}_{x}}{{d}_{3}{s}_{2}+e} \right)\neq \mathrm{atan}\left( \dfrac{{p}_{y}}{{p}_{x}} \right)$$
That is because we don't know the sign of ${d}_{3}{s}_{2}+e$. What we can do though is split into the two options:
- if ${d}_{3}{s}_{2}+e>0$, then:
	$$\begin{aligned}
{\theta}_{1} & =\mathrm{atan2}\left( \dfrac{{p}_{y}}{{d}_{3}{s}_{2}+e},\dfrac{{p}_{x}}{{d}_{3}{s}_{2}+e} \right) \\[1ex]
 & =\mathrm{atan2}({p}_{y},{p}_{x})
\end{aligned}$$
- if ${d}_{3}{s}_{2}+e<0$, then:
	$$\begin{aligned}
	{\theta}_{1} & =\mathrm{atan2}\left( \dfrac{{p}_{y}}{{d}_{3}{s}_{2}+e},\dfrac{{p}_{x}}{{d}_{3}{s}_{2}+e} \right) \\[1ex]
 	& =\mathrm{atan2}(-{p}_{y},-{p}_{x}) \\[1ex]
 	& =\mathrm{atan2}({p}_{y},{p}_{x})+\pi
\end{aligned}$$
So basically:
$$\boxed {
{\theta}_{1}=\mathrm{atan2}(\pm {p}_{y},\pm {p}_{x})
 }$$

Now we can move to ${\theta}_{2}$. From $\text{(E2.1)}$ and $\text{(E2.3)}$:
$$\begin{aligned}
 & {s}_{2}=\dfrac{{p}_{x}-e{c}_{1}}{{d}_{3}{c}_{1}} &  & {c}_{2}=\dfrac{(h-{p}_{z})}{{d}_{3}}
\end{aligned}$$
As before, ${d}_{3}$ can be either positive or negative, so there are two possible solutions:
$$\boxed {
{\theta}_{2}=\mathrm{atan2}\left( \pm  \dfrac{{p}_{x}-e{c}_{1}}{{c}_{1}},\pm (h-{p}_{z}) \right)
 }$$

Regarding ${d}_{3}$, from $\text{(E2.3)}$ we get:
$$\boxed {
{d}_{3}=\dfrac{h-{p}_{z}}{{c}_{2}}
 }$$

We therefore have 4 solutions.
### Part b
Write the inverse kinematics solution as a function of the target point $P$ and the following decision parameters:
$$\begin{aligned}
 & \mathrm{ARM}=\begin{cases}
+1\quad (\text{right arm}) &  & -90^{\circ} \leq  {\theta}_{1}\leq  90^{\circ} \\
-1\quad (\text{left arm}) &  & 90^{\circ} <  {\theta}_{1}<  270^{\circ}
\end{cases} \\[1ex]
 & \mathrm{ELB}=\begin{cases}
+1\quad (\text{elbow up}) &  & 90^{\circ} \leq  {\theta}_{2}\leq   270^{\circ}  \\
-1\quad \text{(elbow down} &  & -90^{\circ} <{\theta}_{2}<90^{\circ} 
\end{cases}
\end{aligned}$$
- The four solutions have a distinct geometrical interpretation of the manipulator's pose.
- The idea is to allow the user to determine the manipulator's pose by setting $\mathrm{ARM}$ and $\mathrm{ELB}$.

Let us examine the relation between $\mathrm{ARM}$ and $\mathrm{sgn}({p}_{x})$:
- if $\mathrm{ARM}\cdot \mathrm{sgn}({p}_{x})=1$, then ${\theta}_{1}=\mathrm{atan2}({p}_{y},{p}_{x})$
- if $\mathrm{ARM}\cdot \mathrm{sgn}({p}_{x})=-1$, then ${\theta}_{1}=\mathrm{atan2}({p}_{y},{p}_{x})+\pi$

We can therefore write the solution as:
$$\boxed {
{\theta}_{1}=\mathrm{atan2}({p}_{y},{p}_{x})+\dfrac{\pi}{2}(1-\mathrm{ARM}\cdot \mathrm{sgn}({p}_{x}))
 }$$
![[IRB1_003 Inverse Kinematics 2025-05-23 16.17.32.excalidraw.svg]]
>Distinction between left arm and right arm.

Let us examine the relation between $\mathrm{ELB}$ and $\mathrm{sgn}({p}_{x})$:
- if $\mathrm{ELB}\cdot \mathrm{sgn}(h-{p}_{z})=-1$, then 
	$${\theta}_{2}=\mathrm{atan2}\left(\dfrac{{p}_{x}-e{c}_{1}}{{c}_{1}},h-{p}_{z}\right)$$
- if $\mathrm{ELB}\cdot \mathrm{sgn}(h-{p}_{z})=1$, then 
	$${\theta}_{2}=\mathrm{atan2}\left(\dfrac{{p}_{x}-e{c}_{1}}{{c}_{1}},h-{p}_{z}\right)+\pi$$

We can therefore write the solution as:
$$\boxed {
{\theta}_{2}=\mathrm{atan2}\left(\dfrac{{p}_{x}-e{c}_{1}}{{c}_{1}},h-{p}_{z}\right)+\dfrac{\pi}{2}(1-\mathrm{ELB}\cdot \mathrm{sgn}(h-{p}_{z}))
}$$

 
