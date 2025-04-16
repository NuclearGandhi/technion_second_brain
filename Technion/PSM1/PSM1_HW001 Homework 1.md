---
aliases:
---


|               | Student A                      |
| ------------- | ------------------------------ |
| **Full Name** | Ido Fang Bentov                |
| **ID**        | 322869140                      |
| **Email**     | ido.fang@campus.technion.ac.il |


## Question 1
The probability that a part produced in chamber $A$ is defective is $0.15$ and the probability that a part produced in chamber $B$ is defective is $0.05$. All parts are independent of each other. If we know that exactly two of the $16$ parts produced in one shift are defective, what is the probability that in a random sample of five parts selected from these $16$ parts, exactly two are defective?

**Solution**:
The number of ways of selecting $5$ parts from $16$ is:
$$\binom{16}{5}=\dfrac{16!}{11!5!}=\pu {4368 }$$
Knowing we already picked two defective parts, we now have $14$ parts to select from, and $3$ more to pick. The number ways of picking them are:
$$\binom{14}{3}=\dfrac{14!}{11!3!}=364$$
Therefore, the probability is:
$$\begin{gathered}
P(D)=\dfrac{364}{4368} \\[1ex]
\boxed{P(D)=\dfrac{1}{12} }
\end{gathered}$$

## Question 2
Concrete samples from a building site are sent to one of four laboratories ($\mathrm{lab1}$, $\mathrm{lab2}$, $\mathrm{lab3}$, $\text{lab4}$), selected at random. When a sample arrive at the lab, three properties are tested (${Y}_{1}$,${Y}_{2}$,${Y}_{3}$).

On a particular day, two samples are sent. The following events are defined:
- $A$: both samples are sent to $\text{lab1}$
- $B$: at least one sample is sent to $\mathrm{lab1}$
- $C$: both samples are sent to the same lab

### Part a
Find the probabilities $P(A),\,P(B),\,P(C),\,P(A\cup C),\,P(B\cup C),\,P(B\cap C)$.

**Solution**:
We define:
- ${L}_{i}$ sample is sent to $\text{lab}i$

Since the the labs are selected at random, there are $4$ labs, and the selections are independent:
$$\begin{aligned}
 & P(A)=P({L}_{1})P({L}_{1})=\boxed {
\dfrac{1}{16}
 } \\[1ex]
 & P(B)=1-P({{{L}_{1}}}^{c})P({{{L}_{1}}}^{c})=1-\left( \dfrac{3}{4} \right)\left( \dfrac{3}{4} \right)=\boxed {
\dfrac{7}{16}
 } \\[1ex]
 & P(C)=P({L}_{1})P({L}_{1})+P({L}_{2})P({L}_{2})+\dots =4\cdot \dfrac{1}{16}=\boxed{\dfrac{1}{4} }
\end{aligned}$$
$A$ is a subset of $C$, so:
$$\begin{aligned}
 & P(A\cup C) =P(C)=\boxed {
\dfrac{1}{4}
 }
\end{aligned}$$
To calculate $P(B\cup C)$ we can use the [[PSM1_001 Introduction and Probability#Additive Rules|additive rule]]:
$$\begin{aligned}
P(B\cup C) & =P(B)+P(C)-P(B\cap C) \\[1ex]
 & =\dfrac{1}{4}+\dfrac{7}{16}-P(B\cap C)
\end{aligned}$$
The intersection of $B$ and $C$ corresponds to the event that both samples are sent to $\text{lab1}$, that is, event $A$. Hence, $P(B\cap C)=P(A)=\boxed{\dfrac{1}{16}}$, so we can write:
$$\begin{gathered}
P(B\cup C)=\dfrac{1}{4}+\dfrac{7}{16}-\dfrac{1}{16} \\[1ex]
\boxed {
P(B\cup C)=\dfrac{5}{8}
 }
\end{gathered}$$

### Part b
If the result of the test of ${Y}_{1}$ does not meet the specification, we say that ${Y}_{1}$ failed. When a sample is tested in $\text{lab1}$,:
$$\begin{aligned}
 & P(\text{fail }{Y}_{1})=0.03 \\[1ex]
 & P(\text{fail }{Y}_{2})=0.04 \\[1ex]
 & P(\text{fail }{Y}_{3})=0.02 \\[1ex]
 & P(\text{fail }{Y}_{1}\cap\text{fail }{Y}_{2})=0.01 \\[1ex]
 & P(\text{fail }{Y}_{1}\cap\text{fail }{Y}_{3})=0.0006 \\[1ex] & P(\text{fail }{Y}_{2}\cap\text{fail }{Y}_{3})=0 \\[1ex]
\end{aligned}$$

For a single sample tested in $\text{lab1}$, find the probabilities
$$\begin{aligned}
 & P(\text{fail }{Y}_{1}\cup\text{fail }{Y}_{2}),\, P(\text{fail }{Y}_{1}\cup\text{fail }{Y}_{3}) \\[1ex]
 & P(\text{fail }{Y}_{2}\cup\text{fail }{Y}_{3}) \\[1ex]
& P(\text{fail }{Y}_{1}\cup\text{fail }{Y}_{2}\cup \text{fail }{Y}_{3})
\end{aligned}$$

**Solution**:
We'll use the shorthand:
- ${Y}_{1}$ means $\text{fail }{Y}_{1}$.

Using the [[PSM1_001 Introduction and Probability#Additive Rules|additive rule]]:
$$\begin{gathered}
 & P({Y}_{1}\cup{Y}_{2})=P({Y}_{1})+P({Y}_{2})-P({Y}_{1}\cap{Y}_{2}) \\[1ex]
 & \boxed{P({Y}_{1}\cup{Y}_{2})=0.06 }
\end{gathered}$$
Applying the same logic, we get:
$$\boxed{P({Y}_{1}\cup{Y}_{3})=0.0494 },\qquad \boxed{P({Y}_{2}\cup{Y}_{3})=0.06 }$$

For the last probability, we get:
$$\begin{aligned}
P({Y}_{1}\cup {Y}_{2}\cup {Y}_{3}) & =P({Y}_{1})+P({Y}_{2})+P({Y}_{3}) \\[1ex]
 & \qquad -P({Y}_{1}\cap {Y}_{2})-P({Y}_{1}\cap {Y}_{3})-P({Y}_{2}\cap {Y}_{3}) \\[1ex]
 & \qquad +P({Y}_{1}\cap {Y}_{2}\cap {Y}_{3})
\end{aligned}$$
Since $P({Y}_{2}\cap {Y}_{3})=0$, we know that $P({Y}_{1}\cap {Y}_{2}\cap {Y}_{3})=0$. Therefore:
$$\begin{gathered}
P({Y}_{1}\cup {Y}_{2}\cup {Y}_{3})=0.03+0.04+0.02-0.01-0.0006-0+0 \\[1ex]
\boxed{P({Y}_{1}\cup {Y}_{2}\cup {Y}_{3})=0.0794 }
\end{gathered}$$