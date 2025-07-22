---
aliases:
---
# Part I
## Question 1
We know that $p=0.6$. Therefore, using a [[PSM1_003 Some Discrete Probability  Distributions#Geometric Distribution|geometric distribution]]:
$$\begin{aligned}
P(X\leq  3) & =g(1;p)+g(2;p)+g(3;p) \\[1ex]
 & =p(1-p)^{0}+p(1-p)^{1}+p(1-p)^{2} \\[1ex]
 & =\boxed {
0.936
 }
\end{aligned}$$

## Question 2
First, we notice that:
$$\begin{aligned}
P(X=3) & =g(3;p) \\[1ex]
 & =p(1-p)^{2} \\[1ex]
 & =0.096
\end{aligned}$$
Now we need to find $P(X=3\mid X\leq 3)$. According to [[PSM1_001 Introduction and Probability#Conditional Probability|conditional probability]]:
$$\begin{aligned}
P(X=3\mid X\leq  3) & =\dfrac{P((X=3)\cap (X\leq  3))}{P(X\leq  3)} \\[1ex]
 & =\dfrac{P(X=3)}{P(X\leq  3)} \\[1ex]
 & =\dfrac{0.096}{0.936} \\[1ex]
 & =\boxed {
0.10256
 }
\end{aligned}$$

## Question 3
According to [[PSM1_003 Some Discrete Probability  Distributions#Poisson Distribution and the Poisson Process|poisson distribution]]:
$$\begin{aligned}
P(X=4) & =p(4;0.33) \\[1ex]
 & =\dfrac{0.33^{4}e^{-0.33}}{4!} \\[1ex]
 & =\boxed {
0.00035524
 }
\end{aligned}$$

## Question 4
First, we notice that:
$$\begin{aligned}
P(X=0) & =p(0;0.33) \\[1ex]
 & =0.71892
\end{aligned}$$
Therefore, using the multiplication principle for independent events, the probability of this specific scenario is:
$$\begin{aligned}
P(A) & =P(X=0)^{11}\cdot P(X=4) \\[1ex]
 & =0.71892^{11}\cdot 0.00035524 \\[1ex]
 & =\boxed {
\pu {9.4197e-6 }
 }
\end{aligned}$$

## Question 5
Since any one of the $12$ total games could be the one with exactly $4$ ripped jerseys, we need to account for all possibilities using the multiplication principle:
$$\begin{aligned}
P(B) & =\binom{12}{1}\times P(X=4) \times P(X=0)^{11} \\[1ex]
 & =12 \times 0.00035524 \times 0.71892^{11} \\[1ex]
 & =\boxed {
0.00011304
 }
\end{aligned}$$

## Question 6
We are asked what is $P((R=4)\cap(W=0))$.
First, we notice that:
$$\begin{aligned}
 & P(R=4)=\binom{11}{4}\times 0.12^{4}\times 0.88^{7} =0.027965 \\[1ex]
 & P(W=0)=\binom{22}{0}\times 0.12^{0}\times 0.88^{22}=0.060065
\end{aligned}$$
Therefore, assuming they are independent:
$$\begin{aligned}
P((R=4)\cap(W=0)) & =P(R=4)\times P(W=0) \\[1ex]
 & =\boxed {
0.0016797
 }
\end{aligned}$$

## Question 7
The probabilities for each jersey being defective are different this time - we need to use [[PSM1_003 Some Discrete Probability  Distributions#Hypergeometric Distribution|hypergeometric distributions]]:
$$\begin{aligned}
 & P(R=4)=\dfrac{\binom{6}{4}\binom{50-6}{11-4}}{\binom{50}{11}}=0.015388\\[1ex]
 & P(W=0)=\dfrac{\binom{6}{0}\binom{50-6}{22-0}}{\binom{50}{22}}=0.023708
\end{aligned}$$
Therefore, assuming they are independent:
$$\begin{aligned}
P((R=4)\cap(W=0)) & =P(R=4)\times P(W=0) \\[1ex]
 & =\boxed {
0.00036483
 }
\end{aligned}$$


# Part II
## Question 8
We need to find $P(T<24)$. Because we know it has a [[PSM1_004 Some Continuous Probability Distributions#Normal Distribution|normal distribution]] with $\mu=20$ and $\sigma=3$, we can use the [[PSM1_004 Some Continuous Probability Distributions#Standardization and the Standard Normal Distribution|standard normal curve]]:
$$\begin{aligned}
P(T<24) & =P\left( Z<\dfrac{24-20}{3} \right) \\[1ex]
 & =P(Z<1.\bar{3}) \\[1ex]
 & =\boxed {
0.90879
 }
\end{aligned}$$

## Question 9


Using a [[PSM1_003 Some Discrete Probability  Distributions#Binomial Distribution|binomial distribution]] and our previous result:
$$\begin{aligned}
P(A) & =\binom{10}{8}\times0.90879^{8}\times 0.09121^{2} \\[1ex]
 & =\boxed {
0.17418
 }
\end{aligned}$$

## Question 10

We denote:
- ${X}_{1}$ - no fine.
- ${X}_{2}$ - small fine.
- ${X}_{3}$ - large fine.

We already found that for a single project $P({X}_{1})=0.90879$.
Furthermore:
$$\begin{aligned}
 & P({X}_{2})=P(T>26)=P\left( Z>\dfrac{26-20}{3} \right)=1-P(Z<2)=0.0228\\[1ex]
 & P({X}_{3})=P(24<T<26)=1-P(T<24)-P(T>26)=0.06841
\end{aligned}$$

Calculating the expected fine for each case and then summing them up yields:
$$\begin{aligned}
E(F) & =0\times P({X}_{1})+1000\times P({X}_{2})+8000\times P({X}_{3}) \\[1ex]
 & =250.81
\end{aligned}$$
The variance:
$$\begin{aligned}
{{{\sigma}_{F}}}^{2} & =E(F^{2})-[E(F)]^{2} \\[1ex]
 & =\pu{1527610-\pu{62905}} \\[1ex]
 & =\pu{1464705}
\end{aligned}$$
Which means:
$${\sigma}_{F}=1210$$

Therefore, the expected fine for $120$ projects is:
$$\begin{aligned}
E({F}_{120}) & =120\times E(F) \\[1ex]
 & =\boxed {
\pu{30097.2}
 }
\end{aligned}$$

And the variance:
$$\begin{aligned}
{\sigma}_{{F}_{120}} & =\sqrt{ 120 }{\sigma}_{F} \\[1ex]
 & =\boxed {
13257
 }
\end{aligned}$$
## Question 11
Using the previous answer and the standard normal curve:
$$\begin{aligned}
P({F}_{120}<40000) & =P\left( Z<\dfrac{40000-30097.2}{13257} \right) \\[1ex]
 & =P(Z<0.747) \\[1ex]
 & \approx \boxed {
0.7734
 }
\end{aligned}$$

# Part III
## Question 12
The [[PSM1_006 One- and Two-Sample  Estimation Problems#Concept of a Large-Sample Confidence Interval|confidence interval]] is:
$$\begin{gathered}
 {z}_{0.975} \dfrac{\sigma}{\sqrt{ n }}= \dfrac{1262.93-1255.07}{2} \\[1ex]
1.96\cdot \dfrac{8.5}{\sqrt{ n }}=3.93 \\[1ex]
\sqrt{ n }=4.239 \\[1ex]
\boxed {
n\approx 18
 }
\end{gathered}$$

## Question 13
We know that $\mu=1265$ doesn't sit inside the $95\%$ confidence bounds. Therefore, we gather that ${H}_{0}$ is rejected, and $\boxed{p<0.05 }$.

## Question 14
Assuming $\sigma$ stays the same, the $1295$ observation doesn't affect the *width* of the sample, as it is determined by our choice of $\alpha$, the standard deviation $\sigma$, and the sample size $n$.

## Question 15
The new confidence interval will be *wider*, as can be seen from the confidence interval definition.

# Part IV

## Question 16
Simply reading the table gives:
$$\begin{aligned}
 & \text{Predicted-Strength7days}(*)=12+0.6274\times29.6\approx \boxed {
30.6
 } \\[1ex]
 & \text{Residual-Strength7days}(*)=30.1-\text{Predicted-Strength7days}(*)\approx \boxed {
-0.48
 }
\end{aligned}$$

## Question 17
For a $95\%$ confidence interval for the slope, we use:
$$\text{slope estimate} \pm t_{\alpha/2, n-2} \times \text{SE(slope)}$$

From the statistical output:
- Slope estimate $=0.6274222 \approx 0.627$
- Standard Error $= 0.25226 \approx 0.252$
- Degrees of freedom $= n-2 = 23-2 = 21$
- For $95\%$ CI: $t_{0.025,21} \approx 2$

Therefore, the $95\%$ confidence interval is:
$$\boxed{0.627 \pm (2 \times 0.252)}$$

## Question 18
We would *not* expect the following to the variance of the points above and below the fitted line will be smaller

# Part V

## Question 19
According to [[PSM1_007 One- and Two-Sample Tests of  Hypotheses#The Probability of a Type I Error|error types]], The null hypothesis will not be rejected and we might be making a Type II error.

## Question 20
For this two-stage protocol, we need to find the overall Type I error rate.

Under $H_0$ (null hypothesis is true), we reject $H_0$ if:
1. We reject at Stage 1 (probability = $\alpha_{\text{single}}$), OR
2. We fail to reject at Stage 1 AND reject at Stage 2

For Stage 2 to occur:
- Must first NOT reject at Stage 1: probability = $(1-\alpha_{\text{single}})$  
- Then reject at Stage 2: probability = $\alpha_{\text{single}}$
- Combined probability = $(1-\alpha_{\text{single}}) \times \alpha_{\text{single}}$

Overall Type I Error:
$$\boxed {
\begin{aligned}
P(\text{Reject } H_0 \text{ under } H_0) &= \alpha_{\text{single}} + (1-\alpha_{\text{single}}) \times \alpha_{\text{single}}
\end{aligned}
 }$$

