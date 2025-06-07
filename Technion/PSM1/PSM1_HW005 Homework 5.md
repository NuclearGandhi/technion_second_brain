---
aliases: 
title: Homework 5
---

|               | Student A                      |
| ------------- | ------------------------------ |
| **Full Name** | Ido Fang Bentov                |
| **ID**        | 322869140                      |
| **Email**     | ido.fang@campus.technion.ac.il |

<div><hr><hr></div>

## Question 1

Twelve machines run in parallel, manufacturing the same part, in one 8-hour shift per day. The times to failure (TTF) for the 12 machines, $T_i, i=1,\ldots,12$, have independent, identical exponential distributions with $E(T_i)=50$ hours. Whenever a machine fails, it is shut down for the remainder of the 8-hour shift and repaired later by a maintenance crew. The times to failure for the repaired machines have the same, independent exponential distributions as the new machines. Every
morning all twelve machines are working; by the end of the 8-hour shift, zero to twelve machines are still working.

We denote $X$ as the total number of failures for all 12 machines in one 8-hour shift. Note that $8 \cdot 12 \cdot 0.02 = 1.92$.
### Part a
Regarding the distribution of $X$, which of the following statement is true?
1. Because the machines are shut down for the rest of the shift after failing, $E(X)<1.92$
2. Because the machines are shut down for the rest of the shift after failing, $E(X)>1.92$
3. $X \sim \text{Poisson}(1.92)$, with mean $1.92$
4. $X$ has an approximately normal distribution, with mean $1.92$
5. $X \sim \exp(1/1.92)$, with mean $1.92$

**Solution**:

The key insight is understanding how the shutdown mechanism affects the failure process. Each machine has an [[PSM1_004 Some Continuous Probability Distributions#Exponential Distribution|exponential distribution]] with mean 50 hours, giving a failure rate $\lambda = 1/50 = 0.02$ failures per hour.

In a pure [[PSM1_003 Some Discrete Probability  Distributions#Poisson Distribution and the Poisson Process|Poisson process]] with 12 machines over 8 hours, the expected number of failures would be $12 \times 8 \times 0.02 = 1.92$. However, **because machines are shut down after failing**, they cannot contribute additional failures during the same shift. This reduces the effective "machine-hours" as failures occur, making the actual expected number of failures less than 1.92.

Therefore, **statement 1 is correct**: Because the machines are shut down for the rest of the shift after failing, $E(X) < 1.92$.

### Part b
What is the probability that exactly 10 of the 12 machines are still working at the end of the first 8-hour shift of this week?

**Solution**:

If exactly 10 machines are still working, then exactly 2 machines have failed ($X = 2$).

For each machine during an 8-hour period:
- Probability of survival: $P(T > 8) = e^{-\lambda t} = e^{-0.02 \times 8} = e^{-0.16} \approx 0.8521$
- Probability of failure: $P(T \leq 8) = 1 - e^{-0.16} \approx 0.1479$

This follows a [[PSM1_003 Some Discrete Probability  Distributions#Binomial Distribution|binomial distribution]]: $X \sim \text{Binomial}(12, 0.1479)$.

$$\begin{gathered}
P(X = 2) = \binom{12}{2}(0.1479)^2(0.8521)^{10} = 66 \cdot 0.02187 \cdot 0.2725 \\[1ex]
P(X=2) = \boxed{0.393}
\end{gathered}$$

### Part c
If we know that exactly 10 of the 12 machines are still working at the end of the first 8-hour shift of this week, and we randomly select a sample of four machines from these 12 machines, what is the probability that exactly two of the four machines selected are still working?

**Solution**:

This is a [[PSM1_003 Some Discrete Probability  Distributions#Hypergeometric Distribution|hypergeometric distribution]] problem. We have:
- $N = 12$ total machines
- $k = 10$ working machines  
- $n = 4$ machines selected
- $x = 2$ working machines desired

Using the hypergeometric formula:
$$\begin{gathered}
P(X = 2) = \frac{\binom{10}{2}\binom{2}{2}}{\binom{12}{4}} = \frac{45 \times 1}{495} = \frac{9}{99} \\[1ex]
\boxed {
P(X=2)=\dfrac{1}{11}
 }
\end{gathered} $$