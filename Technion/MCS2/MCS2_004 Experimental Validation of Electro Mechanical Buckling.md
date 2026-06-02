---
aliases:
  - Experimental Validation of Electromechanical Buckling
  - Electromechanical Buckling
  - EMB
---
# Experimental Validation of Electromechanical Buckling

Electromechanical buckling (EMB) is a bifurcation instability in which an elastic structure is destabilized by the combined action of axial loading and a symmetric electrostatic field. The key idea is that two different bifurcation mechanisms, mechanical buckling and electrostatic bifurcation, can be described by one critical stability curve. [[MCS2_000 00380800 Advanced Modeling in MEMS#Bibliography|(Abu-Salih & Elata, 2006)]].

![[Pasted image 20260526223156.png|bookhue|600]]^figure-emb-instability-comparison
>Instability responses: mechanical buckling of a compressed beam, pull-in of a parallel-plate actuator, and side pull-in of a comb-drive. [[MCS2_000 00380800 Advanced Modeling in MEMS#Bibliography|(Abu-Salih & Elata, 2006)]].

Mechanical buckling occurs only when the compressive axial load exceeds a critical value. Pull-in of a usual parallel-plate actuator is different: it is a limit point, so the system loses stability in one prescribed direction. Electrostatic side pull-in, however, is a bifurcation, because the structure can collapse in either of two symmetric directions.

EMB combines these ideas. A slender beam is subjected to an axial load and to two equal side voltages. The symmetric electrostatic field does not choose an initial side. Instead, it reduces the stiffness of the symmetric equilibrium until the straight configuration loses stability.

>[!notes] Why this is not ordinary pull-in
>In a one-sided parallel-plate actuator, the voltage force already points toward the fixed electrode. In the EMB structure, the two side electrodes are symmetric. The straight beam sees equal attraction on both sides, so it remains an equilibrium configuration until that equilibrium becomes unstable.

## Symmetric Electrostatic Bifurcation

A simple lumped model that captures the electrostatic part of the phenomenon is a grounded movable plate suspended by a spring between two fixed electrodes held at the same voltage $V$.

![[MCS2_004 Experimental Validation of Electro Mechanical Buckling 2026-05-26 22.47.46.excalidraw.svg]]^figure-symmetric-parallel-plate-bifurcation
>Symmetric parallel-plate actuator used as a lumped model for electrostatic bifurcation.

Using the voltage-controlled potential convention from [[MCS2_002 Electromechanical Systems with N DOFs and K Voltages#Energy, Equilibrium, and Stability|a previous lecture]], the total potential is

$$
\psi
=
\dfrac{1}{2}ky^{2}
-\dfrac{1}{2}\varepsilon_{0}AV^{2}
\left(
\dfrac{1}{g-y}
+
\dfrac{1}{g+y}
\right).
\tag{4.1}
$$

Define

$$
\tilde{y}:=\dfrac{y}{g},
\qquad
\tilde{\psi}:=\dfrac{\psi}{kg^{2}},
\qquad
\tilde{V}^{2}:=\dfrac{\varepsilon_{0}A}{kg^{3}}V^{2}.
\tag{4.2}
$$

Then

$$
\tilde{\psi}
=
\dfrac{1}{2}\tilde{y}^{2}
-
\dfrac{\tilde{V}^{2}}{1-\tilde{y}^{2}}.
\tag{4.3}
$$

The equilibrium equation is

$$
\dfrac{\partial \tilde{\psi}}{\partial \tilde{y}}
=
\tilde{y}
-
\tilde{V}^{2}
\dfrac{2\tilde{y}}{(1-\tilde{y}^{2})^{2}}
=0.
\tag{4.4}
$$

One equilibrium is always $\tilde{y}=0$. Its stiffness is

$$
K
=
\dfrac{\partial^{2}\tilde{\psi}}{\partial \tilde{y}^{2}}
=
1
-
2\tilde{V}^{2}
\dfrac{1+3\tilde{y}^{2}}{(1-\tilde{y}^{2})^{3}}.
\tag{4.5}
$$

At $\tilde{y}=0$ this gives $K=1-2\tilde{V}^{2}$, so the symmetric equilibrium becomes critical at

$$
\boxed{\tilde{V}^{2}_{cr}=\dfrac{1}{2}}.
\tag{4.6}
$$

Below this voltage the plate remains centered. At the critical voltage, it can collapse toward either side. This is a bifurcation, not a one-sided fold.

## Clamped-Guided EMB Model

The experimentally validated structure is a clamped-guided beam placed symmetrically between two fixed side electrodes. The guided end allows axial load to be prescribed externally.

![[MCS2_004 Experimental Validation of Electro Mechanical Buckling 2026-05-26 22.36.02.excalidraw.svg]]^figure-clamped-guided-emb-beam
>Clamped-guided beam subjected to axial load $p$ and a symmetric electrostatic field. One buckled configuration is shown by a dashed line. [[MCS2_000 00380800 Advanced Modeling in MEMS#Bibliography|(Abu-Salih & Elata, 2006)]].

At the onset of buckling the deflection is small, so the critical state is governed by the linear equilibrium equation

$$
E^{*}I
\dfrac{\mathrm{d}^{4}y}{\mathrm{d}x^{4}}
-
p
\dfrac{\mathrm{d}^{2}y}{\mathrm{d}x^{2}}
=
q(y).
\tag{4.7}
$$

>[!notes] Effective modulus approximation
>Strictly, the bending modulus is not always exactly $E^{*}=E/(1-\nu^{2})$. As discussed in [[MCS1_005 חומרים דיאלקטריים#כפיפה גלילית|cylindrical bending]], the transition depends on the parameter $\beta=b^{2}/(\rho h)$: for small $\beta$ the effective modulus approaches $E$, while for large $\beta$ it approaches $E^{*}$. In this lecture we keep the paper's notation and use $E^{*}$ for brevity.


Here $y(x)$ is the transverse beam deflection, $x$ is the coordinate along the beam, $p$ is the axial force applied to the guided edge, and $p>0$ denotes tension. The bending modulus is

$$
E^{*}=\dfrac{E}{1-\nu^{2}},
\qquad
I=\dfrac{bh^{3}}{12},
\tag{4.8}
$$

where $b$ is the beam width, $h$ is the beam thickness, and $b\gg h$.

The symmetric electrostatic load per unit length is approximated by local parallel-plate pressure:

$$
q(y)
=
\dfrac{1}{2}\varepsilon_{0}bV^{2}
\left[
\dfrac{1}{(g-y)^{2}}
-
\dfrac{1}{(g+y)^{2}}
\right].
\tag{4.9}
$$

This approximation treats the beam as many infinitesimal parallel-plate actuators. For the aspect ratios in the experiment, $L/g>200$, it is sufficiently accurate near the critical state.

For small $y/g$,

$$
\begin{aligned}
\dfrac{1}{(g-y)^{2}}
-
\dfrac{1}{(g+y)^{2}}
&=
\dfrac{1}{g^{2}}
\left[
\dfrac{1}{(1-y/g)^{2}}
-
\dfrac{1}{(1+y/g)^{2}}
\right] \\[1ex]
&\approx
\dfrac{1}{g^{2}}
\left[
\left(1+2\dfrac{y}{g}\right)
-
\left(1-2\dfrac{y}{g}\right)
\right] \\[1ex]
&=
\dfrac{4y}{g^{3}}.
\end{aligned}
\tag{4.10}
$$

Therefore

$$
q(y)
\approx
\dfrac{2\varepsilon_{0}bV^{2}}{g^{3}}y.
\tag{4.11}
$$

Substituting $\text{(4.11)}$ into $\text{(4.7)}$ shows the destabilizing role of voltage:

$$
E^{*}I
\dfrac{\mathrm{d}^{4}y}{\mathrm{d}x^{4}}
-
p
\dfrac{\mathrm{d}^{2}y}{\mathrm{d}x^{2}}
-
\dfrac{2\varepsilon_{0}bV^{2}}{g^{3}}y
=0.
\tag{4.12}
$$

The clamped-guided boundary conditions are

$$
\tilde{y}(0)=\tilde{y}(1)=0,
\qquad
\dfrac{\mathrm{d}\tilde{y}}{\mathrm{d}\tilde{x}}(0)
=
\dfrac{\mathrm{d}\tilde{y}}{\mathrm{d}\tilde{x}}(1)
=0.
\tag{4.13}
$$

They enforce zero deflection and zero rotation at both ends. The guided end can translate axially but cannot rotate.

>[!notes] Residual stress in the clamped-guided model
>Uniform residual stress is not included in $\text{(4.12)}$ because the guided edge can move axially and release it. Small stress gradients are also neglected because the no-rotation boundary conditions suppress initial arcing of the beam.

## Normalized Critical Equation

Define

$$
\tilde{x}:=\dfrac{x}{L},
\qquad
\tilde{y}:=\dfrac{y}{g},
\qquad
\tilde{g}:=\dfrac{g}{h},
\tag{4.14}
$$

and

$$
\tilde{p}
:=
(2\pi)^{2}\dfrac{p}{\lvert p_{Eu}\rvert},
\qquad
\tilde{V}^{2}
:=
\dfrac{24\varepsilon_{0}L^{4}}{E^{*}g^{3}h^{3}}V^{2}.
\tag{4.15}
$$

The Euler buckling load for the clamped-guided beam is

$$
p_{Eu}
=
-
\dfrac{4\pi^{2}E^{*}I}{L^{2}}.
\tag{4.16}
$$

With these definitions, the linear critical equation becomes

$$
\dfrac{\mathrm{d}^{4}\tilde{y}}{\mathrm{d}\tilde{x}^{4}}
-
\tilde{p}
\dfrac{\mathrm{d}^{2}\tilde{y}}{\mathrm{d}\tilde{x}^{2}}
-
\tilde{V}^{2}\tilde{y}
=0.
\tag{4.17}
$$

The general solution is

$$
\tilde{y}(\tilde{x})
=
{c}_{1}e^{\lambda \tilde{x}}
+
{c}_{2}e^{-\lambda \tilde{x}}
+
{c}_{3}\cos(\Lambda \tilde{x})
+
{c}_{4}\sin(\Lambda \tilde{x}),
\tag{4.18}
$$

where ${c}_{1},{c}_{2},{c}_{3},{c}_{4}$ are constants, and

$$
\begin{aligned}
\lambda
&=
\sqrt{
\dfrac{\tilde{p}+\sqrt{\tilde{p}^{2}+4\tilde{V}^{2}}}{2}
} \\[1ex]
\Lambda
&=
\sqrt{
\dfrac{-\tilde{p}+\sqrt{\tilde{p}^{2}+4\tilde{V}^{2}}}{2}
}.
\end{aligned}
\tag{4.19}
$$

Applying $\text{(4.13)}$ gives the homogeneous linear system

$$
\begin{pmatrix}
1 & 1 & 1 & 0 \\
e^{\lambda} & e^{-\lambda} & \cos(\Lambda) & \sin(\Lambda) \\
\lambda & -\lambda & 0 & \Lambda \\
\lambda e^{\lambda} & -\lambda e^{-\lambda} & -\Lambda\sin(\Lambda) & \Lambda\cos(\Lambda)
\end{pmatrix}
\begin{pmatrix}
{c}_{1} \\
{c}_{2} \\
{c}_{3} \\
{c}_{4}
\end{pmatrix}
=
\begin{pmatrix}
0 \\
0 \\
0 \\
0
\end{pmatrix}.
\tag{4.20}
$$

A nontrivial buckling mode exists only when the determinant vanishes:

$$
\sin(\Lambda)\sinh(\lambda)(\lambda^{2}-\Lambda^{2})
+
2\lambda\Lambda
\left[
1-\cos(\Lambda)\cosh(\lambda)
\right]
=0.
\tag{4.21}
$$

The first nontrivial solution $\{\lambda_{1},\Lambda_{1}\}$ determines the critical axial load and voltage:

$$
\boxed{
\tilde{V}_{cr}^{2}
=
\lambda_{1}^{2}\Lambda_{1}^{2}
},
\qquad
\boxed{
\tilde{p}_{cr}
=
\lambda_{1}^{2}-\Lambda_{1}^{2}
}.
\tag{4.22}
$$

The curve in [[#^figure-critical-emb-curve|the figure]] is generated by `MCS2_004/emb_buckling_graphs.m`, which solves $\text{(4.21)}$ by continuation in $\lambda_{1}$ and then uses $\text{(4.22)}$.

![[emb_critical_curve.svg|600|bookhue]]^figure-critical-emb-curve
>Critical EMB curve of the clamped-guided beam: normalized critical voltage as a function of normalized axial load. [[MCS2_000 00380800 Advanced Modeling in MEMS#Bibliography|(Abu-Salih & Elata, 2006)]].

To compute the curve, choose $\lambda_{1}\geq 0$, solve $\text{(4.21)}$ for $\Lambda_{1}$, and substitute the pair into $\text{(4.22)}$. When $\lambda_{1}\to 0$, the voltage vanishes and the first root is $\Lambda_{1}=2\pi$, so $\tilde{p}_{cr}=-(2\pi)^{2}$, which recovers the Euler load.

The important physical consequence is that the symmetric electric field can induce buckling even when the compressive load is smaller than the Euler load, and even when the beam is in tension. In pure mechanical buckling the critical state is one point on a load axis. In EMB, the critical states form a curve in the $(\tilde{p},\tilde{V})$ plane.

## Connection to Residual-Stress EMB

The clamped-guided critical equation is closely related to the clamped-clamped residual-stress problem. For a clamped-clamped beam with residual stress $\sigma$, the governing equation is

$$
\begin{aligned}
E^{*}I
\dfrac{\mathrm{d}^{4}y}{\mathrm{d}x^{4}}
&-
\sigma A
\dfrac{\mathrm{d}^{2}y}{\mathrm{d}x^{2}}
-
EA
\left[
\dfrac{1}{L}
\int_{0}^{L}
\dfrac{1}{2}
\left(
\dfrac{\mathrm{d}y}{\mathrm{d}x}
\right)^{2}
\,\mathrm{d}x
\right]
\dfrac{\mathrm{d}^{2}y}{\mathrm{d}x^{2}} \\[1ex]
&=
\dfrac{1}{2}\varepsilon_{0}bV^{2}
\left[
\dfrac{1}{(g-y)^{2}}
-
\dfrac{1}{(g+y)^{2}}
\right].
\end{aligned}
\tag{4.23}
$$

The terms in $\text{(4.23)}$ are:
- $E^{*}I y''''$: bending resistance;
- $-\sigma A y''$: the axial force contribution caused by residual stress;
- the integral term: nonlinear membrane stretching due to the extra centerline length created by transverse deflection; That is, the stress that keeps the beam the same length, which didn't exist for the clamped-guided case.
- the right-hand side: the same symmetric electrostatic force as in the clamped-guided EMB beam.

At the critical state the deflection is small, so the nonlinear membrane-stretching term is neglected and the electrostatic force is linearized. This gives the same mathematical structure as $\text{(4.17)}$, with residual stress replacing the externally applied axial load. This is why the clamped-guided experimental validation also supports the residual-stress measurement idea proposed in the 2005 paper. [[MCS2_000 00380800 Advanced Modeling in MEMS#Bibliography|(Elata & Abu-Salih, 2005)]].

## Post-EMB Stability

The critical curve tells us when the straight beam loses stability, but it does not tell us whether the post-buckled state is easy to observe. If the post-buckled branch is stable and has small amplitude, the critical event may be hard to detect experimentally. If the post-buckled branch is unstable, the beam collapses into contact with a side electrode, making the event clear.

The post-EMB analysis uses the total potential

$$
\begin{aligned}
\psi
=
\psi_{a}
&+
\dfrac{E^{*}I}{2}
\int_{0}^{L}
\left(
\dfrac{\mathrm{d}^{2}y}{\mathrm{d}x^{2}}
\right)^{2}
\left[
1+
\left(
\dfrac{\mathrm{d}y}{\mathrm{d}x}
\right)^{2}
\right]
\,\mathrm{d}x \\[1ex]
&+
p
\int_{0}^{L}
\dfrac{1}{2}
\left[
\left(
\dfrac{\mathrm{d}y}{\mathrm{d}x}
\right)^{2}
+
\dfrac{1}{4}
\left(
\dfrac{\mathrm{d}y}{\mathrm{d}x}
\right)^{4}
\right]
\,\mathrm{d}x \\[1ex]
&-
\dfrac{1}{2}\varepsilon_{0}bV^{2}
\int_{0}^{L}
\left(
\dfrac{1}{g-y}
+
\dfrac{1}{g+y}
\right)
\,\mathrm{d}x.
\end{aligned}
\tag{4.24}
$$

Here $\psi_{a}$ is the elastic potential associated with axial strain and the work of the axial load up to the critical state. The remaining terms represent bending, contraction work from the axial load, and electrostatic co-energy.

After normalizing and expanding the electrostatic term, the potential near the critical state can be written as

$$\tiny\begin{align}
\tilde{\psi} & =
\tilde{\psi}_{0}+
\int_{0}^{1}
\left[
\left(
\dfrac{\mathrm{d}^{2}\tilde{y}}{\mathrm{d}\tilde{x}^{2}}
\right)^{2}
\left(1+
\dfrac{g^{2}}{L^{2}}
\left(
\dfrac{\mathrm{d}\tilde{y}}{\mathrm{d}\tilde{x}}
\right)^{2}
\right)
\right]
\,\mathrm{d}\tilde{x}+ \\[1ex]
 & \qquad \tilde{p}
\int_{0}^{1}
\left[
\left(
\dfrac{\mathrm{d}\tilde{y}}{\mathrm{d}\tilde{x}}
\right)^{2}+
\dfrac{1}{4}\dfrac{g^{2}}{L^{2}}
\left(
\dfrac{\mathrm{d}\tilde{y}}{\mathrm{d}\tilde{x}}
\right)^{4}
\right]
\,\mathrm{d}\tilde{x}-
\tilde{V}^{2}
\int_{0}^{1}
\left(
\tilde{y}^{2}+
\tilde{y}^{4}
\right)
\,\mathrm{d}\tilde{x}.
\end{align}\tag{4.25}$$

Following Koiter's initial post-buckling idea, take the first buckling mode $\tilde{y}_{1}(\tilde{x})$ and write the near-critical deflection as

$$
\tilde{y}(\tilde{x})
=
{c}_{1}\tilde{y}_{1}(\tilde{x}),
\tag{4.26}
$$

where ${c}_{1}$ is the post-buckling amplitude. Substitution into $\text{(4.25)}$ gives

$$
\tilde{\psi}
=
\tilde{\psi}_{0}
+
{c}_{1}^{2}\tilde{\psi}_{2}(\tilde{p},\tilde{V})
+
{c}_{1}^{4}\tilde{\psi}_{4}\left(\tilde{p},\tilde{V},\dfrac{g}{L}\right).
\tag{4.27}
$$

The stiffness associated with ${c}_{1}$ is

$$
K
=
\dfrac{\partial^{2}\tilde{\psi}}{\partial {c}_{1}^{2}}
=
2\tilde{\psi}_{2}
+
12{c}_{1}^{2}\tilde{\psi}_{4}.
\tag{4.28}
$$

At the critical EMB state, $\tilde{\psi}_{2}=0$, so the sign of the initial post-EMB stiffness is determined by the quartic term. The critical gap separating stable and unstable post-EMB behavior is

$$
\boxed{
\dfrac{g_{cr}}{L}
=
\sqrt{
\dfrac{
\tilde{V}_{cr}^{2}
\int_{0}^{1}{{\tilde{y}_{1}}}^{4}\,\mathrm{d}\tilde{x}
}{
\int_{0}^{1}
\left(
\dfrac{\mathrm{d}^{2}\tilde{y}_{1}}{\mathrm{d}\tilde{x}^{2}}
\right)^{2}
\left(
\dfrac{\mathrm{d}\tilde{y}_{1}}{\mathrm{d}\tilde{x}}
\right)^{2}
\,\mathrm{d}\tilde{x}
+
\dfrac{\tilde{p}_{cr}}{4}
\int_{0}^{1}
\left(
\dfrac{\mathrm{d}\tilde{y}_{1}}{\mathrm{d}\tilde{x}}
\right)^{4}
\,\mathrm{d}\tilde{x}
}
}
}.
\tag{4.29}
$$


The curve in [[#^figure-critical-gap-post-emb|the figure]] is generated by the same script, `MCS2_004/emb_buckling_graphs.m`. For each critical state, the script extracts the null vector of $\text{(4.20)}$ as the buckling mode and evaluates $\text{(4.29)}$ numerically.

![[emb_critical_gap.svg|600|bookhue]]^figure-critical-gap-post-emb
>Critical gap below which the initial post-EMB response is unstable. [[MCS2_000 00380800 Advanced Modeling in MEMS#Bibliography|(Abu-Salih & Elata, 2006)]].

For a given axial load, if $g<g_{cr}$ the post-EMB response is unstable and the beam collapses to one of the side electrodes. If $g>g_{cr}$, the post-EMB response is initially stable. In the fabricated devices, $g$ is much smaller than $L$, so the response is unstable for the relevant axial loads except very close to the Euler load.

## Test Device

The experimental device was designed to apply a controlled axial load before applying the side-electrode EMB voltage.

![[Pasted image 20260529100326.png|bookhue|600]]^figure-emb-test-device-schematic
>Schematic view of a typical test structure: clamped-guided beam, guided shuttle, and electrostatic actuators for applying tension or compression. [[MCS2_000 00380800 Advanced Modeling in MEMS#Bibliography|(Abu-Salih & Elata, 2006)]].

The guided shuttle is suspended on four flexures. The shuttle is connected to the test beam and to a central electrode used to generate axial load:
- applying voltage ${V}_{T}$ to the tension electrode while grounding the compression electrode creates tension;
- applying voltage ${V}_{C}$ to the compression electrode while grounding the tension electrode creates compression.

The suspension stiffness in the axial direction is

$$
{k}_{s}
=
\dfrac{4Ebh_{s}^{3}}{L_{s}^{3}},
\tag{4.30}
$$

while the axial stiffness of the slender beam is

$$
k
=
\dfrac{Ebh}{L}.
\tag{4.31}
$$

Thus

$$
\dfrac{{k}_{s}}{k}
=
\dfrac{4Lh_{s}^{3}}{hL_{s}^{3}}.
\tag{4.32}
$$

For the example device with $L=\pu{1200 \mu m}$, $h=\pu{5 \mu m}$, $L_{s}=\pu{535 \mu m}$, and $h_{s}=\pu{15 \mu m}$, the ratio is ${k}_{s}/k\approx 0.02$. Therefore about $98\%$ of the applied axial force is transmitted to the slender beam.

![[Pasted image 20260529100444.png|500]]^figure-emb-device-microphoto
>Microphoto of a typical test device. The shown clamped-guided beam is $\pu{1200 \mu m}$ long, and the beam and side gaps are each $\pu{5 \mu m}$ wide. [[MCS2_000 00380800 Advanced Modeling in MEMS#Bibliography|(Abu-Salih & Elata, 2006)]].

![[Pasted image 20260529102659.png|300]]^figure-emb-tension-compression-actuator-before
>Close-up of the tension/compression actuators before engagement. [[MCS2_000 00380800 Advanced Modeling in MEMS#Bibliography|(Abu-Salih & Elata, 2006)]].

![[Pasted image 20260529102811.png|300]]^figure-emb-tension-compression-actuator-after
>Close-up of the tension/compression actuators after engagement. Engagement reduces the gap near the shuttle electrode to about $\pu{1 \mu m}$. [[MCS2_000 00380800 Advanced Modeling in MEMS#Bibliography|(Abu-Salih & Elata, 2006)]].

The devices were fabricated from single-crystal silicon on SOI wafers using DRIE. The side gap of the EMB beam was $g=\pu{5 \mu m}$, while the tension/compression actuator gap was reduced electrostatically to about $\pu{1 \mu m}$ using stoppers. This reduction was needed because the oxide breakdown voltage was about $\pu{110 V}$, so starting from a $\pu{5 \mu m}$ load-actuator gap would have required excessive voltage.

Test beams had lengths $L=\pu{1000 \mu m}$, $\pu{1100 \mu m}$, $\pu{1200 \mu m}$, and $\pu{1300 \mu m}$, with crystallographic orientations $\langle 100\rangle$ and $\langle 110\rangle$. The cross-section dimensions were $h=\pu{5 \mu m}$ and $b=\pu{20 \mu m}$. The elastic constants used were:
- for $\langle 100\rangle$: $E=\pu{129 GPa}$ and $\nu=0.297$;
- for $\langle 110\rangle$: $E=\pu{168 GPa}$ and $\nu=0.064$.

For results, see the paper [[MCS2_000 00380800 Advanced Modeling in MEMS#Bibliography|(Abu-Salih & Elata, 2006)]].
## Consequence for Residual-Stress Measurement

The critical EMB state of a clamped-guided beam with applied axial load is the same as the critical EMB state of a clamped-clamped beam with corresponding internal residual stress. This means the experimental validation also supports the residual-stress measurement method based on a clamped-clamped beam in a symmetric electrostatic field.

In that method, the measured critical voltage is used to infer the residual stress:
- larger tensile stress requires larger EMB voltage;
- smaller compressive stress also requires larger EMB voltage compared with the Euler point;
- both tensile and compressive residual stresses can be measured with one structure over a continuous range.

The 2005 residual-stress paper emphasizes that the structure should be designed so the post-buckling response is unstable. Then the critical event is catastrophic contact with a side electrode and is easy to observe.

## Summary

EMB is a two-parameter bifurcation controlled by axial load and voltage. The symmetric electrostatic field adds a destabilizing stiffness term but does not choose a side before instability. The critical states form a curve in $(\tilde{p},\tilde{V})$, recovering Euler buckling when $\tilde{V}=0$ and predicting buckling even under tensile axial load for sufficiently high voltage.

The experiments validated this prediction using clamped-guided silicon beams with electrostatically applied tension or compression. After correcting for fringing fields, the measured EMB voltages agreed with theory to within a few percent, supporting both the clamped-guided EMB model and its use as indirect validation of the residual-stress EMB method.
