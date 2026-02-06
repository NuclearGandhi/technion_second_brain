---
aliases:
---

>[!notes] Note: 
 >1. For general conservation laws, see [[DYN1_005 קינטיקה של חלקיק#עבודה מכנית של כוחות הפועלים על חלקיק|dynamics]].

# Mechanical Similarity
As established earlier, multiplying the Lagrangian by any constant does not affect the equations of motion. This property enables us to draw useful conclusions about the motion in certain cases, without explicitly solving the equations.

Consider systems where the potential energy is a **homogeneous function** of the coordinates, meaning it satisfies:
$$U(\alpha \mathbf{r}_{1},\alpha \mathbf{r}_{2},\dots ,\alpha \mathbf{r}_{n})=\alpha ^{k}U(\mathbf{r}_{1},\mathbf{r}_{2},\dots ,\mathbf{r}_{n})\tag{LL10.1}$$
Here $\alpha$ is an arbitrary scaling factor and $k$ is the **degree of homogeneity**.

Now consider a simultaneous rescaling of coordinates by a factor $\alpha$ and time by a factor $\beta$: $\mathbf{r}_{a}\to\alpha \mathbf{r}_{a}$ and $t \to\beta t$. Under this transformation:
- Velocities scale as $\mathbf{v}_{a}=\mathrm{d}\mathbf{r}_{a}/\mathrm{d}t \to (\alpha/\beta)\mathbf{v}_{a}$
- Kinetic energy $T \propto v^2$ scales by $\alpha^{2}/\beta^{2}$
- Potential energy scales by $\alpha^{k}$ (from the homogeneity property)

For the Lagrangian $\mathcal{L} = T - U$ to scale uniformly (so that the equations of motion are unchanged), we require $\alpha^{2}/\beta^{2} = \alpha^{k}$, which gives $\beta = \alpha^{1-k/2}$.

Scaling all coordinates by the same factor $\alpha$ produces a geometrically similar path - same shape, different size. We conclude that when the potential energy is a homogeneous function of degree $k$, the equations of motion admit geometrically similar solutions. The times required to traverse corresponding points on these similar paths are related by:
$$\dfrac{t'}{t}=\left( \dfrac{\ell'}{\ell} \right)^{1-k/2}\tag{LL10.2}$$
where $\ell'/\ell$ is the ratio of linear dimensions (sizes) of the paths.

Other mechanical quantities at corresponding points and times also scale as powers of $\ell'/\ell$:
$$\begin{aligned}
 & v'/v=(\ell'/\ell)^{k/2}, \\[1ex]
 & E'/E=(\ell'/\ell)^{k},\\[1ex]
 &  M'/M=(\ell'/\ell)^{1+k/2}
\end{aligned}\tag{LL10.3}$$

**Applications:**

- **Small oscillations** ($k=2$): The potential is quadratic in displacement. From $\text{(LL10.2)}$, $t'/t = (\ell'/\ell)^0 = 1$, meaning the period is independent of amplitude - a characteristic property of harmonic motion.

- **Uniform gravitational field** ($k=1$): The potential is linear in height. Then $t'/t = \sqrt{\ell'/\ell}$, implying that the time of free fall scales as the square root of the initial height.

- **Newtonian gravity / Coulomb interaction** ($k=-1$): The potential is inversely proportional to distance. Here $t'/t = (\ell'/\ell)^{3/2}$, which is *Kepler's third law*: the square of the orbital period is proportional to the cube of the orbital size.

## The Virial Theorem

When the potential energy is a homogeneous function of the coordinates and the motion remains bounded in space, there exists a simple relation between the time-averaged kinetic and potential energies, known as the **virial theorem**.

The kinetic energy $T$ is a quadratic (homogeneous of degree 2) function of the velocities. By Euler's theorem on homogeneous functions:
$$\sum_{a} \mathbf{v}_{a}\cdot \dfrac{\partial T}{\partial \mathbf{v}_{a}}=2T$$

Since $\partial T/\partial \mathbf{v}_{a}=\mathbf{p}_{a}$ (the momentum), we can write $2T = \sum_{a}\mathbf{p}_{a}\cdot \mathbf{v}_{a}$. Using the product rule for derivatives:
$$\dfrac{\mathrm{d}}{\mathrm{d}t}\left( \sum_{a}\mathbf{p}_{a}\cdot \mathbf{r}_{a}\right) = \sum_{a}\dot{\mathbf{p}}_{a}\cdot \mathbf{r}_{a} + \sum_{a}\mathbf{p}_{a}\cdot \mathbf{v}_{a}$$

Rearranging:
$$2T=\sum_{a}\mathbf{p}_{a}\cdot \mathbf{v}_{a}=\dfrac{\mathrm{d}}{\mathrm{d}t}\left( \sum_{a}\mathbf{p}_{a}\cdot \mathbf{r}_{a}\right) - \sum_{a}\dot{\mathbf{p}}_{a}\cdot \mathbf{r}_{a}\tag{LL10.4}$$

Now we take the time average. For any function $f(t)$, the time average is defined as:
$$\bar{f}=\lim_{ \tau \to \infty} \dfrac{1}{\tau}\int_{0}^{\tau} f(t) \, \mathrm{d}t $$

If $f(t) = \mathrm{d}F/\mathrm{d}t$ for some bounded function $F(t)$, then:
$$\bar{f}=\lim_{ \tau \to \infty} \dfrac{F(\tau)-F(0)}{\tau}=0 $$

For bounded motion with finite velocities, the quantity $\sum_{a} \mathbf{p}_{a}\cdot \mathbf{r}_{a}$ remains bounded. Therefore, the time average of the total derivative term in $\text{(LL10.4)}$ vanishes. For the remaining term, we use the equations of motion $\dot{\mathbf{p}}_{a} = -\partial U/\partial \mathbf{r}_{a}$:
$$2\bar{T}=\overline{\sum _{a}\mathbf{r}_{a}\cdot \dfrac{ \partial U }{ \partial \mathbf{r}_{a} }} \tag{LL10.5}$$

If $U$ is homogeneous of degree $k$ in the position vectors, Euler's theorem gives $\sum_{a}\mathbf{r}_{a}\cdot (\partial U/\partial \mathbf{r}_{a}) = kU$, so:
$$2\bar{T}=k\bar{U}\tag{LL10.6}$$

Since total energy is conserved, $\bar{T}+\bar{U}=E$, and we can solve for:
$$\bar{U}=\dfrac{2E}{k+2},\qquad \bar{T}=\dfrac{kE}{k+2}\tag{LL10.7}$$

**Examples:**

- **Small oscillations** ($k=2$): $\bar{T}=\bar{U}$ - the average kinetic and potential energies are equal.

- **Newtonian gravity** ($k=-1$): $2\bar{T}=-\bar{U}$ and $E=-\bar{T}$. Since $\bar{T}>0$, bounded orbits require $E<0$, which is indeed the condition for elliptical orbits.

# Exercises
## Question 1
Find the ratio of the times in the same path for particles having different masses but the same potential energy.

**Solution**:
For the same path ($\ell' = \ell$) and the same potential energy $U$, the Lagrangian differs only in the kinetic term: $T = \frac{1}{2}mv^2$. For a given path, velocity scales as $v \propto \ell/t$, so $T \propto m\ell^2/t^2$. The equation of motion balances $T$ and $U$, requiring $m\ell^2/t^2 \sim U$. Since $\ell$ and $U$ are fixed:
$$\boxed {
\dfrac{t'}{t} = \sqrt{\dfrac{m'}{m}}
 }$$

## Question 2
Find the ratio of times in the same path for particles having the same mass but potential energies differing by a constant factor.

**Solution**:
Let $U' = \gamma U$ where $\gamma$ is a constant. For the same path and mass, balancing kinetic and potential energies: $m\ell^2/t^2 \sim U$. With $U' = \gamma U$:
$$\dfrac{m\ell^2}{t'^2} \sim \gamma U \sim \gamma \dfrac{m\ell^2}{t^2}$$
Therefore:
$$\dfrac{t'}{t} = \dfrac{1}{\sqrt{\gamma}}$$
Meaning:
$$\boxed {
\dfrac{t'}{t}=\sqrt{ \dfrac{U}{U'} }
 }$$