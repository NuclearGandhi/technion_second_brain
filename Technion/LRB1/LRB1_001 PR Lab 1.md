---
aliases: 
title: "PR Lab 1"
---

| **קורס**  | מעבדה מתקדמת לרובוטים |
| --------- | --------------------- |
| מספר קורס | 00340401              |


| עידו פנג בנטוב                 | יובל הנדל                          |
| ------------------------------ | ---------------------------------- |
| 322869140                      | 211828587                          |
| ido.fang@campus.technion.ac.il | yuval.hendel@campus.technion.ac.il |


<div><hr><hr></div>


# עבודות הכנה

הסעיפים הבאים מתייחסים לרובוט Delta אידיאלי בעל שלוש שרשראות קינמטיות זהות. הסימון והמשוואות מבוססים על [[DeltaKin.pdf|DeltaKin]] עבור רובוט Delta עם כניסות סיבוביות. מכיוון שבדף ההנחיות של המעבדה לא ניתנו מידות מספריות, הפיתוח מנוסח באופן סמלי, והגרפים מופקים כדוגמה לפי המידות המספריות שמופיעות ב-DeltaKin. הקוד הנלווה נמצא בקובץ [[LRB1_001/lrb1_delta_kinematics.py]].

## שאלה 1

נחשב את מספר דרגות החופש באמצעות נוסחת גרובלר-קוצבך למנגנון מרחבי:

$$
M = 6\left(n-1-j\right)+\sum_{k=1}^{j} f_k
$$

כאשר $M$ הוא מספר דרגות החופש, $n$ הוא מספר החוליות כולל הקרקע, $j$ הוא מספר המפרקים, ו-$f_k$ הוא מספר דרגות החופש של המפרק ה-$k$.

נשתמש במודל קינמטי שקול לרובוט Delta:

- חוליות: בסיס קבוע, פלטה נעה, שלוש זרועות עליונות, ושלושה מקבילונים תחתונים שקולים. לכן $n=8$.
- מפרקים: שלושה מפרקים סיבוביים מונעים בבסיס, שלושה מפרקים אוניברסליים בין הזרוע העליונה למקבילון, ושלושה מפרקים אוניברסליים בין המקבילון לפלטה הנעה. לכן $j=9$.
- דרגות חופש במפרקים:

$$
\sum f_k = 3\cdot 1 + 6\cdot 2 = 15
$$

נציב:

$$
\begin{aligned}
M & = 6\left(8-1-9\right)+15 \\[1ex]
  & = 6\left(-2\right)+15 \\[1ex]
  & = 3
\end{aligned}
$$

כלומר לרובוט יש שלוש דרגות חופש. שלוש דרגות חופש אלו הן תרגומים של הפלטה הנעה במרחב, כלומר מיקום $x,y,z$. המקבילונים התחתונים מונעים שינוי אוריינטציה של הפלטה, ולכן האוריינטציה $R$ קבועה במודל האידיאלי.

>[!notes] הערה:
>אם סופרים את כל המוטות והמפרקים הכדוריים של המקבילונים בנפרד, מתקבלות דרגות חופש פנימיות מיותרות של סיבוב מוטות סביב צירם. דרגות חופש אלו אינן משפיעות על תנועת הפלטה, ולכן במודל גרובלר מתאים משתמשים במקבילון כחוליה שקולה.

## שאלה 2

נסמן:

- $\{B\}$ - מערכת הצירים הקבועה של הבסיס.
- $\{P\}$ - מערכת הצירים של הפלטה הנעה.
- ${}^{B}\mathbf{P}=\begin{pmatrix}x&y&z\end{pmatrix}^{T}$ - מיקום ראשית $\{P\}$ במערכת $\{B\}$.
- ${}^{B}R_P=I$ - האוריינטציה של הפלטה קבועה וזהה לאוריינטציה של הבסיס.
- $s_B$ - אורך צלע משולש הבסיס.
- $s_P$ - אורך צלע משולש הפלטה.
- $L$ - אורך הזרוע העליונה.
- $l$ - אורך הזרוע התחתונה השקולה, כלומר האורך המרכזי של המקבילון.
- $h$ - רוחב המקבילון.
- ${}^{B}\mathbf{B}_i$ - נקודת המפרק הסיבובי בבסיס.
- ${}^{B}\mathbf{A}_i$ - נקודת הברך, כלומר קצה הזרוע העליונה.
- ${}^{P}\mathbf{P}_i$ - נקודת חיבור המקבילון לפלטה, כתובה במערכת $\{P\}$.

עבור משולשים שווי צלעות נגדיר את הגדלים הגאומטריים:

$$
\begin{aligned}
w_B &= \frac{\sqrt{3}}{6}s_B,
&
u_B &= \frac{\sqrt{3}}{3}s_B,
\\[1ex]
w_P &= \frac{\sqrt{3}}{6}s_P,
&
u_P &= \frac{\sqrt{3}}{3}s_P
\end{aligned}
$$

נקודות החיבור בבסיס הן:

$$
\begin{aligned}
{}^{B}\mathbf{B}_1 &=
\begin{pmatrix}
0\\
-w_B\\
0
\end{pmatrix},
&
{}^{B}\mathbf{B}_2 &=
\begin{pmatrix}
\frac{\sqrt{3}}{2}w_B\\
\frac{1}{2}w_B\\
0
\end{pmatrix},
&
{}^{B}\mathbf{B}_3 &=
\begin{pmatrix}
-\frac{\sqrt{3}}{2}w_B\\
\frac{1}{2}w_B\\
0
\end{pmatrix}
\end{aligned}
$$

ונקודות החיבור בפלטה הן:

$$
\begin{aligned}
{}^{P}\mathbf{P}_1 &=
\begin{pmatrix}
0\\
-u_P\\
0
\end{pmatrix},
&
{}^{P}\mathbf{P}_2 &=
\begin{pmatrix}
\frac{1}{2}s_P\\
w_P\\
0
\end{pmatrix},
&
{}^{P}\mathbf{P}_3 &=
\begin{pmatrix}
-\frac{1}{2}s_P\\
w_P\\
0
\end{pmatrix}
\end{aligned}
$$

נשתמש גם בקבועים:

$$
\begin{aligned}
a &= w_B-u_P \\[1ex]
b &= \frac{1}{2}s_P-\frac{\sqrt{3}}{2}w_B \\[1ex]
c &= w_P-\frac{1}{2}w_B
\end{aligned}
$$

וקטורי הזרועות העליונות הם:

$$
\begin{aligned}
{}^{B}\mathbf{L}_1 &=
\begin{pmatrix}
0\\
-L\cos\theta_1\\
-L\sin\theta_1
\end{pmatrix},
&
{}^{B}\mathbf{L}_2 &=
\begin{pmatrix}
\frac{\sqrt{3}}{2}L\cos\theta_2\\
\frac{1}{2}L\cos\theta_2\\
-L\sin\theta_2
\end{pmatrix},
&
{}^{B}\mathbf{L}_3 &=
\begin{pmatrix}
-\frac{\sqrt{3}}{2}L\cos\theta_3\\
\frac{1}{2}L\cos\theta_3\\
-L\sin\theta_3
\end{pmatrix}
\end{aligned}
$$

משוואת הסגירה לכל רגל היא:

$$
{}^{B}\mathbf{B}_i
+
{}^{B}\mathbf{L}_i
+
{}^{B}\mathbf{l}_i
=
{}^{B}\mathbf{P}
+
{}^{B}R_P\,{}^{P}\mathbf{P}_i,
\qquad
i=1,2,3
$$

מכיוון שאורך הזרוע התחתונה קבוע:

$$
\left\|{}^{B}\mathbf{l}_i\right\|^2=l^2
$$

הצבה ופישוט נותנים לכל רגל משוואה מהצורה של DeltaKin:

$$
E_i\cos\theta_i+F_i\sin\theta_i+G_i=0,
\qquad
i=1,2,3
$$

כאשר:

$$
\begin{aligned}
E_1 &= 2L(y+a) \\[1ex]
F_1 &= 2zL \\[1ex]
G_1 &= x^2+y^2+z^2+a^2+L^2+2ya-l^2
\end{aligned}
$$

$$
\begin{aligned}
E_2 &= -L\left(\sqrt{3}(x+b)+y+c\right) \\[1ex]
F_2 &= 2zL \\[1ex]
G_2 &= x^2+y^2+z^2+b^2+c^2+L^2+2(xb+yc)-l^2
\end{aligned}
$$

$$
\begin{aligned}
E_3 &= L\left(\sqrt{3}(x-b)-y-c\right) \\[1ex]
F_3 &= 2zL \\[1ex]
G_3 &= x^2+y^2+z^2+b^2+c^2+L^2+2(-xb+yc)-l^2
\end{aligned}
$$

נפתור בעזרת הצבת חצי זווית:

$$
t_i=\tan\left(\frac{\theta_i}{2}\right),
\qquad
\cos\theta_i=\frac{1-t_i^2}{1+t_i^2},
\qquad
\sin\theta_i=\frac{2t_i}{1+t_i^2}
$$

לאחר הצבה:

$$
(G_i-E_i)t_i^2+2F_i t_i+(G_i+E_i)=0
$$

ולכן:

$$
t_i=
\frac{
-F_i\pm\sqrt{E_i^2+F_i^2-G_i^2}
}{
G_i-E_i
}
$$

ולבסוף:

$$
\boxed{
\theta_i=2\tan^{-1}(t_i)
}
$$

ריבוי הפתרונות נובע מהסימן $\pm$. מכל רגל מתקבלים שני פתרונות אפשריים, ולכן תאורטית יש עד $2^3=8$ ענפים. בדומה ל-DeltaKin, בוחרים בדרך כלל את הענף שבו כל הברכיים פונות החוצה.

## שאלה 3

בקינמטיקה הישירה נתונים ערכי המנועים $\theta_1,\theta_2,\theta_3$, ומחפשים את מיקום הפלטה $\mathbf{x}$.

עבור כל זרוע מחשבים תחילה את נקודת הברך:

$$
\begin{aligned}
{}^{B}\mathbf{A}_1 &=
\begin{pmatrix}
0\\
-w_B-L\cos\theta_1\\
-L\sin\theta_1
\end{pmatrix}
\\[2ex]
{}^{B}\mathbf{A}_2 &=
\begin{pmatrix}
\frac{\sqrt{3}}{2}(w_B+L\cos\theta_2)\\
\frac{1}{2}(w_B+L\cos\theta_2)\\
-L\sin\theta_2
\end{pmatrix}
\\[2ex]
{}^{B}\mathbf{A}_3 &=
\begin{pmatrix}
-\frac{\sqrt{3}}{2}(w_B+L\cos\theta_3)\\
\frac{1}{2}(w_B+L\cos\theta_3)\\
-L\sin\theta_3
\end{pmatrix}
\end{aligned}
$$

מכיוון שהפלטה אינה מסתובבת, אפשר להגדיר מרכזי כדורים וירטואליים:

$$
{}^{B}\mathbf{A}_{iv}
=
{}^{B}\mathbf{A}_i
-
{}^{P}\mathbf{P}_i
$$

נקודת הפלטה ${}^{B}\mathbf{P}$ היא חיתוך של שלושה כדורים:

$$
\left\|{}^{B}\mathbf{P}-{}^{B}\mathbf{A}_{iv}\right\|^2=l^2,
\qquad
i=1,2,3
$$

כלומר:

$$
\left({}^{B}\mathbf{A}_{1v},l\right)
\cap
\left({}^{B}\mathbf{A}_{2v},l\right)
\cap
\left({}^{B}\mathbf{A}_{3v},l\right)
$$

אפשר לפתור את חיתוך שלושת הכדורים באופן אנליטי. דרך נוחה היא לחסר את משוואת הכדור הראשון מהשנייה ומהשלישית, וכך לקבל שתי משוואות לינאריות שמגדירות ישר:

$$
{}^{B}\mathbf{P}\left(\lambda\right)
=
{}^{B}\mathbf{P}_0+\lambda\hat{\mathbf{n}}
$$

לאחר מכן מציבים במשוואת הכדור הראשון ומקבלים משוואה סקלרית יחידה:

$$
g\left(\lambda\right)
=
\left\|{}^{B}\mathbf{P}_0+\lambda\hat{\mathbf{n}}-{}^{B}\mathbf{A}_{1v}\right\|^2
-
l^2
=0
$$

בדרך כלל מתקבלים שני פתרונות מתמטיים לחיתוך הכדורים. הפתרון הפיזיקלי של רובוט Delta הוא בדרך כלל זה שנמצא מתחת לבסיס, כלומר בעל ערך $z$ נמוך יותר.

## שאלה 4

הפונקציות בקובץ [[LRB1_001/lrb1_delta_kinematics.py]] הן:

- `inverse_kinematics(x, y, z, params, branch=-1)` - מקבלת מיקום במרחב ומחזירה את שלושת ערכי המנועים.
- `inverse_efg(x, y, z, params)` - מחזירה את מקדמי $E_i,F_i,G_i$ לפי DeltaKin.
- `forward_kinematics(theta1, theta2, theta3, params, solution="lower_z")` - מקבלת שלושה ערכי מנועים ומחזירה את מיקום הפלטה.
- `plot_axis_motion(axis, start, stop, samples, fixed, params, branch=-1, output_path=None)` - מציגה או שומרת גרפים של ערכי המנועים לאורך תנועה בציר יחיד.
- `save_requested_graphs(output_dir, params=None)` - שומרת את שלושת הגרפים הנדרשים עבור תנועה לאורך $X,Y,Z$.

שמות הפרמטרים בקוד תואמים לסימון ב-DeltaKin: $L,l,h,s_B,s_P$. הפונקציות `w_B`, `u_B`, `w_P`, `u_P`, `a`, `b`, `c`, וכן הנקודות ${}^{B}\mathbf{B}_i$ ו-${}^{P}\mathbf{P}_i$, מחושבות מתוך פרמטרים אלו.

## שאלה 5

כדי לקבל גרפים עבור תנועה לאורך ציר יחיד, בוחרים נקודת עבודה קבועה ומשנים רק קואורדינטה אחת בכל פעם.

תנועה לאורך ציר $X$:

$$
\mathbf{x}\left(s\right)
=
\begin{pmatrix}
s\\
y_0\\
z_0
\end{pmatrix}
$$

תנועה לאורך ציר $Y$:

$$
\mathbf{x}\left(s\right)
=
\begin{pmatrix}
x_0\\
s\\
z_0
\end{pmatrix}
$$

תנועה לאורך ציר $Z$:

$$
\mathbf{x}\left(s\right)
=
\begin{pmatrix}
x_0\\
y_0\\
s
\end{pmatrix}
$$

עבור כל ערך של $s$ מחשבים את:

$$
\boldsymbol{\theta}\left(s\right)
=
\begin{pmatrix}
\theta_1\left(s\right)\\
\theta_2\left(s\right)\\
\theta_3\left(s\right)
\end{pmatrix}
$$

ומציגים שלושה גרפים: $\theta_1,\theta_2,\theta_3$ כתלות ב-$s$. בקוד הנלווה הפונקציה `plot_axis_motion` מבצעת את החישוב וההדפסה.

הגרפים הבאים הופקו באמצעות ערכי הדוגמה של ABB FlexPicker IRB 360-1/1600 מתוך DeltaKin:

$$
\begin{aligned}
s_B &= \pu{567 mm} \\[1ex]
s_P &= \pu{76 mm} \\[1ex]
L &= \pu{524 mm} \\[1ex]
l &= \pu{1244 mm} \\[1ex]
h &= \pu{131 mm}
\end{aligned}
$$

לאחר מדידת הרובוט במעבדה יש לעדכן את `example_params` או להעביר `DeltaParams` עם הערכים האמיתיים.

![[LRB1_001/figures/lrb1_delta_motion_x.png|bookhue|600]]^figure-lrb1-delta-motion-x
>זוויות המנועים עבור תנועה לאורך ציר $X$, לפי ערכי הדוגמה של DeltaKin.

![[LRB1_001/figures/lrb1_delta_motion_y.png|bookhue|600]]^figure-lrb1-delta-motion-y
>זוויות המנועים עבור תנועה לאורך ציר $Y$, לפי ערכי הדוגמה של DeltaKin.

![[LRB1_001/figures/lrb1_delta_motion_z.png|bookhue|600]]^figure-lrb1-delta-motion-z
>זוויות המנועים עבור תנועה לאורך ציר $Z$, לפי ערכי הדוגמה של DeltaKin.

## שאלה 6

התכנית המתועדת נמצאת בקובץ [[LRB1_001/lrb1_delta_kinematics.py]]. כדי להפיק כל אחת מהתנועות משנים רק את הפרמטר `axis` בקריאה לפונקציה:

- עבור תנועה בציר $X$: `axis="x"`.
- עבור תנועה בציר $Y$: `axis="y"`.
- עבור תנועה בציר $Z$: `axis="z"`.

בנוסף יש לבחור את `start`, `stop`, `samples`, ואת נקודת העבודה הקבועה `fixed`. הגרפים המשובצים לעיל נוצרו באמצעות `save_requested_graphs(Path(__file__).with_name("figures"))`.

## שאלה 7

רובוט Delta נפוץ במשימות שבהן נדרשת תנועה מהירה ומדויקת של יחידת קצה קלה.

>[!example] דוגמאות:
>- מיון והרמה של מוצרים על מסוע.
>- השמה מהירה של רכיבים אלקטרוניים קטנים.
>- אריזה ומיון של תרופות או מוצרים רפואיים.
>- הדפסה תלת-ממדית או פעולות עיבוד קלות שבהן נדרשת מסה נעה קטנה.

היתרונות העיקריים של הרובוט לשימושים אלו הם:

- מסה נעה קטנה, מפני שהמנועים נמצאים על הבסיס ולא על הפלטה הנעה.
- מהירות ותאוצה גבוהות.
- קשיחות טובה יחסית למבנה קל.
- חזרתיות טובה במשימות Pick and place.
- מבנה סימטרי שמאפשר שליטה נוחה בשלוש דרגות חופש.
