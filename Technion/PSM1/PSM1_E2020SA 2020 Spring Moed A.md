---
aliases:
---
# Part I


## Question 1

**Analysis of each option:**
**$V \sim b(2n,p)$**:
Since ${X}_{1} \sim b(n,p)$ and ${X}_{2} \sim b(n,p)$ are independent, by the additive property of binomial distributions:
$$V = X_1 + X_2 \sim b(n+n, p) = b(2n, p)$$
This is **CORRECT**.

**$Y \sim b(2n,p)$**:
$Y = 2{X}_{1}$ where ${X}_{1} \sim b(n,p)$
- $Y$ can only take even values: ${0, 2, 4, 6, ..., 2n}$
- But $b(2n,p)$ can take all integer values: ${0, 1, 2, 3, ..., 2n}$
- Therefore Y does NOT follow a binomial distribution

This is **INCORRECT**.

**$E(Y) = E(V)$**:
$$\begin{aligned}
E(Y) &= E(2X_1) = 2E(X_1) = 2np \\[1ex]
E(V) &= E(X_1 + X_2) = E(X_1) + E(X_2) = np + np = 2np
\end{aligned}$$
Therefore $E(Y) = E(V)$.
This is **CORRECT**.

**$\mathrm{Var}(Y) = 2\mathrm{Var}(V)$:**
$$\begin{aligned}
 & \text{Var}(Y) = \text{Var}(2X_1) = 4\text{Var}(X_1) = 4np(1-p) \\[1ex]
 & \text{Var}(V) = \text{Var}(X_1 + X_2) = \text{Var}(X_1) + \text{Var}(X_2) = 2np(1-p) \\[1ex]
 & 2\text{Var}(V) = 2 \times 2np(1-p) = 4np(1-p) = \text{Var}(Y)
\end{aligned}$$
This is **CORRECT**.

## Question 2

We need to find $P(\max(X_1, X_2) = n)$ where $X_1 \sim b(n,p)$ and $X_2 \sim b(n,p)$ are independent.

For the maximum to equal $n$, at least one of $X_1$ or $X_2$ must equal $n$.

Using the inclusion-exclusion principle:

$$\begin{aligned}
P(\max(X_1, X_2) = n) &= P(X_1 = n \text{ or } X_2 = n) \\[1ex]
&= P(X_1 = n) + P(X_2 = n) - P(X_1 = n \text{ and } X_2 = n)
\end{aligned}$$

Since $X_1$ and $X_2$ are independent:
$$P(X_1 = n \text{ and } X_2 = n) = P(X_1 = n) \times P(X_2 = n)$$

For a binomial distribution $b(n,p)$:
$$P(X = n) = \binom{n}{n} p^n (1-p)^0 = p^n$$

Therefore:
$$\begin{aligned}
P(X_1 = n) &= p^n \\[1ex]
P(X_2 = n) &= p^n \\[1ex]
P(X_1 = n \text{ and } X_2 = n) &= p^n \times p^n = p^{2n}
\end{aligned}$$

Substituting back:
$$\begin{aligned}
P(\max(X_1, X_2) = n) &= p^n + p^n - p^{2n} \\[1ex]
&= \boxed {
2p^n - p^{2n}
 }
\end{aligned}$$

## Question 3

We are given given lifetime $X \sim \text{Exponential}(\lambda)$ with $E(X) = 50$ hours.
Since $E(X) = \frac{1}{\lambda} = 50$, we have:
$$\lambda = \frac{1}{50} = 0.02$$

For exponential distribution, the survival function is:
$$P(X > t) = e^{-\lambda t}$$

Therefore:
$$\begin{aligned}
P(X > 60) &= e^{-\lambda \cdot 60} \\[1ex]
&= e^{-0.02 \times 60} \\[1ex]
&= e^{-1.2} \\[1ex]
&= \boxed{0.3012}
\end{aligned}$$

## Question 4

We want to find $P(\overline{X} > 60)$ for a sample of $n = 80$ parts.

For exponential distribution with $E(X) = 50$:
- $\lambda = \frac{1}{50} = 0.02$
- $\text{Var}(X) = \frac{1}{\lambda^2} = \frac{1}{(0.02)^2} = 2500$

For the sample mean of $n = 80$ independent observations:
$$\begin{aligned}
 & E(\overline{X}) = E(X) = 50 \\[1ex]
 & \text{Var}(\overline{X}) = \frac{\text{Var}(X)}{n} = \frac{2500}{80} = 31.25 \\[1ex]
 & {\sigma}_{\overline{X}} = \sqrt{31.25} = 5.59
\end{aligned}$$

By the [[PSM1_005 Fundamental Sampling Distributions and Data Descriptions#The Central Limit Theorem|central limit theorem]], $\overline{X} \sim n(50, 31.25)$ approximately. Therefore:

$$\begin{aligned}
P(\overline{X} > 60) &= P\left(Z > \frac{60 - 50}{5.59}\right) \\[1ex]
&= P\left(Z > \frac{10}{5.59}\right) \\[1ex]
&= P(Z > 1.79) \\[1ex]
&= 1 - \Phi(1.79) \\[1ex]
&= 1 - 0.963 \\[1ex]
&= \boxed{0.037}
\end{aligned}$$ 
# Part II

## Question 5

According to [[PSM1_006 One- and Two-Sample  Estimation Problems#Concept of a Large-Sample Confidence Interval|confidence intervals]]:
$$\begin{aligned}
{z}_{\alpha /2} \dfrac{s}{\sqrt{ n }} & ={z}_{0.025} \dfrac{2}{\sqrt{ 100 }} \\[1ex]
 & ={z}_{0.975} \cdot \dfrac{1}{5} \\[1ex]
 & =1.96\cdot \dfrac{1}{5} \\[1ex]
 & =0.392
\end{aligned}$$
Therefore the confidence interval is:
$$\boxed {
\bar{x}=20\pm 0.392
 }$$



## Question 6

For the confidence interval in Question 5, we used the large-sample formula:
$$\bar{x} \pm z_{\alpha/2} \frac{\sigma}{\sqrt{n}}$$

The Central Limit Theorem allows us to use the normal approximation for the sample mean even when individual observations are not normally distributed, provided the sample size is sufficiently large.

# Part III

## Question 7

**Error in original approach:**
The calculation wrote $P(X_1 \geq 2) = 1 - P(X_1 < 2)$ but then calculated $1 - \sum_{x=0}^{2}p(x;3.5)$, which includes $P(X_1 = 2)$ in the subtraction. This gives $P(X_1 > 2)$ instead of $P(X_1 \geq 2)$.

**Correct solution:**

We want $P(X_1 \geq 2)$ where $X_1 \sim \text{Poisson}(3.5)$.

$$\begin{aligned}
P(X_1 \geq 2) &= 1 - P(X_1 \leq 1) \\[1ex]
&= 1 - [P(X_1 = 0) + P(X_1 = 1)] \\[1ex]
&= 1 - \left[\frac{e^{-3.5}(3.5)^0}{0!} + \frac{e^{-3.5}(3.5)^1}{1!}\right] \\[1ex]
&= \boxed{0.864}
\end{aligned}$$

## Question 8
According to [[PSM1_003 Some Discrete Probability  Distributions#Geometric Distribution|geometric distribution]], if the probability no defects of either type is $0.02$, then denoting $T$ as the number of tested items:
$$\begin{aligned}
P(T=4) & =g(4;0.02) \\[1ex]
 & =0.02\times 0.98^{3} \\[1ex]
 & =\boxed {
0.0188
 }
\end{aligned}$$

## Question 9

If $X_I$ and $X_{II}$ were [[PSM1_001 Introduction and Probability#Independent Events|independent]], then:
$$P(X_I = 0 \text{ and } X_{II} = 0) = P(X_I = 0) \times P(X_{II} = 0)$$

We know $P(X_I = 0) = e^{-3.5} = 0.030197$. Given that $P(X_I = 0 \text{ and } X_{II} = 0) = 0.02$:

$$\begin{gathered}
0.02 = 0.030197 \times P(X_{II} = 0) \\[1ex]
P(X_{II} = 0) = \frac{0.02}{0.030197} = 0.662
\end{gathered}$$

This means $P(X_{II} = 1) + P(X_{II} = 2) = 1 - 0.662 = 0.338$.

From the constraint $E(X_{II}) > 1$:
$$E(X_{II}) = 1 \cdot P(X_{II} = 1) + 2 \cdot P(X_{II} = 2) > 1$$

Since $P(X_{II} = 1) + P(X_{II} = 2) = 0.338$, the maximum possible value of $E(X_{II})$ occurs when all probability is at $X_{II} = 2$:
$$E(X_{II})_{\text{max}} = 2 \times 0.338 = 0.676 < 1$$

This contradicts $E(X_{II}) > 1$. Therefore, ${X}_{1}$ and ${X}_{2}$ are not independent.

# Part IV

## Question 10
We cannot start production based on this data alone, since the confidence interval for the difference in means includes values above five units. It is possible that the difference between the two means is less than five.

## Question 11
According to the [[PSM1_005 Fundamental Sampling Distributions and Data Descriptions#The Central Limit Theorem|central limit theorem]], the standard error difference.

## Question 12

There is a fundamental relationship between hypothesis tests and confidence intervals:

For the two-sided test $H_0: \mu_1 = \mu_2$ vs $H_1: \mu_1 \neq \mu_2$:
- If we reject $H_0$ at $\alpha = 0.05$, then the $95\%$ confidence interval for $(\mu_2 - \mu_1)$ will NOT contain $0$
- If we fail to reject $H_0$ at $\alpha = 0.05$, then the $95\%$ confidence interval for $(\mu_2 - \mu_1)$ WILL contain $0$

Since $p < 0.05$, we reject $H_0$ at the $5\%$ significance level.

Therefore, the $95\%$ confidence interval for $(\mu_2 - \mu_1)$ does NOT contain zero.

Since the confidence interval doesn't contain zero, it must be entirely on one side of zero - either entirely above zero or entirely below zero.

# Part V
## Question 13

The significance level $\alpha$ is the probability of Type I error - rejecting $H_0$ when $H_0$ is true.

Since we reject $H_0: p = 0.12$ when $X \leq 5$:
$$\alpha = P(\text{reject } H_0 | H_0 \text{ is true}) = P(X \leq 5 | p = 0.12)$$

Therefore: $\alpha = P(X \leq 5)$ for $X \sim \text{bin}(75, 0.12)$

## Question 14

Power is the probability of correctly rejecting $H_0$ when the alternative hypothesis is true.

For the alternative $p^* = 0.05$:
$$(1-\beta) = P(\text{reject } H_0 | p = 0.05) = P(X \leq 5 | p = 0.05)$$

Therefore: $(1-\beta) = P(X \leq 5)$ for $X \sim \text{bin}(75, 0.05)$

## Question 15

The p-value is the probability of observing a result as extreme or more extreme than what was actually observed, assuming $H_0$ is true.

We observed $X = 4$ defective parts. Since this is a one-sided test ($H_1: p < 0.12$):
$$\text{p-value} = P(X \leq 4 | p = 0.12)$$

Therefore: p-value $= P(X \leq 4)$ for $X \sim \text{bin}(75, 0.12)$

## Question 16

With imperfect detection (only 90% of defective parts are identified), the observed number of defective parts will be systematically lower than the true number.

**Effect on Type I error:**
Under $H_0$ (true $p = 0.12$), we expect fewer observed defective parts due to the $90\%$ detection rate. This makes us more likely to observe $X \leq 5$, increasing the probability of incorrectly rejecting $H_0$.

**Effect on Type II error:**
Under $H_1$ (true $p < 0.12$), we also observe fewer defective parts, but this makes us more likely to correctly reject $H_0$, thus decreasing the Type II error probability.

# Part VI

## Question 17
From the graph we can see the largest positive residual occurs at $\mathrm{evap}=33$ and $\mathrm{temp}=79$. According to the linear regression, at this temp:
$$\begin{aligned}
\mathrm{evap}_{\text{fit}} & =-160.41+2.28\times 79 \\[1ex]
 & =19.71
\end{aligned}$$
Therefore the residual is:
$$\begin{aligned}
\mathrm{res} & =33-19.71 \\[1ex]
 & =\boxed {
13.29
 }
\end{aligned}$$

## Question 18
If a different sample of $25$ observations was used to fit the model, we would not be surprised to get an estimate of the slope of the model of $2.00$ instead of $2.28$.