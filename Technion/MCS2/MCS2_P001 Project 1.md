---
aliases:
  - Strong internal resonance in an asymmetric microbeam
  - One-to-two internal resonance
  - Asadi internal resonance
---

# Strong Internal Resonance in a Nonlinear, Asymmetric Microbeam Resonator

These notes explain the device, experiments, and analytical model of Asadi, Yeom, and Cho (2021). The central result is that a nonprismatic microbeam can be designed so that its second and third flexural modes are nearly commensurate and strongly coupled. Driving either mode then activates internal resonance (InRes or IR), transferring energy to the other mode.

The paper studies two experiments on the same device:

- **Lower-mode excitation (LME)**: the lower participating mode is driven near $\Omega\approx\omega_1$, while the higher mode responds near $2\Omega$. The paper calls this $1{:}2$ IR.
- **Higher-mode excitation (HME)**: the higher participating mode is driven near $\Omega\approx\omega_2$, while the lower mode responds near $\Omega/2$. The paper calls this $2{:}1$ IR.

Here, the reduced-model indices $1$ and $2$ refer to the lower and higher *participating* modes. Physically, these are the beam's second and third flexural modes.

>[!info] Central idea:
> Internal resonance is not merely the numerical coincidence $\omega_2\approx2\omega_1$. It is a nonlinear energy-transfer mechanism. Near this frequency ratio, quadratic coupling creates a resonant path through which the two modes exchange energy.

Useful background appears in [[MCS1_003 לינאריות קורה בכפיפה]], [[MCS1_007 רזונטורים]], and [[MCS1_008 רזונטורים לא לינאריים]].

# Conceptual foundations

## Is the beam a continuous or discrete system?

The physical beam is a **continuous system**. Its transverse displacement is a field,

$$
w=w(x,t),
\tag{P1.1}
$$

so a displacement value must be specified at every axial position $x$. In an ideal continuum, this corresponds to infinitely many degrees of freedom.

A mass-spring oscillator is different. Its configuration can be described by one number $q(t)$, so it is a discrete one-degree-of-freedom system.

>[!example] Continuous versus discrete:
> A guitar string has a displacement at every point and is therefore continuous. Replacing it by ten masses connected by springs produces a discrete ten-degree-of-freedom approximation. Increasing the number of masses improves the approximation to the string.

A continuous beam can be represented by its vibration modes:

$$
w(x,t)=\sum_{n=1}^{\infty}\phi_n(x)q_n(t),
\tag{P1.2}
$$

where $\phi_n(x)$ is a mode shape and $q_n(t)$ is its modal coordinate. The exact expansion still has infinitely many coordinates. The paper keeps only the two modes involved in IR:

$$
w(x,t)\approx \phi_1(x)q_1(t)+\phi_2(x)q_2(t).
\tag{P1.3}
$$

This **two-mode truncation** is a discrete two-degree-of-freedom reduced model of the continuous beam.

>[!notes] Answer in one sentence:
> The device is a continuous distributed-parameter beam, but the paper analyzes its dominant dynamics with a discrete two-mode approximation.

## Natural frequencies and modes

A mode is a deformation pattern that preserves its spatial shape during linear free vibration:

$$
w_n(x,t)=\phi_n(x)\cos(\omega_n t+\varphi_n).
\tag{P1.4}
$$

The pair $(\phi_n,\omega_n)$ consists of a mode shape and its natural frequency. Higher flexural modes have more nodes and generally higher frequencies.

For a uniform Euler-Bernoulli beam, the linear eigenproblem has the form

$$
\frac{\mathrm{d}^2}{\mathrm{d}x^2}
\left(
EI\frac{\mathrm{d}^2\phi_n}{\mathrm{d}x^2}
\right)
=\rho A\omega_n^2\phi_n,
\tag{P1.5}
$$

with clamped conditions

$$
\phi_n(0)=\phi_n'(0)=\phi_n(L)=\phi_n'(L)=0.
\tag{P1.6}
$$

Clamped does not mean pinned. A pinned end has zero displacement but may rotate; a clamped end has both zero displacement and zero slope.

The paper uses sine functions only as convenient trial families for comparing coupling trends. They satisfy zero displacement at the ends, but not the zero-slope conditions in $\text{(P1.6)}$. They are illustrative shapes, not exact clamped-beam eigenmodes.

They are “allowed” only for the limited question the authors ask in Figure 3: *does making a generic shape longitudinally asymmetric reduce cancellation in the coupling integral?* They are not sufficiently admissible trial functions for a quantitative clamped-beam Rayleigh-Ritz solution because an admissible Euler-Bernoulli trial function must satisfy the essential conditions $\phi=\phi'=0$ at both clamps.

For quantitative work, one should use one of the following:

1. exact clamped-beam eigenfunctions for a uniform beam;
2. a piecewise eigenvalue solution that enforces displacement, slope, moment, and shear continuity at the silicon-polymer interface;
3. finite-element eigenmodes of the actual heterogeneous geometry;
4. measured mode shapes, if sufficiently resolved.

Using the sine families affects the *numbers* in Table 1. Their coupling coefficients cannot be interpreted as calibrated coefficients of the fabricated device. Their qualitative symmetry argument may still be useful: products that cancel over a symmetric shape need not cancel after longitudinal distortion.

## Linear and nonlinear modal dynamics

In a linear structure, modal orthogonality decouples the equations:

$$
\ddot q_n+2\zeta_n\omega_n\dot q_n+\omega_n^2q_n=Q_n(t).
\tag{P1.7}
$$

If only mode 1 is forced, mode 2 does not receive energy through $\text{(P1.7)}$. Each mode behaves like an independent oscillator.

Nonlinear deformation introduces products such as $q_1q_2$ and $q_1^2$:

$$
\begin{aligned}
\ddot q_1+2\zeta_1\omega_1\dot q_1+\omega_1^2q_1
+c_{12}q_1q_2&=Q_1(t),\\[1ex]
\ddot q_2+2\zeta_2\omega_2\dot q_2+\omega_2^2q_2
+c_{21}q_1^2&=Q_2(t).
\end{aligned}
\tag{P1.8}
$$

These terms let one mode exert a force on the other.

>[!example] Meaning of nonlinear:
> In a linear spring, doubling displacement doubles the force. For $F=kx+\alpha x^2$, doubling $x$ changes the quadratic contribution by a factor of four. Superposition therefore fails.

>[!example] Can two coupled pendulums exhibit internal resonance?
> Two pendulums joined by an ideal linear spring are a useful picture of two coupled coordinates, but the linear spring-pendulum system is **not yet an internal-resonance system**. After transforming to its linear normal modes, those modes are independent. Energy can beat between the physical pendulums because each pendulum is a mixture of both normal modes, but this is linear beating rather than nonlinear energy transfer between modes.
>
> To obtain $1{:}2$ IR, one can tune the two modal frequencies so that $\omega_2\approx2\omega_1$ and add a nonlinear geometric element, for example a spring whose extension depends quadratically on the pendulum angles. In modal coordinates, the equations must contain terms analogous to $q_1q_2$ and $q_1^2$ in $\text{(P1.8)}$.
>
> - Under **lower-mode excitation**, an actuator drives the slow in-phase-like mode near $\omega_1$. Its quadratic motion contains $2\omega_1$ and excites the fast mode.
> - Under **higher-mode excitation**, the fast mode is driven near $\omega_2$. Above a threshold, the slow mode appears at approximately $\omega_2/2$.
>
> The pendulums help visualize two modes exchanging energy, but the essential test for IR is the nonlinear modal coupling, not merely the presence of two connected oscillators.

>[!example] Dimensionless two-oscillator analogy:
> Consider two otherwise linear modal oscillators with dimensionless natural frequencies $1$ and $2+\delta_{\mathrm{int}}$:
>
> $$
> \begin{aligned}
> \ddot x_1+2\xi_1\dot x_1+x_1+2\kappa x_1x_2
> &=f_1\cos(\Omega t),\\[1ex]
> \ddot x_2+2\xi_2\dot x_2+(2+\delta_{\mathrm{int}})^2x_2+\kappa x_1^2
> &=f_2\cos(\Omega t).
> \end{aligned}
> $$
>
> One can picture $x_1$ and $x_2$ as generalized coordinates attached to linear springs, while a separate nonlinear mechanism supplies the potential $V_{\mathrm{int}}=\kappa x_1^2x_2$. An ordinary single coupling spring between two physical masses does not naturally produce precisely this modal interaction; the model is a clean mechanical analogue of the *modal equations*.
>
> - **LME** sets $f_1\neq0$ and $f_2=0$. The $x_1^2$ force contains $2\Omega$, so $x_2$ grows near $2\Omega\approx\omega_2$.
> - **HME** sets $f_1=0$ and $f_2\neq0$. The product $x_1x_2$ can sustain a subharmonic $x_1$ response near $\Omega/2$ once the activated branch exists.
>
> In the amplitude-frequency diagrams below, the directly forced response first resembles a linear resonance. Inside the interaction region, a partner amplitude appears, the driven response folds or saturates, and multiple branches may coexist. The phase diagrams show the corresponding change in phase locking.
>
> The equations above are the conservative canonical analogy. The figures below use the paper-normalized averaged equations and the phenomenological opposite-relative-sign reconstruction documented in [[#^figure-p001-paper-analytical|the Figure 4 discussion]]. They illustrate normalized branch and phase behavior, but they are not direct time integrations of one conservative two-spring potential.

![[MCS2_P001/p001_quadratic_spring_lme.svg|bookhue|700]]^figure-p001-spring-lme
>Dimensionless LME amplitude and phase response of the reconstructed quadratic-coupling slow flow. Solid segments are stable and dashed segments are unstable.

>[!TODO] TODO: I thought I'm supposed to see the partner activation to happen at x2 the frequency of the LME. Are you using different normalization for them?

>[!TODO] TODO: There is no need to normalize the phase in the phase diagram. I want to see it from -90 to 90.

>[!TODO] TODO: For each of the graphs shown here showing the displacement amplitude/phase, create also graphs of the velocity amplitude/phase.

![[MCS2_P001/p001_quadratic_spring_hme.svg|bookhue|700]]^figure-p001-spring-hme
>Dimensionless HME amplitude and phase response of the reconstructed slow flow. The activated LM appears at half the drive frequency while the directly driven HM approaches a saturation branch.

## Harmonics are not yet internal resonance

Suppose the lower mode moves approximately as

$$
q_1=A\cos(\Omega t).
\tag{P1.9}
$$

Then the quadratic term contains

$$
q_1^2
=\frac{A^2}{2}\left[1+\cos(2\Omega t)\right].
\tag{P1.10}
$$

Thus, motion at $\Omega$ creates a static component and a second harmonic at $2\Omega$. A small $2\Omega$ component can exist even when no second mode is resonant.

If $\omega_2\approx2\omega_1$ and $\Omega\approx\omega_1$, the $2\Omega$ force in $\text{(P1.10)}$ lies near mode 2's natural frequency. Mode 2 then amplifies this harmonic resonantly.

The reverse path follows from

$$
\begin{aligned}
q_1q_2
&\sim \cos(\Omega t)\cos(2\Omega t+\theta)\\[1ex]
&=\frac{1}{2}
\left[
\cos(\Omega t+\theta)+\cos(3\Omega t+\theta)
\right].
\end{aligned}
\tag{P1.11}
$$

The coupling force acting on mode 1 contains a component at $\Omega$. The interaction is therefore reciprocal: lower-mode motion excites the higher mode at $2\Omega$, and higher-mode motion feeds back at $\Omega$.

The dimensionless plots in [[#^figure-p001-spring-lme|the LME figure]] and [[#^figure-p001-spring-hme|the HME figure]] display both amplitude and phase. The phase of a vanishing partner amplitude is undefined, so phase curves are shown only where that modal amplitude is nonzero.

>[!def] Definition:
> Internal resonance is a nonlinear interaction between two or more modes of the same structure when their natural frequencies are nearly commensurate and the system contains coupling terms capable of connecting those frequencies.

## Commensurability and detuning

Two frequencies are commensurate when their ratio is a ratio of small integers:

$$
m\omega_1\approx n\omega_2.
\tag{P1.12}
$$

For this paper,

$$
\omega_2\approx2\omega_1.
\tag{P1.13}
$$

Exact equality is unnecessary because damping and finite amplitudes give the interaction a finite bandwidth. It is clearer to begin with two physical frequency differences:

$$
\delta_{\mathrm{int}}:=\omega_2-2\omega_1,
\qquad
\delta_{\mathrm{ext}}:=\Omega-\omega_1
$$

for LME. The first compares one natural frequency with twice the other; the second compares the drive with the LM. They are different quantities and neither belongs to one mode alone.

The paper assumes both differences are small and writes scaled versions

$$
\delta_{\mathrm{int}}=\eta\sigma_{\mathrm{int}},
\qquad
\delta_{\mathrm{ext}}=\eta\sigma_{\mathrm{ext}}.
$$

Its notation calls these $\sigma_1$ and $\sigma_2$, respectively:

$$
\omega_2=2\omega_1+\eta\sigma_1.
\tag{P1.14}
$$

$$
\Omega=\omega_1+\eta\sigma_2.
\tag{P1.15}
$$

In the explanatory text, $\sigma_{\mathrm{int}}$ and $\sigma_{\mathrm{ext}}$ will be used when the distinction matters. The symbols $\sigma_1$ and $\sigma_2$ are retained inside reproduced paper equations. The bookkeeping parameter $\eta$ separates the small mismatch scale from the $O(1)$ natural-frequency scale; it is explained explicitly in [[#Two-mode kinematics under base excitation]].

>[!example] Two kinds of detuning:
> If the modes are at $\pu{107 kHz}$ and $\pu{215 kHz}$, the internal mismatch is their departure from $215=2\cdot107$. If the lower mode is then driven at $\pu{106.5 kHz}$, the drive-to-mode difference is external detuning.

## What energy transfer means

For mass-normalized modes, the leading linear modal energies are

$$
E_i\approx
\frac{1}{2}\dot q_i^2+\frac{1}{2}\omega_i^2q_i^2.
\tag{P1.16}
$$

When the external drive acts only on one mode but $E_j$ of the undriven mode grows, energy has crossed through the coupling terms. Damping continuously removes energy, so a steady IR response is a balance:

$$
\text{input power}
=
\text{dissipation in mode 1}
+
\text{dissipation in mode 2}.
\tag{P1.17}
$$

Energy transfer does not require both displacement amplitudes to be equal. Because energy also depends on frequency and modal normalization, a lower displacement amplitude may still represent a substantial energy share.

# The microresonator

## Geometry and materials

The device consists of a silicon microbeam connected to the substrate by a small freestanding polymer component. Its dimensions are:

- silicon beam: $L_1=\pu{500 \micro m}$, $b_1=\pu{100 \micro m}$, and $h_1=\pu{2 \micro m}$;
- polymer component: $L_2=\pu{40 \micro m}$, $b_2=\pu{12 \micro m}$, and $h_2=\pu{3 \micro m}$.

The polymer's axial stiffness is approximately $40$ times lower than that of the silicon beam. The compliant segment stretches when the structure vibrates and produces strong geometric nonlinearity.

**Nonprismatic** means that the cross-section or material properties are not uniform along the beam axis. Here, the silicon and polymer segments have different dimensions and elastic properties. Consequently, the structure and its mode shapes are not symmetric from left to right.

The polymer serves two design purposes:

1. its compliance enhances axial stretching and geometric nonlinearity;
2. its dimensions shift the mode frequencies and distort the mode shapes, enabling both near-$1{:}2$ tuning and stronger coupling.

Because the polymer is much softer axially than silicon, a larger fraction of the axial deformation localizes in that short segment. It also makes the left and right ends mechanically different, so the participating mode shapes are distorted toward one side. In the paper's overlap-integral picture, this distortion reduces cancellation between positive and negative spatial contributions. The resulting coupling coefficient can therefore be much larger than for symmetric trial shapes. This is a qualitative mechanism; the exact quadratic coefficient of the fabricated three-dimensional interface is not identified completely by the paper's simplified beam derivation.

The silicon and polymer are fabricated in successive layers rather than assembled as two macroscopic parts. The silicon beam is patterned in the $\pu{2 \micro m}$ SOI device layer. A $\pu{3 \micro m}$ film of photosensitive polyimide HD4100 is blanket-transferred onto the device-layer surface, patterned, and annealed at $350^{\circ}\pu{C}$ for three hours in nitrogen. At the junction, the patterned polyimide lies on and adheres to the silicon end region; beyond that overlap it continues as a freestanding polymer segment to the substrate-side anchor. After release of the buried oxide, it forms the compliant connection shown in [[#^figure-p001-device-fft|Figure 1]].

Why not use a uniform silicon clamped-clamped beam?

1. A uniform fixed-fixed beam does have geometric nonlinearity at large transverse amplitude, but ordinary symmetric midplane stretching mainly produces a cubic Duffing force.

The uniform beam **does** exhibit Duffing nonlinearity without polymer. The same geometric argument used in [[MCS1_003 לינאריות קורה בכפיפה#תרגיל 1]] makes this clear. For a fixed-fixed beam with transverse shape $w(x)=q\phi(x)$, its centerline extension is approximately

$$
\Delta L
\approx\frac{1}{2}\int_0^L(w')^2\,\mathrm{d}x
=\frac{q^2}{2}\int_0^L{{\phi'}}^2\,\mathrm{d}x.
$$

The resulting axial force scales as $N\sim(EA/L)\Delta L\propto q^2$. The transverse restoring force contributed by that tension contains another factor of $q$, so

$$
F_{\mathrm{stretch}}\propto q^3.
$$

This is cubic Duffing hardening. It is present precisely because both ends constrain the extension. What is difficult in a straight transversely symmetric beam is not Duffing nonlinearity, but a strong **quadratic** force proportional to $q_1q_2$ or $q_1^2$. Longitudinal nonuniformity changes the modal overlaps, although, as discussed later, the paper's simplified derivation does not fully resolve which physical symmetry-breaking feature makes the measured quadratic term nonzero.

2. A $1{:}2$ interaction needs an effective quadratic modal-force pair. Symmetry can make the relevant overlap integral zero or weak.

An overlap integral is a spatial weighted sum of products of mode shapes and their derivatives. It asks whether the deformation patterns reinforce or cancel each other over the structure. The exact expression used here is developed in [[#Conservative coupling and reciprocity]].

3. The natural-frequency ratios of a uniform clamped-clamped beam are fixed by its eigenvalues. Its first-second ratio is far from $2$, while the second-third ratio is already much closer to $2$.
4. The compliant nonuniform segment gives the designers independent control over the frequency ratio, mode-shape asymmetry, and coupling strength.

Thus, the polymer is not included merely to make the beam nonlinear. It is a geometric and material design element that makes the *right type* of nonlinear interaction strong and places the chosen modes near commensurability.

At reduced-model level, the coupling is represented by

$$
V_{\mathrm{int}}=\kappa q_1^2q_2,
\qquad
\mathcal{R}_1^{(\mathrm{cpl})}=2\kappa q_1q_2,
\qquad
\mathcal{R}_2^{(\mathrm{cpl})}=\kappa q_1^2.
$$

Here, $\mathcal{R}_i^{(\mathrm{cpl})}=\partial V_{\mathrm{int}}/\partial q_i$ are restoring terms written on the left-hand side of the equations of motion. The corresponding generalized forces on the right-hand side would carry a minus sign. The device geometry determines the dimensional coefficient $\kappa$ through modal projection. The paper's normalized counterparts are $\alpha_1$ and $\alpha_2$ in $\text{(P1.32)}$.

![[MCS2_P001/asadi_fig1_device_fft.png|bookhue|700]]^figure-p001-device-fft
>The fabricated silicon-polymer resonator and its measured spectra without and with IR. Adapted from Figure 1 of [[#Bibliography|(Asadi et al., 2021)]] under CC BY 4.0.

The labels “with IR” and “without IR” do not refer to two different devices or to a switch that removes the coupling. The authors used the same device and changed the excitation voltage:

- at low drive, the directly excited mode remained below the activation threshold, so the partner peak was only a small ordinary harmonic or noise-level response;
- at higher drive, the nonlinear coupling became strong enough to overcome damping and the partner mode resonated strongly.

Therefore, “without IR” means **the IR branch was not activated under that operating condition**, not that the structural coupling was physically turned off.

## Why use the second and third flexural modes?

The measured first three flexural frequencies are approximately

$$
f_{\mathrm{I}}\approx\pu{42 kHz},
\qquad
f_{\mathrm{II}}\approx\pu{107 kHz},
\qquad
f_{\mathrm{III}}\approx\pu{214 kHz}.
\tag{P1.18}
$$

Thus,

$$
\frac{f_{\mathrm{III}}}{f_{\mathrm{II}}}\approx2.
\tag{P1.19}
$$

The participating LM is physical mode II and the participating HM is physical mode III. In the reduced equations, they are renamed modes 1 and 2 to avoid carrying the physical mode numbers through every expression.

There are two paper-supported reasons for selecting modes II and III:

1. **Their frequency ratio is accessible.** For an ideal uniform clamped-clamped Euler-Bernoulli beam, $\omega_n\propto\beta_n^2$, with $\beta_1\approx4.730$, $\beta_2\approx7.853$, and $\beta_3\approx10.996$. Consequently,

   $$
   \frac{\omega_2}{\omega_1}\approx2.76,
   \qquad
   \frac{\omega_3}{\omega_2}\approx1.96.
   $$

   The first-second pair is not close to $1{:}2$, whereas the second-third pair needs only a modest geometric shift to reach $2$.
2. **Their coupling is strongest.** The paper's mode-shape calculation finds that the second-third pair has the largest quadratic coupling among the first three flexural modes that are readily usable in practice.

The trial-function study further finds that asymmetric shapes couple more strongly than symmetric shapes. These observations explain the authors' choice directly; it is not necessary to guess that modes II and III were selected arbitrarily.

![[MCS2_P001/asadi_fig3_trial_modes.png|bookhue|500]]^figure-p001-trial-modes
>Symmetric and asymmetric trial mode-shape families used to illustrate the geometric design trend. These are not exact clamped-beam modes. Adapted from Figure 3 of [[#Bibliography|(Asadi et al., 2021)]] under CC BY 4.0.

The two columns represent *idealized families associated with physically different kinds of structures*: the left family mimics a longitudinally symmetric prismatic structure, while the right family mimics a longitudinally asymmetric nonprismatic structure. They are not computed modes of two fabricated samples.

In the experimental actuator, both participating modes belong to the same asymmetric silicon-polymer structure. Therefore, both the physical mode II and mode III shapes are expected to be longitudinally asymmetric, but the paper does not publish measured full-field mode shapes from which their exact asymmetry could be quantified.

Here, “tuning by a stepped or tapered beam” means **design-time tuning**. Before fabrication, the designer varies segment lengths, widths, thicknesses, or material properties. Each mode stores bending and kinetic energy in different spatial regions, so a local geometry change shifts different natural frequencies by different amounts. The dimensions are iterated numerically until $\omega_3/\omega_2\approx2$, and the fabricated geometry then has that nominal ratio.

This is different from **post-fabrication tuning**. After manufacture, frequency ratios may be adjusted using temperature, electrostatic tension, or another bias, but the 2021 experiment primarily demonstrates geometric design rather than an actively swept tuning mechanism. The paper mentions active tuning as a way to compensate fabrication error in future implementations.

Yes. The measured small-amplitude frequencies were approximately $\pu{107 kHz}$ and $\pu{214 kHz}$, so the fabricated device was essentially at the intended $1{:}2$ ratio without an active tuning sweep. “Approximately” remains important because the finite IR bandwidth tolerates a small mismatch and nonlinear operation shifts the effective resonances.

## Fabrication and measurement

The resonator was fabricated from a silicon-on-insulator wafer. The silicon device layer was patterned photolithographically, a photosensitive polyimide was transferred and patterned to form the polymer structure, and the suspended components were released by etching the buried oxide.

The experiment used:

- a piezoelectric shaker for base excitation;
- a laser Doppler vibrometer (LDV) for contactless velocity measurement;
- an oscilloscope and FFT processing to identify spectral peaks;
- a vacuum pressure of approximately $\pu{3 mTorr}$ to suppress air damping.

The laser spot was placed away from the nodes of both participating modes so one measurement could detect both. Because this point was not the maximum-displacement point of either mode, the reported amplitudes are best used for relative comparisons.

A second vibrometer is not required to separate the modes because they occupy different frequency bands in the FFT. One spot with $\phi_{\mathrm{II}}(x_{\mathrm{spot}})\neq0$ and $\phi_{\mathrm{III}}(x_{\mathrm{spot}})\neq0$ measures both simultaneously. Two lasers could improve absolute modal-amplitude estimation, but would add optical alignment, calibration, synchronization, and access difficulties inside the vacuum setup. Sequentially moving one laser to two antinodes would lose simultaneity and could sample different nonlinear branches. The authors chose simultaneous relative comparison over separate antinode-calibrated measurements.

>[!TODO] TODO: So say they see a certain amplitude on the spot. How do they determine how much of it is due to the first mode and how much is due to the second mode?

# Experimental evidence

## Spectral activation of the partner mode

Under LME at $f_{\mathrm{drive}}=\pu{106.04 kHz}$:

- without activated IR, the second-harmonic amplitude was $\pu{1.34 nm}$;
- with activated IR, it increased to $\pu{36.35 nm}$;
- the directly driven LM increased from $\pu{30.17 nm}$ to $\pu{242.50 nm}$.

Under HME at $f_{\mathrm{drive}}=\pu{205.28 kHz}$:

- the subharmonic at $f_{\mathrm{drive}}/2$ increased from $\pu{1.35 nm}$ to $\pu{825.8 nm}$;
- the directly driven HM increased from $\pu{7.1 nm}$ to $\pu{99.78 nm}$.

The large undriven-mode peaks distinguish strong IR from ordinary weak harmonic generation.

Higher voltage alone does increase response, but the evidence is not merely “both numbers became larger”:

- in LME, the driven component increased by about a factor of $8$, while the partner harmonic increased by about a factor of $27$;
- in HME, the driven HM increased by about a factor of $14$, while the undriven subharmonic increased by more than a factor of $600$;
- a linear system driven at one frequency cannot generate a new component at half the drive frequency;
- the partner response appears abruptly above a threshold and only over a finite frequency interval;
- after HME activation, additional voltage mainly grows the partner while the directly driven HM saturates;
- upward and downward sweeps follow different branches.

These disproportionate, frequency-selective, thresholded, and saturating changes identify nonlinear modal transfer rather than ordinary linear gain from a stronger drive.

The quoted LME and HME frequencies come from two separate nonlinear operating points:

$$
2\cdot\pu{106.04 kHz}=\pu{212.08 kHz},
\qquad
\frac{\pu{205.28 kHz}}{2}=\pu{102.64 kHz}.
$$

They are not required to satisfy $f_{\mathrm{drive,HME}}=2f_{\mathrm{drive,LME}}$. In each experiment, the required relation is between the drive and the *partner response in that same experiment*: the HM responds at $2f_{\mathrm{drive}}$ during LME, while the LM responds at $f_{\mathrm{drive}}/2$ during HME. Damping, nonlinear frequency shifts, detuning, and sweep history move the activated response away from the small-amplitude natural frequencies $\pu{107 kHz}$ and $\pu{214 kHz}$.

The excitation is **base motion**, not a point force applied to one beam edge. A piezoelectric stack shakes the supporting chip, so the anchors move approximately together with displacement $w_b(t)$. The beam displacement relative to that moving base is $w(x,t)$, while its absolute displacement is

$$
w_{\mathrm{abs}}(x,t)=w_b(t)+w(x,t).
$$

The base motion enters the kinetic energy through $\dot w_{\mathrm{abs}}$. After modal projection, it produces the generalized inertial force

$$
Q_i(t)=-\Gamma_i\ddot w_b(t),
\qquad
\Gamma_i=\int_V\rho\phi_i\,\mathrm{d}V.
$$

Thus, the shaker acceleration acts throughout the distributed mass. A mode is excited strongly when its participation factor $\Gamma_i$ is nonzero and the drive frequency lies near that mode's resonance. This is the physical origin of the forcing term $\Lambda=\lambda w_F$ that later appears in the averaged equations.

## Frequency sweeps, the M-shaped response, and hysteresis

![[MCS2_P001/asadi_fig2_experimental_response.png|bookhue|700]]^figure-p001-experimental-response
>Measured frequency responses and force sweeps for LME and HME. Adapted from Figure 2 of [[#Bibliography|(Asadi et al., 2021)]] under CC BY 4.0.

At low forcing, the ERM follows a nearly ordinary resonance curve. Increasing the drive activates IR over a finite frequency interval and produces the characteristic M-shaped response.

>[!def] ERM and IRM:
> **ERM** means externally resonated mode, the mode driven directly by the shaker near its resonance. **IRM** means internally resonated mode, the partner mode that receives no direct near-resonant forcing but grows through nonlinear coupling. Under LME, LM is the ERM and HM is the IRM. Under HME, HM is the ERM and LM is the IRM.

The valley in the M-shaped ERM curve is associated with strong participation of the IRM. Energy supplied near the ERM is redirected into the partner, so the ERM does not simply continue along a single linear-resonance peak.

Multiple stable periodic responses may coexist at one drive frequency. An upward sweep and a downward sweep then follow different stable branches and jump at different points.

>[!def] Definition:
> Hysteresis means that the measured state depends on the path taken through parameter space. In a frequency sweep, the response at one frequency may differ according to whether that frequency was approached from above or below.

### Building the M shape from simpler responses

**Linear oscillator**: one resonance peak appears near $\omega_n$. Below resonance, displacement is approximately in phase with force; across resonance the phase rotates by approximately $\pi$; above resonance it is nearly out of phase. There is one steady amplitude at each frequency.

**Duffing oscillator**: amplitude-dependent stiffness bends that one resonance branch. Hardening bends it toward higher frequency and softening toward lower frequency. A fold can produce three mathematical responses over part of the sweep and therefore jumps and hysteresis, but the curve remains one self-nonlinear modal family.

**$1{:}2$ internally resonant pair**: the driven LM initially follows its ordinary peak. When its amplitude becomes large enough, $q_1^2$ resonantly excites the HM. The HM is an additional dissipation and energy-storage channel. Consequently:

1. the LM grows on the first side of resonance, forming the first hump;
2. phase locking makes the transfer term $\alpha_1a_1a_2\sin\theta$ effective;
3. energy diverted to the HM suppresses the LM near the center, forming the valley;
4. on the other side, detuning weakens the transfer and the LM rises again, forming the second hump;
5. after leaving the interaction band, the HM decays and the LM returns toward its uncoupled response.

From the phase perspective, energy transfer is governed by $\theta=2\beta_1-\beta_2$. The two modes do not exchange net energy efficiently for an arbitrary phase. Inside the IR region, $\theta$ locks to values that balance transferred power against HM damping. Changes in the locked phase across the interaction region alter whether coupling removes energy from or returns energy to the driven mode. The M shape is therefore the amplitude footprint of a phase-locked energy-transfer window, not simply two independent linear peaks placed side by side.

## Activation threshold

The partner mode remains small below a critical drive level. Once the directly excited response becomes large enough, the nonlinear coupling overcomes damping and the IRM jumps to a finite response.

In the experiments:

- LME activated near a drive voltage of $\pu{10 V}$ at the selected fixed frequency;
- HME showed saturation beyond a threshold near $\pu{5 V}$.

The threshold depends on detuning, damping, and coupling strength. It is not a universal material constant.

## Saturation in HME

After HME activates $2{:}1$ IR, the driven HM amplitude becomes nearly constant while the undriven LM continues to grow. Additional input power is dissipated mainly through the growing LM response.

>[!example] Mechanical power splitter:
> Before activation, increasing the input mostly increases the driven HM. After activation, the HM behaves like a clamped output channel and additional energy is routed to the LM. This is analogous to opening a second branch in a flow network.

This saturation is much stronger in HME than in LME. The experiment found an LM response roughly an order of magnitude larger than the directly driven HM response.

# From the continuous beam to the reduced equations

## Two-mode kinematics under base excitation

The paper writes the beam displacement as

$$
w(x,t)
=
\eta\left[A_1(t)\phi_1(x)+A_2(t)\phi_2(x)\right]
+w_b(t),
\tag{P1.20}
$$

where $w_b(t)$ is the imposed base motion and $\eta\ll1$ is a bookkeeping parameter used to order small terms.

This is the same modal-expansion idea used for multiple-degree-of-freedom systems in [[DVI1_006 מערכות מרובות דרגות חופש]]. In matrix vibration theory one writes

$$
\mathbf{x}(t)=[\boldsymbol{\Phi}]\mathbf{q}(t)
=\sum_n\boldsymbol{\phi}_nq_n(t).
$$

For a beam, the discrete vector $\mathbf{x}$ becomes the continuous field $w(x,t)$ and each eigenvector $\boldsymbol{\phi}_n$ becomes a mode-shape function $\phi_n(x)$. Equation $\text{(P1.20)}$ is simply the two-mode version of that familiar coordinate transformation, plus the rigid base displacement $w_b$.

The parameter $\eta$ is not a measured property of the beam. It is a formal label used to keep approximations consistent. The derivation assumes, for example, that modal displacement is small, damping is weak, detuning is small, and base forcing is weaker still.

Each statement is relative to its own natural scale after nondimensionalization, not relative to $w_b$:

- displacement is small relative to a chosen geometric scale such as beam length, thickness, or the modal normalization length;
- damping is small relative to critical damping, so $\zeta_i\ll1$;
- internal detuning is small relative to $\omega_1$, so $|\omega_2-2\omega_1|/\omega_1\ll1$;
- external detuning is small relative to the driven natural frequency;
- forcing is scaled so that its accumulated effect over many cycles competes with damping and coupling at the same approximation order.

In fact, near a high-$Q$ resonance the modal response may be much larger than the base displacement. Therefore, assuming $A_i\ll w_b$ would usually be physically backward.

One may assign

$$
q_i=O(\eta),
\qquad
\zeta_i=O(\eta),
\qquad
\omega_2-2\omega_1=O(\eta),
\qquad
w_b=O(\eta^2).
$$

Here, $O(\eta^2)$ means “smaller by one power of the chosen small scale than an $O(\eta)$ quantity.” After substitution, every contribution carries a power of $\eta$. Keeping all terms through one chosen power and discarding consistently smaller powers prevents a cubic correction from being retained while another contribution of the same size is accidentally omitted. At the end, $\eta$ is commonly set to $1$ because its purpose was bookkeeping, not calibration.

>[!example] What $\eta$ actually does:
> Suppose a dimensionless modal amplitude, damping ratio, and frequency mismatch are all numerically around $0.01$. Introduce $\eta$ and write each as $\eta$ times an $O(1)$ coefficient. A product of amplitude and damping is then marked $O(\eta^2)$; a quadratic coupling force is also marked by its corresponding power. The symbols let the algebra sort terms by relative size without repeatedly writing “about $0.01$.”
>
> This is similar to using $\epsilon$ in a Taylor expansion. It does not assert that all physical small quantities are numerically identical, only that they influence the dynamics on comparable asymptotic scales. Comparing $A_i$ directly with $w_b$ would neither organize damping and detuning nor remain valid under resonant amplification.

For LME,

$$
\begin{aligned}
A_1(t)
&=p_1(\tau)\cos(\Omega t)+s_1(\tau)\sin(\Omega t),\\[1ex]
A_2(t)
&=p_2(\tau)\cos(2\Omega t)+s_2(\tau)\sin(2\Omega t),
\end{aligned}
\qquad
\tau=\eta t.
\tag{P1.21}
$$

This form follows from the expected frequency content:

1. the drive is near the LM, so its leading response oscillates at $\Omega$;
2. squaring that response produces $2\Omega$ by $\text{(P1.10)}$;
3. because $\omega_2\approx2\omega_1$, the HM responds strongly near $2\Omega$;
4. damping, slight detuning, and energy exchange change the amplitudes and phases over many fast cycles rather than within one cycle.

Any slowly modulated sinusoid can be written either as

$$
A_i(t)=a_i(\tau)\cos\left(\Omega_i t-\beta_i(\tau)\right)
$$

or as cosine and sine quadratures,

$$
A_i(t)=p_i(\tau)\cos(\Omega_i t)+s_i(\tau)\sin(\Omega_i t).
$$

The two descriptions are equivalent, with $p_i=a_i\cos\beta_i$ and $s_i=a_i\sin\beta_i$.

Modulation is not first obtained as an exact solution of a separate equation. It is the multiple-scales **ansatz** used to solve the original coupled modal equations near resonance. For the unperturbed equation $\ddot A_i+\Omega_i^2A_i=0$, the cosine and sine coefficients are constants. Weak forcing, damping, detuning, and coupling perturb that solution, so the method allows those constants to vary on $\tau=\eta t$. Substitution into the original equations and removal of secular terms then determines their derivatives. If the assumption of slow variation were inconsistent, the resulting approximation would fail comparison with direct integration or experiment.

The labels $p$ and $s$ simply mean cosine-phase and sine-phase quadratures. They are perpendicular coordinates in a rotating plane; neither is a separate physical mode.

>[!example] How two quadratures form one envelope:
> Let $p=3$ and $s=4$. Then
>
> $$
> A(t)=3\cos(\Omega t)+4\sin(\Omega t)
> =5\cos(\Omega t-\beta),
> \qquad
> \beta=\operatorname{atan2}(4,3).
> $$
>
> The amplitude is not $p+s=7$, but
>
> $$
> a=\sqrt{p^2+s^2}=5.
> $$
>
> If $p(\tau)$ and $s(\tau)$ vary slowly, the fast signal remains between the slowly varying envelopes $\pm a(\tau)$, while $\beta(\tau)=\operatorname{atan2}(s,p)$ gives its slowly varying phase.

![[MCS2_P001/p001_quadrature_envelope.svg|bookhue|650]]^figure-p001-quadrature-envelope
>A fast carrier reconstructed from slowly varying cosine and sine quadratures. The envelope is $a(\tau)=\sqrt{p^2+s^2}$, not $p+s$.

The oscillations at $\Omega$ and $2\Omega$ are fast. The quadratures $p_i$ and $s_i$ evolve slowly because damping removes a small amount of energy per cycle, the shaker adds a small amount per cycle, detuning accumulates phase gradually, and coupling transfers a small amount between modes per cycle. Their accumulated effect becomes appreciable only after many oscillations.

If all four effects vanished, $p_i$ and $s_i$ would be constants and each mode would be a perfect sinusoid. Their derivatives describe the slowly changing envelope and phase caused by those physical effects.

>[!example] Fast and slow times:
> An amplitude-modulated tone oscillates rapidly while its loudness changes slowly. The carrier is analogous to $\cos(\Omega t)$, and the changing loudness is analogous to $p_i(\tau)$ and $s_i(\tau)$.

## Nonlinear axial strain

With no independent longitudinal displacement in the paper's simplified kinematics, the von Kármán axial strain is

$$
\epsilon_{xx}
=
-z\frac{\partial^2w}{\partial x^2}
+\frac{1}{2}
\left(
\frac{\partial w}{\partial x}
\right)^2.
\tag{P1.22}
$$

The von Kármán approximation is not restricted to disks or plates. It is a moderate-rotation strain approximation used for beams as well. Two separate modeling choices are being combined:

- **Euler-Bernoulli kinematics** states that a cross-section remains plane and normal to the deformed centerline. With axial displacement $u_0(x,t)$, this gives

  $$
  u_x(x,z,t)=u_0(x,t)-z\frac{\partial w}{\partial x}.
  $$

- **Linearized Euler-Bernoulli strain** keeps only first-order terms:

  $$
  \epsilon_{xx}^{(\mathrm{linear})}
  =\frac{\partial u_0}{\partial x}
  -z\frac{\partial^2w}{\partial x^2}.
  $$

- **von Kármán strain** retains the leading geometric correction caused by finite transverse slope:

  $$
  \epsilon_{xx}^{(\mathrm{vK})}
  =\frac{\partial u_0}{\partial x}
  -z\frac{\partial^2w}{\partial x^2}
  +\frac{1}{2}\left(\frac{\partial w}{\partial x}\right)^2.
  $$

Here, $x$ runs along the undeformed beam axis. **Transverse** means perpendicular to that axis, in the flexural displacement direction denoted by $w$. The thickness coordinate $z$ locates a material fiber above or below the neutral axis. Thus, $\partial w/\partial x$ is the local rotation caused by bending in the $x$-$w$ plane.

The last term is needed because IR is a nonlinear phenomenon. If it is removed and the material remains linear elastic, the strain energy is quadratic in the modal coordinates and modal projection produces independent linear oscillators. The beam may be geometrically simple, but its vibration amplitude must be modeled beyond infinitesimal strain to obtain geometric coupling.

The first term is the linear bending strain. The second term represents the increase in centerline length caused by transverse slope.

The origin is exactly the arc-length calculation used in [[MCS1_003 לינאריות קורה בכפיפה#תרגיל 1]]. Consider a neutral-axis element whose original length is $\mathrm{d}x$. After axial displacement $u_0(x)$ and transverse displacement $w(x)$, its coordinate differences are

$$
\mathrm{d}x^*=(1+u_0')\,\mathrm{d}x,
\qquad
\mathrm{d}w=w'\,\mathrm{d}x.
$$

Its deformed length is therefore

$$
\begin{aligned}
\mathrm{d}s
&=\sqrt{(\mathrm{d}x^*)^2+(\mathrm{d}w)^2}\\[1ex]
&=\sqrt{(1+u_0')^2+{{w'}}^2}\,\mathrm{d}x.
\end{aligned}
$$

The exact Green-Lagrange axial strain of the centerline is conveniently written from the squared stretch:

$$
\begin{aligned}
\epsilon_0
&=\frac{1}{2}
\left[
\left(\frac{\mathrm{d}s}{\mathrm{d}x}\right)^2-1
\right]\\[1ex]
&=u_0'
+\frac{1}{2}{{u_0'}}^2
+\frac{1}{2}{{w'}}^2.
\end{aligned}
$$

The von Kármán approximation neglects ${{u_0'}}^2/2$ because axial displacement gradients are small, but retains ${{w'}}^2/2$ because transverse slope can create the leading axial extension:

$$
\epsilon_0\approx u_0'+\frac{1}{2}{{w'}}^2.
$$

Adding the Euler-Bernoulli bending strain of a fiber at height $z$ gives

$$
\epsilon_{xx}
\approx
u_0'-zw''+\frac{1}{2}{{w'}}^2.
$$

The angle squared has a direct geometric meaning. For a small slope $\theta\approx w'$,

$$
\sqrt{1+\theta^2}
\approx1+\frac{\theta^2}{2}.
$$

A segment tilted upward or downward is longer than its horizontal projection by the same amount, so the first length correction must be even in $\theta$. That is why it is proportional to $\theta^2$, not $\theta$.

The kinetic energy is

$$
T
=
\frac{1}{2}
\int_V \rho\dot w^2\,\mathrm{d}V.
\tag{P1.23}
$$

Writing

$$
C=\frac{\nu\mu}{1-2\nu}+\mu,
\qquad
\mu=\frac{E}{2(1+\nu)},
\tag{P1.24}
$$

$\mu$ is the Lamé shear modulus, the same material constant often denoted by $G$:

$$
\mu=G=\frac{E}{2(1+\nu)}.
$$

The other Lamé constant is

$$
\lambda_{\mathrm{L}}=\frac{2\mu\nu}{1-2\nu}.
$$

For an isotropic three-dimensional solid, the elastic energy density is

$$
\mathcal{U}
=\frac{\lambda_{\mathrm{L}}}{2}
\left(\operatorname{tr}\boldsymbol{\epsilon}\right)^2
+\mu\,\boldsymbol{\epsilon}:\boldsymbol{\epsilon}.
$$

If the paper retains only $\epsilon_{xx}$, this becomes

$$
\mathcal{U}
=
\left(
\frac{\lambda_{\mathrm{L}}}{2}+\mu
\right)\epsilon_{xx}^2
=C\epsilon_{xx}^2.
$$

Thus, $C$ is not a new independent material property. It is the combination

$$
C=\frac{\lambda_{\mathrm{L}}}{2}+\mu
=\frac{E(1-\nu)}
{2(1+\nu)(1-2\nu)}.
$$

This is the energy-density form of generalized isotropic Hooke's law studied in [[SLD2_005 קשרי מאמץ עיבור]]. For a simple uniaxial stress assumption one may be more familiar with $\mathcal{U}=\sigma\epsilon/2=E\epsilon^2/2$; the coefficient differs because the paper starts from a three-dimensional isotropic energy expression while retaining a simplified strain field.

The paper represents the strain energy using

$$
U=\int_V C\epsilon_{xx}^2\,\mathrm{d}V.
\tag{P1.25}
$$

The averaged Lagrangian is

$$
\langle\mathcal{L}\rangle
=
\int_0^{2\pi/\Omega}(T-U)\,\mathrm{d}t,
\tag{P1.26}
$$

with terms retained through the required order in $\eta$.

## Why averaging selects the resonant coupling

Substituting $\text{(P1.20)}$ into $\text{(P1.25)}$ generates modal products such as

$$
A_1^3,\qquad A_2^3,\qquad A_1^2A_2,\qquad A_1A_2^2.
\tag{P1.27}
$$

This substitution is the energy form of **modal projection** or the Rayleigh-Ritz method:

1. $w(x,t)$ is an unknown field with infinitely many degrees of freedom.
2. The assumed expansion $\text{(P1.20)}$ expresses that field using the finite generalized coordinates $A_1(t)$ and $A_2(t)$.
3. Substituting into $T$ and $U$ and integrating over the beam removes the spatial coordinate.
4. The distributed beam energies become ordinary functions $T(A_i,\dot A_i)$ and $U(A_i)$.
5. Lagrange's equations then produce two coupled ordinary differential equations.

To display the reduction explicitly, omit base motion temporarily and write

$$
w(x,t)=\sum_{i=1}^{2}\phi_i(x)A_i(t).
$$

The velocity is $\dot w=\sum_i\phi_i\dot A_i$, so

$$
\begin{aligned}
T
&=\frac{1}{2}\int_V\rho
\left(\sum_i\phi_i\dot A_i\right)
\left(\sum_j\phi_j\dot A_j\right)
\,\mathrm{d}V\\[1ex]
&=\frac{1}{2}\sum_{i,j}M_{ij}\dot A_i\dot A_j,
\qquad
M_{ij}:=\int_V\rho\phi_i\phi_j\,\mathrm{d}V.
\end{aligned}
$$

Split the strain into a part linear in the amplitudes and a part quadratic in them:

$$
\begin{aligned}
B&:=-z\sum_i\phi_i''A_i,\\
N&:=\frac{1}{2}
\left(\sum_i\phi_i'A_i\right)^2,\\
\epsilon_{xx}&=B+N.
\end{aligned}
$$

Then

$$
U=\int_VC(B^2+2BN+N^2)\,\mathrm{d}V.
$$

The three pieces have different roles:

- $B^2$ is quadratic in $A_i$ and produces the linear stiffness matrix;
- $2BN$ is cubic in $A_i$ and produces quadratic modal forces;
- $N^2$ is quartic in $A_i$ and produces cubic Duffing-type modal forces.

After collecting coefficients, the reduced potential has the generic form

$$
U
=\frac{1}{2}\sum_{i,j}K_{ij}A_iA_j
+\frac{1}{6}\sum_{i,j,k}K^{(3)}_{ijk}A_iA_jA_k
+\frac{1}{24}\sum_{i,j,k,l}K^{(4)}_{ijkl}A_iA_jA_kA_l.
$$

Lagrange's equation for $A_r$ is

$$
\frac{\mathrm{d}}{\mathrm{d}t}
\left(\frac{\partial T}{\partial\dot A_r}\right)
-\frac{\partial T}{\partial A_r}
+\frac{\partial U}{\partial A_r}
=Q_r.
$$

Therefore,

$$
\sum_jM_{rj}\ddot A_j
+\sum_jK_{rj}A_j
+\frac{1}{2}\sum_{j,k}K^{(3)}_{rjk}A_jA_k
+\frac{1}{6}\sum_{j,k,l}K^{(4)}_{rjkl}A_jA_kA_l
=Q_r.
$$

For mass-normalized linear modes, $M_{rj}=\delta_{rj}$ and $K_{rj}=\omega_r^2\delta_{rj}$. Retaining the resonant coefficient associated with $A_1^2A_2$ then yields the quadratic force pair $A_1A_2$ and $A_1^2$ used in $\text{(P1.8)}$.

This is the same operation that produces modal mass and stiffness matrices in linear vibration:

$$
M_{ij}=\int_V\rho\phi_i\phi_j\,\mathrm{d}V,
\qquad
K_{ij}=\int_VEI\phi_i''\phi_j''\,\mathrm{d}V.
$$

It is not an energy-balance equation by itself. It is a change from a continuous coordinate $w(x,t)$ to generalized modal coordinates while preserving the kinetic and potential energies from which the equations of motion are derived.

Most oscillatory products average to zero over a fast period. Near $\omega_2\approx2\omega_1$, the product $A_1^2A_2$ contains a slowly varying phase combination and survives. It produces the force pair

$$
q_1q_2
\quad\text{and}\quad
q_1^2
\tag{P1.28}
$$

in the two modal equations.

>[!notes] Resonant-term selection:
> Averaging does not claim that the discarded terms are identically zero. It states that their rapid positive and negative contributions cancel at leading order on the slow time scale.

## Conservative coupling and reciprocity

A compact conservative interaction potential is

$$
V_{\mathrm{int}}=\kappa q_1^2q_2.
\tag{P1.29}
$$

Its modal restoring terms are

$$
\frac{\partial V_{\mathrm{int}}}{\partial q_1}
=2\kappa q_1q_2,
\qquad
\frac{\partial V_{\mathrm{int}}}{\partial q_2}
=\kappa q_1^2.
\tag{P1.30}
$$

The factor pair $2\kappa$ and $\kappa$ is required by one common potential. The two coupling coefficients may appear different after modal normalization, but they are not independent arbitrary constants.

The paper expresses its LME coupling coefficients as mode-shape integrals. With primes denoting spatial derivatives and $M_i=\int_V(\rho/2)\phi_i^2\,\mathrm{d}V$, their common interaction numerator is

$$
\mathcal{I}_{112}
=
\int_V C
\left[
2\phi_1'\phi_2'(-z\phi_1'')
+{{\phi_1'}}^2(-z\phi_2'')
\right]
\,\mathrm{d}V.
\tag{P1.31}
$$

Then

$$
\alpha_1=\frac{\mathcal{I}_{112}}{4\omega_1M_1},
\qquad
\alpha_2=\frac{\mathcal{I}_{112}}{16\omega_1M_2}.
\tag{P1.32}
$$

$\alpha_1$ and $\alpha_2$ are the normalized quadratic-coupling strengths in the slow equations:

- $\alpha_1$ measures how strongly the HM motion feeds back on the LM through the $q_1q_2$ force;
- $\alpha_2$ measures how strongly the squared LM motion drives the HM through the $q_1^2$ force.

They share the same physical interaction-energy numerator but have different modal-mass and frequency normalizations. Their numerical values and units depend on how the modes and time are normalized, so they should not be interpreted as ordinary spring constants.

Geometry changes $\phi_1$, $\phi_2$, and therefore $\mathcal{I}_{112}$. This is the mathematical basis of the paper's geometric design strategy.

The coefficient $\mathcal{I}_{112}$ is an **overlap integral**, analogous to quantities already encountered in linear vibration:

- $\int\rho\phi_i\phi_j\,\mathrm{d}V$ measures modal mass overlap;
- $\int EI\phi_i''\phi_j''\,\mathrm{d}V$ measures linear bending-stiffness overlap;
- $\mathcal{I}_{112}$ measures nonlinear geometric overlap among two copies of mode 1 and one copy of mode 2.

The local mass of a small volume is simply $\mathrm{d}m=\rho\,\mathrm{d}V$. The conventional generalized modal mass is the effective inertia associated with one chosen deformation pattern:

$$
\widetilde M_i=\int_V\phi_i^2\,\mathrm{d}m.
$$

If $q_i$ changes at rate $\dot q_i$, a point at $x$ moves at $\phi_i(x)\dot q_i$. Its kinetic energy is therefore weighted by $\phi_i^2$, and integration gives $T_i=\widetilde M_i\dot q_i^2/2$. Points near a node contribute little; points near a modal antinode contribute strongly. Modal mass changes if $\phi_i$ is rescaled, which is why a normalization convention must accompany every modal coefficient.

The paper defines $M_i=\widetilde M_i/2$ because its coefficient convention absorbs the usual kinetic-energy factor $1/2$ into $M_i$. This explains the $\rho/2$ in the definition preceding $\text{(P1.31)}$; it is a notation choice, not half of the physical beam mass disappearing.

“Overlap” means that the same material locations participate in several deformation patterns. A simple inner product $\int\phi_i\phi_j\,\mathrm{d}m$ is positive where two modes have the same sign and negative where they have opposite signs. Cancellation gives linear orthogonality. A nonlinear overlap contains more factors and derivatives, so ordinary orthogonality no longer guarantees cancellation.

“Two copies of mode 1” is shorthand for the product $\phi_1\phi_1\phi_2$ or its derivative-weighted counterpart. It appears because the associated potential term is $q_1^2q_2$: mode 1 enters twice algebraically and mode 2 once. There are not two physical replicas of mode 1.

The coefficients are therefore not arbitrary floating numbers. Each is a compressed spatial statement: *where is the mass, where does each mode bend and stretch, and do their signed contributions reinforce or cancel?*

The derivatives also have familiar meanings:

- $\phi_i'$ is the modal slope;
- $\phi_i''$ is the modal curvature;
- $-z\phi_i''$ is the bending strain associated with mode $i$.

The two terms in the integrand arise when the bending part and slope-squared part of $\epsilon_{xx}^2$ are multiplied and the coefficient of $A_1^2A_2$ is collected. Regions in which the product has the same sign add constructively; regions with opposite signs cancel. Asymmetric mode shapes reduce cancellation, making $|\mathcal{I}_{112}|$ larger.

Finally, division by modal mass and frequency converts the interaction-energy coefficient into the normalized slow-flow coefficients $\alpha_1$ and $\alpha_2$. Therefore, $\text{(P1.31)}$ and $\text{(P1.32)}$ are not new physical laws. They are the nonlinear counterpart of calculating a generalized force or stiffness by projecting a distributed quantity onto mode shapes.

## Important symmetry caveat

Equation $\text{(P1.22)}$ contains a quadratic strain term, but this alone does not guarantee a nonzero cubic potential or quadratic modal force. For a straight, transversely symmetric beam measured about its true neutral axis,

$$
\int_A z\,\mathrm{d}A=0.
\tag{P1.33}
$$

The cross-term between $-zw''$ and $(w')^2/2$ then vanishes after integration through the cross-section. Ordinary fixed-fixed midplane stretching instead gives a quartic potential and cubic Duffing forces.

The paper states that $z$ is measured from the neutral plane but prints thickness integrals from $0$ to $h$. Taken literally, these two conventions are inconsistent. Longitudinally asymmetric mode shapes do not by themselves break the transverse symmetry $w\mapsto-w$.

>[!warning] Interpretation of the paper's mechanism:
> The experiment clearly demonstrates strong quadratic modal coupling, and the heterogeneous compliant attachment can plausibly provide symmetry breaking not captured by the simplified beam expression. However, the printed derivation does not completely establish which physical feature makes $\mathcal{I}_{112}$ nonzero. Initial curvature, an offset elastic centroid, asymmetric boundary compliance, residual stress, or another three-dimensional effect may contribute.

Under the following printed assumptions, $\mathcal{I}_{112}$ is zero if they are interpreted literally and simultaneously:

1. $z$ is measured from the true neutral plane;
2. the cross-section is transversely symmetric;
3. the material coefficient is independent of $z$ within each section;
4. the simplified strain field is the complete mechanism.

Every term in $\mathcal{I}_{112}$ is then proportional to $z$ times functions independent of $z$, and

$$
\int_A z\,\mathrm{d}A=0
$$

makes the cross-sectional contribution vanish. The paper instead integrates $z$ from $0$ to $h$, which produces a nonzero value but is inconsistent with calling $z=0$ the neutral plane. The measured IR shows that the real device has an effective quadratic interaction; the unresolved point is which omitted interface, curvature, centroid, prestress, or three-dimensional effect supplies it.

# Lower-mode excitation: $1{:}2$ internal resonance

## Cartesian slow flow

Before reading the four equations, consider one weakly damped and slightly detuned oscillator written in rotating coordinates,

$$
q(t)=p(\tau)\cos(\Omega t)+s(\tau)\sin(\Omega t).
$$

After averaging, its envelope equations have the schematic form

$$
p'=-\zeta p-\sigma s,
\qquad
s'=-\zeta s+\sigma p-\Lambda.
$$

The damping terms shrink both quadratures, detuning rotates the pair $(p,s)$ slowly, and forcing offsets one quadrature. A second mode adds another pair $(p_2,s_2)$; nonlinear interaction adds products that exchange energy between the pairs.

Using the corrected quadrature notation from $\text{(P1.21)}$, the complete averaged LME equations are

$$
\begin{aligned}
p_1'
&=-\zeta_1p_1-\sigma_2s_1-\alpha_1(p_1s_2-p_2s_1),\\
s_1'
&=-\zeta_1s_1+\sigma_2p_1+\alpha_1(p_1p_2+s_1s_2)-\Lambda,\\
p_2'
&=-\zeta_2p_2-\Delta s_2+2\alpha_2p_1s_1,\\
s_2'
&=-\zeta_2s_2+\Delta p_2-\alpha_2(p_1^2-s_1^2),
\end{aligned}
\tag{P1.34}
$$

What $\text{(P1.34)}$ means:

- $(p_1,s_1)$ are the slowly changing cosine and sine components of the LM;
- $(p_2,s_2)$ are those of the HM;
- the prime means differentiation with respect to slow time $\tau$, not ordinary fast time;
- $-\zeta_i p_i$ and $-\zeta_i s_i$ represent damping;
- the $\sigma_2$ and $\Delta$ terms represent gradual phase drift due to detuning;
- the terms multiplied by $\alpha_1$ and $\alpha_2$ transfer amplitude and phase between the modes;
- $-\Lambda$ appears only in the LM equation because only the LM is driven directly in LME.

Thus, these are not four new physical displacements. They are a rotating-coordinate description of how two modal amplitudes and phases evolve after the rapid carrier oscillations have been averaged out.

where

$$
\Delta
=
\frac{\omega_2}{\omega_1}
\left(
\sigma_2-\frac{\sigma_1}{2}
\right),
\qquad
\Lambda=\lambda w_F.
\tag{P1.35}
$$

The Cartesian form remains regular if one modal amplitude vanishes, which makes it preferable for numerical continuation and stability calculations.

## Amplitude and phase equations

Define

$$
p_i=a_i\cos\beta_i,
\qquad
s_i=a_i\sin\beta_i,
\tag{P1.36}
$$

and the internal phase

$$
\theta=2\beta_1-\beta_2.
\tag{P1.37}
$$

The polar slow flow is

$$
\begin{aligned}
a_1'
&=-\zeta_1a_1+\alpha_1a_1a_2\sin\theta-\Lambda\sin\beta_1,\\
a_1\beta_1'
&=\sigma_2a_1+\alpha_1a_1a_2\cos\theta-\Lambda\cos\beta_1,\\
a_2'
&=-\zeta_2a_2+\alpha_2a_1^2\sin\theta,\\
a_2\beta_2'
&=\Delta a_2-\alpha_2a_1^2\cos\theta.
\end{aligned}
\tag{P1.38}
$$

The IRM equation contains no direct forcing term. Its gain comes entirely from $\alpha_2a_1^2$. The relative phase $\theta$ determines how much energy crosses between the modes.

>[!warning] Printed typo:
> Equation (9) in the paper repeats a cosine for both first-mode quadratures. The consistent transformation is $\text{(P1.36)}$, with one cosine and one sine.

## Steady amplitudes and multiple solutions

At steady state, the last two equations in $\text{(P1.38)}$ give

$$
\left(\zeta_2^2+\Delta^2\right)a_2^2
=
\alpha_2^2a_1^4.
\tag{P1.39}
$$

“Steady state” refers to the **envelope**, not to a motionless beam. The beam continues oscillating at $\Omega$ and $2\Omega$, but its amplitudes and phase differences stop changing:

$$
a_1'=a_2'=\beta_1'=\beta_2'=0.
$$

Setting the last two equations of $\text{(P1.38)}$ to zero gives

$$
\zeta_2a_2=\alpha_2a_1^2\sin\theta,
\qquad
\Delta a_2=\alpha_2a_1^2\cos\theta.
$$

Squaring these equations and adding them removes $\theta$ because $\sin^2\theta+\cos^2\theta=1$, directly producing $\text{(P1.39)}$. Physically, the first equality balances HM damping against transferred energy, while the second fixes the phase relation required by detuning.

LM damping is present in the first two equations of $\text{(P1.38)}$ through $\zeta_1$. It does not appear in $\text{(P1.39)}$ because that relation was derived using only the last two equations, which describe the HM amplitude and phase. To determine $a_1$ itself, the first two steady equations must also be satisfied; after their phases are eliminated, $\zeta_1$ appears explicitly in the cubic equation $\text{(P1.41)}$.

Thus,

$$
a_2
=
\frac{|\alpha_2|a_1^2}
{\sqrt{\zeta_2^2+\Delta^2}}.
\tag{P1.40}
$$

The internally excited amplitude scales quadratically with $a_1$ before other nonlinear effects modify the branch.

Eliminating the phases and writing $x=a_1^2$ gives

$$
\frac{\alpha_1^2\alpha_2^2}{D_2}x^3
+
\frac{2\alpha_1\alpha_2(-\zeta_1\zeta_2+\sigma_2\Delta)}{D_2}x^2
+
(\zeta_1^2+\sigma_2^2)x
-\Lambda^2
=0,
\tag{P1.41}
$$

where

$$
D_2=\zeta_2^2+\Delta^2.
\tag{P1.42}
$$

The elimination leading to $\text{(P1.41)}$ proceeds as follows. Define

$$
K=\frac{\alpha_1\alpha_2}{D_2},
\qquad
x=a_1^2.
$$

The HM equations give

$$
a_2\sin\theta=\frac{\alpha_2\zeta_2}{D_2}x,
\qquad
a_2\cos\theta=\frac{\alpha_2\Delta}{D_2}x.
$$

Substitute these two expressions into the first two steady equations of $\text{(P1.38)}$:

$$
\begin{aligned}
\Lambda\sin\beta_1
&=a_1(-\zeta_1+K\zeta_2x),\\
\Lambda\cos\beta_1
&=a_1(\sigma_2+K\Delta x).
\end{aligned}
$$

Squaring and adding eliminates $\beta_1$:

$$
\Lambda^2
=x\left[
(-\zeta_1+K\zeta_2x)^2
+(\sigma_2+K\Delta x)^2
\right].
$$

Expanding this expression gives $\text{(P1.41)}$. This is where the HM steady relation is substituted into the LM equations.

A cubic can have one or three positive roots. Coexisting stable roots explain hysteresis and jumps.

![[MCS2_P001/p001_asadi_1to2_detuning_response.svg|bookhue|600]]^figure-p001-asadi-1to2-response
>Reconstructed LME steady amplitudes versus external detuning. Solid curves are stable and dashed curves are unstable. The near-vertical pieces are branch folds, not plotting glitches. [[#Bibliography|(Asadi et al., 2021)]].

![[MCS2_P001/p001_asadi_1to2_force_activation.svg|bookhue|600]]^figure-p001-asadi-1to2-activation
>Activation and multistability of the internally resonated HM as forcing increases. The lower stable branch terminates at a fold, causing a jump to the upper branch during an upward sweep. [[#Bibliography|(Asadi et al., 2021)]].

![[MCS2_P001/p001_asadi_1to2_energy_fraction.svg|bookhue|600]]^figure-p001-asadi-1to2-energy
>Leading-order fraction of normalized harmonic modal energy in the internally resonated HM. [[#Bibliography|(Asadi et al., 2021)]].

The reconstructed figures now break numerical connections when a sorted root disappears, so a branch-switching jump is not drawn as though it were a family of equilibria. Solid curves denote stable equilibria only; dashed curves denote unstable equilibria. An actual sweep jump is a transient trajectory between branches and should be shown, if desired, by a separate arrow rather than by a solid equilibrium line.

# Higher-mode excitation: $2{:}1$ internal resonance

## Subharmonic response

For HME,

$$
\Omega=\omega_2+\eta\sigma_2,
\tag{P1.43}
$$

and the modal approximation becomes

$$
\begin{aligned}
A_1(t)
&=p_1(\tau)\cos\left(\frac{\Omega t}{2}\right)
+s_1(\tau)\sin\left(\frac{\Omega t}{2}\right),\\
A_2(t)
&=p_2(\tau)\cos(\Omega t)+s_2(\tau)\sin(\Omega t).
\end{aligned}
\tag{P1.44}
$$

The directly forced HM oscillates at $\Omega$. Quadratic coupling creates a parametric-like path that activates the LM at $\Omega/2$.

The unactivated solution has $a_1=0$ and a linear HM response. The activated branch has $a_1>0$.

On the activated branch, the LM equilibrium fixes the coupling phase:

$$
\sin\theta
=\frac{\zeta_1}{\bar{\alpha}_1a_2},
\qquad
\cos\theta
=-\frac{\delta_1}{\bar{\alpha}_1a_2}.
$$

The sign of $\bar{\alpha}_1$ must be retained in both expressions. Omitting it changes $\theta$ by $\pi$ when the reconstructed coefficient is negative, producing points that satisfy the amplitude polynomial but are not equilibria of the Cartesian slow flow. The two values $\beta_1$ and $\beta_1+\pi$ are equivalent period-doubled phase copies of the subharmonic response.

## Why the driven mode saturates

Define

$$
\delta_1
=
\frac{\omega_1}{\omega_2}(\sigma_1+\sigma_2).
\tag{P1.45}
$$

On the activated branch, the supplementary analysis gives

$$
a_2^2
=
\frac{\zeta_1^2+\delta_1^2}
{\bar{\alpha}_1^2}.
\tag{P1.46}
$$

The driven HM amplitude $a_2$ in $\text{(P1.46)}$ does not contain the forcing amplitude. Its value is fixed by LM damping, detuning, and coupling. Increasing forcing therefore increases the activated LM amplitude rather than $a_2$.

This is the mathematical origin of saturation:

$$
\boxed{
\text{after activation, extra input energy is redirected from the driven HM to the LM}
}.
\tag{P1.47}
$$

The HME scaling used by the paper satisfies

$$
\bar{\alpha}_1=2\alpha_1,
\qquad
\bar{\alpha}_2=2\alpha_2,
\qquad
\bar{\lambda}=2\lambda.
\tag{P1.48}
$$

![[MCS2_P001/p001_asadi_2to1_detuning_response.svg|bookhue|600]]^figure-p001-asadi-2to1-response
>Reconstructed HME response, including the unactivated linear HM branch and activated IR branches. [[#Bibliography|(Asadi et al., 2021)]].

![[MCS2_P001/p001_asadi_2to1_force_saturation.svg|bookhue|600]]^figure-p001-asadi-2to1-saturation
>Saturation of the directly driven HM after activation of the LM. [[#Bibliography|(Asadi et al., 2021)]].

![[MCS2_P001/p001_asadi_2to1_energy_fraction.svg|bookhue|600]]^figure-p001-asadi-2to1-energy
>Leading-order fraction of normalized harmonic modal energy in the internally resonated LM. [[#Bibliography|(Asadi et al., 2021)]].

The HME detuning plot now uses the paper's full range $-0.15\leq\sigma_2\leq0.15$ rather than a narrow asymmetric crop. Large discontinuous connections created by reindexing roots are removed before plotting. The remaining folds, intersections, and coexisting branches are properties of the algebraic steady solutions. They should be read together with the stability style and not as one continuous experimental sweep.

>[!warning] Supplementary sign issue:
> The paper reports coupling magnitudes in Figure 4 but its printed Cartesian, polar, and energy expressions do not define one fully consistent sign convention. Same-sign coefficients follow from the common interaction-energy numerator in Eq. (8), but they do not reproduce the published M-shaped Figure 4 topology. The reconstructed plots therefore use the reported magnitudes with the opposite relative sign that recovers the published branch topology. This is a transparent reproduction choice, not a claim that the sign discrepancy has been resolved physically.

>[!notes] How to read the reconstructed branches:
> The curves are sets of steady solutions, not time histories and not the path followed automatically by one frequency sweep. A vertical-looking segment is the neighborhood of a saddle-node fold where two solutions merge. Solid and dashed segments meet at stability changes. During an experiment, the system follows an accessible stable segment and jumps when that segment ends. These folds looked like graphical glitches in the previous presentation, but they are part of the nonlinear response; the genuinely misleading issue was the former same-sign reconstruction, which lacked the published activation topology.

# Stability, bifurcations, and quasiperiodicity

The **slow flow** is the autonomous system of differential equations governing the slowly changing quadratures or amplitudes and phases after the fast factors $\cos(\Omega t)$ and $\sin(\Omega t)$ have been removed by averaging. It is called a flow because it assigns a velocity $\mathbf{g}(\mathbf{y})$ to every point in the envelope state space.

A fixed point of the slow flow,

$$
\mathbf{g}(\mathbf{y}^*)=\mathbf{0},
\qquad
\mathbf{y}=(p_1,s_1,p_2,s_2)^\mathsf{T},
\tag{P1.49}
$$

corresponds to a periodic response of the original fast system. A small perturbation obeys

$$
\delta\mathbf{y}'
=
\left.
\frac{\partial\mathbf{g}}{\partial\mathbf{y}}
\right|_{\mathbf{y}^*}
\delta\mathbf{y}.
\tag{P1.50}
$$

The steady response is asymptotically stable if every eigenvalue of the Jacobian has negative real part.

**Asymptotically stable** means two things:

1. a sufficiently small perturbation remains small;
2. the perturbation decays to zero as $\tau\to\infty$, so the system returns to the same steady envelope and phase.

“Stable” alone can permit a disturbance that remains nearby without decaying. “Asymptotically stable” is stronger. Negative real parts of all Jacobian eigenvalues give exponentially decaying perturbations in the linearized slow flow.

When a stable branch ends, a sweep jumps to another attractor. In regions where the steady slow-flow point is unstable, the modal envelopes may oscillate rather than settle. In the full displacement this appears as quasiperiodic amplitude modulation, which the paper reports near the valley of the M-shaped curve.

# Design-parameter trends

## Forcing level

Increasing forcing:

- raises the modal amplitudes;
- expands the frequency interval over which IR is active;
- may create or enlarge multistable and hysteretic intervals.

The reason is that quadratic coupling scales with products of modal amplitudes. At low amplitude it is too weak to compete with damping.

## Internal frequency mismatch

At exact commensurability, $\sigma_1=0$, the ideal analytical response is a symmetric M shape. Nonzero mismatch tilts and shifts the response.

The paper finds:

- large negative and positive mismatch can produce hardening-like or softening-like line shapes;
- the tilt direction reverses between LME and HME;
- HME energy transfer is more sensitive to internal mismatch;
- LME is more robust to mismatch.

For this 2021 system, exact commensurability gives the lowest activation threshold and largest IRM energy fraction in the reported parameter study.

## Coupling strength

Larger $|\alpha_i|$ generally:

- lowers the activation threshold;
- widens the IR bandwidth;
- increases the energy fraction transferred to the IRM.

The coupling bandwidth changes more strongly than the peak IRM amplitude in parts of the parameter study.

## Why asymmetry is useful

The paper compares illustrative trial modes

$$
\phi_n^{(\mathrm{sym})}(x)
=
\sin\left(\frac{n\pi x}{L}\right)
\tag{P1.51}
$$

and

$$
\phi_n^{(\mathrm{asym})}(x)
=
\sin\left(\frac{n\pi x^2}{L^2}\right).
\tag{P1.52}
$$

Using the paper's normalization, the reported coupling magnitudes for the first-second, first-third, and second-third pairs are:

- symmetric shapes: $0$, $2.23$, and $3.19$ for $|\alpha_1|$;
- asymmetric shapes: $5.65$, $10.95$, and $18.84$ for $|\alpha_1|$;
- symmetric shapes: $0$, $0.56$, and $0.80$ for $|\alpha_2|$;
- asymmetric shapes: $1.29$, $2.42$, and $4.54$ for $|\alpha_2|$.

These values support the qualitative design choice, but they are calculated from trial functions and normalized parameters, not from measured device mode shapes.

# What the model explains

The reduced model explains:

1. why a second harmonic or subharmonic becomes large only after a threshold;
2. why the driven-mode response develops an M shape;
3. why multiple stable states produce sweep-direction hysteresis;
4. why HME can clamp the directly driven HM amplitude;
5. why stronger coupling broadens the IR region and lowers its threshold;
6. why internal mismatch changes response topology and energy transfer;
7. why modifying mode shapes is a practical design lever.

The model does not reproduce:

- exact device mode shapes or residual stress;
- absolute calibration from shaker voltage to generalized modal force;
- absolute modal energy from a single off-antinode LDV measurement;
- fabrication variability;
- all higher modes, higher harmonics, and large-amplitude nonlinear terms;
- the complete three-dimensional origin of the measured quadratic coupling.

# Reproducible calculations

The project scripts are stored in [[MCS2_P001]].

- `quadrature_envelope_demo.m` illustrates how two slow quadratures reconstruct one amplitude- and phase-modulated carrier.
- `asadi_1to2_slowflow.m` solves the corrected LME steady states, classifies slow-flow stability, and generates the detuning, activation, energy-fraction, and dimensionless amplitude-phase figures.
- `asadi_2to1_slowflow.m` solves the HME unactivated and activated branches and generates the detuning, saturation, energy-fraction, and dimensionless amplitude-phase figures.
- `verify_asadi_derivations_symbolic.m` checks the conservative force pair, polar transformation, and LME steady-amplitude polynomial.
- `generate_asadi_figures.m` runs the complete Asadi-only verification and figure suite.

Run:

```matlab
run('content/Technion/MCS2/MCS2_P001/generate_asadi_figures.m')
```

The numerical plots are educational reconstructions of the published reduced equations. They are not fitted reproductions of the raw experimental data.

# Reading the paper's main figures

## Figure 1

The SEM image establishes the heterogeneous nonprismatic structure. The spectra compare weak and strong excitation. IR is identified by the dramatic amplification of the partner-mode harmonic or subharmonic, not merely by the presence of a small harmonic.

## Figure 2

Frequency sweeps show M-shaped responses, branch jumps, and hysteresis. Fixed-frequency force sweeps reveal the activation threshold. The HME force sweep provides the clearest experimental evidence of saturation.

## Figure 3 and Table 1

The trial shapes isolate the role of longitudinal asymmetry. Table 1 predicts stronger coupling for asymmetric modes and identifies the second-third pair as the strongest low-order choice.

## Figure 4

The averaged equations reproduce the main experimental topology: stable and unstable branches, activation, hysteresis, and HME saturation. Agreement is primarily qualitative because the paper uses normalized model parameters.

![[MCS2_P001/asadi_fig4_analytical_response.png|bookhue|700]]^figure-p001-paper-analytical
>Published analytical responses for LME and HME, including stability and saturation. Adapted from Figure 4 of [[#Bibliography|(Asadi et al., 2021)]] under CC BY 4.0.

## Figures 5 and 6

The three-dimensional parameter sweeps show how forcing, mismatch, and coupling alter LME and HME. Their main purpose is not precise curve reading but identifying response-topology trends and practical tuning knobs.

## Figure 7

The energy plots summarize design quality. Exact commensurability activates IR sooner and transfers a larger energy fraction. HME offers stronger transfer but is more sensitive to mismatch.

# Final conclusions

>[!info] Conclusions:
> 1. The microbeam is a continuous system; its two-mode equations are a finite-dimensional reduced model.
> 2. Near $\omega_2\approx2\omega_1$, quadratic terms $q_1^2$ and $q_1q_2$ create a reciprocal resonant path between modes.
> 3. The silicon-polymer geometry tunes the second and third flexural modes to approximately $\pu{107 kHz}$ and $\pu{214 kHz}$ and strongly distorts their mode shapes.
> 4. IR has an activation threshold because coupling must overcome damping and detuning.
> 5. LME creates a strong $2\Omega$ partner response and an M-shaped frequency curve.
> 6. HME creates an $\Omega/2$ partner response and can saturate the directly driven mode.
> 7. Asymmetry, low mismatch, and strong modal coupling widen the useful IR range and lower its threshold.
> 8. The experiments convincingly establish strong quadratic modal interaction, although the simplified printed beam derivation leaves the exact symmetry-breaking origin of the quadratic coefficient partly unresolved.

# Bibliography

- Asadi, K., Yeom, J., & Cho, H. (2021). Strong internal resonance in a nonlinear, asymmetric microbeam resonator. *Microsystems & Nanoengineering*, *7*, 9. https://doi.org/10.1038/s41378-020-00230-1
- Asadi, K., Li, J., Peshin, S., Yeom, J., & Cho, H. (2017). Mechanism of geometric nonlinearity in a nonprismatic and heterogeneous microbeam resonator. *Physical Review B*, *96*, 115306.
- Nayfeh, A. H., & Mook, D. T. (1995). *Nonlinear Oscillations*. Wiley.
- Nayfeh, A. H. (2000). *Nonlinear Interactions: Analytical, Computational, and Experimental Methods*. Wiley.
