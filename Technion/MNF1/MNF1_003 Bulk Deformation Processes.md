---
aliases:
---
# Introduction
In this chapter we will go over metalworking processes where the workpiece is subjected to *plastic deformation*, under forces applied through dies and tooling. Deformation processes generally are classified by type of operation as either primary working or secondary working; they are further divided into three categories of cold (room temperature), warm, and hot working.

**Primary-working** operation involve taking a solid piece of metal (generally from a cast state) and breaking it down successively into *wrought* material of various shapes by the basic processes of **forging**, **rolling**, **extrusion**, and **drawing**.

**Secondary-working** operation typically involve further processing of the products from primary working into final or semifinal products, such as bolts, gears, and sheet metal parts.


| Process      |       | General characteristics                                                                                                                                                                                                                                                                                          | Notes               |
| ------------ | ----- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------- |
| [[#Forging]] |       | production of discrete parts with a set of dies; some finishing operations usually necessary; similar parts can be made by casting or powser-metallurgy techniques; usually performed at elevated temperatures; dies and equipment costs are high; moderate to high labor costs; moderate to high operator skill |                     |
| [[#Rolling]] | Flat  | Production of flat plate, sheet, ad foil at high speeds, and with good surface finish, especially in cold rolling; requires very high capital investment; low to moderate labor cost                                                                                                                             |                     |
|              | Shape | Production of various structural shapes, such as $\mathrm{I}$-beams and rails, at high speeds; includes thread and ring rolling; requires shaped rolls and expensive equipment; low to moderate labor cost; moderate operator skill;                                                                             |                     |
| Extrusion    |       |                                                                                                                                                                                                                                                                                                                  | Not in the syllabus |
| Drawing      |       |                                                                                                                                                                                                                                                                                                                  | Not in the syllabus |
| Swaging      |       |                                                                                                                                                                                                                                                                                                                  | Not in the syllabus |

# Forging
**Forging** denotes a family of processes used to make discrete parts, in which plastic deformation is caused by compressive stresses applied through various dies and tooling. Forging is one of the oldest metalworking operations, dating back to 5000 B.C.  

## Open-Die Forging

<center><iframe src="https://mediaplayer.pearsoncmg.com/assets/secs-open-die-forging-operations" width=600 height=400></iframe></center>

**Open-die forging** typically involves hot working and large deformations using simple tools such as flat dies, rounded sections, punches, or saddles.
A common process, known as **upsetting**, involves placing a solid cylindrical workpiece (the blank) between two flat dies (platens) and reducing its height.
![[MNF1_003/Pasted image 20240624101435.png|book]]
>(a) Ideal deformation of a solid cylindrical specimen compressed between flat frictionless dies (platens), an operation known as upsetting. (b) Deformation in upsetting with friction at the die-workpiece interfaces. Note barreling of the billet caused by friction.

Because the *volume of the cylinder remains constant* in plastic deformation, any reduction in its height causes an increase in diameter. The reduction in height is defined as
$$\text{Reduction in height}=\dfrac{{h}_{o}-{h}_{1}}{{h}_{o}}\times 100\%$$
where the subscript '$o$' stands for 'original'.
The [[../SLD1/SLD1_007 מאמץ ועיבור#עיבור|engineering strain]] is
$$e_{1}=\dfrac{{h}_{o}-{h}_{1}}{{h}_{o}}$$
and the [[../SLD1/SLD1_007 מאמץ ועיבור#מאמץ ועיבור אמיתיים|true strain]]
$${\varepsilon}_{1}=\ln\left( \dfrac{{h}_{o}}{{h}_{1}} \right)$$
### Barreling
In actual practice the specimen develops a barrel shape during upsetting, as shown in the following figure:

![[MNF1_003/Pasted image 20240624103652.png|book]]
>Schematic illustration of grid deformation in upsetting; (a) original grid pattern; (b) after deformation, without friction; and (c) after deformation, with friction. Such deformation patterns can be used to calculate the strains within a deforming body.

Barreling is caused primarily by frictional forces that oppose the radially outward flow of the material at the die-workpiece interfaces.
A result of barreling is that the deformation throughout the specimen becomes *nonuniform* or *inhomogeneous*
### Forces under ideal conditions
If friction at the workpiece-die interfaces is zero and the material is perfectly plastic, with yield strength of $S_{y}$, the normal compressive stress on the cylindrical specimen is uniform and at the level of $S_{y}$. The force at any height ${h}_{1}$ is
$$F=S_{y}{A}_{1}$$
where ${A}_{1}$ is the cross-sectional area and is obtained from volume constancy:
$${A}_{1}=\dfrac{{A}_{o}{h}_{o}}{{h}_{1}}$$
A typical true stress-true strain curve is shown in the following figure:
![[MNF1_003/Pasted image 20240624104418.png|book]]
>(a) True stress–true strain curve in tension. Note that, unlike in an engineering stress–strain curve, the slope is always positive and the slope decreases with increasing strain. Although in the elastic range stress and strain are proportional, the total curve can be approximated by the power expression shown. On this curve, Sy is the yield strength and σf is the flow stress. (b) True stress–true strain curve plotted on a log-log scale.

For convenience, such a curve is often approximated by the equation:
$$\sigma=K\varepsilon^{n}$$
If the material's true stress-true strain curve is given by this equation, then the force at any stage during deformation becomes
$$F=\sigma_{f}{A}_{1}$$
where $\sigma_{f}$ is the **flow stress** of the material - the true stress required to continue plastic deformation at a particular true strain, ${\varepsilon}_{1}$.

For a work hardening material, the average flow stress is given by
$$\boxed {
\bar{\sigma}_{f}=\dfrac{K{{\varepsilon}_{1}}^{n}}{n+1}
 }$$

### Slab Method of Analysis
There are several methods of analysis to theoretically determine stresses, strains, strain rates and forces in deformation processing. We will focus on the **Slab method**.

The slab method is one of the earlier and simpler methods of analyzing the stresses and loads in bulk-deformation processes. This method requires the selection of an element in the workpiece and identification of all the normal and frictional stresses acting on that element.
![[MNF1_003/Pasted image 20240624105311.png|book]]
>Stresses on an element in plane-strain compression (forging) between flat dies with friction.

After a lot of math, [[../SLD1/SLD1_002 שיווי משקל#שיווי משקל במרחב|balancing forces]], assuming $\sigma_{x}$ and $\sigma_{y}$ are [[../SLD2/SLD2_002 מישורים ראשיים#מאמצים מישוריים|principal stresses]], plastic deformation equations, [[../SLD2/SLD2_006 קריטריוני כניעה וכשל#קריטריון פון מיזס|distortion-energy criterion]], we get
$$\boxed {
\sigma_{y}-\sigma_{x}=\dfrac{2}{\sqrt{ 3 }}S_{y}=S_{y}'
 }$$
>[!Question]- Isn't it supposed to be $\sqrt{ 2 }$?
 >No Roma, it involves some assumptions about *plastic* deformation. Read the book, they explain everything in detail.
 
 It can also be shown that the pressure $p=\sigma_{y}$ for a rectangular $h\times 2a$ cross-section is given by:
 $$\boxed {
p=S_{y}'e^{2\mu(a-x)/h}
 }$$
 Where $\mu$ is the coefficient of friction.
 Thus, the average pressure will be:
 $$\boxed {
p_{\text{avg}}=S'_{y}\left( 1+\dfrac{\mu a}{h} \right)
 }$$

![[MNF1_003/Pasted image 20240624110130.png|book]]
>Distribution of die pressure, in dimensionless form of $p /S_{y}'$, in plane-strain compression with sliding friction. Note that the pressure at the left and right boundaries is equal to the yield strength of the material in plane strain, $S_{y}'$.

 
 For a disc-shaped cross section, $p$ is given by:
 $$\boxed {
p=S_{y}e^{2\mu(R-r)/h}
 }$$
and the average pressure:
$$\boxed{p_{\text{avg}}=S_{y}\left( 1+\dfrac{2\mu R}{3h} \right)}$$
>[!example] Example: Upsetting Force 
>A cylindrical specimen made of annealed 4135 steel has a diameter of $\pu{150mm}$ and is $\pu{100mm}$ high. It is upset, at room temperature, by open-die forging with flat dies to a height of $\pu{50mm}$
> Assuming that the coefficient of friction is $0.2$, calculate the upsetting force required at the end of the stroke. Use the average-pressure formula.
> 
> **Solution**:
> The average-pressure formula is given by
> $$p_{\text{av}}=\sigma_{f}\left( 1+\dfrac{2\mu R}{3h} \right)$$
> where $S_{y}$ is replaced by $\sigma_{f}$ because the workpiece material is strain hardening. For annealed 4135 steel, $K=\pu{1015MPa}$ and $n=0.17$. The absolute value of the true strain is
> $${\varepsilon}_{1}=\ln\left( \dfrac{100}{50} \right)=0.693$$
> and therefore
> $$\sigma_{f}=K{{\varepsilon}_{1}}^{n}=\pu{953.6MPa}$$
> The final height of the specimen, ${h}_{1}$, is $\pu{50mm}$. The radius $r$ at the end of the stroke is found from volume constancy:
> $$\begin{gathered}
> \left( \dfrac{\pi 150^{2}}{4} \right)100=(\pi {{r}_{1}}^{2})\cdot 50 \\[1ex]
> {r}_{1}=\pu{106.1mm}
> \end{gathered}$$
> Thus,
> $$p_{\text{av}}=963.6\left[ 1+\dfrac{2\cdot 0.2\cdot 106.1}{3\cdot 50} \right]=\pu{1223MPa}$$
> The upsetting force is
> $$\begin{gathered}
> F=\pi(1223)(0.1061)^{2} \\[1ex]
> \boxed {
> F=\pu {43.25MN }
>  }
> \end{gathered}$$

# Rolling
**Rolling** is the process of reducing the thickness or changing the cross section of a long workpiece by compressive forces applied through a set of rolls.
Rolling, which accounts for about $90\%$ of all metals produced by metalworking operations, was first developed in the late 1500s. The basic rolling operation is called flat rolling, or simply rolling, where the rolled products are flat plate and sheet.

![[MNF1_003/Pasted image 20240624112348.png|book]]
>Schematic outline of various flat-rolling and shape-rolling operations.


Rolling is first carried out at elevated temperatures (hot rolling), wherein the coarse-grained, brittle, and porous cast structure of the ingot or continuously cast metal is broken down into a wrought structure, with finer grain size and improved properties

![[MNF1_003/Pasted image 20240624122903.png|book]]
>Changes in the grain structure of metals during hot rolling. This is an effective method to reduce grain size and refine the microstructure in metals, resulting in improved strength and good ductility.

## Mechanics of Flat Rolling
The basic flat-rolling process is shown schematically in the following figure:
![[MNF1_003/Pasted image 20240624124907.png|book]]
>Schematic illustration of the flat-rolling process (Note that the top roll has been removed for clarity).

A strip of thickness ${h}_{o}$ enters the roll gap and is reduced to a thickness of $h_{f}$ by the powered rotating rolls at a surface speed $V_{r}$ of the roll. Rate of metal flow is constant, the velocity of the strip must increase as it moves through the roll gap. At the exit of the roll gap, the velocity of the strip is $V_{f}$.
![[MNF1_003/Pasted image 20240624125102.png|book]]
>Relative velocity distribution between roll and strip surfaces. The arrows represent the frictional forces acting along the strip-roll interfaces. Note the difference in their direction in the left and right regions.

At one location along the arc of contact, however, the two velocities are the same; for this reason, this point is called the **neutral point** , **neutral plane**, or **no-slip point**. To the left of this point, the roll moves faster than the workpiece, and to the right, the workpiece moves faster than the roll.

Because of the relative motion at the interfaces, the frictional forces (which oppose motion) act on the strip surfaces in the directions shown in the last figure. In rolling, the frictional force on the left of the neutral point must be greater than the frictional force on the right. This difference results in a *net frictional force* to the right, making the rolling operation possible by pulling the strip into the roll gap.

**Forward slip** in rolling is defined as
$$\text{Forward slip}=\dfrac{V_{f}-V_{r}}{V_{r}}$$
and is a measure of the relative velocities at the exit of the work rolls.

### Roll Pressure Distribution
It can be noted that the deformation zone in the roll gap is subjected to a state of stress similar to that in [[#Slab Method of Analysis|upsetting]]. However, the calculation of forces and stress distribution in rolling is more involved because the contact surfaces are curved. Also, in cold rolling, the material at the exit is strain hardened, and thus the flow stress at the exit is higher than that at the entry.

![[MNF1_003/Pasted image 20240624130725.png|book]]
>Stresses acting on an element in rolling: (a) entry zone and (b) exit zone.

It can be shown, that similar to upsetting, we can assume that $p$ and $\sigma_{x}$ are principal stresses, and that the relationship between these two principal stresses and the flow stress, $\sigma_{f}$, of the material is given by:
$$\boxed {
p-\sigma_{x}=\dfrac{2}{\sqrt{ 3 }}\sigma_{f}=\sigma_{f}'
 }$$
If we assume that the pressure distribution is symmetric,  It can be shown that pressure distribution is given by (similar to [[#Slab Method of Analysis]] in forging):

$$\boxed {
p(x)=\sigma_{f}'\exp\left( \dfrac{2\mu(L/2-x)}{h} \right)
 }$$
where $x$ is the position along the contact length, with $x=0$ at the neutral point.
The average pressure distribution is given by:
$$\boxed{p_{\text{avg}}=\sigma_{f}'\left( 1+\dfrac{\mu L}{h_{o}+h_{f}} \right)}$$

If we don't assume pressure distribution is symmetric, we get the following graph:
![[MNF1_003/Pasted image 20240624131616.png|book]]
>Pressure distribution in the roll gap as a function of the coefficient of friction. Note that as friction increases, the neutral point shifts toward the entry. Without friction, the rolls will slip, and the neutral point shifts completely to the exit.

## Neutral Point Location
The **neutral point** (as explained in [[#Rolling]]) is where the surface speed of the rolls matches the speed of the workpiece. The position of the neutral point depends on the balance of forward and backward friction forces. When friction increases, the force helping to move the workpiece through the rolls increases on the entry side. This enhanced frictional force shifts the neutral point toward the entry side because less force is needed to accelerate the workpiece to the roll speed.

## Roll Forces
The **roll force**, $F$, (also called the **roll-sparating force**) on the strip is the product of the area under the pressure vs. contact-length curve and the strip width, $w$. 

A simple method of calculating the roll force is to multiply the contact area by an average contact stress, $p_{\text{avg}}$,
$$\boxed {
F=Lwp_{\text{avg}}
 }$$
where $L$ is the length of contact and can be approximated as the projected length; thus
$$\boxed {
L=\sqrt{ R\Delta h }
 }$$
where $R$ is the roll radius and $\Delta h$ is the difference between the original and final thicknesses of the strip.

## Roll Torque and Power
The **roll torque**, $T$, can be estimated by assuming that the roll force, $F$, acts in the middle of the arc of contact (that is, a length of action of $0.5L$), and that this force is perpendicular to the plane of the strip.

The torque per roll is then
$$\boxed {
T=\dfrac{FL}{2}
 }$$
The power required *per roll* (usually there are 2 rolls, so just multiply by $2$) is
$$P=T\omega=\dfrac{FL\omega}{2}=\dfrac{\pi FLN}{60}$$
where $\omega$ is the roller's angular velocity, and $N$ is the roll speed in $\pu{rpm}$.

>[!example] Example: Power Required in Rolling
> A $\pu{225mm}$-wide 6061-O aluminum strip is rolled from a thickness of $\pu{25mm}$ to $\pu{20mm}$. The roll radius is $\pu{300mm}$ and the roll speed is $N=\pu{100rpm}$.
> Estimate the total power required for this operation.
> 
> **Solution**: The length of the arc of contact, $L$ is obtained by
> $$L=\sqrt{ R\Delta h }=\sqrt{ 300(25-20) }=\pu{38.73mm}$$
> For 6061-O aluminum, $K=\pu{205MPa}$ and $n=0.2$. The true strain in this operation is
> $${\varepsilon}_{1}=\ln\left( \dfrac{25}{25} \right)=0.223$$
> Thus,
> $$\bar{\sigma}_{f}=\dfrac{K\varepsilon^{n}}{n+1}=\dfrac{205(0.223)^{0.2}}{1.2}=\pu{126MPa}$$
> and,
> $$\bar{\sigma}_{f}'=\dfrac{2}{\sqrt{ 3 }}\cdot 126=\pu{145MPa}$$
> Therefore, noting the width is $w=\pu{225mm}$, [[#Roll Forces]] yields
> $$F=Lw\bar{\sigma}_{f}'=0.03873\cdot 0.225\cdot(145\cdot 10^{6})=\pu{1.26MN}$$
> so that the power per roll is
> $$\begin{gathered}
> P=\dfrac{\pi(1.26\cdot 10^{6})\cdot 0.03873\cdot 100}{60} \\[1ex]
> P=\pu{255kW}
> \end{gathered}$$
> Therefore, the power needed for both rolls is $\boxed {\pu{510kW}}$.


