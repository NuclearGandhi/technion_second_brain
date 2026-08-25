---
aliases:
  - Interactive Walkthrough Summary
  - Strong internal resonance summary
title: Strong Internal Resonance in a Nonlinear, Asymmetric Microbeam Resonator
---
Asadi, Yeom & Cho (2021), *Microsystems & Nanoengineering* 7, 9 - summary.

A silicon microbeam is built so its third bending mode sits at almost exactly twice its second ($f_{2}\approx\pu{107 kHz}$, $f_{3}\approx\pu{214 kHz}$). A clamped beam stretches as it bends, so its restoring force contains a term in the square of the displacement, and squaring a tone at $\Omega$ produces a tone at $2\Omega$. That harmonic lands on the partner mode's resonance, the modes lock phase, and the driven peak develops a hole - the M shape - because energy leaves through a mode that is not driven.

| ![[Pasted image 20260801213133.png\|300]]^figure-p002-device                                                             | ![[Pasted image 20260801213218.png\|bookhue\|300]]^figure-p002-experimental                                    |
| ------------------------------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------------------------- |
| The resonator: a silicon beam anchored through a short, compliant polymer link. Asadi et al. (2021), Fig. 1a, CC BY 4.0. | Measured response: the driven mode (red) shows the M shape while the partner (blue) fills the valley. Fig. 2b. |

## The model

Two modes of the von Kármán strain energy give a single cubic coupling term $\Gamma_{112}A_1^{2}A_2$, so that

$$
\ddot{q}_{1}+2\zeta_{1}\omega_{1}\dot{q}_{1}+\omega_{1}^{2}q_{1}+g_{1}q_{1}q_{2}=F\cos\Omega t,
\qquad
\ddot{q}_{2}+2\zeta_{2}\omega_{2}\dot{q}_{2}+\omega_{2}^{2}q_{2}+g_{2}q_{1}^{2}=0.
\tag{P2.1}
$$

Only two of six candidate nonlinear forces survive averaging, and both come from that one potential. Eliminating the partner leaves an ordinary resonance, $a_{1}=\Lambda/\sqrt{\zeta_{\mathrm{eff}}^{2}+\sigma_{\mathrm{eff}}^{2}}$, in which it acts as extra damping plus extra stiffness.

## What the analysis shows

- Near the valley ($0.0030\lesssim\sigma_{2}\lesssim0.0059$) there is no steady amplitude at all; the envelopes orbit indefinitely.
- Driving the high mode gives a subharmonic partner at $\Omega/2$ and a saturating driven amplitude, of bandwidth $2\lvert\bar{\alpha}_{1}\rvert\Lambda/(\zeta_{1}+\zeta_{2}\omega_{1}/\omega_{2})$.

## Assessment
For clamped modes and a uniform cross-section, $\mathcal{I}_{112}$ is identically zero - The paper's expressions survive only because the trial shapes violate $\phi'(0)=\phi'(L)=0$. The coupling is set instead by how the cross-section varies along the beam.
