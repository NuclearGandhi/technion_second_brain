---
aliases:
  - hypothesis testing
  - null hypothesis
  - alternative hypothesis
  - type I error
  - type II error
  - significance level
  - p-value
  - critical region
  - test statistic
  - power of test
  - one-tailed test
  - two-tailed test
---

# Statistical Hypotheses: General Concepts

Often, the problem confronting the scientist or engineer is not so much the estimation of a population parameter, as discussed in the [[PSM1_007 One- and Two-Sample Tests of  Hypotheses#One- and Two-Sample Tests of Hypotheses|previous chapter]] , but rather the formation of a data-based decision procedure that can produce a conclusion about some scientific system. For example, a medical researcher may decide on the basis of experimental evidence whether coffee drinking increases the risk of cancer in humans; an engineer might have to decide on the basis of sample data whether there is a difference between the accuracy of two kinds of gauges; or a sociologist might wish to collect appropriate data to enable him or her to decide whether a person's blood type and eye color are independent variables. In each of these cases, the scientist or engineer postulates or conjectures something about a system. In addition, each must make use of experimental data and make a decision based on the data. In each case, the conjecture can be put in the form of a statistical hypothesis. Procedures that lead to the acceptance or rejection of statistical hypotheses such as these comprise a major area of statistical inference. First, let us define precisely what we mean by a statistical hypothesis.

>[!def] Definition:
>A **statistical hypothesis** is an assertion or conjecture concerning one or more populations.

The truth or falsity of a statistical hypothesis is never known with absolute certainty unless we examine the entire population. This, of course, would be impractical in most situations. Instead, we take a random sample from the population of interest and use the data contained in this sample to provide evidence that either supports or does not support the hypothesis. Evidence from the sample that is inconsistent with the stated hypothesis leads to a rejection of the hypothesis.

## The Role of Probability in Hypothesis Testing

It should be made clear to the reader that the decision procedure must include an awareness of the probability of a wrong conclusion. For example, suppose that the hypothesis postulated by the engineer is that the fraction defective $p$ in a certain process is $0.10$. The experiment is to observe a random sample of the product in question. Suppose that $100$ items are tested and $12$ items are found defective. It is reasonable to conclude that this evidence does not refute the condition that the binomial parameter $p = 0.10$, and thus it may lead one not to reject the hypothesis. However, it also does not refute $p = 0.12$ or perhaps even $p = 0.15$. As a result, the reader must be accustomed to understanding that rejection of a hypothesis implies that the sample evidence refutes it. Put another way, rejection means that there is a small probability of obtaining the sample information observed when, in fact, the hypothesis is true. For example, for our proportion-defective hypothesis, a sample of $100$ revealing $20$ defective items is certainly evidence for rejection. Why? If, indeed, $p = 0.10$, the probability of obtaining $20$ or more defectives is approximately $0.002$. With the resulting small risk of a wrong conclusion, it would seem safe to reject the hypothesis that $p = 0.10$. In other words, rejection of a hypothesis tends to all but "rule out" the hypothesis. On the other hand, it is very important to emphasize that acceptance or, rather, failure to reject does not rule out other possibilities. As a result, the firm conclusion is established by the data analyst when a hypothesis is rejected.

The formal statement of a hypothesis is often influenced by the structure of the probability of a wrong conclusion. If the scientist is interested in strongly supporting a contention, he or she hopes to arrive at the contention in the form of rejection of a hypothesis. If the medical researcher wishes to show strong evidence in favor of the contention that coffee drinking increases the risk of cancer, the hypothesis tested should be of the form "there is no increase in cancer risk produced by drinking coffee." As a result, the contention is reached via a rejection. Similarly, to support the claim that one kind of gauge is more accurate than another, the engineer tests the hypothesis that there is no difference in the accuracy of the two kinds of gauges. The foregoing implies that when the data analyst formalizes experimental evidence on the basis of hypothesis testing, the formal statement of the hypothesis is very important.

## The Null and Alternative Hypotheses

The structure of hypothesis testing will be formulated with the use of the term **null hypothesis**, which refers to any hypothesis we wish to test and is denoted by $H_0$. The rejection of $H_0$ leads to the acceptance of an **alternative hypothesis**, denoted by $H_1$. An understanding of the different roles played by the null hypothesis ($H_0$) and the alternative hypothesis ($H_1$) is crucial to one's understanding of the rudiments of hypothesis testing. The alternative hypothesis $H_1$ usually represents the question to be answered or the theory to be tested, and thus its specification is crucial. The null hypothesis $H_0$ nullifies or opposes $H_1$ and is often the logical complement to $H_1$. As the reader gains more understanding of hypothesis testing, he or she should note that the analyst arrives at one of the two following conclusions:

1. **reject $H_0$ in favor of $H_1$** because of sufficient evidence in the data or
2. **fail to reject $H_0$** because of insufficient evidence in the data.

Note that the conclusions do not involve a formal and literal "accept $H_0$." The statement of $H_0$ often represents the "status quo" in opposition to the new idea, conjecture, and so on, stated in $H_1$, while failure to reject $H_0$ represents the proper conclusion. In our binomial example, the practical issue may be a concern that the historical defective probability of $0.10$ no longer is true. Indeed, the conjecture may be that $p$ exceeds $0.10$. We may then state

$$\begin{aligned}
 & H_0: p = 0.10 \\[1ex]
 & H_1: p > 0.10
\end{aligned}$$

Now $12$ defective items out of $100$ does not refute $p = 0.10$, so the conclusion is "fail to reject $H_0$." However, if the data produce $20$ out of $100$ defective items, then the conclusion is "reject $H_0$" in favor of $H_1: p > 0.10$.

Though the applications of hypothesis testing are quite abundant in scientific and engineering work, perhaps the best illustration for a novice lies in the predicament encountered in a jury trial. The null and alternative hypotheses are

$$\begin{aligned}
 & H_0: \text{defendant is innocent} \\[1ex]
 & H_1: \text{defendant is guilty}
\end{aligned}$$

The indictment comes because of suspicion of guilt. The hypothesis $H_0$ (the status quo) stands in opposition to $H_1$ and is maintained unless $H_1$ is supported by evidence "beyond a reasonable doubt." However, "failure to reject $H_0$" in this case does not imply innocence, but merely that the evidence was insufficient to convict. So the jury does not necessarily accept $H_0$ but fails to reject $H_0$.

# Testing a Statistical Hypothesis

To illustrate the concepts used in testing a statistical hypothesis about a population, we present the following example. A certain type of cold vaccine is known to be only $25\%$ effective after a period of $2$ years. To determine if a new and somewhat more expensive vaccine is superior in providing protection against the same virus for a longer period of time, suppose that $20$ people are chosen at random and inoculated. (In an actual study of this type, the participants receiving the new vaccine might number several thousand. The number $20$ is being used here only to demonstrate the basic steps in carrying out a statistical test.) If more than $8$ of those receiving the new vaccine surpass the $2$-year period without contracting the virus, the new vaccine will be considered superior to the one presently in use. The requirement that the number exceed $8$ is somewhat arbitrary but appears reasonable in that it represents a modest gain over the $5$ people who could be expected to receive protection if the $20$ people had been inoculated with the vaccine already in use. We are essentially testing the null hypothesis that the new vaccine is equally effective after a period of $2$ years as the one now commonly used. The alternative hypothesis is that the new vaccine is in fact superior. This is equivalent to testing the hypothesis that the binomial parameter for the probability of a success on a given trial is $p = 1/4$ against the alternative that $p > 1/4$. This is usually written as follows:

$$\begin{aligned}
 & H_0: p = 0.25 \\[1ex]
 & H_1: p > 0.25
\end{aligned}$$

## The Test Statistic

The test statistic on which we base our decision is $X$, the number of individuals in our test group who receive protection from the new vaccine for a period of at least $2$ years. The possible values of $X$, from $0$ to $20$, are divided into two groups: those numbers less than or equal to $8$ and those greater than $8$. All possible scores greater than $8$ constitute the **critical region**. The last number that we observe in passing into the critical region is called the **critical value**. In our illustration, the critical value is the number $8$. Therefore, if $x > 8$, we reject $H_0$ in favor of the alternative hypothesis $H_1$. If $x \leq 8$, we fail to reject $H_0$. This decision criterion is illustrated in the following figure.

![[{585311B3-03F0-4ACF-83B6-F57FDF94A7AC}.png|bookhue|600]]
>Decision criterion for testing $p = 0.25$ versus $p > 0.25$. [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]].

## The Probability of a Type I Error

The decision procedure just described could lead to either of two wrong conclusions. For instance, the new vaccine may be no better than the one now in use ($H_0$ true) and yet, in this particular randomly selected group of individuals, more than $8$ surpass the $2$-year period without contracting the virus. We would be committing an error by rejecting $H_0$ in favor of $H_1$ when, in fact, $H_0$ is true. Such an error is called a **type I error**.

>[!def] Definition:
>Rejection of the null hypothesis when it is true is called a **type I error**.

A second kind of error is committed if $8$ or fewer of the group surpass the $2$-year period successfully and we are unable to conclude that the vaccine is better when it actually is better ($H_1$ true). Thus, in this case, we fail to reject $H_0$ when in fact $H_0$ is false. This is called a **type II error**.

>[!def] Definition:
>Nonrejection of the null hypothesis when it is false is called a **type II error**.

In testing any statistical hypothesis, there are four possible situations that determine whether our decision is correct or in error. These four situations are summarized in the following table:

| | $H_0$ is true | $H_0$ is false |
|---|---|---|
| **Do not reject $H_0$** | Correct decision | Type II error |
| **Reject $H_0$** | Type I error | Correct decision |

The probability of committing a type I error, also called the **level of significance**, is denoted by the Greek letter $\alpha$. In our illustration, a type I error will occur when more than $8$ individuals inoculated with the new vaccine surpass the $2$-year period without contracting the virus and researchers conclude that the new vaccine is better when it is actually equivalent to the one in use. Hence, if $X$ is the number of individuals who remain free of the virus for at least $2$ years,

$$\begin{aligned}
\alpha &  = P(\text{type I error})  \\[1ex]
 & = P\left(X > 8 \text{ when } p = \frac{1}{4}\right)  \\[1ex]
 & = \sum_{x=9}^{20} b\left(x; 20, \frac{1}{4}\right) \\[1ex]
 & = 1 - \sum_{x=0}^{8} b\left(x; 20, \frac{1}{4}\right)  \\[1ex]
 & = 1 - 0.9591  \\[2ex]
 & = 0.0409
\end{aligned}$$

We say that the null hypothesis, $p = 1/4$, is being tested at the $\alpha = 0.0409$ level of significance. Sometimes the level of significance is called the **size of the test**. A critical region of size $0.0409$ is very small, and therefore it is unlikely that a type I error will be committed. Consequently, it would be most unusual for more than $8$ individuals to remain immune to a virus for a 2-year period using a new vaccine that is essentially equivalent to the one now on the market.

## The Probability of a Type II Error

The probability of committing a type II error, denoted by $\beta$, is impossible to compute unless we have a specific alternative hypothesis. If we test the null hypothesis that $p = 1/4$ against the alternative hypothesis that $p = 1/2$, then we are able to compute the probability of not rejecting $H_0$ when it is false. We simply find the probability of obtaining $8$ or fewer in the group that surpass the $2$-year period when $p = 1/2$. In this case,

$$\begin{aligned}
\beta  & = P(\text{type II error})  \\[1ex]
 & = P\left(X \leq 8 \text{ when } p = \frac{1}{2}\right)  \\[1ex]
 & = \sum_{x=0}^{8} b\left(x; 20, \frac{1}{2}\right)  \\[2ex]
 & = 0.2517
\end{aligned}$$

This is a rather high probability, indicating a test procedure in which it is quite likely that we shall reject the new vaccine when, in fact, it is superior to what is now in use. Ideally, we like to use a test procedure for which the type I and type II error probabilities are both small. It is possible that the director of the testing program is willing to make a type II error if the more expensive vaccine is not significantly superior. In fact, the only time he wishes to guard against the type II error is when the true value of $p$ is at least $0.7$. If $p = 0.7$, this test procedure gives

$$\begin{aligned}
\beta  & = P(\text{type II error})  \\[1ex]
 & = P(X \leq 8 \text{ when } p = 0.7)  \\[1ex]
 & = \sum_{x=0}^{8} b(x; 20, 0.7)  \\[2ex]
 & = 0.0051
\end{aligned}$$

With such a small probability of committing a type II error, it is extremely unlikely that the new vaccine would be rejected when it was $70\%$ effective after a period of $2$ years. As the alternative hypothesis approaches unity, the value of $\beta$ diminishes to zero.

## The Role of $\alpha$, $\beta$, and Sample Size

Let us assume that the director of the testing program is unwilling to commit a type II error when the alternative hypothesis $p = 1/2$ is true, even though we have found the probability of such an error to be $\beta = 0.2517$. It is always possible to reduce $\beta$ by increasing the size of the critical region. For example, consider what happens to the values of $\alpha$ and $\beta$ when we change our critical value to $7$ so that all scores greater than $7$ fall in the critical region and those less than or equal to $7$ fall in the nonrejection region. Now, in testing $p = 1/4$ against the alternative hypothesis that $p = 1/2$, we find that

$$\begin{aligned}
\alpha  & = \sum_{x=8}^{20} b\left(x; 20, \frac{1}{4}\right)  \\[1ex]
 & = 1 - \sum_{x=0}^{7} b\left(x; 20, \frac{1}{4}\right)  \\[1ex]
 & = 1 - 0.8982  \\[2ex]
 & = 0.1018
\end{aligned}$$

and

$$\beta = \sum_{x=0}^{7} b\left(x; 20, \frac{1}{2}\right) = 0.1316$$

By adopting a new decision procedure, we have reduced the probability of committing a type II error at the expense of increasing the probability of committing a type I error. For a fixed sample size, a decrease in the probability of one error will usually result in an increase in the probability of the other error. Fortunately, the probability of committing both types of error can be reduced by increasing the sample size. Consider the same problem using a random sample of $100$ individuals. If more than $36$ of the group surpass the $2$-year period, we reject the null hypothesis that $p = 1/4$ and accept the alternative hypothesis that $p > 1/4$. The critical value is now $36$. All possible scores above $36$ constitute the critical region, and all possible scores less than or equal to $36$ fall in the acceptance region. To determine the probability of committing a type I error, we shall use the normal curve approximation with

$$\begin{gathered}
\begin{aligned}
\mu  & = np  \\[1ex]
 & = (100)\left(\frac{1}{4}\right)  \\[1ex]
 & = 25 
\end{aligned}\qquad  \text{and}\qquad\begin{aligned}
 \sigma  & = \sqrt{npq}  \\[1ex]
 & = \sqrt{(100)(1/4)(3/4)}  \\[1ex]
 & = 4.33
\end{aligned}
\end{gathered}$$

![[{50BAB9E4-A753-48D2-89DA-2EB9B928682B}.png|bookhue|500]]
>Probability of a type I error. [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]].

Referring to the figure, we need the area under the normal curve to the right of $x = 36.5$. The corresponding $z$-value is

$$z = \frac{36.5 - 25}{4.33} = 2.66$$

From a table we can find that:
$$\begin{aligned}
\alpha  & = P(\text{type I error})  \\[1ex]
 & = P\left(X > 36 \text{ when } p = \frac{1}{4}\right)  \\[1ex]
 & \approx P(Z > 2.66)  \\[2ex]
 & = 1 - P(Z < 2.66) = 1 - 0.9961  \\[2ex]
 & = 0.0039
\end{aligned}$$

If $H_0$ is false and the true value of $H_1$ is $p = 1/2$, we can determine the probability of a type II error using the normal curve approximation with

$$\begin{gathered}
\begin{aligned}
\mu  & = np  \\[1ex]
 & = (100)(1/2)  \\[1ex]
 & = 50
\end{aligned} \qquad \text{and} \qquad \begin{aligned}
\sigma  & = \sqrt{npq} \\[1ex]
 &  = \sqrt{(100)(1/2)(1/2)}  \\[1ex]
 & = 5
\end{aligned}
\end{gathered}$$

The probability of a value falling in the nonrejection region when $H_0$ is true is given by the area of the shaded region to the left of $x = 36.5$ in the following figure. The $z$-value corresponding to $x = 36.5$ is

$$z = \frac{36.5 - 50}{5} = -2.7$$

![[{B5C7C398-5094-4EB5-B9BC-9E740D432EF0}.png|bookhue|500]]
>Probability of a type II error. [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]].

Therefore,

$$\begin{aligned}
\beta  & = P(\text{type II error})  \\[1ex]
 & = P\left(X \leq 36 \text{ when } p = \frac{1}{2}\right)  \\[1ex]
 & \approx P(Z < -2.7)  \\[2ex]
 & = 0.0035
\end{aligned}$$

Obviously, the type I and type II errors will rarely occur if the experiment consists of $100$ individuals. The illustration above underscores the strategy of the scientist in hypothesis testing. After the null and alternative hypotheses are stated, it is important to consider the sensitivity of the test procedure. By this we mean that there should be a determination, for a fixed $\alpha$, of a reasonable value for the probability of wrongly accepting $H_0$ (i.e., the value of $\beta$) when the true situation represents some important deviation from $H_0$. A value for the sample size can usually be determined for which there is a reasonable balance between the values of $\alpha$ and $\beta$ computed in this fashion. The vaccine problem provides an illustration.

## Illustration with a Continuous Random Variable

The concepts discussed here for a discrete population can be applied equally well to continuous random variables. Consider the null hypothesis that the average weight of male students in a certain college is $68$ kilograms against the alternative hypothesis that it is unequal to $68$. That is, we wish to test

$$\begin{aligned}
 & H_0: \mu = 68 \\[1ex]
 & H_1: \mu \neq 68
\end{aligned}$$
The alternative hypothesis allows for the possibility that $\mu < 68$ or $\mu > 68$. A sample mean that falls close to the hypothesized value of $68$ would be considered evidence in favor of $H_0$. On the other hand, a sample mean that is considerably less than or more than 68 would be evidence inconsistent with $H_0$ and therefore favoring $H_1$. The sample mean is the test statistic in this case. A critical region for the test statistic might arbitrarily be chosen to be the two intervals $\overline{x} < 67$ and $\overline{x} > 69$. The nonrejection region will then be the interval $67 \leq \overline{x} \leq 69$. This decision criterion is illustrated in the following figure.

![[{1BF73E55-70BD-44EE-AE56-4CB4F412C226}.png|bookhue|600]]
>Critical region (in blue). [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]].

Let us now use the decision criterion to calculate the probabilities of committing type I and type II errors when testing the null hypothesis that $\mu = 68$ kilograms against the alternative that $\mu \neq 68$ kilograms. Assume the standard deviation of the population of weights to be $\sigma = 3.6$. For large samples, we may substitute $s$ for $\sigma$ if no other estimate of $\sigma$ is available. Our decision statistic, based on a random sample of size $n = 36$, will be $\overline{X}$, the most efficient estimator of $\mu$. From the Central Limit Theorem, we know that the sampling distribution of $\overline{X}$ is approximately normal with standard deviation

$$\sigma_{\overline{X}} = \frac{\sigma}{\sqrt{n}} = \frac{3.6}{6} = 0.6$$

The probability of committing a type I error, or the level of significance of our test, is equal to the sum of the areas that have been shaded in each tail of the distribution in the following figure. Therefore,

$$\alpha = P(\overline{X} < 67 \text{ when } \mu = 68) + P(\overline{X} > 69 \text{ when } \mu = 68)$$

![[{C584F27F-5410-424D-AFE3-CFE7743287F3}.png|bookhue|500]]
>Critical region for testing $\mu = 68$ versus $\mu \neq 68$. [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]].

The $z$-values corresponding to $\overline{x}_1 = 67$ and $\overline{x}_2 = 69$ when $H_0$ is true are

$$z_1 = \frac{67 - 68}{0.6} = -1.67 \quad \text{and} \quad z_2 = \frac{69 - 68}{0.6} = 1.67$$

Therefore,

$$\begin{aligned}
\alpha  & = P(Z < -1.67) + P(Z > 1.67)  \\[1ex]
 & = 2P(Z < -1.67)  \\[1ex]
 & = 0.0950
\end{aligned}$$

Thus, $9.5\%$ of all samples of size $36$ would lead us to reject $\mu = 68$ kilograms when, in fact, it is true. To reduce $\alpha$, we have a choice of increasing the sample size or widening the fail-to-reject region. Suppose that we increase the sample size to $n = 64$. Then $\sigma_{\overline{X}} = 3.6/8 = 0.45$. Now

$$z_1 = \frac{67 - 68}{0.45} = -2.22 \quad \text{and} \quad z_2 = \frac{69 - 68}{0.45} = 2.22$$

Hence,

$$\alpha = P(Z < -2.22) + P(Z > 2.22) = 2P(Z < -2.22) = 0.0264$$

The reduction in $\alpha$ is not sufficient by itself to guarantee a good testing procedure. We must also evaluate $\beta$ for various alternative hypotheses. If it is important to reject $H_0$ when the true mean is some value $\mu \geq 70$ or $\mu \leq 66$, then the probability of committing a type II error should be computed and examined for the alternatives $\mu = 66$ and $\mu = 70$. Because of symmetry, it is only necessary to consider the probability of not rejecting the null hypothesis that $\mu = 68$ when the alternative $\mu = 70$ is true. A type II error will result when the sample mean $\overline{x}$ falls between $67$ and $69$ when $H_1$ is true. Therefore, referring to the following figure, we find that

$$\beta = P(67 \leq \overline{X} \leq 69 \text{ when } \mu = 70)$$

![[{61203599-CD31-4628-A1DE-FC053550038A}.png|bookhue|500]]
>Probability of type II error for testing $\mu = 68$ versus $\mu = 70$. [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]].

The $z$-values corresponding to $\overline{x}_1 = 67$ and $\overline{x}_2 = 69$ when $H_1$ is true are

$$z_1 = \frac{67 - 70}{0.45} = -6.67 \quad \text{and} \quad z_2 = \frac{69 - 70}{0.45} = -2.22$$

Therefore,

$$\begin{aligned}
\beta  & = P(-6.67 < Z < -2.22)  \\[1ex]
 & = P(Z < -2.22) - P(Z < -6.67)  \\[1ex]
 & = 0.0132 - 0.0000  \\[1ex]
 & = 0.0132
\end{aligned}$$

If the true value of $\mu$ is the alternative $\mu = 66$, the value of $\beta$ will again be $0.0132$. For all possible values of $\mu < 66$ or $\mu > 70$, the value of $\beta$ will be even smaller when $n = 64$, and consequently there would be little chance of not rejecting $H_0$ when it is false. The probability of committing a type II error increases rapidly when the true value of $\mu$ approaches, but is not equal to, the hypothesized value. Of course, this is usually the situation where we do not mind making a type II error. For example, if the alternative hypothesis $\mu = 68.5$ is true, we do not mind committing a type II error by concluding that the true answer is $\mu = 68$. The probability of making such an error will be high when $n = 64$. Referring to the following figure, we have

$$\beta = P(67 \leq \overline{X} \leq 69 \text{ when } \mu = 68.5)$$

![[{8446B0DB-92D6-4ACA-A4EE-6E5A9BF71A1C}.png|bookhue|500]]
>Type II error for testing $\mu = 68$ versus $\mu = 68.5$. [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]].

The $z$-values corresponding to $\overline{x}_1 = 67$ and $\overline{x}_2 = 69$ when $\mu = 68.5$ are

$$z_1 = \frac{67 - 68.5}{0.45} = -3.33 \quad \text{and} \quad z_2 = \frac{69 - 68.5}{0.45} = 1.11$$

Therefore,

$$\begin{aligned}
\beta  & = P(-3.33 < Z < 1.11)  \\[1ex]
 & = P(Z < 1.11) - P(Z < -3.33)  \\[1ex]
 & = 0.8665 - 0.0004  \\[1ex]
 & = 0.8661
\end{aligned}$$

The preceding examples illustrate the following important properties:

>[!notes] Notes: Important Properties of a Test of Hypothesis
>1. The type I error and type II error are related. A decrease in the probability of one generally results in an increase in the probability of the other.
>2. The size of the critical region, and therefore the probability of committing a type I error, can always be reduced by adjusting the critical value(s).
>3. An increase in the sample size $n$ will reduce $\alpha$ and $\beta$ simultaneously.
>4. If the null hypothesis is false, $\beta$ is a maximum when the true value of a parameter approaches the hypothesized value. The greater the distance between the true value and the hypothesized value, the smaller $\beta$ will be.

One very important concept that relates to error probabilities is the notion of the power of a test.

>[!def] Definition:
>The **power of a test** is the probability of rejecting $H_0$ given that a specific alternative is true.

The power of a test can be computed as $1 - \beta$. Often different types of tests are compared by contrasting power properties. Consider the previous illustration, in which we were testing $H_0: \mu = 68$ and $H_1: \mu \neq 68$. As before, suppose we are interested in assessing the sensitivity of the test. The test is governed by the rule that we do not reject $H_0$ if $67 \leq \overline{x} \leq 69$. We seek the capability of the test to properly reject $H_0$ when indeed $\mu = 68.5$. We have seen that the probability of a type II error is given by $\beta = 0.8661$. Thus, the power of the test is $1 - 0.8661 = 0.1339$. In a sense, the power is a more succinct measure of how sensitive the test is for detecting differences between a mean of $68$ and a mean of $68.5$. In this case, if $\mu$ is truly $68.5$, the test as described will properly reject $H_0$ only $13.39\%$ of the time. As a result, the test would not be a good one if it was important that the analyst have a reasonable chance of truly distinguishing between a mean of $68.0$ (specified by $H_0$) and a mean of $68.5$. From the foregoing, it is clear that to produce a desirable power (say, greater than $0.8$), one must either increase $\alpha$ or increase the sample size.

So far in this chapter, much of the discussion of hypothesis testing has focused on foundations and definitions. In the sections that follow, we get more specific and put hypotheses in categories as well as discuss tests of hypotheses on various parameters of interest. We begin by drawing the distinction between a one-sided and a two-sided hypothesis.

## One- and Two-Tailed Tests

A test of any statistical hypothesis where the alternative is one sided, such as

$$H_0: \theta = \theta_0, \quad H_1: \theta > \theta_0$$

or perhaps

$$H_0: \theta = \theta_0, \quad H_1: \theta < \theta_0$$

is called a **one-tailed test**. Earlier in this section, we referred to the test statistic for a hypothesis. Generally, the critical region for the alternative hypothesis $\theta > \theta_0$ lies in the right tail of the distribution of the test statistic, while the critical region for the alternative hypothesis $\theta < \theta_0$ lies entirely in the left tail. (In a sense, the inequality symbol points in the direction of the critical region.) A one-tailed test was used in the vaccine experiment to test the hypothesis $p = 1/4$ against the one-sided alternative $p > 1/4$ for the binomial distribution. The one-tailed critical region is usually obvious; the reader should visualize the behavior of the test statistic and notice the obvious signal that would produce evidence supporting the alternative hypothesis.

A test of any statistical hypothesis where the alternative is two sided, such as

$$H_0: \theta = \theta_0, \quad H_1: \theta \neq \theta_0$$

is called a **two-tailed test**, since the critical region is split into two parts, often having equal probabilities, in each tail of the distribution of the test statistic. The alternative hypothesis $\theta \neq \theta_0$ states that either $\theta < \theta_0$ or $\theta > \theta_0$. A two-tailed test was used to test the null hypothesis that $\mu = 68$ kilograms against the two-sided alternative $\mu \neq 68$ kilograms in the example of the continuous population of student weights.

## How Are the Null and Alternative Hypotheses Chosen?

The null hypothesis $H_0$ will often be stated using the equality sign. With this approach, it is clear how the probability of type I error is controlled. However, there are situations in which "do not reject $H_0$" implies that the parameter $\theta$ might be any value defined by the natural complement to the alternative hypothesis. For example, in the vaccine example, where the alternative hypothesis is $H_1: p > 1/4$, it is quite possible that nonrejection of $H_0$ cannot rule out a value of $p$ less than $1/4$. Clearly though, in the case of one-tailed tests, the statement of the alternative is the most important consideration.

Whether one sets up a one-tailed or a two-tailed test will depend on the conclusion to be drawn if $H_0$ is rejected. The location of the critical region can be determined only after $H_1$ has been stated. For example, in testing a new drug, one sets up the hypothesis that it is no better than similar drugs now on the market and tests this against the alternative hypothesis that the new drug is superior. Such an alternative hypothesis will result in a one-tailed test with the critical region in the right tail. However, if we wish to compare a new teaching technique with the conventional classroom procedure, the alternative hypothesis should allow for the new approach to be either inferior or superior to the conventional procedure. Hence, the test is two-tailed with the critical region divided equally so as to fall in the extreme left and right tails of the distribution of our statistic.

>[!example] Example:
>A manufacturer of a certain brand of rice cereal claims that the average saturated fat content does not exceed $1.5$ grams per serving. State the null and alternative hypotheses to be used in testing this claim and determine where the critical region is located.
>
>**Solution:**
>The manufacturer's claim should be rejected only if $\mu$ is greater than $1.5$ milligrams and should not be rejected if $\mu$ is less than or equal to $1.5$ milligrams. We test
>$$\begin{aligned}
 & H_0: \mu = 1.5 \\[1ex]
 & H_1: \mu > 1.5
\end{aligned}$$
>Nonrejection of $H_0$ does not rule out values less than 1.5 milligrams. Since we have a one-tailed test, the greater than symbol indicates that the critical region lies entirely in the right tail of the distribution of our test statistic $\overline{X}$.

>[!example] Example:
>A real estate agent claims that $60\%$ of all private residences being built today are $3$-bedroom homes. To test this claim, a large sample of new residences is inspected; the proportion of these homes with $3$ bedrooms is recorded and used as the test statistic. State the null and alternative hypotheses to be used in this test and determine the location of the critical region.
>
>**Solution:**
>If the test statistic were substantially higher or lower than $p = 0.6$, we would reject the agent's claim. Hence, we should make the hypothesis
>$$\begin{aligned}
 & H_0: p = 0.6 \\[1ex]
 & H_1: p \neq 0.6
\end{aligned}$$
>The alternative hypothesis implies a two-tailed test with the critical region divided equally in both tails of the distribution of $\hat{P}$, our test statistic.

# The Use of P-Values for Decision Making in Testing Hypotheses

In testing hypotheses in which the test statistic is discrete, the critical region may be chosen arbitrarily and its size determined. If $\alpha$ is too large, it can be reduced by making an adjustment in the critical value. It may be necessary to increase the sample size to offset the decrease that occurs automatically in the power of the test. Over a number of generations of statistical analysis, it had become customary to choose an $\alpha$ of $0.05$ or $0.01$ and select the critical region accordingly. Then, of course, strict rejection or nonrejection of $H_0$ would depend on that critical region. For example, if the test is two tailed and $\alpha$ is set at the $0.05$ level of significance and the test statistic involves, say, the standard normal distribution, then a $z$-value is observed from the data and the critical region is

$$z > 1.96 \text{ or } z < -1.96$$

where the value $1.96$ is found as $z_{0.025}$. A value of $z$ in the critical region prompts the statement "The value of the test statistic is significant," which we can then translate into the user's language. For example, if the hypothesis is given by

$$H_0: \mu = 10, \quad H_1: \mu \neq 10$$

one might say, "The mean differs significantly from the value $10$."

## Preselection of a Significance Level

This preselection of a significance level $\alpha$ has its roots in the philosophy that the maximum risk of making a type I error should be controlled. However, this approach does not account for values of test statistics that are "close" to the critical region. Suppose, for example, in the illustration with $H_0: \mu = 10$ versus $H_1: \mu \neq 10$, a value of $z = 1.87$ is observed; strictly speaking, with $\alpha = 0.05$, the value is not significant. But the risk of committing a type I error if one rejects $H_0$ in this case could hardly be considered severe. In fact, in a two-tailed scenario, one can quantify this risk as

$$P = 2P(Z > 1.87 \text{ when } \mu = 10) = 2(0.0307) = 0.0614$$

As a result, $0.0614$ is the probability of obtaining a value of $z$ as large as or larger (in magnitude) than $1.87$ when in fact $\mu = 10$. Although this evidence against $H_0$ is not as strong as that which would result from rejection at an $\alpha = 0.05$ level, it is important information to the user. Indeed, continued use of $\alpha = 0.05$ or $0.01$ is only a result of what standards have been passed down through the generations. The $P$-value approach has been adopted extensively by users of applied statistics. The approach is designed to give the user an alternative (in terms of a probability) to a mere "reject" or "do not reject" conclusion. The $P$-value computation also gives the user important information when the $z$-value falls well into the ordinary critical region. For example, if $z$ is $2.73$, it is informative for the user to observe that

$$P = 2(0.0032) = 0.0064$$

and thus the $z$-value is significant at a level considerably less than $0.05$. It is important to know that under the condition of $H_0$, a value of $z = 2.73$ is an extremely rare event. That is, a value at least that large in magnitude would only occur $64$ times in $\pu {10000 }$ experiments.

## A Graphical Demonstration of a P-Value

One very simple way of explaining a $P$-value graphically is to consider two distinct samples. Suppose that two materials are being considered for coating a particular type of metal in order to inhibit corrosion. Specimens are obtained, and one collection is coated with material $1$ and one collection coated with material $2$. The sample sizes are $n_1 = n_2 = 10$, and corrosion is measured in percent of surface area affected. The hypothesis is that the samples came from common distributions with mean $\mu = 10$. Let us assume that the population variance is $1.0$. Then we are testing

$$H_0: \mu_1 = \mu_2 = 10$$

![[Pasted image 20250618101759.png|bookhue|500]]
>Data that are likely generated from populations having two different means. [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]].

Let the figure above represent a point plot of the data; the data are placed on the distribution stated by the null hypothesis. Let us assume that the "×" data refer to material $1$ and the "◦" data refer to material $2$. Now it seems clear that the data do refute the null hypothesis. But how can this be summarized in one number? The $P$-value can be viewed as simply the probability of obtaining these data given that both samples come from the same distribution. Clearly, this probability is quite small, say $0.00000001$! Thus, the small $P$-value clearly refutes $H_0$, and the conclusion is that the population means are significantly different.

Use of the $P$-value approach as an aid in decision-making is quite natural, and nearly all computer packages that provide hypothesis-testing computation print out $P$-values along with values of the appropriate test statistic. The following is a formal definition of a $P$-value.

>[!def] Definition:
>A **$P$-value** is the lowest level (of significance) at which the observed value of the test statistic is significant.

## How Does the Use of P-Values Differ from Classic Hypothesis Testing?

It is tempting at this point to summarize the procedures associated with testing, say, $H_0: \theta = \theta_0$. However, the student who is a novice in this area should understand that there are differences in approach and philosophy between the classic fixed $\alpha$ approach that is climaxed with either a "reject $H_0$" or a "do not reject $H_0$" conclusion and the $P$-value approach. In the latter, no fixed $\alpha$ is determined and conclusions are drawn on the basis of the size of the $P$-value in harmony with the subjective judgment of the engineer or scientist. While modern computer software will output $P$-values, nevertheless it is important that readers understand both approaches in order to appreciate the totality of the concepts. Thus, we offer a brief list of procedural steps for both the classical and the $P$-value approach.

### Approach to Hypothesis Testing with Fixed Probability of Type I Error

1. State the null and alternative hypotheses.
2. Choose a fixed significance level $\alpha$.
3. Choose an appropriate test statistic and establish the critical region based on $\alpha$.
4. Reject $H_0$ if the computed test statistic is in the critical region. Otherwise, do not reject.
5. Draw scientific or engineering conclusions.

### Significance Testing (P-Value Approach)

1. State null and alternative hypotheses.
2. Choose an appropriate test statistic.
3. Compute the $P$-value based on the computed value of the test statistic.
4. Use judgment based on the P-value and knowledge of the scientific system.

In later sections of this chapter and chapters that follow, many examples and exercises emphasize the $P$-value approach to drawing scientific conclusions.

# Single Sample: Tests Concerning a Single Mean

In this section, we formally consider tests of hypotheses on a single population mean. Many of the illustrations from previous sections involved tests on the mean, so the reader should already have insight into some of the details that are outlined here.

## Tests on a Single Mean (Variance Known)

We should first describe the assumptions on which the experiment is based. The model for the underlying situation centers around an experiment with $X_1, X_2, \ldots, X_n$ representing a random sample from a distribution with mean $\mu$ and variance $\sigma^2 > 0$. Consider first the hypothesis

$$\begin{aligned}
 & H_0: \mu = \mu_0 \\[1ex]
 & H_1: \mu \neq \mu_0
\end{aligned}$$

The appropriate test statistic should be based on the random variable $\overline{X}$. The [[PSM1_005 Fundamental Sampling Distributions and Data Descriptions#The Central Limit Theorem|Central Limit Theorem]] was introduced, which essentially states that despite the distribution of $X$, the random variable $\overline{X}$ has approximately a normal distribution with mean $\mu$ and variance $\sigma^2/n$ for reasonably large sample sizes. So, $\mu_{\overline{X}} = \mu$ and $\sigma^2_{\overline{X}} = \sigma^2/n$. We can then determine a critical region based on the computed sample average, $\overline{x}$. It should be clear to the reader by now that there will be a two-tailed critical region for the test.

### Standardization of $\overline{X}$

It is convenient to standardize $\overline{X}$ and formally involve the standard normal random variable $Z$, where

$$Z = \frac{\overline{X} - \mu}{\sigma/\sqrt{n}}$$

We know that under $H_0$, that is, if $\mu = \mu_0$, $\sqrt{n}(\overline{X} - \mu_0)/\sigma$ follows an $n(x; 0, 1)$ distribution, and hence the expression

$$P\left(-z_{\alpha/2} < \frac{\overline{X} - \mu_0}{\sigma/\sqrt{n}} < z_{\alpha/2}\right) = 1 - \alpha$$

can be used to write an appropriate nonrejection region. The reader should keep in mind that, formally, the critical region is designed to control $\alpha$, the probability of type I error. It should be obvious that a two-tailed signal of evidence is needed to support $H_1$. Thus, given a computed value $\overline{x}$, the formal test involves rejecting $H_0$ if the computed test statistic $z$ falls in the critical region described next.

>[!info] Test Procedure for a Single Mean (Variance Known):
>$$z = \frac{\overline{x} - \mu_0}{\sigma/\sqrt{n}} > z_{\alpha/2} \quad \text{or} \quad z = \frac{\overline{x} - \mu_0}{\sigma/\sqrt{n}} < -z_{\alpha/2}$$
>
>If $-z_{\alpha/2} < z < z_{\alpha/2}$, do not reject $H_0$. Rejection of $H_0$, of course, implies acceptance of the alternative hypothesis $\mu \neq \mu_0$. With this definition of the critical region, it should be clear that there will be probability $\alpha$ of rejecting $H_0$ (falling into the critical region) when, indeed, $\mu = \mu_0$.

Although it is easier to understand the critical region written in terms of $z$, we can write the same critical region in terms of the computed average $\overline{x}$. The following can be written as an identical decision procedure:

$$\text{reject}\,H_0\quad \text{if}\quad \overline{x} < a\quad \text{or}\quad \overline{x} > b$$

where

$$a = \mu_0 - z_{\alpha/2}\frac{\sigma}{\sqrt{n}}, \quad b = \mu_0 + z_{\alpha/2}\frac{\sigma}{\sqrt{n}}$$

Hence, for a significance level $\alpha$, the critical values of the random variable $z$ and $\overline{x}$ are both depicted in the following figure.

![[Pasted image 20250618105840.png|bookhue|500]]
>Critical region for the alternative hypothesis $\mu \neq \mu_0$. [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]].

Tests of one-sided hypotheses on the mean involve the same statistic described in the two-sided case. The difference, of course, is that the critical region is only in one tail of the standard normal distribution. For example, suppose that we seek to test

$$\begin{aligned}
 & H_0: \mu = \mu_0 \\[1ex]
 & H_1: \mu > \mu_0
\end{aligned}$$

The signal that favors $H_1$ comes from large values of $z$. Thus, rejection of $H_0$ results when the computed $z > z_\alpha$. Obviously, if the alternative is $H_1: \mu < \mu_0$, the critical region is entirely in the lower tail and thus rejection results from $z < -z_\alpha$. Although in a one-sided testing case the null hypothesis can be written as $H_0: \mu \leq \mu_0$ or $H_0: \mu \geq \mu_0$, it is usually written as $H_0: \mu = \mu_0$. The following two examples illustrate tests on means for the case in which $\sigma$ is known.

>[!example] Example:
>A random sample of $100$ recorded deaths in the United States during the past year showed an average life span of $71.8$ years. Assuming a population standard deviation of $8.9$ years, does this seem to indicate that the mean life span today is greater than $70$ years? Use a $0.05$ level of significance.
>
>**Solution:**
>1. $H_0: \mu = 70$ years.
>2. $H_1: \mu > 70$ years.
>3. $\alpha = 0.05$.
>4. Critical region: $z > 1.645$, where $z = \frac{\overline{x} - \mu_0}{\sigma/\sqrt{n}}$.
>5. Computations: $\overline{x} = 71.8$ years, $\sigma = 8.9$ years, and hence 
>   $$z = \frac{71.8 - 70}{8.9/\sqrt{100}} = 2.02$$
>6. Decision: Reject $H_0$ and conclude that the mean life span today is greater than $70$ years.
>
>The $P$-value corresponding to $z = 2.02$ is given by the area of the shaded region in the following figure. Using Table A.3, we have
>$$P = P(Z > 2.02) = 0.0217$$
>As a result, the evidence in favor of $H_1$ is even stronger than that suggested by a $0.05$ level of significance.
>
![[Pasted image 20250618110323.png|bookhue|500]]
>>$P$-value for the life span example. [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]].

>[!example] Example:
>A manufacturer of sports equipment has developed a new synthetic fishing line that the company claims has a mean breaking strength of $8$ kilograms with a standard deviation of $0.5$ kilogram. Test the hypothesis that $\mu = 8$ kilograms against the alternative that $\mu \neq 8$ kilograms if a random sample of $50$ lines is tested and found to have a mean breaking strength of $7.8$ kilograms. Use a $0.01$ level of significance.
>
>**Solution:**
>1. $H_0: \mu = 8$ kilograms.
>2. $H_1: \mu \neq 8$ kilograms.
>3. $\alpha = 0.01$.
>4. Critical region: $z < -2.575$ and $z > 2.575$, where $z = \frac{\overline{x} - \mu_0}{\sigma/\sqrt{n}}$.
>5. Computations: $\overline{x} = 7.8$ kilograms, $n = 50$, and hence 
>   $$z = \frac{7.8 - 8}{0.5/\sqrt{50}} = -2.83$$
>6. Decision: Reject $H_0$ and conclude that the average breaking strength is not equal to $8$ but is, in fact, less than $8$ kilograms.
>
>Since the test in this example is two tailed, the desired $P$-value is twice the area of the shaded region in the following figure to the left of $z = -2.83$. Therefore, using Table A.3, we have
>$$P = P(|Z| > 2.83) = 2P(Z < -2.83) = 0.0046$$
>which allows us to reject the null hypothesis that $\mu = 8$ kilograms at a level of significance smaller than $0.01$.

![[Pasted image 20250618110838.png|bookhue|500]]
>$P$-value for the fishing line example. [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]].

### Relationship to Confidence Interval Estimation

The reader should realize by now that the hypothesis-testing approach to statistical inference in this chapter is very closely related to the confidence interval approach in [[PSM1_006 One- and Two-Sample  Estimation Problems#Introduction|the previous chapter]]. Confidence interval estimation involves computation of bounds within which it is "reasonable" for the parameter in question to lie. For the case of a single population mean $\mu$ with $\sigma^2$ known, the structure of both hypothesis testing and confidence interval estimation is based on the random variable

$$Z = \frac{\overline{X} - \mu}{\sigma/\sqrt{n}}$$

It turns out that the testing of $H_0: \mu = \mu_0$ against $H_1: \mu \neq \mu_0$ at a significance level $\alpha$ is equivalent to computing a $100(1 - \alpha)\%$ confidence interval on $\mu$ and rejecting $H_0$ if $\mu_0$ is outside the confidence interval. If $\mu_0$ is inside the confidence interval, the hypothesis is not rejected. The equivalence is very intuitive and quite simple to illustrate. Recall that with an observed value $\overline{x}$, failure to reject $H_0$ at significance level $\alpha$ implies that

$$-z_{\alpha/2} \leq \frac{\overline{x} - \mu_0}{\sigma/\sqrt{n}} \leq z_{\alpha/2}$$

which is equivalent to

$$\overline{x} - z_{\alpha/2}\frac{\sigma}{\sqrt{n}} \leq \mu_0 \leq \overline{x} + z_{\alpha/2}\frac{\sigma}{\sqrt{n}}$$

The equivalence of confidence interval estimation to hypothesis testing extends to differences between two means, variances, ratios of variances, and so on. As a result, the student of statistics should not consider confidence interval estimation and hypothesis testing as separate forms of statistical inference.
## Tests on a Single Sample (Variance Unknown)

One would certainly suspect that tests on a population mean $\mu$ with $\sigma^2$ unknown, like confidence interval estimation, should involve the use of [[PSM1_005 Fundamental Sampling Distributions and Data Descriptions#t-Distribution|Student t-distribution]]. Strictly speaking, the application of Student $t$ for both confidence intervals and hypothesis testing is developed under the following assumptions. The random variables $X_1, X_2, \ldots, X_n$ represent a random sample from a normal distribution with unknown $\mu$ and $\sigma^2$. Then the random variable $\sqrt{n}(\overline{X} - \mu)/S$ has a Student $t$-distribution with $n-1$ degrees of freedom. The structure of the test is identical to that for the case of $\sigma$ known, with the exception that the value $\sigma$ in the test statistic is replaced by the computed estimate $S$ and the standard normal distribution is replaced by a $t$-distribution.

>[!info] The $t$-Statistic for a Test on a Single Mean (Variance Unknown):
>For the two-sided hypothesis
>$$\begin{aligned}
 & H_0: \mu = \mu_0 \\[1ex]
 & H_1: \mu \neq \mu_0
\end{aligned}$$
>
>we reject $H_0$ at significance level $\alpha$ when the computed $t$-statistic
>$$t = \frac{\overline{x} - \mu_0}{s/\sqrt{n}}$$
>exceeds $t_{\alpha/2,n-1}$ or is less than $-t_{\alpha/2,n-1}$.

The reader should recall that the $t$-distribution is symmetric around the value zero. Thus, this two-tailed critical region applies in a fashion similar to that for the case of known $\sigma$. For the two-sided hypothesis at significance level $\alpha$, the two-tailed critical regions apply. For $H_1: \mu > \mu_0$, rejection results when $t > t_{\alpha,n-1}$. For $H_1: \mu < \mu_0$, the critical region is given by $t < -t_{\alpha,n-1}$.

>[!example] Example:
>The Edison Electric Institute has published figures on the number of kilowatt hours used annually by various home appliances. It is claimed that a vacuum cleaner uses an average of $46$ kilowatt hours per year. If a random sample of $12$ homes included in a planned study indicates that vacuum cleaners use an average of $42$ kilowatt hours per year with a standard deviation of $11.9$ kilowatt hours, does this suggest at the $0.05$ level of significance that vacuum cleaners use, on average, less than $46$ kilowatt hours annually? Assume the population of kilowatt hours to be normal.
>
>**Solution:**
>1. $H_0: \mu = 46$ kilowatt hours.
>2. $H_1: \mu < 46$ kilowatt hours.
>3. $\alpha = 0.05$.
>4. Critical region: $t < -1.796$, where $t = \frac{\overline{x} - \mu_0}{s/\sqrt{n}}$ with $11$ degrees of freedom.
>5. Computations: $\overline{x} = 42$ kilowatt hours, $s = 11.9$ kilowatt hours, and $n = 12$. Hence,
>   $$t = \frac{42 - 46}{11.9/\sqrt{12}} = -1.16, \quad P = P(T < -1.16) \approx 0.135$$
>6. Decision: Do not reject $H_0$ and conclude that the average number of kilowatt hours used annually by home vacuum cleaners is not significantly less than $46$.

