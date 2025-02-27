---
aliases:
---
## שאלה 7

![[MDN1_EEQ Exam Example Questions 2025-02-27 08.15.36.excalidraw.svg]]
>סכמת הריתוך. לא הכי מובן מהשרטוט, אלא אם כן אנחנו נזכרים שאנחנו ב- first angle.

נתונים:
$$\begin{aligned}
 & P=\pu{2500N}, &  & n=2.5 \\[1ex]
 & {S}_{y}=\pu{35.2MPa} \\[1ex]
 & b=\pu{99mm}, &  & d=\pu{123mm}
\end{aligned}$$

נמצא מרכז מסה:
$$\begin{aligned}
 & \bar{x}=\dfrac{b^{2}}{2(b+d)}=\pu{22.1mm} \\[1ex]
 & \bar{y}=\dfrac{d(d/2)+bd}{(b+d)}=\pu{88.9mm}
\end{aligned}$$

מ[[MDN1_C9 טבלאות ריתוכים|טבלה 9-1, מקרה 3]]:
$$\begin{aligned}
 & A^{*}=b+d=\pu{222mm^{}} \\[1ex]
 & {J}_{u}=\dfrac{(b+d)^{4}-6b^{2}d^{2}}{12(b+d)}=\pu{5.78e5mm^{3}}
\end{aligned}$$
במקרה הנתון פועלים על המסגרת כוח גזירה ומומנט פיתול. נחשב אותם עבור מרכז המסה:
$$\begin{aligned}
 & V=P=\pu{2500N} \\[1ex]
 & T=[100+(d-\bar{y})]P=\pu {335.19N.m }
\end{aligned}$$

לכן מאמץ הגזירה עקב הגזירה הטהורה:
$$\begin{aligned}
 & \boldsymbol{\tau}_{V}'^{(*)}= \dfrac{V\mathbf{e}_{2}}{A^{*}}=11.261\mathbf{e}_{2}\,\pu{N.mm^{-1}}
\end{aligned}$$
נבדוק מאמץ גזירה עקב פיתול בנקודות הקיצון השונות. המרחקים שלהם ממרכז הכובד הם:
$$\begin{aligned}
 & \mathbf{r}_{1}=(d-\bar{y})\mathbf{e}_{1}+(b-\bar{x})\mathbf{e}_{2}=-34.1\mathbf{e}_{1}+76.9\mathbf{e}_{2}\,[\pu{mm}] \\[1ex]
 & \mathbf{r}_{2}= (d-\bar{y})\mathbf{e}_{1}-\bar{x}\mathbf{e}_{2}=34.1\mathbf{e}_{1}-22.1\mathbf{e}_{2}\,\pu{[mm]}\\[1ex]
 & \mathbf{r}_{3}=-\bar{y}\mathbf{e}_{1}-\bar{x}\mathbf{e}_{2}=-88.9\mathbf{e}_{1}-22.1\mathbf{e}_{2}\,\pu{[mm]}
\end{aligned}$$
ולכן:
$$\begin{aligned}
 & \boldsymbol{\tau}_{1 T}''^{(*)}=\dfrac{T\mathbf{e}_{3}\times \mathbf{r}_{1}}{{J}_{u}}=-\pu{44.6}\mathbf{e}_{1}+19.8\mathbf{e}_{2}\,\pu{[N.mm^{-1}]} \\[1ex]
 & \boldsymbol{\tau}_{2 T}''^{(*)}=\dfrac{T\mathbf{e}_{3}\times \mathbf{r}_{2}}{{J}_{u}}=12.8\mathbf{e}_{1}+19.8\mathbf{e}_{2}\,\,\pu{[N.mm^{-1}]} \\[1ex]
 & \boldsymbol{\tau}''^{(*)}_{3 T}=\dfrac{T\mathbf{e}_{3}\times \mathbf{r}_{3}}{{J}_{u}}=12.8\mathbf{e}_{1}-51.6\mathbf{e}_{2}\,\pu{[N.mm^{-1}]}
\end{aligned}$$
נשים לב שמבחינת גודל נקודה $1$ הכי מסוכנת. המאמץ הוא:
$$\boldsymbol{\tau}_{1}^{(*)}=\boldsymbol{\tau}'^{(*)}_{V}+\boldsymbol{\tau}_{1T}''^{(*)}=-44.6\mathbf{e}_{1}+31\mathbf{e}_{2}\,\pu{N.mm^{-1}}$$
הגודל שלו:
$$\lvert \boldsymbol{\tau}^{(*)}_{1} \rvert=\pu{54.352N.mm^{-1}} $$
נסיק שנקודה $1$ הכי מסוכנת ולכן, לפי מקדם הביטחון:
$$\begin{gathered}
h=\dfrac{n\sqrt{ 6 } \lvert {\boldsymbol{\tau}}_{\text{1}}^{(*)} \rvert }{{S}_{y}} \\[1ex]
h= \pu{9.5mm}
\end{gathered}$$
לכן נבחר עובי ריתוך $\boxed{\pu{10mm} }$.
