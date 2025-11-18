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
since the derivatives $\partial L/ \partial \dot{q}_{i}$ are, by definition, the **generalized momentum**, and $\partial L/\partial {q}_{i}=\dot{p}_{i}$ by Euler-Lagrange'sequations.

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
$$\dfrac{\mathrm{d}H}{\mathrm{d}t}=\dfrac{ \partial H }{ \partial t } $$
In particular, if the Hamiltonian does not depend explicitly on time, then $\mathrm{d}H/\mathrm{d}t=0$, and we have law of conservation of energy.