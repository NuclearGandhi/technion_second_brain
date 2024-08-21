---
aliases:
---
|                   | סטודנט א'                      | סטודנט ב'                      |
| ----------------- | ------------------------------ | ------------------------------ |
| **שם**            | עידו פנג בנטוב                 | ניר קרל                        |
| **ת"ז**           | 322869140                      | 322437203                      |
| **דואר אלקטרוני** | ido.fang@campus.technion.ac.il | nir.karl@campus.technion.ac.il |

## Question 1
### Part a
We know that the maximum [[MNF1_004 Machining Processes#Turning#Key Parameters and Equations|cutting speed]] is given by:
$$\begin{aligned}
V_{c} & =\pi D_{\max_{}}N
\end{aligned}$$
Therefore the rotational speed is $N=\dfrac{V_{c}}{\pi D_{\max_{}}}$.
Substituting the given maximum allowed cutting speed, and its appropriate diameter of the workpiece, we get the following rotational speed:
$$\begin{gathered}
N =\dfrac{\pu{250m.\min^{-1}}}{\pi\cdot \pu{60mm}} \\[1ex]
\boxed {
N=\pu{1326.3rpm}
 }
\end{gathered}$$



### Part b
For the minimal diameter, $D=\pu{20mm}$, and the same cutting speed $V_{c}=\pu{250m.\min^{-1}}$, the rotational speed would need to be:
$$\begin{aligned}
N & =\dfrac{\pu{250m*\min_{}^{-1}}}{\pi\cdot \pu{20mm}} \\[1ex]
 & = \pu{3978.87rpm}
\end{aligned}$$
Therefore, the machine needs to allow rotational speeds in the following range:
$$\boxed {
\pu{1326.3rpm}<N<\pu{3978.87rpm}
 }$$
By allowing the rotational speed to vary, we get shorter [[MNF1_004 Machining Processes#Turning#Key Parameters and Equations|cutting time]]:
$$t=\dfrac{L}{fN}$$

### Part c
From the drawings, we can see that the required surface finish is $R_{a}=\pu{1.6\mu m}$.
We also know that:
$$\begin{gathered}
3.95R_{a}=\dfrac{f^{2}}{8r} \\[1ex]
f=\sqrt{ 3.95\cdot 8R_{a}r }
\end{gathered}$$
Substituting $R_{a}$ and $r=\pu{0.8mm}$, we get:
$$\boxed {
f=\pu{0.2mm}
 }$$

### Part d
The [[MNF1_004 Machining Processes#Turning#Cutting Force and Power|power required]] is given by:
$$\begin{aligned}
P_{c} & =F_{c}V_{c} \\[1ex]
 &= K_{s}fdV_{c}
\end{aligned}$$
In both cases, the maximal power would be when $V_{c}$ is the largest. Substituting given parameters:
$$\begin{gathered}
P=\pu{369N.mm^{-2}}\cdot \pu{0.2mm}\cdot \pu{5mm}\cdot \pu{250m.min^{-1}} \\[1ex]
\boxed {
P=\pu{1.538kW}
 }
\end{gathered}$$

If $N$ varies, the power stays constant in this value for the whole process. If $N$ stays constant, the cutting speed is at its maximum only in the beginning, meaning that the calculated power is true only for that time period.

### Part e
The cutting is given by:
$$\begin{aligned}
t & =\dfrac{L}{fN} \\[1ex]
 & = \dfrac{\Delta D}{2fN}
\end{aligned}$$
In the more general case:
$$t=\int_{D_{\text{min}}}^{D_{\text{max}}} \dfrac{1}{2fN} \, \mathrm{d}D $$
If $N$ is constant:
$$\begin{gathered}
t  =\dfrac{\pu{40mm}}{2\cdot \pu{0.2mm}\cdot \pu{1326.3rpm}} \\[1ex]
\boxed {
 t =\pu {4.524s }
 }
\end{gathered}$$
If $N$ varies ($V_{c}$ is constant):
$$\begin{aligned}
t & =\int_{D_{\min_{}}}^{D_{\max_{}}} \dfrac{1}{2fN} \, \mathrm{d}D \\[1ex]
  & =\int_{D_{\min_{}}}^{D_{\max_{}}} \dfrac{\pi D}{2fV_{c}} \, \mathrm{d}D \\[1ex]
 & =\dfrac{\pi}{2fV_{c}}\left[ \dfrac{1}{2}D^{2} \right]_{D_{\min_{}}}^{D_{\max_{}}} \\[1ex]
 & = \pu{16mm.min^{-1}.m^{-1}}
\end{aligned}$$
Therefore:
$$\boxed {
t=\pu {3.016s }
 }$$

## Question 2

### Part a
The angle between each tooth is:
$$\begin{gathered}
\beta=\dfrac{360^{\circ}}{z} \\[1ex]
\boxed {
\beta=45^{\circ} 
 }
\end{gathered}$$

### Part b
![[MNF1_HW002/MNF1_HW002 Homework 2 2024-08-05 15.27.31.excalidraw.svg]]
>Definition of $\alpha$ - the total arc angle that the tooth is in the material

Some trigonometry:
![[MNF1_HW002/MNF1_HW002 Homework 2 2024-08-05 15.30.35.excalidraw.svg]]
>Geometry of the problem

From the figure above, we can see that:
$$\begin{gathered}
\cos(180^{\circ} -\alpha)=\dfrac{w-R}{R} \\[1ex]
180^{\circ} -\alpha=45.573^{\circ}  \\[1ex]
\boxed {
\alpha=134.427^{\circ} 
 }
\end{gathered}$$

### Part c
The number of teeth is given by:
$$\begin{gathered}
n=\dfrac{\alpha}{\beta} \\[1ex]
\boxed {
n\approx 3
 }
\end{gathered}$$

### Part d
The [[MNF1_004 Machining Processes#Milling#Cutting Force and Power|cutting force]] is *per tooth* is given by:
$$F_{c}=K_{s}f_{t}d\cos\theta $$
Since there are 3 teeth in the material at any given time, we know that the total force would be
$$F_{c}=K_{s}f_{t}d(\cos\theta+\cos(\theta-\beta)+\cos(\theta-2\beta))$$
as long as the angles are bounded by:
$$-\dfrac{\pi}{2}\leq  \theta,\theta-\beta,\theta-2\beta\leq  -\dfrac{\pi}{2}+\alpha$$
or, in short:
$$0\leq  \theta\leq  \dfrac{\pi}{4}$$

![[MNF1_HW002/MNF1_HW002 Homework 2 2024-08-05 19.37.59.excalidraw.svg]]
>The angle of each tooth in the material

We can see that the maximum will be at $\theta=\dfrac{\pi}{4}$. Substituting the given parameters, we get:
$$\boxed {
F_{c}=\pu {1892.74N }
 }$$

### Part e
We can see that the minimum will be at $\theta=0$. Substituting the given parameters, we get:
$$\boxed {
F_{c}=1338.37N
 }$$

### Part f
The average force is given by:
$$\begin{aligned}
F_{c}=K_{s}wd
\end{aligned}$$
Therefore:
$$\boxed{F_{c}=\pu {133.28kN }}$$

### Part g
The [[MNF1_004 Machining Processes#Milling#Cutting Force and Power|average power]] would be:
$$\begin{aligned}
P_{c} & =F_{c}v \\[1ex]
 & =F_{c}f_{t}zN \\[1ex]
 & =F_{c}f_{t}z \dfrac{V_{c}}{\pi D}
\end{aligned}$$
Therefore:
$$\boxed {
P_{c}=\pu{2.83kW}
 }$$

### Part h
The [[MNF1_004 Machining Processes#Milling#Key Parameters and Equations|total milling time]] (if $L=\pu{200mm}$) is given by:
$$\begin{aligned}
t & =\dfrac{L+D}{v} \\[1ex]
 & =\dfrac{L+D}{f_{t}z (V_{c}/\pi D)}
\end{aligned}$$
Therefore:
$$\boxed{t=\pu {10.37s } }$$


