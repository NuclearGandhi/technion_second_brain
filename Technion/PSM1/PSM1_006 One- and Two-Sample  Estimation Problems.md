---
aliases:
---

# Introduction

In previous chapters, we emphasized sampling properties of the sample mean and variance. We also emphasized displays of data in various forms. The purpose of these presentations is to build a foundation that allows us to draw conclusions about the population parameters from experimental data. For example, the [[PSM1_005 Fundamental Sampling Distributions and Data Descriptions#The Central Limit Theorem|Central Limit Theorem]] provides information about the distribution of the sample mean $\overline{X}$. The distribution involves the population mean $\mu$. Thus, any conclusions concerning $\mu$ drawn from an observed sample average must depend on knowledge of this sampling distribution. Similar comments apply to $S^2$ and $\sigma^2$. Clearly, any conclusions we draw about the variance of a normal distribution will likely involve the sampling distribution of $S^2$.

In this chapter, we begin by formally outlining the purpose of statistical inference. We follow this by discussing the problem of estimation of population parameters. We confine our formal developments of specific estimation procedures to problems involving one and two samples.

# Statistical Inference

In [[PSM1_001 Introduction and Probability|Chapter 1]], we discussed the general philosophy of formal statistical inference. **Statistical inference** consists of those methods by which one makes inferences or generalizations about a population. The trend today is to distinguish between the classical method of estimating a population parameter, whereby inferences are based strictly on information obtained from a random sample selected from the population, and the Bayesian method, which utilizes prior subjective knowledge about the probability distribution of the unknown parameters in conjunction with the information provided by the sample data.

Throughout most of this chapter, we shall use classical methods to estimate unknown population parameters such as the mean, the proportion, and the variance by computing statistics from random samples and applying the theory of sampling distributions, much of which was covered in [[PSM1_005 Fundamental Sampling Distributions and Data Descriptions|the previous chapter]].

Statistical inference may be divided into two major areas: **estimation** and **tests of hypotheses**. We treat these two areas separately, dealing with theory and applications of estimation in this chapter.

To distinguish clearly between the two areas, consider the following examples:

- A candidate for public office may wish to estimate the true proportion of voters favoring him by obtaining opinions from a random sample of 100 eligible voters. The fraction of voters in the sample favoring the candidate could be used as an estimate of the true proportion in the population of voters. A knowledge of the sampling distribution of a proportion enables one to establish the degree of accuracy of such an estimate. This problem falls in the area of **estimation**.

- Now consider the case in which one is interested in finding out whether brand A floor wax is more scuff-resistant than brand B floor wax. He or she might hypothesize that brand A is better than brand B and, after proper testing, accept or reject this hypothesis. In this example, we do not attempt to estimate a parameter, but instead we try to arrive at a correct decision about a pre-stated hypothesis. This falls under **hypothesis testing**.

Once again we are dependent on sampling theory and the use of data to provide us with some measure of accuracy for our decision.

# Classical Methods of Estimation

A **point estimate** of some population parameter $\theta$ is a single value $\hat{\theta}$ of a statistic $\hat{\Theta}$. For example, the value $\overline{x}$ of the statistic $\overline{X}$, computed from a sample of size $n$, is a point estimate of the population parameter $\mu$. Similarly, $\hat{p} = x/n$ is a point estimate of the true proportion $p$ for a binomial experiment.

An estimator is not expected to estimate the population parameter without error. We do not expect $\overline{X}$ to estimate $\mu$ exactly, but we certainly hope that it is not far off. For a particular sample, it is possible to obtain a closer estimate of $\mu$ by using the sample median $\tilde{X}$ as an estimator.

Consider, for instance, a sample consisting of the values 2, 5, and 11 from a population whose mean is 4 but is supposedly unknown. We would estimate $\mu$ to be $\overline{x} = 6$, using the sample mean as our estimate, or $\tilde{x} = 5$, using the sample median as our estimate. In this case, the estimator $\tilde{X}$ produces an estimate closer to the true parameter than does the estimator $\overline{X}$. On the other hand, if our random sample contains the values 2, 6, and 7, then $\overline{x} = 5$ and $\tilde{x} = 6$, so $\overline{X}$ is the better estimator. Not knowing the true value of $\mu$, we must decide in advance whether to use $\overline{X}$ or $\tilde{X}$ as our estimator.

## Unbiased Estimator

What are the desirable properties of a "good" decision function that would influence us to choose one estimator rather than another? Let $\hat{\Theta}$ be an estimator whose value $\hat{\theta}$ is a point estimate of some unknown population parameter $\theta$. Certainly, we would like the sampling distribution of $\hat{\Theta}$ to have a mean equal to the parameter estimated. An estimator possessing this property is said to be **unbiased**.

>[!def] Definition:
>A statistic $\hat{\Theta}$ is said to be an **unbiased estimator** of the parameter $\theta$ if
>$$\mu_{\hat{\Theta}} = E(\hat{\Theta}) = \theta$$

## Variance of a Point Estimator

If $\hat{\Theta}_1$ and $\hat{\Theta}_2$ are two unbiased estimators of the same population parameter $\theta$, we want to choose the estimator whose sampling distribution has the smaller variance. Hence, if $\sigma^2_{\hat{\theta}_1} < \sigma^2_{\hat{\theta}_2}$, we say that $\hat{\Theta}_1$ is a **more efficient estimator** of $\theta$ than $\hat{\Theta}_2$.

>[!def] Definition:
>If we consider all possible unbiased estimators of some parameter $\theta$, the one with the smallest variance is called the **most efficient estimator** of $\theta$.

The following figure illustrates the sampling distributions of three different estimators, $\hat{\Theta}_1$, $\hat{\Theta}_2$, and $\hat{\Theta}_3$, all estimating $\theta$:

![[Pasted image 20250604135442.png|bookhue|500]]
>Sampling distributions of different estimators of $\theta$. [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]].

It is clear that only $\hat{\Theta}_1$ and $\hat{\Theta}_2$ are unbiased, since their distributions are centered at $\theta$. The estimator $\hat{\Theta}_1$ has a smaller variance than $\hat{\Theta}_2$ and is therefore more efficient. Hence, our choice for an estimator of $\theta$, among the three considered, would be $\hat{\Theta}_1$.

For normal populations, one can show that both $\overline{X}$ and $\tilde{X}$ are unbiased estimators of the population mean $\mu$, but the variance of $\overline{X}$ is smaller than the variance of $\tilde{X}$. Thus, both estimates $\overline{x}$ and $\tilde{x}$ will, on average, equal the population mean $\mu$, but $\overline{x}$ is likely to be closer to $\mu$ for a given sample, and thus $\overline{X}$ is more efficient than $\tilde{X}$.
## Interval Estimation

Even the most efficient unbiased estimator is unlikely to estimate the population parameter exactly. It is true that estimation accuracy increases with large samples, but there is still no reason we should expect a point estimate from a given sample to be exactly equal to the population parameter it is supposed to estimate. There are many situations in which it is preferable to determine an interval within which we would expect to find the value of the parameter. Such an interval is called an **interval estimate**.

An **interval estimate** of a population parameter $\theta$ is an interval of the form $\hat{\theta}_L < \theta < \hat{\theta}_U$, where $\hat{\theta}_L$ and $\hat{\theta}_U$ depend on the value of the statistic $\hat{\Theta}$ for a particular sample and also on the sampling distribution of $\hat{\Theta}$.

For example, a random sample of SAT verbal scores for students in the entering freshman class might produce an interval from 530 to 550, within which we expect to find the true average of all SAT verbal scores for the freshman class. The values of the endpoints, 530 and 550, will depend on the computed sample mean $\overline{x}$ and the sampling distribution of $\overline{X}$.

As the sample size increases, we know that $\sigma^2_{\overline{X}} = \sigma^2/n$ decreases, and consequently our estimate is likely to be closer to the parameter $\mu$, resulting in a shorter interval. Thus, the interval estimate indicates, by its length, the accuracy of the point estimate. An engineer will gain some insight into the population proportion defective by taking a sample and computing the sample proportion defective. But an interval estimate might be more informative.

### Interpretation of Interval Estimates

Since different samples will generally yield different values of $\hat{\Theta}$ and, therefore, different values for $\hat{\theta}_L$ and $\hat{\theta}_U$, these endpoints of the interval are values of corresponding random variables $\hat{\Theta}_L$ and $\hat{\Theta}_U$. From the sampling distribution of $\hat{\Theta}$ we shall be able to determine $\hat{\Theta}_L$ and $\hat{\Theta}_U$ such that $P(\hat{\Theta}_L < \theta < \hat{\Theta}_U)$ is equal to any positive fractional value we care to specify.

If, for instance, we find $\hat{\Theta}_L$ and $\hat{\Theta}_U$ such that

$$P(\hat{\Theta}_L < \theta < \hat{\Theta}_U) = 1 - \alpha$$

for $0 < \alpha < 1$, then we have a probability of $1-\alpha$ of selecting a random sample that will produce an interval containing $\theta$.

>[!def] Definition:
>The interval $\hat{\theta}_L < \theta < \hat{\theta}_U$, computed from the selected sample, is called a **$100(1 - \alpha)\%$ confidence interval**, the fraction $1 - \alpha$ is called the **confidence coefficient** or the **degree of confidence**, and the endpoints, $\hat{\theta}_L$ and $\hat{\theta}_U$, are called the **lower and upper confidence limits**.

Thus, when $\alpha = 0.05$, we have a $95\%$ confidence interval, and when $\alpha = 0.01$, we obtain a wider $99\%$ confidence interval. The wider the confidence interval is, the more confident we can be that the interval contains the unknown parameter.

Of course, it is better to be $95\%$ confident that the average life of a certain television transistor is between 6 and 7 years than to be $99\%$ confident that it is between 3 and 10 years. Ideally, we prefer a short interval with a high degree of confidence. Sometimes, restrictions on the size of our sample prevent us from achieving short intervals without sacrificing some degree of confidence.

In the sections that follow, we pursue the notions of point and interval estimation, with each section presenting a different special case. The reader should notice that while point and interval estimation represent different approaches to gaining information regarding a parameter, they are related in the sense that confidence interval estimators are based on point estimators.

In the following section, for example, we will see that $\overline{X}$ is a very reasonable point estimator of $\mu$. As a result, the important confidence interval estimator of $\mu$ depends on knowledge of the sampling distribution of $\overline{X}$.

We begin the following section with the simplest case of a confidence interval. The scenario is simple and yet unrealistic. We are interested in estimating a population mean $\mu$ and yet $\sigma$ is known. Clearly, if $\mu$ is unknown, it is quite unlikely that $\sigma$ is known. Any historical results that produced enough information to allow the assumption that $\sigma$ is known would likely have produced similar information about $\mu$.

Despite this argument, we begin with this case because the concepts and indeed the resulting mechanics associated with confidence interval estimation remain the same for the more realistic situations presented later in this section and beyond.

# Single Sample: Estimating the Mean

The sampling distribution of $\overline{X}$ is centered at $\mu$, and in most applications the variance is smaller than that of any other estimators of $\mu$. Thus, the sample mean $\overline{x}$ will be used as a point estimate for the population mean $\mu$. Recall that $\sigma^2_{\overline{X}} = \sigma^2/n$, so a large sample will yield a value of $\overline{X}$ that comes from a sampling distribution with a small variance. Hence, $\overline{x}$ is likely to be a very accurate estimate of $\mu$ when $n$ is large.

Let us now consider the interval estimate of $\mu$. If our sample is selected from a normal population or, failing this, if $n$ is sufficiently large, we can establish a confidence interval for $\mu$ by considering the sampling distribution of $\overline{X}$. According to the Central Limit Theorem, we can expect the sampling distribution of $\overline{X}$ to be approximately normally distributed with mean $\mu_{\overline{X}} = \mu$ and standard deviation $\sigma_{\overline{X}} = \sigma/\sqrt{n}$.

Writing $z_{\alpha/2}$ for the $z$-value above which we find an area of $\alpha/2$ under the normal curve, we can see from the following figure that

$$P(-z_{\alpha/2} < Z < z_{\alpha/2}) = 1 - \alpha$$

where

$$Z = \frac{\overline{X} - \mu}{\sigma/\sqrt{n}}$$

![[{38D90642-624B-4E4F-B3A8-E5AB33E74479}.png|bookhue|500]]
>$P(-z_{\alpha/2} < Z < z_{\alpha/2}) = 1 - \alpha$. [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]].

Hence,

$$P\left(-z_{\alpha/2} < \frac{\overline{X} - \mu}{\sigma/\sqrt{n}} < z_{\alpha/2}\right) = 1 - \alpha$$

Multiplying each term in the inequality by $\sigma/\sqrt{n}$ and then subtracting $\overline{X}$ from each term and multiplying by $-1$ (reversing the sense of the inequalities), we obtain

$$P\left(\overline{X} - z_{\alpha/2}\frac{\sigma}{\sqrt{n}} < \mu < \overline{X} + z_{\alpha/2}\frac{\sigma}{\sqrt{n}}\right) = 1 - \alpha$$

A random sample of size $n$ is selected from a population whose variance $\sigma^2$ is known, and the mean $\overline{x}$ is computed to give the $100(1 - \alpha)\%$ confidence interval below. It is important to emphasize that we have invoked the Central Limit Theorem above. As a result, it is important to note the conditions for applications that follow.

>[!def] Definition:
>If $\overline{x}$ is the mean of a random sample of size $n$ from a population with known variance $\sigma^2$, a **$100(1 - \alpha)\%$ confidence interval for $\mu$** is given by
>$$\overline{x} - z_{\alpha/2}\frac{\sigma}{\sqrt{n}} < \mu < \overline{x} + z_{\alpha/2}\frac{\sigma}{\sqrt{n}}$$
>where $z_{\alpha/2}$ is the $z$-value leaving an area of $\alpha/2$ to the right.

For small samples selected from nonnormal populations, we cannot expect our degree of confidence to be accurate. However, for samples of size $n \geq 30$, with the shape of the distributions not too skewed, sampling theory guarantees good results.

Clearly, the values of the random variables $\hat{\Theta}_L$ and $\hat{\Theta}_U$, defined in the previous section, are the confidence limits

$$\hat{\theta}_L = \overline{x} - z_{\alpha/2}\frac{\sigma}{\sqrt{n}} \quad \text{and} \quad \hat{\theta}_U = \overline{x} + z_{\alpha/2}\frac{\sigma}{\sqrt{n}}$$

Different samples will yield different values of $\overline{x}$ and therefore produce different interval estimates of the parameter $\mu$, as shown in the following figure:

![[{93874C83-99A6-4903-92CC-2AE99FC32030}.png|bookhue|500]]
>Interval estimates of $\mu$ for different samples. [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]].

The dot at the center of each interval indicates the position of the point estimate $\overline{x}$ for that random sample. Note that all of these intervals are of the same width, since their widths depend only on the choice of $z_{\alpha/2}$ once $\overline{x}$ is determined. The larger the value we choose for $z_{\alpha/2}$, the wider we make all the intervals and the more confident we can be that the particular sample selected will produce an interval that contains the unknown parameter $\mu$. In general, for a selection of $z_{\alpha/2}$, $100(1 - \alpha)\%$ of the intervals will cover $\mu$.

>[!example] Example: Zinc Concentration
>The average zinc concentration recovered from a sample of measurements taken in 36 different locations in a river is found to be $2.6$ grams per milliliter. Find the $95\%$ and $99\%$ confidence intervals for the mean zinc concentration in the river. Assume that the population standard deviation is $0.3$ gram per milliliter.
>
>**Solution:**
>The point estimate of $\mu$ is $\overline{x} = 2.6$. The $z$-value leaving an area of 0.025 to the right, and therefore an area of 0.975 to the left, is $z_{0.025} = 1.96$ (from table). Hence, the $95\%$ confidence interval is
>$$2.6 - (1.96)\left(\frac{0.3}{\sqrt{36}}\right) < \mu < 2.6 + (1.96)\left(\frac{0.3}{\sqrt{36}}\right)$$
> which reduces to $2.50 < \mu < 2.70$. To find a $99\%$ confidence interval, we find the $z$-value leaving an area of $0.005$ to the right and $0.995$ to the left. From Table A.3 again, $z_{0.005} = 2.575$, and the $99\%$ confidence interval is:
> 
> $$2.6 - (2.575)\left(\frac{0.3}{\sqrt{36}}\right) < \mu < 2.6 + (2.575)\left(\frac{0.3}{\sqrt{36}}\right)$$
> 
> or simply
> 
> $$2.47 < \mu < 2.73$$
> 

We now see that a longer interval is required to estimate $\mu$ with a higher degree of confidence.

## Error in Estimation

The $100(1-\alpha)\%$ confidence interval provides an estimate of the accuracy of our point estimate. If $\mu$ is actually the center value of the interval, then $\overline{x}$ estimates $\mu$ without error. Most of the time, however, $\overline{x}$ will not be exactly equal to $\mu$ and the point estimate will be in error. The size of this error will be the absolute value of the difference between $\mu$ and $\overline{x}$, and we can be $100(1 - \alpha)\%$ confident that this difference will not exceed $z_{\alpha/2}\frac{\sigma}{\sqrt{n}}$. We can readily see this if we draw a diagram of a hypothetical confidence interval, as in the following figure:

![[{FCDD3C73-B39D-4241-810F-CA0C1031C704}.png|bookhue|500]]
>Error in estimating $\mu$ by $\overline{x}$. [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]].

>[!theorem] Theorem:
>If $\overline{x}$ is used as an estimate of $\mu$, we can be $100(1 - \alpha)\%$ confident that the error will not exceed $z_{\alpha/2}\frac{\sigma}{\sqrt{n}}$.

In the previous example, we are $95\%$ confident that the sample mean $\overline{x} = 2.6$ differs from the true mean $\mu$ by an amount less than $1.96\cdot0.3/\sqrt{36} = 0.1$ and $99\%$ confident that the difference is less than $2.575\cdot0.3/\sqrt{36} = 0.13$.

## Sample Size Determination

Frequently, we wish to know how large a sample is necessary to ensure that the error in estimating $\mu$ will be less than a specified amount $e$. By the previous theorem, we must choose $n$ such that $z_{\alpha/2}\frac{\sigma}{\sqrt{n}} = e$. Solving this equation gives the following formula for $n$.

>[!theorem] Theorem:
>If $\overline{x}$ is used as an estimate of $\mu$, we can be $100(1 - \alpha)\%$ confident that the error will not exceed a specified amount $e$ when the sample size is
>$$n = \left(\frac{z_{\alpha/2}\sigma}{e}\right)^2$$

When solving for the sample size, $n$, we round all fractional values up to the next whole number. By adhering to this principle, we can be sure that our degree of confidence never falls below $100(1 - \alpha)\%$.

Strictly speaking, the formula in the theorem above is applicable only if we know the variance of the population from which we select our sample. Lacking this information, we could take a preliminary sample of size $n \geq 30$ to provide an estimate of $\sigma$. Then, using $s$ as an approximation for $\sigma$ in the theorem, we could determine approximately how many observations are needed to provide the desired degree of accuracy.

>[!example] Example: Sample Size Calculation
>How large a sample is required if we want to be $95\%$ confident that our estimate of $\mu$ in the previous example is off by less than $0.05$?
>
>**Solution:**
>The population standard deviation is $\sigma = 0.3$. Then, by theorem above,
>$$n = \left[\frac{(1.96)(0.3)}{0.05}\right]^2 = 138.3$$
>
>Therefore, we can be $95\%$ confident that a random sample of size $139$ will provide an estimate $\overline{x}$ differing from $\mu$ by an amount less than $0.05$.

>[!TODO] TODO: לסדר
## One-Sided Confidence Bounds

The confidence intervals and resulting confidence bounds discussed thus far are two-sided (i.e., both upper and lower bounds are given). However, there are many applications in which only one bound is sought. For example, if the measurement of interest is tensile strength, the engineer receives better information from a lower bound only. This bound communicates the worst-case scenario. On the other hand, if the measurement is something for which a relatively large value of $\mu$ is not profitable or desirable, then an upper confidence bound is of interest. An example would be a case in which inferences need to be made concerning the mean mercury composition in a river. An upper bound is very informative in this case.

One-sided confidence bounds are developed in the same fashion as two-sided intervals. However, the source is a one-sided probability statement that makes use of the Central Limit Theorem:

$$P\left(\frac{\overline{X} - \mu}{\sigma/\sqrt{n}} < z_\alpha\right) = 1 - \alpha$$

One can then manipulate the probability statement much as before and obtain

$$P\left(\mu > \overline{X} - z_\alpha\frac{\sigma}{\sqrt{n}}\right) = 1 - \alpha$$

Similar manipulation of $P\left(\frac{\overline{X} - \mu}{\sigma/\sqrt{n}} > -z_\alpha\right) = 1 - \alpha$ gives

$$P\left(\mu < \overline{X} + z_\alpha\frac{\sigma}{\sqrt{n}}\right) = 1 - \alpha$$

As a result, the upper and lower one-sided bounds follow.

>[!def] One-Sided Confidence Bounds on $\mu$, $\sigma^2$ Known:
>If $\overline{X}$ is the mean of a random sample of size $n$ from a population with variance $\sigma^2$, the one-sided $100(1 - \alpha)\%$ confidence bounds for $\mu$ are given by:
>
>**Upper one-sided bound:** $\overline{x} + z_\alpha\frac{\sigma}{\sqrt{n}}$
>
>**Lower one-sided bound:** $\overline{x} - z_\alpha\frac{\sigma}{\sqrt{n}}$

>[!example] Example 9.4: Psychological Testing
>In a psychological testing experiment, 25 subjects are selected randomly and their reaction time, in seconds, to a particular stimulus is measured. Past experience suggests that the variance in reaction times to these types of stimuli is $4 \text{ sec}^2$ and that the distribution of reaction times is approximately normal. The average time for the subjects is $6.2$ seconds. Give an upper $95\%$ bound for the mean reaction time.
>
>**Solution:**
>The upper $95\%$ bound is given by
>$$\overline{x} + z_\alpha\frac{\sigma}{\sqrt{n}} = 6.2 + (1.645)\frac{\sqrt{4}}{\sqrt{25}} = 6.2 + 0.658 = 6.858 \text{ seconds}$$
>
>Hence, we are $95\%$ confident that the mean reaction time is less than 6.858 seconds.

## The Case of $\sigma$ Unknown

Frequently, we must attempt to estimate the mean of a population when the variance is unknown. The reader should recall learning in [[PSM1_005 Fundamental Sampling Distributions and Data Descriptions|Chapter 8]] that if we have a random sample from a normal distribution, then the random variable

$$T = \frac{\overline{X} - \mu}{S/\sqrt{n}}$$

has a Student $t$-distribution with $n - 1$ degrees of freedom. Here $S$ is the sample standard deviation. In this situation, with $\sigma$ unknown, $T$ can be used to construct a confidence interval on $\mu$. The procedure is the same as that with $\sigma$ known except that $\sigma$ is replaced by $S$ and the standard normal distribution is replaced by the $t$-distribution.

Referring to the following figure, we can assert that

$$P(-t_{\alpha/2} < T < t_{\alpha/2}) = 1 - \alpha$$

where $t_{\alpha/2}$ is the $t$-value with $n-1$ degrees of freedom, above which we find an area of $\alpha/2$. Because of symmetry, an equal area of $\alpha/2$ will fall to the left of $-t_{\alpha/2}$.

![[{FIGURE_9_5}.png|bookhue|500]]
>$P(-t_{\alpha/2} < T < t_{\alpha/2}) = 1 - \alpha$. [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]].

Substituting for $T$, we write

$$P\left(-t_{\alpha/2} < \frac{\overline{X} - \mu}{S/\sqrt{n}} < t_{\alpha/2}\right) = 1 - \alpha$$

Multiplying each term in the inequality by $S/\sqrt{n}$, and then subtracting $\overline{X}$ from each term and multiplying by $-1$, we obtain

$$P\left(\overline{X} - t_{\alpha/2}\frac{S}{\sqrt{n}} < \mu < \overline{X} + t_{\alpha/2}\frac{S}{\sqrt{n}}\right) = 1 - \alpha$$

For a particular random sample of size $n$, the mean $\overline{x}$ and standard deviation $s$ are computed and the following $100(1 - \alpha)\%$ confidence interval for $\mu$ is obtained.

>[!def] Confidence Interval on $\mu$, $\sigma^2$ Unknown:
>If $\overline{x}$ and $s$ are the mean and standard deviation of a random sample from a normal population with unknown variance $\sigma^2$, a $100(1 - \alpha)\%$ confidence interval for $\mu$ is
>$$\overline{x} - t_{\alpha/2}\frac{s}{\sqrt{n}} < \mu < \overline{x} + t_{\alpha/2}\frac{s}{\sqrt{n}}$$
>where $t_{\alpha/2}$ is the $t$-value with $v = n - 1$ degrees of freedom, leaving an area of $\alpha/2$ to the right.

We have made a distinction between the cases of $\sigma$ known and $\sigma$ unknown in computing confidence interval estimates. We should emphasize that for $\sigma$ known we exploited the [[PSM1_005 Fundamental Sampling Distributions and Data Descriptions#The Central Limit Theorem|Central Limit Theorem]], whereas for $\sigma$ unknown we made use of the sampling distribution of the random variable $T$. However, the use of the $t$-distribution is based on the premise that the sampling is from a normal distribution. As long as the distribution is approximately bell shaped, confidence intervals can be computed when $\sigma^2$ is unknown by using the $t$-distribution and we may expect very good results.

Computed one-sided confidence bounds for $\mu$ with $\sigma$ unknown are as the reader would expect, namely

$$\overline{x} + t_\alpha\frac{s}{\sqrt{n}} \quad \text{and} \quad \overline{x} - t_\alpha\frac{s}{\sqrt{n}}$$

They are the upper and lower $100(1 - \alpha)\%$ bounds, respectively. Here $t_\alpha$ is the $t$-value having an area of $\alpha$ to the right.

>[!example] Example 9.5: Sulfuric Acid Containers
>The contents of seven similar containers of sulfuric acid are 9.8, 10.2, 10.4, 9.8, 10.0, 10.2, and 9.6 liters. Find a $95\%$ confidence interval for the mean contents of all such containers, assuming an approximately normal distribution.
>
>**Solution:**
>The sample mean and standard deviation for the given data are
>$$\overline{x} = 10.0 \quad \text{and} \quad s = 0.283$$
>
>Using Table A.4, we find $t_{0.025} = 2.447$ for $v = 6$ degrees of freedom. Hence, the $95\%$ confidence interval for $\mu$ is
>$$10.0 - (2.447)\left(\frac{0.283}{\sqrt{7}}\right) < \mu < 10.0 + (2.447)\left(\frac{0.283}{\sqrt{7}}\right)$$
>which reduces to $9.74 < \mu < 10.26$.

## Concept of a Large-Sample Confidence Interval

Often statisticians recommend that even when normality cannot be assumed, $\sigma$ is unknown, and $n \geq 30$, $s$ can replace $\sigma$ and the confidence interval

$$\overline{x} \pm z_{\alpha/2}\frac{s}{\sqrt{n}}$$

may be used. This is often referred to as a **large-sample confidence interval**. The justification lies only in the presumption that with a sample as large as 30 and the population distribution not too skewed, $s$ will be very close to the true $\sigma$ and thus the Central Limit Theorem prevails. It should be emphasized that this is only an approximation and the quality of the result becomes better as the sample size grows larger.

>[!example] Example 9.6: SAT Mathematics Scores
>Scholastic Aptitude Test (SAT) mathematics scores of a random sample of 500 high school seniors in the state of Texas are collected, and the sample mean and standard deviation are found to be 501 and 112, respectively. Find a $99\%$ confidence interval on the mean SAT mathematics score for seniors in the state of Texas.
>
>**Solution:**
>Since the sample size is large, it is reasonable to use the normal approximation. Using Table A.3, we find $z_{0.005} = 2.575$. Hence, a $99\%$ confidence interval for $\mu$ is
>$$501 \pm (2.575)\left(\frac{112}{\sqrt{500}}\right) = 501 \pm 12.9$$
>which yields $488.1 < \mu < 513.9$.

# Standard Error of a Point Estimate

We have made a rather sharp distinction between the goal of a point estimate and that of a confidence interval estimate. The former supplies a single number extracted from a set of experimental data, and the latter provides an interval that is reasonable for the parameter, given the experimental data; that is, $100(1 - \alpha)\%$ of such computed intervals "cover" the parameter.

These two approaches to estimation are related to each other. The common thread is the sampling distribution of the point estimator. Consider, for example, the estimator $\overline{X}$ of $\mu$ with $\sigma$ known. We indicated earlier that a measure of the quality of an unbiased estimator is its variance. The variance of $\overline{X}$ is

$$\sigma^2_{\overline{X}} = \frac{\sigma^2}{n}$$

Thus, the standard deviation of $\overline{X}$, or **standard error** of $\overline{X}$, is $\sigma/\sqrt{n}$. Simply put, the standard error of an estimator is its standard deviation.

For $\overline{X}$, the computed confidence limit

$$\overline{x} \pm z_{\alpha/2}\frac{\sigma}{\sqrt{n}}$$

is written as $\overline{x} \pm z_{\alpha/2} \cdot \text{s.e.}(\overline{x})$, where "s.e." is the "standard error."

The important point is that the width of the confidence interval on $\mu$ is dependent on the quality of the point estimator through its standard error. In the case where $\sigma$ is unknown and sampling is from a normal distribution, $s$ replaces $\sigma$ and the estimated standard error $s/\sqrt{n}$ is involved. Thus, the confidence limits on $\mu$ are:

>[!def] Confidence Limits on $\mu$, $\sigma^2$ Unknown:
>$$\overline{x} \pm t_{\alpha/2}\frac{s}{\sqrt{n}} = \overline{x} \pm t_{\alpha/2} \cdot \text{s.e.}(\overline{x})$$

Again, the confidence interval is no better (in terms of width) than the quality of the point estimate, in this case through its estimated standard error. Computer packages often refer to estimated standard errors simply as "standard errors."

As we move to more complex confidence intervals, there is a prevailing notion that widths of confidence intervals become shorter as the quality of the corresponding point estimate becomes better, although it is not always quite as simple as we have illustrated here. It can be argued that a confidence interval is merely an augmentation of the point estimate to take into account the precision of the point estimate.

# Prediction Intervals

The point and interval estimations of the mean in previous sections provide good information about the unknown parameter $\mu$ of a normal distribution or a nonnormal distribution from which a large sample is drawn. Sometimes, other than the population mean, the experimenter may also be interested in predicting the possible value of a future observation.

For instance, in quality control, the experimenter may need to use the observed data to predict a new observation. A process that produces a metal part may be evaluated on the basis of whether the part meets specifications on tensile strength. On certain occasions, a customer may be interested in purchasing a single part. In this case, a confidence interval on the mean tensile strength does not capture the required information. The customer requires a statement regarding the uncertainty of a single observation. This type of requirement is nicely fulfilled by the construction of a **prediction interval**.

## Prediction Interval with Known Variance

It is quite simple to obtain a prediction interval for the situations we have considered so far. Assume that the random sample comes from a normal population with unknown mean $\mu$ and known variance $\sigma^2$. A natural point estimator of a new observation is $\overline{X}$. It is known that the variance of $\overline{X}$ is $\sigma^2/n$. However, to predict a new observation, not only do we need to account for the variation due to estimating the mean, but also we should account for the variation of a future observation. From the assumption, we know that the variance of the random error in a new observation is $\sigma^2$.

The development of a prediction interval is best illustrated by beginning with a normal random variable $x_0 - \overline{x}$, where $x_0$ is the new observation and $\overline{x}$ comes from the sample. Since $x_0$ and $\overline{x}$ are independent, we know that

$$z = \frac{x_0 - \overline{x}}{\sqrt{\sigma^2 + \sigma^2/n}} = \frac{x_0 - \overline{x}}{\sigma\sqrt{1 + 1/n}}$$

is $n(z; 0, 1)$. As a result, if we use the probability statement

$$P(-z_{\alpha/2} < Z < z_{\alpha/2}) = 1 - \alpha$$

with the $z$-statistic above and place $x_0$ in the center of the probability statement, we have the following event occurring with probability $1 - \alpha$:

$$\overline{x} - z_{\alpha/2}\sigma\sqrt{1 + 1/n} < x_0 < \overline{x} + z_{\alpha/2}\sigma\sqrt{1 + 1/n}$$

As a result, computation of the prediction interval is formalized as follows.

>[!def] Prediction Interval of a Future Observation, $\sigma^2$ Known:
>For a normal distribution of measurements with unknown mean $\mu$ and known variance $\sigma^2$, a $100(1 - \alpha)\%$ prediction interval of a future observation $x_0$ is
>$$\overline{x} - z_{\alpha/2}\sigma\sqrt{1 + 1/n} < x_0 < \overline{x} + z_{\alpha/2}\sigma\sqrt{1 + 1/n}$$
>where $z_{\alpha/2}$ is the $z$-value leaving an area of $\alpha/2$ to the right.

>[!example] Example 9.7: Mortgage Loan Application
>Due to the decrease in interest rates, the First Citizens Bank received a lot of mortgage applications. A recent sample of 50 mortgage loans resulted in an average loan amount of $257,300. Assume a population standard deviation of $25,000. For the next customer who fills out a mortgage application, find a $95\%$ prediction interval for the loan amount.
>
>**Solution:**
>The point prediction of the next customer's loan amount is $\overline{x} = \$257,300$. The $z$-value here is $z_{0.025} = 1.96$. Hence, a $95\%$ prediction interval for the future loan amount is
>$$257,300 - (1.96)(25,000)\sqrt{1 + 1/50} < x_0 < 257,300 + (1.96)(25,000)\sqrt{1 + 1/50}$$
>which gives the interval $(\$207,812.43, \$306,787.57)$.

The prediction interval provides a good estimate of the location of a future observation, which is quite different from the estimate of the sample mean value. It should be noted that the variation of this prediction is the sum of the variation due to an estimation of the mean and the variation of a single observation.

## Prediction Interval with Unknown Variance

However, as in the past, we first consider the case with known variance. It is also important to deal with the prediction interval of a future observation in the situation where the variance is unknown. Indeed a Student $t$-distribution may be used in this case, as described in the following result. The normal distribution is merely replaced by the $t$-distribution.

>[!def] Prediction Interval of a Future Observation, $\sigma^2$ Unknown:
>For a normal distribution of measurements with unknown mean $\mu$ and unknown variance $\sigma^2$, a $100(1 - \alpha)\%$ prediction interval of a future observation $x_0$ is
>$$\overline{x} - t_{\alpha/2}s\sqrt{1 + 1/n} < x_0 < \overline{x} + t_{\alpha/2}s\sqrt{1 + 1/n}$$
>where $t_{\alpha/2}$ is the $t$-value with $v = n - 1$ degrees of freedom, leaving an area of $\alpha/2$ to the right.

One-sided prediction intervals can also be constructed. Upper prediction bounds apply in cases where focus must be placed on future large observations. Concern over future small observations calls for the use of lower prediction bounds. The upper bound is given by

$$\overline{x} + t_\alpha s\sqrt{1 + 1/n}$$

and the lower bound by

$$\overline{x} - t_\alpha s\sqrt{1 + 1/n}$$

>[!example] Example 9.8: Meat Inspection
>A meat inspector has randomly selected 30 packs of $95\%$ lean beef. The sample resulted in a mean of 96.2% with a sample standard deviation of 0.8%. Find a $99\%$ prediction interval for the leanness of a new pack. Assume normality.
>
>**Solution:**
>For $v = 29$ degrees of freedom, $t_{0.005} = 2.756$. Hence, a $99\%$ prediction interval for a new observation $x_0$ is
>$$96.2 - (2.756)(0.8)\sqrt{1 + \frac{1}{30}} < x_0 < 96.2 + (2.756)(0.8)\sqrt{1 + \frac{1}{30}}$$
>which reduces to $(93.96, 98.44)$.

## Use of Prediction Limits for Outlier Detection

To this point in the text very little attention has been paid to the concept of outliers, or aberrant observations. The majority of scientific investigators are keenly sensitive to the existence of outlying observations or so-called faulty or "bad data." We deal with the concept of outlier detection extensively in Chapter 12. However, it is certainly of interest here since there is an important relationship between outlier detection and prediction intervals.

It is convenient for our purposes to view an outlying observation as one that comes from a population with a mean that is different from the mean that governs the rest of the sample of size $n$ being studied. The prediction interval produces a bound that "covers" a future single observation with probability $1 - \alpha$ if it comes from the population from which the sample was drawn.

As a result, a methodology for outlier detection involves the rule that an observation is an outlier if it falls outside the prediction interval computed without including the questionable observation in the sample. As a result, for the prediction interval of Example 9.8, if a new pack of beef is measured and its leanness is outside the interval $(93.96, 98.44)$, that observation can be viewed as an outlier.
