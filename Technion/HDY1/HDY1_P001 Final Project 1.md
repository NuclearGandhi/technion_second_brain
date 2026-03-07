---
aliases:
title: Final Project 1
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

**MATLAB Code**: All related code files can be found on [GitHub](https://github.com/NuclearGandhi/technion_second_brain/tree/master/Technion/HDY1/HDY1_P001/code) as well as [OneDrive](https://technionmail-my.sharepoint.com/:f:/g/personal/ido_fang_campus_technion_ac_il/IgD45m2UrEczT5_KSBWzIvnLAbe_P8jEVC_rfGIoKPJjKNY?e=5TCGrL).


<div><hr><hr></div>

# Problem Description

The figure shows the "compass biped" walking robot model. This model consists of two rigid legs connected by a passive revolute joint. The two legs are identical slender rods of mass $m$, length $2\ell$ and moment of inertia $I_c$ with respect to their center-of-mass located at their midpoints. Another point mass $m_h$ is located at the passive "hip joint" connecting the two legs. One leg touches the ground, and is called "stance leg", while the other leg is called "swing leg". The endpoint of the stance leg, called "stance foot", makes a unilateral point contact with an inclined plane having slope angle $\alpha$ and friction coefficient $\mu$ (both static and dynamic). The stance foot is considered as a passive revolute joint, and may slip on the ground or stick, depending on friction.

The generalized coordinates of the system are $\mathbf{q} = (x, y, \theta_1, \theta_2)^T$, where $x, y$ denote the position of the stance foot, expressed in a fixed reference frame where $\hat{\mathbf{x}}$ and $\hat{\mathbf{y}}$ axes are aligned with the tangent and normal directions to the inclined plane, respectively. The angles $\theta_1, \theta_2$ are orientations of the stance and swing legs, respectively, with respect to the $\hat{\mathbf{y}}$ axis. Normal contact displacement of the stance foot is constrained as $y = 0$, whereas the tangential displacement satisfies $\dot{x} = 0$ for no-slip contact or $\dot{x} \neq 0$ during slippage.

The swing leg's endpoint, called "swing foot", is located at $\mathbf{p} = (\tilde{x}, \tilde{y})^T$ and its velocity can be written as $\dot{\mathbf{p}} = \tilde{\mathbf{W}}(\mathbf{q})\dot{\mathbf{q}}$. The swing foot moves until it passes ahead of the stance leg and hits the ground when $\theta_1 = \theta_2$. Then it undergoes inelastic impact with friction, and attaches to the ground. As a result of this collision, the rear foot lifts from the ground and the swing and stance feet switch their roles.

Note that during the phase where the swing leg passes across the stance leg, it actually penetrates into the ground for a short time, that is, $y_p(t) < 0$. This effect, called "foot scuffing", should be ignored in the analysis and not considered as a collision.


![[HDY1_P001 Final Project 1 2026-01-29 14.21.32.excalidraw.svg]]
>The compass biped passive dynamic walker on an inclined plane.

**Sign Convention:**
- $\theta_1$ (stance leg): positive clockwise — leg tips toward $+\hat{\mathbf{x}}$ (downhill)
- $\theta_2$ (swing leg): positive counterclockwise — leg tips toward $+\hat{\mathbf{x}}$ (downhill)

**Parameter values for numerical simulations:**
$$\begin{aligned}
 & m = \pu{4 kg}  &  & m_h = \pu{1.8 kg} \\[1ex]
 &  I_c = 0  &  &  \ell = \pu{0.8 m},  \\[1ex]
 &  g = \pu{10 m/s^2} &  &  \alpha = 1.5^{\circ} 
\end{aligned}$$


<div><hr><hr></div>


## Task 1
Write the equations of motion in matrix form and the matrices $\mathbf{M}(\mathbf{q})$, $\mathbf{G}(\mathbf{q})$, $\mathbf{B}(\mathbf{q}, \dot{\mathbf{q}})$, $\mathbf{W}(\mathbf{q})$, $\tilde{\mathbf{W}}(\mathbf{q})$.

**Solution:**

The positions of the key points in the slope-aligned coordinate system are determined by the generalized coordinates. The stance foot is located at $\mathbf{r}_{\text{foot}} = (x, y)$. With $\theta_1$ measured clockwise from the vertical, the stance leg COM lies at distance $\ell$ along the leg from the foot:
$$\mathbf{r}_{1c} = (x + \ell\sin\theta_1, \, y + \ell\cos\theta_1) \tag{P1.1}$$

The hip is at distance $2\ell$ from the stance foot:
$$\mathbf{r}_h = (x + 2\ell\sin\theta_1, \, y + 2\ell\cos\theta_1) \tag{P1.2}$$

The swing leg COM is at distance $\ell$ from the hip, with $\theta_2$ measured counterclockwise from the downward vertical:
$$\mathbf{r}_{2c} = (x + 2\ell\sin\theta_1 + \ell\sin\theta_2, \, y + 2\ell\cos\theta_1 - \ell\cos\theta_2) \tag{P1.3}$$

The swing foot position $\mathbf{p} = (\tilde{x}, \tilde{y})$ is:
$$\mathbf{p} = (x + 2\ell\sin\theta_1 + 2\ell\sin\theta_2, \, y + 2\ell\cos\theta_1 - 2\ell\cos\theta_2) \tag{P1.4}$$

The velocities are obtained by differentiating the positions with respect to time:
$$\begin{aligned}
\mathbf{v}_{1c} &= (\dot{x} + \ell\dot{\theta}_1\cos\theta_1, \, \dot{y} - \ell\dot{\theta}_1\sin\theta_1) \\[1ex]
\mathbf{v}_h &= (\dot{x} + 2\ell\dot{\theta}_1\cos\theta_1, \, \dot{y} - 2\ell\dot{\theta}_1\sin\theta_1) \\[1ex]
\mathbf{v}_{2c} &= (\dot{x} + 2\ell\dot{\theta}_1\cos\theta_1 + \ell\dot{\theta}_2\cos\theta_2, \, \dot{y} - 2\ell\dot{\theta}_1\sin\theta_1 + \ell\dot{\theta}_2\sin\theta_2)
\end{aligned} \tag{P1.5}$$

The kinetic energy consists of translational and rotational components for each body. The stance leg contributes $T_1 = \frac{1}{2}m|\mathbf{v}_{1c}|^2 + \frac{1}{2}I_c\dot{\theta}_1^2$, the hip point mass contributes $T_h = \frac{1}{2}m_h|\mathbf{v}_h|^2$, and the swing leg contributes $T_2 = \frac{1}{2}m|\mathbf{v}_{2c}|^2 + \frac{1}{2}I_c\dot{\theta}_2^2$. The total kinetic energy is $T = T_1 + T_h + T_2$.

The gravity vector in the slope-aligned coordinate system is $\mathbf{g} = (g\sin\alpha, -g\cos\alpha)$. The potential energy for each body is $V = mg\cos\alpha \cdot y_{\text{COM}} - mg\sin\alpha \cdot x_{\text{COM}}$, giving:
$$\begin{aligned}
V_1 &= mg\cos\alpha(y + \ell\cos\theta_1) - mg\sin\alpha(x + \ell\sin\theta_1) \\[1ex]
V_h &= m_h g\cos\alpha(y + 2\ell\cos\theta_1) - m_h g\sin\alpha(x + 2\ell\sin\theta_1) \\[1ex]
V_2 &= mg\cos\alpha(y + 2\ell\cos\theta_1 - \ell\cos\theta_2) - mg\sin\alpha(x + 2\ell\sin\theta_1 + \ell\sin\theta_2)
\end{aligned} \tag{P1.6}$$

Using the Lagrangian $L = T - V$, the equations of motion are derived in the standard form $\mathbf{M}(\mathbf{q})\ddot{\mathbf{q}} + \mathbf{B}(\mathbf{q}, \dot{\mathbf{q}}) + \mathbf{G}(\mathbf{q}) = \mathbf{W}^T \boldsymbol{\lambda}$, where $\boldsymbol{\lambda} = (\lambda_n, \lambda_t)^T$ are the normal and tangential contact forces. The mass matrix is obtained from the Hessian of the kinetic energy with respect to the generalized velocities, the Coriolis/centrifugal vector $\mathbf{B}$ is computed using Christoffel symbols, and the gravity vector $\mathbf{G}$ is the gradient of the potential energy.

From symbolic computation in MATLAB, the resulting matrices are (using shorthand $s_1 = \sin\theta_1$, $c_1 = \cos\theta_1$, $s_2 = \sin\theta_2$, $c_2 = \cos\theta_2$, $c_{12}^+ = \cos(\theta_1 + \theta_2)$):

$$\mathbf{M} = \begin{pmatrix}
2m + m_h & 0 & \ell c_1(3m + 2m_h) & \ell m c_2 \\
0 & 2m + m_h & -\ell s_1(3m + 2m_h) & \ell m s_2 \\
\ell c_1(3m + 2m_h) & -\ell s_1(3m + 2m_h) & I_c + \ell^2(5m + 4m_h) & 2\ell^2 m c_{12}^+ \\
\ell m c_2 & \ell m s_2 & 2\ell^2 m c_{12}^+ & I_c + \ell^2 m
\end{pmatrix} \tag{P1.7}$$

$$\mathbf{B} = \begin{pmatrix}
-\ell s_1 (3m + 2m_h) \dot{\theta}_1^2 - \ell m s_2 \dot{\theta}_2^2 \\
-\ell c_1 (3m + 2m_h) \dot{\theta}_1^2 + \ell m c_2 \dot{\theta}_2^2 \\
-2\ell^2 m \sin(\theta_1 + \theta_2) \dot{\theta}_2^2 \\
-2\ell^2 m \sin(\theta_1 + \theta_2) \dot{\theta}_1^2
\end{pmatrix} \tag{P1.8}$$

$$\mathbf{G} = \begin{pmatrix}
-g\sin\alpha (2m + m_h) \\
g\cos\alpha (2m + m_h) \\
-g\ell \sin(\alpha + \theta_1)(3m + 2m_h) \\
-g\ell m \sin(\alpha - \theta_2)
\end{pmatrix} \tag{P1.9}$$

For stance foot contact, the normal constraint is $d_n = y = 0$ and the tangential constraint (no-slip) is $\dot{x} = 0$. The constraint gradients give:
$$\mathbf{W} = \begin{pmatrix} \mathbf{w}_n \\ \mathbf{w}_t \end{pmatrix} = \begin{pmatrix} 0 & 1 & 0 & 0 \\ 1 & 0 & 0 & 0 \end{pmatrix} \tag{P1.10}$$

The swing foot velocity is $\dot{\mathbf{p}} = \tilde{\mathbf{W}}(\mathbf{q})\dot{\mathbf{q}}$, where the swing foot Jacobian is:
$$\tilde{\mathbf{W}} = \begin{pmatrix}
1 & 0 & 2\ell\cos\theta_1 & 2\ell\cos\theta_2 \\
0 & 1 & -2\ell\sin\theta_1 & 2\ell\sin\theta_2
\end{pmatrix} \tag{P1.11}$$


<div><hr><hr></div>


## Task 2
Write two MATLAB functions for numerical simulations of the dynamic equations with no-slip contact:

A function defining the state-space differential equation:
```matlab
function dXdt = sys_stick(t, X)
```

A function defining condition for stopping event due to onset of slippage:

```matlab
[value, isterminal, direction] = events_stick(t, X)
```

Include also a possible event of "falling" when the hip joint hits the ground.

**Solution:**

Under no-slip contact, the constraints $y = 0$ and $\dot{x} = 0$ reduce the system to two degrees of freedom. The reduced state vector is $\mathbf{X} = (\theta_1, \theta_2, \dot{\theta}_1, \dot{\theta}_2)^T$.

The function `sys_stick` computes the state derivative $\dot{\mathbf{X}}$ for ODE integration. It extracts the angles and angular velocities from the state vector and calls the symbolically-derived `stick_accelerations` function to compute $\ddot{\theta}_1$ and $\ddot{\theta}_2$, returning $\dot{\mathbf{X}} = (\dot{\theta}_1, \dot{\theta}_2, \ddot{\theta}_1, \ddot{\theta}_2)^T$.

The function `events_stick` detects terminating events during simulation. It monitors four conditions: forward slip onset when $\lambda_t - \mu\lambda_n = 0$ with increasing $\lambda_t$, backward slip onset when $\lambda_t + \mu\lambda_n = 0$ with decreasing $\lambda_t$, swing foot collision when the swing foot height $\tilde{y} = 0$ with the swing foot ahead of the stance foot (to exclude foot scuffing), and falling when the hip reaches the ground ($\cos\theta_1 = 0$). The contact forces are computed using the symbolically-derived `stick_forces` function.


<div><hr><hr></div>


## Task 3
Write MATLAB function of the form `Xnew = impact_law(Xold)` for calculating the change in the state vector due to collision of the swing foot with the ground. Use Chatterjee's impact law and assume a frictional fully-plastic collision ($e_n = e_t = 0$). Note that the function should also include the relabeling of coordinates due to interchange between stance and swing legs, so that `Xnew` represents initial conditions for a new step. The function should also check that the rear foot separates from the ground at the post-impact state, otherwise it should return "failure" code due to double-foot impact.

**Solution:**

The swing foot collides with the ground when its height reaches zero: $\tilde{y} = 2\ell\cos\theta_1 - 2\ell\cos\theta_2 = 0$. This gives the impact condition $\cos\theta_1 = \cos\theta_2$, which corresponds to $\theta_1 = \theta_2$ for typical walking configurations where both angles have the same sign. The pre-impact state is $\mathbf{X}^- = (\theta_1^-, \theta_2^-, \dot{\theta}_1^-, \dot{\theta}_2^-)^T$.

For a fully-plastic collision ($e_n = e_t = 0$), Chatterjee's impact law requires the post-impact contact velocity to be zero. The collision matrix relates the contact velocity to the impulse: $\mathbf{A}_c = \tilde{\mathbf{W}}_c \mathbf{M}_c^{-1} \tilde{\mathbf{W}}_c^T$, where $\tilde{\mathbf{W}}_c$ and $\mathbf{M}_c$ are evaluated at the impact configuration. The candidate impulse for fully-plastic impact is $\hat{\boldsymbol{\Lambda}} = -\mathbf{A}_c^{-1} \mathbf{v}^-$, where $\mathbf{v}^- = (\dot{\tilde{x}}^-, \dot{\tilde{y}}^-)^T$ is the pre-impact swing foot velocity.

The impulse must satisfy Coulomb's friction bound $|\Lambda_t| \leq \mu \Lambda_n$. If violated, the tangential impulse is projected onto the friction cone boundary with $\Lambda_t = \sigma \mu \Lambda_n$ where $\sigma = \mathrm{sgn}(\hat{\Lambda}_t)$, and $\Lambda_n$ is adjusted to ensure $\dot{\tilde{y}}^+ = 0$:
$$\Lambda_n = \frac{-\dot{\tilde{y}}^-}{A_{c,22} + \sigma\mu \, A_{c,21}}$$
The post-impact generalized velocities are then $\dot{\mathbf{q}}^+ = \dot{\mathbf{q}}^- + \mathbf{M}_c^{-1} \tilde{\mathbf{W}}_c^T \boldsymbol{\Lambda}$.

After impact, the swing foot becomes the new stance foot. Since the positive-rotation conventions for $\theta_1$ (CW) and $\theta_2$ (CCW) are opposite, the relabeling includes a sign change:
$$\theta_1^{\text{new}} = -\theta_2^-,\quad \theta_2^{\text{new}} = -\theta_1^-,\quad \dot{\theta}_1^{\text{new}} = -\dot{\theta}_2^{+},\quad \dot{\theta}_2^{\text{new}} = -\dot{\theta}_1^{+}$$

For a valid step, the old stance foot (now rear foot) must lift off the ground. This requires $\dot{\tilde{y}}_{\text{rear}}^+ = 2\ell\sin\theta_c(\dot{\theta}_1^{\text{new}} - \dot{\theta}_2^{\text{new}}) > 0$, where $\theta_c = \theta_1^- = \theta_2^-$ is the common angle at impact. If this condition is violated, the function returns a failure status indicating double-foot impact.


<div><hr><hr></div>


## Task 4
Write MATLAB function of the form `Znew = Poincare_map(Zold)` for calculating the Poincaré map of the system $\Pi(\mathbf{z})$, where the Poincaré section is chosen as the post-impact state. Assume no-slip motion and impact. The function should return "failure" codes in cases of falling or double-foot impact.

**Solution:**

The Poincaré section is defined at the post-impact state, where the impact constraint $\theta_1 = \theta_2 = \theta_c$ reduces the full 4D state to a 3D reduced state $\mathbf{z} = (\theta_c, \dot{\theta}_1, \dot{\theta}_2)^T$. The function `poincare_map` takes this reduced state, converts it to the full state $\mathbf{X} = (\theta_c, \theta_c, \dot{\theta}_1, \dot{\theta}_2)^T$, and integrates the no-slip dynamics using `ode45` with event detection until the next impact occurs (swing foot height reaches zero with the swing foot ahead of the stance foot). The impact law is then applied to obtain the post-impact velocities, followed by leg relabeling. The new reduced state is extracted and returned along with a status code: 0 for success, 1 for falling, 2 for double-foot impact, and 3 for slip onset.


<div><hr><hr></div>


## Task 5
Use the MATLAB command `fsolve` for finding a fixed point of the Poincaré map, which satisfies $\mathbf{z}^* = \Pi(\mathbf{z}^*)$. You can use initial guess from the MSc thesis of Benny Gamus (page 35). If needed, start with parameter values from the thesis and then change them in small increments and update the initial guess for `fsolve` iteratively, until reaching the current values.

For the periodic solution, present the following graphs, for the time span of a single period:

**(a)** Plot of the two angles versus time, $\theta_i(t)$, overlaid on the same plot. Mark the "scuffing" event on the plot.

**(b)** Phase plane trajectories of $\dot{\theta}_i(t)$ vs. $\theta_i(t)$, one curve for each leg in different colors on the same plot. Mark the points of collision by 'x' and the points of scuffing by 'o' on the curves. Mark the jumps due to impact + foot relabeling in dotted straight-line segments.

**(c)** Plot of the normal contact force $\lambda_n(t)$ at the stance foot as a function of time $t$, overlaid with a dashed horizontal line at height 0.

**(d)** Plot of the force ratio $\lambda_t/\lambda_n$ at the stance foot as a function of time $t$. At the final time of impact, add a marker 'x' for the value of the impulse ratio $\Lambda_t/\Lambda_n$ at the collision.

**(e)** Plot of the normal height of the swing foot $y_p$ as a function of time $t$. Mark the duration of "scuffing" effect when $y_p(t) < 0$ by two dashed vertical lines at the endpoints of this time interval.

All graphs should have labels and units, and all lines should have width $\geq 2$.

**Solution:**

To find the fixed point, we define the residual function $\mathbf{G}(\mathbf{z}) = \Pi(\mathbf{z}) - \mathbf{z}$ and use MATLAB's `fsolve` to find $\mathbf{z}^*$ such that $\mathbf{G}(\mathbf{z}^*) = \mathbf{0}$. If the Poincaré map fails (due to falling, slip, or double-foot impact), the residual returns a large penalty value to guide the solver away from infeasible regions.

Using the initial guess from Gamus's thesis, `fsolve` converges in 4 iterations with residual norm $\|\mathbf{G}\| = 5.14 \times 10^{-15}$. The fixed point is:
$$\mathbf{z}^* = \begin{pmatrix} \theta_c \\ \dot{\theta}_1 \\ \dot{\theta}_2 \end{pmatrix} = \begin{pmatrix} -0.1665 \text{ rad} \; (-9.542°) \\ 0.8033 \text{ rad/s} \\ -0.4490 \text{ rad/s} \end{pmatrix} \tag{P5.1}$$

![[task5_a_angles.png|bookhue|600]]
>(a) Angles vs time for the periodic solution. Scuffing occurs in the mid-stride region where $\tilde{y} < 0$.

![[task5_b_phase.png|bookhue|600]]
>(b) Phase portrait of the periodic solution. Collision points marked with $\times$, scuffing points with $\circ$. Impact jumps (including foot relabeling) shown as dotted lines.

![[task5_c_normal_force.png|bookhue|600]]
>(c) Normal contact force at the stance foot. The force remains positive throughout, confirming sustained contact.

![[task5_d_force_ratio.png|bookhue|600]]
>(d) Force ratio $\lambda_t / \lambda_n$ with friction bounds $\pm\mu$. The impact impulse ratio $\Lambda_t / \Lambda_n$ is marked at the end of the period.

![[task5_e_swing_height.png|bookhue|600]]
>(e) Swing foot height during the periodic solution. The scuffing interval where $\tilde{y} < 0$ is marked by dashed vertical lines.


<div><hr><hr></div>


## Task 6
Find the minimal value of friction coefficient $\mu_{\min}$ such that no-slip contact is maintained along the entire periodic solution for all $\mu > \mu_{\min}$, including the impact. Explain your result.

**Solution:**

The no-slip periodic solution's dynamics are independent of $\mu$ -- neither the constrained equations of motion nor the fully-plastic no-slip impact law involve the friction coefficient. Therefore, $\mu_{\min}$ can be determined directly from the periodic solution found in Task 5 by computing the maximum friction demand across both the continuous phase and the impact event.

During the continuous phase, no-slip contact requires $|\lambda_t(t)| \leq \mu \lambda_n(t)$ at all times. At the impact, the no-slip impulse must satisfy $|\Lambda_t| \leq \mu \Lambda_n$. The minimum friction coefficient ensuring no-slip throughout the entire cycle is therefore:
$$\mu_{\min} = \max\!\left(\max_t \left|\frac{\lambda_t(t)}{\lambda_n(t)}\right|, \; \left|\frac{\Lambda_t}{\Lambda_n}\right|\right) \tag{P6.1}$$

This corresponds to the peak of graph (d) in Task 5, which shows the force ratio over the period along with the impact impulse ratio. Running the computation yields:
$$\max_t \left|\frac{\lambda_t(t)}{\lambda_n(t)}\right| = 0.2000 \quad (\text{at } t = 0), \qquad \left|\frac{\Lambda_t}{\Lambda_n}\right| = 0.1580$$

The continuous-phase demand exceeds the impact demand, so the critical instant is at $t = 0$ (immediately after impact). Therefore:
$$\boxed{\mu_{\min} \approx 0.200} \tag{P6.2}$$

This result means that the stance foot is most prone to slipping right at the start of each step, when the post-impact contact forces have the highest tangential-to-normal ratio. For any $\mu > 0.200$, the entire periodic walking cycle proceeds without slippage.


<div><hr><hr></div>

%%
## Task 7
Now, assume that at some time along the periodic solution, the stance foot is given a perturbation of small slippage, $\dot{x} = \pm\varepsilon$. Find a condition on the friction coefficient $\mu$ in order to avoid Painlevé paradox, and explain. Find the maximal value of the friction coefficient $\mu_{\max}$ such that for all $\mu < \mu_{\max}$, the no-slip motion is safe of Painlevé paradox under small slippage perturbation at any time along the periodic solution.

**Solution:**




<div><hr><hr></div>


## Task 8
Calculate the Jacobian matrix of the Poincaré map at the fixed point $\mathbf{J} = \left.\dfrac{\partial\Pi}{\partial\mathbf{z}}\right|_{\mathbf{z}^*}$, calculate its eigenvalues $\lambda_j$, and discuss orbital stability of the periodic solution.

Plot the discrete-time series $\psi_k$ of the angles $\theta_1(t_k) = \theta_2(t_k)$ at impact times for $k = \{1 \ldots 15\}$, under the largest initial perturbation $\psi_1$ that lies in the region of attraction (initial velocities should be taken equal to $\mathbf{z}^*$).

**Solution:**




<div><hr><hr></div>


## Task 9
Write two MATLAB functions for numerical simulations of the dynamic equations with slipping contact:

A function that defines the state-space differential equation and uses a global variable `sgn_slip` defining the direction of slip and taking values of $\pm 1$:
```matlab
function dXdt = sys_slip(t, X)
```

A function defining condition for stopping event due to stopping slippage, contact separation, swing foot's collision, or falling:
```matlab
[value, isterminal, direction] = events_slip(t, X)
```

**Solution:**




<div><hr><hr></div>


## Task 10
Extend the function of Poincaré map to the case of finite bounded friction coefficient. The function should account for possible stick-slip transitions during motion, as well as possible slippage at impact. That is, the dimension of the Poincaré section at post-impact times should be extended to include also $\dot{x}(t_c^+)$. Note that after a no-slip impact, the motion may possibly switch immediately to slip, in case where the initial no-slip constraint forces violate the friction bounds. The Poincaré map function should return "failure" in cases of falling, contact separation, or double-foot impact.

**Solution:**




<div><hr><hr></div>


## Task 11
Use the MATLAB command `fsolve` for finding a fixed point of the bounded-friction Poincaré map for $\mu = 0.9\mu_{\min}$, which corresponds to periodic solutions with stick-slip transitions. Present same plots as in Task 5 for the periodic solution, while the phases of foot slippage are marked by dashed lines. Describe the resulting motion.

Calculate the Jacobian matrix of the Poincaré map at the fixed point $\mathbf{J} = \left.\dfrac{\partial\Pi}{\partial\mathbf{z}}\right|_{\mathbf{z}^*}$, calculate its eigenvalues $\lambda_j$, and discuss orbital stability of the periodic solution.

**Solution:**




<div><hr><hr></div>


## Task 12
Write a short paragraph of summary, discussion and conclusion.

**Solution:**




<div><hr><hr></div>


## Task 13 (Optional, Bonus 5%)
Reduce friction coefficient "continuously" (i.e. in small increments) from $\mu_{\min}$ towards $0.1\mu_{\min}$, and track the periodic solution, until reaching loss of existence due to "failure". Show a plot of $\max\{|\lambda_j|\}$ of the periodic solution as a function of $\mu$, and another plot of the percentage of slippage duration out of the period time as a function of $\mu$.

Identify all critical values of $\mu$ for which a qualitative change in the periodic solution occurs — change in the sequence of contact states, change in the impact, change in stability, and loss of existence. Show plots of type 5(b) for each different type of periodic solution. Discuss your findings.

**Solution:**

%%