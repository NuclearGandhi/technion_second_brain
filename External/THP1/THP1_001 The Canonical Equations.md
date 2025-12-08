---
aliases:
---
# Hamilton's Equations

![](https://www.youtube.com/watch?v=tpp1Ahmij_Q)

The formulation of the laws of mechanics in terms of the [[DVI1_001 מושגי יסוד ומכניקת לגראנז'#משוואות אויילר-לגראנז'|Lagrangian]], and of the Euler-Lagrange's equations derived from it, presupposes that the mechanical state of a system is described by specifying its generalized coordinates and velocities. This is not the only possible mode of description, however. A number of advantages, especially in the study of certain general problems of mechanics, attach to a description in terms of the generalized coordinates and momenta of the system. The question therefore arises of the form of the equations of motion corresponding to that formulation of mechanics.

The passage from one set of independent variables to another can be effected by means of what is called in mathematics **Legendre's transformation**. In the present case of this transformation is as follows. The total differential of the Lagrangian as a function of coordinates and velocities is
$$\mathrm{d}\mathcal{L}= \sum_{i}^{} \dfrac{ \partial \mathcal{L} }{ \partial {q}_{i} } \mathrm{d}{q}_{i}+\sum_{i}^{}\dfrac{ \partial \mathcal{L} }{ \partial \dot{q}_{i} } \mathrm{d}\dot{q}_{i}  $$
This expression may be written
$$\mathrm{d}\mathcal{L}=\sum_{}^{}\dot{p}_{i}\mathrm{d}{q}_{i}+\sum_{}^{}{p}_{i}\mathrm{d}\dot{q}_{i}\tag{LL40.1}  $$
since the derivatives $\partial L/ \partial \dot{q}_{i}$ are, by definition, the **generalized momentum**, and $\partial L/\partial {q}_{i}=\dot{p}_{i}$ by Euler-Lagrange's equations.

>[!def] Definition: 
>Just like [[DVI1_001 מושגי יסוד ומכניקת לגראנז'#עבודה וירטואלית|generalized forces]] are the extension of linear forces and moments, **generalized momentum** are the extension of linear and angular momentum to systems described by generalized coordinates, defines as:
>$${p}_{i}=\dfrac{ \partial L }{ \partial \dot{q}_{i} } $$ 
> It is also known as **canonical momentum**.

Rewriting $\text{(LL40.1)}$ gives us:
$$\mathrm{d}\left( \sum_{}^{}{p}_{i}\dot{q}_{i}-L  \right)=-\sum_{}^{}\dot{p}_{i}\,\mathrm{d}{q}_{i}+\sum_{}^{}\dot{q}_{i}\,\mathrm{d}{p}_{i}  $$

The argument of the differential is the energy of the system expressed in terms of coordinates and momentum, it is called the **Hamilton's function** or **Hamiltonian** of the system:
$$\boxed {
H(p,q,t)=\sum_{i}^{}{p}_{i}\dot{q}_{i}-L \tag{LL40.2} 
 }$$
From the equation in differentials
$$\mathrm{d}H=-\sum_{}^{}\dot{p}_{i}\,\mathrm{d}{q}_{i}+\sum_{}^{}\dot{q}_{i}\,\mathrm{d}{p}_{i} \tag{LL40.3}  $$
in which the independent variables are the coordinates and momenta, we have the equations
$$\boxed {
\begin{aligned}
 & \dot{q}_{i}=\dfrac{ \partial H }{ \partial {p}_{i} }  \\[1ex]
 & \dot{p}_{i}=-\dfrac{ \partial H }{ \partial {q}_{i} } 
\end{aligned} \tag{LL40.4}
 }$$

These are the required equations of motion in the variables $p$ and $q$, and are called **Hamilton's equations**. They form a set of $2s$ first-order differential equations for the $2s$ unknown functions ${p}_{i}(t)$ and ${q}_{i}(t)$, replacing the $s$ second-order equations in the Lagrangian treatment. Because of their simplicity and symmetry of form, they are also called **canonical equations**.

The total time derivative of the Hamiltonian is
$$\dfrac{\mathrm{d}H}{\mathrm{d}t}=\dfrac{ \partial H }{ \partial t } +\sum_{}^{} \dfrac{ \partial H }{ \partial {q}_{i} } \dot{q}_{i}+\sum_{}^{} \dfrac{ \partial H }{ \partial {p}_{i} } \dot{p}_{i}  $$
substitution of $\dot{q}_{i}$ and $\dot{p}_{i}$ from equations $\text{(L40.4)}$ shows that the last two terms cancel, and so
$$\dfrac{\mathrm{d}H}{\mathrm{d}t}=\dfrac{ \partial H }{ \partial t }  \tag{LL40.5}$$
In particular, if the Hamiltonian does not depend explicitly on time, then $\mathrm{d}H/\mathrm{d}t=0$, and we have law of conservation of energy.

As well as the dynamical variables $q,\dot{q}$ or $q,p,$ the Lagrangian and the Hamiltonian involve various parameters which relate to the properties of the mechanical system itself, or to the external forces on it. Let $\lambda$ be one such parameter. Regarding it as a variable, we have instead of $\text{(LL40.1)}$
$$\mathrm{d}\mathcal{L}=\sum_{}^{}\dot{p}_{i}\,\mathrm{d}{q}_{i} +\sum {p}_{i}\mathrm{d}\dot{q}_{i}+\left( \dfrac{ \partial \mathcal{L} }{ \partial \lambda }  \right)\mathrm{d}\lambda $$
and $\text{(LL40.3)}$ becomes
$$\mathrm{d}H=-\sum \dot{p}_{i}\,\mathrm{d}{q}_{i}+\sum \dot{q}_{i}\,\mathrm{d}{p}_{i}-\left( \dfrac{ \partial \mathcal{L} }{ \partial \lambda }  \right)\mathrm{d}\lambda$$
Hence
$$\left( \dfrac{ \partial H }{ \partial \lambda }  \right)_{p,q}=-\left( \dfrac{ \partial \mathcal{L} }{ \partial \lambda } \right)_{\dot{q},q}\tag{LL40.6}$$
which relates the derivatives of the Lagrangian and the Hamiltonian with respect to the parameter $\lambda$. The suffixes to the derivates show the quantities which are to be kept constant in differentiation.

This result can be put in another way. Let the Lagrangian be of the form $L={L}_{0}+L'$, where $L'$ is a small correction to the function ${L}_{0}$. Then the corresponding addition $H'$ in the Hamiltonian $H={H}_{0}+H'$ is related to $L'$ by
$$(H')_{p,q}=(-\mathcal{L}')_{\dot{q},q}\tag{LL40.7}$$

It may be noticed that, in transforming $\text{(LL40.1)}$ into $\text{(LL40.3)}$, we did not include a term in $\mathrm{d}t$ to take account of a possible explicit time-dependence of the Lagrangian, since the time would there be only a parameter which would not be involved in the transformation. Analogously to formula $\text{(40.6)}$, the partial time derivatives of $\mathcal{L}$ and $H$ are related by
$$\left( \dfrac{ \partial H }{ \partial t }  \right)_{p,q}=-\left( \dfrac{ \partial \mathcal{L} }{ \partial t }  \right)_{\dot{q},q} \tag{LL40.8}$$

# Exercises

## Exercise 1
Find the Hamiltonian for a single particle in Cartesian, cylindrical and spherical coordinates.

**Solution**:
In Cartesian coordinates $(x, y, z)$, the position and velocity are:
$$
\begin{aligned}
 & \mathbf{r} = x\hat{\mathbf{x}} + y\hat{\mathbf{y}} + z\hat{\mathbf{z}} \\[1ex]
 &  \mathbf{v} = \dot{x}\hat{\mathbf{x}} + \dot{y}\hat{\mathbf{y}} + \dot{z}\hat{\mathbf{z}}
\end{aligned}
$$
The Lagrangian is:
$$
\begin{aligned}
\mathcal{L}  & = T - U  \\[1ex]
 & = \frac{1}{2}m(\dot{x}^2 + \dot{y}^2 + \dot{z}^2) - U(x, y, z)
\end{aligned}
$$
The generalized momenta are:
$$
\begin{aligned}
 & p_x = \frac{\partial \mathcal{L}}{\partial \dot{x}} = m\dot{x},  \\[1ex]
 &  p_y = \frac{\partial \mathcal{L}}{\partial \dot{y}} = m\dot{y},  \\[1ex]
 &  p_z = \frac{\partial \mathcal{L}}{\partial \dot{z}} = m\dot{z}
\end{aligned}
$$
Inverting these relations gives the velocities in terms of momenta:
$$
\dot{x} = \frac{p_x}{m}, \quad \dot{y} = \frac{p_y}{m}, \quad \dot{z} = \frac{p_z}{m}
$$
The Hamiltonian is defined as $H = \sum p_i \dot{q}_i - \mathcal{L}$:
$$
\begin{aligned}
H &= p_x\dot{x} + p_y\dot{y} + p_z\dot{z} - \left[ \frac{1}{2}m(\dot{x}^2 + \dot{y}^2 + \dot{z}^2) - U \right] \\
&= \frac{p_x^2}{m} + \frac{p_y^2}{m} + \frac{p_z^2}{m} - \frac{1}{2}m\left( \frac{p_x^2}{m^2} + \frac{p_y^2}{m^2} + \frac{p_z^2}{m^2} \right) + U \\[3ex]
&\implies\boxed {
 H= \frac{1}{2m}(p_x^2 + p_y^2 + p_z^2) + U(x, y, z)
 }
\end{aligned}
$$

In cylindrical coordinates $(r, \phi, z)$, the velocity squared is $v^2 = \dot{r}^2 + r^2\dot{\phi}^2 + \dot{z}^2$. The Lagrangian is:
$$
\mathcal{L} = \frac{1}{2}m(\dot{r}^2 + r^2\dot{\phi}^2 + \dot{z}^2) - U(r, \phi, z)
$$
The momenta are:
$$
\begin{aligned}
 & p_r = m\dot{r} \\[1ex]
 & p_\phi = mr^2\dot{\phi}  \\[1ex]
 &  p_z = m\dot{z}
\end{aligned}
$$
Velocities:
$$
\begin{aligned}
 & \dot{r} = \frac{p_r}{m} \\[1ex]
 &  \dot{\phi} = \frac{p_\phi}{mr^2} \\[1ex]
 &  \dot{z} = \frac{p_z}{m}
\end{aligned}
$$
The Hamiltonian is:
$$
\boxed {
H = \frac{p_r^2}{2m} + \frac{p_\phi^2}{2mr^2} + \frac{p_z^2}{2m} + U(r, \phi, z)
 }
$$

In spherical coordinates $(r, \theta, \phi)$, the velocity squared is $v^2 = \dot{r}^2 + r^2\dot{\theta}^2 + r^2\sin^2\theta\dot{\phi}^2$. The Lagrangian is:
$$
\mathcal{L} = \frac{1}{2}m(\dot{r}^2 + r^2\dot{\theta}^2 + r^2\sin^2\theta\dot{\phi}^2) - U(r, \theta, \phi)
$$
The momenta are:
$$
\begin{aligned}
 & p_r = m\dot{r} \\[1ex]
 & p_\theta = mr^2\dot{\theta} \\[1ex]
 &  p_\phi = mr^2\sin^2\theta\dot{\phi}
\end{aligned}
$$
Velocities:
$$
\begin{aligned}
 & \dot{r} = \frac{p_r}{m} \\[1ex]
 & \dot{\theta} = \frac{p_\theta}{mr^2} \\[1ex]
 &  \dot{\phi} = \frac{p_\phi}{mr^2\sin^2\theta}
\end{aligned}
$$
The Hamiltonian is:
$$
\boxed {
H = \frac{p_r^2}{2m} + \frac{p_\theta^2}{2mr^2} + \frac{p_\phi^2}{2mr^2\sin^2\theta} + U(r, \theta, \phi)
 }
$$

