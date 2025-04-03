---
aliases:
---
# Probability

## Sample Space
From [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]]:
In the study of statistics, we are concerned basically with presentation and interpretation of **chance outcomes** that occur in a planned study or scientific investigation. The statistician is often dealing with either numerical data, representing counts or measurements, or **categorical data**, which can be classified according to some criterion.


>[!def] Definition: Sample Space
 >The set of all possible outcomes of a statistical experiment is called the **sample space** and is represented by symbol $\Omega$.
 
 Each outcome in a sample space is called an **element** or a **member** of the sample space, or simply a **sample point**. If the sample space has a finite number of elements, we may list the members separated by commas and enclosed in braces. Thus, the sample space $\Omega$, of all possible outcomes when a coin is flipped, may be written
 $$\Omega=\{ H,T \}$$
 where $H$ and $T$ correspond to heads and tails, respectively.

>[!example] Example:
>Consider the experiment of tossing a die. If we are interested in the number that shows on the top face, the sample face is
>$${\Omega}_{1}=\{ 1,2,3,4,5,6 \}$$
>If we are interested only in whether the number is even or odd, the sample space is simply
>$${\Omega}_{2}=\{ \text{even},\text{odd} \}$$

# Events

For any given experiment, we may be interested in the occurrence of certain **events** rather than in the occurrence of a specific element in the sample space. For instance, we may be interested in the event $A$ that the outcome when a die is tossed is divisible by $3$. This will occur if the outcome is an element of the subset $A=\{ 3,6 \}$ of the sample space ${\Omega}_{1}$ is the example above.
To each event we assign a collection of sample points, which constitute a subset of the sample space. That subset represents all of the elements for which the event is true.

>[!def] Definition: Event
 >An **event** is subset of a sample space.

It is conceivable that an event may be a subset that includes the entire sample space $\Omega$ or a subset of $\Omega$ called the **null set** and denoted by the symbol $\phi$, which contains no elements at all. For example, if
$$B=\{ x\mid x \,\text{ is an even factor of }7 \}$$

then $B$ must be the null set, since the only possible factors of $7$ are the odd numbers $1$ and $7$.

## Various Set Operations

>[!def] Definition: Complement
 >The **complement** of an event $A$ with respect to $\Omega$ is the subset of all elements of $\Omega$ that are not in $A$. We denote the complement of $A$ by the symbol $A^{c}$.
 
 >[!example] Example: 
 >Let $R$ be the event that a red card is selected from an ordinary deck of $52$ playing cards, and let $\Omega$ be the entire deck. Then $R^{c}$ is the event that the card selected from the deck is not a red card but a black card.

>[!def] Definition: Intersection 
 >The **Intersection** of the two events $A$ and $B$, denoted by the symbol $A\cap B$, is the event containing all elements that are common to $A$ and $B$.
 
>[!def] Definition: Disjoint 
 >Two events $A$ and $B$ are **mutually exclusive**, or **disjoint**, if $A\cap B=\phi$, that is, if $A$ and $B$ have no elements in common.

>[!def] Definition: Union
 >The **union** of two events $A$ and $B$, denoted by the symbol $A\cup B$, is the event containing all the elements that belong to $A$ or $B$ or both.

The relationship between events and the corresponding sample space can be illustrated graphically by means of **Venn diagrams**. In a Venn diagram we let the sample space a rectangle and represent events by circles drawn inside the rectangle.

![[{2878DE7D-874C-4B54-8218-5FFD30D86B25}.png|bookhue|500]]
>Events represented by various regions. [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]].

Thus, in the figure above, we see that:
$$\begin{aligned}
 & A\cup C=\text{regions 1,2,3,4,5 and 7} \\[1ex]
 & B^{c}\cap A=\text{regions 4 and 7,} \\[1ex]
 & A\cap B\cap C=\text{region 1}, \\[1ex]
 & (A\cup B)\cap C^{c}=\text{regions 2,6, and 7}
\end{aligned}$$


Some useful rules:
1. $$A\cap \phi=\phi$$
2. $$A\cup \phi=A$$
3. $$A\cap A^{c}=\phi$$
4. $$A\cup A^{c}=\Omega$$
5. $$\Omega^{c}=\phi$$
6. $$\phi^{c}=\Omega$$
7. $$(A^{c})^{c}=A$$
8. $$(A\cup B)^{c}=A^{c}\cap B^{c}$$
9. $$(A\cup B)^{c}=A^{c}\cap B^{c}$$
10. $$A=(A\cap B)\cup(A\cap B^{c})$$
# Counting Sample Points

## Permutation

 If an operation can be performed in ${n}_{1}$ ways, and if for each of these ways a second operation can be performed in ${n}_{2}$ ways, then the two operations can be performed together in ${n}_{1}{n}_{2}$ ways.

>[!def] Definition: Permutation 
 >A **permutation** is an arrangement of all or part of a set of objects.
 
 Consider the three letters $a,b$ and $c$. The possible permutations are $abc,\,acb,\,bac,\,bca,\,cab$ and $cba$. Thus, we see that there are $6$ distinct arrangements. There are ${n}_{1}=3$ choices for the first position. No matter which letter is chosen, there are always ${n}_{2}=2$ choices for the second position. No matter which two letters are chosen for the first two positions, there is only ${n}_{3}=1$ choice for the last position, giving a total of:
 $${n}_{1}{n}_{2}{n}_{3}=3\cdot 2\cdot 1=6$$
Or simply:
>[!theorem] Theorem: 
 >The number of permutations of $n$ objects is $n!$.

Now consider the number of permutations that are possible by taking two letters at a time from four. These would be $ab,\,ac,\,ad,\,ba,\,bc,\,bd,\,ca,\,cb,cd,\,da,\,db$ and $dc$. Using the rule above, we have two positions to fill, with ${n}_{1}=4$ choices for the first and then ${n}_{2}=3$ choices for the second, for a total of
$${n}_{1}{n}_{2}=4\cdot 3=12$$
 In general, $n$ distinct objects taken $r$ at a time can be arranged in
 $$n(n-1)(n-2)\cdots (n-r+1)$$
ways. We represent this product by the symbol
$$_{n}{P}_{k}=\dfrac{n!}{(n-k)!}$$
As a result, we have the following theorem:
>[!theorem] Theorem: 
 >The number of permutations of $n$ distinct object taken $r$ at a time is
 >$$_{n}{P}_{k}=\dfrac{n!}{(n-k)!}$$
## Combination
In many problems, we are interested in the number of ways of selecting $r$ objects from $n$ without regard to order. These selections are called **combinations**.

>[!theorem] Theorem: 
 >The number of combinations of $n$ distinct objects taken $r$ at a time is
 >$$\binom{n}{k}=\dfrac{n!}{(n-k)!k!}$$
 
 >[!notes] Note: 
 >$$\binom{n}{n}=\binom{n}{0}=1$$
 
# Probability of an Event


>[!def] Definition: Probability
 > The **probability** of an event $A$ is the sum of the weights of all sample points in $A$. Therefore,
 > $$0\leq  P(A)\leq  1,\qquad P(\phi)=0,\qquad \text{and}\qquad  P(\Omega)=1$$
 > Furthermore, if ${A}_{1},{A}_{2},{A}_{3},\dots$ is a sequence of mutually exclusive events, then
 > $$P({A}_{1}\cup {A}_{2}\cup {A}_{3}\cup\cdots )=P({A}_{1})+P({A}_{2})+P({A}_{3})+\cdots $$
 
>[!example] Example:
>A coin is tossed twice. What is the probability that at least $1$ head occurs?
>**Solution**:
>The space for this experiment is
>$$\Omega=\{ HH,\, HT,\, TH,\, TT \}$$
>If the coin is balanced, each of these outcomes is equally likely to occur. Therefore, we assign a probability of $\omega$ to each sample point. Then $4\omega=1$, or $\omega=1/4$. If $A$ represents the event of at least $1$ head occurring, then
>$$A=\{ HH,\, HT,\, TH \}$$
>so
>$$ P(A)=\dfrac{1}{4}+\dfrac{1}{4}+\dfrac{1}{4}=\dfrac{3}{4}$$


Some important rules:
1. $$P(A)+P(A^{c})=1$$
2. $$A\subseteq B\implies P(A)\leq  P(B)$$
# Additive Rules
Often it is easiest to calculate the probability of some event from known probabilities of other events. This may well be true if the event in question can be represented as the union of two other events or as the complement of some event. Several important laws that frequently simplify the computation of probabilities follow. The first, called the **additive rule**, applies to union of events.

>[!theorem] Theorem: 
 >If $A$ and $B$ are two events, then
>$$P(A\cup B)=P(A)+P(B)-P(A\cap B)$$

![[{DC268415-8EBA-4BFC-B27C-642D92D32162}.png|bookhue|350]]
>Additive rule of probability. [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]].


>[!theorem] Theorem: 
 >If $A$ and $B$ are disjoint, then
 >$$P(A\cup B)=P(A)+P(B)$$

>[!theorem] Theorem: 
 >If ${A}_{1},{A}_{2},\dots,{A}_{m}$ are mutually exclusive, then
 >$$P({A}_{1}\cup {A}_{2}\cup\dots \cup {A}_{m})=\sum_{i=1}^{m}P({A}_{i}) $$

> [!tip] Tip:
> When in doubt, consider a Venn diagram.

>[!example] Example: 
>How do employees commute to work? (defined as "use at least one a week"), given:
>$$\begin{aligned}
 & P(\text{train})=0.2, &  & P(\text{car})=0.8, \\
 & P(\text{car and bike})=0.08
\end{aligned}$$
>What are the probabilities for "not car", "train or car", "bike and not car"?
>**Solution**:
>Using the notation
>$$\begin{aligned}
 & P(T)=P(\text{train}), &  & P(C)=P(\text{car}), &  & P(B)=P(\text{bike}) \\
\end{aligned}$$
>we get:
>$$\begin{aligned}
 & P(C)^{c}=1-0.8=0.2 \\[1ex]
 & P(T\cup C)=P(T)+P(C)-P(T\cup C)=0.2+0.8-0.16=0.84
\end{aligned}$$
>For the third case, we know that:
>$$P(B)=P(B\cap C)+P(B\cap C^{c})$$
>So we can simple rearrange:
>$$P(B\cap C^{c})=P(B)-P(B\cap C)=0.1-0.08=0.02$$

# Conditional Probability, Independence, and the Product Rule

## Conditional Probability

The probability of an event $B$ occurring when it is known that some event $A$ has occurred is called a **conditional probability** and is denoted by $P(B|A)$. The symbol $P(B|A)$ is usually read "the probability that $B$ occurs given that $A$ occurs", or simply "the probability of $B$, given $A$".

Consider the event $B$ of getting a perfect square when a die is tossed. The die is constructed so that the even numbers are *twice* as likely to occur as the odd numbers. Based on sample space $\Omega=\{ 1,2,3,4,5,6 \}$, with probabilities of $1/9$ and $2/9$ assigned, respectively, to the odd and even numbers, the probability of $B$ occurring is $1/3$. Now supposed that it is known that the toss of the die resulted in a number greater than $3$. We are now dealing with a reduced sample space $A=\{ 4,5,6 \}$, which is a subset of $\Omega$. To find the probability that $B$ occurs, relative to the space $A$, we must first assign new probabilities to the elements of $A$ proportional to their original probabilities such that their sum is $1$. Assigning a probability of $w$ to the odd numbers in $A$ and a probability of $2w$ to the two even numbers, we have $5w=1$, or $w=1/5$. Relative to the space $A$, we find that $B$ contains the single element $4$. Denoting this event by the symbol $B|A$, we write $B|A=\{ 4 \}$, and hence
$$P(B|A)=\dfrac{2}{5}$$
This example illustrates that events may have different probabilities when considered relative to different sample spaces.
We can also write
$$P(B|A)=\dfrac{2}{5}=\dfrac{2/9}{5/9}=\dfrac{P(A\cap B)}{P(A)}$$

>[!def] Definition: 
 >The conditional probability of $B$, given $A$, denoted by $P(B|A)$, is defined by:
 >$$P(B|A)=\dfrac{P(A\cap B)}{P(A)},\, \qquad  P(A)>0 $$

Another rule:
1. $$P(A|B)=P(A\cap C|B)+P(A\cap C^{c}|B)$$
## Independent Events

In the die tossing experiment we note that $P(B|A)=2/5$ whereas $P(B)=1/3$. That is, $P(B|A)\neq P(B)$, indicating that $B$ depends on $A$. Now consider an experiment in which $2$ cards are drawn in succession from an ordinary deck, with replacement. The events are defined as
- $A$ - the first card is an ace,
- $B$ - the second card is a spade.

Since the first card is replaced, our sample space for both the first and the second draw consists of $52$ cards, containing $4$ aces and $13$ spades. Hence:
$$P(B|A)=\dfrac{1}{4}\qquad \text{and}\qquad P(B)=\dfrac{13}{52}=\dfrac{1}{4}$$
That is, $P(B|A)=P(B)$. When this is true, the events $A$ and $B$ are said to be **independent**.
Although conditional probability allows for an alteration of the probability of an event in the light additional material, it also enables us to understand better the very important concept of **independence** or, in the present context, independent events.

>[!def] Definition: 
 >Two events $A$ and $B$ are **independent** if and only if
 >$$P(B|A)=P(B)\qquad \text{or}\qquad P(A|B)=P(A)$$
 >Assuming the existences of the conditional probabilities. Otherwise, $A$ and $B$ are **dependant**.

The condition $P(B|A)=P(B)$ implies that $P(A|B)=P(A)$, and conversely.

## The Multiplicative Rule
Multiplying the definition of the [[#Conditional Probability]] above by $P(A)$, we obtain the following important **multiplicative rule** (or **product rule**), which enables us to calculate the probability that two events will both occur.

>[!theorem] Theorem: 
 >If in an experiment the events $A$ and $B$ can both occur, then
 >$$P(A\cup B)=P(A)P(B| A),\qquad P(A)>0$$

Therefore, we can also write:
$$\begin{aligned}
P({A}_{1}\cap {A}_{2}\cap\dots \cap {A}_{n}) & = P({A}_{1})\cdot P({A}_{2}|{A}_{1})\cdot  \\[1ex]
 & \qquad \cdot P({A}_{3}|{A}_{1}\cap {A}_{2}) \\[1ex]
 & \qquad \cdots P({A}_{m}|{A}_{1}\cap\dots \cap {A}_{m-1})
\end{aligned}$$



# Bayes' Rule

Bayesian statistics is a collection of tools that is used in a special form of statistical inference which applies in the analysis of experimental data in many practical situations in science and engineering. Bayes' rule is one of the most important rules in probability theory.

## Total Probability

Supposed that our sample space $\Omega$ is the population of adults in a small town who have completed the requirements for a college degree. We shall categorize them according to gender and employment status. The data are given in the following figure:
![[{1E4D62E0-ED53-463B-A3EB-62F496BC3E52}.png|bookhue|450]]
>Categorization of the Adults in a Small Town.

One of these individuals is to be selected at random for a tour throughout the country to publicize the advantages of establishing new industries in the town. We shall be concerned with the following events:
- $M$ - a man is chosen,
- $E$ - the one chosen is employed.

Suppose that we are now given the additional information that $36$ of those employed and $12$ of those unemployed are members of the Rotary Club. We wish to find the probability of the event $A$ that the individual selected is a member of the Rotary Club.
![[{26C13AD9-90A9-478A-B9BE-80649EEC2021}.png|bookhue|400]]
>Venn diagram for the events $A,\,E$ and $E^{c}$. [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]].

Referring to the figure, we can write $A$ as the union of the two mutually exclusive events $E\cap A$ and $E^c\cap A$. Hence, $A=(E\cap A)\cup(E^c\cap A)$, and using the rules discussed earlier we can write:
$$\begin{aligned}
P(A) & =P[(E\cap A)\cup(E^c\cap A)] \\[1ex]
 & =P(E\cap A)+P(E^c\cap A) \\[1ex]
 & =P(E)P(A|E)+P(E^c)P(A|E^c)
\end{aligned}$$

From the table we can compute that:
$$P(E)=\dfrac{600}{900}=\dfrac{2}{3},\qquad P(A|E)=\dfrac{36}{600}=\dfrac{3}{50}$$
and:
$$P(E^{c})=\dfrac{300}{900}=\dfrac{1}{3},\qquad P(A|E^{c})=\dfrac{12}{300}=\dfrac{1}{25}$$
We can also display these probabilities by means of a tree diagram:
![[{6D9CDCBD-FCAE-436B-8968-464BAAC6F90D}.png|bookhue|450]]
>Tree diagram for the data above.

It follows that:
$$P(A)=\dfrac{2}{3}\cdot \dfrac{3}{50}+\dfrac{1}{3} \cdot \dfrac{1}{25}=\dfrac{4}{75}$$
A generalization of the foregoing illustration to the case where the sample space is partitioned into $k$ subsets is covered by the following theorem, sometimes called the **theorem of total probability**.


>[!theorem] Theorem: 
 >If the events ${B}_{1},{B}_{2},\dots,{B}_{k}$ constitute a partition of the sample space $\Omega$ such that $P({B}_{i})\neq 0$ for $i=1,2,\dots,k$, then for any event $A$ of $\Omega$,
 >$$P(A)=\sum_{i=1}^{m}P({B}_{i}\cap A)=\sum_{i=1}^{m}P({B}_{i})P(A|{B}_{i})  $$

![[{27CC9365-1C28-47F2-9B1C-1DDF88A7A685}.png|bookhue|500]]
>Partitioning the sample space $\Omega$. [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]].