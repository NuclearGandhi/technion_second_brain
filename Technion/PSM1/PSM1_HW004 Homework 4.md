---
aliases:
  - Homework 4
---

|               | Student A                      |
| ------------- | ------------------------------ |
| **Full Name** | Ido Fang Bentov                |
| **ID**        | 322869140                      |
| **Email**     | ido.fang@campus.technion.ac.il |

<div><hr><hr></div>

## Question 1
Let $X\sim \mathrm{Poisson}(\alpha)$ and $Y\sim \text{Poisson}(\beta)$ be two independent random variables. Define a new random variable as $Z=X+Y$. Find the PMF of $Z$.

**Solution**:
Since $X$ and $Y$ are independent, the PMF of $Z=X+Y$ is given by the the convolution of the PMFs of $X$ and $Y$:
$$P(Z=k)=\sum_{i=0}^{k} P(X=i)\cdot P(Y=k-1) $$
Plugging in the PMFs of $X\sim \mathrm{Poisson}(\alpha)$ and $Y\sim \text{Poisson}(\beta)$, we get:
$$\boxed {
P(Z=k)=\sum_{i=0}^{k} \dfrac{a^{i}e^{-a}}{i!}\cdot \dfrac{\beta^{k-1}e^{-\beta}}{(k-1)!}
 } $$

## Question 2
I roll a fair die repeatedly until a number larger than $4$ is observed. If $N$ is the total number of times that I roll the die find $P(N=k)$ for $k=1,2,3,\dots$.

**Solution**:
The probability of rolling a number larger than $4$ is $1/3$.
Assuming the number of rolls is $N$, according to the [[#Geometric Distribution|geometric distribution]], the probability of getting one successful roll after $N$ rolls is 

$$\boxed {
P(N=k)=\dfrac{1}{3}\cdot\left( \dfrac{2}{3} \right)^{k-1}
 }$$