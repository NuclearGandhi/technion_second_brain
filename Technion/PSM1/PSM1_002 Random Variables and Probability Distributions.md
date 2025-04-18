---
aliases:
  - random variable
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
>Probability mass function plot.

![[{6850365A-3E1E-4EF6-907F-474984755A48}.png|bookhue|400]]
>Probability histogram.

The graph of the cumulative distribution function is obtained by plotting the points $(x,F(x))$:

![[{006D722C-4C6B-49E5-B9BB-62C6653A4336}.png|bookhue|400]]
>Discrete cumulative distribution function.

# Binomial Distribution

No matter whether a discrete probability distribution is represented graphically by a histogram, in tabular form, or by means of a formula, the behavior of a random variable is described. Often, the observations generated by different statistical experiments have the same general type of behavior. Consequently, discrete random variables associated with these experiments can be described by essentially the same probability distribution and therefore can be represented by a single formula. In fact, one needs only a handful of important probability distributions to describe many of the discrete random variables encountered in practice.

Such a handful of distributions describe several real-life random phenomena. For instance, in a study involving testing the effectiveness of a new drug, the number of cured patients among all the patients who use the drug approximately follows a **binomial distribution**.

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
