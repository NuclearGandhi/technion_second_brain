---
aliases: 
title: Homework 2
---

|               | Student A                      |
| ------------- | ------------------------------ |
| **Full Name** | Ido Fang Bentov                |
| **ID**        | 322869140                      |
| **Email**     | ido.fang@campus.technion.ac.il |

<div><hr><hr></div>

## Question 1
An item is purchased from three different suppliers. The probability of an item purchased from supplier $A$ being defective is $0.02$, the probability of an item purchased from supplier $B$ being defective is $0.03$, and the probability of an item purchased from supplier $C$ being defective is $0.12$. A bin contains $35$ items from supplier $A$, $40$ items from supplier $B$ and $15$ items from supplier $C$.

### Part a
What is the probability that an item randomly selected from the bin is defective?

**Solution**:
The probability of selecting an item from a specific supplier is:
$$\begin{aligned}
P(A) & =\dfrac{35}{90} \\[1ex]
 & =\dfrac{7}{18}
\end{aligned},\qquad \begin{aligned}
P(B) & =\dfrac{40}{90} \\[1ex]
 & = \dfrac{8}{18}
\end{aligned},\qquad \begin{aligned}
P(C) & =\dfrac{15}{90} \\[1ex]
 & = \dfrac{3}{18}
\end{aligned}$$
Denoting a item being defective as $D$, we know that:
$$P(D|A)=0.02,\qquad P(D|B)=0.03,\qquad P(D|C)=0.12$$
Therefore, using the [[PSM1_001 Introduction and Probability#Total Probability|total probability rule]]:
$$\begin{aligned}
P(D) & =P(A)P(D|A)+P(B)P(D|B)+P(C)P(D|C) \\[1ex]
 & =\dfrac{7}{18}\cdot 0.02+\dfrac{8}{18}\cdot 0.03+\dfrac{3}{18}\cdot 0.12
\end{aligned}$$
We get:
$$\boxed {
P(D)=0.04\bar{1}
 }$$

### Part b
If one item randomly selected from the bin is defective, then what is the probability that the item was purchased from Supplier $C$?

**Solution**:
Using [[PSM1_001 Introduction and Probability#Bayes' Rule|bayes' rule]]:
$$\begin{aligned}
P(C|D) & =\dfrac{P(C)P(D|C)}{P(D)} \\[1ex]
 & =\dfrac{(3/18)\cdot 0.12}{0.04\bar{1}} 
\end{aligned}$$
We get:
$$\boxed{P(C|D)\approx 0.4865 }$$
