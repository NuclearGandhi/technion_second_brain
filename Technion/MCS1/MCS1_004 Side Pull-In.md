---
aliases:
---
# משפעל מקבילי כפול

כפי שראינו ב[[MCS1_001 מבוא#הפעלת מתח|הרצאה הראשונה]], לפי [[MCS1_001 מבוא|משוואה]] $\text{(1.14)}$:
$$\psi=\dfrac{1}{2}kx^{2}-\dfrac{1}{2} \dfrac{{\varepsilon}_{0}A}{g-x}V^{2}+{Q}_{\text{battery,0}}V$$
נקרא לדרגת החופש $y$ כי ככה רשום בסיכומים של אילתה (הסיבה תבוא בהמשך):
$$\tilde{\psi}=\dfrac{1}{2}\tilde{y}^{2}-\dfrac{1}{2} \dfrac{\tilde{V}^{2}}{(1-\tilde{y})}$$
לאחר נרמול (והתעלמות מהמטען הקבוע ${Q}_{\text{battery,0}}$):
$$\tilde{\psi}=\dfrac{1}{2} \tilde{y}^{2}-\dfrac{1}{2} \dfrac{\tilde{V}^{2}}{(1-\tilde{y})}$$
כאשר:
$$\tilde{\psi}:=\dfrac{\psi}{kg^{2}},\qquad \tilde{y}:= \dfrac{y}{g},\qquad \tilde{V}^{2}:=\dfrac{{\varepsilon}_{0}A}{kg^{3}}V^{2}$$

נשרטט את $\tilde{\psi}$ עבור ערכי $\tilde{V}$ שונים (דיאגרמת קווי גובה של $\tilde{\psi}$):
![[parallel_plate_voltage_potential.png|bookhue|600]]^figure-parallel-plate-potential
>אנרגיה פוטנציאלית כתלות בהעתק עבור מתחים שונים במפעיל לוחות מקביליים.

עבור ערכי $\tilde{V}$ שונים, אנו מצפים לקבל התנהגות שיווי משקל שונה. למשל, עבור $\tilde{V}=0$ (העקומה הכי עליונה), אנו רואים שהעקומה קמורה כלפי מעלה, כך שהיא יציבה ב-$y=0$. זוהי ההתנהגות הצפויה כי כאשר $\tilde{V}=0$ רק הקפיץ המכני משפיע על מצב המערכת, ואכן הוא יציב כאשר הוא רפוי.
ככל ש-$\tilde{V}$ גדל, אנו מקבלים עוד נקודת שיווי משקל *לא יציבה* בערכים גדולים של $\tilde{y}$, כי בגדלים אלו האלקטרודה הצפה קרובה מספיק לאלקטרודה המוארקת כדי להתגבר על הכוח המכני של הקפיץ.
עבור $\tilde{V}=\tilde{V}_{\text{PI}}$, נקודת שיווי משקל זו הופכת לאדישה (העקומה האדומה), כפי שראינו ב[[MCS1_001 מבוא#הפעלת מתח|הפעלת מתח]].

הכוח הריאקטיבי הוא:
$$\tilde{f}_{R}=\tilde{y}-\dfrac{1}{2} \dfrac{\tilde{V}^{2}}{(1-\tilde{y})^{2}}$$
שיווי משקל מתקבל כאשר הכוח הריאקטיבי מתאפס:
$$\tilde{y}=\dfrac{1}{2} \dfrac{\tilde{V}^{2}}{(1-\tilde{y})^{2}}$$
![[parallel_plate_voltage_equilibrium.png|bookhue|500]]^figure-parallel-plate-equilibrium
>עקומת שיווי משקל של מפעיל לוחות מקביליים.

הקשיחות:
$$\tilde{K}=1-\dfrac{\tilde{V}^{2}}{(1-\tilde{y})^{3}}$$
הקשיחות בשיווי משקל:
$$\tilde{K}_{\text{eq}}=\dfrac{1-3\tilde{y}}{1-\tilde{y}}$$
## הפעלת מתח

נביט כעת במערכת של משפעל מקבילי כפול וסימטרי:
![[MCS1_004 הצמדה צדדית 2025-11-23 15.26.09.excalidraw.svg]]^figure-symmetric-parallel-plate-schematic
>משפעל מקבילי כפול סימטרי עם $y$ כדרגת חופש.

מערכת זו סימטרית (אנו מניחים שאין כבידה) ולפיכך נצפה שעבור כל מתח $V$, הפלטה האמצעית תהיה בשיווי משקל במרכז ($y=0$).

הקיבול של המערכת (שני קבלים מחוברים ב-*מקביל*):
$$C={\varepsilon}_{0}A\left( \dfrac{1}{g-y}+\dfrac{1}{g+y} \right)$$
ולכן:
$$C={\varepsilon}_{0}A \dfrac{2g}{g^{2}-y^{2}}\tag{4.1}$$
ולכן האנרגיה הפוטנציאלית:
$$\psi=\dfrac{1}{2}ky^{2}-\dfrac{1}{2} \dfrac{2{\varepsilon}_{0}Ag}{(g^{2}-y^{2})}V^{2} \tag{4.2}$$
לאחר נרמול:
$$\begin{aligned}
\tilde{\psi} & =\dfrac{1}{2}\tilde{y}^{2}-\dfrac{1}{2} \dfrac{\tilde{V}^{2}}{(1-\tilde{y}^{2})}
\end{aligned} \tag{4.3}$$
כאשר:
$$\tilde{\psi}:=\dfrac{\psi}{kg^{2}},\qquad \tilde{y}:= \dfrac{y}{g},\qquad \tilde{V}^{2}:=\dfrac{2{\varepsilon}_{0}A}{kg^{3}}V^{2}$$

![[symmetric_parallel_plate_voltage_potential.png|bookhue|600]]^figure-symmetric-parallel-plate-potential
>אנרגיה פוטנציאלית כתלות בהעתק עבור מתחים שונים במפעיל לוחות מקביליים סימטרי.

דיאגרמה זו היא למעשה השלמת מראה של [[#^figure-parallel-plate-potential|איור קודם]]. אנו רואים שמ-$\tilde{V}> \tilde{V}_{\text{PI}}$, $\tilde{y}=0$ כבר נהיית לא יציבה, ואנו מגיעים למצב של **ביפורקציה** - אי-יציבות שיכולה להוביל לאחד משני מצבים. במקרה שלנו, pull-in לאלקטרודה העליונה או pull-in לאלקטרודה התחתונה.

כוח התגובה הוא:
$$\tilde{f}_{R}=\tilde{y}\left( 1-\dfrac{\tilde{V}^{2}}{(1-\tilde{y})^{2}} \right) \tag{4.4}$$
שיווי משקל יתקבל כאשר:
$$1-\dfrac{\tilde{V}^{2}}{(1-\tilde{y}^{2})}=0,\qquad \tilde{y}=0$$
הפתרונות הפיזיקליים הם:
$$\tilde{y}=\pm \sqrt{ 1-\tilde{V} },\, \qquad \tilde{y}=0\tag{4.5}$$
כיוון שלא יכול להתקיים $y>\sqrt{ 1+\tilde{V} }$.

נגזור כדי למצוא את הקשיחות:
$$\tilde{K}=\left( 1-\dfrac{\tilde{V}^{2}}{(1-\tilde{y}^{2})^{2}} \right)-\dfrac{4\tilde{y}^{2}\tilde{V}^{2}}{(1-\tilde{y}^{2})^{3}}\tag{4.6}$$

הקשיחות בשיווי משקל:
$$\begin{aligned}
 & \tilde{K}_{\tilde{y}=0}=1-\tilde{V}^{2} \\[1ex]
 & \tilde{K}_{\tilde{y}=\pm \sqrt{ 1-\tilde{V} }}=-\dfrac{4\tilde{y}^{2}}{1-\tilde{y}^{2}}
\end{aligned} \tag{4.7}$$

![[symmetric_parallel_plate_voltage_equilibrium.png|bookhue|600]]^figure-symmetric-parallel-plate-equilibrium
>עקומת שיווי משקל של מפעיל לוחות מקביליים סימטרי.

באיור לעיל ניתן לראות את הביפורקציה - הפיצול לשני מצבי ה pull-in השונים.

## הפעלת מטען
בהפעלת מטען, הקבלים עדיין מחוברים במקביל, הרי האלקטרודות הצדדיות מוארקות, והמטען ולפיכך המתח על האלקטרודה האמצעית קבועה.

לכן הקיבול זהה ל-$\text{(4.1)}$:
$$C={\varepsilon}_{0}A \dfrac{2g}{g^{2}-y^{2}}$$
סך האנרגיה הפוטנציאלית:
$$\psi=\dfrac{1}{2}ky^{2}+\dfrac{1}{2} 
\dfrac{g^{2}-y^{2}}{2{\varepsilon}_{0}Ag}Q^{2} \tag{4.8}$$

![[symmetric_parallel_plate_charge_potential.png|bookhue|600]]^figure-symmetric-parallel-plate-charge
>אנרגיה פוטנציאלית כתלות בהעתק עבור מטענים שונים במפעיל לוחות מקביליים סימטרי.


לאחר נרמול:
$$\tilde{\psi}=\dfrac{1}{2}\tilde{y}^{2}+\dfrac{1}{2}(1-\tilde{y}^{2})\tilde{Q}^{2}\tag{4.9}$$
כאשר:
$$\tilde{\psi}=\dfrac{\psi}{kg^{2}},\qquad \tilde{y}=\dfrac{y}{g},\qquad \tilde{Q}^{2}=\dfrac{Q^{2}}{2{\varepsilon}_{0}Akg}$$
הכוח הריאקטיבי:
$$\tilde{f}_{R}=\tilde{y}(1-\tilde{Q}^{2}) \tag{4.10}$$
נקבל שיווי משקל כאשר:
$$\tilde{y}=0\quad \text{or}\quad  \tilde{Q}^{2}=1 \tag{4.11}$$
הקשיחות של המערכת:
$$\tilde{K}=1-\tilde{Q}^{2} \tag{4.12}$$
הקשיחות בשיווי משקל:
$$\begin{aligned}
 & \tilde{K}_{\tilde{y}=0}=(1-\tilde{Q}^{2}) \\[1ex]
 & \tilde{K}_{\tilde{Q}^{2}=1}=0
\end{aligned}$$
![[symmetric_parallel_plate_charge_equilibrium.png|bookhue|600]]^figure-symmetric-parallel-plate-charge-equilibrium
>עקומת שיווי משקל של מפעיל לוחות מקביליים סימטרי בהפעלת מטען.

קיבלנו מערכת שהיא אדישה עבור $\tilde{Q}=1$.

# Side Pull In במשפעל מסרק

## משפעל מסרק חד-צדדי

נביט כעת מה קורה כאשר ב[[MCS1_002 שדות שוליים ומשפעל מסרק#משפעל מסרק|משפעל מסרק]] ישנה גם דרגת חופש אנכית:

![[MCS1_004 Pull-In צדדי 2025-11-23 15.50.28.excalidraw.svg]]^figure-one-sided-comb-schematic
>סכמה של משפעל מסרק חד-צדדי בהתחשבות החופש האנכי.

כעת הקיבול הוא פונקציה של $x$ ו-$y$:
$$\begin{gather}
C(x,y)=n{\varepsilon}_{0}b(OL+x)\left( \dfrac{1}{g-y}+\dfrac{1}{g+y} \right)
\end{gather}$$
לאחר סידור:
$$C(x,y)=\dfrac{2n{\varepsilon}_{0}b(OL+x)}{g(1-(y/g)^{2}} \tag{4.13}$$
כאשר $n$ הוא מספר ראשי המסרק על הרוטור (החלק השמאלי המחובר לקפיץ).

כאשר המשפעל מופעל מתח, הפוטנציאל נתון ע"י:
$$\psi(x,y,V)=\dfrac{1}{2}{{{k}_{x}}}^{2}+\dfrac{1}{2}{k}_{y}y^{2}-\dfrac{1}{2} \dfrac{2n{\varepsilon}_{0}b(OL+x)}{g(1-(y/g)^{2})}\tilde{V}^{2} \tag{4.14}$$
לאחר נרמול:
$$\tilde{\psi}(\tilde{x},\tilde{y},\tilde{V})=\dfrac{1}{2}\tilde{x}^{2}+\dfrac{1}{2}\tilde{k}\tilde{y}^{2}-\dfrac{\tilde{O}+\tilde{x}}{1-\tilde{y}^{2}}\tilde{V}^{2}\tag{4.15}$$

כאשר:
$$\begin{aligned}
 & \tilde{\psi}=\dfrac{\psi}{{k}_{x}{{{L}_{e}}}^{2}}, &  & \tilde{k}=\dfrac{{k}_{y}g^{2}}{{k}_{x}{{{L}_{e}}}^{2}} \\[1ex]
 & \tilde{V}^{2}=\dfrac{n{\varepsilon}_{0}b}{g{k}_{x}{L}_{e}}V^{2}, &  & \tilde{x}=\dfrac{x}{{L}_{e}} \\[1ex]
 & \tilde{y}=\dfrac{y}{g}, &  & \tilde{O}=\dfrac{OL}{{L}_{e}}
\end{aligned}$$
ו-${L}_{e}$ הוא טווח התנועה הצפוי בכיוון הראשי (${L}_{e}<L-OL$).

כוח התגובה:
$$\begin{align}
 & \tilde{f}_{x}=\tilde{x}-\dfrac{\tilde{V}^{2}}{1-\tilde{y}^{2}}  \tag{4.16a}\\[1ex]
 & {f}_{{R}_{y}}=\tilde{y}\left( \tilde{k}-2 \dfrac{\tilde{O}+\tilde{x}}{(1-\tilde{y}^{2})^{2}}\tilde{V}^{2} \right) \tag{4.16b}
\end{align}$$
השיווי משקל של המערכת מתקבל כאשר:
$$\begin{align}
 & \tilde{f}_{x}=0: &  & \tilde{x}-\dfrac{\tilde{V}^{2}}{1-\tilde{y}^{2}}=0 \tag{4.17a}\\[3ex]
 & \tilde{f}_{y}=0: &  & \tilde{y}\left( \tilde{k}-2 \dfrac{\tilde{O}+\tilde{x}}{(1-\tilde{y}^{2})} \right)=0 \tag{4.17b}
\end{align}$$
משתי משוואות אלו נסיק שתי פתרונות:
- עבור $\tilde{y}=0$, משוואה $\text{(4.17b)}$ מתקיימת, ומ-$\text{(4.17a)}$ נסיק שגם $\tilde{x}=\tilde{V}^{2}$.
- עבור $\tilde{y} \neq 0$, כדי לקיים את $\text{(4.17b)}$ צריך ש:
	$$\tilde{k}=2 \dfrac{(\tilde{O}+\tilde{x})}{(1-\tilde{y}^{2})^{2}}\tilde{V}^{2}$$
	נציב את $\text{(4.17a)}$:
	$$\tilde{k}=2 \dfrac{(\tilde{O}+\tilde{x})\tilde{x}}{1-\tilde{y}^{2}}$$
	ולכן:
	$$\tilde{y}=\pm \sqrt{ 1-(\tilde{O}+\tilde{x}) \dfrac{2\tilde{x}}{\tilde{k}} }$$

נסכם:
$$\begin{align}
 & y=0 \quad \text{and}\quad  \tilde{x}=\tilde{V}^{2} \tag{4.18a} \\[1ex]
 & y=\pm \sqrt{ 1-(\tilde{O}+\tilde{x}) \dfrac{2\tilde{x}}{\tilde{k}} } \tag{4.18b}
\end{align}$$

הפתרונות $\text{(4.18a)}$ ו-$\text{(4.18b)}$ מוצגים בדיאגרמה הבאה, עבור המקרה המיוחד של $\tilde{O}=0$ ו-$\tilde{k}=2$:

![[one_sided_comb_equilibrium.png|bookhue|400]]^figure-one-sided-comb-equilibrium
>עקומת שיווי משקל של משפעל מסרק חד-צדדי.

>[!info] כלל תכן:
>טווח תנועה מלא $\tilde{x}=1$ מתקבל ע"י הפעלת מתח $\tilde{V}^{2}=1$, ו-pull in צדדי ניתן למניעה בתוך טווח ע"י קיום $\tilde{k}>2(1+\tilde{O})$.

## משפעל מסרק דו-צדדי

במקרה הדו-צדדי:

![[MCS1_004 Side Pull-In 2025-11-23 21.47.45.excalidraw.svg]]^figure-double-sided-comb-schematic
>סכמה של משפעל מסרק דו-צדדי בהתחשבות החופש האנכי.

סך הפוטנציאל של המערכת הוא:
$$\psi=\dfrac{1}{2}{k}_{x}x^{2}+\dfrac{1}{2}{k}_{y}y^{2}-\dfrac{1}{2}n{\varepsilon}_{0}b[2OL({{{V}_{S}}}^{2}+{{{V}_{R}}}^{2})+4{V}_{S}{V}_{R}x]\left[ \dfrac{1}{g-y}+\dfrac{1}{g+y} \right]$$
לאחר סידור:
$$\psi=\dfrac{1}{2}{k}_{x}x^{2}+\dfrac{1}{2}{k}_{y}y^{2}-\dfrac{1}{2} \dfrac{2n{\varepsilon}_{0}bg}{g^{2}-y^{2}}[2OL({{{V}_{S}}}^{2}+{{{V}_{R}}}^{2})+4{V}_{S}{V}_{R}x] \tag{4.19}$$
לאחר נרמול:
$$\tilde{\psi}(\tilde{x},\tilde{y},\tilde{V})=\dfrac{1}{2}\tilde{x}^{2}+\dfrac{1}{2}\tilde{k}\tilde{y}^{2}-\dfrac{1+\tilde{V}^{2}+2\tilde{V}\tilde{x}}{1-\tilde{y}^{2}}{{\tilde{V}_{S}}}^{2}\tag{4.20}$$
כאשר:
$$\begin{aligned}
 & \tilde{\psi}=\dfrac{\psi}{kOL^{2}}, &  & \tilde{x}=\dfrac{x}{OL} \\[1ex]
 & \tilde{y}=\dfrac{y}{g}, &  & \tilde{k}=\dfrac{{k}_{y}g^{2}}{{k}_{x}OL^{2}} \\[1ex]
 & {{\tilde{V}_{S}}}^{2}=\dfrac{2n{\varepsilon}_{0}b}{{k}_{x}OLg}, &  & \tilde{V}^{2}_{R}=\dfrac{2n{\varepsilon}_{0}b}{{k}_{x}OLg}{{{V}_{R}}}^{2} \\[1ex]
 & \tilde{V}=\dfrac{\tilde{V}_{R}}{\tilde{V}_{S}}
\end{aligned}$$
ההזזה בכיוון הראשי מוגבלת לטווח $-1<\tilde{x}<1$ כדי להבטיח שהרוטור לא יתנתק מהסטטור.

הכוחות הריאקטיביים:
$$\begin{align}
 & \tilde{f}_{x}(\tilde{x},\tilde{y},\tilde{V})=\tilde{x}-\dfrac{2{{\tilde{V}_{S}}}^{2}}{1-\tilde{y}^{2}}\tilde{V}\tag{4.21a} \\[1ex]
 & \tilde{f}_{y}(\tilde{x},\tilde{y},\tilde{V})=\tilde{y}\left[ \tilde{k}-\dfrac{1+\tilde{V}^{2}+2\tilde{V}\tilde{x}}{(1-\tilde{y}^{2})^{2}}\cdot 2{{\tilde{V}_{S}}}^{2} \right] \tag{4.21b}
\end{align}$$
שיווי משקל:
$$\begin{align}
 & \tilde{f}_{x}=0: &  & \tilde{x}-\dfrac{2{{\tilde{V}_{S}}}^{2}}{1-\tilde{y}^{2}}\tilde{V}=0 \tag{4.22a} \\[3ex]
 & \tilde{f}_{y}=0: &  & \tilde{y}\left[ \tilde{k}-\dfrac{1+\tilde{V}^{2}+2\tilde{V}\tilde{x}}{(1-\tilde{y}^{2})^{2}}\cdot 2{{\tilde{V}_{S}}}^{2} \right] =0 \tag{4.22b}
\end{align}$$
משתי משוואות אלו נסיק שתי פתרונות:
- עבור $\tilde{y}=0$, משוואה $\text{(4.22b)}$ מתקיימת, ומ-$\text{(4.22a)}$ נסיק שגם $\tilde{x}=2{{\tilde{V}_{S}}}^{2}\tilde{V}$.
- עבור $\tilde{y} \neq 0$, כדי לקיים את $\text{(4.22b)}$ צריך ש:
	$$\tilde{k}=\dfrac{1+\tilde{V}^{2}+2\tilde{V}\tilde{x}}{(1-\tilde{y}^{2})^{2}}2{{\tilde{V}_{S}}}^{2}$$
	נציב את $\text{(4.22a)}$ ונבודד את $\tilde{x}^{2}$ לקבלת:
	$$\tilde{x}^{2}=2{{\tilde{V}_{S}}}^{2} \dfrac{\tilde{k}(1-\tilde{y}^{2})^{2}-2{{\tilde{V}_{S}}}^{2}}{4{{\tilde{V}_{S}}}^{2}(1-\tilde{y}^{2})+(1-\tilde{y}^{2})^{2}}$$

נסכם:
$$\begin{align}
 & y=0 \quad \text{and}\quad  \tilde{x}=2{{\tilde{V}_{S}}}^{2}\tilde{V}\tag{4.23a} \\[1ex]
 & \tilde{x}^{2}=2{{\tilde{V}_{S}}}^{2} \dfrac{\tilde{k}(1-\tilde{y}^{2})^{2}-2{{\tilde{V}_{S}}}^{2}}{4{{\tilde{V}_{S}}}^{2}(1-\tilde{y}^{2})+(1-\tilde{y}^{2})^{2}} \tag{4.23b}
\end{align}$$

לפני שנשרטט את העקומות שיווי משקל של המשפעל, נשים לב שעבור יישום פרקטי של משפעל מסרק כפול נרצה שכאשר ההזזה מקסימלית בכיוון הראשי ($\tilde{x}=1$), גודל המתח המנורמל הוא יחידה ($\tilde{V}_{\tilde{x}=1}=1$). 

ממשוואה $\text{(4.23a)}$ זה אומר שנרצה לעבור ב- $\tilde{V}^{2}=1/2$. מהצבה של ערך זה ב-$\text{(4.23b)}$ נקבל את עקומות שיווי המשקל (הלא יציבות) באיורים הבאים. עקומות אלו חושבו עבור ערכים שונים של פרמטר הקשיחות $\tilde{k}$, והחיתוך בין עקומות אלו והפתרון הראשון $\text{(4.23a)}$ (כלומר, הקו $\tilde{y}=0$) הם שתי נקודות pull-in. נסיק מכך שטווח פעולה מלא של $-1<\tilde{x}<1$ אפשרי אך ורק אם $\tilde{k}>4$. עבור ערכין קטנים יותר של $\tilde{k}$, אי-יציבות של ה- side pull-in יגביל את טווח התנועה. 

![[double_sided_comb_equilibrium.png|bookhue|600]]^figure-double-sided-comb-equilibrium
>עקומות שיווי משקל של משפעל מסרק דו-צדדי המציגות מצבי שיווי משקל יציבים (קו רציף) ולא יציבים (קו מקווקו). (א) פתרון משוואה (5) עבור $\tilde{k}=10,6,4,3,2,1.1$ (מהעקומות הפנימיות לחיצוניות). (ב) עקומות שיווי משקל עבור $\tilde{k}=4$.

# פתרונות לטיפול ב- Side Pull-In

[^1]: Grade, J. D., Jerman, H., & Kenny, T. W. (2003). Design of large deflection electrostatic actuators. _Journal of Microelectromechanical Systems_, _12_(3), 335–343. [https://doi.org/10.1109/JMEMS.2003.811750](https://doi.org/10.1109/JMEMS.2003.811750)]

הקטע הבא מתבסס על המאמר "Design of Large Deflection Electrostati Actuators" [^1].

בשנות ה-2000, עם העלייה הדרמטית בביקוש להעברת מידע בממדים עצומים, הואצה פריסת תשתיות הסיבים האופטיים ברחבי העולם. בצמתי התקשורת, האותות האופטיים נדרשים להיות מנותבים ליעדם. השיטה המסורתית לביצוע מיתוג זה כרוכה בהמרת האות מאופטי לחשמלי, ביצוע הניתוב האלקטרוני, והמרה חזרה לאות אופטי (O-E-O). תהליך זה הוא יקר, צורך אנרגיה רבה ומהווה צוואר בקבוק בקצבי העברת מידע גבוהים. פתרון יעיל יותר הוא מיתוג אופטי ישיר (All-Optical Switching), המאפשר לנתב את אלומות האור ללא צורך בהמרה חשמלית. מערכות MEMS, ובפרט משפעלים אלקטרוסטטיים המזיזים מראות או חוסמים, מציעות פתרון קומפקטי ויעיל למימוש מתגים אופטיים אלו.

![[Pasted image 20251124085043.png|bookhue|600]]^figure-optical-switch
>תרשים סכמטי של מתג אופטי $1\times N$ המשתמש במספר משפעלים לינאריים. קרן לייזר, המיושרת ע"י עדשת GRIN, נע שמאלה עד שהיא נחסמת ע"י מראה מוסטת וממוקדת לסיב מוצא [^1].

במאמר פורטו בעיות תכן של side pull-in, ומספר פתרונות עבורן.

![[Pasted image 20251124085204.png|bookhue|300]]^figure-comb-traditional
>שרטוט סכמטי של משפעל מסרק מסורתי.[^1]

במשפעל לעיל, אחת הבעיות האפשריות היא סיבוב של כלל הרוטור - בעיה שמתעצמת ככל שהמסרק גדל בגובהו. בסכמה הבאה, מוצע הפתרון בו העוגנים יוצאים החוצה מהמסרק, והמסרק מתהפך, כך שהרוטור בחוץ והסטטור בפנים. מערך זה הרבה יותר קשיח אנכית, ומאחר והמסרק קרוב יותר לציר הסיבוב, הוא יסתובב פחות:


![[Pasted image 20251124085409.png|bookhue|300]]^figure-comb-u-shape
>שרטוט סכמטי של משפעל מסרק עם חלק נע (shuttle) בצורת U ושני קפיצים מקופלים בלבד.[^1]

עוד בעיה שעולה היא הקשיחות האנכית של קורות ה-suspension *כאשר הן מכופפות*. עד כה בחנו את הקשיחות האנכית (צירית) שלהן כאשר הן ישרות, אבל קשיחות זו קטנה בהרבה לאחר הכיפוף שלהן - וכאשר הן מכופפות מדובר בשילוב המקסימלי של המסרק, זהו הרגע הכי קריטי ל- side pull-in!

הפתרון שמציעים במאמר הוא גאוני: נייצר את הקורות מכופפות מלכתחילה בכיוון ההפוך, כך שכאשר מגיעים לשילוב מלא, הקורות ישרות.
בנוסף, מתואר באיור הבא גם פתרון להקטנת כוח ה-side pull-in כתלות בשטח השילוב. אם מקטינים חלק מהשיניים של המסרק (הזווית שרואים בשרטוט) שטח השילוב קטן, ולפיכך כוח ה- side pull-in. למה אז כבר לא לקצר את כל השיניים? כי עדיין חייבים כמה שיניים שיתחילו את תהליך השילוב כדי שבכלל נקבל קיבול אלקטרוסטטי.

![[Pasted image 20251124085455.png|bookhue|300]]^figure-comb-improved
>שרטוט סכמטי של משפעל מסרק משופר, בו הקפיצים ושיני המסרק שונו על מנת לאפשר תזוזות גדולות.[^1]

![[Pasted image 20251124085537.png|600]]^figure-comb-sem
>תמונת SEM של משפעל מסרק עם שילוב לינארי של השיניים וקפיצים עם עיקום מוקדם (prebent).[^1]

![[Pasted image 20251124085644.png|500]]^figure-comb-etch-fins
>תמונת SEM המראה קפיץ של משפעל עם סדרה של סנפירים בצורת H (etch fins) שנועדו לשלוט בפרופיל דופן הצד (sidewall) מבלי להשפיע על קשיחות הקפיץ.[^1]


# תרגילים


## תרגיל 1
שן הרוטור היא בעלת אורך $L$ רוחב $w$ ועובי $b$, המרחק בין שן סטטור לשן רוטור הוא $g$ ואנו מניחים כי הוא אחיד.
מתח $V$ מופעל על הרוטור וגורם לתנועה המשנה את שטח החפיפה ההתחלתי בשיעור $OL+x$. בהנחה שהמבנה סימטרי, תופעת ה- side pull-in של שן בודדת, תרחש רק כאשר נגיע לאי-יציבות.

![[MCS1_004 הצמדה צדדית 2025-11-23 14.27.27.excalidraw.svg]]^figure-ex1-schematic
>סכמה של הבעיה הנתונה.

המשתנה $x$ קובע את המיקום של הרוטור, בעוד המשתנה $\xi$ הוא משתנה רץ לאורך הקורה שניעזר בו לחישוב השקיעה בקורה. שני המשתנים האלו באותו הכיוון.

נשים לב שניתן להסתכל על הבעיה כקורה רתומה עם עומס מפורס:
![[MCS1_004 Side Pull-In 2025-11-23 22.28.56.excalidraw.svg]]^figure-ex1-beam-model
>בעיית קורה רתומה עם עומס מפורס לא לאורך כל הקורה.

מבחינת מהמשוואה השולטת בכיוון האנכי, העומס המפורס כתוצאה מהשדה החשמלי נותן לנו את המשוואה הבאה:
$$EI \dfrac{\mathrm{d}^{4}y}{\mathrm{d}\xi^{4}}=\begin{cases}
0 & 0\leq  \xi\leq  L-(OL+x) \\
\dfrac{1}{2}{\varepsilon}_{0}bV^{2}\left( \dfrac{1}{(g-y)^{2}}-\dfrac{1}{(g+y)^{2}} \right) & L-(OL+x)\leq  \xi\leq  L
\end{cases} \tag{E4.1}$$

התחום הראשון הוא מחוץ לשטח החפיפה לכן לא פועל בתחום זה כוח. התחום השני הוא באזור חפיפת השיניים לכן על השן יש עומס מפורס.

הביטוי לעומס המפורס הינו הכוח הריאקטיבי השקול ליחידת אורך. ניתן לקבל אותו מגזירה הביטוי לאנרגיה האלקטרוסטטית לשן בודדת, לפי דרגת החופש הרלוונטית $y$.

לאחר נרמול:
$$\dfrac{\mathrm{d}^{4}\tilde{y}}{\mathrm{d}\tilde{\xi}^{4}}=\begin{cases}
0 & 0\leq  \tilde{\xi}\leq  \alpha  \\
\tilde{V}^{2} \dfrac{\tilde{y}}{(1-\tilde{y}^{2})^{2}} & \alpha \leq  \tilde{\xi}\leq  1
\end{cases} \tag{E4.2}$$

כאשר:
$$\begin{aligned}
 & \tilde{y}:=\dfrac{y}{g}, &  & \tilde{\xi}:=\dfrac{\xi}{L} \\[1ex]
 & \beta:=\dfrac{OL+x}{L}, &  & \alpha =1-\beta \\[1ex]
 & \tilde{V}^{2}=24 \dfrac{{\varepsilon}_{0}L^{4}}{Ew^{3}g^{3}}
\end{aligned} \tag{E4.3}$$

על סף ה pull-in השקיעה $\tilde{y}$ קטנה, לכן ניתן לפתח את הכוח המנורמל באגף ימין לטור טיילור:
$$\tilde{V}^{2} \dfrac{\tilde{y}}{(1-\tilde{y}^{2})^{2}}=\tilde{V}^{2}(\tilde{y}+2\tilde{y}^{3}+\mathcal{O}(\tilde{y}^{5})) \tag{E4.4}$$
אם ניקח קירוב ראשון, המשוואות נהיות הרבה יותר פשוטות:
$$\dfrac{\mathrm{d}^{4}\tilde{y}}{\mathrm{d}\tilde{\xi}^{4}}=\begin{cases}
0 & 0\leq  \tilde{\xi}\leq  \alpha  \\
\tilde{V}^{2}\tilde{y} & \alpha \leq  \tilde{\xi}\leq  1
\end{cases} \tag{E4.5}$$

נפתור את הבעיה בכל אחד מהתחומים. התחום הראשון פשוט ונקבל:
$$\begin{aligned}
\tilde{y}_{1}={b}_{0}+{b}_{1}\xi+{b}_{2}\xi ^{2}+{b}_{3}\xi ^{3} &  & 0\leq  \xi\leq  a
\end{aligned} \tag{E4.6}$$
בתחום השני יש לנו מד"ר לינארית עם מקדמים קבועים ולכן הפתרון נתון ע"י פולינום אופייני ושורשיו:
$$r^{4}=\tilde{V}^{2}$$
נגדיר $\lambda ^{2}:=\tilde{V}$ כך שנוכל לרשום:
$${r}_{1,2}=\pm \lambda,\qquad {r}_{3,4}=\pm i\lambda$$
לפיכך הפתרון:
$$\tilde{y}_{2}={c}_{0}e^{-\lambda \xi}+{c}_{1}e^{\lambda \xi}+{c}_{2}\sin(\lambda \xi)+{c}_{3}\cos(\lambda \xi)\qquad a\leq  \xi\leq  1 \tag{E4.7}$$

השן רתומה בקצה אחד (לבסיס הרוטור) ובעלת קצה חופשי ב-$\tilde{\xi}=1$. לכן תנאי השפה של הבעיה:
$$\begin{aligned}
 & \tilde{\xi}=0: &  & \tilde{y}=\tilde{y}'=0 \\
 & \tilde{\xi}=1: &  & \tilde{y}''=\tilde{y}'''=0
\end{aligned} \tag{E4.8}$$

בנוסף, יש לנו את תנאי הרציפות בין שני התחומים:
$$\begin{aligned}
 & \tilde{y}_{1}(\alpha )=\tilde{y}_{2}(\alpha ) \\[1ex]
 & \tilde{y}_{1}'(\alpha )=\tilde{y}_{2}'(\alpha ) \\[1ex]
 & y''_{1}(\alpha )=y''_{2}(\alpha ) \\[1ex]
 & y'''_{1}(\alpha )={y}_{2}'''(\alpha )
\end{aligned} \tag{E4.9}$$
לאחר הצבת תנאי השפה ותנאי הרציפות נקבל בצורה מטריצית את מערכת המשוואות הבאה עבור וקטור המקדמים $\mathbf{v}=[b_2, b_3, c_0, c_1, c_2, c_3]^T$ (כאשר $b_0=b_1=0$ בשל תנאי השפה באפס):
$$\begin{pmatrix}
-\alpha^2 & -\alpha^3 & e^{-\lambda\alpha} & e^{\lambda\alpha} & \sin(\lambda\alpha) & \cos(\lambda\alpha) \\
-2\alpha & -3\alpha^2 & -\lambda e^{-\lambda\alpha} & \lambda e^{\lambda\alpha} & \lambda \cos(\lambda\alpha) & -\lambda \sin(\lambda\alpha) \\
-2 & -6\alpha & \lambda^2 e^{-\lambda\alpha} & \lambda^2 e^{\lambda\alpha} & -\lambda^2 \sin(\lambda\alpha) & -\lambda^2 \cos(\lambda\alpha) \\
0 & -6 & -\lambda^3 e^{-\lambda\alpha} & \lambda^3 e^{\lambda\alpha} & -\lambda^3 \cos(\lambda\alpha) & \lambda^3 \sin(\lambda\alpha) \\
0 & 0 & \lambda^2 e^{-\lambda} & \lambda^2 e^{\lambda} & -\lambda^2 \sin(\lambda) & -\lambda^2 \cos(\lambda) \\
0 & 0 & -\lambda^3 e^{-\lambda} & \lambda^3 e^{\lambda} & -\lambda^3 \cos(\lambda) & \lambda^3 \sin(\lambda)
\end{pmatrix} \begin{pmatrix} b_2 \\ b_3 \\ c_0 \\ c_1 \\ c_2 \\ c_3 \end{pmatrix} = \mathbf{0} \tag{E4.11}$$
נרצה למצוא פתרון לא טריוויאלי. דרך אחת לעשות זאת לחשב מתי הדטרמיננטה שווה לאפס. במקרה הכי קיצוני בו ישנה חפיפה מלאה בין השיניים ($\alpha=0$):
$$\begin{pmatrix}
0 & 0 & 1 & 1 & 0 & 1 \\
0 & 0 & -\lambda & \lambda & \lambda & 0 \\
-2 & 0 & \lambda^2 & \lambda^2 & 0 & -\lambda^2 \\
0 & -6 & -\lambda^3 & \lambda^3 & -\lambda^3 & 0 \\
0 & 0 & \lambda^2 e^{-\lambda} & \lambda^2 e^{\lambda} & -\lambda^2 \sin(\lambda) & -\lambda^2 \cos(\lambda) \\
0 & 0 & -\lambda^3 e^{-\lambda} & \lambda^3 e^{\lambda} & -\lambda^3 \cos(\lambda) & \lambda^3 \sin(\lambda)
\end{pmatrix} \begin{pmatrix} b_2 \\ b_3 \\ c_0 \\ c_1 \\ c_2 \\ c_3 \end{pmatrix} = \mathbf{0} \tag{E4.12}$$
לאחר חישוב סימבולי נקבל שהדטרמיננטה מתאפסת כאשר:
$$-24\lambda^{6}(\cos\lambda \cosh\lambda+1)=0 \tag{E4.12}$$
מאחר ונרצה פתרון לא טריוויאלי:
$$\cos\lambda \cosh\lambda+1=0$$
שורשי משוואה זו הם למעשה הע"ע העצמיים של הבעיה. נראה את פונקציה זו על הגרף כדי למצוא את השורשים שלה (ישנם אינסוף, אכפת לנו רק מהראשון):
![[exercise_roots.png|bookhue|600]]^figure-exercise-roots
>פתרון גרפי לשורשי המשוואה האופיינית.

השורש הראשון הוא $\lambda\approx1.8751$.

ריבועי השורשים (הערכים העצמיים) נותנים לנו את המתח הדרוש על מנת להגיע למצב הביפורקציה - $\tilde{V}_{\text{PI}}$. ניתן לראות כי עבור השורש הראשון שקיבלנו המתח הוא:
$$\tilde{V}_{\text{PI}}=\lambda ^{2}=3.516$$
אם נסתכל על הביטוי המנורמל למתח שהשתמשנו בו קודם, נרצה לשמור שהמתח לא יגיע למתח ה-pull-in:
$$\tilde{V}_{\text{PI}}^{2}>\tilde{V}^{2}=24 \dfrac{{\varepsilon}_{0}L^{4}}{Ew^{3}g^{3}}V^{2}$$
בדרך כלל המתח נקבע מתוך דרישות המערכת לתזוזה מסוימת. לאחר שנקבע ערכו של המתח נוכל להשתמש בפרמטר זה כדי לקבל מגבלה על הרוחב $w$:
$$w\geq   \left( 24 \dfrac{{\varepsilon}_{0}L^{4}V^{2}}{Eg^{3}\tilde{V}^{2}_{\text{PI}}} \right)^{1/3}$$

אם אנו מניחים (כמו במרבית ההתקנים) שמתקיים $w\approx g$ נקבל
$$w\geq  \left( 24 \dfrac{{\varepsilon}_{0}L^{4}V^{2}}{E\tilde{V}^{2}_{\text{PI}}} \right)^{1/6}\tag{E4.13}$$