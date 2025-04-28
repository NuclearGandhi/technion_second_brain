---
aliases:
  - random variable
  - binomial distribution
  - probability distribution
  - Bernoulli process
---
From [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]]:
# Concept of a Random Variable

The testing of a number of electronic components is an example of a **statistical experiment**, a term that is used to describe any process by which several change observations are generated. It is often important to allocate a numerical description to the outcome. For example, the sample space giving a detailed description of each outcome when three electronic components are tested may be written
$$\Omega=\{ N N N,\, N N D,\, NDN,\, DN N,\, NDD,\, D N D,\, DDN,\, DDD \}$$
where $N$ denoted non-defective and $D$ denotes defective.
One is naturally concerned with the number of defectives that occur. Thus, each point in the sample space will be assigned a *numerical value* of $0,1,2$ or $3$. These values are, of course, random quantities *determined by the outcome of the experiment*. They may be viewed as values assumed by the **random variable** $X$, the number of defective items when three electronic components are tested.

>[!def] Definition: 
 >A **random variable** is a function that associates a real number with each element in the sample space.
 
 We shall use a capital letter, say $X$, to denote a random variable and its corresponding small letter, $x$ in this case, for one of its values.

## Discrete and Continuous Sample Space

>[!def] Definition: 
 >If a sample space contains a finite number of possibilities or an unending sequence with as many elements as there are whole numbers, it is called a **discrete sample space**.
 
The outcomes of some statistical experiments may be neither finite nor countable. Such is the case, for example, when one conducts an investigation measuring the distances that a certain make of automobile will travel over a prescribed test course on $5$ liters of gasoline. Assuming distance to be a variable measured to any degree of accuracy, then clearly we have an infinite number of possible distances in the sample space that cannot be equated to the number of whole numbers.

>[!def] Definition: 
 >If a sample space contains an infinite number of possibilities equal to the number of points on a line segment, it is called a **continuous sample space**.
 
A random variable is called a **discrete random variable** if its set of possible outcomes is countable. But a random variable whose set of possible values is an entire interval of numbers is not discrete. When a random variable can take on values on a continuous scale, it is called a **continuous random variable**.

# Discrete Probability Distributions
A discrete random variable assumes each of its values with a certain probability. In the case of tossing a coin three times, the variable $X$, representing the number of heads, assumes the value $2$ with probability $3/8$, since $3$ of the $8$ equally likely sample points result in two heads and one tail.

Frequently, it is convenient to represent all the probabilities of a random variable $X$ by a formula. Such a formula would necessarily be a function of the numerical values $x$ that we shall denote by $f(x),g(x),r(x)$, and so forth. Therefore, we write $f(x)=P(X=x)$; that is, $f(3)=P(X=3)$.

## Probability Distribution

>[!def] Definition: 
 > The set of ordered pairs $(x,f(x))$ is called the **probability function**, **probability mass function**, or **probability distribution** of the discrete random variable $X$ if, for each possible outcome $x$,
 > 1. $f(x)\geq 0$
 > 2. $\sum_x f(x)=1$,
 > 3. $P(X=x)=f(x)$


>[!example] Example: ^example-probability-dist
> If a car agency sells $50\%$ of its inventory of a certain foreign car equipped with side airbags, find a formula for the probability distribution of the number of cars with side airbags among the next $4$ cars sold by the agency.
> 
> **Solution**:
> Since the probability of selling an automobile with side airbags is $0.5$, the $2^{4}=16$ points in the sample space are equally likely to occur. Therefore, the denominator for all probabilities, and also for our function, is $16$. To obtain the number of ways of selling $3$ cars with side airbags, we need to consider the number of ways of partitioning $4$ outcomes into two cells, with $3$ cars with side airbags assigned to one cell and the model without side airbags assigned to the other. This can be done in $\binom{4}{3}=4$ ways. In general, the event of selling $x$ models with side airbags and $4-x$ models without side airbags can occur in $\binom{4}{x}$ ways, where $x$ can be $0$, $1$, $2$, $3$, or $4$. Thus, the probability distribution $f(x)=P(X=x)$ is
> $$f(x)=\dfrac{1}{16} \binom{4}{x},\qquad x=0,1,2,3,4$$

## Cumulative Distribution Function

There are many problems where we may wish to compute the probability that the observed value of a random variable $X$ will be less than or equal to some real number $x$. Writing $F(x)=P(X\leq x)$ for every real number $x$, we define $F(x)$ to be the **cumulative distribution function** of the random variable $X$.

>[!def] Definition: 
 >The **cumulative distribution function** $F(x)$ of a discrete random variable $X$ with probability distribution $f(x)$ is
 >$$F(x)=P(X\leq  x)=\sum_{t\leq  x}^{}f(t),\, \qquad -\infty <x<\infty  $$
 
>[!example] Example: 
> Find the cumulative distribution function of the random variable $X$ in the [[#^example-probability-dist|previous example]]. Using $F(x)$, verify that $f(2)=3/8$.
> 
> **Solution**:
> Direct calculations of the probability distribution of that example gives
> $$\begin{aligned}
>  & f(0)=1/16, &  & f(1)=1/4, &  & f(2)=3/8 \\[1ex]
>  & f(3)=1/4, &  & f(4)=1/16
> \end{aligned}$$
> Therefore,
> $$\begin{aligned}
>  & F(0)=f(0)=\dfrac{1}{16} \\[1ex]
>  & F(1)=f(0)+f(1)=\dfrac{5}{16} \\[1ex]
>  & F(2)=f(0)+f(1)+f(2)=\dfrac{11}{16} \\[1ex]
>  & F(3)=f(0)+f(1)+f(2)+f(3)=\dfrac{15}{16} \\[1ex]
>  & F(4)=f(0)+f(1)+f(2)+f(3)+f(4)=1
> \end{aligned}$$
> Now
> $$f(2)=F(2)-F(1)=\dfrac{11}{16}-\dfrac{5}{16}=\dfrac{3}{8}$$
> $$\tag*{$\blacksquare$}$$

It is often helpful to look at a probability distribution in the graphic form. One might plot the points $(x,f(x))$ of the example above to obtain the following figures:
![[{8ADEA98C-E53D-4C08-867D-994C94036816}.png|bookhue|400]]
>Probability mass function plot. [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]].

![[{6850365A-3E1E-4EF6-907F-474984755A48}.png|bookhue|400]]
>Probability histogram. [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]].

The graph of the cumulative distribution function is obtained by plotting the points $(x,F(x))$:

![[{006D722C-4C6B-49E5-B9BB-62C6653A4336}.png|bookhue|400]]
>Discrete cumulative distribution function. [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]].

# Mean of a Random Variable

Consider the following. If two coins are tossed $16$ times and $X$ is the number of heads that occur per toss, then the values of $X$ are $0$, $1$, and $2$. Suppose that the experiment yields no heads, one head, and two heads a total of $4$, $7$ and $5$ times, respectively. The average number of heads per toss of the two coins is then
$$\dfrac{0\cdot 4+1\cdot 7+2\cdot 5}{16}=1.06$$
This is an average value of the data and yet it is not a possible outcome of $\{ 0,1,2 \}$. Hence, an average is not necessarily a possible outcome for the experiment.

We shall refer to this average value as the **mean of the random variable $X$** or the **mean of the probability distribution of $X$** and write it as ${\mu}_{x}$ or simply as $\mu$ when it is clear to which random variable we refer. It is also common among statisticians to refer to this mean as the mathematical expectation, or the expected value of the random variable $X$, and denote it as $E(X)$.

>[!def] Definition: 
 >Let $X$ be a random variable with probability distribution $f(x)$. The **mean**, or **expected value**, of $X$ is
>$$\mu=E(x)=\sum_{x}^{} xf(x) $$
>if $X$ is discrete, and
>$$\mu=E(x)=\int_{-\infty }^{\infty} xf(x) \, \mathrm{d}x $$
>if $X$ is continuous.

# Variance and Covariance of Random Variables

## Variance of Random Variables

The mean (expected value) of a random variable $X$ describes the center of its probability distribution, but does not capture how spread out the values are. To understand the variability or dispersion of a distribution, we use the **variance**.

Two distributions can have the same mean but very different variability (dispersion) around the mean.

![[{01A46799-058E-4D12-A51F-B9351A14150D}.png|bookhue|600]]
>Distributions with equal means and unequal dispersions. [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]].

>[!def] Definition: 
> Let $X$ be a random variable with probability distribution $f(x)$ and mean $\mu$. The **variance** of $X$ is
> $$
> \begin{aligned}
> & \sigma^2  = E[(X-\mu)^2] = \sum_x (x-\mu)^2 f(x)\quad \text{if $X$ is discrete,} \\[1ex]
> & \sigma^2  = E[(X-\mu)^2] = \int_{-\infty}^{\infty} (x-\mu)^2 f(x)\,\mathrm{d}x\quad \text{if $X$ is continuous.}
> \end{aligned}
> $$
>
> The positive square root of the variance, $\sigma$, is called the **standard deviation** of $X$.

The term $x-\mu$ is called the **deviation** of an observation from its mean. Since deviations are squared and then averaged, the variance $\sigma^2$ is smaller when values are close to the mean, and larger when values are more spread out.

>[!example] Example: 
> Let the random variable $X$ represent the number of automobiles that are used for official business purposes on any given workday. The probability distribution for company $A$ is
> $$\begin{array}{c|ccc}
> x & 1 & 2 & 3 \\
> \hline f(x) & 0.3 & 0.4 & 0.3
> \end{array}$$
> and that for company $B$ is
> $$\begin{array}{c|ccccc}
> x & 0 & 1 & 2 & 3 & 4 \\
> \hline f(x) & 0.2 & 0.1 & 0.3 & 0.3 & 0.1
> \end{array}$$
> Show that the variance of the probability distribution for company $B$ is greater than that for company $A$.
> 
> **Solution**:
> For company $A$, we find that
> $${\mu}_{A}=E(X)=1\cdot 0.3 + 2\cdot 0.4+3\cdot 0.3=2.0$$
> and then
> $$\begin{aligned}
> {{{\sigma}_{A}}}^{2} & =\sum_{x=1}^{3} (x-2)^{2}  \\[1ex]
>  & =(1-2)^{2}\cdot 0.3+(2-2)^{2}\cdot 0.4+(3-2)^{2}\cdot 0.3 \\[1ex]
>  & =\boxed {
0.6
 }
> \end{aligned}$$
> For company $B$, we have
> $${\mu}_{B}=E(x)=0\cdot 0.2+0.1\cdot 1+0.3\cdot 2+0.3\cdot 3+0.1\cdot 4=2.0$$
> and then
> $$\begin{aligned}
> {{{\sigma}_{B}}}^{2} & =\sum_{x=0}^{4}(x-2)^{2}f(x)  \\[1ex]
>  & =(0-2)^{2}\cdot 0.2+(1-2)^{2}\cdot 0.1+(2-2)^{2}\cdot 0.3 \\[1ex]
>  & \qquad +(3-2)^{2}\cdot 0.3 \\[1ex]
>  & \qquad +(4-2)^{2}\cdot 0.1 \\[1ex]
>  & =\boxed {
1.6
 }
> \end{aligned}$$
> 
> Clearly, the variance of the number of automobiles that are used for official business purposes is greater for company $B$ than for company $A$.

An alternative and preferred formula for finding $\sigma ^{2}$, which often simplifies the calculations is stated in the following theorem:

>[!theorem] Theorem: 
 >The variance of a random variable $X$ is
 >$$\sigma ^{2}=E(X^{2})-\mu ^{2}$$

>[!example] Example: 
> Let the random variable $X$ represent the number of defective parts for a machine when $3$ parts are sampled from a production line and tested. The following is the probability distribution of $X$.
> 
> $$\begin{array}{c|cccc}
> x & 0 & 1 & 2 & 3 \\
> \hline f(x) & 0.51 & 0.38 & 0.1 & 0.01
> \end{array}$$
> Calculate $\sigma ^{2}$.
> 
> **Solution**:
> First, we compute
> $$\mu=0\cdot 0.51+1\cdot 0.38+2\cdot 0.1+3\cdot 0.01=0.61$$
> Now,
> $$E(X^{2})=0\cdot 0.51+1\cdot 0.38+2^{2}\cdot 0.1+3^{2}\cdot 0.01=0.87$$
> Therefore:
> $$\begin{aligned}
> \sigma ^{2} & =0.87-0.61^{2} \\[1ex]
>  & =\boxed {
> 0.4979
>  }
> \end{aligned}$$
> 

## Covariance of Random Variables

The **covariance** between two random variables is a measure of the nature of the association between the two.

>[!def] Definition: 
> Let $X$ and $Y$ be random variables with joint probability distribution $f(x,y)$. The covariance of $X$ and $Y$ is
>  $$\begin{aligned}
> {\sigma}_{XY} & =E[(x-{\mu}_{X})(y-{\mu}_{Y})] \\[1ex]
>  & =\sum_{x}^{}\sum_{y}^{}(x-{\mu}_{X})(y-{\mu}_{y})f(x,y)  
> \end{aligned}$$
>  if $X$ and $Y$ are discrete, and
>  $$\begin{aligned}
> {\sigma}_{XY} & =E[(X-{\mu}_{X})(Y-{\mu}_{Y})] \\[1ex]
>  & =\int_{-\infty }^{\infty} \int_{-\infty }^{\infty} (x-{\mu}_{X})(y-{\mu}_{Y}) \, \mathrm{d}x  \, \mathrm{d}y 
> \end{aligned}$$
> if $X$ and $Y$ are continuous.

>[!TODO] TODO: להשלים

## Means and Variances of Linear Combinations of Random Variables

We now develop some useful properties that will simplify the calculations of means and variances of random variables that appear in later chapters.

>[!theorem] Theorem: 
> If $a$ and $b$ are constants, then
> $$E(aX+b)=aE(X)+b$$
> Therefore, we can also see that:
> $$E(b)=b$$
> and that
> $$E(aX)=aE(X)$$

>[!TODO] TODO: להשלים

# Binomial and Multinomial Distributions

No matter whether a discrete probability distribution is represented graphically by a histogram, in tabular form, or by means of a formula, the behavior of a random variable is described. Often, the observations generated by different statistical experiments have the same general type of behavior. Consequently, discrete random variables associated with these experiments can be described by essentially the same probability distribution and therefore can be represented by a single formula. In fact, one needs only a handful of important probability distributions to describe many of the discrete random variables encountered in practice.

Such a handful of distributions describe several real-life random phenomena. For instance, in a study involving testing the effectiveness of a new drug, the number of cured patients among all the patients who use the drug approximately follows a **binomial distribution**.

An experiment often consists of repeated trials, each with two possible outcomes that may be labeled **success** or **failure**. The most obvious application deals with the testing of items as they off an assembly line, where each trial may indicate defective or a non-defective item. We may choose to define either outcome as a success. The process is referred to as a **Bernoulli process**. Each trial is called a **Bernoulli trial**. Observe, for example, if one were drawing cards from a deck, the probabilities for repeated trials change if the cards are not replaced. That is, the probability of selecting a heart on the first draw is $1/4$, but on the second draw it is a conditional probability having a value of $13/51$ or $12/51$, depending on whether a heart appeared on the first draw: this, then, would no longer be considered a set of Bernoulli trials.

## The Bernoulli Process
Strictly speaking, the Bernoulli process must possess the following properties:  
1. The experiment consists of repeated trials.
2. Each trial results in an outcome that may be classified as a success or a failure.
3. The probability of success, denoted by $p$, remains constant from trial to trial.
4. The repeated trials are independent.

Consider the set of Bernoulli trials where three items are selected at random from a manufacturing process, inspected, and classified as defective or non-defective. A defective item is designated a success. The number of successes is a random variable $X$ assuming integral values from $0$ through $3$. The eight possible outcomes and the corresponding values of $X$ are
$$\begin{array}{c|cc}
\text{Outcome} & N N N & N D N & N N D & D N N & ND D  & DND & DD N  & DDD \\
\hline x & 0 & 1 & 1 & 1 & 2 & 2 & 2 & 3
\end{array}$$

Since the items are selected independently and we assume that the process produces $25\%$ defectives, we have
$$P(N D N)=P(N)P(D)P(N)=\left( \dfrac{3}{4} \right)\left( \dfrac{1}{4} \right)\left( \dfrac{3}{4} \right)=\dfrac{9}{64}$$
Similar calculations yield the probabilities for the other possible outcomes. The probability distribution of $X$ is therefore
$$\begin{array}{c|cc}
x & 0 & 1 & 2 & 3 \\
\hline f(x) & \dfrac{27}{64} & \dfrac{27}{64} & \dfrac{9}{64} & \dfrac{1}{64}
\end{array}$$

## Binomial Distribution

The number $X$ of successes in $n$ Bernoulli trials is a called a **binomial random variable**. The probability distribution of this discrete random variable is called the **binomial distribution**, and its values will be denoted by $b(x;n,p)$ since they depend on the number of trials and the probability of a success on a given trial.

We wish to find a formula that gives the probability of $x$ successes in $n$ trails for a binomial experiment. First, consider the probability of $x$ successes and $n-x$ failures in a specified order. Since the trials are independent, we can multiply all the probabilities corresponding to the different outcomes. Each success occurs with probability $p$ and each failure with probability $q=1-p$. Therefore the probability for the specified order is $p^{x}q^{n-x}$. We must now determine the total number of sample points in the experiment that have $x$ successes and $n-x$ failures. This number is equal to the number of partitions of $n$ outcomes into two group with $x$ in one group and $n-x$ in the other and is written $\binom{n}{x}$ as introduced in the [[PSM1_001 Introduction and Probability#Combination|previous chapter]]. Because these partitions are [[PSM1_001 Introduction and Probability#Various Set Operations|mutually exclusive]], we add the probabilities of all the different partition to obtain the general formula:

>[!theorem] Theorem: 
 >A Bernoulli trial can result in a success with probability $p$ and a failure with probability $q=1-p$. Then the probability distribution of the binomial random variable $X$, the number of successes in $n$ independent trials, is
 >$$b(x;n,p)=\binom{n}{x}p^{x}q^{n-x},\qquad x=0,1,2,\dots ,n$$

>[!example] Example: 
> The probability that a certain kind of component will survive a shock test $3/4$. Find the probability that exactly $2$ of the next $4$ components tested survive.
> 
> **Solution**:
> Assuming that the tests are independent and $p=3/4$ for each of the $4$ tests, we obtain
> $$b\left( 2;4,\dfrac{3}{4} \right)=\binom{4}{2}\left( \dfrac{3}{4} \right)^{2}\left( \dfrac{1}{4} \right)^{2}=\dfrac{27}{128}$$
> 

## Areas of Application
Since the probability distribution of any binomial random variable depends only on the values assumed by the parameters $n$, $p$, and $q$, it would seem reasonable to assume that the mean and variance of a binomial random variable also depend on the values assumed by these parameters.

>[!theorem] Theorem: 
 >The mean and variance of the binomial distribution $b(x;n,p)$ are
 >$$\mu=np\qquad \text{and}\qquad \sigma ^{2}=npq$$

>[!example] Example: 
> It is conjectured that an impurity exists in $30\%$ of all drinking wells in a certain rural community. In order to gain some insight into the true extent of the problem, it is determined that some testing is necessary. It is too expensive to test all of the wells in the area, so $10$ are randomly selected for testing.
> 
> 1. Using the binomial distribution, what is the probability that exactly $3$ wells have the impurity, assuming that the conjecture is correct?
>2. What is the probability that more than $3$ wells are impure?
>
>**Solution**:
>1. We require
> 	$$b(3;10,0.3)=\sum_{x=0}^{3}b(x;10 ,0.3)-\sum_{x=0}^{2}b(x;10,0.3)=0.6496-0.3828=\boxed {
> 0.2668 
>  } $$
>2. In this case,
> 	$$P(X>3)=1-0.6496=\boxed {
> 0.3504
>  }$$

>[!TODO] TODO: להשלים




# Hypergeometric Distribution

>[!theorem] Theorem: 
> The probability distribution of the hypergeometric random variable $X$, the number of successes in a random sample of size $n$ selected from $N$ items of which $k$ are labeled **success** and $N-k$ labeled **failure**, is
> $$h(x;N,n,k)=\dfrac{\binom{k}{n}\binom{N-k}{n-k}}{\binom{N}{n}},\qquad \max_{}\{ 0,n-(N-k) \}\leq  x\leq  \min_{}\{ n,k \}$$


>[!example] Example:
>A shipment of $20$ similar laptop computers to a retail outlet contains $3$ that are defective. If a school makes a random purchase of $2$ of these computes, find the probability distribution for the number of defectives.
> **Solution**:
> Let $X$ be a random variable whose values $x$ are the possible numbers of defective computers purchased by the school. Then $x$ can only take numbers $0$, $1$ and $2$.
> 
> Now
> $$\begin{aligned}
>  & f(0)=P(X=0)=\dfrac{\binom{3}{0}\binom{17}{2}}{\binom{20}{2}}=\dfrac{68}{95} \\[1ex]
>  & f(1)=P(X=1)=\dfrac{\binom{3}{1}\binom{17}{1}}{\binom{20}{2}}=\dfrac{51}{190} \\[1ex]
>  & f(2)=P(X=2)=\dfrac{\binom{3}{2}\binom{17}{0}}{\binom{20}{2}}=\dfrac{3}{190}
> \end{aligned}$$
> Thus, the probability distribution of $X$ is
> $$\begin{array}{c|ccc}
> x & 0 & 1 & 2 \\
> \hline f(x) & \dfrac{68}{95} & \dfrac{51}{190} & \dfrac{3}{190}
> \end{array}$$

# Exercises
## Question 1
A farmer found a bottle with $6$ genies. $3$ of them grant wishes. The farmer lets the genies one-by-one, in a random order. Let $X$ be the number of released genies (including) until a wish is granted.

### Part a
Build the probability function of $X$.

**Solution**:
Its best to start with a simple case and then generalize. So for $X=1$, the probability is simply $3$ out of $6$:
$$P(X=1)=\dfrac{3}{6}=0.5$$
For $X=2$, first need to select a genie that doesn't grant a wish, that's $3/6$, and then a genie that does grant a wish. We have $5$ genies left to select from, and $3$ of them that grant wishes. Therefore:
$$P(X=2)=\dfrac{3}{6}\cdot \dfrac{3}{5}=0.3$$
The rest can be calculated in the same manner:
$$\begin{aligned}
 & P(X=3)=\dfrac{3}{6}\cdot \dfrac{2}{5}\cdot \dfrac{3}{4}=0.15 \\[1ex]
 & P(X=4)=\dfrac{3}{6}\cdot \dfrac{2}{5}\cdot \dfrac{1}{4}\cdot \dfrac{3}{3}=0.05
\end{aligned}$$


### Part b
Calculate $E(X)$ and $\sigma$.

**Solution**:
Using the [[#Variance and Covariance of Random Variables|theorems]], we get:
$$\begin{aligned}
E(X) & =1\cdot 0.5+2\cdot 0.3+3\cdot 0.15+4\cdot 0.05 \\[1ex]
 & =\boxed {
1.75
 }
\end{aligned}$$
Therefore:
$$\begin{aligned}
E(X^{2}) & =1^{2}\cdot 0.5+2^{2}\cdot 0.3+3^{2}\cdot 0.15+4^{2}\cdot 0.05 \\[1ex]
 & =\boxed {
3.85
 }
\end{aligned}$$
And the variance is:
$$\begin{aligned}
\sigma & =E(X^{2})-E(X)^{2} \\
 & =3.85-1.75^{2} \\[1ex]
 & =\boxed {
0.7875
 }
\end{aligned}$$

