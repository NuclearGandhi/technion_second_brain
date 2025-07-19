---
aliases:
---
# Part I
## Question 1
Denoting $A$ as the process being approved, and given $p=0.03$, the probability of having less than two parts being defective (which means the process is approved) follows a [[PSM1_003 Some Discrete Probability  Distributions#Binomial Distribution|binomial distribution]]:
$$\begin{aligned}
P(A) & = b(0;60,0.03) + b(1;60,0.03) \\[1ex]
 & = \binom{60}{0}0.03^{0}\cdot 0.97^{60} + \binom{60}{1}0.03^{1}\cdot 0.97^{59} \\[1ex]
 & = 0.1608 + 0.2984 \\[1ex]
 & = \boxed {
0.4592
 }
\end{aligned}$$

## Question 2
Assertion I is correct and Assertion II is correct.

## Question 3
We need to find $E(N)$ where $N$ is the number of parts that are inspected.

In the modified plan, $N$ can take three values:
- $N = 20$: Reject after first sample ($≥2$ defective in first $20$)
- $N = 40$: Reject after second sample ($≥2$ defective total in $40$, but $<2$ in first $20$)  
- $N = 60$: Continue to third sample ($≤1$ defective total in first $40$)

Let $X_1 \sim b(20, 0.03)$ and $X_1 + X_2 \sim b(40, 0.03)$.

**Calculating $P(N = 20) = P(X_1 \geq 2)$**
$$\begin{aligned}
P(X_1 = 0) &= \binom{20}{0}(0.03)^0(0.97)^{20} = 0.5438 \\[1ex]
P(X_1 = 1) &= \binom{20}{1}(0.03)^1(0.97)^{19} = 20 \times 0.03 \times 0.5607 = 0.3364 \\[1ex]
P(X_1 \geq 2) &= 1 - 0.5438 - 0.3364 = 0.1198
\end{aligned}$$

**Calculating $P(N = 40)$**
This occurs when $X_1 \leq 1$ but $X_1 + X_2 \geq 2$:
$$P(N = 40) = P(X_1 + X_2 \geq 2) - P(X_1 \geq 2)$$

For $X_1 + X_2 \sim \text{Binomial}(40, 0.03)$:
$$\begin{aligned}
P(X_1 + X_2 = 0) &= \binom{40}{0}(0.03)^0(0.97)^{40} = 0.2957 \\[1ex]
P(X_1 + X_2 = 1) &= \binom{40}{1}(0.03)^1(0.97)^{39} = 40 \times 0.03 \times 0.3048 = 0.3658 \\[1ex]
P(X_1 + X_2 \geq 2) &= 1 - 0.2957 - 0.3658 = 0.3385
\end{aligned}$$

Therefore: $P(N = 40) = 0.3385 - 0.1198 = 0.2187$

**Calculating $P(N = 60)$**
$$P(N = 60) = P(X_1 + X_2 \leq 1) = 0.2957 + 0.3658 = 0.6615$$

**Calculating expected value**
$$\begin{aligned}
E(N) &= 20 \cdot P(N = 20) + 40 \cdot P(N = 40) + 60 \cdot P(N = 60) \\[1ex]
&= 20 \times 0.1198 + 40 \times 0.2187 + 60 \times 0.6615 \\[1ex]
&= 2.396 + 8.748 + 39.69 \\[1ex]
&= \boxed{50.83}
\end{aligned}$$

## Question 4

Given: $C \sim \text{Poisson}(\lambda = 14)$

For a Poisson distribution: $\mu_C = \lambda = 14$ and $\sigma_C = \sqrt{\lambda} = \sqrt{14}$

**Calculating control limits**
$$\begin{aligned}
\text{UCL} &= \mu_C + 3\sigma_C = 14 + 3\sqrt{14} = 14 + 3(3.742) = 25.226 \\[1ex]
\text{LCL} &= \mu_C - 3\sigma_C = 14 - 3\sqrt{14} = 14 - 3(3.742) = 2.774
\end{aligned}$$

**Defining false alarm condition**
Since $C$ is a discrete random variable (count), a false alarm occurs when:
$$C \leq 2 \text{ or } C \geq 26$$

**Calculating probability using normal approximation**
For large $\lambda$, Poisson approaches normal. Using continuity correction:
$$\begin{aligned}
P(\text{false alarm}) &= P(C \leq 2) + P(C \geq 26) \\[1ex]
&\approx P\left(Z \leq \frac{2.5 - 14}{\sqrt{14}}\right) + P\left(Z \geq \frac{25.5 - 14}{\sqrt{14}}\right) \\[1ex]
&= P\left(Z \leq \frac{-11.5}{3.742}\right) + P\left(Z \geq \frac{11.5}{3.742}\right) \\[1ex]
&= P(Z \leq -3.074) + P(Z \geq 3.074) \\[1ex]
&= 2 \times P(Z \geq 3.074) \\[1ex]
&\approx 2 \times 0.00106 \\[1ex]
&= 0.00212
\end{aligned}$$

Therefore:
$$\boxed {
0.001<\alpha <0.01
 }$$

## Question 5

Given:
- Original process: $\mu = 14$, LCL = $14 - 3\sqrt{14} = 2.774$
- Improved process: $\mu = 5$ 
- Measurements taken every $2$ hours

**Finding probability of detection per measurement**
Under the improved process, $C \sim \text{Poisson}(5)$. Detection occurs when $C \leq 2$ (below LCL):

$$\begin{aligned}
P(C \leq 2) &= P(C = 0) + P(C = 1) + P(C = 2) \\[1ex]
&= e^{-5} + 5e^{-5} + \frac{5^2}{2!}e^{-5} \\[1ex]
&= e^{-5}(1 + 5 + 12.5) \\[1ex]
&= 18.5 \times 0.00674 \\[1ex]
&= 0.1247
\end{aligned}$$

**Model as geometric distribution**
The number of measurements until first detection follows a [[PSM1_003 Some Discrete Probability  Distributions#Geometric Distribution|geometric distribution]] with parameter $p = 0.1247$.

Expected number of trials until first success:
$$E[N] = \frac{1}{p} = \frac{1}{0.1247} = 8.02$$

**Converting to hours**
Since measurements are taken every $2$ hours:
$$\text{Expected time} = 8.02 \times 2 = \boxed{16.04 \text{ hours}}$$

## Question 6

Moving average control chart with last $4$ wafers, where each wafer has $C_i \sim \text{Poisson}(14)$.

$$\text{MA} = \frac{C_1 + C_2 + C_3 + C_4}{4}$$

**Calculating mean of moving average**
$$\begin{aligned}
\mu_{\text{MA}} &= E[\text{MA}] = E\left[\frac{C_1 + C_2 + C_3 + C_4}{4}\right] \\[1ex]
&= \frac{1}{4}[E[C_1] + E[C_2] + E[C_3] + E[C_4]] \\[1ex]
&= \frac{1}{4}[14 + 14 + 14 + 14] \\[1ex]
&= 14
\end{aligned}$$

**Calculating variance of moving average**
Since wafers are independent over time:
$$\begin{aligned}
\sigma^2_{\text{MA}} &= \text{Var}[\text{MA}] = \text{Var}\left[\frac{C_1 + C_2 + C_3 + C_4}{4}\right] \\[1ex]
&= \frac{1}{16}\text{Var}[C_1 + C_2 + C_3 + C_4] \\[1ex]
&= \frac{1}{16}[\text{Var}(C_1) + \text{Var}(C_2) + \text{Var}(C_3) + \text{Var}(C_4)] \\[1ex]
&= \frac{1}{16}[14 + 14 + 14 + 14] \\[1ex]
&= \frac{56}{16} = 3.5
\end{aligned}$$

Therefore: $\sigma_{\text{MA}} = \sqrt{3.5} = \frac{\sqrt{14}}{2}$

**Calculating Upper Control Limit**
$$\begin{aligned}
\text{UCL} &= \mu_{\text{MA}} + 3\sigma_{\text{MA}} \\[1ex]
&= 14 + 3 \cdot \frac{\sqrt{14}}{2} \\[1ex]
&= \boxed{19.613}
\end{aligned}$$

# Part II
## Question 7
Given $L\sim N(49.3,0.4)$, then:
$$\begin{aligned}
P(X>50) & =P\left( Z> \dfrac{50-49.3}{0.4} \right) \\[1ex]
 & =1-P(Z<1.75)  \\[1ex]
 & =1-0.9599 \\[1ex]
 & =\boxed {
0.0401
 }
\end{aligned}$$

## Question 8
By the [[PSM1_005 Fundamental Sampling Distributions and Data Descriptions#Sampling Distribution of S²|sampling distributions]], for the first specification:
$$\begin{aligned}
P(s<0.6) & =P\left( \chi ^{2}<\dfrac{(10-1)\times 0.6^{2}}{0.4^{2}} \right) \\[1ex]
 & =\boxed {
P(\chi ^{2}<20.25)
 }
\end{aligned}$$

By the [[PSM1_005 Fundamental Sampling Distributions and Data Descriptions#The Central Limit Theorem|central limit theorem]], for the second specification, we want:
$$\begin{aligned}
P\left( \dfrac{50-\bar{X}}{0.4} >2\right) & =P(\bar{X}<49.2) \\[1ex]
 & =P\left( Z<\dfrac{49.2-49.3}{0.4/\sqrt{ 10 }} \right) \\[1ex]
 & =\boxed {
P(Z<-0.79)
 }
\end{aligned}$$

## Question 9
We can see from the calculation that the higher the $n$, the larger the absolute value on the right hand side of the inequality. That means that the probability of meeting the second step depends on the numerator, (depends on the exact value of $\mu$ - larger of smaller than $49.2$).

# Part III
## Question 10
The standard error measures the accuracy of the estimate, which is better for larger n, for fixed levels of time.

## Question 11
The outer dotted lines in the graph represent the $95\%$ confidence interval, but we want a $97.5\%$ confidence. Thing is - we need $97.5\%$ confidence that the parts will have a thickness *below* $\pu{2mm}$ - we don't need a bottom limit - which means we only care about the higher outer dotted line - which comes below $\pu{2mm}$ at around $\boxed{\pu{16.2\min} }$.

## Question 12
This is a classic case for the use of [[PSM1_001 Introduction and Probability#Bayes' Rule|bayes' rule]]. We know $P(T|D)=0.94$, that $P(T|D^{c})=0.025$, and that $P(D)=0.044$.

That means:
$$P(T^{c}|D^{c})=0.975,\qquad P(T^{c}|D)=0.06$$

We want to know $P(D|T)$.
$$\begin{aligned}
P(D|T) & =\dfrac{P(D\cap T)}{P(D\cap T)+P(D^{c}\cap T)} \\[1ex]
 & =\dfrac{P(D)P(T|D)}{P(D)P(T|D)+P(D^{c})P(T|D^{c})} \\[1ex]
 & =\dfrac{0.044\times 0.94}{0.044\times 0.94+0.956\times 0.025} \\[1ex]
 & =\boxed {
0.6338
 }
\end{aligned}$$

## Question 13
According to the [[PSM1_005 Fundamental Sampling Distributions and Data Descriptions#The Central Limit Theorem|central limit theorem]]:
$$\begin{aligned}
\small P({\mu}_{x}-0.05{\sigma}_{X}<\bar{X}<{\mu}_{x}+0.05{\sigma}_{X})  & = \small P(-0.05{\sigma}_{X}<\bar{X}-{\mu}_{X}<0.05{\sigma}_{X}) \\[1ex]
 & =\small P\left( \dfrac{-0.05{\sigma}_{X}}{{\sigma}_{X}/\sqrt{ 81 }}<\dfrac{\bar{X}-{\mu}_{X}}{{\sigma}_{X}/\sqrt{ 81 }}<\dfrac{0.05{\sigma}_{X}}{{\sigma}_{X}}/\sqrt{ 81 } \right) \\[1ex]
 & =P(-0.45<Z<0.45) \\[1ex]
 & =P(Z<0.45)-[1-P(Z<0.45)] \\[1ex]
 & =0.6736-0.3264 \\[1ex]
 & =\boxed {
0.3472
 }
\end{aligned}$$

# Part III

## Question 14

The width of a confidence interval for the difference between two means depends on:
$$\text{CI width} \propto t_{\alpha/2} \cdot \text{SE} = t_{\alpha/2} \cdot s_p \sqrt{\frac{1}{n_1} + \frac{1}{n_2}}$$

Where $s_p$ is the pooled standard deviation.

**Effect of removing outliers:**

1. **Sample size effect**: $n$ decreases from $81$ to $78$ 
   - This tends to increase the standard error slightly
   - Effect: $\sqrt{\frac{1}{n_1} + \frac{1}{n_2}}$ increases marginally

2. **Outlier removal effect**: Removing extreme values (times $> 60$ min)
   - Substantially reduces sample variability
   - Pooled standard deviation $s_p$ decreases significantly  
   - Effect: Much smaller $s_p$

**Dominant effect:**
The reduction in $s_p$ from removing outliers has a much larger impact than the small increase in $\sqrt{\frac{1}{n_1} + \frac{1}{n_2}}$ from reduced sample size.

**Conclusion:**
Since removing outliers dramatically reduces variability while the sample size reduction is minimal ($81 \to 78$ is only $3.7\%$ decrease), the overall effect is a reduction in standard error.

Therefore the new confidence interval will be narrower.

## Question 15
Assertion I: correct.
Assertion II: incorrect – we can see the difference in the two averages, but not the levels.

## Question 16
The boxplots show the errors, meaning $0$ is the for a perfect cut. We can see that the median lies at $\sim-1$, meaning the the range $-1<Y<1$ is about $\boxed{50\% }$. Which is within $1$ degree of the planned cut angle.

## Question 17

Given data:
$$\begin{aligned}
 & \text{Femoral flexion:}  &  &  \overline{x}= -1.1^{\circ} , \quad s = 1.2^{\circ} \\[1ex]
 & \text{Axial rotation:}  &  &  \overline{x} = 0.2^{\circ}, \quad s = 0.8^{\circ} \\[1ex]
 & \text{Tibia slope:}  &  &  \overline{x} = 0.4^{\circ}, \quad s = 1.0^{\circ} \\[1ex]
 & \text{Sample size:}  &  &  n = 52
\end{aligned}$$

For each measure, we test whether the mean error differs significantly from zero.

1. $H_0: \mu = 0$ (no systematic error)
2. $H_1: \mu \neq 0$ (systematic error exists)
3. $\alpha = 0.05$
4. Critical region: $|t| > t_{0.025,51} \approx 2.008$, where $t = \frac{\overline{x}}{s/\sqrt{n}}$

**Femoral flexion:**
$$t = \frac{(-1.1)\sqrt{52}}{1.2} = \frac{-7.93}{1.2} = -6.61$$

Since $|t| = 6.61 > 2.008$, reject $H_0$. This is significant.

**Axial rotation:**
$$t = \frac{(0.2)\sqrt{52}}{0.8} = \frac{1.442}{0.8} = 1.80$$

Since $|t| = 1.80 < 2.008$, do not reject $H_0$. This is not significant.

**Tibia slope:**
$$t = \frac{(0.4)\sqrt{52}}{1.0} = \frac{2.884}{1.0} = 2.88$$

Since $|t| = 2.88 > 2.008$, reject $H_0$. This is significant.

Therefore:
A significant difference for femoral flexion angle and for tibia slope, but not for femoral axial rotation.

## Question 18
The data come from the same $52$ knee replacements, so we need a paired test. The average difference is mathematically the same as the difference in averages. Therefore:

An appropriate statistical test is a two-sided paired t-test, and we know the observed average difference will be $0.2-0.4=-0.2$.

## Question 19

We have two groups (RAN and CAN) and want to compare the proportions of patients with different comorbidities (diabetes, hypertension, neither). This creates a contingency table:

|           | Diabetes | Hypertension | Neither |
|-----------|----------|--------------|---------|
| RAN group |    ?     |      ?       |    ?    |
| CAN group |    ?     |      ?       |    ?    |

We want to test whether group membership (RAN vs CAN) is independent of comorbidity status. This is a test of association between two categorical variables.

The appropriate test is a chi-squared test for association, which tests:
- $H_0$: Group membership and comorbidity are independent
- $H_1$: Group membership and comorbidity are associated

## Question 20

From the power curve graph with Error Std Dev $=1$, Difference in Means = $1.5$, and $\alpha=0.05$:

**Assertion I:**
The probability of getting a $p$-value less than 0.05 when there truly is a difference is the definition of statistical power. From the graph, at total sample size $16$, the power appears to be approximately 0.80 or slightly above.

Since the true difference in means is $1.55$ (very close to the graph's $1.5$), the power would be very similar. Therefore, the power is not "less than 0.80" but rather around 0.80 or above.

**Assertion I is incorrect.**

**Assertion II Analysis:** 
Power depends on the effect size, which is the standardized difference:
$$\text{Effect size} = \frac{\text{Difference in means}}{\text{Standard deviation}}$$

Original: $\frac{1.5}{1} = 1.5$

New scenario: $\frac{12}{8} = 1.5$

Since both effect sizes are identical ($1.5$) and alpha remains $0.05$, the power curves will indeed be identical.

**Assertion II is correct.**
