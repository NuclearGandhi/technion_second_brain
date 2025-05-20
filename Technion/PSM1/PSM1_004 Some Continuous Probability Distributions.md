---
aliases:
  - continuous uniform distribution
  - normal distribution
  - Gaussian distribution
  - rectangular distribution
---
# Continuous Uniform Distribution

One of the simplest continuous distributions in statistics is the **continuous uniform distribution**. This distribution is characterized by a [[PSM1_002 Random Variables#Probability Density Function|density function]] that is "flat," making the probability uniform in a closed interval $[A, B]$. While applications of the continuous uniform distribution are not as abundant as those for other distributions in this chapter, it provides a good introduction to continuous distributions.

## Uniform Distribution

>[!def] Definition: 
>The density function of the continuous uniform random variable $X$ on the interval $[A, B]$ is:
>$$f(x; A, B) = \begin{cases}
>\frac{1}{B-A}, & A \leq x \leq B \\
>0 & \text{elsewhere}
>\end{cases}$$

The density function forms a rectangle with base $B-A$ and constant height $\frac{1}{B-A}$. As a result, the uniform distribution is often called the **rectangular distribution**. Note that the interval may not always be closed $[A, B]$. It can be $(A, B)$ as well.

The density function for a uniform random variable on the interval $[1, 3]$ is shown in the figure below:

![[{3B906D64-C7C7-4D12-98FB-2FE99F71D96C}.png|bookhue|400]]
>The density function for a random variable on the interval $[1, 3]$. [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]].

Probabilities are simple to calculate for the uniform distribution because of the simple nature of the density function. However, note that the application of this distribution is based on the assumption that the probability of falling in an interval of fixed length within $[A, B]$ is constant.

>[!example] Example: Conference Room Booking
>Suppose that a large conference room at a certain company can be reserved for no more than 4 hours. Both long and short conferences occur quite often. In fact, it can be assumed that the length $X$ of a conference has a uniform distribution on the interval $[0, 4]$.
>
>1. What is the probability density function?
>
>2. What is the probability that any given conference lasts at least 3 hours?
>
>**Solution**:
>
>1. The appropriate density function for the uniformly distributed random variable $X$ in this situation is:
>$$f(x) = \begin{cases}
>\frac{1}{4}, & 0 \leq x \leq 4, \\
>0, & \text{elsewhere}.
>\end{cases}$$
>
>2. $P[X \geq 3] = \int_3^4 \frac{1}{4} dx = \frac{1}{4}$.

>[!theorem] Theorem: 
>The mean and variance of the uniform distribution are:
>$$\mu = \frac{A+B}{2} \quad \text{and} \quad \sigma^2 = \frac{(B-A)^2}{12}$$

# Normal Distribution

The most important continuous probability distribution in the entire field of statistics is the **normal distribution**. Its graph, called the **normal curve**, is the bell-shaped curve shown below, which approximately describes many phenomena that occur in nature, industry, and research.

![[{3C38BD34-FA5E-4D1F-B9A6-10AA4D1E63A9}.png|bookhue|500]]
>The normal curve. [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]].

For example, physical measurements in areas such as meteorological experiments, rainfall studies, and measurements of manufactured parts are often more than adequately explained with a normal distribution. In addition, errors in scientific measurements are extremely well approximated by a normal distribution.

In 1733, Abraham DeMoivre developed the mathematical equation of the normal curve. It provided a basis from which much of the theory of inductive statistics is founded. The normal distribution is often referred to as the **Gaussian distribution**, in honor of Karl Friedrich Gauss (1777–1855), who also derived its equation from a study of errors in repeated measurements of the same quantity.

A continuous random variable $X$ having the bell-shaped distribution is called a **normal random variable**. The mathematical equation for the probability distribution of the normal variable depends on the two parameters $\mu$ and $\sigma$, its mean and standard deviation, respectively. Hence, we denote the values of the density of $X$ by $n(x; \mu, \sigma)$.

## Normal Distribution Formula

>[!def] Definition: 
>The density of the normal random variable $X$, with mean $\mu$ and variance $\sigma^2$, is:
>$$n(x; \mu, \sigma) = \frac{1}{\sqrt{2\pi\sigma}}e^{-\frac{1}{2\sigma^2}(x-\mu)^2}, \quad -\infty < x < \infty$$

Once $\mu$ and $\sigma$ are specified, the normal curve is completely determined. For example, if $\mu = 50$ and $\sigma = 5$, then the ordinates $n(x; 50, 5)$ can be computed for various values of $x$ and the curve drawn.

The following figures illustrate how the parameters $\mu$ and $\sigma$ affect the shape and position of the normal curve:

![[{866E488A-F8C7-479C-8D75-1BDF0E25D3E6}.png|bookhue|500]]
>Normal curves with $\mu_1 < \mu_2$ and $\sigma_1 = \sigma_2$.

In the figure above, we have two normal curves having the same standard deviation but different means. The two curves are identical in form but are centered at different positions along the horizontal axis.

![[{0FA290DC-48AB-45F1-B13E-567F167489EF}.png|bookhue|500]]
>Normal curves with $\mu_1 = \mu_2$ and $\sigma_1 < \sigma_2$.

In this figure, we have two normal curves with the same mean but different standard deviations. The curves are centered at exactly the same position on the horizontal axis, but the curve with the larger standard deviation is lower and spreads out farther. Remember that the area under a probability curve must be equal to 1, and therefore the more variable the set of observations, the lower and wider the corresponding curve will be.

![[{31DCA7C0-F090-4B38-BF7B-B28570F21AA9}.png|bookhue|500]]
>Normal curves with $\mu_1 < \mu_2$ and $\sigma_1 < \sigma_2$.

This figure shows two normal curves having different means and different standard deviations. They are centered at different positions on the horizontal axis and their shapes reflect the two different values of $\sigma$.

## Properties of the Normal Curve

Based on inspection of the figures and examination of the first and second derivatives of $n(x; \mu, \sigma)$, we can list the following properties of the normal curve:

1. The mode, which is the point on the horizontal axis where the curve is a maximum, occurs at $x = \mu$.

2. The curve is symmetric about a vertical axis through the mean $\mu$.

3. The curve has its points of inflection at $x = \mu \pm \sigma$; it is concave downward if $\mu - \sigma < X < \mu + \sigma$ and is concave upward otherwise.

4. The normal curve approaches the horizontal axis asymptotically as we proceed in either direction away from the mean.

5. The total area under the curve and above the horizontal axis is equal to 1.

>[!theorem] Theorem: 
>The mean and variance of $n(x; \mu, \sigma)$ are $\mu$ and $\sigma^2$, respectively. Hence, the standard deviation is $\sigma$.

**Proof**:
To evaluate the mean, we first calculate:
$$E(X - \mu) = \int_{-\infty}^{\infty} \frac{x-\mu}{\sqrt{2\pi\sigma}}e^{-\frac{1}{2}\left(\frac{x-\mu}{\sigma}\right)^2} dx.$$

Setting $z = (x - \mu)/\sigma$ and $dx = \sigma dz$, we obtain:
$$E(X - \mu) = \frac{1}{\sqrt{2\pi}}\int_{-\infty}^{\infty} ze^{-\frac{1}{2}z^2} dz = 0,$$

since the integrand above is an odd function of $z$. Using the properties of expected value, we conclude that:
$$E(X) = \mu.$$

The variance of the normal distribution is given by:
$$E[(X - \mu)^2] = \frac{1}{\sqrt{2\pi\sigma}}\int_{-\infty}^{\infty} (x - \mu)^2e^{-\frac{1}{2}[(x-\mu)/\sigma]^2} dx.$$

Again setting $z = (x - \mu)/\sigma$ and $dx = \sigma dz$, we obtain:
$$E[(X - \mu)^2] = \frac{\sigma^2}{\sqrt{2\pi}}\int_{-\infty}^{\infty} z^2e^{-\frac{z^2}{2}} dz.$$

Integrating by parts with $u = z$ and $dv = ze^{-z^2/2} dz$ so that $du = dz$ and $v = -e^{-z^2/2}$, we find that:
$$\begin{aligned}
E[(X - \mu)^2]  & = \frac{\sigma^2}{\sqrt{2\pi}}\left(-ze^{-z^2/2}\bigg|_{-\infty}^{\infty} + \int_{-\infty}^{\infty} e^{-z^2/2} dz\right)  \\[1ex]
 & = \sigma^2(0 + 1)  \\[1ex]
 & = \sigma^2
\end{aligned}$$
$$\tag*{$\blacksquare$}$$

## Applications of the Normal Distribution

Many random variables have probability distributions that can be described adequately by the normal curve once $\mu$ and $\sigma^2$ are specified. In this chapter, we shall assume that these two parameters are known, perhaps from previous investigations.

The normal distribution plays a significant role as a reasonable approximation of scientific variables in real-life experiments. There are other applications of the normal distribution that include:

1. The normal distribution finds enormous application as a limiting distribution.

2. Under certain conditions, the normal distribution provides a good continuous approximation to the binomial and hypergeometric distributions.

3. The limiting distribution of sample averages is normal, which provides a broad base for statistical inference that proves very valuable for estimation and hypothesis testing.

4. Theory in important areas such as analysis of variance and quality control is based on assumptions that make use of the normal distribution.

## Areas Under the Normal Curve

The curve of any continuous probability distribution (or density function) is constructed so that the area under the curve, bounded by the two ordinates $x = x_1$ and $x = x_2$, equals the probability that the random variable $X$ assumes a value between $x_1$ and $x_2$:

$$
\begin{aligned}
P(x_1 < X < x_2)  & = \int_{x_1}^{x_2} n(x; \mu, \sigma) \, dx  \\[1ex]
 & = \frac{1}{\sqrt{2\pi\sigma}} \int_{x_1}^{x_2} e^{-\frac{1}{2\sigma^2}(x-\mu)^2} dx
\end{aligned}
$$

This probability is represented by the area of the shaded region under the normal curve between $x_1$ and $x_2$.

![[{0D677C63-5D11-4C80-8522-580ED5A3A6F7}.png|bookhue|500]]
>Area under the normal curve between $x_1$ and $x_2$ represents $P(x_1 < X < x_2)$.

In previous figures, we saw how the normal curve depends on the mean ($\mu$) and standard deviation ($\sigma$) of the distribution. The area under the curve between any two ordinates also depends on $\mu$ and $\sigma$. This is illustrated below, where shaded regions correspond to $P(x_1 < X < x_2)$ for two curves with different means and variances:

![[{12FB2419-6B2C-439A-B560-A7836E52EFCA}.png|bookhue|600]]
>Shaded regions for $P(x_1 < X < x_2)$ for two different normal curves.

The two shaded regions are different in size; therefore, the probability associated with each distribution will be different for the same $x_1$ and $x_2$.

### Standardization and the Standard Normal Distribution

Calculating areas under the normal curve for every possible $\mu$ and $\sigma$ would require an infinite number of tables. Fortunately, we can transform any normal random variable $X$ into a standard normal variable $Z$ with mean $0$ and variance $1$ using the transformation:

$$
Z = \frac{X - \mu}{\sigma}
$$

Whenever $X$ assumes a value $x$, the corresponding value of $Z$ is $z = (x - \mu)/\sigma$. Therefore, if $X$ falls between $x_1$ and $x_2$, $Z$ falls between $z_1 = (x_1 - \mu)/\sigma$ and $z_2 = (x_2 - \mu)/\sigma$.

Thus,
$$
P(x_1 < X < x_2) = \int_{x_1}^{x_2} n(x; \mu, \sigma) dx = \int_{z_1}^{z_2} n(z; 0, 1) dz = P(z_1 < Z < z_2)
$$
where $n(z; 0, 1)$ is the standard normal density.

>[!def] Definition:
>The distribution of a normal random variable with mean $0$ and variance $1$ is called the **standard normal distribution**.

![[{1F22C59A-21EC-463B-B35B-BF49D3967CD5}.png|bookhue|600]]
>The area under the $X$-curve between $x_1$ and $x_2$ equals the area under the $Z$-curve between $z_1$ and $z_2$.

Tables of the standard normal distribution (Table A.3) provide $P(Z < z)$ for values of $z$ from $-3.49$ to $3.49$. For example, to find $P(Z < 1.74)$, locate $z = 1.7$ in the left column and $0.04$ in the top row; the value is $0.9591$.

To find a $z$ value corresponding to a given probability, reverse the process. For example, the $z$ value leaving an area of $0.2148$ to the left is $-0.79$.

>[!example] Example:
>Given a standard normal distribution, find the area under the curve that lies
>1. to the right of $z = 1.84$ and
>2. between $z = -1.97$ and $z = 0.86$.
>
>![[{12ECE2DA-E126-48A0-A906-E29AEEF6DC52}.png|bookhue|450]]
>
>**Solution**:
>
>1. The area to the right of $z = 1.84$ is 
>	$$1 - P(Z < 1.84) = 1 - 0.9671 = 0.0329$$
>
>2. The area between $z = -1.97$ and $z = 0.86$ is 
>	$$P(Z < 0.86) - P(Z < -1.97) = 0.8051 - 0.0244 = 0.7807$$

>[!example] Example:
>Given a standard normal distribution, find the value of $k$ such that
>**(a)** $P(Z > k) = 0.3015$ and
>**(b)** $P(k < Z < -0.18) = 0.4197$.
>
>![[{1D97C1C4-F450-4803-9C8E-2FFA6B76E959}.png|bookhue|500]]
>
>**Solution**:
>
>1. $k$ leaves $0.3015$ to the right, so $0.6985$ to the left. From the table, $k = 0.52$.
>
>2. The area to the left of $-0.18$ is $0.4286$. The area between $k$ and $-0.18$ is $0.4197$, so the area to the left of $k$ is $0.4286 - 0.4197 = 0.0089$. From the table, $k = -2.37$.

>[!example] Example:
>Given $X \sim N(50, 10^2)$, find $P(45 < X < 62)$.
>
>![[{794A901D-A8B2-4D95-9DDC-1A3F89966649}.png|bookhue|500]]
>
>**Solution**:
>
>The $z$ values are 
>$$z_1 = (45-50)/10 = -0.5$, $z_2 = (62-50)/10 = 1.2$$
>Therefore:
>$$\begin{aligned}
P(45 < X < 62)  & = P(-0.5 < Z < 1.2)  \\[1ex]
 & = P(Z < 1.2) - P(Z < -0.5)  \\[1ex]
 & = 0.8849 - 0.3085  \\[1ex]
 & = 0.5764
\end{aligned}$$

>[!example] Example:
>Given $X \sim N(300, 50^2)$, find $P(X > 362)$.
>
>![[{5242F757-EE3E-4DFA-813E-060E3A460E8F}.png|bookhue|500]]
>
>**Solution**:
>
>$z = (362-300)/50 = 1.24$.
>
>$P(X > 362) = 1 - P(Z < 1.24) = 1 - 0.8925 = 0.1075$.

### Probability within $k$ Standard Deviations

According to Chebyshev's theorem, the probability that a random variable assumes a value within $2$ standard deviations of the mean is at least $3/4$. For the normal distribution, the $z$ values corresponding to $x_1 = \mu - 2\sigma$ and $x_2 = \mu + 2\sigma$ are $z_1 = -2$ and $z_2 = 2$.

$$
P(\mu - 2\sigma < X < \mu + 2\sigma) = P(-2 < Z < 2) = P(Z < 2) - P(Z < -2) = 0.9772 - 0.0228 = 0.9544
$$

This is a much stronger statement than Chebyshev's theorem.

### Using the Normal Curve in Reverse

Sometimes, we are required to find the value of $z$ (or $x$) corresponding to a specified probability. Rearranging the standardization formula gives $x = \sigma z + \mu$.

>[!example] Example:
>Given $X \sim N(40, 6^2)$, find the value of $x$ that has
>1. $45\%$ of the area to the left and
>2. $14\%$ of the area to the right.
>
>![[{D2607958-CF89-48F2-8CB9-73C7FCE2DE60}.png|bookhue|600]]
>
>**Solution**:
>
>1. $P(Z < z) = 0.45 \implies z = -0.13$, so $x = 6 \cdot (-0.13) + 40 = 39.22$.
>
>2. $P(Z < z) = 0.86 \implies z = 1.08$, so $x = 6 \cdot 1.08 + 40 = 46.48$.

# Gamma and Exponential Distributions

Although the normal distribution can be used to solve many problems in engineering and science, there are still numerous situations that require different types of density functions. Two such density functions, the **gamma and exponential distributions**, are discussed in this section. It turns out that the exponential distribution is a special case of the gamma distribution. Both find a large number of applications.

The exponential and gamma distributions play an important role in both queuing theory and reliability problems. Time between arrivals at service facilities and time to failure of component parts and electrical systems often are nicely modeled by the exponential distribution. The relationship between the gamma and the exponential allows the gamma to be used in similar types of problems.

## The Gamma Function

The gamma distribution derives its name from the well-known gamma function, studied in many areas of mathematics. Before we proceed to the gamma distribution, let us review this function and some of its important properties.

>[!def] Definition: 
>The gamma function is defined by
>$$\Gamma(\alpha) = \int_0^{\infty} x^{\alpha-1}e^{-x} \mathrm{d}x \qquad \alpha > 0.$$

The following are a few simple properties of the gamma function:

1. $\Gamma(\alpha) = (\alpha - 1)\Gamma(\alpha - 1)$, for $\alpha > 1$.
2. $\Gamma(n) = (n - 1)!$ for a positive integer $n$.
3. $\Gamma(1) = 1$.
4. $\Gamma(1/2) = \sqrt{\pi}$.

## Gamma Distribution

>[!def] Definition: 
>The continuous random variable $X$ has a **gamma distribution**, with parameters $\alpha$ and $\beta$, if its density function is given by
>$$f(x; \alpha, \beta) = \begin{cases}
>\frac{1}{\beta^{\alpha}\Gamma(\alpha)}x^{\alpha-1}e^{-x/\beta} & x > 0 \\
>0 & \text{elsewhere},
>\end{cases}$$
>where $\alpha > 0$ and $\beta > 0$.

Graphs of several gamma distributions are shown in the figure below for certain specified values of the parameters $\alpha$ and $\beta$.

![[{3F374FA4-528F-4C1D-BAD6-0B8F4274B802}.png|bookhue|500]]
>Gamma distributions with different values of $\alpha$ for $\beta=1$. [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]].

## Exponential Distribution

The special gamma distribution for which $\alpha = 1$ is called the **exponential distribution**.

>[!def] Definition: 
>The continuous random variable $X$ has an **exponential distribution**, with parameter $\beta$, if its density function is given by
>$$f(x; \beta) = \begin{cases}
>\frac{1}{\beta}e^{-x/\beta}, & x > 0, \\
>0, & \text{elsewhere},
>\end{cases}$$
>where $\beta > 0$.

>[!theorem] Theorem: 
>The mean and variance of the gamma distribution are
>$$\mu = \alpha\beta \quad \text{and} \quad \sigma^2 = \alpha\beta^2.$$

>[!theorem] Corollary: 
>The mean and variance of the exponential distribution are
>$$\mu = \beta \quad \text{and} \quad \sigma^2 = \beta^2.$$

## Relationship to the Poisson Process

We shall pursue applications of the exponential distribution and then return to the gamma distribution. The most important applications of the exponential distribution are situations where the Poisson process applies (see [[PSM1_003 Some Discrete Probability  Distributions#Poisson Distribution and the Poisson Process|Poisson distribution]]). 

The relationship between the exponential distribution (often called the negative exponential) and the Poisson process is quite simple. In the Poisson distribution, the parameter $\lambda$ may be interpreted as the mean number of events per unit "time." Consider now the random variable described by the time required for the first event to occur. Using the Poisson distribution, we find that the probability of no events occurring in the span up to time $t$ is given by

$$p(0; \lambda t) = \frac{e^{-\lambda t}(\lambda t)^0}{0!} = e^{-\lambda t}.$$

Let $X$ be the time to the first Poisson event. The probability that the length of time until the first event will exceed $x$ is the same as the probability that no Poisson events will occur in $x$. The latter is given by $e^{-\lambda x}$. As a result,

$$P(X > x) = e^{-\lambda x}.$$

Thus, the cumulative distribution function for $X$ is given by

$$P(0 \leq X \leq x) = 1 - e^{-\lambda x}.$$

Now, differentiating the cumulative distribution function above to obtain the density function:

$$f(x) = \lambda e^{-\lambda x},$$

which is the density function of the exponential distribution with $\lambda = 1/\beta$.

## Applications of the Exponential and Gamma Distributions

The exponential distribution applies in "time to arrival" or time to Poisson event problems. The mean of the exponential distribution is the parameter $\beta$, the reciprocal of the parameter in the Poisson distribution. 

An important aspect of the Poisson distribution is that it has no memory, implying that occurrences in successive time periods are independent. The parameter $\beta$ is the mean time between events. In reliability theory, where equipment failure often conforms to this Poisson process, $\beta$ is called **mean time between failures**. Many equipment breakdowns follow the Poisson process, and thus the exponential distribution applies. Other applications include survival times in biomedical experiments and computer response time.

>[!example] Example: Reliability Analysis
>Suppose that a system contains a certain type of component whose time, in years, to failure is given by $T$. The random variable $T$ is modeled by the exponential distribution with mean time to failure $\beta = 5$. If $5$ of these components are installed in different systems, what is the probability that at least $2$ are still functioning at the end of $8$ years?
>
>**Solution**:
>The probability that a given component is still functioning after $8$ years is given by
>$$P(T > 8) = \frac{1}{5}\int_8^{\infty} e^{-t/5} dt = e^{-8/5} \approx 0.2.$$
>
>Let $X$ represent the number of components functioning after $8$ years. Then using the binomial distribution, we have
>$$\begin{aligned}
>P(X \geq 2) &= \sum_{x=2}^{5} b(x; 5, 0.2) \\[1ex]
>&= 1 - \sum_{x=0}^{1} b(x; 5, 0.2) \\[1ex]
>&= 1 - 0.7373 \\[1ex]
>&= 0.2627
>\end{aligned}$$

## The Memoryless Property

The types of applications of the exponential distribution in reliability and component or machine lifetime problems are influenced by the **memoryless property** of the exponential distribution. For example, in the case of an electronic component where lifetime has an exponential distribution, the probability that the component lasts $t$ hours, $P(X \geq t)$, is the same as the conditional probability

$$P(X \geq t_0 + t | X \geq t_0).$$

This means that if the component "makes it" to $t_0$ hours, the probability of lasting an additional $t$ hours is the same as the probability of lasting $t$ hours from the beginning. There is no "punishment" through wear that may have ensued for lasting the first $t_0$ hours. Thus, the exponential distribution is more appropriate when the memoryless property is justified.

If the failure of the component is a result of gradual or slow wear (as in mechanical wear), then the exponential does not apply and either the gamma or the Weibull distribution may be more appropriate.

## Applications of the Gamma Distribution

The importance of the gamma distribution lies in the fact that it defines a family of which other distributions are special cases. But the gamma itself has important applications in waiting time and reliability theory.

Whereas the exponential distribution describes the time until the occurrence of a Poisson event (or the time between Poisson events), the time (or space) occurring until a specified number of Poisson events occur is a random variable whose density function is described by the gamma distribution. This specific number of events is the parameter $\alpha$ in the gamma density function. Thus, when $\alpha = 1$, the special case of the exponential distribution occurs.

>[!example] Example: Telephone Call Analysis
>Suppose that telephone calls arriving at a particular switchboard follow a Poisson process with an average of 5 calls coming per minute. What is the probability that up to a minute will elapse by the time 2 calls have come in to the switchboard?
>
>**Solution**:
>The Poisson process applies, with time until 2 Poisson events following a gamma distribution with $\beta = 1/5$ and $\alpha = 2$. Denote by $X$ the time in minutes that transpires before 2 calls come. The required probability is given by
>$$\begin{aligned}
>P(X \leq 1) &= \int_0^1 \frac{1}{\beta^2}xe^{-x/\beta} dx \\
>&= 25\int_0^1 xe^{-5x} dx \\
>&= 1 - e^{-5}(1 + 5) \\
>&= 0.96
>\end{aligned}$$

While the origin of the gamma distribution deals in time (or space) until the occurrence of $\alpha$ Poisson events, there are many instances where a gamma distribution works very well even though there is no clear Poisson structure. This is particularly true for survival time problems in both engineering and biomedical applications.

>[!example] Example: Biomedical Study
>In a biomedical study with rats, a dose-response investigation is used to determine the effect of the dose of a toxicant on their survival time. The toxicant is one that is frequently discharged into the atmosphere from jet fuel. For a certain dose of the toxicant, the study determines that the survival time, in weeks, has a gamma distribution with $\alpha = 5$ and $\beta = 10$. What is the probability that a rat survives no longer than 60 weeks?
>
>**Solution**:
>Let the random variable $X$ be the survival time (time to death). The required probability is
>$$P(X \leq 60) = \frac{1}{\beta^5}\int_0^{60} \frac{x^{\alpha-1}e^{-x/\beta}}{\Gamma(5)} dx.$$
>
>The integral above can be solved through the use of the incomplete gamma function, which becomes the cumulative distribution function for the gamma distribution. This function is written as
>$$F(x; \alpha) = \int_0^x \frac{y^{\alpha-1}e^{-y}}{\Gamma(\alpha)} dy.$$
>
>If we let $y = x/\beta$, so $x = \beta y$, we have
>$$P(X \leq 60) = \int_0^6 \frac{y^4e^{-y}}{\Gamma(5)} dy,$$
>
>which is denoted as $F(6; 5)$ in the table of the incomplete gamma function. For this problem, the probability that the rat survives no longer than 60 weeks is given by
>$$P(X \leq 60) = F(6; 5) = 0.715.$$

>[!example] Example: Customer Complaints Analysis
>It is known, from previous data, that the length of time in months between customer complaints about a certain product is a gamma distribution with $\alpha = 2$ and $\beta = 4$. Changes were made to tighten quality control requirements. Following these changes, 20 months passed before the first complaint. Does it appear as if the quality control tightening was effective?
>
>**Solution**:
>Let $X$ be the time to the first complaint, which, under conditions prior to the changes, followed a gamma distribution with $\alpha = 2$ and $\beta = 4$. The question centers around how rare $X \geq 20$ is, given that $\alpha$ and $\beta$ remain at values 2 and 4, respectively. In other words, under the prior conditions is a "time to complaint" as large as 20 months reasonable?
>
>$$P(X \geq 20) = 1 - \frac{1}{\beta^\alpha}\int_0^{20} \frac{x^{\alpha-1}e^{-x/\beta}}{\Gamma(\alpha)} dx.$$
>
>Again, using $y = x/\beta$, we have
>$$\begin{aligned}
>P(X \geq 20) &= 1 - \int_0^5 \frac{ye^{-y}}{\Gamma(2)} dy \\
>&= 1 - F(5; 2) \\
>&= 1 - 0.96 \\
>&= 0.04
>\end{aligned}$$
>
>where $F(5; 2) = 0.96$ is found from tables of the incomplete gamma function. As a result, we could conclude that the conditions of the gamma distribution with $\alpha = 2$ and $\beta = 4$ are not supported by the data that an observed time to complaint is as large as 20 months. Thus, it is reasonable to conclude that the quality control work was effective.

>[!example] Example: Washing Machine Repair
>Based on extensive testing, it is determined that the time $Y$ in years before a major repair is required for a certain washing machine is characterized by the density function
>$$f(y) = \begin{cases}
>\frac{1}{4}e^{-y/4}, & y \geq 0, \\
>0, & \text{elsewhere}.
>\end{cases}$$
>
>Note that $Y$ is an exponential random variable with $\mu = 4$ years. The machine is considered a bargain if it is unlikely to require a major repair before the sixth year. What is the probability $P(Y > 6)$? What is the probability that a major repair is required in the first year?
>
>**Solution**:
>Consider the cumulative distribution function $F(y)$ for the exponential distribution,
>$$F(y) = \frac{1}{\beta}\int_0^y e^{-t/\beta} dt = 1 - e^{-y/\beta}.$$
>
>Then
>$$P(Y > 6) = 1 - F(6) = e^{-6/4} = e^{-3/2} = 0.2231.$$
>
>Thus, the probability that the washing machine will require major repair after year six is 0.223. Of course, it will require repair before year six with probability 0.777. Thus, one might conclude the machine is not really a bargain. 
>
>The probability that a major repair is necessary in the first year is
>$$P(Y < 1) = 1 - e^{-1/4} = 1 - 0.779 = 0.221.$$