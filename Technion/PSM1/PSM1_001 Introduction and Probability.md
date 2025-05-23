---
aliases:
  - probability
  - sample space
  - permutation
  - combination
  - conditional probability
  - independent
  - the multiplicative rule
  - total probability
  - bayes' rule
  - additive rule
---
From [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]]:
# Probability

## Sample Space
In the study of statistics, we are concerned basically with presentation and interpretation of **chance outcomes** that occur in a planned study or scientific investigation. The statistician is often dealing with either numerical data, representing counts or measurements, or **categorical data**, which can be classified according to some criterion.


>[!def] Definition:
 >The set of all possible outcomes of a statistical experiment is called the **sample space** and is represented by symbol $\Omega$.
 
 Each outcome in a sample space is called an **element** or a **member** of the sample space, or simply a **sample point**. If the sample space has a finite number of elements, we may list the members separated by commas and enclosed in braces. Thus, the sample space $\Omega$, of all possible outcomes when a coin is flipped, may be written
 $$\Omega=\{ H,T \}$$
 where $H$ and $T$ correspond to heads and tails, respectively.

>[!example] Example:
>
>Consider the experiment of tossing a die. If we are interested in the number that shows on the top face, the sample face is
>$${\Omega}_{1}=\{ 1,2,3,4,5,6 \}$$
>If we are interested only in whether the number is even or odd, the sample space is simply
>$${\Omega}_{2}=\{ \text{even},\text{odd} \}$$

# Events

For any given experiment, we may be interested in the occurrence of certain **events** rather than in the occurrence of a specific element in the sample space. For instance, we may be interested in the event $A$ that the outcome when a die is tossed is divisible by $3$. This will occur if the outcome is an element of the subset $A=\{ 3,6 \}$ of the sample space ${\Omega}_{1}$ is the example above.
To each event we assign a collection of sample points, which constitute a subset of the sample space. That subset represents all of the elements for which the event is true.

>[!def] Definition:
 >An **event** is subset of a sample space.

It is conceivable that an event may be a subset that includes the entire sample space $\Omega$ or a subset of $\Omega$ called the **null set** and denoted by the symbol $\phi$, which contains no elements at all. For example, if
$$B=\{ x\mid x \,\text{ is an even factor of }7 \}$$

then $B$ must be the null set, since the only possible factors of $7$ are the odd numbers $1$ and $7$.

## Various Set Operations

>[!def] Definition:
 >The **complement** of an event $A$ with respect to $\Omega$ is the subset of all elements of $\Omega$ that are not in $A$. We denote the complement of $A$ by the symbol $A^{c}$.
 
 >[!example] Example: 
 >
 >Let $R$ be the event that a red card is selected from an ordinary deck of $52$ playing cards, and let $\Omega$ be the entire deck. Then $R^{c}$ is the event that the card selected from the deck is not a red card but a black card.

>[!def] Definition:
 >The **Intersection** of the two events $A$ and $B$, denoted by the symbol $A\cap B$, is the event containing all elements that are common to $A$ and $B$.
 
>[!def] Definition:
 >Two events $A$ and $B$ are **mutually exclusive**, or **disjoint**, if $A\cap B=\phi$, that is, if $A$ and $B$ have no elements in common.

>[!def] Definition:
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
$$\begin{aligned}
 & 1. &  & A\cap \phi=\phi \\[1ex]
 & 2. &  & A\cup \phi=A \\[1ex]
 & 3. &  & A\cap A^{c}=\phi \\[1ex]
 & 4. &  & A\cup A^{c}=\Omega \\[1ex]
 & 5. &  & \Omega^{c}=\phi \\[1ex]
 & 6. &  & \phi^{c}=\Omega \\[1ex]
 & 7. &  & (A^{c})^{c}=A \\[1ex]
 & 8. &  & (A\cup B)^{c}=A^{c}\cap B^{c} \\[1ex]
 & 9. &  & (A\cup B)^{c}=A^{c}\cap B^{c} \\[1ex]
 & 10. &  & A=(A\cap B)\cup(A\cap B^{c})
\end{aligned}$$

# Counting Sample Points

One of the problems that the statistician must consider and attempt to evaluate is the element of chance associated with the occurrence of certain events when an experiment is performed. These problems belong in the field of **probability**. In many cases, we shall be able to solve a probability problem by counting the number of points in the sample space without actually listing each element. The fundamental principle of counting, often referred to as the **multiplication rule**, is the following:

>[!theorem] Theorem: 
>  If an operation can be performed in ${n}_{1}$ ways, and if for each of these ways a second operation can be performed in ${n}_{2}$ ways, then the two operations can be performed together in ${n}_{1}{n}_{2}$ ways.

This rule can be extended to cover any number of operations. Supposed for instance, that a customer wishes to buy a new cell phone and can choose from ${n}_{1}=5$ brands, ${n}_{2}=5$ sets of capability, and ${n}_{3}=4$ colors. These three classifications result in ${n}_{1}{n}_{2}{n}_{3}=5\cdot 5\cdot 4=100$ different ways for a customer to order one of these phones. The **generalized multiplication rule** covering $k$ operations is stated in the following.
>[!theorem] Theorem: 
 >If an operation can be performed in ${n}_{1}$ ways, and if for each of these a second operation can be performed in ${n}_{2}$ ways, and for each of the first two a third operation can be performed in ${n}_{3}$ ways, and so forth, then the sequence of $k$ operations can be performed in ${n}_{1},{n}_{2},\dots,{n}_{k}$ ways.

>[!example] Example:
>How many *even* four-digit numbers can be formed from the digits $0,\,1,\,2,\,5,\,6$ and $9$ if each digit can be used only once?
>**Solution**:
> Since the number must be even, we have only ${n}_{1}=3$ choices for the units position. However, for a four-digit number the thousands position cannot be $0$. Hence, we consider the units position in two parts, $0$ or not $0$. If the units position  is $0$ (i.e., ${n}_{1}=1$), we have ${n}_{2}=5$ choices for the thousands position, ${n}_{3}=4$ for the hundreds position, and ${n}_{4}=3$ for the tens position. Therefore, in this case we have a total of
> $${n}_{1}{n}_{2}{n}_{3}{n}_{4}=1\cdot 5\cdot 4\cdot 3=60$$
> even four-digit numbers. On the other hand, if the units position is not $0$ (i.e., ${n}_{1}=2$), we have ${n}_{2}=4$ choices for the thousands position, ${n}_{3}=4$ for the hundreds position, ${n}_{4}=3$ for the tens position. Therefore, in this case we have a total of
> $${n}_{1}{n}_{2}{n}_{3}{n}_{4}=2\cdot 4\cdot 4\cdot 3=96$$
> even four-digit numbers.
> Since the above two cases are mutually exclusive, the total number of even four-digit numbers can be calculated as $60+96=\boxed{156 }$
> 
> 

## Permutation


>[!def] Definition: 
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

>[!example] Example:
> In one year, three awards (research, teaching, and service) will be given to a class of $25$ graduate students in a statistics department. If each student can receive at most one award, how many possible selection are there?
> 
> **Solution**:
> Since the awards are distinguishable, it is a permutation problem. The total number of sample points is
> $$_{25}{P}_{3}=\dfrac{25!}{(25-3)!}=\dfrac{25!}{22!}=25\cdot 24\cdot 23=\boxed {
> \pu{13800}
>  }$$
> 

Permutations that occur by arranging object in a circle are called **circular permutations**. Two circular permutations are not considered different unless corresponding objects in the two arrangements are preceded or followed by a different object as we proceed in a clockwise direction. For example, if $4$ people are playing bridge, we do not have a new permutation if there all move one position in a clockwise direction. By considering one person in a fixed position and arranging the other three in $3!$ ways, we find there are $6$ distinct arrangements for the bridge game.

>[!theorem] Theorem: 
 >The number of permutations of $n$ objects arranged in a circle is $(n-1)!$
 
So far we have considered permutations of distinct objects. That is, all the objects were completely different or distinguishable. Obviously, if the letters $b$ and $c$ are both equal to $x$, then the $6$ permutations of the letters $a$, $b$, and $c$ are both equal to $x$, then the $6$ permutations of the letters $a$, $b$, and $c$ become $axx$, $ax x$, $xax$, $xax$, $xxa$ and $xxa$, of which only $3$ are distinct. Therefore, with $3$ letters, $2$ being the same, we have $3!/2! = 3$ distinct permutations. With $4$ different letters $a$, $b$, $c$ and $d$, we have $24$ distinct permutations. If we let $a=b=x$ and $c=d=y$, we just list only the following distinct permutations: $x xyy$, $xyxy$, $y xx y$, $y y x x$, $xyyx$ and $yxyx$. Thus we have $4!/(2!2!)=6$ distinct permutations.

>[!theorem] Theorem: 
 >The number of distinct permutations of $n$ things of which ${n}_{1}$ are of one kind, ${n}_{2}$ of a second kind, $\dots$, ${n}_{k}$ are of a $k$-th kind is
 >$$\dfrac{n!}{{n}_{1}!{n}_{2}!\cdots {n}_{k}!}$$
## Combination
In many problems, we are interested in the number of ways of selecting $r$ objects from $n$ without regard to order. These selections are called **combinations**.

>[!theorem] Theorem: 
 >The number of combinations of $n$ distinct objects taken $r$ at a time is
 >$$\binom{n}{k}=\dfrac{n!}{(n-k)!k!}$$
 
 >[!notes] Note: 
 >$$\binom{n}{n}=\binom{n}{0}=1$$

# Probability of an Event


>[!def] Definition:
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
$$\begin{aligned}
 & 1. &  & P(A)+P(A^{c})=1 \\[1ex]
 & 2. &  & A\subseteq B\implies P(A)\leq  P(B)
\end{aligned}$$

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

Which we can generalize:
>[!theorem] Theorem: 
 >If ${A}_{1},{A}_{2},\dots,{A}_{m}$ are mutually exclusive (disjoint), then
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
 >The **conditional probability** of $B$, given $A$, denoted by $P(B|A)$, is defined by:
 >$$P(B|A)=\dfrac{P(A\cap B)}{P(A)},\, \qquad  P(A)>0 $$


Another rule:
$$\begin{aligned}
& 1. & & P(A|B)=P(A\cap C|B)+P(A\cap C^{c}|B) \\[1ex]
\end{aligned}$$

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

>[!notes] Note: 
 >The condition $P(B|A)=P(B)$ implies that $P(A|B)=P(A)$, and conversely.
 

## The Multiplicative Rule
Multiplying the definition of the [[#Conditional Probability|conditional probability]] above by $P(A)$, we obtain the following important **multiplicative rule** (or **product rule**), which enables us to calculate the probability that two events will both occur.

>[!theorem] Theorem: 
 >If in an experiment the events $A$ and $B$ can both occur, then
 >$$P(A\cup B)=P(A)P(B| A),\qquad P(A)>0$$

Therefore, we can also write:
$$\begin{aligned}
P({A}_{1}\cap {A}_{2}\cap\dots \cap {A}_{n}) & = P({A}_{1})\cdot P({A}_{2}|{A}_{1})\cdot  \\[1ex]
 & \qquad \cdot P({A}_{3}|{A}_{1}\cap {A}_{2}) \\[1ex]
 & \qquad \cdots P({A}_{m}|{A}_{1}\cap\dots \cap {A}_{m-1})
\end{aligned}$$

>[!example] Example: 
>Suppose that we have a fuse box containing $20$ fuses, of which $5$ are defective. If $2$ fuses are selected at random and removed from the box in succession without replacing the first, what is the probability that both fuses are defective?
> **Solution**:
> We shall let $A$ be the event that the first fuse is defective and $B$ the event that second fuse is defective; then we interpret $A\cap B$ as the event that $A$ occurs and then $B$ occurs after $A$ has occurred. The probability of first removing a defective fuse is $1/4$; then the probability of removing a second defective fuse from the remaining $4$ is $4/19$. Hence,
> $$P(A\cap B)=\dfrac{1}{4}\cdot \dfrac{4}{19}=\boxed {
> \dfrac{1}{19}
>  }$$

# Bayesian Statistics

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
 >$$P(A)=\sum_{i=1}^{m}P({B}_{i}\cap A)=\sum_{i=1}^{m}P({B}_{i})P(A|{B}_{i}) $$

![[{27CC9365-1C28-47F2-9B1C-1DDF88A7A685}.png|bookhue|500]]
>Partitioning the sample space $\Omega$. [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]].

>[!example] Example: 
> In a certain assembly plant, three machines, ${B}_{1},{B}_{2}$ and ${B}_{3}$, make $30\%,45\%$, and $25\%$, respectively, of the products. It is known from past experience that $2\%,3\%$ and $2\%$ of the products made by each machine, respectively, are defective. Now, suppose that a finished product is randomly selected. What is the probability that it is defective?
> 
> **Solutions**:
> Consider the following events:
> - $A$ - the product is defective
> - ${B}_{1}$ - the product is made by machine ${B}_{1}$,
> - ${B}_{2}$ - the product is made by machine ${B}_{2}$,
> - ${B}_{3}$ - the product is made by machine ${B}_{3}$
> 
> Applying the rule of elimination, we can write
> $$P(A)=P({B}_{1})P(A|{B}_{1})+P({B}_{2})P(A|{B}_{2})+P({B}_{3})P(A|{B}_{3})$$
> ![[{CB5D26FF-2E0F-4EF8-A72F-D58E2E8A0248}.png|bookhue|400]]
> >Tree diagram for the example above.
> 
> Referring to the tree diagram of the figure above, we find that the three branches give the probabilities
> $$\begin{aligned}
>  & P({B}_{1})P(A|{B}_{1})=0.3\cdot 0.02=0.006 \\[1ex]
>  & P({B}_{2})P(A|{B}_{2})=0.45\cdot 0.03=0.0135 \\[1ex]
>  & P({B}_{3})P(A|{B}_{3})=0.25\cdot 0.02=0.005
> \end{aligned}$$
> and hence
> $$P(A)=0.006+0.0135+0.005=0.0245$$


## Bayes' Rule
Instead of asking for $P(A)$ in the example above, by the rule of eliminations, suppose that we now consider the problem of finding the conditional probability $P({B}_{i}|A)$. In other words, supposed that a product was randomly selected and it is defective. What is the probability that this product was made by machine ${B}_{i}$? Questions of this type can be answered by using the following theorem, called **Bayes' rule**:


>[!theorem] Theorem: 
 >If the events ${B}_{1},{B}_{2},\dots,{B}_{k}$ constitute a partition of the sample space $\Omega$ such that $P({B}_{i})\neq 0$ for $i=1,2,\dots,k$, then for any event $A$ in $\Omega$ such that $P(A)\neq 0$,
 >$$P({B}_{r}|A)=\dfrac{P({B}_{r}\cap A)}{\sum _{i=1}^{k}P({B}_{i}\cap A)}=\dfrac{P({B}_{r})P(A|{B}_{r})}{\sum _{i=1}^{k}P({B}_{i})P(A|{B}_{i})},\qquad  r=1,2,\dots ,k$$

![](https://www.youtube.com/watch?v=HZGCoVF3YvM)



>[!example] Example: 
> A medical test has a $0.95$ sensitivity (i.e., detects the disease in $95\%$ of people who have it) and $0.92$ specificity (i.e., does not detect the disease in $92\%$ of people who do not have it).
> 
> If $2\%$ of the population have this disease (a $0.02$ prevalence), what is the probability that a person who tests positive has the disease (this is called the “positive predictive value”)?
> 
> 
> **Solution**:
> Let
> - $T$ - positive test result
> - $D$ - disease
> 
> Therefore, we know that:
> $$\begin{aligned}
>  & P(T|D)=0.95, &  & P(T^{c}|D^{c})=0.92,\qquad P(D)=0.02
> \end{aligned}$$
> So that:
> $$P(T|D^{c})=0.08,\qquad P(D^{c})=0.98$$
> 
> We want to know what's the probability of $D$ knowing $T$. Using Bayes' rule:
> $$\begin{aligned}
>  P(D|T) & =\dfrac{P(D\cap T)}{P(D\cap T)+P(D^{c}\cap T^{})} \\[1ex]
>  & =\dfrac{P(D)P(T|D)}{P(D)P(T|D)+P(D^{c})P(T^{}|D^{c})} \\[1ex]
>  & = \dfrac{0.95\cdot 0.02}{(0.95\cdot 0.05)+(0.08\cdot 0.98)} \\[1ex]
>  & =\dfrac{0.019}{0.019+0.0784} \\[1ex]
>  & =\boxed {
> 0.195
>  }
> \end{aligned}$$
> 
> ![](https://www.youtube.com/watch?v=R13BD8qKeTg&t=67s)
![](https://www.youtube.com/watch?v=lG4VkPoG3ko)
> 

# Exercises
## Question 1
$A$ and $B$ are 2 disjoined events. The following probabilities are given:
$$\begin{aligned}
P(A)=0.3, &  & P(B)=0.4
\end{aligned}$$
Calculate:
1. $P(A^{c}\cap B^{c})$
2. $P(A^{c}\cup B)$

**Solution**:
1. Using the [[#Various Set Operations]]:
	$$\begin{aligned}
	P(A^{c}\cap B^{c}) & =P([A\cup B]^{c}) \\[1ex]
	& =1-P(A\cup B) \\[1ex]
	&=1-P(A)-P(B) \\[1ex]
	& =\boxed {0.3}
	\end{aligned}$$
	Where $P(A\cup B)=P(A)+P(B)$ because $A$ and $B$ are disjointed.
2. Using the [[#Various Set Operations]]:
	$$\begin{aligned}
	P(A^{c}\cup B) & =P(A^{c})+P(B)-P(A^{c}\cap B) \\[1ex]
	 & =0.7+0.4-P(B) \\[1ex]
	 & =\boxed {
	0.7
	 }
	\end{aligned}$$
	Where $P(A^{c}\cap B)=P(B)$ because $A$ and $B$ are disjointed.

## Question 2
The chance of a student to solve:
- question 1 correctly is $0.9$. 
- question 3 correctly is $0.8$.
- both questions correctly is $0.75$.

### Part a
What is the chance of a student to solve at least one question correctly?

**Solution**:
Let's denote:
- $A$ solving question 1 correctly.
- $B$ solving question 3 correctly.

We know that:
$$P(A)=0.9,\qquad P(B)=0.8,\qquad P(A\cap B)=0.75$$
Solving at least one question correctly corresponds to "$A$ or $B$", which is $A\cup B$. Therefore:
$$\begin{aligned}
P(A\cup B) & =P(A)+P(B)-P(A\cap B) \\[1ex]
 & =0.9+0.8-0.75 \\[1ex]
 & =\boxed {
0.95
 }
\end{aligned}$$
### Part b
What is the chance of a student to solve none of the questions correctly?

**Solution**:
Solving at none of the questions correctly corresponds to "not $A$ and not $B$", which is $A^{c}\cap B^{c}$. Therefore:
$$\begin{aligned}
P(A^{c}\cap B^{c}) & =P([A\cup B]^{c}) \\[1ex]
 & =1-P(A\cup B) \\[1ex]
 & =1-0.75 \\[1ex]
 & =\boxed {
0.25
 }
\end{aligned}$$
### Part c
What is the chance of a student to solve only one question correctly?

**Solution**:
Solving only one question correctly corresponds to "$A$ xor $B$", which is $[A\cap B^{c}]\cup[A^{c}\cap B]$. Therefore:
$$\begin{align}
P([A\cap B^{c}]\cup[A^{c}\cap B]) & =P(A\cap B^{c})+P(A^{c}\cap B)-\cancel{ P([A\cap B^{c}]\cap[A^{c}\cap B]) } \\[1ex]
 & =P(A\cap B^{c})+P(A^{c}\cap B)
\end{align}$$
We know that $A=[A\cap B]\cup[A\cap B^{c}]$. Therefore:
$$\begin{gathered}
P(A) =P([A\cap B]\cup[A\cap B^{c}]) \\[1ex]
  P(A)=P(A\cap B)+P(A\cap B^{c})-\cancel{ P([A\cap B]\cap[A\cap B^{c}]) } \\[1ex]
P(A\cap B^{c})=P(A)-P(A\cap B)
\end{gathered}$$
Substituting known values we can see that:
$$\begin{aligned}
P(A\cap B^{c}) & =0.9-0.75 \\[1ex]
 & =0.15
\end{aligned}$$
Doing the same for $P(A^{c}\cap B)$, we can solve the problem. Daniel didn't want to do it.

## Question 3
In how many ways can we choose two people with different nationalities, given out of a group of $7$ French, 10 Italians , and 5 English?

**Solution**:
If there were only $7$ French and $10$ Italians, then there would simply be $7\cdot 10=70$ ways of performing the given operation. If there were only the Italians and English, it would be $50$ different ways. With only the French and the English, there are $35$ different ways. Now, simply summing it all up, there are $70+50+35=\boxed{155 }$  ways for the given operation to be performed.

## Question 4
Out of $10$ tenants in a common building, a committee contains $6$ representatives. How many options of representatives are there:
- With no limitation.
- If $2$ tenants cannot be together due to a conflict.

**Solution**:
In the case where there is no limitation, we can simple calculate using a [[#Combination|theorem]]:
$$\binom{10}{6}=\dfrac{10!}{6!(10-6)!}=\boxed{210 }$$

In the second case, the problem is a bit more complicated. We can separate it to three different situations:
1. None of special tenants are in the committee.
2. The first special tenant is in the committee.
3. The second special tenant is in the committee.

For the first situation, we simply use the same theorem again, but now we have $8$ people to choose from instead of $10$:
$$\binom{8}{6}=\dfrac{8!}{6!(8-6)!}=28$$

For the second situation, we now already know one of tenants in the committee, so we have $5$ more to choose. We also have $8$ people to choose from, because one was already chosen, and another we can't choose. Therefore:
$$\binom{8}{5}=\dfrac{8!}{5!(8-5)!}=56$$

The third situation is exactly the same as the second one, so we have another $56$.
Summing all the different options, we get $56+56+28=\boxed{140 }$ different options for representatives.

## Question 5
Consider a bag containing $7$ red balls, 8 white and $5$ black. How many ways of arranging the $20$ balls are there, in a row, while all the black balls are together?

**Solution**:
The basic formula is $n!$ (i.e., there are $n!$ [[#Permutation|permutations]]). So we could say we have $20$ balls, and therefore there are $20!$ permutations. Now we need to subtract from that all the cases where the black balls aren't together. That's a bit problematic.
Another thing we can try is to treat all the black balls as one group - just as a single ball. Doing that, we get $(7+8+1)!=16!$ permutations.
These permutations contain repeated elements ($7$ reds and $8$ whites), so the number of ways to arrange these $16$ items is:
$$\dfrac{16!}{7!8!}=\boxed {
\pu {102960 }
 }$$

## Question 6
Drinking cups are produced in a $2$-step process: shaping and painting. Experience shows that $70\%$ of the cups are properly shaped.
The probability that a deformed cup is properly painted is $0.2$. A properly shaped cup will be properly painted with $0.95$ probability.

### Part a
What is the probability that a random cup produced is properly shaped but improperly painted?

**Solution**:
Let's denote
- $S$: cup is properly shaped.
- $A$: cup is properly painted.

We are given that:
$$\begin{aligned}
 & P(S)=0.7, &  & P(S^{c})=0.3 \\[1ex]
 & P(A|S^{c})=0.2, &  & P(A^{c}|S^{c})=0.8 \\[1ex]
 & P(A|S)=0.95, &  & P(A^{c}|S)=0.05
\end{aligned}$$

We need to find $P(S\cap A^{c})$.
![[PSM1_001 Introduction and Probability 2025-04-21 13.59.08.excalidraw.svg]]
>Probability tree for the given problem.

From the tree above, and from the [[#The Multiplicative Rule|the multiplication rule]], we see that:
$$\begin{aligned}
P(S\cap A^{c}) & =P(S)\cdot P(A^{c}) \\[1ex]
 & =0.7\cdot 0.05 \\[1ex]
 & =\boxed {
0.035
 }
\end{aligned}$$


### Part b
What is the probability that a cup is properly painted?

**Solution**:
Using the [[#Total Probability|total probability rule]]:
$$\begin{aligned}
P(A) & =P(S\cap A)+P(S^{c}\cap A) \\[1ex]
 & =P(A)P(A|S)+P(A)P(A|S^{c}) \\[1ex]
 & =0.7\cdot 0.95+0.3\cdot 0.2 \\[1ex]
 & =\boxed{0.725 }
\end{aligned}$$

### Part c
If a cup is improperly painted, what is the probability it is properly shaped?

**Solution**:
We need to find $P(S|A^{c})$. Using [[#Bayes' Rule|bayes' rule]]:
$$\begin{aligned}
P(S|A^{c}) & =\dfrac{P(A^{c}|S)P(A^{c})}{P(S)} \\[1ex]
 & =\dfrac{0.05\cdot(1-P(A))}{0.7} \\[1ex]
 & =\dfrac{0.05\cdot 0.275}{0.7} \\[1ex]
 & =\boxed {
0.01964
 }
\end{aligned}$$

