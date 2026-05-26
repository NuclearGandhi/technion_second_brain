---
aliases:
  - Floating Electrode Actuator
  - Charge and voltage actuation
---
# Floating Electrode Actuator
In the previous notes we mostly treated voltage-controlled electrostatic actuators, where the electrical loading is prescribed directly by an external voltage source. This lecture introduces a different situation: a suspended conductor carries a fixed charge $Q$, but is also acted on by a voltage source $V$ through a nearby driving electrode.

The important point is that the suspended electrode is **floating**. It is conductive, so it has a single electric potential throughout its volume, but it is not directly wired to a voltage source. Its potential is determined by charge redistribution between the variable drive capacitance and the parasitic capacitance.

![[MCS2_003 Floating Electrode Actuator 2026-05-19 18.32.20.excalidraw.svg]]^figure-floating-electrode-actuator
>Floating electrode actuator.

%%
$$\begin{gathered}
{C}_{d}({V}_{f}-V)+{C}_{p}({V}_{f}-0)=Q \\[1ex]
{C}_{d}{V}_{f}-{C}_{d}V+{C}_{p}{V}_{f}=Q \\[1ex]
{V}_{f}({C}_{d}+{C}_{p})-{C}_{d}V=Q \\[1ex]
{V}_{f}=\dfrac{Q+{C}_{d}V}{{C}_{d}+{C}_{p}}
\end{gathered}$$
%%

The variable capacitance between the fixed *driving* electrode and the floating electrode is

$$
{C}_{d}(x)=\dfrac{{\varepsilon}_{0}A}{g-x}
\tag{3.1}
$$

where $x$ is positive toward the driving electrode. The *parasitic* capacitance ${C}_{p}$ is assumed constant.

## Charge Loading Only
First suppose that both fixed electrodes are grounded and charge $Q$ is placed on the floating conductor. The two grounded electrodes must carry charge $-Q$ in total. Since the two capacitances are connected to the same floating potential, the charge divides proportionally to capacitance:

$$
\begin{aligned}
{q}_{dQ}
&=-\dfrac{{C}_{d}}{{C}_{p}+{C}_{d}}Q \\[1ex]
{q}_{pQ}
&=-\dfrac{{C}_{p}}{{C}_{p}+{C}_{d}}Q
\end{aligned}
\tag{3.2}
$$

The two equations used to derive $\text{(3.2)}$ are:

$$
\begin{aligned}
 & {q}_{dQ}+{q}_{pQ}=-Q \\[3ex]
 & -\dfrac{{q}_{dQ}}{{C}_{d}}=-\dfrac{{q}_{pQ}}{{C}_{p}}
\end{aligned}
\tag{3.3}
$$

The first equation is charge conservation: the floating electrode carries $Q$, so the two grounded electrodes together carry $-Q$. The second equation is the floating-conductor constraint: both fixed electrodes are grounded, so the voltage of the floating conductor computed through the driving capacitor must equal the same voltage computed through the parasitic capacitor.

Solving $\text{(3.3)}$:

$$
\begin{aligned}
{q}_{dQ}
&=-\dfrac{{C}_{d}}{{C}_{p}+{C}_{d}}Q \\[1ex]
{q}_{pQ}
&=-\dfrac{{C}_{p}}{{C}_{p}+{C}_{d}}Q
\end{aligned}
\tag{3.4}
$$

The floating electrode voltage ${V}_{f}$ can be computed through either capacitor. Through the driving capacitor,

$$
{V}_{f}
=-\dfrac{{q}_{dQ}}{{C}_{d}}
=\dfrac{Q}{{C}_{p}+{C}_{d}}
\tag{3.5}
$$

and through the parasitic capacitor,

$$
{V}_{f}
=-\dfrac{{q}_{pQ}}{{C}_{p}}
=\dfrac{Q}{{C}_{p}+{C}_{d}}
\tag{3.6}
$$

This agreement is a useful sanity check: the floating conductor must have one potential.

## Charge and Voltage Loading
Now the driving electrode is held at voltage $V$, while the parasitic electrode remains grounded. The electrode charges become

$$
\begin{aligned}
{q}_{d}
&=
\dfrac{V{C}_{p}{C}_{d}}{{C}_{p}+{C}_{d}}
-\dfrac{Q{C}_{d}}{{C}_{p}+{C}_{d}} \\[1ex]
{q}_{p}
&=
-\dfrac{V{C}_{p}{C}_{d}}{{C}_{p}+{C}_{d}}
-\dfrac{Q{C}_{p}}{{C}_{p}+{C}_{d}}
\end{aligned}
\tag{3.7}
$$

The first term in each expression is the **voltage-only** contribution, i.e. the charge distribution that would appear if $Q=0$ and the source voltage $V$ were applied. In that case the two capacitors form a series path from the driving electrode at voltage $V$, through the floating conductor, to the grounded parasitic electrode. The equivalent series capacitance is

$$
{C}_{\text{eq}}
=
\dfrac{1}{1/{C}_{p}+1/{C}_{d}}
=
\dfrac{{C}_{p}{C}_{d}}{{C}_{p}+{C}_{d}}
\tag{3.8}
$$

so the source-driven charge magnitude is ${C}_{\text{eq}}V$. It appears with opposite signs on the two fixed electrodes: the driving electrode is connected to the positive terminal of the voltage source, so its voltage-induced charge is $+{C}_{\text{eq}}V$; the grounded parasitic electrode carries the opposite charge, $-{C}_{\text{eq}}V$. The remaining terms in $\text{(3.7)}$ are the charge-only contribution from the trapped floating-electrode charge $Q$.

Again, ${q}_{d}+{q}_{p}=-Q$. The voltage of the floating electrode is

$$
{V}_{f}
=
\dfrac{V{C}_{d}}{{C}_{p}+{C}_{d}}
+\dfrac{Q}{{C}_{p}+{C}_{d}}
\tag{3.9}
$$

The first term is a capacitive divider contribution from the applied voltage. The second term is the contribution from the trapped charge.

## Total Potential
The energy stored in the two capacitors is

$$
\begin{aligned}
{U}_{E}
&=
\dfrac{1}{2}\dfrac{{{q}_{p}}^{2}}{{C}_{p}}
+\dfrac{1}{2}\dfrac{{{q}_{d}}^{2}}{{C}_{d}} \\[1ex]
&=
\dfrac{1}{2}\dfrac{Q^{2}}{{C}_{p}+{C}_{d}}
+\dfrac{1}{2}\dfrac{V^{2}}{1/{C}_{p}+1/{C}_{d}}
\end{aligned}
\tag{3.10}
$$

The voltage source also contributes potential energy. When the voltage source moves charge through a prescribed potential difference, the source does work on the electrical subsystem; in the potential formulation this enters with the opposite sign:

$$
\begin{aligned}
{U}_{B}
&=-({q}_{d}-{q}_{d0})V \\[1ex]
&=
\dfrac{VQ/{C}_{p}}{1/{C}_{p}+1/{C}_{d}}
-V^{2}\dfrac{1}{1/{C}_{p}+1/{C}_{d}}
+{q}_{d0}V
\end{aligned}
\tag{3.11}
$$

Here ${q}_{d0}$ is the **initial charge of the voltage source**. Equivalently, it fixes the reference for the source work: the source only does incremental work on the additional charge ${q}_{d}-{q}_{d0}$ that passes through it while the voltage is held at $V$. The final term ${q}_{d0}V$ is independent of $x$ for a prescribed voltage history, so it shifts the potential by a constant and does not affect force or stiffness.

The mechanical potential is

$$
{U}_{M}=\dfrac{1}{2}kx^{2}
\tag{3.12}
$$

Therefore

$$
\begin{aligned}
\psi
&={U}_{M}+{U}_{E}+{U}_{B} \\[1ex]
&=
\dfrac{1}{2}kx^{2}
+\dfrac{1}{2}\dfrac{Q^{2}}{{C}_{p}+{C}_{d}}
-\dfrac{1}{2}\dfrac{V^{2}}{1/{C}_{p}+1/{C}_{d}}
+\dfrac{VQ/{C}_{p}}{1/{C}_{p}+1/{C}_{d}}
+{q}_{d0}V
\end{aligned}
\tag{3.13}
$$

>[!notes] Why the sign changes
>For an isolated charged capacitor, the electrostatic energy is $+\dfrac{1}{2}Q^{2}/C$. For a voltage-driven capacitor, the voltage source supplies or removes charge while holding $V$ fixed, so the effective potential contains the familiar term $-\dfrac{1}{2}CV^{2}$. The floating electrode actuator contains both ingredients: trapped charge $Q$ and prescribed voltage $V$.

## Normalized Potential
Define

$$
\begin{aligned}
\tilde{x}&=\dfrac{x}{g},
&
\tilde{C}_{p}&=\dfrac{{C}_{p}}{\varepsilon_{0}A/g},
&
\tilde{\psi}&=\dfrac{\psi}{kg^{2}} \\[1ex]
\tilde{V}&=
\sqrt{\dfrac{\varepsilon_{0}A}{kg^{3}}}\,V,
&
\tilde{Q}&=
\dfrac{Q}{\sqrt{kg^{3}\varepsilon_{0}A}},
&
\tilde{x}_{0}&=\dfrac{{x}_{0}}{g}
\end{aligned}
\tag{3.14}
$$

Then

$$
\tilde{C}_{d}
=
\dfrac{1}{1-\tilde{x}}
\tag{3.15}
$$

and the total potential can be written as

$$
\begin{aligned}
\tilde{\psi}
&=
\dfrac{1}{2}\tilde{x}^{2}
+\dfrac{1}{2}
\dfrac{\tilde{Q}^{2}\tilde{C}_{p}(1-\tilde{x})}{1+1/\tilde{C}_{p}-\tilde{x}}
-\dfrac{1}{2}
\dfrac{{{\tilde{V}}}^{2}}{1+1/\tilde{C}_{p}-\tilde{x}} \\[1ex]
&\qquad
+\dfrac{\tilde{Q}\tilde{V}}{1+1/\tilde{C}_{p}-\tilde{x}}
-\dfrac{\tilde{Q}\tilde{V}}{1+1/\tilde{C}_{p}-\tilde{x}_{0}}
\end{aligned}
\tag{3.16}
$$

For force and stability, all $x$-independent terms can be ignored. The derivative of $\text{(3.16)}$ reduces to a particularly simple form:

$$
\tilde{f}_{r}
=
\dfrac{\partial\tilde{\psi}}{\partial \tilde{x}}
=
\tilde{x}
-\dfrac{1}{2}
\dfrac{(\tilde{V}-\tilde{Q})^{2}}
{\left(1+1/\tilde{C}_{p}-\tilde{x}\right)^{2}}
\tag{3.17}
$$

The actuator therefore responds only to the **effective electrostatic load**

$$
\tilde{V}^{*}:=\tilde{V}-\tilde{Q}
\tag{3.18}
$$

This is the central result of the lecture. The trapped charge shifts the voltage axis.

## Static Response
At equilibrium $\tilde{f}_{r}=0$, so

$$
\tilde{x}
=
\dfrac{1}{2}
\dfrac{(\tilde{V}-\tilde{Q})^{2}}
{\left(1+1/\tilde{C}_{p}-\tilde{x}\right)^{2}}
\tag{3.19}
$$

Equivalently,

$$
\tilde{V}
=
\tilde{Q}
\pm
\sqrt{2\tilde{x}}\left(1+\dfrac{1}{\tilde{C}_{p}}-\tilde{x}\right)
\tag{3.20}
$$

The two signs correspond to two voltage directions. Because the system already carries charge, pull-in can occur under either positive or negative applied voltage.

![[floating_electrode_static_response.svg|bookhue|600]]^figure-floating-electrode-static-response
>Static response of the floating electrode actuator for an arbitrary normalized charge and parasitic capacitance. The charge shifts the standard pull-in curve upward by $\tilde{Q}$, producing positive and negative pull-in voltages.

In the plot, the green point is the initial charged state at $\tilde{V}=0$. The applied voltage can move the system toward a positive pull-in point or toward a negative pull-in point. The dashed segments are unstable equilibria.

## Stiffness and Pull-In
The normalized stiffness is

$$
\tilde{K}
=
\dfrac{\partial \tilde{f}_{r}}{\partial \tilde{x}}
=
1
-
\dfrac{(\tilde{V}-\tilde{Q})^{2}}
{\left(1+1/\tilde{C}_{p}-\tilde{x}\right)^{3}}
\tag{3.21}
$$

Substituting the equilibrium condition $\text{(3.19)}$ into $\text{(3.21)}$ gives the stiffness along the equilibrium branch:

$$
\tilde{K}_{\text{eq}}
=
1
-
\dfrac{2\tilde{x}}
{1+1/\tilde{C}_{p}-\tilde{x}}
\tag{3.22}
$$

Pull-in occurs when $\tilde{K}_{\text{eq}}=0$, hence

$$
\tilde{x}_{SPI}
=
\dfrac{1}{3}
\left(1+\dfrac{1}{\tilde{C}_{p}}\right)
\tag{3.23}
$$

The critical effective voltage is

$$
{{\tilde{V}_{SPI}^{*}}}^{2}
=
\dfrac{8}{27}
\left(1+\dfrac{1}{\tilde{C}_{p}}\right)^{3}
\tag{3.24}
$$

and therefore the two static pull-in voltages are

$$
\begin{aligned}
\tilde{V}_{SPI}^{+}
&=
\tilde{Q}
+
\tilde{V}_{SPI}^{*} \\[1ex]
\tilde{V}_{SPI}^{-}
&=
\tilde{Q}
-
\tilde{V}_{SPI}^{*}
\end{aligned}
\tag{3.25}
$$

![[floating_electrode_equilibrium_stiffness.svg|bookhue|600]]^figure-floating-electrode-equilibrium-stiffness
>Equilibrium stiffness along the response curve. Stability is lost when $\tilde{K}_{\text{eq}}=0$.

The initial charge loading is possible only if the trapped charge is not already beyond pull-in:

$$
-\tilde{V}_{SPI}^{*}
<
\tilde{Q}
<
\tilde{V}_{SPI}^{*}
\tag{3.26}
$$

This means the charge itself can destabilize the actuator, even before any external voltage is applied.

>[!info] מסקנה:
>A floating electrode actuator behaves like a voltage-driven parallel-plate actuator in the effective voltage $\tilde{V}^{*}=\tilde{V}-\tilde{Q}$. The trapped charge does not change the shape of the pull-in curve; it shifts the voltage axis and creates two possible pull-in voltages.
