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

![[{DC268415-8EBA-4BFC-B27C-642D92D32162}.png|bookhue|300]]
>Additive rule of probability. [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]].


>[!theorem] Theorem: 
 >If $A$ and $B$ are disjoint, then
 >$$P(A\cup B)=P(A)+P(B)$$

>[!theorem] Theorem: 
 >If ${A}_{1},{A}_{2},\dots,{A}_{m}$ are mutually exclusive, then
 >$$P({A}_{1}\cup {A}_{2}\cup\dots \cup {A}_{m})=\sum_{i=1}^{m}P({A}_{i}) $$



> [!tip] Tip:
> When in doubt, consider a Venn diagram.

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

>[!TODO] TODO: להשלים

## Total Probability
>[!theorem] Theorem: 
 >If the events ${B}_{1},{B}_{2},\dots,{B}_{k}$ constitute a partition of the sample space $\Omega$ such that $P({B}_{i})\neq 0$ for $i=1,2,\dots,k$, then for any event $A$ of $\Omega$,
 >$$P(A)=\sum_{i=1}^{m}P({B}_{i}\cap A)=\sum_{i=1}^{m}P({B}_{i})P(A|{B}_{i})  $$

