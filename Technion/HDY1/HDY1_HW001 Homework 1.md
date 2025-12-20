---
title: Homework 1 - The Falling Cat
---

| **Course**    | Hybrid Dynamics in Mechanical Systems |
| ------------- | ------------------------------------- |
| Course Number | 00360087                              |

| Ido Fang Bentov                |
| ------------------------------ |
| 322869140                      |
| ido.fang@campus.technion.ac.il |

>[!quote] Declaration of independent work
>I confirm that this submission reflects my own work and understanding. ChatGPT/Claude/Gemini were used solely to validate algebraic manipulations, and all results were independently reviewed.

**MATLAB Code**: All related code files can be found on [GitHub](https://github.com/NuclearGandhi/technion_second_brain/tree/master/Technion/HDY1/HDY1_HW001/code) as well as [OneDrive](https://technionmail-my.sharepoint.com/:f:/g/personal/ido_fang_campus_technion_ac_il/Encd0py5BttIjotdCrUxRawBEwhIAl4odQ7NoRQ2-NB_uQ?e=dPUsM1).

<div><hr><hr></div>


# Introduction
We are given a three-link robot connected by two actuated joints with the following generalized coordinates:
$$\mathbf{q}=\begin{pmatrix}
x \\
y \\
\theta \\
{\phi}_{1} \\
{\phi}_{2}
\end{pmatrix}$$

![[HDY1_HW001 Homework 1 2025-11-18 20.21.38.excalidraw.svg]]^figure-given-fbd
>Given robot.

Gravity acts along $-\mathbf{e}_{2}$ and torques ${\tau}_{1},{\tau}_{2}$ command the relative angles ${\phi}_{1},{\phi}_{2}$ while $\theta$ orients the middle link centered at $(x,y)$. The links are identical slender rods of length $2\ell$ and mass $m$, with uniform mass distribution and central moment of inertia $I=m\ell^{2}/3$.

<div><hr><hr></div>

# Assignment 1
Write expressions for components ${x}_{c},{y}_{c}$ of the robot's total center of mass position $C$ depending on coordinates $\mathbf{q}$, and of velocities $\dot{x}_{c},\dot{y}_{c}$ depending on $\mathbf{q},\dot{\mathbf{q}}$. Explain.

**Solution**:
The total mass position depends on the center of mass of the three links (equally, as they are all the same mass):

Each link's position is:
$$\begin{aligned}
 & \mathbf{r}_{0}=x\mathbf{e}_{1}+y\mathbf{e}_{2} \\[1ex]
 & \mathbf{r}_{1}=[x-\ell \cos\theta-\ell \cos (\theta+{\phi}_{1})]\mathbf{e}_{1}+[y-\ell\sin\theta-\ell\sin(\theta+{\phi}_{1})]\mathbf{e}_{2} \\[1ex]
 & \mathbf{r}_{2}=[x+\ell \cos\theta+\ell \cos(\theta+{\phi}_{2})]\mathbf{e}_{1}+[y+\ell\sin\theta+\ell\sin(\theta+{\phi}_{2})]\mathbf{e}_{2}
\end{aligned}$$

Therefore the total center of mass position is:
$$\begin{aligned}
\mathbf{r}_{c} & =\dfrac{1}{3}(\mathbf{r}_{0}+\mathbf{r}_{1}+\mathbf{r}_{2}) \\[1ex]
 & =\left[ x-\dfrac{1}{3}\ell \cos(\theta+{\phi}_{1})+\dfrac{1}{3}\ell \cos(\theta+{\phi}_{2}) \right]\mathbf{e}_{1} \\[1ex]
 & \qquad +\left[ y-\dfrac{1}{3}\ell \sin(\theta+{\phi}_{1})+\dfrac{1}{3}\ell \sin(\theta+{\phi}_{2}) \right]\mathbf{e}_{2}
\end{aligned}$$

Using [[BMA1_009 זהויות טריגונומטריות#זהויות מכפלה|trigonometric identities]] we can write:
$$\begin{aligned}
 & \cos(\theta+{\phi}_{2})-\cos(\theta+{\phi}_{1})=-2\sin\left( \theta+\dfrac{{\phi}_{1}+{\phi}_{2}}{2} \right)\sin\left( \dfrac{{\phi}_{2}-{\phi}_{1}}{2} \right) \\[1ex]
 & \sin(\theta+{\phi}_{2})-\sin(\theta+{\phi}_{1})=2\cos\left( \theta+\dfrac{{\phi}_{1}+{\phi}_{2}}{2} \right)\sin\left( \dfrac{{\phi}_{2}-{\phi}_{1}}{2} \right)
\end{aligned}$$
Substituting into the centroid position we get:
$$\begin{aligned}
\mathbf{r}_{c} & =x\mathbf{e}_{1}+y\mathbf{e}_{2}+\dfrac{2\ell}{3}\sin\left( \dfrac{{\phi}_{2}-{\phi}_{1}}{2} \right)\left[ -\sin\left( \theta+\dfrac{{\phi}_{1}+{\phi}_{2}}{2} \right)\mathbf{e}_{1}\right. \\[1ex]
 & \qquad \left.+\cos\left( \theta+\dfrac{{\phi}_{1}+{\phi}_{2}}{2} \right)\mathbf{e}_{2} \right]
\end{aligned}$$

Therefore:
$$\boxed{\begin{aligned}
 & {x}_{c}=x-\dfrac{2\ell}{3}\sin\left( \dfrac{{\phi}_{2}-{\phi}_{1}}{2} \right)\sin\left( \theta+\dfrac{{\phi}_{1}+{\phi}_{2}}{2} \right) \\[1ex]
 & {y}_{c}=y+\dfrac{2\ell}{3}\sin\left( \dfrac{{\phi}_{2}-{\phi}_{1}}{2} \right)\cos\left( \theta+\dfrac{{\phi}_{1}+{\phi}_{2}}{2} \right)
\end{aligned} } \tag{HW1.1}$$

Taking the total time derivative of ${x}_{c}(\mathbf{q})$ and ${y}_{c}(\mathbf{q})$ yields the centroid velocity components:

$$\boxed{\begin{aligned}
\dot{x}_{c} & =\dot{x}+\dfrac{\ell}{3}\left[\sin(\theta+{\phi}_{1})(\dot{\theta}+\dot{\phi}_{1})-\sin(\theta+{\phi}_{2})(\dot{\theta}+\dot{\phi}_{2})\right] \\[1ex]
\dot{y}_{c} & =\dot{y}-\dfrac{\ell}{3}\cos(\theta+{\phi}_{1})(\dot{\theta}+\dot{\phi}_{1})+\dfrac{\ell}{3}\cos(\theta+{\phi}_{2})(\dot{\theta}+\dot{\phi}_{2})
\end{aligned}} \tag{HW1.2}$$

The terms proportional to $\ell/3$ capture the symmetric contributions of links $1$ and $2$ relative to the actuated joint angles, whereas $\dot{x},\dot{y}$ track the translational motion of the middle link.

<div><hr><hr></div>

# Assignment 2
Write expression for the robot's total angular momentum ${H}_{c}$ about its center of mass $C$, a scalar component in $\mathbf{e}_{3}$ direction, Arrange it in the form
$${H}_{c}={f}_{0}({\phi}_{1},{\phi}_{2})\dot{\theta}+{f}_{1}({\phi}_{1},{\phi}_{2})\dot{\phi}_{1}+{f}_{2}({\phi}_{1},{\phi}_{2})\cdot \dot{\phi}_{2}$$

**Solution**:
Total angular momentum about center of mass is given by:
$${H}_{c}=\sum_{i=0}^{2}[m(\mathbf{r}_{i c}\times \dot{\mathbf{r}}_{i c})+{I}_{i}{\omega}_{i}] $$
where the notation $\mathbf{r}_{ic}$ is the position of link $i$ relative to the total center of mass:
$$\mathbf{r}_{ic}=\mathbf{r}_{i}-\mathbf{r}_{c}$$

Since all links share the same mass $m$ and $I_{0}=I_{1}=I_{2}=m\ell^{2}/3$, the translational parts depend only on the relative vectors $\mathbf{r}_{ic},\dot{\mathbf{r}}_{ic}$ while the rotational part adds $\omega_{0}=\dot{\theta}$, $\omega_{1}=\dot{\theta}+\dot{\phi}_{1}$, $\omega_{2}=\dot{\theta}+\dot{\phi}_{2}$. Collecting terms and eliminating the body translation (which cancels because $\sum \mathbf{r}_{ic}=0$) gives:
$$\boxed{\begin{aligned}
{H}_{c} & =\dfrac{m\ell^{2}}{3}\Big[\left(6\cos{\phi}_{1}+6\cos{\phi}_{2}+2\cos({\phi}_{1}-{\phi}_{2})+13\right)\dot{\theta} \\[1ex]
 & \qquad +\left(3\cos{\phi}_{1}+\cos({\phi}_{1}-{\phi}_{2})+3\right)\dot{\phi}_{1} \\[1ex]
 & \qquad +\left(3\cos{\phi}_{2}+\cos({\phi}_{1}-{\phi}_{2})+3\right)\dot{\phi}_{2}\Big]
\end{aligned}} \tag{HW1.3}$$
Therefore:
$$\begin{aligned}
 & {f}_{0}({\phi}_{1},{\phi}_{2})=\dfrac{m\ell^{2}}{3}\left[6\cos{\phi}_{1}+6\cos{\phi}_{2}+2\cos({\phi}_{1}-{\phi}_{2})+13\right] \\[1ex]
 & {f}_{1}({\phi}_{1},{\phi}_{2})=\dfrac{m\ell^{2}}{3}\left[3\cos{\phi}_{1}+\cos({\phi}_{1}-{\phi}_{2})+3\right] \\[1ex]
 & {f}_{2}({\phi}_{1},{\phi}_{2})=\dfrac{m\ell^{2}}{3}\left[3\cos{\phi}_{2}+\cos({\phi}_{1}-{\phi}_{2})+3\right]
\end{aligned}$$

<div><hr><hr></div>

# Assignment 3
Draw forces and torques diagram for link $2$ (the rightmost). Write a scalar equation for balance of the link's angular momentum about the joint position $\mathbf{p}_{2}$. The equation should include terms depending on $\mathbf{q},\dot{\mathbf{q}},\ddot{\mathbf{q}}$, gravity force $mg$ and joint toque ${\tau}_{2}$, but no internal reaction forces.

**Solution**:
![[HDY1_HW001 Homework 1 2025-11-21 09.22.59.excalidraw.svg]]^figure-link2-fbd
>Forces and torques diagram for link $2$. $\mathbf{F}_{2/0}$ is the equivalent force that link $0$ exerts on link $2$ at the joint (in a arbitrary direction).

The angular momentum balance for the moving joint $\mathbf{p}_{2}$ must include the inertial term:
$$\dot{H}_{{p}_{2}} + (\dot{\mathbf{r}}_{p_{2}}\times m\dot{\mathbf{r}}_{2})\cdot\mathbf{e}_{3} = {M}_{{p}_{2}} \tag{HW1.4}$$
Where the inertial term accounts for the acceleration of the reference point.

The joint position is
$$\mathbf{r}_{{p}_{2}}=(x+\ell\cos\theta)\mathbf{e}_{1}+(y+\ell\sin\theta)\mathbf{e}_{2}$$
and the link-$2$ center of mass is
$$\mathbf{r}_{2}=[x+\ell\cos\theta+\ell\cos(\theta+{\phi}_{2})]\mathbf{e}_{1}+[y+\ell\sin\theta+\ell\sin(\theta+{\phi}_{2})]\mathbf{e}_{2}$$
so that
$$\begin{aligned}
\mathbf{r}_{2/p_{2}} & =\mathbf{r}_{2}-\mathbf{p}_{2} \\[1ex]
 & =\ell\cos(\theta+{\phi}_{2})\mathbf{e}_{1}+\ell\sin(\theta+{\phi}_{2})\mathbf{e}_{2}
\end{aligned}$$

Differentiating $\mathbf{r}_{2}$ gives the absolute velocity of the link-$2$ center of mass:
$$\begin{aligned}
\dot{\mathbf{r}}_{2} & =\left[\dot{x}-\ell\dot{\theta}\sin\theta-\ell(\dot{\theta}+\dot{\phi}_{2})\sin(\theta+{\phi}_{2})\right]\mathbf{e}_{1} \\[1ex]
 & \qquad +\left[\dot{y}+\ell\dot{\theta}\cos\theta+\ell(\dot{\theta}+\dot{\phi}_{2})\cos(\theta+{\phi}_{2})\right]\mathbf{e}_{2}
\end{aligned}$$
The required cross product for angular momentum calculation:
$$\begin{aligned}
\left( \mathbf{r}_{2/p_{2}}\times \dot{\mathbf{r}}_{2} \right)\cdot \mathbf{e}_{3} & =\ell\cos(\theta+{\phi}_{2})\left[\dot{y}+\ell\dot{\theta}\cos\theta+\ell(\dot{\theta}+\dot{\phi}_{2})\cos(\theta+{\phi}_{2})\right] \\[1ex]
 & \qquad -\ell\sin(\theta+{\phi}_{2})\left[\dot{x}-\ell\dot{\theta}\sin\theta-\ell(\dot{\theta}+\dot{\phi}_{2})\sin(\theta+{\phi}_{2})\right]
\end{aligned}$$
The total angular momentum about the moving joint is then
$$\begin{aligned}
{H}_{{p}_{2}} & =I_{c}(\dot{\theta}+\dot{\phi}_{2})+m\left( \mathbf{r}_{2/p_{2}}\times \dot{\mathbf{r}}_{2} \right)\cdot \mathbf{e}_{3} \\[1ex]
 & =\dfrac{m\ell}{3}\left[ 4\ell\dot{\theta}+4\ell\dot{\phi}_{2}+3\dot{\theta}\ell\cos{\phi}_{2}-3\dot{x}\sin(\theta+{\phi}_{2})+3\dot{y}\cos(\theta+{\phi}_{2}) \right]
\end{aligned}$$

External torques about $\mathbf{p}_{2}$ consist of the applied motor torque and the gravitational moment:
$${M}_{{p}_{2}}={\tau}_{2}-mg\ell\cos(\theta+{\phi}_{2})$$
Substituting into $\text{(HW1.4)}$ we get:

$$\boxed{\begin{aligned}
\dfrac{4\ell}{3}\ddot{\phi}_{2} & +\ell\left( \cos {\phi}_{2}+\dfrac{4}{3} \right)\ddot{\theta}-\sin(\theta+{\phi}_{2})\ddot{x}+\cos(\theta+{\phi}_{2})\ddot{y} \\[1ex]
 & \qquad +\ell\sin{\phi}_{2}\dot{\theta}^{2} \\[2ex]
 & \qquad +g\cos(\theta+{\phi}_{2})=\dfrac{{\tau}_{2}}{m\ell}
\end{aligned}} \tag{HW1.5}$$

<div><hr><hr></div>

# Assignment 4
Write the robot's dynamic equation of motion using Lagrange's formulation, and arrange in matrix form. Explain all stages of derivation.


**Solution**:
Using symbolic calculations in MATLAB, the kinetic and potential energies are:
$$\begin{aligned}
T & =\frac{m}{2}\sum_{i=0}^{2}\dot{\mathbf{r}}_{i}^{T}\dot{\mathbf{r}}_{i}+\frac{m\ell^{2}}{6}\sum_{i=0}^{2}\omega_{i}^{2} \\[1ex]
V & =m g\sum_{i=0}^{2}\left(\mathbf{r}_{i}\cdot \mathbf{e}_{2}\right)
\end{aligned} \tag{HW1.6}$$
Evaluating these sums yields
$$\begin{align}
T & = m\Bigg[
\frac{3}{2}\left(\dot{x}^{2}+\dot{y}^{2}\right) \\[1ex]
& \qquad + \ell\Big(
-\big(\dot{y}(\dot{\phi}_{1}+\dot{\theta})\cos\phi_{1}-\dot{y}(\dot{\phi}_{2}+\dot{\theta})\cos\phi_{2} \\[0.5ex]
& \qquad\qquad - \left[(\dot{\phi}_{1}+\dot{\theta})\sin\phi_{1}-(\dot{\phi}_{2}+\dot{\theta})\sin\phi_{2}\right]\dot{x}\big)\cos\theta \\[0.5ex]
& \qquad\qquad + \big(\dot{x}(\dot{\phi}_{1}+\dot{\theta})\cos\phi_{1}-\dot{x}(\dot{\phi}_{2}+\dot{\theta})\cos\phi_{2} \\[0.5ex]
& \qquad\qquad\qquad + \left[(\dot{\phi}_{1}+\dot{\theta})\sin\phi_{1}-(\dot{\phi}_{2}+\dot{\theta})\sin\phi_{2}\right]\dot{y}\big)\sin\theta
\Big) \\[1ex]
& \qquad + \ell^{2}\Big(
\dot{\theta}(\dot{\phi}_{1}+\dot{\theta})\cos\phi_{1}+\dot{\theta}(\dot{\phi}_{2}+\dot{\theta})\cos\phi_{2} \\[0.5ex]
& \qquad\qquad + \frac{5}{2}\dot{\theta}^{2}+\frac{4}{3}(\dot{\phi}_{1}+\dot{\phi}_{2})\dot{\theta}+\frac{2}{3}{{\dot{\phi}_{1}}}^{2}+\frac{2}{3}{{\dot{\phi}_{2}}}^{2}
\Big)
\Bigg] \\[2ex]
V & = m g\left(3y-\ell\sin(\theta+\phi_{1})+\ell\sin(\theta+\phi_{2})\right)
\end{align}$$
with $\omega_{0}=\dot{\theta}$, $\omega_{1}=\dot{\theta}+\dot{\phi}_{1}$, $\omega_{2}=\dot{\theta}+\dot{\phi}_{2}$. The Lagrangian $\mathcal{L}=T-V$ produces Euler–Lagrange equations that can be written in compact matrix form as
$$\mathbf{M}(\mathbf{q})\ddot{\mathbf{q}}+\mathbf{B}(\mathbf{q},\dot{\mathbf{q}})+\mathbf{G}(\mathbf{q})=\boldsymbol{\tau}$$
where $\mathbf{q}=[x,\,y,\,\theta,\,\phi_{1},\,\phi_{2}]^{T}$, $\boldsymbol{\tau}=[0,\,0,\,0,\,\tau_{1},\,\tau_{2}]^{T}$.

Splitting the coordinates into body and shape sets,
$$\mathbf{q}_{b}=[x,\,y,\,\theta]^{T},\qquad \mathbf{q}_{s}=[\phi_{1},\,\phi_{2}]^{T}$$
produces the block partitions needed for the under-actuated structure as [[HDY1_001 Introduction#Locomotion of Under-Actuated Robots|presented in the lecture]] with [[HDY1_001 Introduction|equation]] $\text{(1.2)}$:

$$\boxed{\begin{bmatrix}
\mathbf{M}_{bb} & \mathbf{0}_{3\times 2} \\[1ex]
\mathbf{M}_{bs}^{T} & \mathbf{I}_{2}
\end{bmatrix}\begin{bmatrix}
\ddot{\mathbf{q}}_{b} \\[1ex]
\mathbf{F}_{\mathbf{q}_{s}}
\end{bmatrix}=
\begin{bmatrix}
-\mathbf{M}_{bs}\ddot{\mathbf{q}}_{s}-\mathbf{B}_{b}-\mathbf{G}_{b} \\[1ex]
-\mathbf{M}_{ss}\ddot{\mathbf{q}}_{s}-\mathbf{B}_{s}-\mathbf{G}_{s}
\end{bmatrix}} \tag{HW1.7}$$

Where, from the Lagrangian $\mathcal{L}$, we can write:

$$\begin{aligned}
 & \mathbf{M}_{bb}  = \tiny m\begin{pmatrix}
3 & 0 & (\sin(\theta+\phi_{1})-\sin(\theta+\phi_{2}))\ell \\
0 & 3 & -(\cos(\theta+\phi_{1})-\cos(\theta+\phi_{2}))\ell \\
(\sin(\theta+\phi_{1})-\sin(\theta+\phi_{2}))\ell & -(\cos(\theta+\phi_{1})-\cos(\theta+\phi_{2}))\ell & (5+2\cos\phi_{1}+2\cos\phi_{2})\ell^{2}
\end{pmatrix} \\[3ex]
 & \mathbf{M}_{bs} = m\begin{pmatrix}
\sin(\theta+\phi_{1})\ell & -\sin(\theta+\phi_{2})\ell \\
-\cos(\theta+\phi_{1})\ell & \cos(\theta+\phi_{2})\ell \\
(\cos\phi_{1}+4/3)\ell^{2} & (\cos\phi_{2}+4/3)\ell^{2}
\end{pmatrix} \\[3ex]
 & \mathbf{M}_{ss}  = m\ell^{2}\begin{pmatrix}
4/3 & 0 \\
0 & 4/3
\end{pmatrix} \\[3ex]
 & \mathbf{B}_{b}  = m\ell\begin{pmatrix}
-(\dot{\phi}_{1}+\dot{\theta})^{2}\cos(\theta+\phi_{1})+(\dot{\phi}_{2}+\dot{\theta})^{2}\cos(\theta+\phi_{2}) \\
-(\dot{\phi}_{1}+\dot{\theta})^{2}\sin(\theta+\phi_{1})+(\dot{\phi}_{2}+\dot{\theta})^{2}\sin(\theta+\phi_{2}) \\
-\ell\left[\dot{\phi}_{1}(\dot{\phi}_{1}+2\dot{\theta})\sin\phi_{1}+\dot{\phi}_{2}(\dot{\phi}_{2}+2\dot{\theta})\sin\phi_{2}\right]
\end{pmatrix} \\[3ex]
 & \mathbf{B}_{s} = m\ell^{2}\begin{pmatrix}
\dot{\theta}^{2}\sin\phi_{1} \\
\dot{\theta}^{2}\sin\phi_{2}
\end{pmatrix} \\[3ex]
 & \mathbf{G}_{b} = \begin{pmatrix}
0 \\
3 g m \\
-m\ell g\left[\cos(\theta+\phi_{1})-\cos(\theta+\phi_{2})\right]
\end{pmatrix}  \\[1ex]
 & \mathbf{G}_{s}  = m\ell g\begin{pmatrix}
-\cos(\theta+\phi_{1}) \\
\cos(\theta+\phi_{2})
\end{pmatrix}
\end{aligned}$$

and $\mathbf{F}_{\mathbf{q}_{s}}=[\tau_{1},\,\tau_{2}]^{T}$ are the actuation torques extracted once the prescribed shape accelerations $\ddot{\mathbf{q}}_{s}$ are known.

<div><hr><hr></div>

# Assignment 5
Physical values are given as $m=\pu{1kg},\,g=\pu{10m.s^{-2}},\,\ell=\pu{0.1m}$. At the initial time $t=0$, the robot is released from rest in horizontal posture, $\mathbf{q}(0)=0,\,\dot{\mathbf{q}}(0)=0$, The joint angles are prescribed in time as $$\begin{aligned}
 & {\phi}_{1}(t)=S(t)[-\alpha+\beta \sin(\omega t-\psi)] \\[1ex]
 & {\phi}_{2}(t)=S(t)[\alpha +\beta \sin(\omega t+\psi)]
\end{aligned}$$
where
$$\begin{aligned}
 & \alpha =\psi=\pi /4, &  & \beta=\pi /2, &  & \omega=\pu{1rad.s^{-1}}
\end{aligned}$$

The function $S(t)$ for smooth transient is given by:
$$S(t)=\begin{cases}
 t^{3}(6t^{2}-15t\cdot {t}_{f}+10{{{t}_{f}}}^{2})/{{{t}_{f}}}^{5} & t\leq  {t}_{f} \\[1ex]
1 & t>{t}_{f}
\end{cases}\qquad \qquad {t}_{f}=2\pi /\omega$$
Present graphs of the following time plots:

## Figure a
Angle of middle link $\theta(t)$, in degrees.

**Solution**:
The full five-state model was integrated in MATLAB with `ode45` over $0\leq t\leq \pu{40s}$ using $\Delta t=\pu{0.001s}$. The prescribed joint angles excite the middle link and reorient it.

![[HDY1_HW001_PartA.png|bookhue|600]]^figure-hw1-part-a
>Middle-link angle $\theta(t)$ in degrees. (Self-generated simulation.)

The motion remains bounded because angular momentum is internally redistributed by the joint actuation while the total center of mass stays fixed.

<div><hr><hr></div>

## Figure b
Normalized horizontal position of the middle link's center $x(t)/\ell$, overlaid with the center of mass position ${x}_{c}(t)/\ell$, on the same plot. Explain the results.

**Solution**:

![[HDY1_HW001_PartB.png|bookhue|600]]^figure-hw1-part-b
>Normalized horizontal positions $x/\ell$ and $x_{c}/\ell$. (Self-generated simulation.)

[[#^figure-hw1-part-b|Figure]] highlights that link $0$'s geometric center translates significantly even though the overall center of mass hardly moves. This satisfies linear-momentum conservation for the system.

<div><hr><hr></div>

## Figure c
Normalized horizontal velocity of the middle link's center $\dot{x}(t)/(\ell\omega)$, overlaid with the center of mass horizontal velocity $\dot{x}_{c}(t)/(\ell\omega)$, and the normalized total angular momentum ${H}_{c}(t)/(m\ell ^{2}\omega)$, all on the same plot. Explain the results.

**Solution**:

![[HDY1_HW001_PartC.png|bookhue|600]]^figure-hw1-part-c
>Normalized horizontal velocities and angular momentum. (Self-generated simulation.)

[[#^figure-hw1-part-c|figure]] shows that $\dot{x}_{c}$ and $H_{c}/(m\ell^{2}\omega)$ remain effectively zero. Internal actuation therefore reshapes the body without accumulating horizontal translation or global angular momentum. $\dot{x}$ on the other hand, is link $0$'s center of mass horizontal position, and it is free to change as long as the center of mass remains zero.


<div><hr><hr></div>


## Figure d
Normalized horizontal velocity of the middle link's center $\dot{y}(t)/(\ell\omega)$, overlaid with the center of mass horizontal velocity $\dot{y}_{c}(t)/(\ell\omega)$, on the same plot. Add another graph of the difference $[\dot{y}(t)-\dot{y}_{c}(t)]/(\ell\omega)$. Explain the results.

**Solution**:

![[HDY1_HW001_PartD.png|bookhue|600]]^figure-hw1-part-d
>Vertical velocity comparison (top) and normalized difference (bottom). (Self-generated simulation.)

[[#^figure-hw1-part-d|Figure]] shows the robot’s total center of mass follows link $0$'s vertical motion extremely closely. The deviations mainly occur because of the phase difference applied to the actuated joints. These effect the vertical velocities of joints $1$ and $2$ with a slight delay between them, therefore the total center of mass deviates slightly from link $0$'s vertical velocity.


<div><hr><hr></div>


## Figure e
Normalized angular velocity of the middle link $\dot{\theta}(t)/\omega$. Add on the same plot a curve where $\dot{\theta}(t)$ is calculated from conservation of total angular momentum ${H}_{c}(t)=0$ using the expression from assignment 2 above. Compare and explain the results.

**Solution**:

![[HDY1_HW001_PartE.png|bookhue|600]]^figure-hw1-part-e
>Measured vs. momentum-inferred angular velocity. (Self-generated simulation.)

The two curves are visually indistinguishable, so the symbolic decomposition $H_{c}=f_{0}\dot{\theta}+f_{1}\dot{\phi}_{1}+f_{2}\dot{\phi}_{2}$ matches the numerical trajectory.


<div><hr><hr></div>


## Figure f
Actuation torques at the joints, ${\tau}_{1}(t),\,{\tau}_{2}(t)$, two curves on the same plot.

**Solution**:

![[HDY1_HW001_PartF.png|bookhue|600]]^figure-hw1-part-f
>Joint torques over time. (Self-generated simulation.)

The opposite phasing reflects the mirrored excitation applied to $\phi_{1}$ and $\phi_{2}$.


<div><hr><hr></div>


## Figure g
Normalized angular acceleration of the middle link $\ddot{\theta}(t)/\omega ^{2}$. Add on the same plot a curve where $\ddot{\theta}(t)$ is calculated from balance of angular momentum for link 2 derived in assignment 3 above. Compare and explain the results.

**Solution**:

![[HDY1_HW001_PartG.png|bookhue|600]]^figure-hw1-part-g
>Angular accelerations from the full-state integration vs. the link-2 balance. (Self-generated simulation.)

The direct output $\ddot{\theta}/\omega^{2}$ matches the reconstruction based on the link $2$ balance, confirming the consistency of the derived dynamic model.

# Assignment 6
Write a short paragraph (3-6 sentences) of summary and conclusions from this exercise.

**Solution**:
The simulation demonstrates how internal shape changes can reorient the system while preserving the zero-mean center of mass position. Since the input profiles are smooth ($C^2$), the required torques remain small ($\pm 0.02\,\mathrm{N\cdot m}$), suggesting this maneuver is physically feasible. The numerical results align perfectly with the symbolic derivations for position and angular momentum, and the link-$2$ momentum balance confirms the dynamic consistency of the model.
