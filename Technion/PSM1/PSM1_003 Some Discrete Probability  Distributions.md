---
aliases:
  - binomial distribution
  - hypergeometric distribution
  - geometric distribution
  - negative binomial
  - poisson distribution
  - bernoulli process
  - discrete distributions
---
From [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]]:
# Binomial and Multinomial Distributions

Many statistical experiments follow similar patterns, allowing us to describe their behavior with standardized probability distributions. One of the most common and useful distributions is the binomial distribution.

For example, when testing the effectiveness of a new drug, the number of cured patients among all treated patients approximately follows a binomial distribution.

## The Bernoulli Process

A **Bernoulli process** consists of repeated trials where each trial has exactly two possible outcomes, commonly labeled "success" and "failure". Examples include testing electronic components (defective vs. non-defective) or flipping coins (heads vs. tails).

Formally, a Bernoulli process must satisfy these properties:
1. The experiment consists of repeated trials
2. Each trial results in exactly two possible outcomes: "success" or "failure" 
3. The probability of success, denoted by $p$, remains constant from trial to trial
4. All trials are independent of each other

Consider selecting $3$ items from a manufacturing process and classifying them as defective (D) or non-defective (N). If we define "defective" as a success, the number of defectives is a random variable $X$ taking values from $0$ to $3$. The $8$ possible outcomes and corresponding values of $X$ are:

$$\begin{array}{c|cccccccc}
\text{Outcome} & NNN & NDN & NND & DNN & NDD & DND & DDN & DDD \\
\hline x & 0 & 1 & 1 & 1 & 2 & 2 & 2 & 3
\end{array}$$

If the process produces $25\%$ defective items and the selections are independent, then:
$$P(NDN) = P(N)P(D)P(N) = \left(\frac{3}{4}\right)\left(\frac{1}{4}\right)\left(\frac{3}{4}\right) = \frac{9}{64}$$

Similar calculations for all outcomes yield the probability distribution:
$$\begin{array}{c|cccc}
x & 0 & 1 & 2 & 3 \\
\hline f(x) & \frac{27}{64} & \frac{27}{64} & \frac{9}{64} & \frac{1}{64}
\end{array}$$

## Binomial Distribution

The number $X$ of successes in $n$ Bernoulli trials is called a **binomial random variable**, and its probability distribution is the **binomial distribution**, denoted by $b(x;n,p)$.

>[!theorem] Theorem:
>In a Bernoulli process with success probability $p$ and failure probability $q=1-p$, the probability distribution of the binomial random variable $X$ (the number of successes in $n$ independent trials) is:
>$$b(x;n,p) = \binom{n}{x}p^x q^{n-x}, \quad x=0,1,2,\ldots,n$$

The formula can be derived as follows:
1. The probability of $x$ successes and $(n-x)$ failures in a specific order is $p^x q^{n-x}$
2. The number of different ways to arrange $x$ successes among $n$ trials is $\binom{n}{x}$
3. Multiplying these gives the total probability of exactly $x$ successes

>[!example] Example: Binomial Calculation
>The probability that a certain component will survive a shock test is $3/4$. Find the probability that exactly $2$ of the next $4$ components tested survive.
>
>**Solution**:
>With $n=4$ trials, success probability $p=3/4$ (survival), and $x=2$ successes, we have:
>$$b\left(2;4,\frac{3}{4}\right) = \binom{4}{2}\left(\frac{3}{4}\right)^2\left(\frac{1}{4}\right)^2 = 6 \cdot \frac{9}{16} \cdot \frac{1}{16} = \frac{54}{256} = \frac{27}{128}$$

## Mean and Variance of Binomial Distribution

The binomial distribution's parameters directly determine its [[PSM1_002 Random Variables#Mean of a Random Variable|mean]] and [[PSM1_002 Random Variables#Variance of Random Variables|variance]].

>[!theorem] Theorem: 
>The mean and variance of the binomial distribution $b(x;n,p)$ are:
>$$\mu = np \quad \text{and} \quad \sigma^2 = npq$$
>where $q = 1-p$

This makes intuitive sense:
- The mean $np$ is the expected number of successes in $n$ trials, each with success probability $p$
- The variance $npq$ reflects how the outcomes are distributed around this mean

>[!example] Example: Impurity Testing
>It is conjectured that impurities exist in $30\%$ of drinking wells in a rural community. To investigate, $10$ wells are randomly selected for testing.
>
>1. What is the probability that exactly $3$ wells have impurities?
>2. What is the probability that more than $3$ wells are impure?
>
>**Solution**:
>With $n=10$, $p=0.3$, and $q=0.7$:
>
>3. For exactly $3$ impure wells:
>   $$b(3;10,0.3) = \binom{10}{3}(0.3)^3(0.7)^7 = 120 \cdot 0.027 \cdot 0.0824 = 0.2668$$
>
>4. For more than $3$ impure wells:
>   $$P(X>3) = 1 - P(X \leq 3) = 1 - \sum_{x=0}^{3}b(x;10,0.3) = 1 - 0.6496 = 0.3504$$

# Hypergeometric Distribution

The binomial distribution assumes that each trial is independent with a constant probability of success. However, in sampling without replacement, this assumption doesn't hold, as the probability of success changes after each selection. For these scenarios, we use the **hypergeometric distribution**.

>[!theorem] Theorem: Hypergeometric Distribution 
>The probability distribution of the hypergeometric random variable $X$, representing the number of successes in a random sample of size $n$ selected from $N$ items (of which $k$ are labeled "success" and $N-k$ are labeled "failure"), is:
>$$h(x;N,n,k)=\frac{\binom{k}{x}\binom{N-k}{n-x}}{\binom{N}{n}}, \quad \max\{0,n-(N-k)\} \leq x \leq \min\{n,k\}$$

The hypergeometric formula can be understood as:
- $\binom{k}{x}$ represents the number of ways to select $x$ successes from $k$ total successes
- $\binom{N-k}{n-x}$ represents the number of ways to select $(n-x)$ failures from $(N-k)$ total failures
- $\binom{N}{n}$ represents the total number of ways to select $n$ items from $N$ total items

>[!example] Example: Laptop Computers
>A shipment of $20$ laptop computers to a retail outlet contains $3$ that are defective. If a school randomly purchases $2$ of these computers, find the probability distribution for the number of defectives.
>
>**Solution**:
>Let $X$ be the random variable representing the number of defective computers purchased. With $N=20$ total computers, $k=3$ defective computers, and a sample size of $n=2$, $X$ can take values $0$, $1$, or $2$.
>
>For $x=0$ (no defective computers):
>$$f(0) = P(X=0) = \frac{\binom{3}{0}\binom{17}{2}}{\binom{20}{2}} = \frac{1 \cdot 136}{190} = \frac{136}{190} = \frac{68}{95}$$
>
>For $x=1$ (one defective computer):
>$$f(1) = P(X=1) = \frac{\binom{3}{1}\binom{17}{1}}{\binom{20}{2}} = \frac{3 \cdot 17}{190} = \frac{51}{190}$$
>
>For $x=2$ (two defective computers):
>$$f(2) = P(X=2) = \frac{\binom{3}{2}\binom{17}{0}}{\binom{20}{2}} = \frac{3 \cdot 1}{190} = \frac{3}{190}$$
>
>Therefore, the probability distribution of $X$ is:
>$$\begin{array}{c|ccc}
>x & 0 & 1 & 2 \\
>\hline f(x) & \frac{68}{95} & \frac{51}{190} & \frac{3}{190}
>\end{array}$$

## Mean and Variance of Binomial Distribution

>[!theorem] Theorem: 
> The mean and variance of the hypergeometric distribution $h(x;N,n,k)$ are
> $$\mu=\dfrac{nk}{N}\qquad \text{and}\qquad \sigma ^{2}=\dfrac{N-n}{N-1}\cdot n\cdot \dfrac{k}{N}\left( 1-\dfrac{k}{N} \right)$$

# Negative Binomial and Geometric Distributions

In some experiments, we repeat independent trials (each with probability $p$ of success and $q=1-p$ of failure) until a fixed number of successes occurs. Unlike the binomial distribution, where the number of trials $n$ is fixed and we count the number of successes, here we fix the number of successes $k$ and are interested in the probability that the $k$-th success occurs on the $x$-th trial. Such experiments are called **negative binomial experiments**.

>[!example] Example: 
> Suppose a drug is effective in $60\%$ of cases. What is the probability that the fifth patient to experience relief is the seventh patient to receive the drug?
> 
>**Solution**:
> A possible sequence: $SFS S S F S$, with probability $(0.6)^5(0.4)^2$.  
> The number of ways to arrange $4$ successes and $2$ failures in the first $6$ trials is $\binom{6}{4}=15$.  
> Thus, $P(X=7) = \binom{6}{4}(0.6)^5(0.4)^2 = 0.1866$.

## Negative Binomial Distribution

>[!def] Definition: 
> If a random variable $X$ (number of trials needed to achieve $k$ successes) follows the **negative binomial distribution**. Its probability mass function is:
> $$
> b^*(x; k, p) = \binom{x-1}{k-1} p^k q^{x-k}, \quad x = k, k+1, k+2, \ldots
> $$
> where $p$ is the probability of success, $q=1-p$, $k$ is the number of successes, and $x$ is the trial on which the $k$-th success occurs.

>[!example] Example: 
> In an NBA championship, the first team to win $4$ games out of $7$ wins the series. Suppose that team $A$ has probability $0.55$ of winning a game.
> 1. What is the probability that team $A$ will win the series in $6$ games?
> 2. What is the probability that team $A$ will win the series?
> 
> **Solution**:
> 3. Plugging into the formula:
> 	$$\begin{aligned}
> b^*(6; 4, 0.55)  & = \binom{5}{3} (0.55)^4 (0.45)^2  \\[1ex]
>  & = \boxed {
> 0.1853
>  }
> \end{aligned}$$
> 4. Now we need to do the above $4$ times:
> 	$$\begin{aligned}
> 	 b^*(4; 4, 0.55)  & + b^*(5; 4, 0.55) + b^*(6; 4, 0.55) + b^*(7; 4, 0.55)  \\[1ex]
> 	 & = 0.0915 + 0.1647 + 0.1853 + 0.1668  \\[1ex]
>  & = \boxed {
> 0.6083
>  }
> 	\end{aligned}$$
> 

## Geometric Distribution

A special case of the negative binomial distribution is when $k=1$, i.e., we are interested in the number of trials until the first success. This is called the **geometric distribution**.

>[!def] Definition: 
 If a repeated independent trails can result in a success with probability $p$ and a failure with probability $q=1-p$, then the probability distribution of the random variable $X$, the number of the trail on which the first success occurs, is
> $$
> g(x; p) = p q^{x-1}, \quad x = 1, 2, 3, \ldots
> $$


>[!example] Example: 
> - If $1$ in $100$ items is defective ($p=0.01$), the probability that the $5$-th item inspected is the first defective is
> 	$$g(5; 0.01) = 0.01 \times 0.99^4 = 0.0096$$
> - If the probability of a successful phone call is $0.05$, the probability that $5$ attempts are needed is 
>	$$g(5; 0.05) = 0.05 \times 0.95^4 = 0.041$$

>[!theorem] Theorem: 
> The mean and variance of a random variable following the geometric distribution are
> $$
> \mu = \frac{1}{p}\qquad \text{and}\qquad  \sigma^2 = \frac{1-p}{p^2}
> $$

# Poisson Distribution and the Poisson Process

A **Poisson experiment** involves recording the number of times a certain event (random variable $X$) occurs within a fixed time period or within a defined region. The time interval can vary—such as a minute, hour, day, week, month, or year. For instance, $X$ could represent the number of phone calls an office receives per hour, the number of school days canceled due to snow in a winter, or the number of baseball games postponed because of rain in a season. The specified region might be a line, area, volume, or a piece of material, where $X$ could represent the number of field mice per acre, bacteria in a culture, or typing errors per page.

A Poisson experiment is based on the **Poisson process**, which has these key properties:

1. **Independence:** The number of events in one time interval or region is independent of the number in any other non-overlapping interval or region. This means the process has no memory.
2. **Proportionality:** The probability of a single event occurring in a very short time interval or small region is proportional to the length or size of that interval or region, and does not depend on events outside it.
3. **Negligible Multiple Events:** The chance of more than one event occurring in such a short interval or small region is so small it can be ignored.

The random variable $X$, representing the number of events in a Poisson experiment, is called a **Poisson random variable**, and its probability distribution is the **Poisson distribution**.

The average number of events is given by:
$$\mu=\lambda t$$
where:
- $\lambda$ is the rate at which events occur,
- $t$ is the length of the time interval, distance, area, or volume.

The probability of observing exactly $x$ events, denoted as $p(x;\lambda t)$, depends on the rate $\lambda$ and the interval or region size $t$. The formula for calculating Poisson probabilities is based on the properties above, though its derivation is not covered here.

>[!def] Definition: 
 >The probability distribution of the Poisson random variable $X$, representing the number of outcomes occurring in a given time interval or specified region denoted by $t$, is
 >$$p(x;\lambda t)=\dfrac{e^{-\lambda t}(\lambda t)^{x}}{x!},\qquad x=0,1,2,\dots $$
> Where $\lambda$ is the average number of outcomes per unit time, distance, area, or volume and $e=2.71828\dots$

The Poisson probability sums is defined as:
$$P(r;\lambda t)=\sum_{x=0}^{r} p(x;\lambda t) $$

>[!example] Example: Radioactive Particles
>During a laboratory experiment, the average number of radioactive particles passing through a counter in $1$ millisecond is $4$. What is the probability that $6$ particles enter the counter in a given millisecond?
>
>**Solution**:
>Using the Poisson distribution with $x = 6$ and $\lambda t = 4$:
>$$\begin{aligned}
p(6; 4)  & = \frac{e^{-4}4^6}{6!}  \\[1ex]
 & = \sum_{x=0}^{6} p(x; 4) - \sum_{x=0}^{5} p(x; 4)  \\[1ex]
 & = 0.8893 - 0.7851  \\[1ex]
 & = \boxed {
0.1042
 }
\end{aligned}$$

>[!example] Example: Oil Tankers
>Ten is the average number of oil tankers arriving each day at a certain port. The facilities at the port can handle at most 15 tankers per day. What is the probability that on a given day tankers have to be turned away?
>
>**Solution**:
>Let $X$ be the number of tankers arriving each day. We need to find:
>$$\begin{aligned}
P(X > 15)  & = 1 - P(X \leq 15)  \\[1ex]
 & = 1 - \sum_{x=0}^{15} p(x; 10)  \\[1ex]
 & = 1 - 0.9513  \\[1ex]
 & = \boxed {
0.0487
 }
\end{aligned}$$

>[!theorem] Theorem:
>Both the mean and the variance of the Poisson distribution $p(x;\lambda t)$ are $\lambda t$.

## Nature of the Poisson Probability Function

Like many discrete and continuous distributions, the form of the Poisson distribution becomes increasingly symmetric and bell-shaped as the mean grows larger. The probability function for different values of $\mu$ shows this progression:

- When $\mu = 0.1$, the distribution is highly skewed
- When $\mu = 2$, it begins to become more balanced
- When $\mu = 5$, it appears nearly symmetric

This behavior parallels what we see in the binomial distribution as well.

![[{144FCDE2-5433-42CA-A94A-AC13D587C64A}.png|bookhue|600]]
>Poisson density functions for different means. [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]].
## Approximation of Binomial Distribution by a Poisson Distribution

The Poisson distribution can be viewed as a limiting form of the binomial distribution. When the sample size $n$ is large and the probability $p$ is small, the binomial distribution can be approximated by the Poisson distribution with parameter $\mu = np$.

The independence among Bernoulli trials in the binomial case aligns with the independence property of the Poisson process. When $p$ is close to $0$, this relates to the negligible multiple events property of the Poisson process.

If $p$ is close to $1$, we can still use the Poisson approximation by redefining what we consider a "success," effectively changing $p$ to a value close to $0$.

>[!theorem] Theorem:
>Let $X$ be a binomial random variable with probability distribution $b(x; n, p)$. When $n \rightarrow \infty$, $p \rightarrow 0$, and $np \rightarrow \mu$ remains constant,
>$$b(x; n, p) \rightarrow p(x; \mu)$$

>[!example] Example: Industrial Accidents
>In a certain industrial facility, accidents occur infrequently. The probability of an accident on any given day is $0.005$, and accidents are independent of each other.
>
>1. What is the probability that in any given period of $400$ days there will be an accident on exactly one day?
>2. What is the probability that there are at most three days with an accident?
>
>**Solution**:
>Let $X$ be a binomial random variable with $n = 400$ and $p = 0.005$. Thus, $np = 2$. Using the Poisson approximation with $\mu = 2$:
>
>3. $P(X = 1) = \frac{e^{-2}2^1}{1!} = \boxed {
0.271
 }$
>
>4. $P(X \leq 3) = \sum_{x=0}^{3} \frac{e^{-2}2^x}{x!} = \boxed {0.857}$

>[!example] Example: Glass Manufacturing
>In a manufacturing process where glass products are made, defects or bubbles occur occasionally, rendering the piece unmarketable. On average, $1$ in every $1000$ items produced has one or more bubbles. What is the probability that a random sample of $8000$ will yield fewer than $7$ items possessing bubbles?
>
>**Solution**:
>This is essentially a binomial experiment with $n = 8000$ and $p = 0.001$. Since $p$ is very close to $0$ and $n$ is quite large, we can approximate with the Poisson distribution using:
>$$\mu = (8000)(0.001) = 8$$
>
>Hence, if $X$ represents the number of bubbles:
>$$\begin{aligned}
P(X < 7)  & = \sum_{x=0}^{6} b(x; 8000, 0.001) \\[1ex]
 &  \approx \sum_{x=0}^{6} p(x; 8) \\[1ex]
 &  = \boxed {
0.3134
 }
\end{aligned}$$

# Exercises
## Question 1
A ship is shooting rockets at an enemy ship. The probability of success is $P(S)=0.7$.

### Part a
What is the probability that the first successful hit is on the fifth shot?

**Solution**:
This is a classic case of a [[#Geometric Distribution|geometric distribution]], where $k=5$:
$$\begin{aligned}
g(5;0.7) & =0.7\cdot 0.3^{5-1} \\[1ex]
 & =\boxed {
\pu {5.67e-3 }
 }
\end{aligned}$$

### Part b
How many rockets should we shoot so that the probability of a successful hit is at least $0.95$?

**Solution**:
We can use both a geometric distribution and a binomial distribution to solve this problem.

Assuming the number of rockets shot is $n$, according to the [[#Geometric Distribution|geometric distribution]], the probability of getting one successful hit after $n$ shots is $P(X=n)=g(n;0.7)=0.7\cdot 0.3^{n-1}$.
Therefore, the probability of getting *at least* one successful hit after $n$ shots is:
$$\begin{aligned}
P(X\leq  n) & =\sum_{t\leq  n}^{}g(t;0.7)  \\[1ex]
 & =\dots =1-(1-0.7)^{n} \\[1ex]
 & =1-0.3^{n}
\end{aligned}$$
This is a specific case of the more general [[PSM1_002 Random Variables#Discrete Probability Distributions#Cumulative Distribution Function|CDF]] for geometric distributions:
$$G(n;p)=1-(1-p)^{n}$$
This formula works because $(1-p)^{n}$ is the probability of *failing every single trial* in the first $n$ trials. So, $1-(1-p)^{n}$ is the probability that we *succeed at least once* in the first $n$ trails.

We want to know when $P(X\leq n)\geq0.95$. Therefore:
$$\begin{gathered}
1-0.3^{n}\geq  0.95 \\[1ex]
0.3^{n}\leq  0.05 \\[1ex]
n\gtrsim 2.49
\end{gathered}$$

Therefore, the ship must take a minimum of $\boxed {n=3}$ shots.

We can also solve the problem using a [[#Binomial Distribution|binomial distribution]]. Here, we model the total number of successes in $n$ independent trials. We want:
$$\begin{gathered}
P(\text{at least one success})\geq  0.95 \\[1ex]
1-P(\text{0 successes})\geq  0.95 \\[1ex]
P(\text{0 successes})\leq  0.05 \\[1ex]
b(0;n,0.7)\leq  0.05 \\[1ex]
\binom{n}{0}0.7^{0}\cdot 0.3^{n-0}\leq  0.05 \\[1ex]
0.3^{n}\leq  0.05
\end{gathered}$$
We go the exact same inequality from before.
### Part c
Given the first $5$ shots were unsuccessful, what is the probability that the first hit will be on the $7$-th shot?

**Solution**:
Denoting $X$ as the number of shots it takes for getting a successful hit, we are trying to find $P(X=7|X>  5)$. Because geometric distributions are *memoryless*:
$$P(X=7|X>5)=P(X=2|X>0)$$
Which is like saying $P(X=2)$.
Therefore, all we need to calculate is:
$$\begin{aligned}
P(X=2) & =g(2;0.7) \\[1ex]
 & =0.7\cdot 0.3^{2-1} \\[1ex]
 & =\boxed {
0.21
 }
\end{aligned}$$

## Question 2
In a coffee shop there are $6$ cakes from yesterday and $10$ cakes from today. By $\text{10 a.m}$ the customers bought $5$ cakes.

What is the probability that at most $2$ old cakes are left at $\text{10 a.m}$?

**Solution**:
Denoting:
- $X$: number of old cakes bought.
- $N=16$: number of total cakes
- $n=5$: number of cakes taken
- $k=6$: number of old cakes before customers came

Using a [[#Hypergeometric Distribution|hypergeometric distribution]], we want to find:
$$\begin{aligned}
P(X\geq    4) & =P(X=4)+P(X=5) \\[1ex]
 & =h(4;16,5,6)+h(5;16,5,6) \\[1ex]
 & =\boxed {
0.0357
 }
\end{aligned}$$
