---
aliases:
  - sampling distributions
  - central limit theorem
  - sample mean
  - sample variance
  - random sampling
  - population sample
  - statistics
  - sample median
  - CLT
---
# Random Sampling

The outcome of a statistical experiment may be recorded either as a numerical value or as a descriptive representation. For example, when a pair of dice is tossed and the total is the outcome of interest, we record a numerical value. However, if the students of a certain school are given blood tests and the type of blood is of interest, then a descriptive representation might be more useful. A person's blood can be classified in 8 ways: $\mathrm{AB}$, $\mathrm{A}$, $\mathrm{B}$, or $\mathrm{O}$, each with a plus or minus sign, depending on the presence or absence of the $\mathrm{Rh}$ antigen.

In this chapter, we focus on sampling from distributions or populations and study such important quantities as the sample mean and sample variance, which will be of vital importance in future chapters. In addition, we introduce the role that the sample mean and variance will play in statistical inference. The use of modern high-speed computers allows the scientist or engineer to greatly enhance their use of formal statistical inference with graphical techniques. Much of the time, formal inference appears quite dry and perhaps even abstract to the practitioner or to the manager who wishes to let statistical analysis be a guide to decision-making.

## Populations and Samples

We begin by discussing the notions of populations and samples. Both are mentioned in a broad fashion in [[PSM1_001 Introduction and Probability|the introductory chapter]], but more detail is needed here, particularly in the context of random variables.

>[!def] Definition:
>A **population** consists of the totality of the observations with which we are concerned. The number of observations in the population is called the **size of the population**.

Examples:
- The numbers on the cards in a deck, the heights of residents in a certain city, and the lengths of fish in a particular lake are examples of populations with finite size.
- The observations obtained by measuring the atmospheric pressure every day, from the past on into the future, or all measurements of the depth of a lake, from any conceivable position, are examples of populations whose sizes are infinite.
- Some finite populations are so large that in theory we assume them to be infinite (e.g., the population of lifetimes of a certain type of storage battery being manufactured for mass distribution).

Each observation in a population is a value of a random variable $X$ having some probability distribution $f(x)$. For example:
- Inspecting items coming off an assembly line for defects: each observation is a value $0$ or $1$ of a [[PSM1_003 Some Discrete Probability  Distributions#The Bernoulli Process|Bernoulli random variable]] $X$ with probability distribution
  $$b(x; 1, p) = p^x q^{1-x}, \quad x = 0, 1$$
  where $0$ indicates a non-defective item and $1$ indicates a defective item, and $p$ is the probability of any item being defective.
- In the blood-type experiment, the random variable $X$ represents the type of blood and is assumed to take on values from $1$ to $8$.
- The lives of storage batteries are values assumed by a continuous random variable, perhaps with a normal distribution.

When we refer to a "binomial population," a "normal population," or, in general, the "population $f(x)$," we mean a population whose observations are values of a random variable having a binomial distribution, a normal distribution, or the probability distribution $f(x)$. The mean and variance of a random variable or probability distribution are also referred to as the mean and variance of the corresponding population.

In statistical inference, we are interested in drawing conclusions about a population when it is impossible or impractical to observe the entire set of observations. For example, to determine the average length of life of a certain brand of light bulb, it would be impossible to test all such bulbs. Exorbitant costs can also be a prohibitive factor. Therefore, we depend on a subset of observations from the population to help us make inferences concerning that population. This brings us to the notion of sampling.

>[!def] Definition:
>A **sample** is a subset of a population.

If our inferences from the sample to the population are to be valid, we must obtain samples that are representative of the population. Any sampling procedure that produces inferences that consistently overestimate or consistently underestimate some characteristic of the population is said to be **biased**. To eliminate bias, it is desirable to choose a **random sample**: observations made independently and at random.

Suppose we select a random sample of size $n$ from a population $f(x)$. Let $X_i$, $i = 1, 2, \ldots, n$, represent the $i$th measurement or sample value. The random variables $X_1, X_2, \ldots, X_n$ constitute a random sample from the population $f(x)$ if the measurements are obtained by repeating the experiment $n$ independent times under essentially the same conditions. Thus, the $n$ random variables $X_1, X_2, \ldots, X_n$ are independent and each has the same probability distribution $f(x)$. Their joint probability distribution is:
$$
f(x_1, x_2, \ldots, x_n) = f(x_1)f(x_2) \cdots f(x_n)
$$

>[!def] Definition:
>Let $X_1, X_2, \ldots, X_n$ be $n$ independent random variables, each having the same probability distribution $f(x)$. Then $X_1, X_2, \ldots, X_n$ form a **random sample** of size $n$ from the population $f(x)$, with joint probability distribution
>$$f(x_1, x_2, \ldots, x_n) = f(x_1)f(x_2) \cdots f(x_n)$$

> [!example] Example:
> If we select $n = 8$ storage batteries from a manufacturing process and record the life of each battery, with $x_1$ the value of $X_1$, $x_2$ the value of $X_2$, etc., then $x_1, x_2, \ldots, x_8$ are the values of the random sample $X_1, X_2, \ldots, X_8$. If the population of battery lives is normal, each $X_i$ has the same normal distribution as $X$.

# Some Important Statistics

Our main purpose in selecting random samples is to elicit information about unknown population parameters. For example, to estimate the proportion $p$ of coffee-drinkers in the US who prefer a certain brand, we select a large random sample and compute the sample proportion $\hat{p}$. Since many random samples are possible, $\hat{p}$ varies from sample to sample; it is a value of a random variable, called a **statistic**.

>[!def] Definition:
>Any function of the random variables constituting a random sample is called a **statistic**.

## Location Measures of a Sample: The Sample Mean, Median, and Mode

Let $X_1, X_2, \ldots, X_n$ represent $n$ random variables.

- **Sample mean:**
	$$
	\overline{X} = \frac{1}{n} \sum_{i=1}^n X_i
	$$
	The statistic $\overline{X}$ assumes the value $\overline{x} = \frac{1}{n} \sum_{i=1}^n x_i$ for a given sample.

- **Sample median:**
	$$
	\tilde{x} = \begin{cases}
	x_{(n+1)/2}, & \text{if } n \text{ is odd} \\
	\frac{1}{2}(x_{n/2} + x_{n/2+1}), & \text{if } n \text{ is even}
	\end{cases}
	$$
	The sample median is the middle value of the sample.
- **Sample mode:**
	  The value of the sample that occurs most often.
>[!example] Example:
>Suppose a data set consists of the following observations:
>$$0.32,\ 0.53,\ 0.28,\ 0.37,\ 0.47,\ 0.43,\ 0.36,\ 0.42,\ 0.38,\ 0.43$$
>The sample mode is $0.43$, since it occurs more than any other value.



## Variability Measures of a Sample: The Sample Variance, Standard Deviation, and Range

A measure of location or central tendency in a sample does not by itself give a clear indication of the nature of the sample. Thus, a measure of variability in the sample must also be considered.

The variability in a sample displays how the observations spread out from the average.

- **Sample variance:**
	$$
	\boxed {S^2 = \frac{1}{n-1} \sum_{i=1}^n (X_i - \overline{X})^2}
	$$
	The computed value for a given sample is denoted $s^2$.
>[!example] Example:
>A comparison of coffee prices at 4 randomly selected grocery stores in San Diego showed increases from the previous month of $12$, $15$, $17$, and $20$ cents for a 1-pound bag. Find the variance of this random sample of price increases.
>
>**Solution:**
>Sample mean: $\overline{x} = (12 + 15 + 17 + 20)/4 = 16$ cents.
>Sample variance:
>$$
>s^2 = \frac{1}{3} \sum_{i=1}^4 (x_i - 16)^2 = \frac{(-4)^2 + (-1)^2 + 1^2 + 4^2}{3} = \frac{34}{3}
>$$
	
- An alternative formula for the sample variance is:
>[!theorem] Theorem:
>If $S^2$ is the variance of a random sample of size $n$, we may write
>$$
>S^2 = \frac{1}{n(n-1)} \left[ n \sum_{i=1}^n X_i^2 - \left( \sum_{i=1}^n X_i \right)^2 \right]
>$$
	
- **Sample standard deviation:**
	$$S = \sqrt{S^2}$$
	where $S^{2}$ is the sample variance.
- **Sample range:**
	$$R = X_{\max} - X_{\min}$$

>[!example] Example:
>Find the variance of the data $3, 4, 5, 6, 6, 7$, representing the number of trout caught by a random sample of 6 fishermen.
>
>**Solution:**
>Calculating the sample mean, we get
>We find that $\sum_{i=1}^6 x_i^2 = 171$, $\sum_{i=1}^6 x_i = 31$, and $n = 6$. Hence,
>$$
>s^2 = \frac{1}{6 \cdot 5} [6 \cdot 171 - 31^2] = \frac{13}{6}
>$$
>
>Sample standard deviation: $s = \sqrt{13/6} \approx 1.47$
>
>Sample range: $7 - 3 = 4$

# Sampling Distribution of Means

The first important sampling distribution to be considered is that of the mean $\overline{X}$. Suppose that a random sample of $n$ observations is taken from a normal population with mean $\mu$ and variance $\sigma^2$. Each observation $X_i$, $i = 1, 2, \ldots, n$, of the random sample will then have the same normal distribution as the population being sampled.

Hence, we conclude that
$$\overline{X} = \frac{1}{n}(X_1 + X_2 + \cdots + X_n)$$
has a normal distribution with mean
$$\mu_{\overline{X}} = \frac{1}{n}(\mu + \mu + \cdots + \mu) = \mu$$
and variance
$$\sigma^2_{\overline{X}} = \frac{1}{n^2}(\sigma^2 + \sigma^2 + \cdots + \sigma^2) = \frac{\sigma^2}{n}$$

If we are sampling from a population with unknown distribution, either finite or infinite, the sampling distribution of $\overline{X}$ will still be approximately normal with mean $\mu$ and variance $\sigma^2/n$, provided that the sample size is large. This amazing result is an immediate consequence of the following theorem, called the Central Limit Theorem.

# The Central Limit Theorem

![](https://www.youtube.com/watch?v=zeJD6dqJ5lo)

The Central Limit Theorem is one of the most important results in probability theory and statistics. It provides the theoretical foundation for many statistical procedures and explains why the normal distribution appears so frequently in nature.

>[!theorem] Theorem:
>The **Central Limit Theorem** states that if $\overline{X}$ is the mean of a random sample of size $n$ taken from a population with mean $\mu$ and finite variance $\sigma^2$, then the limiting form of the distribution of 
>$$Z = \frac{\overline{X} - \mu}{\sigma/\sqrt{n}}$$
>as $n \to \infty$, is the standard normal distribution $n(z; 0, 1)$.

The normal approximation for $\overline{X}$ will generally be good if $n \geq 30$, provided the population distribution is not terribly skewed. If $n < 30$, the approximation is good only if the population is not too different from a normal distribution. If the population is known to be normal, the sampling distribution of $\overline{X}$ will follow a normal distribution exactly, no matter how small the size of the samples.

The sample size $n = 30$ is a guideline to use for the Central Limit Theorem. However, as the statement of the theorem implies, the presumption of normality on the distribution of $\overline{X}$ becomes more accurate as $n$ grows larger. The following figure illustrates how the theorem works:

![[{963627F4-DE77-4631-9252-E739996A1B01}.png|bookhue|600]]
>Illustration of the Central Limit Theorem (distribution of $\overline{X}$ for $n = 1$, moderate $n$, and large $n$). [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]].

The figure shows how the distribution of $\overline{X}$ becomes closer to normal as $n$ grows larger, beginning with the clearly nonsymmetric distribution of an individual observation ($n = 1$). It also illustrates that the mean of $\overline{X}$ remains $\mu$ for any sample size and the variance of $\overline{X}$ gets smaller as $n$ increases.

>[!example] Example:
>An electrical firm manufactures light bulbs that have a length of life that is approximately normally distributed, with mean equal to $800$ hours and a standard deviation of $40$ hours. Find the probability that a random sample of $16$ bulbs will have an average life of less than $775$ hours.
>
>**Solution:**
>The sampling distribution of $\overline{X}$ will be approximately normal, with $\mu_{\overline{X}} = 800$ and $\sigma_{\overline{X}} = 40/\sqrt{16} = 10$. The desired probability is given by the area of the shaded region in the following figure:
>
>![[{2B98A8D4-FE9A-4D1F-879E-6522767E157A}.png|bookhue|500]]
>
>Corresponding to $\overline{x} = 775$, we find that
>$$z = \frac{775 - 800}{10} = -2.5,$$
>and therefore
>$$P(\overline{X} < 775) = P(Z < -2.5) = 0.0062.$$

## Inferences on the Population Mean

One very important application of the Central Limit Theorem is the determination of reasonable values of the population mean $\mu$. Topics such as hypothesis testing, estimation, quality control, and many others make use of the Central Limit Theorem.

>[!example] Case Study: Automobile Parts
>An important manufacturing process produces cylindrical component parts for the automotive industry. It is important that the process produce parts having a mean diameter of $\pu {5.0 mm }$. The engineer involved conjectures that the population mean is $\pu {5.0 mm }$. An experiment is conducted in which $100$ parts produced by the process are selected randomly and the diameter measured on each. It is known that the population standard deviation is $\sigma = \pu {0.1 mm}$. The experiment indicates a sample average diameter of $\overline{x} = \pu{5.027mm}$. Does this sample information appear to support or refute the engineer's conjecture?
>
>**Solution:**
>This example reflects the kind of problem often posed and solved with hypothesis testing machinery introduced in future chapters. We will not use the formality associated with hypothesis testing here, but we will illustrate the principles and logic used.
>
>Whether the data support or refute the conjecture depends on the probability that data similar to those obtained in this experiment ($\overline{x} = 5.027$) can readily occur when in fact $\mu = 5.0$ (See the following figure). In other words, how likely is it that one can obtain $\overline{x} \geq 5.027$ with $n = 100$ if the population mean is $\mu = 5.0$?
>
>![[{E262C760-ABC3-4897-9DF9-24201A056CB3}.png|bookhue|500]]
>
>The probability that we choose to compute is given by $P(|\overline{X} - 5| \geq 0.027)$. In other words, if the mean $\mu$ is 5, what is the chance that $\overline{X}$ will deviate by as much as $\pu{0.027mm}$?
>
>$$\begin{aligned}
>P(|\overline{X} - 5| \geq 0.027) &= P(\overline{X} - 5 \geq 0.027) + P(\overline{X} - 5 \leq -0.027) \\
>&= 2P\left(\frac{\overline{X} - 5}{0.1/\sqrt{100}} \geq 2.7\right)
>\end{aligned}$$
>
>Here we are simply standardizing $\overline{X}$ according to the Central Limit Theorem. If the conjecture $\mu = 5.0$ is true, $\frac{\overline{X}-5}{0.1/\sqrt{100}}$ should follow $N(0, 1)$. Thus,
>
>$$2P\left(\frac{\overline{X} - 5}{0.1/\sqrt{100}} \geq 2.7\right) = 2P(Z \geq 2.7) = 2(0.0035) = 0.007.$$
>
>Therefore, one would experience by chance that an $\overline{x}$ would be $\pu{0.027mm}$ from the mean in only $7$ in $1000$ experiments. As a result, this experiment with $\overline{x} = 5.027$ certainly does not give supporting evidence to the conjecture that $\mu = 5.0$. In fact, it strongly refutes the conjecture!

# Sampling Distribution of S²

In the preceding section we learned about the sampling distribution of $\overline{X}$. The Central Limit Theorem allowed us to make use of the fact that
$$\frac{\overline{X} - \mu}{\sigma/\sqrt{n}}$$
tends toward $N(0, 1)$ as the sample size grows large. Sampling distributions of important statistics allow us to learn information about parameters. Usually, the parameters are the counterpart to the statistics in question. For example, if an engineer is interested in the population mean resistance of a certain type of resistor, the sampling distribution of $\overline{X}$ will be exploited once the sample information is gathered. On the other hand, if the variability in resistance is to be studied, clearly the sampling distribution of $S^2$ will be used in learning about the parametric counterpart, the population variance $\sigma^2$.

If a random sample of size $n$ is drawn from a normal population with mean $\mu$ and variance $\sigma^2$, and the sample variance is computed, we obtain a value of the statistic $S^2$. We shall proceed to consider the distribution of the statistic $(n-1)S^2/\sigma^2$.

By the addition and subtraction of the sample mean $\overline{X}$, it is easy to see that
$$\sum_{i=1}^n (X_i - \mu)^2 = \sum_{i=1}^n [(X_i - \overline{X}) + (\overline{X} - \mu)]^2$$

Expanding this expression:
$$\begin{aligned}
\sum_{i=1}^n (X_i - \mu)^2 &= \sum_{i=1}^n (X_i - \overline{X})^2 + \sum_{i=1}^n (\overline{X} - \mu)^2 + 2(\overline{X} - \mu) \sum_{i=1}^n (X_i - \overline{X}) \\[1ex]
&= \sum_{i=1}^n (X_i - \overline{X})^2 + n(\overline{X} - \mu)^2
\end{aligned}$$

The cross-product term equals zero because $\sum_{i=1}^n (X_i - \overline{X}) = 0$.

Dividing each term of the equality by $\sigma^2$ and substituting $(n-1)S^2$ for $\sum_{i=1}^n (X_i - \overline{X})^2$, we obtain:
$$\frac{1}{\sigma^2} \sum_{i=1}^n (X_i - \mu)^2 = \frac{(n-1)S^2}{\sigma^2} + \frac{(\overline{X} - \mu)^2}{\sigma^2/n}$$

Now, it known that
$$\sum_{i=1}^n\frac{ (X_i - \mu)^2}{\sigma^2}$$
is a [[PSM1_004 Some Continuous Probability Distributions#Chi-Squared Distribution|chi-squared random variable]] with $n$ **degrees of freedom**. We have a chi-squared random variable with $n$ degrees of freedom partitioned into two components. The second term on the right-hand side is $Z^2$, which is a chi-squared random variable with $1$ degree of freedom, and it turns out that $(n-1)S^2/\sigma^2$ is a chi-squared random variable with $n-1$ degrees of freedom. We formalize this in the following theorem.

>[!theorem] Theorem:
>If $S^2$ is the variance of a random sample of size $n$ taken from a normal population having the variance $\sigma^2$, then the statistic
>$$\chi^2 = \frac{(n-1)S^2}{\sigma^2} =\sum_{i=1}^n \frac{ (X_i - \overline{X})^2}{\sigma^2}$$
>has a chi-squared distribution with $v = n-1$ degrees of freedom.

The values of the random variable $\chi^2$ are calculated from each sample by the formula:
$$\chi^2 = \frac{(n-1)s^2}{\sigma^2}$$

The probability that a random sample produces a $\chi^2$ value greater than some specified value is equal to the area under the curve to the right of this value. It is customary to let $\chi^2_\alpha$ represent the $\chi^2$ value above which we find an area of $\alpha$. This is illustrated by the shaded region in the following figure:

![[Pasted image 20250614170346.png|bookhue|500]]
>The chi-squared distribution. [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]].

There are tables that give values of ${{{\chi}_{\alpha}}}^{2}$ for various values of $\alpha$ and $v$. The areas, $\alpha$, are the column headings; the degrees of freedom, $v$, are given in the left column; and the table entries are the $\chi^2$ values. Hence, the $\chi^2$ value with $7$ degrees of freedom, leaving an area of $0.05$ to the right, is ${\chi}^{2}_{0.05} = 14.067$. Owing to lack of symmetry, we must also use the tables to find $\chi^2_{0.95} = 2.167$ for $v = 7$.

Exactly $95\%$ of a chi-squared distribution lies between $\chi^2_{0.975}$ and $\chi^2_{0.025}$. A $\chi^2$ value falling to the right of $\chi^2_{0.025}$ is not likely to occur unless our assumed value of $\sigma^2$ is too small. Similarly, a $\chi^2$ value falling to the left of $\chi^2_{0.975}$ is unlikely unless our assumed value of $\sigma^2$ is too large. In other words, it is possible to have a $\chi^2$ value to the left of $\chi^2_{0.975}$ or to the right of $\chi^2_{0.025}$ when $\sigma^2$ is correct, but if this should occur, it is more probable that the assumed value of $\sigma^2$ is in error.

>[!example] Example:
>A manufacturer of car batteries guarantees that the batteries will last, on average, $3$ years with a standard deviation of $1$ year. If five of these batteries have lifetimes of $1.9$, $2.4$, $3.0$, $3.5$, and $4.2$ years, should the manufacturer still be convinced that the batteries have a standard deviation of $1$ year? Assume that the battery lifetime follows a normal distribution.
>
>**Solution:**
>We first find the sample variance using the [[#Variability Measures of a Sample The Sample Variance, Standard Deviation, and Range|alternative formula]]:
>$$s^2 = \frac{5\cdot48.26 - 15^2}{5\cdot4} = 0.815$$
>
>Then
>$$\chi^2 = \frac{4\cdot0.815}{1} = 3.26$$
>is a value from a chi-squared distribution with $4$ degrees of freedom. Since $95\%$ of the $\chi^2$ values with $4$ degrees of freedom fall between $0.484$ and $11.143$, the computed value with $\sigma^2 = 1$ is reasonable, and therefore the manufacturer has no reason to suspect that the standard deviation is other than $1$ year.

## Degrees of Freedom as a Measure of Sample Information

![](https://www.youtube.com/watch?v=VDlnuO96p58)

It is known that
$$\sum_{i=1}^n\frac{ (X_i - \mu)^2}{\sigma^2}$$
has a $\chi^2$-distribution with $n$ degrees of freedom. Note also from the [[#Sampling Distribution of S²|theorem]] that the random variable
$$\frac{(n-1)S^2}{\sigma^2} = \frac{\sum_{i=1}^n (X_i - \overline{X})^2}{\sigma^2}$$
has a $\chi^2$-distribution with $n-1$ degrees of freedom.

The reader can view the [[#Sampling Distribution of S²|theorem]] as indicating that when $\mu$ is not known and one considers the distribution of 
$$\sum_{i=1}^n\frac{ (X_i - \overline{X})^2}{\sigma^2}$$
there is $1$ less degree of freedom, or a degree of freedom is lost in the estimation of $\mu$ (i.e., when $\mu$ is replaced by $\overline{x}$).

In other words, there are $n$ degrees of freedom, or independent pieces of information, in the random sample from the normal distribution. When the data (the values in the sample) are used to compute the mean, there is 1 less degree of freedom in the information used to estimate $\sigma^2$.

This concept of "losing" a degree of freedom when estimating parameters is fundamental to understanding why we use $n-1$ in the denominator of the sample variance formula and why many statistical distributions depend on degrees of freedom rather than sample size directly.

# t-Distribution

In [[#The Central Limit Theorem]], we discussed the utility of the Central Limit Theorem. Its applications revolve around inferences on a population mean or the difference between two population means. Use of the Central Limit Theorem and the normal distribution is certainly helpful in this context. However, it was assumed that the population standard deviation is known. This assumption may not be unreasonable in situations where the engineer is quite familiar with the system or process. However, in many experimental scenarios, knowledge of $\sigma$ is certainly no more reasonable than knowledge of the population mean $\mu$. Often, in fact, an estimate of $\sigma$ must be supplied by the same sample information that produced the sample average $\overline{x}$. As a result, a natural statistic to consider to deal with inferences on $\mu$ is

$$T = \frac{\overline{X} - \mu}{S/\sqrt{n}}$$

since $S$ is the sample analog to $\sigma$. If the sample size is small, the values of $S^2$ fluctuate considerably from sample to sample and the distribution of $T$ deviates appreciably from that of a standard normal distribution. If the sample size is large enough, say $n \geq 30$, the distribution of $T$ does not differ considerably from the standard normal. However, for $n < 30$, it is useful to deal with the exact distribution of $T$.

In developing the sampling distribution of $T$, we shall assume that our random sample was selected from a normal population. We can then write

$$T = \frac{(\overline{X} - \mu)/(\sigma/\sqrt{n})}{\sqrt{S^2/\sigma^2}} = \frac{Z}{\sqrt{V/(n-1)}}$$

where

$$Z = \frac{\overline{X} - \mu}{\sigma/\sqrt{n}}$$

has the standard normal distribution and

$$V = \frac{(n-1)S^2}{\sigma^2}$$

has a chi-squared distribution with $v = n - 1$ degrees of freedom. In sampling from normal populations, we can show that $\overline{X}$ and $S^2$ are independent, and consequently so are $Z$ and $V$. The following theorem gives the definition of a random variable $T$ as a function of $Z$ (standard normal) and $\chi^2$. For completeness, the density function of the t-distribution is given.

>[!theorem] Theorem:
>Let $Z$ be a standard normal random variable and $V$ a chi-squared random variable with $v$ degrees of freedom. If $Z$ and $V$ are independent, then the distribution of the random variable $T$, where
>$$T = \frac{Z}{\sqrt{V/v}}$$
>is given by the density function
>$$h(t) = \frac{\Gamma[(v+1)/2]}{\Gamma(v/2)\sqrt{\pi v}} \left(1 + \frac{t^2}{v}\right)^{-(v+1)/2} \qquad -\infty < t < \infty$$
>This is known as the **t-distribution** with $v$ degrees of freedom.

From the foregoing and the theorem above we have the following corollary.

>[!theo] Corollary:
>Let $X_1, X_2, \ldots, X_n$ be independent random variables that are all normal with mean $\mu$ and standard deviation $\sigma$. Let
>$$\overline{X} = \frac{1}{n} \sum_{i=1}^n X_i \qquad \text{and} \qquad S^2 = \frac{1}{n-1} \sum_{i=1}^n (X_i - \overline{X})^2$$
>Then the random variable
>$$T = \frac{\overline{X} - \mu}{S/\sqrt{n}}$$
>has a t-distribution with $v = n - 1$ degrees of freedom.

The probability distribution of $T$ was first published in 1908 in a paper written by W. S. Gosset. At the time, Gosset was employed by an Irish brewery that prohibited publication of research by members of its staff. To circumvent this restriction, he published his work secretly under the name "Student." Consequently, the distribution of $T$ is usually called the **Student t-distribution** or simply the **t-distribution**. In deriving the equation of this distribution, Gosset assumed that the samples were selected from a normal population. Although this would seem to be a very restrictive assumption, it can be shown that nonnormal populations possessing nearly bell-shaped distributions will still provide values of $T$ that approximate the t-distribution very closely.

## What Does the t-Distribution Look Like?

The distribution of $T$ is similar to the distribution of $Z$ in that they both are symmetric about a mean of zero. Both distributions are bell shaped, but the t-distribution is more variable, owing to the fact that the $T$-values depend on the fluctuations of two quantities, $\overline{X}$ and $S^2$, whereas the $Z$-values depend only on the changes in $\overline{X}$ from sample to sample. The distribution of $T$ differs from that of $Z$ in that the variance of $T$ depends on the sample size $n$ and is always greater than $1$. Only when the sample size $n \to \infty$ will the two distributions become the same.

![[Pasted image 20250615113041.png|bookhue|500]]
>The t-distribution curves for $v = 2, 5,$ and $\infty$. [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]].

The percentage points of the t-distribution are usually given in a table.

It is customary to let $t_\alpha$ represent the t-value above which we find an area equal to $\alpha$. Hence, the t-value with $10$ degrees of freedom leaving an area of $0.025$ to the right is $t = 2.228$. Since the t-distribution is symmetric about a mean of zero, we have $t_{1-\alpha} = -t_\alpha$; that is, the t-value leaving an area of $1 - \alpha$ to the right and therefore an area of $\alpha$ to the left is equal to the negative t-value that leaves an area of $\alpha$ in the right tail of the distribution.

![[Pasted image 20250615113058.png|bookhue|500]]
>Symmetry property (about 0) of the t-distribution. [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]].

That is, $t_{0.95} = -t_{0.05}$, $t_{0.99} = -t_{0.01}$, and so forth.

>[!example] Example:
>The t-value with $v = 14$ degrees of freedom that leaves an area of $0.025$ to the left, and therefore an area of $0.975$ to the right, is
>$$t_{0.975} = -t_{0.025} = -2.145$$

>[!example] Example:
>Find $P(-t_{0.025} < T < t_{0.05})$.
>
>**Solution:**
>Since $t_{0.05}$ leaves an area of $0.05$ to the right, and $-t_{0.025}$ leaves an area of $0.025$ to the left, we find a total area of
>$$1 - 0.05 - 0.025 = 0.925$$
>between $-t_{0.025}$ and $t_{0.05}$. Hence
>$$P(-t_{0.025} < T < t_{0.05}) = 0.925$$

>[!example] Example:
>Find $k$ such that $P(k < T < -1.761) = 0.045$ for a random sample of size $15$ selected from a normal distribution and $T = \frac{\overline{X} - \mu}{S/\sqrt{n}}$.
>
>![[Pasted image 20250615113311.png|bookhue|500]]
>
>**Solution:**
>From a t-distribution table we note that $1.761$ corresponds to $t_{0.05}$ when $v = 14$. Therefore, $-t_{0.05} = -1.761$. Since $k$ in the original probability statement is to the left of $-t_{0.05} = -1.761$, let $k = -t_\alpha$. Then, from the figure, we have
>$$0.045 = 0.05 - \alpha, \quad \text{or} \quad \alpha = 0.005$$
>Hence, from the table with $v = 14$, $k = -t_{0.005} = -2.977$ and
>$$P(-2.977 < T < -1.761) = 0.045$$

Exactly $95\%$ of the values of a t-distribution with $v = n - 1$ degrees of freedom lie between $-t_{0.025}$ and $t_{0.025}$. Of course, there are other t-values that contain $95\%$ of the distribution, such as $-t_{0.02}$ and $t_{0.03}$, but these values do not appear in the tables, and furthermore, the shortest possible interval is obtained by choosing t-values that leave exactly the same area in the two tails of our distribution. A t-value that falls below $-t_{0.025}$ or above $t_{0.025}$ would tend to make us believe either that a very rare event has taken place or that our assumption about $\mu$ is in error. Should this happen, we shall make the decision that our assumed value of $\mu$ is in error. In fact, a t-value falling below $-t_{0.01}$ or above $t_{0.01}$ would provide even stronger evidence that our assumed value of $\mu$ is quite unlikely. General procedures for testing claims concerning the value of the parameter $\mu$ will be treated in [[PSM1_007 One- and Two-Sample Tests of  Hypotheses|One- and Two-Sample Tests of  Hypotheses]]. A preliminary look into the foundation of these procedures is illustrated by the following example.

>[!example] Example:
>A chemical engineer claims that the population mean yield of a certain batch process is $500$ grams per milliliter of raw material. To check this claim he samples $25$ batches each month. If the computed t-value falls between $-t_{0.05}$ and $t_{0.05}$, he is satisfied with this claim. What conclusion should he draw from a sample that has a mean $\overline{x} = 518$ grams per milliliter and a sample standard deviation $s = 40$ grams? Assume the distribution of yields to be approximately normal.
>
>**Solution:**
>From a table we find that $t_{0.05} = 1.711$ for $24$ degrees of freedom. Therefore, the engineer can be satisfied with his claim if a sample of $25$ batches yields a t-value between $-1.711$ and $1.711$. If $\mu = 500$, then
>$$t = \frac{518 - 500}{40/\sqrt{25}} = 2.25$$
>a value well above $1.711$. The probability of obtaining a t-value, with $v = 24$, equal to or greater than $2.25$ is approximately $0.02$. If $\mu > 500$, the value of $t$ computed from the sample is more reasonable. Hence, the engineer is likely to conclude that the process produces a better product than he thought.

## What Is the t-Distribution Used For?

The t-distribution is used extensively in problems that deal with inference about the population mean (as illustrated in the example above) or in problems that involve comparative samples (i.e., in cases where one is trying to determine if means from two samples are significantly different).

>[!notes] Important Notes:
>- The use of the t-distribution for the statistic $T = \frac{\overline{X} - \mu}{S/\sqrt{n}}$ requires that $X_1, X_2, \ldots, X_n$ be normal.
>- The use of the t-distribution and the sample size consideration do not relate to the Central Limit Theorem.
>- The use of the standard normal distribution rather than $T$ for $n \geq 30$ merely implies that $S$ is a sufficiently good estimator of $\sigma$ in this case.
>- In chapters that follow, the t-distribution finds extensive usage.

# F-Distribution

We have motivated the t-distribution in part by its application to problems in which there is comparative sampling (i.e., a comparison between two sample means). For example, some of our examples in future chapters will take a more formal approach: a chemical engineer collects data on two catalysts, a biologist collects data on two growth media, or a chemist gathers data on two methods of coating material to inhibit corrosion. While it is of interest to let sample information shed light on two population means, it is often the case that a comparison of variability is equally important, if not more so. The F-distribution finds enormous application in comparing sample variances. Applications of the F-distribution are found in problems involving two or more samples.

The statistic $F$ is defined to be the ratio of two independent chi-squared random variables, each divided by its number of degrees of freedom. Hence, we can write:
$$F = \frac{U/v_1}{V/v_2}$$
where $U$ and $V$ are independent random variables having [[PSM1_004 Some Continuous Probability Distributions#Chi-Squared Distribution|chi-squared distributions]] with $v_1$ and $v_2$ degrees of freedom, respectively. We shall now state the sampling distribution of $F$.

>[!theorem] Theorem:
>Let $U$ and $V$ be two independent random variables having chi-squared distributions with $v_1$ and $v_2$ degrees of freedom, respectively. Then the distribution of the random variable 
>$$F = \frac{U/v_1}{V/v_2}$$
>is given by the density function
>$$h(f) = \begin{cases}
>\dfrac{\Gamma[(v_1+v_2)/2](v_1/v_2)^{v_1/2}}{\Gamma(v_1/2)\Gamma(v_2/2)} \cdot \dfrac{f^{(v_1/2)-1}}{(1+v_1f/v_2)^{(v_1+v_2)/2}}, & f > 0 \\
>0, & f \leq 0
>\end{cases}$$
>This is known as the **F-distribution** with $v_1$ and $v_2$ degrees of freedom (d.f.).

We will make considerable use of the random variable $F$ in future chapters. However, the density function will not be used and is given only for completeness. The curve of the F-distribution depends not only on the two parameters $v_1$ and $v_2$ but also on the order in which we state them. Once these two values are given, we can identify the curve. Typical F-distributions are shown in the following figure:

![[Pasted image 20250615133222.png|bookhue|500]]
>Typical F-distributions. [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]].

Let $f_\alpha$ be the f-value above which we find an area equal to $\alpha$. This is illustrated by the shaded region in the following figure:

![[Pasted image 20250615133248.png|bookhue|500]]
>Illustration of the $f_\alpha$ for the F-distribution. [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]].

Tables give values of $f_\alpha$ only for $\alpha = 0.05$ and $\alpha = 0.01$ for various combinations of the degrees of freedom $v_1$ and $v_2$. Hence, the f-value with $6$ and $10$ degrees of freedom, leaving an area of $0.05$ to the right, is $f_{0.05} = 3.22$. By means of the following theorem, tables can also be used to find values of $f_{0.95}$ and $f_{0.99}$.

>[!theorem] Theorem:
>Writing $f_\alpha(v_1, v_2)$ for $f_\alpha$ with $v_1$ and $v_2$ degrees of freedom, we obtain
>$$f_{1-\alpha}(v_1, v_2) = \frac{1}{f_\alpha(v_2, v_1)}$$

Thus, the f-value with $6$ and $10$ degrees of freedom, leaving an area of $0.95$ to the right, is:
$$f_{0.95}(6, 10) = \frac{1}{f_{0.05}(10, 6)} = \frac{1}{4.06} = 0.246$$

## The F-Distribution with Two Sample Variances

Suppose that random samples of size $n_1$ and $n_2$ are selected from two normal populations with variances $\sigma_1^2$ and $\sigma_2^2$, respectively. From the [[#Sampling Distribution of S²|theorem]], we know that:
$${{{\chi}_{1}}}^{2} = \frac{(n_1 - 1)S_1^2}{\sigma_1^2} \quad \text{and} \quad {{{\chi}_{2}}}^{2} = \frac{(n_2 - 1)S_2^2}{\sigma_2^2}$$
are random variables having chi-squared distributions with $v_1 = n_1 - 1$ and $v_2 = n_2 - 1$ degrees of freedom. Furthermore, since the samples are selected at random, we are dealing with independent random variables. Then, using the F-distribution theorem with $\chi_1^2 = U$ and $\chi_2^2 = V$, we obtain the following result.

>[!theorem] Theorem:
>If ${{{S}_{1}}}^{2}$ and ${{{S}_{2}}}^{2}$ are the variances of independent random samples of size $n_1$ and $n_2$ taken from normal populations with variances ${{{\sigma}_{1}}}^{2}$ and ${{{\sigma}_{2}}}^{2}$, respectively, then
>$$F = \frac{{{{S}_{1}}}^{2}/{{{\sigma}_{1}}}^{2}}{{{{S}_{2}}}^{2}/{{{\sigma}_{2}}}^{2}} = \dfrac{{{{\sigma}_{2}}}^{2}{{{S}_{1}}}^{2}}{{{{\sigma}_{1}}}^{2}{{{S}_{2}}}^{2}}$$
>has an F-distribution with $v_1 = n_1 - 1$ and $v_2 = n_2 - 1$ degrees of freedom.

## What Is the F-Distribution Used For?

We answered this question, in part, at the beginning of this section. The F-distribution is used in two-sample situations to draw inferences about the population variances. This involves the application of the theorem above. However, the F-distribution can also be applied to many other types of problems involving sample variances. In fact, the F-distribution is called the **variance ratio distribution**.

As an illustration, consider a case in which two paints, $A$ and $B$, were compared with regard to mean drying time. The normal distribution applies nicely (assuming that $\sigma_A$ and $\sigma_B$ are known). However, suppose that there are three types of paints to compare, say $A$, $B$, and $C$. We wish to determine if the population means are equivalent. Suppose that important summary information from the experiment is as follows:

| Paint | Sample Mean            | Sample Variance | Sample Size |
| ----- | ---------------------- | --------------- | ----------- |
| $A$   | $\overline{X}_A = 4.5$ | $s_A^2 = 0.20$  | $10$        |
| $B$   | $\overline{X}_B = 5.5$ | $s_B^2 = 0.14$  | $10$        |
| $C$   | $\overline{X}_C = 6.5$ | $s_C^2 = 0.11$  | $10$        |

The problem centers around whether or not the sample averages $(\overline{x}_A, \overline{x}_B, \overline{x}_C)$ are far enough apart. The implication of "far enough apart" is very important. It would seem reasonable that if the variability between sample averages is larger than what one would expect by chance, the data do not support the conclusion that $\mu_A = \mu_B = \mu_C$. Whether these sample averages could have occurred by chance depends on the variability within samples, as quantified by $s_A^2$, $s_B^2$, and $s_C^2$.

The notion of the important components of variability is best seen through some simple graphics. Consider the plot of raw data from samples $A$, $B$, and $C$, shown in the following figure. These data could easily have generated the above summary information.

![[Pasted image 20250615135405.png|bookhue|600]]
>Data from three distinct samples. [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]].

It appears evident that the data came from distributions with different population means, although there is some overlap between the samples. An analysis that involves all of the data would attempt to determine if the variability between the sample averages and the variability within the samples could have occurred jointly if in fact the populations have a common mean. Notice that the key to this analysis centers around the following two sources of variability:

>[!info] Two Sources of Variability:
>1. **Variability within samples** (between observations in distinct samples)
>2. **Variability between samples** (between sample averages)

Clearly, if the variability in (1) is considerably larger than that in (2), there will be considerable overlap in the sample data, a signal that the data could all have come from a common distribution. An example is found in the data set shown in the following figure:

![[Pasted image 20250615135522.png|bookhue|600]]
>Data that easily could have come from the same population. [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]].

On the other hand, it is very unlikely that data from distributions with a common mean could have variability between sample averages that is considerably larger than the variability within samples.

The sources of variability in (1) and (2) above generate important ratios of sample variances, and ratios are used in conjunction with the F-distribution. The general procedure involved is called **analysis of variance**. It is interesting that in the paint example described here, we are dealing with inferences on three population means, but two sources of variability are used. We will not supply details here, but in future chapters we make extensive use of analysis of variance, and, of course, the F-distribution plays an important role.

>[!notes] Key Applications of F-Distribution:
>- Comparing population variances from two or more samples
>- Analysis of variance (ANOVA) procedures
>- Testing equality of multiple population means
>- Quality control and experimental design
>- The F-distribution is also known as the variance ratio distribution


