---
aliases:
---
# Part I
## Question 1
According to a [[PSM1_003 Some Discrete Probability  Distributions#Hypergeometric Distribution|hypergeometric distribution]]:
$$\begin{aligned}
P(X=2) & =h(2;8,4,3) \\[1ex]
 & =\dfrac{\binom{3}{2}\binom{5}{2}}{\binom{8}{4}} \\[1ex]
 & =\dfrac{3 \times 10}{70} \\[1ex]
 & =\dfrac{30}{70} \\[1ex]
 & =\boxed{\dfrac{3}{7} = 0.4286}
\end{aligned}$$

## Question 2
Assertion I - incorrect.
Assertion II - correct.

## Question 3

The p-value is calculated based on the test statistic and the sampling distribution under the null hypothesis. It represents the probability of observing a test statistic as extreme or more extreme than what was actually observed, assuming $H_0$ is true.

The significance level $\alpha$ is simply the threshold we choose for making a decision about rejecting $H_0$. The p-value calculation does not depend on our choice of $\alpha$.

Since the same data produces the same test statistic, and the same test statistic produces the same p-value regardless of what decision criterion we use, changing $\alpha$ from $0.05$ to $0.10$ will not change the p-value.

What changes is only our decision:
- With $\alpha = 0.05$: p-value $= 0.08 > 0.05$, so do not reject $H_0$
- With $\alpha = 0.10$: p-value $= 0.08 < 0.10$, so reject $H_0$

## Question 4
According to [[PSM1_003 Some Discrete Probability  Distributions#Poisson Distribution and the Poisson Process|poisson distribution]]:
$$\begin{aligned}
P(X>2) & =1-\sum_{x=0}^{r=2}p(x;3.8)  \\[1ex]
 & =1-\dfrac{e^{-3.8}\times 3.8^{0}}{0!}-\dfrac{e^{-3.8}\times 3.8^{1}}{1!}-\dfrac{e^{-3.8}\times 3.8^{2}}{2!} \\[1ex]
 & = \boxed {
0.7311
 }
\end{aligned}$$

## Question 5
The probability of a product to be found with no scratches is:
$$\begin{aligned}
p & :=P(X=0) \\[1ex]
 & =\dfrac{e^{-3.8}\times 3.8^{0}}{0!} \\[1ex]
 & =0.02237
\end{aligned}$$
Using a [[PSM1_003 Some Discrete Probability  Distributions#Negative Binomial Distribution|negative binomial]]:
$$\begin{aligned}
P(Y=7) & =b^{*}(7;2,p) \\[1ex]
 & = \binom{7-1}{2-1}p^{2}(1-p)^{7-2} \\[1ex]
 & =\dfrac{6!}{1!5!}\times0.02237^{2}\times 0.97763^{5} \\[1ex]
 & =\boxed {
0.00268
 }
\end{aligned}$$

## Question 6

We are given $\pu{18hours} = \pu{1080min}$, and repair times are $\pu{5min}$ for $1$ scratch, $\pu{15 min}$ for $>1$ scratch.

First, find probabilities for each repair scenario:
$$\begin{aligned}
P(X = 0) &= 0.02237 \quad \text{(0 minutes repair)} \\[1ex]
P(X = 1) &= \frac{e^{-3.8} \times 3.8^1}{1!} = 0.08501 \quad \text{(5 minutes repair)} \\[1ex]
P(X > 1) &= 1 - 0.02237 - 0.08501 = 0.89262 \quad \text{(15 minutes repair)}
\end{aligned}$$

For each product, the expected repair time:
$$E[T] = 0 \times 0.02237 + 5 \times 0.08501 + 15 \times 0.89262 = \pu{13.8144min}$$

The variance:
$$\begin{gathered}
E[T^2] = 0^2 \times 0.02237 + 5^2 \times 0.08501 + 15^2 \times 0.89262 = 202.965 \\[1ex]
\text{Var}[T] = 202.965 - (13.8144)^2 = 12.127
\end{gathered}$$

For $75$ products:
$$\begin{aligned}
 & E[T] = 75 \times 13.8144 = 1036.08 \text{ minutes} \\[1ex]
 & \text{Var}[T] = 75 \times 12.127 = 909.525 \\[1ex]
 & \sigma_{T} = \sqrt{909.525} = 30.16 \text{ minutes}
\end{aligned}$$

Using normal approximation:
$$Z = \frac{1080 - 1036.08}{30.16} = \frac{43.92}{30.16} = 1.456$$
Therefore:
$$\begin{aligned}
P(\text{total time} > 1080)  & = P(Z > 1.456)  \\[1ex]
 & \approx 1 - 0.9274  \\[1ex]
 & = \boxed{0.073}
\end{aligned}$$

# Part II

## Question 7

Given: $95\%$ confidence interval $[3.93\%, 4.16\%]$, $n = 9$, $t_{8,0.025} = 2.306$.

For a $95\%$ confidence interval with unknown $\sigma$:
$$\overline{x} \pm t_{\alpha/2,n-1} \frac{s}{\sqrt{n}}$$

From the confidence interval:
$$\begin{aligned}
 & \text{Sample mean: } \overline{x} = \frac{3.93 + 4.16}{2} = 4.045\% \\[1ex]
 & \text{Margin of error: } E= \frac{4.16 - 3.93}{2} = 0.115\%
\end{aligned}$$

The margin of error equals:
$$E = t_{\alpha/2,n-1} \frac{s}{\sqrt{n}}$$
Substituting known values:
$$0.115 = 2.306 \times \frac{s}{\sqrt{9}}$$
Solving for $s$:
$$s = \frac{0.115 \times 3}{2.306} = \frac{0.345}{2.306} = \boxed{0.150\%}$$

## Question 8

There is a direct relationship between confidence intervals and hypothesis testing:

- A $95\%$ confidence interval corresponds to a two-sided test with $\alpha = 0.05$
- If the null hypothesis value is **inside** the confidence interval, then **do not reject** $H_0$ ($p$-value $> 0.05$)
- If the null hypothesis value is **outside** the confidence interval, then **reject** $H_0$ ($p$-value $< 0.05$)

Given:
- $95\%$ confidence interval: $[3.93\%, 4.16\%]$
- Null hypothesis: $H_0: \mu = 4.0\%$

Since $4.0\%$ lies within the interval $[3.93\%, 4.16\%]$, we would not reject $H_0$.

Therefore, the $p$-value $> 0.05$.

## Question 9
Assertion I is correct.
Assertion II is incorrect.

## Question 10
The four small horizontal lines shown on the graph show average $\pm$ one sample standard deviation for each machine (with standard deviation estimated separately for each machine)

## Question 11
We cannot start production, since the whole $95\%$ confidence interval for the difference in means is above one unit, indicating that the difference between the two means is greater than one unit.

## Question 12
From the JMP output:
- Test statistic: $t = 3.675274$
- Degrees of freedom: $18$
- The one-sided p-value is directly provided as "$\text{Prob} > t = 0.0009$"

Since the observed difference ($3.959$) is positive and we're testing $H₁: μ₂ - μ₁ > 0$, we need the right tail probability:

$p$-value $= P({T}_{18} > 3.675) = \boxed{0.0009 }$

# Part III
## Question 13
From the regression output: $\text{weight} = 4.0452 + 0.00281 × \text{temperature}$

For temperature = $200^{\circ}\pu{C}$, the predicted weight is:
$$\hat{y} = 4.0452 + 0.00281 \times 200 = 4.0452 + 0.562 = 4.6072$$

Therefore the residual for the observation with $\text{temperature} = 200^{\circ}\pu{C}$ and $\text{weight} = \pu {4.63g}$ is:
$$\begin{aligned}
\text{Residual}  & = y - \hat{y}  \\[1ex]
 & = 4.63 - 4.6072\\[1ex]
 & = \boxed{0.0228}
\end{aligned}$$

## Question 14
The standard error $\pu {0.000212}$ is an *estimate* of the standard deviation of the estimate of the *slope* of the fitted line.

## Question 15

A composite sample is contaminated if **at least one** of the $10$ individual samples is contaminated.

Using the complement: $P(\text{contaminated}) = 1 - P(\text{none contaminated})$

$$\begin{aligned}
P(\text{none contaminated}) &= b(0;10,0.01) \\[1ex]
&= \binom{10}{0} \times 0.01^{0} \times 0.99^{10} \\[1ex]
&= 1 \times 1 \times 0.9044 \\[1ex]
&= 0.9044
\end{aligned}$$

Therefore:
$$P(\text{contaminated}) = 1 - 0.9044 = \boxed{0.0956}$$

## Question 16

Cost scenarios per week:
- If composite not contaminated: $20 + 40 = 60$ shekels
- If composite contaminated: $20 + 40 + 40 \times 10 = 460$ shekels

From the previous question:
- $P(\text{not contaminated}) = 0.9044$
- $P(\text{contaminated}) = 0.0956$

Expected weekly cost:
$$\begin{aligned}
E(C) &= 60 \times 0.9044 + 460 \times 0.0956 \\[1ex]
&= 54.264 + 43.976 \\[1ex]
&= 98.24 \text{ shekels}
\end{aligned}$$
The annual expected cost: $52 \times 98.24 = \pu {5108.48  shekels}$.

Therefore the annual savings:
$$\begin{aligned}
\text{savings} & =\pu {20800 } - \pu {5108.48 }  \\[1ex]
 & = \boxed{\pu {15691.52shekels }}
\end{aligned}$$

## Question 17

For a binomial distribution, we need: fixed number of independent trials, each with two outcomes and constant probability of success.

Analyzing each option:
- Options a, b, e: The number of tests varies based on contamination results
- Option c: Always exactly $52$ tests (constant, not random)  
- Option d: Exactly $52$ independent trials (weeks), each with probability $0.0956$ of contamination

Therefore, option d. is the correct answer.

## Question 18
Cost less than in the original version above.

