---
aliases:
---
Chasles' theorem states that any general displacement of a rigid body can be represented by a translation plus a rotation. The theorem suggests that it ought to be possible to split the problem of a rigid body motion into two separate phases, one concerned solely with the translational motion of the body, the other, with its rotational motion. Of course, if one point of the body is fixed, the separation is obvious, for then there is only a rotational motion about the fixed point, without any translation. But even for a general type of motion such a separation is often possible. The six coordinates needed to describe the motion are: the three Cartesian coordinates of a point fixed in the rigid body to describe the translational motion and, say, the three Euler angles for the motion about the point. If, further, the origin of the body system is chosen to be the center of mass, then total kinetic energy $T$ can be written in the form:
$$T=\dfrac{1}{2}Mv^{2}+T'(\phi,\theta,\psi)$$
As the sum of the sum of the kinetic energy of the entire body as if concentrated at the center of mass, plus the kinetic energy of motion about the center of mass.

Often the potential energy can be similarly divided, each term involving only one of the coordinate sets, either the translational or rotational. Thus, the potential energy in a uniform gravitational field will depend only upon the Cartesian vertical coordinate of the center of gravity. Certainly, almost all problems soluble in practice will allow for such a separation. In such a case, the entire mechanical problem does indeed split into two. The Lagrangian, $L=T-V$, divides into two parts, one involving only the translational coordinates, the other only the angle coordinates. These two groups of coordinates will then be completely separated, and the translational and rotational problems can be solves independently of each other.

Let $\mathbf{R}_{1}$ and $\mathbf{R}_{2}$ be the position vectors, relative to a fixed set of coordinates, of the origins of two sets of body coordinates. The difference vector is denoted by $\mathbf{R}$:
$$\mathbf{R}_{2}=\mathbf{R}_{1}+\mathbf{R}$$

![[Pasted image 20260623074543.png|bookhue|600]]^figure-5-1
>Vectorial relation between sets of rigid body coordinates with different origins. [[CMC1_000 Classical Mechanics#Bibliography|(Goldstein, 2016)]].

If the origin of the second set of axes is considered as a point defined relative to the first, then time derivative of $\mathbf{R}_{2}$ relative to the space axes is given by
$$\left( \dfrac{\mathrm{d}\mathbf{R}_{2}}{\mathrm{d}t} \right)_{s}=\left( \dfrac{\mathrm{d}\mathbf{R}_{1}}{\mathrm{d}t} \right)_{s}+\left( \dfrac{\mathrm{d}\mathbf{R}}{\mathrm{d}t} \right)_{s}=\left( \dfrac{\mathrm{d}\mathbf{R}_{1}}{\mathrm{d}t} \right)_{s}+\boldsymbol{\omega}_{1}\times \mathbf{R}$$
Here subscript $s$ indicate the time derivative observed in the space/world system of axes.

The last step is due to the derivatives of $\mathbf{R}$ relative to any rigid body axes must vanish, and with $\boldsymbol{\omega}_{1}$ as being the angular velocity vector appropriate to the first coordinate system:
$$\left( \dfrac{\mathrm{d}}{\mathrm{d}t} \right)_{s}=\left( \dfrac{\mathrm{d}}{\mathrm{d}t} \right)_{r}+\boldsymbol{\omega}\times\tag{HG4.86}$$Which is an operator generalization of:
$$\left( \dfrac{\mathrm{d}\mathbf{G}}{\mathrm{d}t} \right)_{\text{space}}=\left( \dfrac{\mathrm{d}\mathbf{G}}{\mathrm{d}t} \right)_{\text{body}}+\boldsymbol{\omega}\times \mathbf{G}\tag{HG4.82}$$
where $\boldsymbol{\omega}\mathrm{d}t=\mathrm{d}\boldsymbol{\Omega}$.

Alternatively, the origin of the first coordinate system can be considered fixed in the second system with position vector $-\mathbf{R}$:
$$\left( \dfrac{\mathrm{d}\mathbf{R}_{1}}{\mathrm{d}t} \right)_{s}=\left( \dfrac{\mathrm{d}\mathbf{R}_{2}}{\mathrm{d}t} \right)_{s}-\left( \dfrac{\mathrm{d}\mathbf{R}}{\mathrm{d}t} \right)_{s}=\left( \dfrac{\mathrm{d}\mathbf{R}_{2}}{\mathrm{d}t} \right)_{s}-\boldsymbol{\omega}_{2}\times \mathbf{R}$$
A comparison of these two expressions shows $(\boldsymbol{\omega}_{1}-\boldsymbol{\omega}_{2})\times \mathbf{R}=0$. Any difference in the angular velocity vectors at two arbitrary points must lie along the line joining the two points. Assuming the $\boldsymbol{\omega}$ vector field is continuous, the only possible solution for all pairs of points is that the two angular velocity vectors must be equal:
$$\boldsymbol{\omega}_{1}={{\boldsymbol{\omega}_{2}}}^{*}$$

The angular velocity vector is the same for all coordinate systems fixed in the rigid body.

When a rigid body moves with one point stationary, the total angular momentum about that point is
$$\mathbf{L}={m}_{i}(\mathbf{r}_{i}\times \mathbf{v}_i\tag{HG5.1})$$
employing the summation convention.
Here, $\mathbf{r}_{i}$ and $\mathbf{v}_{i}$ are the radius vector and velocity, respectively, of the $i$-th particle relative to the given point. Since $\mathbf{r}_{i}$ is a fixed vector relative to the body, the velocity $\mathbf{v}_{i}$ with respect to the space set of axes arises solely from the rotational motion of the rigid body about the fixed point. Therefore, from $\text{(HG4.86)}$:
$$\mathbf{v}_{i}=\boldsymbol{\omega}\times \mathbf{r}_{i}\tag{HG5.2}$$
Hence, $\text{(HG5.1)}$ can be written as
$$\mathbf{L}={m}_{i}[\mathbf{r}_{i}\times(\boldsymbol{\omega}\times \mathbf{r}_{i})]$$
or, expanding the triple cross product,
$$\mathbf{L}={m}_{i}[\boldsymbol{\omega}{{{r}_{i}}}^{2}-\mathbf{r}_{i}(\mathbf{r}_{i}\cdot\boldsymbol{\omega})]\tag{HG5.3}$$
Again expanding, the $x$-component of the angular momentum becomes
$${L}_{x}={\omega}_{x}{m}_{i}({{{r}_{i}}}^{2}-{{{x}_{i}}}^{2})-{\omega}_{y}{m}_{i}{x}_{i}{y}_{i}-{\omega}_{z}{m}_{i}{x}_{i}{z}_{i}\tag{HG5.4}$$

with similar equations for the other components of $\mathbf{L}$. Thus, each component of the angular momentum is a linear function of all the components of the angular velocity. *The angular momentum vector is related to the angular velocity by a linear transformation*. To emphasize the similarity of $\text{(HG5.4)}$ with the equations of a linear transformation, we may write ${L}_{x}$ as
$${L}_{x}={I}_{xx}{\omega}_{x}+{I}_{xy}{\omega}_{y}+{I}_{xz}{\omega}_{z}.$$
Analogously, for ${L}_{y}$ and ${L}_{z}$ we have
$$\begin{align}
 & {L}_{z}={I}_{yx}{\omega}_{x}+{I}_{yy}{\omega}_{y}+{I}_{yz}{\omega}_{z}, \\[1ex]
 & {L}_{z}={I}_{zx}{\omega}_{x}+{I}_{zy}{\omega}_{y}+{I}_{zz}{\omega}_{z}
\end{align}\tag{HG5.5}$$
The nine coefficients ${I}_{xx},{I}_{xy},$ etc., are the nine elements of the transformation matrix. The diagonal elements are known as *moment of inertia coefficients*, and have the following form
$${I}_{xx}={m}_{i}({{{r}_{i}}}^{2}-{{{x}_{i}}}^{2})\tag{HG5.6}$$
while the off-diagonal elements are designated as *products of inertia*, a typical one being
$${I}_{xy}=-{m}_{i}{x}_{i}{y}_{i}\tag{HG5.7}$$


# The Eigenvalues of the Inertia Tensor and the Principal Axis Transformation
The preceding discussion emphasizes the important role the inertia tensor plays in the discussion of the motion of rigid bodies. An examination, at this point, of the properties of this tensor and its associated matrix will therefore prove of considerable interest. From the defining equation, $\text{(HG5.7)}$, it is seen that the components of the tensor are symmetrical, that is
$${I}_{xy}={I}_{yx}\tag{HG5.24}$$

This means that, while the inertia tensor will in general have nine components, only six of them will be independent—the three along the diagonal plus three of the off-diagonal elements.

The inertia coefficients depend both upon the location of the origin of the body set of axes and upon the orientation of these axes with respect to the body. This symmetry suggests that there exists a set of coordinates in which the tensor is diagonal with the three principal values ${I}_{1}$, ${I}_{2}$ and ${I}_{3}$. In this system, the components of $\mathbf{L}$ would involve only the corresponding component of $\boldsymbol{\omega}$, thus
$$\begin{aligned}
L={I}_{1}{\omega}_{1}, &  & {L}_{2}={I}_{2}{\omega}_{2}, &  & {L}_{3}={I}_{3}{\omega}_{3}
\end{aligned}\tag{HG5.25}$$
A similar simplification would also occur in the form of the kinetic energy:
$$T=\dfrac{\boldsymbol{\omega}\cdot \mathbf{I}\cdot\boldsymbol{\omega}}{2}=\dfrac{1}{2}{I}_{1}{{{\omega}_{1}}}^{2}+\dfrac{1}{2}{I}_{2}{{{\omega}_{2}}}^{2}+\dfrac{1}{2}{I}_{3}{{{\omega}_{3}}}^{2}\tag{HG5.26}$$
We can show that it is always possible to find such axes, and the proof is based essentially on the symmetric nature of the inertia tensor.

The concept of principal axes can also be understood through some geometrical considerations that historically formed the first approach to the subject. The moment of inertia about a given axis has been defined as $I=\mathbf{n}\cdot \mathbf{I}\cdot \mathbf{n}$. Let the direction cosines of the axis be $\alpha,\beta,$ and $\gamma$ so that
$$\mathbf{n}=\alpha \mathbf{i}+\beta \mathbf{j}+\gamma \mathbf{k};$$
$I$ then can be written as
$$I={I}_{xx}\alpha ^{2}+{I}_{yy}\beta ^{2}+{I}_{zz}\gamma ^{2}+2{I}_{xy}\alpha \beta+2{I}_{yz}\beta\gamma+2{I}_{zx}\gamma\alpha \tag{HG5.32}$$
using the symmetry of $\mathbf{I}$ explicitly. It is convenient to define a vector $\boldsymbol{\rho}$ by the equation
$$\boldsymbol{\rho}=\dfrac{\mathbf{n}}{\sqrt{ I }}\tag{HG5.33}$$
The magnitude of $\boldsymbol{\rho}$ is thus related to the moment of inertia about the axis whose direction is given by $\mathbf{n}$. In terms of the components of this new vector, $\text{(HG5.32)}$ takes on the form
$$I={I}_{xx}{{{\rho}_{1}}}^{2}+{I}_{yy}{{{\rho}_{2}}}^{2}+{I}_{zz}{{{\rho}_{3}}}^{2}+2{I}_{xy}{\rho}_{1}{\rho}_{2}+2{I}_{yz}{\rho}_{2}{\rho}_{3}+2{I}_{zx}{\rho}_{3}{\rho}_{1}\tag{HG5.34}$$
Considered as a function of the three variables ${\rho}_{1},\,{\rho}_{2},\,{\rho}_{3}$, $\text{(HG5.34)}$ is the equation of some surfaces in $\rho$ space. In particular, $\text{(HG5.34)}$ is the equation of an ellipsoid designated as the *inertial ellipsoid*. We can always transform to a set of Cartesian axes in which the equation of an ellipsoid taken on its normal form:
$$1={I}_{1}{{{\rho}'_{1}}}^{2}+{I}_{2}{{{\rho}'_{2}}}^{2}+{I}_{3}{{{\rho}'_{3}}}^{2}\tag{HG5.35}$$
with the principal axes of the ellipsoid along the new coordinates axes.

# Torque-Free Motion of a Rigid Body
One problem in rigid dynamics where [[DYN1_008 טנזור האינרציה#משוואות אויילר|Euler's equations]] are applicable is in the motion of a rigid body not subject to any net forces or torques. The center of mass is then either at rest of moving uniformly, and it does not decrease the generality of the solution to discuss the rotational motion in a reference frame in which the center of mass is stationary. In such a case, the angular momentum arises only from a rotation about the center of mass, and Euler's equations are the equations of motion for the complete system. In the absence of any net torques, they reduce to
$$\begin{aligned}
 & {I}_{1}\dot{\omega}_{1}={\omega}_{2}{\omega}_{3}({I}_{2}-{I}_{3}) \\[1ex]
 & {I}_{2}\dot{\omega}_{2}={\omega}_{3}{\omega}_{1}({I}_{3}-{I}_{1}) \\[1ex]
 & {I}_{3}\dot{\omega}_{3}={\omega}_{1}{\omega}_{2}({I}_{1}-{I}_{2})
\end{aligned}\tag{HG5.40}$$
The same equations, of course, will also describe the motion of a rigid body when one point is fixed and there are no net applied torques. We know two immediate integral of the motion, for both the kinetic energy and the total angular momentum vector must be constant in time. With these two integrals it is possible to integrate $\text{(5.40)}$ completely in terms of elliptic functions, but such a treatment is not very illuminating. However, it is also possible to derive an elegant geometrical description of the motion, known as Poinsot's construction, without requiring a complete solution to the problem.

Let us consider a coordinate system oriented along the principal axes of the body but whose axes measure the components of a vector $\boldsymbol{\rho}$ along the instantaneous axis of rotation as defined by $\text{(HG5.33)}$. For our purposes, it is convenient to make use of $T=\dfrac{1}{2}I\omega ^{2}$ for the kinetic energy, which is constant here, and write the definition of $\boldsymbol{\rho}$ in the form
$$\boldsymbol{\rho}=\dfrac{\boldsymbol{\omega}}{\omega\sqrt{ I }}=\dfrac{\boldsymbol{\omega}}{\sqrt{ 2T }}\tag{HG5.41}$$
In this $\boldsymbol{\rho}$ space, we define a function
$$F(\rho)=\boldsymbol{\rho}\cdot \mathbf{I}\cdot \boldsymbol{\rho}={{{\rho}_{i}}}^{2}{I}_{i}\tag{HG5.42}$$
where the surfaces of constant $F$ are ellipsoids, the particular surface $F=1$ being the inertia ellipsoid. As the direction of the axis of rotation changes in time, the parallel vector $\boldsymbol{\rho}$ moves accordingly, its tip always defining a point on the inertia ellipsoid. The gradient of $F$, evaluated at this point, furnishes the direction of the corresponding normal to the inertia ellipsoid. From $\text{(HG5.42)}$ for $F(\rho)$, the gradient of $F$ with respect to $\rho$ has the form
$$\nabla _{\rho}F=2\mathbf{I}\cdot \boldsymbol{\rho}=\dfrac{2\mathbf{I}\cdot\boldsymbol{\omega}}{\sqrt{ 2T }},$$
or
$$\nabla _{\rho}F=\sqrt{ \dfrac{2}{T} }\mathbf{L}\tag{HG5.43}$$

Thus, the $\boldsymbol{\omega}$ vector will always move such that the corresponding normal to the inertia ellipsoid is in the direction of the angular momentum. In the particular case under discussion, the direction of $\mathbf{L}$ is fixed in space, and it is the inertia ellipsoid (fixed with respect to the body) that must move in space in order to preserve this connection between $\boldsymbol{\omega}$ and $\mathbf{L}$.

![[Pasted image 20260623084751.png|bookhue|600]]^figure-5-4
>The motion of the inertia ellipsoid relative to the invariable plane.[[CMC1_000 Classical Mechanics#Bibliography|(Goldstein, 2016)]].

