---
aliases:
  - random variable
  - binomial distribution
  - probability distribution
  - Bernoulli process
---
From [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]]:
# Concept of a Random Variable

A **statistical experiment** is any process that generates several chance observations. In many cases, we need to assign numerical values to the outcomes of such experiments. For example, when testing three electronic components, the sample space can be represented as:
$$\Omega=\{ N N N,\, N N D,\, NDN,\, DN N,\, NDD,\, D N D,\, DDN,\, DDD \}$$
where $N$ denotes non-defective and $D$ denotes defective.

We can assign a *numerical value* to each outcome representing the number of defectives: $0,1,2$ or $3$. These values are random quantities determined by the experiment and are called values of the **random variable** $X$.

>[!def] Definition: 
>A **random variable** is a function that associates a real number with each element in the sample space.
 
We use capital letters (e.g., $X$) to denote random variables and lowercase letters (e.g., $x$) for their specific values.

## Discrete and Continuous Sample Space

>[!def] Definition: 
>If a sample space contains a finite number of possibilities or a countable sequence (equivalent to the set of whole numbers), it is called a **discrete sample space**.
 
Some experimental outcomes cannot be counted. For instance, when measuring the distance a car travels on 5 liters of gasoline, we have an infinite number of possible distances that form a continuous range of values.

>[!def] Definition: 
>If a sample space contains an infinite number of possibilities equivalent to the points on a line segment, it is called a **continuous sample space**.
 
A **discrete random variable** has a countable set of possible outcomes, while a **continuous random variable** can take values on a continuous scale (an interval of numbers).
# Discrete Probability Distributions

A discrete random variable takes specific values with certain probabilities. For example, when tossing a coin three times, the variable $X$ representing the number of heads can equal $2$ with probability $3/8$, since $3$ of the $8$ possible outcomes result in two heads.

We can represent the probabilities of a random variable $X$ with a formula denoted by $f(x)$, where $f(x) = P(X = x)$.

## Probability Distribution

>[!def] Definition: 
>The set of ordered pairs $(x,f(x))$ is called the **probability function**, **probability mass function**, or **probability distribution** of the discrete random variable $X$ if, for each possible outcome $x$:
>1. $f(x) \geq 0$
>2. $\sum_x f(x) = 1$
>3. $P(X = x) = f(x)$

>[!example] Example: Probability Distribution
>If a car agency sells 50% of its inventory of a certain foreign car equipped with side airbags, find the probability distribution of the number of cars with side airbags among the next 4 cars sold.
>
>**Solution**:
>Since the probability of selling a car with side airbags is 0.5, the $2^4 = 16$ possible outcomes are equally likely. Let $X$ be the number of cars with side airbags sold. The event of selling $x$ cars with side airbags and $(4-x)$ without can occur in $\binom{4}{x}$ ways.
>
>The probability distribution is:
>$$f(x)=\frac{1}{16}\binom{4}{x}, \quad x=0,1,2,3,4$$
>
>Computing the values:
>$$\begin{aligned}
>& f(0) = \frac{1}{16}\binom{4}{0} = \frac{1}{16} \\[1ex]
>& f(1) = \frac{1}{16}\binom{4}{1} = \frac{4}{16} = \frac{1}{4} \\[1ex]
>& f(2) = \frac{1}{16}\binom{4}{2} = \frac{6}{16} = \frac{3}{8} \\[1ex]
>& f(3) = \frac{1}{16}\binom{4}{3} = \frac{4}{16} = \frac{1}{4} \\[1ex]
>& f(4) = \frac{1}{16}\binom{4}{4} = \frac{1}{16}
>\end{aligned}$$

## Cumulative Distribution Function

For many problems, we need to determine the probability that a random variable $X$ is less than or equal to some value $x$. This is defined as the **cumulative distribution function** (CDF).

>[!def] Definition: 
>The **cumulative distribution function** $F(x)$ of a discrete random variable $X$ with probability distribution $f(x)$ is:
>$$F(x)=P(X\leq x)=\sum_{t\leq x}f(t), \quad -\infty < x < \infty$$

>[!example] Example: Cumulative Distribution Function
>Find the cumulative distribution function of the random variable $X$ in the previous example. Using $F(x)$, verify that $f(2)=3/8$.
>
>**Solution**:
>From the previous calculations, we have:
>$$\begin{aligned}
>& f(0)=\frac{1}{16}, & f(1)=\frac{1}{4}, & f(2)=\frac{3}{8} \\[1ex]
>& f(3)=\frac{1}{4}, & f(4)=\frac{1}{16}
>\end{aligned}$$
>
>Therefore:
>$$\begin{aligned}
>& F(0)=f(0)=\frac{1}{16} \\[1ex]
>& F(1)=f(0)+f(1)=\frac{1}{16}+\frac{1}{4}=\frac{5}{16} \\[1ex]
>& F(2)=f(0)+f(1)+f(2)=\frac{1}{16}+\frac{1}{4}+\frac{3}{8}=\frac{11}{16} \\[1ex]
>& F(3)=f(0)+f(1)+f(2)+f(3)=\frac{11}{16}+\frac{1}{4}=\frac{15}{16} \\[1ex]
>& F(4)=f(0)+f(1)+f(2)+f(3)+f(4)=\frac{15}{16}+\frac{1}{16}=1
>\end{aligned}$$
>
>We can verify that:
>$$f(2)=F(2)-F(1)=\frac{11}{16}-\frac{5}{16}=\frac{3}{8}$$

Visualizing probability distributions is often helpful. Here are graphical representations:

![[{8ADEA98C-E53D-4C08-867D-994C94036816}.png|bookhue|400]]
>Probability mass function plot. [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]].

![[{6850365A-3E1E-4EF6-907F-474984755A48}.png|bookhue|400]]
>Probability histogram. [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]].

![[{006D722C-4C6B-49E5-B9BB-62C6653A4336}.png|bookhue|400]]
>Discrete cumulative distribution function. [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]].

# Mean of a Random Variable

The mean of a random variable represents the "center" or expected value of its probability distribution. Consider this example: If two coins are tossed 16 times and we record $X$, the number of heads per toss, then $X$ can be 0, 1, or 2. If we observe 0 heads 4 times, 1 head 7 times, and 2 heads 5 times, the average number of heads is:

$$\frac{0 \cdot 4 + 1 \cdot 7 + 2 \cdot 5}{16} = 1.06$$

This average value (1.06) isn't actually one of the possible outcomes $\{0, 1, 2\}$. This illustrates that the mean of a random variable doesn't necessarily correspond to a possible outcome.

This average value is called the **mean of the random variable $X$**, the **mean of the probability distribution of $X$**, the **mathematical expectation**, or the **expected value** of $X$. It is denoted by $\mu_X$, $\mu$, or $E(X)$.

>[!def] Definition: 
>Let $X$ be a random variable with probability distribution $f(x)$. The **mean**, or **expected value**, of $X$ is:
>
>For a discrete random variable:
>$$\mu = E(X) = \sum_{x} x f(x)$$
>
>For a continuous random variable:
>$$\mu = E(X) = \int_{-\infty}^{\infty} x f(x) \, \mathrm{d}x$$

# Variance and Covariance of Random Variables

## Variance of Random Variables

While the mean describes the center of a probability distribution, it doesn't tell us about how spread out the values are. The **variance** measures this dispersion or variability.

Two distributions can have the same mean but very different spreads around that mean:

![[{01A46799-058E-4D12-A51F-B9351A14150D}.png|bookhue|600]]
>Distributions with equal means and unequal dispersions. [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]].

>[!def] Definition: 
>Let $X$ be a random variable with probability distribution $f(x)$ and mean $\mu$. The **variance** of $X$ is:
>
>For a discrete random variable:
>$$\sigma^2 = E[(X-\mu)^2] = \sum_x (x-\mu)^2 f(x)$$
>
>For a continuous random variable:
>$$\sigma^2 = E[(X-\mu)^2] = \int_{-\infty}^{\infty} (x-\mu)^2 f(x)\,\mathrm{d}x$$
>
>The positive square root of the variance, $\sigma$, is called the **standard deviation** of $X$.

The term $x-\mu$ represents the deviation of a value from the mean. The variance averages the squared deviations, making it smaller when values cluster around the mean and larger when values are more spread out.

>[!example] Example: Comparing Variances
>Let the random variable $X$ represent the number of automobiles used for official business purposes on any given workday. The probability distributions for two companies are:
>
>Company A:
>$$\begin{array}{c|ccc}
>x & 1 & 2 & 3 \\
>\hline f(x) & 0.3 & 0.4 & 0.3
>\end{array}$$
>
>Company B:
>$$\begin{array}{c|ccccc}
>x & 0 & 1 & 2 & 3 & 4 \\
>\hline f(x) & 0.2 & 0.1 & 0.3 & 0.3 & 0.1
>\end{array}$$
>
>Compare the variances of both distributions.
>
>**Solution**:
>For company A:
>$$\mu_A = E(X) = 1 \cdot 0.3 + 2 \cdot 0.4 + 3 \cdot 0.3 = 2.0$$
>
>Then:
>$$\begin{aligned}
>\sigma_A^2 &= \sum_{x=1}^{3}(x-2)^2 f(x) \\
>&= (1-2)^2 \cdot 0.3 + (2-2)^2 \cdot 0.4 + (3-2)^2 \cdot 0.3 \\
>&= 0.3 + 0 + 0.3 = 0.6
>\end{aligned}$$
>
>For company B:
>$$\mu_B = E(X) = 0 \cdot 0.2 + 1 \cdot 0.1 + 2 \cdot 0.3 + 3 \cdot 0.3 + 4 \cdot 0.1 = 2.0$$
>
>Then:
>$$\begin{aligned}
>\sigma_B^2 &= \sum_{x=0}^{4}(x-2)^2 f(x) \\
>&= (0-2)^2 \cdot 0.2 + (1-2)^2 \cdot 0.1 + (2-2)^2 \cdot 0.3 \\
>&\quad + (3-2)^2 \cdot 0.3 + (4-2)^2 \cdot 0.1 \\
>&= 0.8 + 0.1 + 0 + 0.3 + 0.4 = 1.6
>\end{aligned}$$
>
>Although both distributions have the same mean (2.0), company B has a significantly larger variance (1.6 > 0.6), indicating greater variability in the number of automobiles used daily.

An alternative formula for calculating variance that often simplifies computations is:

>[!theorem] Theorem: 
>The variance of a random variable $X$ is:
>$$\sigma^2 = E(X^2) - \mu^2$$

>[!example] Example: Using the Alternative Formula
>Let $X$ represent the number of defective parts when 3 parts are sampled from a production line. The probability distribution is:
>
>$$\begin{array}{c|cccc}
>x & 0 & 1 & 2 & 3 \\
>\hline f(x) & 0.51 & 0.38 & 0.1 & 0.01
>\end{array}$$
>
>Calculate the variance using the alternative formula.
>
>**Solution**:
>First, we compute the mean:
>$$\mu = 0 \cdot 0.51 + 1 \cdot 0.38 + 2 \cdot 0.1 + 3 \cdot 0.01 = 0.61$$
>
>Next, we find $E(X^2)$:
>$$E(X^2) = 0^2 \cdot 0.51 + 1^2 \cdot 0.38 + 2^2 \cdot 0.1 + 3^2 \cdot 0.01 = 0.87$$
>
>Therefore:
>$$\sigma^2 = 0.87 - 0.61^2 = 0.87 - 0.3721 = 0.4979$$

## Covariance of Random Variables

The **covariance** measures the relationship between two random variables, indicating how they vary together.

>[!def] Definition: 
>Let $X$ and $Y$ be random variables with joint probability distribution $f(x,y)$ and means $\mu_X$ and $\mu_Y$. The covariance of $X$ and $Y$ is:
>
>For discrete random variables:
>$$\sigma_{XY} = E[(X-\mu_X)(Y-\mu_Y)] = \sum_{x}\sum_{y}(x-\mu_X)(y-\mu_Y)f(x,y)$$
>
>For continuous random variables:
>$$\sigma_{XY} = E[(X-\mu_X)(Y-\mu_Y)] = \int_{-\infty}^{\infty}\int_{-\infty}^{\infty}(x-\mu_X)(y-\mu_Y)f(x,y)\,\mathrm{d}x\,\mathrm{d}y$$

A positive covariance indicates that the variables tend to move in the same direction, while a negative covariance suggests they move in opposite directions. Zero covariance indicates no linear relationship between the variables.

## Linear Combinations of Random Variables

The following properties simplify calculations for means and variances of linear combinations of random variables.

>[!theorem] Theorem: 
>If $a$ and $b$ are constants, then:
>$$E(aX+b) = aE(X)+b$$
>
>Special cases:
>$$E(b) = b$$
>$$E(aX) = aE(X)$$

>[!theorem] Theorem: 
>For independent random variables $X$ and $Y$ and constants $a$ and $b$:
>1. $E(X+Y) = E(X) + E(Y)$
>2. $\text{Var}(aX+b) = a^2\text{Var}(X)$
>3. $\text{Var}(X+Y) = \text{Var}(X) + \text{Var}(Y)$

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

Consider selecting three items from a manufacturing process and classifying them as defective (D) or non-defective (N). If we define "defective" as a success, the number of defectives is a random variable $X$ taking values from 0 to 3. The eight possible outcomes and corresponding values of $X$ are:

$$\begin{array}{c|cccccccc}
\text{Outcome} & NNN & NDN & NND & DNN & NDD & DND & DDN & DDD \\
\hline x & 0 & 1 & 1 & 1 & 2 & 2 & 2 & 3
\end{array}$$

If the process produces 25% defective items and the selections are independent, then:
$$P(NDN) = P(N)P(D)P(N) = \left(\frac{3}{4}\right)\left(\frac{1}{4}\right)\left(\frac{3}{4}\right) = \frac{9}{64}$$

Similar calculations for all outcomes yield the probability distribution:
$$\begin{array}{c|cccc}
x & 0 & 1 & 2 & 3 \\
\hline f(x) & \frac{27}{64} & \frac{27}{64} & \frac{9}{64} & \frac{1}{64}
\end{array}$$

## Binomial Distribution

The number $X$ of successes in $n$ Bernoulli trials is called a **binomial random variable**, and its probability distribution is the **binomial distribution**, denoted by $b(x;n,p)$.

>[!theorem] Theorem: Binomial Distribution
>In a Bernoulli process with success probability $p$ and failure probability $q=1-p$, the probability distribution of the binomial random variable $X$ (the number of successes in $n$ independent trials) is:
>$$b(x;n,p) = \binom{n}{x}p^x q^{n-x}, \quad x=0,1,2,\ldots,n$$

The formula can be derived as follows:
1. The probability of $x$ successes and $(n-x)$ failures in a specific order is $p^x q^{n-x}$
2. The number of different ways to arrange $x$ successes among $n$ trials is $\binom{n}{x}$
3. Multiplying these gives the total probability of exactly $x$ successes

>[!example] Example: Binomial Calculation
>The probability that a certain component will survive a shock test is 3/4. Find the probability that exactly 2 of the next 4 components tested survive.
>
>**Solution**:
>With $n=4$ trials, success probability $p=3/4$ (survival), and $x=2$ successes, we have:
>$$b\left(2;4,\frac{3}{4}\right) = \binom{4}{2}\left(\frac{3}{4}\right)^2\left(\frac{1}{4}\right)^2 = 6 \cdot \frac{9}{16} \cdot \frac{1}{16} = \frac{54}{256} = \frac{27}{128}$$

## Mean and Variance of Binomial Distribution

The binomial distribution's parameters directly determine its mean and variance.

>[!theorem] Theorem: 
>The mean and variance of the binomial distribution $b(x;n,p)$ are:
>$$\mu = np \quad \text{and} \quad \sigma^2 = npq$$
>where $q = 1-p$

This makes intuitive sense:
- The mean $np$ is the expected number of successes in $n$ trials, each with success probability $p$
- The variance $npq$ reflects how the outcomes are distributed around this mean

>[!example] Example: Impurity Testing
>It is conjectured that impurities exist in 30% of drinking wells in a rural community. To investigate, 10 wells are randomly selected for testing.
>
>1. What is the probability that exactly 3 wells have impurities?
>2. What is the probability that more than 3 wells are impure?
>
>**Solution**:
>With $n=10$, $p=0.3$, and $q=0.7$:
>
>1. For exactly 3 impure wells:
>   $$b(3;10,0.3) = \binom{10}{3}(0.3)^3(0.7)^7 = 120 \cdot 0.027 \cdot 0.0824 = 0.2668$$
>
>2. For more than 3 impure wells:
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
>A shipment of 20 laptop computers to a retail outlet contains 3 that are defective. If a school randomly purchases 2 of these computers, find the probability distribution for the number of defectives.
>
>**Solution**:
>Let $X$ be the random variable representing the number of defective computers purchased. With $N=20$ total computers, $k=3$ defective computers, and a sample size of $n=2$, $X$ can take values 0, 1, or 2.
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

# Exercises

## Exercise 1: Genies in a Bottle

A farmer found a bottle with 6 genies. 3 of them grant wishes. The farmer releases the genies one-by-one, in random order. Let $X$ be the number of genies released (including the current one) until a wish-granting genie is released.

### Part A: Probability Distribution

Find the probability function of $X$.

**Solution**:
We need to find $P(X=x)$ for each possible value of $x \in \{1,2,3,4\}$. Since we have 3 genies that grant wishes out of 6 total genies:

For $X=1$ (first genie released grants a wish):
$$P(X=1) = \frac{3}{6} = 0.5$$

For $X=2$ (second genie released is the first to grant a wish):
- First genie must not grant wishes: $\frac{3}{6}$ 
- Second genie must grant wishes: $\frac{3}{5}$ (3 wish-granting genies left out of 5 total)
$$P(X=2) = \frac{3}{6} \cdot \frac{3}{5} = 0.3$$

For $X=3$ (third genie released is the first to grant a wish):
- First two genies must not grant wishes: $\frac{3}{6} \cdot \frac{2}{5}$
- Third genie must grant wishes: $\frac{3}{4}$ (3 wish-granting genies left out of 4 total)
$$P(X=3) = \frac{3}{6} \cdot \frac{2}{5} \cdot \frac{3}{4} = 0.15$$

For $X=4$ (fourth genie released is the first to grant a wish):
- First three genies must not grant wishes: $\frac{3}{6} \cdot \frac{2}{5} \cdot \frac{1}{4}$
- Fourth genie must grant wishes: $\frac{3}{3}$ (all remaining genies grant wishes)
$$P(X=4) = \frac{3}{6} \cdot \frac{2}{5} \cdot \frac{1}{4} \cdot \frac{3}{3} = 0.05$$

The complete probability distribution is:
$$\begin{array}{c|cccc}
x & 1 & 2 & 3 & 4 \\
\hline f(x) & 0.5 & 0.3 & 0.15 & 0.05
\end{array}$$

### Part B: Expected Value and Standard Deviation

Calculate $E(X)$ and $\sigma$.

**Solution**:
First, we calculate the expected value:
$$\begin{aligned}
E(X) &= \sum_{x} x f(x) \\
&= 1 \cdot 0.5 + 2 \cdot 0.3 + 3 \cdot 0.15 + 4 \cdot 0.05 \\
&= 0.5 + 0.6 + 0.45 + 0.2 \\
&= 1.75
\end{aligned}$$

To find the standard deviation, we first calculate $E(X^2)$:
$$\begin{aligned}
E(X^2) &= \sum_{x} x^2 f(x) \\
&= 1^2 \cdot 0.5 + 2^2 \cdot 0.3 + 3^2 \cdot 0.15 + 4^2 \cdot 0.05 \\
&= 0.5 + 1.2 + 1.35 + 0.8 \\
&= 3.85
\end{aligned}$$

Now we can calculate the variance:
$$\begin{aligned}
\sigma^2 &= E(X^2) - [E(X)]^2 \\
&= 3.85 - 1.75^2 \\
&= 3.85 - 3.0625 \\
&= 0.7875
\end{aligned}$$

And the standard deviation:
$$\sigma = \sqrt{0.7875} \approx 0.887$$

The expected number of genies that need to be released until finding a wish-granting genie is 1.75, with a standard deviation of approximately 0.887.

