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

>[!def] Definition: 
 >If a sample space contains a finite number of possibilities or an unending sequence with as many elements as there are whole numbers, it is called a **discrete sample space**.
 
The outcomes of some statistical experiments may be neither finite nor countable. Such is the case, for example, when one conducts an investigation measuring the distances that a certain make of automobile will travel over a prescribed test course on $5$ liters of gasoline. Assuming distance to be a variable measured to any degree of accuracy, then clearly we have an infinite number of possible distances in the sample space that cannot be equated to the number of whole numbers.

>[!def] Definition: 
 >If a sample space contains an infinite number of possibilities equal to the number of points on a line segment, it is called a **continuous sample space**.
 
A random variable is called a **discrete random variable** if its set of possible outcomes is countable. But a random variable whose set of possible values is an entire interval of numbers is not discrete. When a random variable can take on values on a continuous scale, it is called a **continuous random variable**.

# Discrete Probability Distributions
A discrete random variable assumes each of its values with a certain probability. In the case of tossing a coin three times, the variable $X$, representing the number of heads, assumes the value $2$ with probability $3/8$, since $3$ of the $8$ equally likely sample points result in two heads and one tail.

Frequently, it is convenient to represent all the probabilities of a random variable $X$ by a formula. Such a formula would necessarily be a function of the numerical values $x$ that we shall denote by $f(x),g(x),r(x)$, and so forth. Therefore, we write $f(x)=P(X=x)$; that is, $f(3)=P(X=3)$.

>[!def] Definition: 
 > The set of ordered pairs $(x,f(x))$ is called the **probability function**, **probability mass function**, or **probability distribution** of the discrete random variable $X$ if, for each possible outcome $x$,
 > 1. $f(x)\geq 0$
 > 2. $\sum_x f(x)=1$,
 > 3. $P(X=x)=f(x)$
 
>[!example] Example:
>A shipment of $20$ similar laptop computers to a retail outlet contains $3$ that are defective. If a school makes a random purchase of $2$ of these computes, find the probability distribution for the number of defectives.

**Solution**:
