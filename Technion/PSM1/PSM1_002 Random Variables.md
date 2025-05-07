---
aliases:
  - random variable
  - discrete random variable
  - continuous random variable
  - probability mass function
  - probability distribution
  - cumulative distribution function
  - expected value
  - variance
  - covariance
  - linear combinations of random variables
  - standard deviation
  - mean of random variable
  - probability function
  - joint probability distribution
  - density function
---
From [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]]:
# Concept of a Random Variable

A **statistical experiment** is any process that generates several chance observations. In many cases, we need to assign numerical values to the outcomes of such experiments. For example, when testing $3$ electronic components, the sample space can be represented as:
$$\Omega=\{ N N N,\, N N D,\, NDN,\, DN N,\, NDD,\, D N D,\, DDN,\, DDD \}$$
where $N$ denotes non-defective and $D$ denotes defective.

We can assign a *numerical value* to each outcome representing the number of defectives: $0,1,2$ or $3$. These values are random quantities determined by the experiment and are called values of the **random variable** $X$.

>[!def] Definition: 
>A **random variable** is a function that associates a real number with each element in the sample space.
 
We use capital letters (e.g., $X$) to denote random variables and lowercase letters (e.g., $x$) for their specific values.

## Discrete and Continuous Sample Space

>[!def] Definition: 
>If a sample space contains a finite number of possibilities or a countable sequence (equivalent to the set of whole numbers), it is called a **discrete sample space**.
 
Some experimental outcomes cannot be counted. For instance, when measuring the distance a car travels on $5$ liters of gasoline, we have an infinite number of possible distances that form a continuous range of values.

>[!def] Definition: 
>If a sample space contains an infinite number of possibilities equivalent to the points on a line segment, it is called a **continuous sample space**.
 
A **discrete random variable** has a countable set of possible outcomes, while a **continuous random variable** can take values on a continuous scale (an interval of numbers).
# Discrete Probability Distributions

A discrete random variable takes specific values with certain probabilities. For example, when tossing a coin $3$ times, the variable $X$ representing the number of heads can equal $2$ with probability $3/8$, since $3$ of the $8$ possible outcomes result in two heads.

We can represent the probabilities of a random variable $X$ with a formula denoted by $f(x)$, where $f(x) = P(X = x)$.

## Probability Distribution

>[!def] Definition: 
>The set of ordered pairs $(x,f(x))$ is called the **probability function**, **probability mass function**, or **probability distribution** of the discrete random variable $X$ if, for each possible outcome $x$:
>1. $f(x) \geq 0$
>2. $\sum_x f(x) = 1$
>3. $P(X = x) = f(x)$

>[!example] Example: Probability Distribution
>If a car agency sells $50\%$ of its inventory of a certain foreign car equipped with side airbags, find the probability distribution of the number of cars with side airbags among the next $4$ cars sold.
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

# Continuous Probability Distributions

Unlike discrete random variables, a **continuous random variable** has a probability of $0$ of assuming exactly any of its values. Consequently, its probability distribution cannot be given in tabular form.

This might seem startling initially, but becomes more plausible when we consider a specific example. Consider a random variable representing the heights of all people over $21$ years of age. Between any two values, say $163.5$ and $164.5$ centimeters, or even $163.99$ and $164.01$ centimeters, there are an infinite number of heights, one of which is $164$ centimeters. The probability of selecting a person at random who is exactly $164$ centimeters tall (and not one of the infinitely large set of heights so close to $164$ centimeters that you cannot humanly measure the difference) is essentially zero.

However, the probability of selecting a person who is at least $163$ centimeters but not more than $165$ centimeters tall is meaningful. Here we're dealing with an interval rather than a point value of our random variable.

For continuous random variables, we compute probabilities for intervals such as $P(a < X < b)$, $P(W \geq c)$, and so forth. Note that when $X$ is continuous:

$$P(a < X \leq b) = P(a < X < b) + P(X = b) = P(a < X < b)$$

That is, it doesn't matter whether we include an endpoint of the interval or not, since $P(X = b) = 0$. This is not true for discrete random variables.

## Probability Density Function

Although the probability distribution of a continuous random variable cannot be presented in tabular form, it can be stated as a formula. Such a formula is a function of the numerical values of the continuous random variable $X$ and is represented by the functional notation $f(x)$.

>[!def] Definition: 
>For continuous variables, $f(x)$ is called the **probability density function**, or simply the **density function**, of $X$.

Since $X$ is defined over a continuous sample space, $f(x)$ may have a finite number of discontinuities. However, most density functions used in statistical analysis are continuous, and their graphs may take various forms, as shown in the figure below:

![[{9CB84A33-4688-4B53-9E53-4AAF4B59C3B6}.png|bookhue]]
>Typical density functions. [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]].

Because areas represent probabilities (which are positive), the density function must lie entirely above the $x$-axis.

A probability density function is constructed so that the area under its curve bounded by the $x$-axis equals $1$ when computed over the range of $X$ for which $f(x)$ is defined. If this range is a finite interval, we can extend it to include all real numbers by defining $f(x)$ to be zero outside the original interval.

The probability that $X$ assumes a value between $a$ and $b$ equals the area under the density function between $x = a$ and $x = b$, given by:

$$P(a < X < b) = \int_a^b f(x)\,dx$$
![[{3D33DDE1-D88E-4330-B5C8-BC3C4708DCD4}.png|bookhue|500]]
>$P(a<X<b)$.  [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]].


>[!def] Definition: 
>The function $f(x)$ is a **probability density function** (pdf) for the continuous random variable $X$, defined over the set of real numbers, if:
>1. $f(x) \geq 0$, for all $x \in \mathbb{R}$.
>2. $\int_{-\infty}^{\infty} f(x)\,dx = 1$.
>3. $P(a < X < b) = \int_a^b f(x)\,dx$.

>[!example] Example: Temperature Error
>Suppose that the error in the reaction temperature, in $^{\circ}\pu{C}$, for a controlled laboratory experiment is a continuous random variable $X$ having the probability density function:
>$$f(x) = \begin{cases}
>\frac{x^2}{3}, & -1 < x < 2, \\
>0, & \text{elsewhere}.
>\end{cases}$$
>
>1. Verify that $f(x)$ is a density function.
>2. Find $P(0 < X \leq 1)$.
>
>**Solution**:
> 
> 1. Obviously, $f(x) \geq 0$. To verify condition 2, we have:
> 	$$\begin{aligned}
> 	\int_{-\infty}^{\infty} f(x)\,dx &= \int_{-1}^{2} \frac{x^2}{3}\,dx \\[1ex]
> 	&= \left.\frac{x^3}{9}\right|_{-1}^{2} \\[1ex]
> 	&= \frac{8}{9} + \frac{1}{9} = 1
> 	\end{aligned}$$
> 
> 2. Using formula 3, we obtain:
> 	$$\begin{aligned}
> 	P(0 < X \leq 1) &= \int_{0}^{1} \frac{x^2}{3}\,dx \\[1ex]
> 	&= \left.\frac{x^3}{9}\right|_{0}^{1} \\[1ex]
> 	&= \boxed {
\frac{1}{9}
 }
> 	\end{aligned}$$

## Cumulative Distribution Function

Similarly to discrete random variables, we can define a cumulative distribution function for continuous random variables.

>[!def] Definition: 
>The **cumulative distribution function** $F(x)$ of a continuous random variable $X$ with density function $f(x)$ is:
>$$F(x) = P(X \leq x) = \int_{-\infty}^{x} f(t)\,dt, \quad -\infty < x < \infty$$

As a consequence of this definition, we can write:
$$P(a < X < b) = F(b) - F(a)$$

and if the derivative exists:
$$f(x) = \frac{dF(x)}{dx}$$

>[!example] Example: Using the CDF
>For the density function of the previous example, find $F(x)$, and use it to evaluate $P(0 < X \leq 1)$.
>
>**Solution**:
>
>For $-1 < x < 2$,
>$$\begin{aligned}
>F(x) &= \int_{-\infty}^{x} f(t)\,dt \\
>&= \int_{-1}^{x} \frac{t^2}{3}\,dt \\
>&= \left.\frac{t^3}{9}\right|_{-1}^{x} \\
>&= \frac{x^3 + 1}{9}
>\end{aligned}$$
>
>Therefore:
>$$F(x) = \begin{cases}
>0, & x < -1, \\
>\frac{x^3 + 1}{9}, & -1 \leq x < 2, \\
>1, & x \geq 2.
>\end{cases}$$
>![[{4343A3BF-1EFF-4131-891B-A8D059635EA7}.png|bookhue|400]]
>Now we can find:
>$$\begin{aligned}
>P(0 < X \leq 1) &= F(1) - F(0) \\
>&= \frac{2}{9} - \frac{1}{9} \\
>&= \frac{1}{9}
>\end{aligned}$$
>
>This agrees with our result using the density function directly.

>[!example] Example: Bidding Process
>The Department of Energy (DOE) puts projects out on bid and generally estimates what a reasonable bid should be. Call the estimate $b$. The DOE has determined that the density function of the winning (low) bid is:
>$$f(y) = \begin{cases}
>\frac{5}{8b}, & \frac{2}{5}b \leq y \leq 2b, \\
>0, & \text{elsewhere}.
>\end{cases}$$
>
>Find $F(y)$ and use it to determine the probability that the winning bid is less than the DOE's preliminary estimate $b$.
>
>**Solution**:
>
>For $\frac{2}{5}b \leq y \leq 2b$,
>$$\begin{aligned}
>F(y) &= \int_{\frac{2b}{5}}^{y} \frac{5}{8b}\,dy \\
>&= \left.\frac{5t}{8b}\right|_{\frac{2b}{5}}^{y} \\
>&= \frac{5y}{8b} - \frac{1}{4}
>\end{aligned}$$
>
>Thus:
>$$F(y) = \begin{cases}
>0, & y < \frac{2}{5}b, \\
>\frac{5y}{8b} - \frac{1}{4}, & \frac{2}{5}b \leq y < 2b, \\
>1, & y \geq 2b.
>\end{cases}$$
>
>To find the probability that the winning bid is less than the preliminary bid estimate $b$:
>$$\begin{aligned}
>P(Y \leq b) &= F(b) \\
>&= \frac{5}{8} - \frac{1}{4} \\
>&= \frac{3}{8}
>\end{aligned}$$

# Mean of a Random Variable

The mean of a random variable represents the "center" or expected value of its probability distribution. Consider this example: If two coins are tossed $16$ times and we record $X$, the number of heads per toss, then $X$ can be $0$, $1$, or $2$. If we observe $0$ heads $4$ times, $1$ head $7$ times, and $2$ heads $5$ times, the average number of heads is:

$$\frac{0 \cdot 4 + 1 \cdot 7 + 2 \cdot 5}{16} = 1.06$$

This average value ($1.06$) isn't actually one of the possible outcomes $\{0, 1, 2\}$. This illustrates that the mean of a random variable doesn't necessarily correspond to a possible outcome.

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
>Although both distributions have the same mean ($2.0$), company B has a significantly larger variance ($1.6 > 0.6$), indicating greater variability in the number of automobiles used daily.

An alternative formula for calculating variance that often simplifies computations is:

>[!theorem] Theorem: 
>The variance of a random variable $X$ is:
>$$\sigma^2 = E(X^2) - \mu^2$$

>[!example] Example: Using the Alternative Formula
>Let $X$ represent the number of defective parts when $3$ parts are sampled from a production line. The probability distribution is:
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
>1. Setting $a=0$,
>	$$E(b) = b$$
>2. Setting $b=0$,
>	$$E(aX) = aE(X)$$

>[!theorem] Theorem: 
 >The expected value of the sum or difference of two or more functions of a random variable $X$ is the sum or difference of the expected values of the functions. That is,
 >$$E(g(X)\pm h(X))=E(g(X))\pm E(h(X))$$

>[!example] Example: 
> Let $X$ be random variable with probability distribution as follows:
> $$\begin{array}{c|cccc}
> x & 0 & 1 & 2 & 3 \\
> \hline f(x) & 1/3 & 1/2 & 0 & 1/6
> \end{array}$$
> Applying the theorem above to the function $Y=(X-1)^{2}$, we can write
> $$\begin{aligned}
> E[(X-1)^{2}] & =E(X^{2}-2X+1) \\[1ex]
>  & =E(X^{2})-2E(X)+E(1)
> \end{aligned}$$
> We know that $E(1)=1$, and by direct computation,
> $$\begin{aligned}
>  & E(X)=0\cdot \dfrac{1}{3}+1\cdot \dfrac{1}{2}+2\cdot 0+3\cdot \dfrac{1}{6}=1 \\[1ex]
>  & E(X^{2})=0\cdot \dfrac{1}{3}+1\cdot \dfrac{1}{2}+4\cdot 0+9\cdot \dfrac{1}{6}=2
> \end{aligned}$$
> Hence,
> $$\begin{aligned}
> E[(X-1)^{2}] & =2-2\cdot 1+1 \\[1ex]
>  & =1
> \end{aligned}$$

>[!theorem] Theorem: 
 >If $X$ and $Y$ are random variables with joint probability distribution $f(x,y)$ and $a$, $b$ and $c$ are constants, then
>$$\sigma ^{2}_{aX+bY+c}=a^{2}{{{\sigma}_{X}}}^{2}+b^{2}{{{\sigma}_{Y}}}^{2}+2ab{\sigma}_{XY}$$
>Special cases:
> 1. Setting $b=0$:
> 	$$\sigma ^{2}_{aX+c}=a^{2}{{{\sigma}_{X}}}^{2}$$
> 2. Setting $a=1$:
> 	$$\sigma ^{2}_{X+c}=\sigma ^{2}_{X}$$
> 3. Setting $b=0$ and $c=0$, we see that
> 	$$\sigma ^{2}_{aX}=a^{2}{{{\sigma}_{X}}}^{2}$$
>4. If ${X}_{1},{X}_{2},\dots,{X}_{n}$ are independent random variables, then
>	$$\sigma ^{2}_{{a}_{1}{X}_{1}+{a}_{2}{X}_{2}+\dots +{a}_{n}{X}_{n}}={{{a}_{1}}}^{2}{{\sigma}_{{X}_{1}}}^{2}+{{{a}_{2}}}^{2}{{\sigma}_{{X}_{2}}}^{2}+\dots +{{{a}_{n}}}^{2}{{\sigma}_{{X}_{n}}}^{2}$$

>[!example] Example: 
> If $X$ and $Y$ are random variables with variances ${{{\sigma}_{X}}}^{2}=2$ and ${{{\sigma}_{Y}}}^{2}=4$ and covariance ${\sigma}_{XY}=-2$, find the variance of the random variable $Z=3X-4Y+8$.
> 
> **Solution**:
> $$\begin{aligned}
> {{{\sigma}_{Z}}}^{2} & =\sigma^{2}_{3X-4Y+8} \\[1ex]
>  & =\sigma ^{2}_{3X-4Y} \\[1ex]
>  & =9{{{\sigma}_{X}}}^{2}+16{{{\sigma}_{Y}}}^{2}-24{\sigma}_{XY} \\[1ex]
>  & =9\cdot 2+16\cdot 4-24\cdot(-2) \\[1ex]
>  & =\boxed {
> 130
>  }
> \end{aligned}$$

# Exercises

## Exercise 1

A farmer found a bottle with $6$ genies. $3$ of them grant wishes. The farmer releases the genies one-by-one, in random order. Let $X$ be the number of genies released (including the current one) until a wish-granting genie is released.

### Part a

Find the probability function of $X$.

**Solution**:
We need to find $P(X=x)$ for each possible value of $x \in \{1,2,3,4\}$. Since we have $3$ genies that grant wishes out of $6$ total genies:

For $X=1$ (first genie released grants a wish):
$$P(X=1) = \frac{3}{6} = 0.5$$

For $X=2$ (second genie released is the first to grant a wish):
- First genie must not grant wishes: $\frac{3}{6}$ 
- Second genie must grant wishes: $\frac{3}{5}$ ($3$ wish-granting genies left out of $5$ total)
$$P(X=2) = \frac{3}{6} \cdot \frac{3}{5} = 0.3$$

For $X=3$ (third genie released is the first to grant a wish):
- First two genies must not grant wishes: $\frac{3}{6} \cdot \frac{2}{5}$
- Third genie must grant wishes: $\frac{3}{4}$ ($3$ wish-granting genies left out of $4$ total)
$$P(X=3) = \frac{3}{6} \cdot \frac{2}{5} \cdot \frac{3}{4} = 0.15$$

For $X=4$ (fourth genie released is the first to grant a wish):
- First three genies must not grant wishes: $\frac{3}{6} \cdot \frac{2}{5} \cdot \frac{1}{4}$
- Fourth genie must grant wishes: $\frac{3}{3}$ (all remaining genies grant wishes)
$$P(X=4) = \frac{3}{6} \cdot \frac{2}{5} \cdot \frac{1}{4} \cdot \frac{3}{3} = 0.05$$

The complete probability distribution is:
$$\boxed {
\begin{array}{c|cccc}
x & 1 & 2 & 3 & 4 \\
\hline f(x) & 0.5 & 0.3 & 0.15 & 0.05
\end{array}
 }$$

### Part b

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
$$\sigma = \boxed {
\sqrt{0.7875}
 } \approx 0.887$$

The expected number of genies that need to be released until finding a wish-granting genie is $1.75$, with a standard deviation of approximately $0.887$.

