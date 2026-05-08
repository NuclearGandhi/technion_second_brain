---
aliases:
---
# Disintegration of Particles
In many cases the laws of conservation of momentum and energy alone can be used to obtain important results concerning the properties of various mechanical processes. It should be noted that these properties are independent of the particular type of interaction between the particles involved.
Let us consider a "spontaneous" disintegration (this is, one not due to external forces) of a particle into two "constituent parts", i.e. into two other particles which move independently after the disintegration.
This process is most simply described in a frame of reference in which the particle is at rest before the disintegration. The law of conservation of momentum shows that the sum of the momenta of the two particles formed in the disintegration is then zero; that is, the particles move apart with equal and opposite momenta. The magnitude ${p}_{0}$ of either momentum is given by the laws of conservation of energy:
$${E}_{i}={E}_{1i} +\dfrac{{{{p}_{0}}}^{2}}{2{m}_{1}}+{E}_{2i} +\dfrac{{{{p}_{0}}}^{2}}{2{m}_{2}}$$
here ${m}_{1}$ and ${m}_{2}$ are the masses of the particles, ${E}_{1i}$ and ${E}_{2i}$ their internal energies, and ${E}_{i}$ the internal energy of the original particle. If $\epsilon$ is the "disintegration energy", i.e. the difference
$$\epsilon={E}_{i} - {E}_{1 i}-{E}_{2i}\tag{LL16.1}$$
which must obviously be positive, then
$$\epsilon=\dfrac{1}{2}{{{p}_{0}}}^{2}\left( \dfrac{1}{{m}_{1}}+\dfrac{1}{{m}_{2}} \right)=\dfrac{{{{p}_{0}}}^{2}}{2m}\tag{LL16.2}$$
which determines ${p}_{0}$; here $m$ is the reduced mass of the two particles. The velocities are ${v}_{10}={p}_{0}/{m}_{1}$ and ${v}_{20}={p}_{0}/{m}_{2}$.

Let us now change to a frame of reference in which the primary particle moves with velocity $V$ before the break-up. This frame is usually called the **laboratory system**, or $L$ system, in contradistinction to the **center of mass system**, or $C$ system, in which the total momentum is zero. Let us consider one of the resulting particles, and let $\mathbf{v}$ and $\mathbf{v}_{0}$ be its velocities in the $L$ and $C$ system respectively. Evidently $\mathbf{v}=\mathbf{V}+{\mathbf{v}}_{0}$, or $\mathbf{v}-\mathbf{V}=\mathbf{v}_{0}$, and so
$$v^{2}+V^{2}-2vV\cos\theta={{{v}_{0}}}^{2}\tag{LL16.3}$$

where $\theta$ is the angle at which this particle moves relative to the direction of the velocity $\mathbf{V}$. This equation gives the velocity of the particle as a function of its direction of motion in the $L$ system. In [[#^figure-mechanics-14|figure]] the velocity $\mathbf{v}$ is represented by a vector drawn to any point on a circle of radius ${v}_{0}$ from a point $A$ at a distance $V$ from the center. The cases $V<{v}_{0}$ and $V>{v}_{0}$ are shown in (a) and (b) respectively. In the former case $\theta$ can have any value, but in the latter case the particle can move only forwards, at an angle $\theta$ which does not exceed ${\theta}_{\max_{}}$, given by
$$\sin{\theta}_{\max_{}}=\dfrac{{v}_{0}}{V}\tag{LL16.4}$$
This is the direction of the tangent from the point $A$ to the circle.

![[Pasted image 20260328151852.png|bookhue|600]]^figure-mechanics-14
>Geometry of a particle disintegration. [[THP1_000 Course of Theoretical Physics - Mechanics#Bibliography|(Landau & Lifšic, 1976)]].

The relation between the angles $\theta$ and ${\theta}_{0}$ in the $L$ and $C$ systems is evidently
$$\tan\theta=\dfrac{{v}_{0}\sin{\theta}_{0}}{{v}_{0}\cos{\theta}_{0}+V}\tag{LL16.5}$$
If this equation is solved for $\cos{\theta}_{0}$, we obtain
$$\cos{\theta}_{0}=-\dfrac{V}{{v}_{0}}\sin ^{2}\theta\pm \cos\theta\sqrt{ \left( 1-\dfrac{V^{2}}{{{{v}_{0}}}^{2}}\sin ^{2}\theta \right) }\tag{LL16.6}$$

For ${v}_{0}>V$ the relation between ${\theta}_{0}$ and $\theta$ is one-to-one ([[#^figure-mechanics-14|figure]] (a)). The plus sign must be taken in $\text{(LL16.6)}$ so that ${\theta}_{0}=0$ when $\theta=0$. If ${v}_{0}<V$, however, the relation is not one-to-one: for each value of $\theta$ there are two values of ${\theta}_{0}$, which correspond to vectors $\mathbf{v}_{0}$ drawn from the center of the circle to the points $B$ and $C$ ([[#^figure-mechanics-14|figure]] (b)), and are given by the two signs in $\text{(LL16.6)}$.

In physical applications we are usually concerned with the disintegration of not one but many similar particles, and this raises the problem of the distribution of the resulting particles in direction, energy, etc. We shall assume that the primary particles are randomly oriented in space, i.e. isotropically on average.

In the $C$ system, this problem is very easily solved: every resulting particle (of a given kind) has the same energy, and their directions of motion are isotropically distributed. The latter fact depends on the assumption that the primary particles are randomly oriented, and can be expressed by saying that the fraction of particles entering a solid angle element $\mathrm{d}{o}_{0}$ is proportional to $\mathrm{d}{o}_{0}$, i.e. equal to $\mathrm{d}{o}_{0}/4\pi$.

>[!note] Unpacking the Paragraph Above
>The key idea is to think statistically. Instead of tracking one disintegration, imagine a large ensemble of identical particles, each about to disintegrate. Since they are randomly oriented, the axis along which the two products fly apart points in a random direction - no direction is preferred.
>
>In the $C$ system, the physics of the disintegration fixes the *speed* $v_0$ of each product (via energy/momentum conservation), but says nothing about the *direction*. Combined with the random orientation of the parent particle, this means the resulting particles are equally likely to fly off in any direction - they are **isotropically distributed**.
>
>The solid angle element $\mathrm{d}o_0$ measures a small "patch" of directions on a sphere. The total solid angle of a full sphere is $4\pi$ steradians. If directions are isotropic, the fraction of particles heading into any patch $\mathrm{d}o_0$ is simply the ratio $\mathrm{d}o_0 / 4\pi$.

The distribution with respect to the angle ${\theta}_{0}$ is obtained by putting $\mathrm{d}{o}_{0}=2\pi \sin{\theta}_{0}\,\mathrm{d}{\theta}_{0}$, i.e. the corresponding fraction is
$$\dfrac{1}{2}\sin{\theta}_{0}\,\mathrm{d}{\theta}_{0}\tag{LL16.7}$$

The corresponding distributions in the $L$ system are obtained by an appropriate transformation. For example, let us calculate the kinetic energy distribution in the $L$ system. Squaring the equation $\mathbf{v}=\mathbf{v}_{0}+\mathbf{V}$, we have $v^{2}={{{v}_{0}}}^{2}+V^{2}+2{v}_{0}V\cos{\theta}_{0}$, whence $\mathrm{d}(\cos{\theta}_{0})=\mathrm{d}(v^{2})/2{v}_{0}V$. Using the kinetic energy $T=\dfrac{1}{2}mv^{2}$, where $m$ is ${m}_{1}$ or ${m}_{2}$ depending on which kind of particle is under consideration, and substituting in $\text{(LL16.7)}$, we find the required distribution:
$$\dfrac{1}{2m{v}_{0}V}\,\mathrm{d}T\tag{LL16.8}$$
The kinetic energy can take values between ${T}_{\min_{}}=\dfrac{1}{2}m({v}_{0}-V)^{2}$ and ${T}_{\max_{}}=\dfrac{1}{2}m({v}_{0}+V)^{2}$. The particles are, according to $\text{(LL16.8)}$, distributed uniformly over this range.

When a particle disintegrates into more than two parts, the laws of conservation of energy and momentum naturally allow considerably more freedom as regards the velocities and directions of motion of the resulting particles. In particular, the energies of these particles in the $C$ system do not have determinate values. There is, however, an upper limit to the kinetic energy of any one of the resulting particles. To determine the limit, we consider the system formed by all these particles except the one concerned (whose mass is ${m}_{1}$, say), and denote the "internal energy" of that system by ${E}_{i}'$. Then the kinetic energy of the particle ${m}_{1}$ is, by $\text{(LL16.1)}$ and $\text{(LL16.2)}$:
$${T}_{10}=\dfrac{{{{p}_{0}}}^{2}}{2{m}_{1}}=\dfrac{(M-{m}_{1})({E}_{i}-{E}_{1i}-{E}_{i}')}{M}$$ where $M$ is the mass of the primary particle. It is evident that ${T}_{10}$ has its greatest possible value when ${E}_{i}'$ is least. For this to be so, all the resulting particles except ${m}_{1}$ must be moving with the same velocity. Then ${E}_{i}'$ is simply the sum of their internal energies, and the difference ${E}_{i}-{E}_{1i}-{E}_{i}'$ is the disintegration energy $\epsilon$. Thus
$${T}_{10,\max_{}}=\dfrac{(M-{m}_{1})\epsilon}{M}\tag{LL16.9}$$

# Elastic Collisions
A collision between two particles is said to be *elastic* if it involves no change in their internal state. Accordingly, when the law of conservation of energy is applied to such a collision, the internal energy of the particles may be neglected.
The collision is most simply described in a frame of reference in which the center of mass of the two particles is at rest (the $C$ system). As in the previous section, we distinguish by the suffix $0$ the values of quantities in that system. The velocities of the particles before the collision are related to their velocities $\mathbf{v}_{1}$ and $\mathbf{v}_{2}$ in the laboratory system by $\mathbf{v}_{10}=\dfrac{{m}_{2}\mathbf{v}}{{m}_{1}+{m}_{2}}$ and $\mathbf{v}_{20}=-\dfrac{{m}_{1}\mathbf{v}}{{m}_{1}+{m}_{2}}$, where $\mathbf{v}=\mathbf{v}_{1}-\mathbf{v}_{2}$.
Because of the law of conservation of momentum, the momenta of the two particles remain equal and opposite after the collision, and are also unchanged in magnitude, by the law of conservation of energy. Thus, in the $C$ system the collision simply rotates the velocities, which remain opposite in direction and unchanged in magnitude. If we denote by $\mathbf{n}_{0}$ a unit vector in the direction of the velocity of the particle ${m}_{1}$ after the collision, then the velocities of the two particles after the collision (distinguished by primes) are
$$\mathbf{v}_{10}'=\dfrac{{m}_{2}v\mathbf{n}_{0}}{{m}_{1}+{m}_{2}},\qquad \mathbf{v}_{20}'=-\dfrac{{m}_{1}v\mathbf{n}_{0}}{{m}_{1}+{m}_{2}}\tag{LL17.1}$$
In order to return to the $L$ system, we must add to these expressions the velocity $\mathbf{V}$ of the center of mass. The velocities in the $L$ system after the collision are therefore
$$\begin{aligned}
 & \mathbf{v}_{1}'=\dfrac{{m}_{2}v\mathbf{n}_{0}}{{m}_{1}+{m}_{2}}+\dfrac{{m}_{1}\mathbf{v}_{1}+{m}_{2}\mathbf{v}_{2}}{{m}_{1}+{m}_{2}} \\[1ex]
 & \mathbf{v}_{2}'=-\dfrac{{m}_{1}v\mathbf{n}_{0}}{{m}_{1}+{m}_{2}}+\dfrac{{m}_{1}\mathbf{v}_{1}+{m}_{2}\mathbf{v}_{2}}{{m}_{1}+{m}_{2}}
\end{aligned}\tag{LL17.2}$$
No further information about the collision can be obtained from the laws of conservation of momentum and energy. The direction of the vector $\mathbf{n}_{0}$ depends on the law of interaction of the particles and on their relative position during the collision.
The results obtained above may be interpreted geometrically. Here it is more convenient to use momenta instead of velocities. Multiplying equations $\text{(LL17.2)}$ by ${m}_{1}$ and ${m}_{2}$ respectively, we obtain
$$\begin{aligned}
 & \mathbf{p}_{1}'=mv\mathbf{n}_{0}+\dfrac{{m}_{1}(\mathbf{p}_{1}+\mathbf{p}_{2})}{{m}_{1}+{m}_{2}} \\[1ex]
 & \mathbf{p}_{2}'=-mv\mathbf{n}_{0}+\dfrac{{m}_{2}(\mathbf{p}_{1}+\mathbf{p}_{2})}{{m}_{1}+{m}_{2}}
\end{aligned}\tag{LL17.3}$$
where $m=\dfrac{{m}_{1}{m}_{2}}{{m}_{1}+{m}_{2}}$ is the reduced mass. We draw a circle of radius $mv$ and use the construction shown in [[#^figure-mechanics-15|figure]]. If the unit vector $\mathbf{n}_{0}$ is along $OC$, the vectors $AC$ and $CB$ give the momenta $\mathbf{p}_{1}'$ and $\mathbf{p}_{2}'$ respectively. When $\mathbf{p}_{1}$ and $\mathbf{p}_{2}$ are given, the radius of the circle and points $A$ and $B$ are fixed, but the point $C$ may be anywhere on the circle.

![[Pasted image 20260328174102.png|bookhue|450]]^figure-mechanics-15
>Geometric interpretation of an elastic collision. [[THP1_000 Course of Theoretical Physics - Mechanics#Bibliography|(Landau & Lifšic, 1976)]].

>[!note] Understanding the Geometric Construction
>The diagram encodes **all possible outcomes** of an elastic collision in a single picture. Here is how to read it:
>
>**Why a circle?** In the $C$ system, conservation laws dictate that the collision can only *rotate* the relative velocity — it cannot change its magnitude. The tip of the C-system momentum vector $mv\mathbf{n}_0$ can therefore point in any direction, and all such directions trace out a **circle of radius** $mv$ centered at $O$.
>
>**What are points $A$ and $B$?** From $\text{(LL17.3)}$, each particle's lab momentum $\mathbf{p}'$ is the C-system momentum $(\pm mv\mathbf{n}_0)$ **plus** a fixed offset that comes from the total momentum $\mathbf{P}=\mathbf{p}_1+\mathbf{p}_2$. Specifically:
>- $A$ is the point at distance $\dfrac{{m}_{1}P}{{m}_{1}+{m}_{2}}$ from $O$, opposite to the direction of $\mathbf{P}$
>- $B$ is the point at distance $\dfrac{{m}_{2}P}{{m}_{1}+{m}_{2}}$ from $O$, in the direction of $\mathbf{P}$
>
>These points are fixed once the initial conditions are known. Note that $\overrightarrow{AB}=\mathbf{P}$, the total momentum.
>
>**How to read off the result:** Pick any point $C$ on the circle — this represents one possible scattering direction. Then:
>- $\overrightarrow{AC}=\mathbf{p}_{1}'$ (the momentum of particle 1 after the collision)
>- $\overrightarrow{CB}=\mathbf{p}_{2}'$ (the momentum of particle 2 after the collision)
>
>You can verify this adds up: $\overrightarrow{AC}+\overrightarrow{CB}=\overrightarrow{AB}=\mathbf{P}$, so momentum is conserved for every choice of $C$.
>
>**The physical content** is that the laws of conservation pin down everything *except* the scattering angle $\chi$ (the angle $\angle BOC$). That angle depends on the details of the interaction. But no matter what $\chi$ turns out to be, the result must lie somewhere on the circle.

Let us consider in more detail the case where one of the particles (${m}_{2}$, say) is at rest before the collision. In that case the distance $OB=\dfrac{{m}_{2}{p}_{1}}{{m}_{1}+{m}_{2}}=mv$ is equal to the radius, i.e. $B$ lies on the circle. The vector $AB$ is equal to the momentum $\mathbf{p}_{1}$ of the particle ${m}_{1}$ before the collision. The point $A$ lies inside or outside the circle, according as ${m}_{1}<{m}_{2}$ or ${m}_{1}>{m}_{2}$. The corresponding diagrams are shown in [[#^figure-mechanics-16|figure]] (a) and (b). The angles ${\theta}_{1}$ and ${\theta}_{2}$ in these diagrams are the angles between the directions of motion after the collision and the direction of impact (i.e. of $\mathbf{p}_{1}$). The angle at the center, denoted by $\chi$, which gives the direction $\mathbf{n}_{0}$, is the angle through which the direction of motion of ${m}_{1}$ is turned in the $C$ system. It is evident from the figure that ${\theta}_{1}$ and ${\theta}_{2}$ can be expressed in terms of $\chi$ by
$$\tan{\theta}_{1}=\dfrac{{m}_{2}\sin \chi}{{m}_{1}+{m}_{2}\cos \chi},\qquad {\theta}_{2}=\dfrac{1}{2}(\pi-\chi)\tag{LL17.4}$$

![[Pasted image 20260328174622.png|bookhue|600]]^figure-mechanics-16
>Geometric interpretation of an elastic collision, where ${m}_{2}$ is at rest before the collision. [[THP1_000 Course of Theoretical Physics - Mechanics#Bibliography|(Landau & Lifšic, 1976)]].

We may give also the formula for the magnitudes of the velocities of the two particles after the collision, likewise expressed in terms of $\chi$:
$$\begin{aligned}
 & {v}_{1}'=\dfrac{v\sqrt{ {{{m}_{1}}}^{2}+{{{m}_{2}}}^{2}+2{m}_{1}{m}_{2}\cos \chi }}{{m}_{1}+{m}_{2}} \\[1ex]
 & {v}_{2}'=\dfrac{2{m}_{1}v}{{m}_{1}+{m}_{2}}\sin\left( \dfrac{1}{2}\chi \right)
\end{aligned}\tag{LL17.5}$$
The sum ${\theta}_{1}+{\theta}_{2}$ is the angle between the directions of motion of the particles after the collision. Evidently ${\theta}_{1}+{\theta}_{2}>\dfrac{1}{2}\pi$ if ${m}_{1}<{m}_{2}$, and ${\theta}_{1}+{\theta}_{2}<\dfrac{1}{2}\pi$ if ${m}_{1}>{m}_{2}$.
When the two particles are moving afterwards in the same or in opposite directions (head-on collision), we have $\chi=\pi$, i.e. the point $C$ lies on the diameter through $A$, and is on $OA$ ([[#^figure-mechanics-16|figure]] (b); $\mathbf{p}_{1}'$ and $\mathbf{p}_{2}'$ in the same direction) or on $OA$ produced ([[#^figure-mechanics-16|figure]] (a); $\mathbf{p}_{1}'$ and $\mathbf{p}_{2}'$ in opposite directions).
In this case the velocities after the collision are
$$\mathbf{v}_{1}'=\dfrac{{m}_{1}-{m}_{2}}{{m}_{1}+{m}_{2}}\mathbf{v},\qquad \mathbf{v}_{2}'=\dfrac{2{m}_{1}}{{m}_{1}+{m}_{2}}\mathbf{v}\tag{LL17.6}$$

This value of $\mathbf{v}_{2}'$ has the greatest possible magnitude, and the maximum energy which can be acquired in the collision by a particle originally at rest is therefore
$$E'_{2,\max_{}}=\dfrac{1}{2}{m}_{2}({v}_{2}' \,_{\max_{}})^{2}=\dfrac{4{m}_{1}{m}_{2}}{({m}_{1}+{m}_{2})^{2}}{E}_{1}\tag{LL17.7}$$
where ${E}_{1}=\dfrac{1}{2}{m}_{1}{{{v}_{1}}}^{2}$ is the initial energy of the incident particle.
If ${m}_{1}<{m}_{2}$, the velocity of ${m}_{1}$ after the collision can have any direction. If ${m}_{1}>{m}_{2}$ however, this particle can be deflected only through an angle not exceeding ${\theta}_{\max_{}}$ from its original direction; this maximum value of ${\theta}_{1}$ corresponds to the position of $C$ for which $AC$ is a tangent to the circle. Evidently
$$\sin{\theta}_{\max_{}}=\dfrac{OC}{OA}=\dfrac{{m}_{2}}{{m}_{1}}\tag{LL17.8}$$
The collision of two particles of equal mass, of which one is initially at rest, is especially simple. In this case both $B$ and $A$ lie on the circle ([[#^figure-mechanics-17|figure]]).

![[Pasted image 20260328180033.png|bookhue|350]]^figure-mechanics-17
>Geometric interpretation of an elastic collision, where ${m}_{2}$ is at rest before the collision, and ${m}_{1}={m}_{2}$. [[THP1_000 Course of Theoretical Physics - Mechanics#Bibliography|(Landau & Lifšic, 1976)]].

Then
$$\begin{align}
 & {\theta}_{1}=\dfrac{1}{2}\chi, &  & {\theta}_{2}=\dfrac{1}{2}(\pi-\chi)\tag{LL17.9} \\[1ex]
 & {v}_{1}'=v\cos\left( \dfrac{1}{2}\chi \right), &  & {v}_{2}'=v\sin\left( \dfrac{1}{2}\chi \right)\tag{LL17.10}
\end{align}$$
After the collision the particles move at right angles to each other.

# Scattering
As already mentioned in [[#Elastic Collisions]], a complete calculation of the result of a collision between two particles (i.e. the determination of the angle $\chi$) requires the solution of the equations of motion for the particular law of interaction involved.

We shall first consider the equivalent problem of the deflection  of a single particle of mass $m$ moving in a field $U(r)$ whose center is at rest (and is at the center of mass of the two particles in the original problem).

As has been shown in [[THP1_003 Integration of the Equations of Motion#Motion in a Central Field|Motion in a Central Field]], the path of a particle in a center field is symmetrical about a line from the center to the nearest point in the orbit ($OA$ in [[#^figure-mechanics-18|figure]]). Hence the two asymptotes to the orbit make equal angles (${\phi}_{0}$, say) with this line. The angle $\chi$ through which the particle is deflected as it passes the center is seen from [[#^figure-mechanics-18|figure]] to be
$$\chi=\lvert \pi-2{\phi}_{0} \rvert \tag{LL18.1}$$

![[Pasted image 20260403103007.png|bookhue|450]]^figure-mechanics-18
>Deflection of a particle moving in a field $U(r)$ whose center is at rest.

The angle ${\phi}_{0}$ itself is given, according to [[THP1_003 Integration of the Equations of Motion#Motion in a Central Field|equation]] $\text{(LL14.7)}$, by
$${\phi}_{0}=\int_{{r}_{\min_{}}}^{\infty}  \dfrac{(M/r^{2})}{\sqrt{ 2m[E-U(r)]-M^{2}/r^{2} }} \, \mathrm{d}r\tag{LL18.2} $$
taken between the nearest approach to the center and infinity. It should be recalled that ${r}_{\min_{}}$ is a zero of the radicand.
For an infinite motion, such as that considered here, it is convenient to use instead of the consonants $E$ and $M$ the velocity ${v}_{\infty}$ of the particle at infinity and the *impact parameter* $\rho$. The latter is the length of the perpendicular from the center $O$ to the direction of ${v}_{\infty}$, i.e. the distance at which the particle would pass the center if there were no field of force ([[#^figure-mechanics-18|figure]]). The energy and the angular momentum are given in terms of these quantities by
$$E=\dfrac{1}{2}m{{{v}_{\infty }}}^{2},\qquad M=m\rho {v}_{\infty }\tag{LL18.3}$$
and formula $\text{(LL18.2)}$ becomes
$${\phi}_{0}=\int_{{r}_{\min_{}}}^{\infty}  \dfrac{(\rho/r^{2})}{\sqrt{ 1-(\rho ^{2}/r^{2}) -(2U/m{{{v}_{\infty }}}^{2})}} \, \mathrm{d}r\tag{LL18.4} $$
Together with $\text{(LL18.1)}$, this gives $\chi$ as a function of $\rho$.
In physical application we are usually concerned not with the deflection of a single particle but with the *scattering* center. The different particles in the beam have different impact parameters and are therefore scattered through different angles $\chi$. Let $\mathrm{d}N$ be the number of particles scattered per unit time though angles between $\chi$ and $\chi+\mathrm{d}x$. This number itself is not suitable for describing the scattering process, since it is proportional to the density of the incident beam. We therefore use the ratio
$$\mathrm{d}\sigma=\dfrac{\mathrm{d}N}{n}\tag{LL18.5}$$
where $n$ is the number of particles passing in unit time through unit area of the beam cross-section (the beam being assumed uniform over its cross-section). This ratio has the dimensions of area and is called the **effective scattering cross-section**. It is entirely determined by the form of the scattering field and is the motion important characteristic of the scattering process.
We shall suppose that the relation between $\chi$ and $\rho$ is one-to-one; this is so if the angle of scattering is a monotonically decreasing function of the impact parameter. In that case, only those particles whose impact parameters lie between $\rho(x)$ and $\rho(x)+\mathrm{d}\rho(x)$ are scattered at angles between $\chi$ and $\chi+\mathrm{d}\chi$. The number of such particles is equal to the product of $n$ and the area between two circles of radii $\rho$ and $\rho+\mathrm{d}\rho$, i.e. $\mathrm{d}N=2\pi \rho\,\mathrm{d}\rho\,\cdot n$. The effective cross-section is therefore
$$\mathrm{d}\sigma=2\pi \rho\,\mathrm{d}\rho\tag{LL18.6}$$
In order to find the dependence of $\mathrm{d}\sigma$ on the angle of scattering, we need only rewrite $\text{(LL18.6)}$ as
$$\mathrm{d}\sigma=2\pi \rho(\chi)\left\lvert  \dfrac{\mathrm{d}\rho(\chi)}{\mathrm{d}\chi}  \right\rvert \mathrm{d}\chi\tag{LL18.7} $$
Here we use the modulus of the derivative $\mathrm{d}\rho /\mathrm{d}\chi$, since the derivative may be (and usually is) negative. Often $\mathrm{d}\sigma$ is referred to the solid angle element $\mathrm{d}o$ instead of the plane angle element $\mathrm{d}\chi$. The solid angle between cones with vertical angles $\chi$ and $\chi+\mathrm{d}\chi$ is $\mathrm{d}o=2\pi \chi\,\mathrm{d}\chi$. Hence we have from $\text{(LL18.7)}$
$$\mathrm{d}\sigma=\dfrac{\rho(\chi)}{\sin\chi} \dfrac{\mathrm{d}\rho}{\mathrm{d}\chi}\mathrm{d}o\tag{LL18.8}$$
Returning now to the problem of scattering of a beam of particles, not by a fixed center of force, but by other particles initially at rest, we can say that $\text{(LL18.7)}$ gives the effective cross section as a function of the angle of scattering in the center-of-mass system. To find the corresponding expression as a function of the scattering angle $\theta$ in the laboratory system, we must express $\chi$ in $\text{(LL18.7)}$ in terms of $\theta$ by means of formula $\text{(LL17.4)}$. This gives expressions for both the scattering cross-section for the incident beam of particles ($\chi$ in terms of ${\theta}_{1}$) and that for the particles initially at rest ($\chi$ in terms of ${\theta}_{2}$).

> [!Stop]
>Stopped here. Became boring.