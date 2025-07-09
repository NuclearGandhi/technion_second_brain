---
aliases:
  - linear regression
  - correlation
  - regression model
  - fitted regression line
  - least squares
  - regression coefficients
  - error variance
  - residual variance
---

# Introduction to Linear Regression

Often, in practice, one is called upon to solve problems involving sets of variables when it is known that there exists some inherent relationship among the variables. For example, in an industrial situation it may be known that the tar content in the outlet stream in a chemical process is related to the inlet temperature. It may be of interest to develop a method of prediction, that is, a procedure for estimating the tar content for various levels of the inlet temperature from experimental information.

Now, of course, it is highly likely that for many example runs in which the inlet temperature is the same, say $130^{\circ}\pu{C}$, the outlet tar content will not be the same. This is much like what happens when we study several automobiles with the same engine volume. They will not all have the same gas mileage. Houses in the same part of the country that have the same square footage of living space will not all be sold for the same price.

Tar content, gas mileage, and the price of houses (in thousands of dollars) are natural **dependent variables**, or **responses**, in these three scenarios. Inlet temperature, engine volume (cubic feet), and square feet of living space are, respectively, natural **independent variables**, or **regressors**.

A reasonable form of a relationship between the response $Y$ and the regressor $x$ is the linear relationship

$$Y = \beta_0 + \beta_1 x$$

where, of course, $\beta_0$ is the intercept and $\beta_1$ is the slope. The relationship is illustrated in the following figure:

![[{45EBAD15-A858-4FAE-96BD-F12FD2C01FDC}.png|bookhue|500]]
>A linear relationship; $\beta_0$: intercept; $\beta_1$: slope. [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]].

If the relationship is exact, then it is a **deterministic relationship** between two scientific variables and there is no random or probabilistic component to it. However, in the examples listed above, as well as in countless other scientific and engineering phenomena, the relationship is not deterministic (i.e., a given $x$ does not always give the same value for $Y$). As a result, important problems here are probabilistic in nature since the relationship above cannot be viewed as being exact.

The concept of **regression analysis** deals with finding the best relationship between $Y$ and $x$, quantifying the strength of that relationship, and using methods that allow for prediction of the response values given values of the regressor $x$.

In many applications, there will be more than one regressor (i.e., more than one independent variable that helps to explain $Y$). For example, in the case where the response is the price of a house, one would expect the age of the house to contribute to the explanation of the price, so in this case the **multiple regression** structure might be written

$$Y = \beta_0 + \beta_1 x_1 + \beta_2 x_2$$

where $Y$ is price, $x_1$ is square footage, and $x_2$ is age in years.

As a second illustration of multiple regression, a chemical engineer may be concerned with the amount of hydrogen lost from samples of a particular metal when the material is placed in storage. In this case, there may be two inputs, storage time $x_1$ in hours and storage temperature $x_2$ in degrees centigrade. The response would then be hydrogen loss $Y$ in parts per million.

In this chapter, we deal with the topic of **simple linear regression**, treating only the case of a single regressor variable in which the relationship between $y$ and $x$ is linear.

Denote a random sample of size $n$ by the set $\{(x_i, y_i); i = 1, 2, \ldots, n\}$. If additional samples were taken using exactly the same values of $x$, we should expect the $y$ values to vary. Hence, the value $y_i$ in the ordered pair $(x_i, y_i)$ is a value of some random variable $Y_i$.

# The Simple Linear Regression (SLR) Model

We have already confined the terminology regression analysis to situations in which relationships among variables are not deterministic (i.e., not exact). In other words, there must be a random component to the equation that relates the variables.

This random component takes into account considerations that are not being measured or, in fact, are not understood by the scientists or engineers. Indeed, in most applications of regression, the linear equation, say $Y = \beta_0 + \beta_1 x$, is an approximation that is a simplification of something unknown and much more complicated.

For example, in our illustration involving the response $Y =$ tar content and $x =$ inlet temperature, $Y = \beta_0 + \beta_1 x$ is likely a reasonable approximation that may be operative within a confined range on $x$. More often than not, the models that are simplifications of more complicated and unknown structures are linear in nature (i.e., linear in the parameters $\beta_0$ and $\beta_1$ or, in the case of the model involving the price, size, and age of the house, linear in the parameters $\beta_0$, $\beta_1$, and $\beta_2$). These linear structures are simple and empirical in nature and are thus called **empirical models**.

## Statistical Model Definition

An analysis of the relationship between $Y$ and $x$ requires the statement of a statistical model. A model is often used by a statistician as a representation of an ideal that essentially defines how we perceive that the data were generated by the system in question. The model must include the set $\{(x_i, y_i); i = 1, 2, \ldots, n\}$ of data involving $n$ pairs of $(x, y)$ values.

One must bear in mind that the value $y_i$ depends on $x_i$ via a linear structure that also has the random component involved. The basis for the use of a statistical model relates to how the random variable $Y$ moves with $x$ and the random component. The model also includes what is assumed about the statistical properties of the random component.

>[!def] Definition:
>The response $Y$ is related to the independent variable $x$ through the equation
>$$Y = \beta_0 + \beta_1 x + \varepsilon$$
>
>In the above, $\beta_0$ and $\beta_1$ are unknown intercept and slope parameters, respectively, and $\varepsilon$ is a random variable that is assumed to be distributed with $E(\varepsilon) = 0$ and $\text{Var}(\varepsilon) = \sigma^2$. The quantity $\sigma^2$ is often called the **error variance** or **residual variance**.

From the model above, several things become apparent:

1. The quantity $Y$ is a random variable since $\varepsilon$ is random.
2. The value $x$ of the regressor variable is not random and, in fact, is measured with negligible error.
3. The quantity $\varepsilon$, often called a **random error** or **random disturbance**, has constant variance. This portion of the assumptions is often called the **homogeneous variance assumption**.
4. The presence of this random error, $\varepsilon$, keeps the model from becoming simply a deterministic equation.

Now, the fact that $E(\varepsilon) = 0$ implies that at a specific $x$ the $y$-values are distributed around the true, or population, regression line $y = \beta_0 + \beta_1 x$. If the model is well chosen (i.e., there are no additional important regressors and the linear approximation is good within the ranges of the data), then positive and negative errors around the true regression are reasonable.

>[!notes] Important Note:
>We must keep in mind that in practice $\beta_0$ and $\beta_1$ are not known and must be estimated from data. In addition, the model described above is conceptual in nature. As a result, we never observe the actual $\varepsilon$ values in practice and thus we can never draw the true regression line (but we assume it is there). We can only draw an estimated line.

The following figure depicts the nature of hypothetical $(x, y)$ data scattered around a true regression line for a case in which only $n = 5$ observations are available:

![[{288D6D95-CB4E-4C93-BA2C-3DA437E29FBA}.png|bookhue|500]]^figure-hypothetical-data
>Hypothetical $(x, y)$ data scattered around the true regression line for $n = 5$. [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]].

Let us emphasize that what we see in this figure is not the line that is used by the scientist or engineer. Rather, the picture merely describes what the assumptions mean! The regression that the user has at his or her disposal will now be described.

## The Fitted Regression Line

An important aspect of regression analysis is, very simply, to estimate the parameters $\beta_0$ and $\beta_1$ (i.e., estimate the so-called **regression coefficients**). The method of estimation will be discussed in the next section. Suppose we denote the estimates $b_0$ for $\beta_0$ and $b_1$ for $\beta_1$. Then the estimated or **fitted regression line** is given by

$$\hat{y} = b_0 + b_1 x$$

where $\hat{y}$ is the **predicted** or **fitted value**. Obviously, the fitted line is an estimate of the true regression line. We expect that the fitted line should be closer to the true regression line when a large amount of data are available.

In the following example, we illustrate the fitted line for a real-life pollution study. One of the more challenging problems confronting the water pollution control field is presented by the tanning industry. Tannery wastes are chemically complex. They are characterized by high values of chemical oxygen demand, volatile solids, and other pollution measures.

Consider the experimental data in the following table, which were obtained from 33 samples of chemically treated waste in a study conducted at Virginia Tech. Readings on $x$, the percent reduction in total solids, and $y$, the percent reduction in chemical oxygen demand, were recorded.

| Solids Reduction, $x$ (%) | Oxygen Demand Reduction, $y$ (%) | Solids Reduction, $x$ (%) | Oxygen Demand Reduction, $y$ (%) |
| :-----------------------: | :------------------------------: | :-----------------------: | :------------------------------: |
|             3             |                5                 |            36             |                34                |
|             7             |                11                |            37             |                36                |
|            11             |                21                |            38             |                38                |
|            15             |                16                |            39             |                37                |
|            18             |                16                |            39             |                36                |
|            27             |                28                |            39             |                45                |
|            29             |                27                |            40             |                39                |
|            30             |                25                |            41             |                41                |
|            30             |                35                |            42             |                40                |
|            31             |                30                |            42             |                44                |
|            31             |                40                |            43             |                37                |
|            32             |                32                |            44             |                44                |
|            33             |                34                |            45             |                46                |
|            33             |                32                |            46             |                46                |
|            34             |                34                |            47             |                49                |
|            36             |                37                |            50             |                51                |
|            36             |                38                |                           |                                  |
>Measures of Reduction in Solids and Oxygen Demand

The data from this table are plotted in a scatter diagram in the following figure:

![[{FF4841B9-D691-4EA0-9328-8825F217EE40}.png|bookhue|600]]
>Scatter diagram with regression lines. [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]].

From an inspection of this scatter diagram, it can be seen that the points closely follow a straight line, indicating that the assumption of linearity between the two variables appears to be reasonable.

The fitted regression line and a hypothetical true regression line are shown on the scatter diagram.

## Another Look at the Model Assumptions

It may be instructive to revisit the simple linear regression model presented previously and discuss in a graphical sense how it relates to the so-called true regression. Let us expand on the [[#^figure-hypothetical-data|figure]] by illustrating not merely where the $\varepsilon_i$ fall on a graph but also what the implication is of the normality assumption on the $\varepsilon_i$.

Suppose we have a simple linear regression with $n = 6$ evenly spaced values of $x$ and a single $y$-value at each $x$. Consider the graph in the following figure:

![[{A009A778-7C30-4E7A-A7A6-075BEBDF9CDA}.png|bookhue|600]]
>Individual observations around true regression line. [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]].

This illustration should give the reader a clear representation of the model and the assumptions involved. The line in the graph is the true regression line. The points plotted are actual $(y, x)$ points which are scattered about the line. Each point is on its own normal distribution with the center of the distribution (i.e., the mean of $y$) falling on the line.

This is certainly expected since $E(Y) = \beta_0 + \beta_1 x$. As a result, the true regression line goes through the means of the response, and the actual observations are on the distribution around the means. Note also that all distributions have the same variance, which we referred to as $\sigma^2$.

Of course, the deviation between an individual $y$ and the point on the line will be its individual $\varepsilon$ value. This is clear since

$$y_i - E(Y_i) = y_i - (\beta_0 + \beta_1 x_i) = \varepsilon_i$$

Thus, at a given $x$, $Y$ and the corresponding $\varepsilon$ both have variance $\sigma^2$.

>[!notes] Note:
>We have written the true regression line here as $\mu_{Y|x} = \beta_0 + \beta_1 x$ in order to reaffirm that the line goes through the mean of the $Y$ random variable.

# Least Squares and the Fitted Model

In this section, we discuss the method of fitting an estimated regression line to the data. This is tantamount to the determination of estimates $b_0$ for $\beta_0$ and $b_1$ for $\beta_1$. This of course allows for the computation of predicted values from the fitted line $\hat{y} = b_0 + b_1 x$ and other types of analyses and diagnostic information that will ascertain the strength of the relationship and the adequacy of the fitted model.

Before we discuss the method of least squares estimation, it is important to introduce the concept of a residual. A residual is essentially an error in the fit of the model $\hat{y} = b_0 + b_1 x$.

## Residual: Error in Fit

Given a set of regression data $\{(x_i, y_i); i = 1, 2, \ldots, n\}$ and a fitted model, $\hat{y}_i = b_0 + b_1 x_i$, the $i$-th residual $e_i$ is given by

>[!def] Definition:
>$$e_i = y_i - \hat{y}_i, \quad i = 1, 2, \ldots, n$$

Obviously, if a set of $n$ residuals is large, then the fit of the model is not good. Small residuals are a sign of a good fit. Another interesting relationship which is useful at times is the following:

$$y_i = b_0 + b_1 x_i + e_i$$

The use of the above equation should result in clarification of the distinction between the residuals, $e_i$, and the conceptual model errors, $\varepsilon_i$. One must bear in mind that whereas the $\varepsilon_i$ are not observed, the $e_i$ not only are observed but also play an important role in the total analysis.

The following figure depicts the line fit to this set of data, namely $\hat{y} = b_0 + b_1 x$, and the line reflecting the model $\mu_{Y|x} = \beta_0 + \beta_1 x$. Now, of course, $\beta_0$ and $\beta_1$ are unknown parameters. The fitted line is an estimate of the line produced by the statistical model. Keep in mind that the line $\mu_{Y|x} = \beta_0 + \beta_1 x$ is not known.

![[{3956C0A0-1A8D-49B4-9DDB-9688ABF90A3B}.png|bookhue|600]]^figure-residuals-comparison
>Comparing $\varepsilon_i$ with the residual, $e_i$. [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]].

## The Method of Least Squares

We shall find $b_0$ and $b_1$, the estimates of $\beta_0$ and $\beta_1$, so that the sum of the squares of the residuals is a minimum. The residual sum of squares is often called the **sum of squares of the errors about the regression line** and is denoted by $\text{SSE}$. This minimization procedure for estimating the parameters is called the **method of least squares**.

Hence, we shall find $b_0$ and $b_1$ so as to minimize

$$\text{SSE} = \sum_{i=1}^{n} e_i^2 = \sum_{i=1}^{n} (y_i - \hat{y}_i)^2 = \sum_{i=1}^{n} (y_i - b_0 - b_1 x_i)^2$$

Differentiating SSE with respect to $b_0$ and $b_1$, we have

$$\begin{aligned}
\frac{\partial(\text{SSE})}{\partial b_0} &= -2 \sum_{i=1}^{n} (y_i - b_0 - b_1 x_i) \\[1ex]
\frac{\partial(\text{SSE})}{\partial b_1} &= -2 \sum_{i=1}^{n} (y_i - b_0 - b_1 x_i) x_i
\end{aligned}$$

Setting the partial derivatives equal to zero and rearranging the terms, we obtain the equations (called the **normal equations**):

$$\begin{aligned}
 & n b_0 + b_1 \sum_{i=1}^{n} x_i = \sum_{i=1}^{n} y_i \\[1ex]
 & b_0 \sum_{i=1}^{n} x_i + b_1 \sum_{i=1}^{n} x_i^2 = \sum_{i=1}^{n} x_i y_i
\end{aligned}$$

which may be solved simultaneously to yield computing formulas for $b_0$ and $b_1$.

## Estimating the Regression Coefficients


>[!formula] Formula: Least Squares Estimators:
>Given the sample $\{(x_i, y_i); i = 1, 2, \ldots, n\}$, the least squares estimates $b_0$ and $b_1$ of the regression coefficients $\beta_0$ and $\beta_1$ are computed from the formulas:
>$$b_1 = \frac{n \sum_{i=1}^{n} x_i y_i - \left(\sum_{i=1}^{n} x_i\right)\left(\sum_{i=1}^{n} y_i\right)}{n \sum_{i=1}^{n} x_i^2 - \left(\sum_{i=1}^{n} x_i\right)^2} = \frac{\sum_{i=1}^{n} (x_i - \overline{x})(y_i - \overline{y})}{\sum_{i=1}^{n} (x_i - \overline{x})^2}$$
>
>and
>
>$$b_0 = \frac{\sum_{i=1}^{n} y_i - b_1 \sum_{i=1}^{n} x_i}{n} = \overline{y} - b_1 \overline{x}$$

The calculations of $b_0$ and $b_1$, using the data from the pollution study, are illustrated by the following example.

>[!example] Example: Estimate the regression line for the pollution data
>Estimate the regression line for the pollution data from the table presented earlier.
>
>**Solution:**
>From the data with $n = 33$ observations:
>$$\begin{aligned}
 & \sum_{i=1}^{33} x_i = 1104, &  & 
\sum_{i=1}^{33} y_i = 1124, \\[1ex]
 & \sum_{i=1}^{33} x_i y_i = 41,355, &  & 
 \sum_{i=1}^{33} x_i^2 = 41,086
\end{aligned}$$
>
>Therefore,
>$$\begin{aligned}
b_1 &= \frac{(33)(41,355) - (1104)(1124)}{(33)(41,086) - (1104)^2} \\[1ex]
&= 0.903643
\end{aligned}$$
>
>and
>$$\begin{aligned}
b_0 &= \frac{1124 - (0.903643)(1104)}{33} \\[1ex]
&= 3.829633
\end{aligned}$$
>
>Thus, the estimated regression line is given by
>$$\hat{y} = 3.8296 + 0.9036x$$

Using the regression line from this example, we would predict a $31\%$ reduction in the chemical oxygen demand when the reduction in the total solids is $30\%$. The $31\%$ reduction in the chemical oxygen demand may be interpreted as an estimate of the population mean $\mu_{Y|30}$ or as an estimate of a new observation when the reduction in total solids is $30\%$.

Such estimates, however, are subject to error. Even if the experiment were controlled so that the reduction in total solids was $30\%$, it is unlikely that we would measure a reduction in the chemical oxygen demand exactly equal to $31\%$. In fact, the original data show that measurements of $25\%$ and $35\%$ were recorded for the reduction in oxygen demand when the reduction in total solids was kept at $30\%$.

# Properties of the Least Squares Estimators

## Model With Only Y (Before X Enters)

Before considering the regressor $x$ to explain $Y$, we start with the simplest model where $Y$ varies purely due to random fluctuations. In this case, our estimate of the mean response is simply the average of the $Y$ values:

$$\hat{\mu}_Y = \overline{y} = \frac{1}{n}\sum_{i=1}^{n} y_i$$

This serves as our alternative to any model involving $x$ (or several $x$'s in multiple regression). When we introduce a regressor, we're essentially asking: "Can $x$ explain the variation in $Y$ better than just using the overall mean?"

## Distributional Properties of the Estimators

In addition to the assumptions that the error term in the model $Y_i = \beta_0 + \beta_1 x_i + \varepsilon_i$ is a random variable with mean $0$ and constant variance $\sigma^2$, suppose that we make the further assumption that $\varepsilon_1, \varepsilon_2, \ldots, \varepsilon_n$ are independent from run to run in the experiment.

The values $b_0$ and $b_1$, based on a given sample of $n$ observations, are only estimates of true parameters $\beta_0$ and $\beta_1$. If the experiment is repeated over and over again, each time using the same fixed values of $x$, the resulting estimates will most likely differ from experiment to experiment.

The distributional assumptions imply that the $Y_i$, $i = 1, 2, \ldots, n$, are also independently distributed, with mean $\mu_{Y|x_i} = \beta_0 + \beta_1 x_i$ and equal variances $\sigma^2$.

The least squares estimators have the following properties:
For the slope estimator $B_1$:
- **Mean:** $\mu_{B_1} = \beta_1$ (unbiased)
- **Variance:** $\sigma^2_{B_1} = \dfrac{\sigma^2}{S_{xx}}$ where $S_{xx} = \sum_{i=1}^{n}(x_i - \overline{x})^2$
- **Distribution:** $B_1 \sim N\left(\beta_1, \dfrac{\sigma^2}{S_{xx}}\right)$

For the intercept estimator $B_0$:
- **Mean:** $\mu_{B_0} = \beta_0$ (unbiased)
- **Distribution:** $B_0 \sim N\left(\beta_0, \sigma^2_{B_0}\right)$

The point $(\overline{x}, \overline{y})$ is always on the fitted regression line.

The accuracy depends on:
1. **The error variance $\sigma^2$** - smaller is better
2. **The spread of $x$ values $S_{xx}$** - larger spread gives more accurate slope estimates
3. **Sample size $n$** - larger sample gives better estimates

To draw inferences on $\beta_0$ and $\beta_1$, we need an estimate of $\sigma^2$. Using the notation:
- $S_{xx} = \sum_{i=1}^{n}(x_i - \overline{x})^2$
- $S_{yy} = \sum_{i=1}^{n}(y_i - \overline{y})^2$  
- $S_{xy} = \sum_{i=1}^{n}(x_i - \overline{x})(y_i - \overline{y})$

>[!theorem] Theorem: 
>An unbiased estimate of $\sigma^2$ is:
>$$s^2 = \frac{SSE}{n-2} = \frac{\sum_{i=1}^{n}(y_i - \hat{y}_i)^2}{n-2} = \frac{S_{yy} - b_1 S_{xy}}{n-2}$$

The quantity $s^2$ is called the **mean squared error (MSE)**. The divisor $n-2$ represents the degrees of freedom (we subtract 2 because we estimated two parameters: $\beta_0$ and $\beta_1$).

# Inferences Concerning the Regression Coefficients

We can test hypotheses regarding $\beta_0$ and $\beta_1$, and construct confidence intervals. Assuming normality of the errors:

$$T = \frac{B_1 - \beta_1}{s/\sqrt{S_{xx}}}$$

follows a $t$-distribution with $n-2$ degrees of freedom. The statistic $T$ can be used to construct a $100(1-\alpha)\%$ confidence interval for the coefficient ${\beta}_{1}$.

>[!Formula] Formula: Confidence Interval for ${\beta}_{1}$ 
>A $100(1-\alpha)\%$ confidence interval for $\beta_1$ is:
$$b_1 - t_{\alpha/2}\frac{s}{\sqrt{S_{xx}}} < \beta_1 < b_1 + t_{\alpha/2}\frac{s}{\sqrt{S_{xx}}}$$

## Hypothesis Testing on the Slope

To test the null hypothesis ${H}_{0}$ that ${\beta}_{1}={\beta}_{10}$ against a suitable alternative, we again use the $t$-distribution with $n-2$ degrees of freedom to establish a critical region and then base our decision on the value of
$$t=\dfrac{{b}_{1}-{\beta}_{10}}{s/\sqrt{ {S}_{xx} }}$$

One important $t$-test on the slope is the test of the hypothesis
$${H}_{0}:{\beta}_{1}=0\quad \text{vs}\quad   {H}_{1}:{\beta}_{1}\neq 0$$

When the null hypothesis is not rejected, the conclusion is that there is no significant linear relationship between $E(y)$ and the independent variable $x$. The plot of the data for the previous example would suggest that a linear relationship exists. However, in some applications in which $\sigma ^{2}$ is large and thus considerable "noise" is present the data, a plot, while useful, may not produce clear information for the researcher. Rejection of ${H}_{0}$ above implies that a significant linear regression exists.
The $t$-test for the hypothesis above is of the more simple form
$$t= \dfrac{{b}_{1}}{s/\sqrt{ {S}_{xx} }}$$
The failure to reject ${H}_{0}: {\beta}_{1}=0$ suggests that there is no linear relationship between $Y$ and $x$. The following figure is an illustration of the implication of this result. It may mean that changing $x$ has little impact on changes in $Y$, as seen in (a). However, it may also indicate that the true relationship is nonlinear, as indicated by (b).

![[{6A679CD7-B264-4054-890B-438BD05695C2}.png|bookhue|600]]^figure-h0-not-rejected
>The hypothesis ${H}_{0}: {\beta}_{1} = 0$ is not rejected - scenarios where no linear relationship is evident. [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]].

When ${H}_{0}:{\beta}_{1}=0$ is rejected, there is an implication that the linear term in $x$ residing in the model explains a significant portion of variability in $Y$. The two plots in the following figure illustrate possible scenarios. As depicted in (a) of the figure, rejection of ${H}_{0}$ may suggest that the relations is, indeed, linear. As indicated in (b), it may suggest that while the model does contain a linear effect, a better representation may be found by including a polynomial (perhaps quadratic) term (i.e., terms that supplement the linear term).
![[{83248C97-1BFD-4BCE-8810-35EB6A03FAF8}.png|bookhue|600]]^figure-h0-rejected
>The hypothesis H₀: β₁ = 0 is rejected - scenarios showing linear relationships. [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]].

# A Measure of Quality of Fit: Coefficient of Determination

$R^2$ is the proportion of the variation in $Y$ explained by the model:
$$R^2 = \frac{SSR}{SST} = 1 - \frac{SSE}{SST}$$
where $SST = SSR + SSE$:
- $SST = \sum_{i=1}^{n}(y_i - \overline{y})^2$ (Total Sum of Squares)
- $SSR = \sum_{i=1}^{n}(\hat{y}_i - \overline{y})^2$ (Regression Sum of Squares)  
- $SSE = \sum_{i=1}^{n}(y_i - \hat{y}_i)^2$ (Error Sum of Squares)

$SST$ represents the variation in the response values that *ideally* would be explained by the model. The $SSE$ value is the variation due to error, or **variation unexplained**. Clearly, if $SSE=0$, all variation is explained. The quantity that represents variation explained is $SST-SSE$.

Note that if the fit is perfect, *all residuals are zero*, and thus $R^{2}=1.0$. But if $SSE$ is only slightly smaller than $SST$, $R^{2}\approx0$.

![[{76B725E6-44DC-48EF-9119-F1AD3BCE5620}.png|bookhue|600]]^figure-r-squared-good-poor-fit
>Plots depicting a very good fit ($R^{2}\approx 1.0$) and a poor fit ($R^{2} \approx 0$). [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]].

## Pitfalls in the Use of $R^{2}$

**Large $R^2$ does NOT mean "the model is good"**.

Analysts quote values of $R^{2}$ quite often, perhaps due to its simplicity. However, there are pitfalls in its interpretation. The reliability of $R^{2}$ is a function of the size of the regression data set and the type of application. Clearly, $0\leq R^{2}\leq 1$ and the upper bound is achieved when the fit to the data is perfect (i.e., all of the residuals are zero). What is an acceptable value of $R^{2}$? This is a difficult question to answer. A chemist, charged with doing a linear calibration of a high-precision piece of equipment, certainly expects to experience a very high $R^{2}$-value (perhaps exceeding $0.99$), while a behavioral scientist, dealing in data impacted by variability in human behavior, may feel fortunate to experience an $R^{2}$ as large as $0.70$. An experienced model fitter senses when a value is large enough, given the situation confronted. Clearly, some scientific phenomena lend themselves to modeling with more precision than others.

The $R^{2}$ criterion is dangerous to use for comparing *competing models* for the same data set. Adding additional terms to the model (e.g., an additional regressor) decreases $SSE$ and thus increase $R^{2}$ (or at least does not decrease is). This implies that $R^{2}$ can be made artificially high by an unwise practice of **overfitting** (i.e., the inclusion of too many model terms). Thus, the inevitable increase in $R^{2}$ enjoyed by adding an additional term does not imply the additional term was needed. In face, the simple model may be superior for predicting response values.

>[!TODO] TODO: לעבור

# Prediction

There are several reasons for building a linear regression model. One of the most important is to predict response values at one or more values of the independent variable. In this section, we focus on the errors associated with prediction and the construction of appropriate intervals for predicted values.

The fitted regression equation $\hat{y} = b_0 + b_1 x$ may be used for two distinct purposes:

1. **Estimate the mean response** $\mu_{Y|x_0}$ at $x = x_0$, where $x_0$ is a specific value of the regressor
2. **Predict a single future value** $y_0$ of the variable $Y$ when $x = x_0$

We would expect the error of prediction to be higher in the case of predicting a single value than when estimating a mean. This difference will affect the width of our prediction intervals.

## Confidence Interval for the Mean Response

Suppose the experimenter wishes to construct a confidence interval for $\mu_{Y|x_0}$. We use the point estimator $\hat{Y}_0 = B_0 + B_1 x_0$ to estimate $\mu_{Y|x_0} = \beta_0 + \beta_1 x_0$.

It can be shown that the sampling distribution of $\hat{Y}_0$ is normal with:

**Mean:** 
$$\mu_{\hat{Y}_0} = E(\hat{Y}_0) = E(B_0 + B_1 x_0) = \beta_0 + \beta_1 x_0 = \mu_{Y|x_0}$$

**Variance:**
$$\sigma^2_{\hat{Y}_0} = \sigma^2_{B_0 + B_1 x_0} = \sigma^2\left[\frac{1}{n} + \frac{(x_0 - \overline{x})^2}{S_{xx}}\right]$$

This variance formula follows from the fact that $\text{Cov}(\overline{Y}, B_1) = 0$.

Therefore, a $100(1-\alpha)\%$ confidence interval for the mean response $\mu_{Y|x_0}$ can be constructed using the statistic:

$$T = \frac{\hat{Y}_0 - \mu_{Y|x_0}}{s\sqrt{\frac{1}{n} + {(x_0 - \overline{x})^2}/{S_{xx}}}}$$

which follows a $t$-distribution with $n-2$ degrees of freedom.

>[!formula] Formula: Confidence Interval for Mean Response
>A $100(1-\alpha)\%$ confidence interval for the mean response $\mu_{Y|x_0}$ is:
>$$\hat{y}_0 - t_{\alpha/2} s \sqrt{\frac{1}{n} + \frac{(x_0 - \overline{x})^2}{S_{xx}}} < \mu_{Y|x_0} < \hat{y}_0 + t_{\alpha/2} s \sqrt{\frac{1}{n} + \frac{(x_0 - \overline{x})^2}{S_{xx}}}$$
>where $t_{\alpha/2}$ is the critical value from the $t$-distribution with $n-2$ degrees of freedom.

>[!example] Example: Confidence Interval for Mean Response
>Using the pollution data from our previous examples, construct $95\%$ confidence limits for the mean response $\mu_{Y|x_0}$ when $x_0 = 20\%$ solids reduction.
>
>**Solution:**
>From the regression equation, for $x_0 = 20\%$ solids reduction:
>$$\hat{y}_0 = 3.829633 + (0.903643)(20) = 21.9025$$
>
>We have:
>- $\overline{x} = 33.4545$
>- $S_{xx} = 4152.18$ 
>- $s = 3.2295$
>- $t_{0.025} \approx 2.045$ for $31$ degrees of freedom
>- $n = 33$
>
>Therefore, the $95\%$ confidence interval for $\mu_{Y|20}$ is:
>$$\begin{aligned}
>&21.9025 - (2.045)(3.2295)\sqrt{\frac{1}{33} + \frac{(20 - 33.4545)^2}{4152.18}} \\[1ex]
>&< \mu_{Y|20} < \\[1ex] 
>&21.9025 + (2.045)(3.2295)\sqrt{\frac{1}{33} + \frac{(20 - 33.4545)^2}{4152.18}}
>\end{aligned}$$
>
>This simplifies to: $20.1071 < \mu_{Y|20} < 23.6979$
>
>We are $95\%$ confident that the population mean reduction in chemical oxygen demand is between $20.11\%$ and $23.70\%$ when solids reduction is $20\%$.

![[{2AC80BFF-5CA1-4270-877A-DB6A24620938}.png|bookhue|600]]
>Confidence limits for the mean value of $Y|x$, showing the regression line with confidence bands. [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]].

## Prediction Interval for Individual Response

Another type of interval that is often confused with the confidence interval for the mean is the **prediction interval** for a future observed response. In many instances, the prediction interval is more relevant to the scientist or engineer than the confidence interval on the mean.

For example, in practical applications, there is often interest not only in estimating the mean response at a specific $x$ value but also in constructing an interval that reflects the error in predicting a future individual observation at that $x$ value.

To obtain a prediction interval for a single value $y_0$ of the variable $Y_0$, we need to estimate the variance of the difference $\hat{y}_0 - y_0$. We can think of this difference as a value of the random variable $\hat{Y}_0 - Y_0$.

The sampling distribution of $\hat{Y}_0 - Y_0$ is normal with:

**Mean:**
$$\mu_{\hat{Y}_0 - Y_0} = E(\hat{Y}_0 - Y_0) = E[B_0 + B_1 x_0 - (\beta_0 + \beta_1 x_0 + \varepsilon_0)] = 0$$

**Variance:**
$$\sigma^2_{\hat{Y}_0 - Y_0} = \sigma^2\left[1 + \frac{1}{n} + \frac{(x_0 - \overline{x})^2}{S_{xx}}\right]$$

Note the additional "$1$" term in the variance, which accounts for the uncertainty in the individual future observation $Y_0$.

Therefore, a $100(1-\alpha)\%$ prediction interval can be constructed using the statistic:

$$T = \frac{\hat{Y}_0 - Y_0}{s\sqrt{1 + \frac{1}{n} + {(x_0 - \overline{x})^2}/{S_{xx}}}}$$

which follows a $t$-distribution with $n-2$ degrees of freedom.

>[!formula] Formula: Prediction Interval for Individual Response
>A $100(1-\alpha)\%$ prediction interval for a single response $y_0$ is:
>$$\hat{y}_0 - t_{\alpha/2} s \sqrt{1 + \frac{1}{n} + \frac{(x_0 - \overline{x})^2}{S_{xx}}} < y_0 < \hat{y}_0 + t_{\alpha/2} s \sqrt{1 + \frac{1}{n} + \frac{(x_0 - \overline{x})^2}{S_{xx}}}$$
>where $t_{\alpha/2}$ is the critical value from the $t$-distribution with $n-2$ degrees of freedom.

>[!example] Example: Prediction Interval for Individual Response
>Using the pollution data, construct a $95\%$ prediction interval for $y_0$ when $x_0 = 20\%$.
>
>**Solution:**
>We have the same values as before:
>- $n = 33$, $x_0 = 20$, $\overline{x} = 33.4545$
>- $\hat{y}_0 = 21.9025$, $S_{xx} = 4152.18$
>- $s = 3.2295$, $t_{0.025} \approx 2.045$
>
>Therefore, the $95\%$ prediction interval for $y_0$ is:
>$$\begin{aligned}
>&21.9025 - (2.045)(3.2295)\sqrt{1 + \frac{1}{33} + \frac{(20 - 33.4545)^2}{4152.18}} \\[1ex]
>&< y_0 < \\[1ex]
>&21.9025 + (2.045)(3.2295)\sqrt{1 + \frac{1}{33} + \frac{(20 - 33.4545)^2}{4152.18}}
>\end{aligned}$$
>
>This simplifies to: $15.0585 < y_0 < 28.7464$

![[{E1B5A9E7-29EB-44DB-9C89-4CD45DA9DE1F}.png|bookhue|600]]
>Confidence and prediction intervals for the chemical oxygen demand reduction data; inside bands indicate the confidence limits for the mean responses and outside bands indicate the prediction limits for the future responses. [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]].

## Key Differences Between Confidence and Prediction Intervals

>[!notes] Important Distinctions:
>
>**Confidence Interval for Mean Response ($\mu_{Y|x_0}$):**
>- Estimates a population parameter (the mean response)
>- Narrower interval
>- Variance: $\sigma^2\left[\frac{1}{n} + \frac{(x_0 - \overline{x})^2}{S_{xx}}\right]$
>- Interpretation: We are $(1-\alpha) \times 100\%$ confident that the true mean response lies within this interval
>
>**Prediction Interval for Individual Response ($y_0$):**
>- Predicts a future individual observation (not a parameter)
>- Wider interval due to additional uncertainty
>- Variance: $\sigma^2\left[1 + \frac{1}{n} + \frac{(x_0 - \overline{x})^2}{S_{xx}}\right]$
>- Interpretation: There is a $(1-\alpha) \times 100\%$ probability that a future observation will fall within this interval

The key difference is the additional "$1$" in the variance for prediction intervals, which accounts for the inherent variability in individual observations around the regression line.

Both intervals become wider as $x_0$ moves farther from $\overline{x}$, reflecting increased uncertainty when extrapolating away from the center of the data. The plot shows that prediction intervals are consistently wider than confidence intervals, with both being narrowest at $x = \overline{x}$.

# Correlation

Up to this point, we have assumed that the independent regressor variable $x$ is a physical or scientific variable that is measured with negligible error, but not a random variable. In fact, in this context, $x$ is often called a **mathematical variable**. In many applications of regression techniques, it is more realistic to assume that both $X$ and $Y$ are random variables, and the measurements $\{(x_i, y_i); i = 1, 2, \ldots, n\}$ are observations from a population having a joint density function $f(x, y)$.

We shall consider the problem of measuring the relationship between two random variables $X$ and $Y$. For example:
- If $X$ and $Y$ represent the length and circumference of a particular kind of bone in the adult body, we might expect large values of $X$ to be associated with large values of $Y$, and vice versa.
- If $X$ represents the age of a used automobile and $Y$ represents the retail book value, we would expect large values of $X$ to correspond to small values of $Y$.

**Correlation analysis** attempts to measure the strength of such relationships between two variables by means of a single number called a **correlation coefficient**.

## The Bivariate Normal Distribution

In theory, it is often assumed that the conditional distribution $f(y|x)$ of $Y$, for fixed values of $X$, is normal with mean $\mu_{Y|x} = \beta_0 + \beta_1 x$ and variance $\sigma^2_{Y|x} = \sigma^2$, and that $X$ is likewise normally distributed with mean $\mu_X$ and variance $\sigma_X^2$.

The joint density of $X$ and $Y$ is then:

$$\begin{aligned}
f(x, y)  & = n(y|x; \beta_0 + \beta_1 x, \sigma) \cdot n(x; \mu_X, \sigma_X) \\[1ex]
 & =\frac{1}{2\pi\sigma_x\sigma} \exp\left\{-\frac{1}{2}\left[\left(\frac{y - \beta_0 - \beta_1 x}{\sigma}\right)^2 + \left(\frac{x - \mu_X}{\sigma_X}\right)^2\right]\right\}
\end{aligned}$$

for $-\infty < x < \infty$ and $-\infty < y < \infty$.

Let us write the random variable $Y$ in the form:

$$Y = \beta_0 + \beta_1 X + \varepsilon$$

where $X$ is now a random variable independent of the random error $\varepsilon$. Since the mean of the random error is zero, it follows that:

$$\mu_Y = \beta_0 + \beta_1 \mu_X \quad \text{and} \quad \sigma_Y^2 = \sigma^2 + {{{\beta}_{1}}}^{2} \sigma_X^2$$

After substitution and algebraic manipulation, we obtain the **bivariate normal distribution**:

$$\begin{aligned}
f(x, y)  & = \small\frac{1}{2\pi\sigma_X\sigma_Y\sqrt{1-\rho^2}} \\[1ex]
 &\times  \small\exp\left\{-\frac{1}{2(1-\rho^2)}\left[\left(\frac{x-\mu_X}{\sigma_X}\right)^2 - 2\rho\left(\frac{x-\mu_X}{\sigma_X}\right)\left(\frac{y-\mu_Y}{\sigma_Y}\right) + \left(\frac{y-\mu_Y}{\sigma_Y}\right)^2\right]\right\}
\end{aligned}$$

for $-\infty < x < \infty$ and $-\infty < y < \infty$, where:

$$\rho^2 = 1 - \frac{\sigma^2}{\sigma_Y^2} = \frac{{{{\beta}_{1}}}^{2}\sigma_X^2}{\sigma_Y^2}$$

>[!def] Definition:
>The constant $\rho$ is called the **population correlation coefficient** and measures the linear association between two random variables $X$ and $Y$.

Properties of $\rho$:
1. **Range**: $-1 \leq \rho \leq 1$
2. **Zero correlation**: $\rho = 0$ when $\beta_1 = 0$ (no linear relationship)
3. **Perfect correlation**: $\rho = \pm 1$ when $\sigma^2 = 0$ (perfect linear relationship)
   - $\rho = +1$: perfect positive linear relationship
   - $\rho = -1$: perfect negative linear relationship

Values of $\rho$ close to $\pm 1$ imply strong linear association between $X$ and $Y$, whereas values near zero indicate little or no linear correlation.

## The Sample Correlation Coefficient

To obtain a sample estimate of $\rho$, recall from our earlier work that the error sum of squares is:

$$SSE = S_{yy} - b_1 S_{xy}$$

Dividing both sides by $S_{yy}$ and replacing $S_{xy}$ by $b_1 S_{xx}$, we obtain:

$$\frac{{{{b}_{1}}}^{2} S_{xx}}{S_{yy}} = 1 - \frac{SSE}{S_{yy}}$$

Since $S_{yy} \geq SSE$, we conclude that ${{{b}_{1}}}^{2} S_{xx}/S_{yy}$ must be between $0$ and $1$. Consequently, $b_1\sqrt{S_{xx}/S_{yy}}$ must range from $-1$ to $+1$, with:
- Negative values corresponding to lines with negative slopes
- Positive values corresponding to lines with positive slopes
- Values of $\pm 1$ occurring when $SSE = 0$ (perfect linear relationship)

>[!def] Definition: Sample Correlation Coefficient
>The **sample correlation coefficient** (also called the **Pearson product-moment correlation coefficient**) is:
>$$r = b_1\sqrt{\frac{S_{xx}}{S_{yy}}} = \frac{S_{xy}}{\sqrt{S_{xx}S_{yy}}}$$

## Coefficient of Determination

For values of $r$ between $-1$ and $+1$, we must be careful in our interpretation. Values such as $r = 0.3$ and $r = 0.6$ indicate two positive correlations, one stronger than the other, but it is wrong to conclude that $r = 0.6$ indicates a linear relationship twice as good as $r = 0.3$.

However, if we write:

$$r^2 = \frac{S_{xy}^2}{S_{xx}S_{yy}} = \frac{SSR}{S_{yy}}$$

then $r^2$, the **sample coefficient of determination**, represents the proportion of the variation in $S_{yy}$ explained by the regression of $Y$ on $x$.

>[!notes] Important Interpretation:
>$r^2$ expresses the proportion of the total variation in the values of $Y$ that can be accounted for by a linear relationship with the values of $X$.
>
>For example, a correlation of $r = 0.6$ means that $r^2 = 0.36$, or $36\%$, of the total variation in $Y$ is accounted for by the linear relationship with $X$.

>[!example] Example: Forest Products Correlation Study
>In a study of anatomical characteristics of plantation-grown loblolly pine, 29 trees were randomly selected. The data shows specific gravity (g/cm³) and modulus of rupture (kPa). Compute and interpret the sample correlation coefficient.
>
>| Specific Gravity | Modulus of Rupture | Specific Gravity | Modulus of Rupture |
>|:---------------:|:------------------:|:---------------:|:------------------:|
>|      0.414      |      29,186        |      0.581      |      85,156        |
>|      0.383      |      29,266        |      0.557      |      69,571        |
>|      0.399      |      26,215        |      0.550      |      84,160        |
>|      0.402      |      30,162        |      0.531      |      73,466        |
>|      0.442      |      38,867        |      0.550      |      78,610        |
>|      0.422      |      37,831        |      0.556      |      67,657        |
>|      0.466      |      44,576        |      0.523      |      74,017        |
>|      0.500      |      46,097        |      0.602      |      87,291        |
>|      0.514      |      59,698        |      0.569      |      86,836        |
>|      0.530      |      67,705        |      0.544      |      82,540        |
>|      0.569      |      66,088        |      0.557      |      81,699        |
>|      0.558      |      78,486        |      0.530      |      82,096        |
>|      0.577      |      89,869        |      0.547      |      75,657        |
>|      0.572      |      77,369        |      0.585      |      80,490        |
>|      0.548      |      67,095        |              |                    |
>
>**Solution:**
>From the data we find:
>- $S_{xx} = 0.11273$
>- $S_{yy} = 11,807,324,805$  
>- $S_{xy} = 34,422.27572$
>
>Therefore:
>$$r = \frac{34,422.27572}{\sqrt{(0.11273)(11,807,324,805)}} = 0.9435$$
>
>A correlation coefficient of $0.9435$ indicates a very strong positive linear relationship between specific gravity and modulus of rupture. Since $r^2 = 0.8902$, approximately $89\%$ of the variation in modulus of rupture is accounted for by the linear relationship with specific gravity.

## Hypothesis Testing for Correlation

A test of the hypothesis $\rho = 0$ versus an appropriate alternative is equivalent to testing $\beta_1 = 0$ for the simple linear regression model. The $t$-statistic can be written as:

$$t = \frac{r\sqrt{n-2}}{\sqrt{1-r^2}}$$

which follows a $t$-distribution with $n-2$ degrees of freedom.

>[!example] Example: Testing for No Linear Association
>For the forest products data, test the hypothesis that there is no linear association between the variables at $\alpha = 0.05$.
>
>**Solution:**
>1. $H_0: \rho = 0$
>2. $H_1: \rho \neq 0$  
>3. $\alpha = 0.05$
>4. Critical region: $t < -2.052$ or $t > 2.052$ (with 27 degrees of freedom)
>5. Computations: 
>   $$t = \frac{0.9435\sqrt{27}}{\sqrt{1-0.9435^2}} = 14.79, \quad P < 0.0001$$
>6. **Decision:** Reject the hypothesis of no linear association. There is very strong evidence of a linear relationship.

For testing the more general hypothesis $\rho = \rho_0$ against a suitable alternative, if $X$ and $Y$ follow the bivariate normal distribution, we use the transformation:

$$z = \frac{\sqrt{n-3}}{2}\ln\left[\frac{(1+r)(1-\rho_0)}{(1-r)(1+\rho_0)}\right]$$

which follows approximately the standard normal distribution.

>[!example] Example: Testing Specific Correlation Value
>For the forest products data, test $H_0: \rho = 0.9$ against $H_1: \rho > 0.9$ at $\alpha = 0.05$.
>
>**Solution:**
>1. $H_0: \rho = 0.9$
>2. $H_1: \rho > 0.9$
>3. $\alpha = 0.05$  
>4. Critical region: $z > 1.645$
>5. Computations:
>   $$z = \frac{\sqrt{26}}{2}\ln\left[\frac{(1+0.9435)(0.1)}{(1-0.9435)(1.9)}\right] = 1.51, \quad P = 0.0655$$
>6. **Decision:** There is some evidence that $\rho$ does not exceed $0.9$, but not quite significant at the $0.05$ level.

## Important Caveats About Correlation

>[!notes] Critical Points to Remember:
>
>1. **Correlation measures linear relationship only**: A correlation coefficient close to zero indicates lack of **linear** relationship, not necessarily lack of association.
>
>2. **Correlation does not imply causation**: High correlation between two variables does not mean one causes the other.
>
>3. **Model assumptions matter**: Results are only as good as the assumed bivariate normal model.
>
>4. **Preliminary plotting is essential**: Always examine scatter plots before interpreting correlation coefficients.

![[{186BA0F4-816E-49E8-9B62-557C4C570968}.png|bookhue|600]]^figure-correlation-examples
>Scatter diagrams showing: (a) zero correlation with no association, and (b) zero correlation with strong nonlinear relationship. [[PSM1_000 00340058 Probability and Statistics for Mechanical Engineers#Bibliography|(Walpole et al., 2017)]].

A value of the sample correlation coefficient close to zero can result from:
- **Purely random scatter** (Figure a): implying little or no causal relationship
- **Strong nonlinear relationship** (Figure b): where a quadratic or other nonlinear relationship exists

This emphasizes that $r = 0$ implies a lack of **linearity**, not necessarily a lack of association. If a strong quadratic relationship exists between $X$ and $Y$, we can still obtain zero correlation, indicating the need for nonlinear analysis methods.
