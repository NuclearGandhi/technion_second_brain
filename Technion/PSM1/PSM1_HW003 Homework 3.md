---
aliases:
  - Homework 3
---

|               | Student A                      |
| ------------- | ------------------------------ |
| **Full Name** | Ido Fang Bentov                |
| **ID**        | 322869140                      |
| **Email**     | ido.fang@campus.technion.ac.il |

<div><hr><hr></div>

## Question 1

Which one of the following assertions is correct and which one is false:
1. $$E(2{X}_{1})=E({X}_{1}+{X}_{2})$$
2. $${\sigma}_{2{X}_{1}}={\sigma}_{{X}_{1}+{X}_{2}}$$

**Solution**:

1. Only if $E({X}_{1})=E({X}_{2})$, because then
	$$\begin{aligned}
	E({X}_{1}+{X}_{2}) & =E({X}_{1})+E({X}_{2}) \\[1ex]
	 & =2E({X}_{1}) \\[1ex]
	 & =E(2{X}_{1})
	\end{aligned}$$
2. Incorrect. Say ${\sigma}_{{X}_{1}}^{2}={\sigma}_{{X}_{2}}^{2}=2$. Then
	$$\begin{aligned}
{\sigma}_{{X}_{1}+{X}_{2}}^{2} & =\sigma ^{2}_{{X}_{1}} +\sigma ^{2}_{{X}_{2}} \\[1ex]
 & =4
\end{aligned}$$
	And:
	$$\begin{aligned}
\sigma ^{2}_{2{X}_{1}} & =4{\sigma}_{{X}_{1}}^{2} \\[1ex]
 & =8
\end{aligned}$$


## Question 2

You take an exam that contains $20$ multiple-choice questions. Each question has $4$ possible options. You know the answer to $10$ questions, but you have no idea about the other $10$ questions so you choose answers randomly. Your score $X$ on the exam is the total number of correct answers. Find the PMF of $X$. What is $P(X>15)$?

**Solution**:
Denoting $Y$ as the number of randomly guessed answers that are correct, then we get $X=10+Y$. According to [[PSM1_003 Some Discrete Probability  Distributions#Binomial Distribution|binomial distributions]], the [[PSM1_002 Random Variables#Probability Distribution|PMF]] of $Y$ is:
$$\begin{aligned}
P(Y=y) & =b(y;10,0.25) \\[1ex]
 & =\binom{10}{y}0.25^{y}\cdot0.75^{10-y}
\end{aligned}$$
Therefore:
$$\boxed {
P(X=x)=\binom{10}{x-10}0.25^{x-10}\cdot 0.75^{20-x}
 }$$

In order to compute $P(X>15)$ we need to compute:
$$\begin{aligned}
 & P(X=16)=\binom{10}{6}0.25^{6}\cdot 0.75^{4}\approx 0.016222 \\[1ex]
 & P(X=17)=\dots \approx 0.003090 \\[1ex]
 & P(X=18)= \dots \approx 0.000386\\[1ex]
 & P(X=19)=\dots \approx 0.0000286 \\[1ex]
 & P(X=20)=\dots \approx 0.00000095
\end{aligned}$$
In total, we get:
$$\boxed {
P(X>15)=0.01973
 }$$