---
aliases:
---
# 2021 מועד א'
## תרגיל 1
נתונה הפונקציה $y=\sin ^{2}x$. נרצה למצוא את הנקודות שהפונקציה מתאפסת (נניח שהפתרון לא ידוע).
1. רשמו צעד איטרציה אחד עבור שיטת ניוטון רפסון, עבור ניחוש התחלתי של ${x}_{0}=0.3$.
2. האם שיטת החצייה מתאימה לבעיה זו?
3. אפיינו את ההתכנסות של השיטה ליד הפתרון עבור שיטת ניוטון רפסון (סדר התכנסות). יש להוכיח את התוצאה.

### סעיף א'
נרצה למצוא מתי מתקיים
$$f(x)\equiv \sin ^{2}(x)=0$$
בעזרת [[NUM1_005 משוואות לא לינאריות במשתנה אחד|שיטת ניוטון]].
נמצא את הנגזרת של הפונקציה (באופן אנליטי):
$$f'(x)=2\cos x\sin x$$
הנוסחה לשיטה האיטרטיבית:
$$\begin{aligned}
x_{k+1} & =x_{k}-\dfrac{f(x_{k})}{f'(x_{k})} \\[1ex]
 & =x_{k}-\dfrac{\sin ^{2}(x_{k})}{2\cos x_{k}\sin x_{k}} \\[1ex]
 & =x_{k}-\dfrac{\sin x_{k}}{2\cos x_{k}}
\end{aligned}$$
נתחיל עם ${x}_{0}=0.3$:
$$\begin{aligned}
{x}_{1} & ={x}_{0}-\dfrac{\sin {x}_{0}}{2\cos {x}_{0}} \\[1ex]
 & =0.3-\dfrac{\sin (0.3)}{2\cos (0.3)} \\[1ex]
 & = \boxed {
0.1453
 }
\end{aligned}$$

### סעיף ב'
שיטת החצייה מתאימה לכל בעיה עם פונקציה רציפה בעלת ערכים שליליים וחיוביים. מאחר ו- $y=\sin ^{2}x$ אי שלילית בכל תחום הגדרתה, שיטת החצייה לא מתאימה לבעיה זו.

### סעיף ג'
נרצה למצוא את $\dfrac{e_{n+1}}{e_{n}}$:
$$\begin{aligned}
\dfrac{e_{n+1}}{e_{n}} & =\dfrac{\left|x_{k+1}-x^{*}\right|}{\left|x_{k}-x^{*}\right|} \\
\end{aligned}$$
הפתרון האמיתי הוא $x^{*}=0$ (זהו הפתרון שמכוונים אליו בשאלה). נציב אותו ואת הנוסחה שקיבלנו בסעיף הקודם עבור $x_{k+1}$:
$$\begin{aligned}
\dfrac{e_{n+1}}{e_{n}} & =\dfrac{\left|x_{k}-\dfrac{\sin x_{k}}{2\cos x_{k}}\right|}{\left|x_{k}\right|} \\[1ex]
\end{aligned}$$
ליד הפתרון, כלומר ליד $x^{*}=0$, נוכל לבצע את ההנחות הבאות:
$$\begin{aligned}
\sin x\approx x &  & \cos x\approx 1
\end{aligned}$$
נציב ונקבל:
$$\begin{aligned}
\dfrac{e_{n+1}}{e_{n}} & =\dfrac{\left|x_{k}-\dfrac{x_{k}}{2}\right|}{\left|x_{k}\right|} \\[1ex]
 & =\dfrac{1}{2}
\end{aligned}$$
נסיק כי קצב ההתכנסות של השיטה ליד הפתרון הוא לינארי.

## תרגיל 2
נתונה מערכת משוואות $A\bar{x}=b$, כאשר:
$$\begin{aligned}
A=\begin{pmatrix}
3 & -\dfrac{1}{2} & \dfrac{3}{2} \\[1ex]
1 & 4 & \dfrac{4}{3} \\[1ex]
\dfrac{5}{2} & \dfrac{10}{3} & 5
\end{pmatrix} &  & b=\begin{pmatrix}
2 \\
1 \\
0
\end{pmatrix}
\end{aligned}$$
נרצה לפתור את הבעיה בעזרת שיטת יעקובי.
1. הוכיחו שמטריצה המקיימת את התכונה הבאה לכל $j$:
	$$\sum_{\begin{gathered}
i=1 \\
i\neq j
\end{gathered}}^{N}\left|\frac{a_{ij}}{a_{ii}} \right|<1 $$
מתכנסת בשיטה יעקובי (רמז: נורמה $\ell_{1}$).
2. בדקו אם יש התכנסות עבור המטריצה $A$.
3. בצעו איטרציה אחת עבור הניחוש ההתחלתי ${x}_{0}=\begin{pmatrix}1\\0\\0\end{pmatrix}$.
4. מצאו חסם למספר האיטרציות הדרושות כדי שנורמת השגיאה בוקטור הפתרון תהיה קטנה מ-$10^{-5}$. כלומר:
	$$\dfrac{\| x_{n}-x^{*}\|_{}}{\| {x}_{0}-x^{*}\|_{}}<10^{-5}$$
	כאשר $n$ מסמן את מספר האיטרציה, ו-$x^{*}$ הוא הפתרון המדויק.

### סעיף א'
תהי מטריצה ריבועית כללית $A\in \mathbb{R}^{n\times n}$. נסמן:
$$G=I-D^{-1}A$$
כאשר $D$ היא מטריצה המכילה רק את האלכסון של $A$.

נמצא את הנורמה $\ell_{1}$ של $G$:
$$\begin{aligned}
\| \begin{gathered}
G
\end{gathered}\|_{1} & =\max_{1\leq j\leq n}\sum_{i=1}^{n}\left|g_{ij}\right| \\
\end{aligned}$$
מעצם הגדרת $G$ מתקיים:
$$g_{ij}=\delta_{ij}-\dfrac{1}{a_{ii}}a_{ij}$$
כאשר $\delta_{ij}$ היא ה[[../SLD2/SLD2_001 טנזור המאמץ#הדלתא של קרונר|הדלתא של קרונקר]] (סתם נוח לסמן ככה). נציב בחזרה בביטוי עבור הנורמה כדי לקבל:
$$\begin{aligned}
\| G\|
_{1} & =\max_{1\leq j\leq n}\sum_{i=1}^{n}\left|\delta_{ij}-\dfrac{1}{a_{ii}}a_{ij}\right|
\end{aligned} 
$$
נפרק את פעולת הסכימה למקרים בהם $i=j$ ולמקרים בהם $i\neq j$:
$$\begin{aligned}
\| G\|_{1} & =\max_{1\leq j\leq n}\sum_{\begin{gathered}
i=1 \\
i=j
\end{gathered}}^{n}\left|\cancel{ 1-\dfrac{a_{ii}}{a_{ii}} }\right|+\sum_{\begin{gathered}
i=1 \\
i\neq j
\end{gathered}}^{n}\left|\cancel{ \delta_{ij} }-\dfrac{a_{ij}}{a_{ii}}\right| \\[2ex]
 & =\max_{i\leq j\leq n}\sum_{\begin{gathered}
i=1 \\
i\neq j
\end{gathered}}^{n} \left|\dfrac{a_{ij}}{a_{ii}}\right|
\end{aligned}$$
נציב את התכונה הנתונה:
$$\| G\|_{1}<\max_{i\leq j\leq n}(1)\leq 1$$
האי שוויון שקיבלנו הוא תנאי מספיק להתכנסות של שיטת יעקובי עבור מטריצה $A$.
$$\mathrm{ל.ש.מ} \quad \quad \quad \quad \quad \quad \quad \quad \quad \quad \quad \quad \quad \quad \quad \quad \quad \quad \quad \quad \quad \quad \quad \quad$$

### סעיף ב'
נבדוק אם המטריצה $A$ מקיימת את התכונה לעיל.
$$\begin{aligned} \\
 & j=1: &  & 
\sum_{\begin{gathered}
i=1 \\
i\neq j
\end{gathered}}^{n}\left|\dfrac{a_{ij}}{a_{ii}}\right| = \left|\dfrac{a_{21}}{a_{22}}\right|+\left|\dfrac{a_{31}}{a_{33}}\right|=\dfrac{1}{4}+\dfrac{5}{10}\overset{ \checkmark  }{ < }1 \\[2ex]
 & j=2: &  & \sum_{\begin{gathered}
i=1 \\
i\neq j
\end{gathered}}^{n}\left|\dfrac{a_{ij}}{a_{ii}}\right| = \left| \dfrac{a_{12}}{a_{11}} \right|+\left| \dfrac{a_{32}}{{a}_{33}} \right|=\dfrac{1}{6}+\dfrac{10}{15}\overset{ \checkmark  }{ < }1 \\[2ex]
 & j=3: &  & \sum_{\begin{gathered}
i=1 \\
i\neq j
\end{gathered}}^{n}\left|\dfrac{a_{ij}}{a_{ii}}\right| = \left| \dfrac{a_{13}}{a_{11}} \right|+\left| \dfrac{a_{23}}{a_{22}} \right|=\dfrac{3}{6}+\dfrac{4}{12}\overset{ \checkmark  }{ < }1
\end{aligned}$$
קיבלנו ש-$A$ מקיימת את התכונה ולכן לפי סעיף א', יש התכנסות עבור שיטת יעקובי עם מטריצה $A$.

### סעיף ג'
הנוסחה לשיטת יעקובי:
$$x_{i}^{k+1}=x_{i}^{k}+\dfrac{1}{a_{ii}}\left( b_{i}-\sum_{j=1}^{n}a_{ij}x_{j}^{k}  \right)$$
נציב את הנתונים שלנו, עם תנאי ההתחלה $x^{(0)}=\begin{pmatrix}1\\0\\0\end{pmatrix}$:
$$\begin{aligned}
 & x_{1}^{(1)}={x}_{1}^{(0)}+\dfrac{1}{{a}_{11}}\left( {b}_{1}-\sum_{j=1}^{n}a_{1j}x_{j}^{(0)}  \right) =1+\dfrac{1}{3}[2-(3\cdot 1+0+0)]=\dfrac{2}{3} \\
 & {x}_{2}^{(1)}={x}_{2}^{(0)}+\dfrac{1}{{a}_{22}}\left( {b}_{2}-\sum_{j=1}^{n}a_{2j}x_{j}^{(0)}  \right)=0+\dfrac{1}{4}\left[ 1-\left( 1\cdot 1+0+0 \right) \right]=0\\
 & {x}_{3}^{(1)}={x}_{3}^{(0)}+\dfrac{1}{{a}_{33}}\left( {b}_{3}-\sum_{j=1}^{n}a_{3j}x_{j}^{(0)}  \right)=0+\dfrac{1}{5}\left[ 0-\left( \dfrac{5}{2}\cdot 1+0+0 \right) \right]=-\dfrac{1}{2}
\end{aligned}$$
קיבלנו ש:
$$\boxed{x^{(1)}=\begin{pmatrix}
\dfrac{2}{3} \\[1ex]
0 \\[1ex]
-\dfrac{1}{2}
\end{pmatrix} }$$

### סעיף ד'
נרצה למצוא את קצב ההתכנסות של השיטה. כלומר, נדרש למצוא את $\| G\|$.
$$\begin{aligned}
G & =I-D^{-1}A \\[2ex]
 & =I-\begin{pmatrix}
\dfrac{1}{3} & 0 & 0 \\
0 & \dfrac{1}{4} & 0 \\
0 & 0 & \dfrac{1}{5}
\end{pmatrix}\begin{pmatrix}
3 & -\dfrac{1}{2} & \dfrac{3}{2} \\[1ex]
1 & 4 & \dfrac{4}{3} \\[1ex]
\dfrac{5}{2} & \dfrac{10}{3} & 5
\end{pmatrix} \\[2ex]
 & =I-\begin{pmatrix}
1 & -\dfrac{1}{6} & \dfrac{1}{2} \\[1ex]
\dfrac{1}{4} & 1 & \dfrac{1}{3} \\[1ex]
\dfrac{1}{2} & \dfrac{2}{3} & 1
\end{pmatrix} \\[2ex]
 & =-\begin{pmatrix}
0 & -\dfrac{1}{6} & \dfrac{1}{2} \\[1ex]
\dfrac{1}{4} & 0 & \dfrac{1}{3} \\[1ex]
\dfrac{1}{2} & \dfrac{2}{3} & 0
\end{pmatrix}
\end{aligned}$$
הנורמה-$1$ שלה יהיה:
$$\begin{aligned}
\| G\|_{1} & =\max_{}\left( \dfrac{1}{4}+\dfrac{1}{2},\, \dfrac{1}{6}+\dfrac{2}{3},\, \dfrac{1}{2}+\dfrac{1}{3} \right) \\
 & =\dfrac{5}{6}
\end{aligned}$$
מ[[NUM1_004 שיטות איטרטיביות לפתרון מערכות לינאריות#התכנסות שיטות איטרטיביות למערכות לינאריות|ההרצאה]], ראינו שניתן לשער את קצב ההתכנסות ע"י הנורמה:
$$\dfrac{\| e_{n}\|}{\| e_{0}\|}=\dfrac{\| x_{n}-x^{*}\|_{}}{\| {x}_{0}-x^{*}\|_{}}\approx \| G\|^{n}$$
נרצה לדעת מתי הביטוי הימני שווה ל-$10^{-5}$. נשווה ונציב את הערך שמצאנו עבור הנורמה-$1$ של $G$:
$$\begin{gathered}
\left( \dfrac{5}{6} \right)^{n}=10^{-5} \\
n\log\left( \dfrac{5}{6} \right)=-5 \\
n\approx 63.146
\end{gathered}$$
כלומר, נדרש לבצע יותר מ- $\boxed{N=63 }$ איטרציות כדי לקבל שנורמת השגיאה שלנו תהיה קטנה מ-$10^{-5}$.


## תרגיל 3
נתונה משוואה דיפרנציאלית:
$$\dfrac{\mathrm{d}^{2}y}{\mathrm{d}x^{2}}+\dfrac{\mathrm{d}y}{\mathrm{d}x}-x^{2}=0$$
עם התנאי שפה:
$$\begin{aligned}
y(0)=1 &  & y(1)=2
\end{aligned}$$
בשאלה זו נפתור את הבעיה שיטת הפרשים סופיים באמצעות הפרשים מרכזיים בעלי דיוק מסדר שני בצעד $h=0.2$ ובתחום $[0,1]$.

1. רשמו את המשוואות המתקבלות ע"י שיטת ההפרשים הסופיים.
2. בטאו את המשוואות באופן מטריצי.
3. נניח שכעת, נרצה לפתור את הבעיה עם צעד בגודל $h=\dfrac{1}{N}$. העריכו את הסיבוכיות כתלות ב-$N$. כלומר, אם הסיבוכיות היא $O(N^{a})$ מצאו את $a$.

### סעיף א'

[[NUM1_010 גזירה נומרית#שיטה בשלוש נקודות|שיטת ההפרשים המרכזיים]] עבור נגזרת ראשונה:
$$y_{i}'=\dfrac{y_{i+1}-y_{i-1}}{2h}+\mathcal{O}(h^{2})$$
עבור נגזרת שנייה:
$$y''_{i}=\dfrac{y_{i+1}-2y_{i}+y_{i-1}}{h^{2}}+\mathcal{O}(h^{2})$$
נציב במשוואה הדיפרנציאלית, כאשר נשים לב שכעת $x=x_{i}$:
$$\begin{gathered}
\dfrac{y_{i+1}-2y_{i}+y_{i-1}}{h^{2}}+\dfrac{y_{i+1}-y_{i-1}}{2h}-x_{i}^{2}=0 \\[1ex]
y_{i+1}-2y_{i}+y_{i-1}+\dfrac{h}{2}(y_{i+1}-y_{i-1})-h^{2}x_{i}^{2}=0 \\[1ex]
\left( 1+\dfrac{h}{2} \right)y_{i+1}-2y_{i}+\left( 1-\dfrac{h}{2} \right)y_{i-1}=h^{2}x_{i}^{2}
\end{gathered}$$
נציב $h=0.2$ ונקבל את הבעיה:
$$
\begin{aligned}
 & 1.1y_{i+1}-2y_{i}+0.9 y_{i-1}=0.04x^{2}_{i}
\end{aligned}
 $$
נחלק את הקטע $[0,1]$ ל-$n$ קטעים באורך $h=0.2$. לכן:
$$x_{i}=0+hi=0.2i$$
נציב במשוואה:
$$1.1y_{i+1}-2y_{i}+0.9 y_{i-1}=0.04(0.2i)^{2}=0.000016i^{2}$$
נוכל כעת לבנות את מערכת המשוואות:
 $$\begin{aligned}
 & i=1: &  & 1.1{y}_{0}-2{y}_{1}+0.9y_{2}=0.000016 \\
 & i=2: &  & 1.1{y}_{1}-2{y}_{2}+0.9{y}_{3}=0.000064 \\
 & i=3: &  & 1.1{y}_{2}-2{y}_{3}+0.9{y}_{4}=0.000144 \\
 & i=4: &  & 1.1{y}_{3}-2{y}_{4}+0.9{y}_{5}=0.000256 \\
\end{aligned}$$
מתנאי השפה, אנו יכולים להסיק ש- ${y}_{0}=1$ ו- ${y}_{5}=2$. נציב במערכת משוואות ונקבל:
$$\boxed {
\begin{aligned}
 & i=1: &  & 2{y}_{1}+0.9y_{2}=-1.099984 \\
 & i=2: &  & 1.1{y}_{1}-2{y}_{2}+0.9{y}_{3}=0.000064 \\
 & i=3: &  & 1.1{y}_{2}-2{y}_{3}+0.9{y}_{4}=0.000144 \\
 & i=4: &  & 1.1{y}_{3}-2{y}_{4}=-1.799744 \\
\end{aligned}
 }$$

### סעיף ב'
באופן מטריצי:
$$\boxed {
\begin{pmatrix}
2 & 0.9 &  &  \\
1.1 & -2 & 0.9 &  \\
0 & 1.1 & -2 & 0.9 \\
 &  & 1.1 & -2
\end{pmatrix}\begin{pmatrix}
{y}_{1} \\
{y}_{2} \\
{y}_{3} \\
{y}_{4}
\end{pmatrix}=\begin{pmatrix}
-1.099984 \\
0.000064 \\
0.000144 \\
-1.799744
\end{pmatrix}
 }$$

### סעיף ג'
את הבעיה אנו בסוף ממירים למערכת משוואות לינארית שניתן לפתור בעזרת שיטת תומס, עם מטריצה מסדר $(N-1)\times(N-1)$ עבור $h=\dfrac{1}{N}$. שיטה זו היא בעלת סיבוכיות $O(N-1)\sim O(N)$. לכן:
$$\boxed{a=1 }$$


## תרגיל 4
בשאלה זו סעיפים ג', ד' לא תלויים בסעיפים א',ב'.
1. נתון האינטגרל:
	$$I=\int_{0}^{h} f(x)e^{-x} \, \mathrm{d}x $$
	פתחו שיטת אינטגרציה שמדויקת לכל $f(x)$ שהוא פולינום מסדר ראשון:
	$$I=\int_{0}^{h} f(x)\exp(-x) \, \mathrm{d}x ={C}_{0}f(0)+{C}_{1}f(h)+E$$
	כלומר, חשבו את ${C}_{0},{C}_{1}$.
2. העריכו את השגיאה $E$ כאשר $h$ קטן. רשמו את האיבר המוביל $ch^{m}$ וחשבו את $m,c$. האם השגיאה גדולה או קטנה ביחס לשיטות המבוססות על אינטרפולציה פולינומית של $f(x)e^{-x}$ באותם הנקודות?
3. פתרו את האינטגרל
	$$\int_{0}^{0.2} g(x) \, \mathrm{d}x $$
	בעזרת גאוס לז'נדר מסדר $3$, כאשר $g(x)=\exp(-x^{2})$.
4. עבור איזה סדר של פולינום $g(x)$ התוצאה מדויקת?

אינטגרלי עזר:
$$\begin{aligned}
 & \int_{0}^{h} \exp(-x) \, \mathrm{d}x=1-e^{-h} \\
 & \int_{0}^{h} x\exp(-x) \, \mathrm{d}x=1-(1+h)e^{-h} \\
 & \int_{0}^{h} x^{2}\exp(-x) \, \mathrm{d}x=2-(h^{2}+2h+2)e^{-h}  
\end{aligned}$$

### סעיף א'
נשתמש בשיטת המקדמים החופשיים. נבצע אינטגרציה על מרחב הפולינומים מסדר $1$ - $\{ 1,x \}$:
$$\begin{aligned}
 & f(x)=1: &  & \int_{0}^{h} 1\cdot e^{-x} \, \mathrm{d}x=1-e^{-h} \\[1ex]
 &  &   &\quad \quad \implies 1-e^{-h}={C}_{0}+{C}_{1} \\[2ex]
 & f(x)=x: &  & \int_{0}^{h} x\cdot e^{-x} \, \mathrm{d}x =1-(1+h)e^{-h} \\[1ex]
 &  &  & \quad \quad\implies 1-(1+h)e^{-h}=h{C}_{1}
\end{aligned}$$
קיבלנו את מערכת המשוואות:
$$\begin{aligned}
 & {C}_{0}+{C}_{1}=1-e^{-h} \\
 & h{C}_{1}=1-(1+h)e^{-h}
\end{aligned}$$
מהמשוואה השנייה קל לראות כי:
$${C}_{1}=\dfrac{1}{h}[1-(1+h)e^{-h}]$$
נציב במשוואה הראשונה ונקבל:
$$\begin{gathered}
{C}_{0}+\dfrac{1}{h}[1-(1+h)e^{-h}]=1-e^{-h} \\[1ex]
{C}_{0}=1-e^{-h}-\dfrac{1}{h}+\dfrac{1+h}{h}e^{-h} \\[1ex]
{C}_{0}=1\cancel{ -e^{-h} }-\dfrac{1}{h}+\dfrac{1}{h}e^{-h}+\cancel{ e^{-h} } \\[1ex]
{C}_{0}=1+\dfrac{1}{h}(e^{-h}-1)
\end{gathered}$$
לסיכום:
$$\boxed {
I=\int_{0}^{h} f(x)e^{-x} \, \mathrm{d}x =\left[ 1+\dfrac{1}{h}(e^{-h}-1) \right]f(0)+\dfrac{1}{h}[1-(1+h)e^{-h}]f(h)+E
 }$$

### סעיף ב'
השגיאה $E$ נתונה ע"י:
$$E=I-\tilde{I}$$
כאשר $\tilde{I}$ הוא השיעור שלנו לפתרון. ראשית נפתח את הביטוי של $f(x)$ ב-$I$ בעזרת [[../CAL1/CAL1_006 פולינום טיילור#פולינום טיילור|טור טיילור]] קרוב לנקודה $x=0$ (ככה שזה בעצם טור מקלורן):
$$\begin{aligned}
I & =\int_{0}^{h} f(x)e^{-x} \, \mathrm{d}x \\
 & = \int_{0}^{h}\left( f(0)+xf'(0)+\dfrac{1}{2}x^{2}f''({\xi}_{1}) \right)e^{-x} \, \mathrm{d}x 
\end{aligned}$$
כאשר $0<{\xi}_{1}<h$. נמשיך עם האינטגרציה, כאשר ניעזר באינטגרלי עזר:
$$\begin{aligned}
I & =f(0)\int_{0}^{h} e^{-x} \, \mathrm{d}x +f'(0)\int_{0}^{h} xe^{-x} \, \mathrm{d}x +\dfrac{1}{2}f''({\xi}_{1})\int_{0}^{h}x^{2}e^{-x} \, \mathrm{d}x  \\
 & = [1-e^{-h}]f(0)+[1-(1+h)e^{-h}]f'(0)+\dfrac{1}{2}[2-(h^{2}+2h+2)e^{-h}] f''({\xi}_{1})
\end{aligned}$$
את $\tilde{I}$ כבר מצאנו בסעיף קודם:
$$\tilde{I}=\left[ 1+\dfrac{1}{h}(e^{-h}-1) \right]f(0)+\dfrac{1}{h}[1-(1+h)e^{-h}]f(h)$$
את הערך $f(h)$ גם נפתח בטור מקלורן:
$$\tilde{I}=\left[ 1+\dfrac{1}{h}(e^{-h}-1) \right]f(0)+\dfrac{1}{h}[1-(1+h)e^{-h}]\left[ f(0)+hf'(0)+\dfrac{1}{2}h^{2}f''({\xi}_{2}) \right]$$
כאשר $0<{\xi}_{2}<h$. נפשט טיפה את הביטוי:
$$\begin{aligned}
\tilde{I} & =\left[ 1+\dfrac{1}{h}(e^{-h}-1)+\dfrac{1}{h}[1-(1+h)e^{-h}] \right]f(0) \\
 & \quad \quad \quad +[1-(1+h)e^{-h}]f'(0)+\dfrac{1}{2}h[1-(1+h)e^{-h}]f''({\xi}_{2}) \\[1ex]
 & = \left[ 1+\dfrac{\cancel{ e^{-h} }\cancel{ -1+1 }-(\cancel{ 1 }+h)e^{-h}}{h} \right]f(0)+\dots  \\[2ex]
 & =(1-e^{-h})f(0)+\dots 
\end{aligned}$$
נציב בחזרה בביטוי עבור $E$, כאשר נשים לב שהביטויים $f(0)$ ו-$f'(0)$ מקזזים אחד את השני:
$$\begin{aligned}
E & =I-\tilde{I} \\
 & = \dfrac{1}{2} [2-(h^{2}+2h+2)e^{-h}] f''({\xi}_{1})-\dfrac{1}{2}h[1-(1+h)e^{-h}]f''({\xi}_{2})
\end{aligned}$$
ממשפט ערך הביניים, נוכל לשלב את ${\xi}_{1}$ ו-${\xi}_{2}$:
$$E=\dfrac{1}{2}[2-(h^{2}+2h+2)e^{-h}-h[1-(1+h)e^{-h}]]f''(\xi)$$
כאשר $0<\xi<h$. נמשיך לפתח את הביטוי:
$$\begin{aligned}
E & =\dfrac{1}{2}[2-h+(\cancel{ -h^{2} }-2h-2+h\cancel{ +h^{2} })e^{-h}]f''(\xi) \\[1ex]
 & =\dfrac{1}{2}[2-h-(h+2)e^{-h}]f''(\xi) \\[1ex]
 & =\dfrac{1}{2}\left[ 2-h-(h+2)\left( 1-h+\dfrac{h^{2}}{2}-\dfrac{h^{3}}{6}+\mathcal{O}(h^{4}) \right) \right]f''(\xi) \\[1ex]
 & = \dfrac{1}{2}\left[ 2-h-(h+2)\left( 1-h+\dfrac{h^{2}}{2} \right)+(h+2) \dfrac{h^{3}}{6} \right]f''(\xi)+\mathcal{O}(h^{4})
\end{aligned}$$
נשים לב כי:
$$\begin{aligned}
2-h-(h+2)\left( 1-h+\dfrac{h^{2}}{2} \right) &  =2-h-\left( h\cancel{ -{ h^{2} } }+\dfrac{h^{3}}{2}+2-2h\cancel{+ h^{2} } \right) \\
 & =2-h-\left( -h+2+\dfrac{h^{3}}{2} \right) \\
 & =-\dfrac{h^{3}}{2}
\end{aligned}$$
נציב בחזרה בביטוי עבור $E$:
$$\begin{aligned}
E & =\dfrac{1}{2}\left[ -\dfrac{h^{3}}{2}+(h+2) \dfrac{h^{3}}{6} \right]f''(\xi)+\mathcal{O}(h^{4}) \\[1ex]
 & =\dfrac{1}{2}\left[ -\dfrac{h^{3}}{2}+\dfrac{h^{4}}{6}+\dfrac{h^{3}}{3} \right]f''(\xi)+\mathcal{O}(h^{4}) \\[1ex]
 & =\dfrac{1}{2}\cdot\left( -\dfrac{h^{3}}{6} \right)f''(\xi)+\mathcal{O}(h^{4}) \\[1ex]
 & =\boxed {
-\dfrac{1}{12}h^{3}f''(\xi)+\mathcal{O}(h^{4})
 }
\end{aligned}$$

בהשוואה לשיטת הטרפז, שהיא בעלת שגיאה מסדר $2$ ($E=-\dfrac{1}{12}h^{2}f''(\xi)+\mathcal{O}(h^{3})$), קיבלנו שגיאה יותר קטנה.

נודר בחיים לא הייתי מצליח את הסעיף הזה במבחן.

### סעיף ג'
ראשית נמיר את האינטגרנד שלנו לתחום הרצוי. כדי לעשות זאת, נבצע t, החלפת המשתנים:
$$\begin{aligned}
T(t)=x=\dfrac{0+0.2+(0.2-0)t}{2}=0.1+0.1t &  & \mathrm{d}x=0.1\,\mathrm{d}t
\end{aligned}$$
$$\begin{aligned}
\int_{0}^{0.2}g(x)  \, \mathrm{d}x & =\int_{-1}^{1} g(0.1+0.1t) \cdot0.1 \, \mathrm{d}t    \\
 & =\int_{-1}^{1} 0.1\exp(-[0.1+0.1t]^{2}) \, \mathrm{d}t
\end{aligned}$$
נסמן $f(t)=0.1\exp(-[0.1+0.1t]^{2})$ ונפתור את האינטגרל עליו בתחום $[-1,1]$ בעזרת שיטת גאוס.
נבחר $3$ נקודות הנתונות מטבלת שורשי פולינומי לז'נדר, עבורן המקדמים הם:
$$\begin{aligned}
 & {t}_{1,2}=\pm \dfrac{\sqrt{ 15 }}{5} &  &  {a}_{1,2}=\dfrac{5}{9} \\[1ex]
 & t_{3}=0 &  & {a}_{3}=\dfrac{8}{9}
\end{aligned}$$
נציב כדי לקבל את שיעור האינטגרל שלנו:
$$\begin{aligned}
\tilde{I} & ={a}_{1}f({t}_{1})+{a}_{2}f({t}_{2})+{a}_{3}f({t}_{3}) \\
 &  =0.053833+0.055527+0.088 \\
 & =\boxed {
0.197364
 }
\end{aligned}$$

### סעיף ד'
התוצאה תהיה מדויקת אם $g$ הוא פולינום שהוא לכל היותר מסדר $5$, כי שיטת גאוס-לז'נדר בנויה כך שהיא מדויקת עבור פולינום מסדר $2n-1$, כאשר $n$ הוא מספר הנקודות שבהן לוקחים את הדגימות.