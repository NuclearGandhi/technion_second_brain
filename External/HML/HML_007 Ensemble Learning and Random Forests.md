---
aliases:
  - ensemble
---
# Introduction
From [[HML_000 Hands-On Machine Learning#Bibliography|(Géron, 2023)]]:
Suppose you pose a complex question to thousands of random people, then aggregate their answers. In many cases you will find that this aggregated answer is better than an expert’s answer. This is called the **wisdom of the crowd**. Similarly, if you aggregate the predictions of a group of predictors (such as classifiers or regressors), you will often get better predictions than with the best individual predictor. A group of predictors is called an **ensemble**; thus, this technique is called **ensemble learning**, and an ensemble learning algorithm is called an **ensemble method**.

# Voting Classifiers
Suppose you have trained a few classifiers, each one achieving about 80% accuracy. You may have a logistic regression classifier, an SVM classifier, a random forest classifier, a k-nearest neighbors classifier, and perhaps a few more.

![[{AC3F2F18-CA0E-4D18-BE00-605111C12A51}.png|bookhue|500]]
>Training diverse classifiers. [[HML_000 Hands-On Machine Learning#Bibliography|(Géron, 2023)]].

A very simple way to create an even better classifier is to aggregate the predictions of each classifier: the class that gets the most votes is the ensemble’s prediction. This majority-vote classifier is called a **hard voting** classifier.

![[{A1BF8B75-BA08-4CC7-8E8C-5B0191A6816B}.png|bookhue|500]]
>Hard voting classifier predictions. [[HML_000 Hands-On Machine Learning#Bibliography|(Géron, 2023)]].

Somewhat surprisingly, this voting classifier often achieves a higher accuracy than the best classifier in the ensemble. In fact, even if each classifier is a **weak learner** (meaning it does only slightly better than random guessing), the ensemble can still be a **strong learner** (achieving high accuracy), provided there are a sufficient number of weak learners in the ensemble and they are sufficiently diverse.

How is this possible? The following analogy can help shed some light on this mystery. Suppose you have a slightly biased coin that has a 51% chance of coming up heads and 49% chance of coming up tails. If you toss it 1,000 times, you will generally get more or less 510 heads and 490 tails, and hence a majority of heads. If you do the math, you will find that the probability of obtaining a majority of heads after 1,000 tosses is close to 75%. The more you toss the coin, the higher the probability (e.g., with 10,000 tosses, the probability climbs over 97%). This is due to the law of large numbers: as you keep tossing the coin, the ratio of heads gets closer and closer to the probability of heads (51%).
The following figure shows 10 series of biased coin tosses. 

![[Pasted image 20241011154043.png|bscreen]]
>The law of large numbers

You can see that as the number of tosses increases, the ratio of heads approaches 51%. Eventually all 10 series end up so close to 51% that they are consistently above 50%.

Similarly, suppose you build an ensemble containing 1,000 classifiers that are individually correct only 51% of the time (barely better than random guessing). If you predict the majority voted class, you can hope for up to 75% accuracy! However, this is only true if all classifiers are perfectly independent, making uncorrelated errors, which is clearly not the case because they are trained on the same data. They are likely to make the same types of errors, so there will be many majority votes for the wrong class, reducing the ensemble’s accuracy.

Scikit-Learn provides a `VotingClassifier` class that’s quite easy to use: just give it a list of name/predictor pairs, and use it like a normal classifier. Let’s try it on the moon dataset. We will load and split the moons dataset into a training set and a test set, then we’ll create and train a voting classifier composed of three diverse classifiers:

```python
from sklearn.datasets import make_moons
from sklearn.ensemble import RandomForestClassifier, VotingClassifier
from sklearn.linear_model import LogisticRegression
from sklearn.model_selection import train_test_split
from sklearn.svm import SVC

X, y = make_moons(n_samples=500, noise=0.30, random_state=42)
X_train, X_test, y_train, y_test = train_test_split(X, y, random_state=42)

voting_clf = VotingClassifier(
estimators=[
('lr', LogisticRegression(random_state=42)),
('rf', RandomForestClassifier(random_state=42)),
('svc', SVC(random_state=42))
		]
		)
		voting_clf.fit(X_train, y_train)
		```

When you fit a `VotingClassifier`, it clones every estimator and fits the clones. The original estimators are available via the estimators attribute, while the fitted clones are available via the `estimators_` attribute. If you prefer a `dict` rather than a list, you can use `named_estimators` or `named_estimators_` instead. To begin, let’s look at each fitted classifier’s accuracy on the test set:

```python
>>> for name, clf in voting_clf.named_estimators_.items():
> 	print(name, "=", clf.score(X_test, y_test))
> lr = 0.864
> rf = 0.896
> svc = 0.896
> ```

When you call the voting classifier's `predict()` method, it performs hard voting. For example, the voting classifier predicts class 1 for the first instance of the test set, because two out of three classifiers predict that class:

```python
>>> voting_clf.predict(X_test[:1])
> array([1])
>>> [clf.predict(X_test[:1]) for clf in voting_clf.estimators_]
> [array([1]), array([1]), array([0])]
>>> voting_clf.score(X_test, y_test)
> 0.912
> ```

There you have it! The voting classifier outperforms all the individual classifiers.

If all classifiers are able to estimate class probabilities (i.e., if they all have a `predict_proba()` method), then you can tell Scikit-Learn to predict the class with the highest class probability, averaged over all the individual classifiers. This is called **soft voting**. It often achieves higher performance than hard voting because it gives more weight to highly confident votes. All you need to do is set the voting classifier’s voting hyperparameter to "`soft`", and ensure that all classifiers can estimate class probabilities. This is not the case for the SVC class by default, so you need to set its probability hyperparameter to `True` (this will make the SVC class use cross-validation to estimate class probabilities, slowing down training, and it will add a `predict_proba()` method). Let’s try that:

```python
>>> voting_clf.voting = "soft"
>>> voting_clf.named_estimators["svc"].probability = True
>>> voting_clf.fit(X_train, y_train)
>>> voting_clf.score(X_test, y_test)
> 0.92
> ```

# Bagging and Pasting
One way to get a diverse set of classifiers is to use very different training algorithms, as just discussed. Another approach is to use the same training algorithm for every predictor but train them on different random subsets of the training set. When sampling is performed with *replacement* (Imagine picking a card randomly from a deck of cards, writing it down, then placing it back in the deck before picking the next card: the same card could be sampled multiple times), this method is called **bagging** (short for **bootstrap aggregating** ). When sampling is performed without replacement, it is called **pasting**.

In other words, both bagging and pasting allow training instances to be sampled several times across multiple predictors, but only bagging allows training instances to be sampled several times for the same predictor. This sampling and training process is represented in the following figure:

![[{842153AA-7E5E-4B19-A290-768EFA7589D2}.png|bookhue|500]]
>Bagging and pasting involve training several predictors on different random samples of the training set. [[HML_000 Hands-On Machine Learning#Bibliography|(Géron, 2023)]].

Once all predictors are trained, the ensemble can make a prediction for a new instance by simply aggregating the predictions of all predictors. The aggregation function is typically the **statistical mode** for classification (i.e., the most frequent prediction, just like with a hard voting classifier), or the average for regression. Each individual predictor has a higher bias than if it were trained on the original training set, but aggregation reduces both bias and variance. Generally, the net result is that the ensemble has a similar bias but a lower variance than a single predictor trained on the original training set.

## Bagging and Pasting in Scikit-Learn
Scikit-Learn offers a simple API for both bagging and pasting: `BaggingClassifier` class (or `BaggingRegressor` for regression). The following code trains an ensemble of 500 decision tree classifiers: each is trained on 100 training instances randomly sampled from the training set with replacement (this is an example of bagging, but if you want to use pasting instead, just set `bootstrap=False`). The `n_jobs` parameter tells Scikit-Learn the number of CPU cores to use for training and predictions, and –1 tells Scikit-Learn to use all available cores:

```python
from sklearn.ensemble import BaggingClassifier
from sklearn.tree import DecisionTreeClassifier

bag_clf = BaggingClassifier(DecisionTreeClassifier(), 
n_estimators=500, max_samples=100, n_jobs=-1,
random_state=42)
bag_clf.fit(X_train, y_train)
```

>[!notes] Note: 
 >A `BaggingClassifier` automatically performs soft voting instead of hard voting if the base classifier can estimate class probabilities (i.e., if it has a `predict_proba()` method), which is the case with decision tree classifiers.
 
The following figure compares the decision boundary of a single decision tree with the decision boundary of a bagging ensemble of 500 trees (from the preceding code), both trained on the moons dataset.

![[Pasted image 20241011181951.png|bscreen]]
>A single decision tree (left) versus a bagging ensemble of 500 trees (right).

As you can see, the ensemble’s predictions will likely generalize much better than the single decision tree’s predictions: the ensemble has a comparable bias but a smaller variance (it makes roughly the same number of errors on the training set, but the decision boundary is less irregular).

## Out-of-Bag Evaluation
With bagging, some training instances may be sampled several times for any given predictor, while others may not be sampled at all. By default a `BaggingClassifier` samples `m` training instances with replacement (`bootstrap=True`), where $m$ is the size of the training set. With this process, it can be shown mathematically that only about 63% of the training instances are sampled on average for each predictor. The remaining 37% of the training instances that are not sampled are called out-of-bag (OOB) instances. Note that they are not the same 37% for all predictors.

A bagging ensemble can be evaluated using OOB instances, without the need for a separate validation set: indeed, if there are enough estimators, then each instance in the training set will likely be an OOB instance of several estimators, so these estimators can be used to make a fair ensemble prediction for that instance. Once you have a prediction for each instance, you can compute the ensemble’s prediction accuracy (or any other metric).

In Scikit-Learn, you can set `oob_score=True` when creating a `BaggingClassifier` to request an automatic OOB evaluation after training. The following code demonstrates this. The resulting evaluation score is available in the `oob_score_ attribute`:

```python
>>> bag_clf = BaggingClassifier(DecisionTreeClassifier(), 
> 		n_estimators=500, oob_score=True, n_jobs=-1,
> 		random_state=42)
		>>> bag_clf.fit(X_train, y_train)
		>>> bag_clf.oob_score_
> 0.896
		```

The OOB decision function for each training instance is also available through the `oob_decision_function_` attribute. Since the base estimator has a `predict_proba()` method, the decision function returns the class probabilities for each training instance. For example, the OOB evaluation estimates that the first training instance has a 67.6% probability of belonging to the positive class and a 32.4% probability of belonging to the negative class:
```python
>>> bag_clf.oob_decision_function_[:3] # probas for the first 3 instances
>>> array([[0.32352941, 0.67647059],
> 	   [0.3375	, 0.6625	],
> 	   [1.		, 0.		]])
> ```

## Random Patches and Random Subspaces
The `BaggingClassifier` class supports sampling the features as well. Sampling is controlled by two hyperparameters: `max_features` and `bootstrap_features`. They work the same way as `max_samples` and bootstrap, but for feature sampling instead of instance sampling. Thus, each predictor will be trained on a random subset of the input features.

This technique is particularly useful when you are dealing with high-dimensional inputs (such as images), as it can considerably speed up training. Sampling both training instances and features is called the **random patches** method. Keeping all training instances (by setting `bootstrap=False` and `max_samples=1.0`) but sampling features (by setting `bootstrap_features` to `True` and/or `max_features` to a value smaller than `1.0`) is called the **random subspaces** method.

Sampling features results in even more predictor diversity, trading a bit more bias for a lower variance.

# Random Forests
A random forest is an ensemble of decision trees, generally trained via the bagging method (or sometimes pasting), typically with `max_samples` set to the size of the training set. Instead of building a `BaggingClassifier` and passing it a `DecisionTreeClassifier`, you can use the `RandomForestClassifier` class, which is more convenient and optimized for decision trees (similarly, there is a `RandomForestRegressor` class for regression tasks). The following code trains a random forest classifier with 500 trees, each limited to maximum 16 leaf nodes, using all available CPU cores:
```python
from sklearn.ensemble import RandomForestClassifier

rnd_clf = RandomForestClassifier(n_estimators=500, max_leaf_nodes=16,
n_jobs=-1, random_state=42)
		rnd_clf.fit(X_train, y_train)
		y_pred_rf = rnd_clf.predict(X_test)
		```

With a few exceptions, a `RandomForestClassifier` has all the hyperparameters of a `DecisionTreeClassifier` (to control how trees are grown), plus all the hyperparameters of a `BaggingClassifier` to control the ensemble itself.

The random forest algorithm introduces extra randomness when growing trees; instead of searching for the very best feature when splitting a node, it searches for the best feature among a random subset of features. By default, it samples $\sqrt{ n }$ features (where $n$ is the total number of features). The algorithm results in greater tree diversity, which (again) trades a higher bias for a lower variance, generally yielding an overall better model. So, the following `BaggingClassifier` is equivalent to the previous `RandomForestClassifier`:

```python
from sklearn.ensemble import RandomForestClassifier

rnd_clf = RandomForestClassifier(n_estimators=500, max_leaf_nodes=16,
n_jobs=-1, random_state=42)
		rnd_clf.fit(X_train, y_train)
		y_pred_rf = rnd_clf.predict(X_test)
		```

## Extra-Trees
When you are growing a tree in a random forest, at each node only a random subset of the features is considered for splitting. It is possible to make trees even more random by also using random thresholds for each feature rather than searching for the best possible thresholds (like regular decision trees do). For this, simply set `splitter="random"` when creating a `DecisionTreeClassifier`.

A forest of such extremely random trees is called an **extremely randomized trees** (or **extra-trees** for short) ensemble. Once again, this technique trades more bias for a lower variance. It also makes extra-trees classifiers much faster to train than regular random forests, because finding the best possible threshold for each feature at every node is one of the most time-consuming tasks of growing a tree.

## Feature Importance
Yet another great quality of random forests is that they make it easy to measure the relative importance of each feature. Scikit-Learn measures a feature’s importance by looking at how much the tree nodes that use that feature reduce impurity on average, across all trees in the forest. More precisely, it is a weighted average, where each node’s weight is equal to the number of training samples that are associated with it.

Scikit-Learn computes this score automatically for each feature after training, then it scales the results so that the sum of all importances is equal to 1.

You can access the result using the `feature_importances_` variable. For example, the following code trains a `RandomForestClassifier` on the iris dataset and outputs each feature’s importance. It seems that the most important features are the petal length (44%) and width (42%), while sepal length and width are rather unimportant in comparison (11% and 2%, respectively):

```python
>>> from sklearn.datasets import load_iris

>>> iris = load_iris(as_frame=True)
>>> rnd_clf = RandomForestClassifier(n_estimators=500,
> 		random_state=42)
		>>> rnd_clf.fit(iris.data, iris.target)
		>>> for score, name in zip(rnd_clf.feature_importances_, 
> 		iris.data.columns):
> 			print(round(score, 2), name)
> 0.11 sepal length (cm)
> 0.02 sepal width (cm)
> 0.44 petal length (cm)
> 0.42 petal width (cm)
		```

Similarly, if you train a random forest classifier on the MNIST dataset and plot each pixel’s importance, you get the the following image:
![[Pasted image 20241011232804.png|bscreen|500]]
>MNIST pixel importance (according to a random forest classifier)

# Boosting
**Boosting** (originally called **hypothesis boosting**) refers to any ensemble method that can combine several weak learners into a strong learner. The general idea of most boosting methods is to train predictors sequentially, each trying to correct its predecessor. There are many boosting methods available, but by far the most popular are AdaBoost (short for **adaptive boosting**) and **gradient boosting**.

## AdaBoost
One way for a new predictor to correct its predecessor is to pay a bit more attention to the training instances that the predecessor underfit. This results in new predictors focusing more and more on the hard cases. This is the technique used by AdaBoost.

For example, when training an AdaBoost classifier, the algorithm first trains a base classifier (such as a decision tree) and uses it to make predictions on the training set. The algorithm then increases the relative weight of misclassified training instances. Then it trains a second classifier, using the updated weights, and again makes predictions on the training set, updates the instance weights, and so on.

![[{897F83FF-6C03-4F8D-9BAF-53347BF16C6B}.png|bookhue|500]]
>AdaBoost sequential training with instance weight updates

The following figure shows the decision boundaries of five consecutive predictors on the moons dataset (in this example, each predictor is a highly regularized SVM classifier with an RBF kernel).

![[Pasted image 20241012123129.png|bscreen]]
>AdaBoost sequential training with instance weight updates

The first classifier gets many instances wrong, so their weights get boosted. The second classifier therefore does a better job on these instances, and so on. The plot on the right represents the same sequence of predictors, except that the learning rate is halved (i.e., the misclassified instance weights are boosted much less at every iteration). As you can see, this sequential learning technique has some similarities with gradient descent, except that instead of tweaking a single predictor’s parameters to minimize a cost function, AdaBoost adds predictors to the ensemble, gradually making it better.

Once all predictors are trained, the ensemble makes predictions very much like bagging or pasting, except that predictors have different weights depending on their overall accuracy on the weighted training set.

Let’s take a closer look at the `AdaBoost` algorithm. Each instance weight $w^{(i)}$ is initially set to $1/m$. A first predictor is trained, and its weighted error rate ${r}_{1}$ is computed on the training set:
$$
r_{j}=\sum_{\substack{i=1\\[1ex]\hat{y}_{j}^{(i)}\neq y^{(i)}}}^{\infty}w^{(i)}\hat{y}_{j}^{(i)} 
$$
where $\hat{y}_{j}^{(i)}$ is the $j$th predictor's prediction for the $i$th instance.

The predictor's weight $\alpha_{j}$ is then computed using the following equation:
$$
\alpha_{j}=\eta \ln \dfrac{1-r_{j}}{r_{j}}
$$
where $\eta$ is the learning rate hyperparameter (defaults to $1$). The more accurate the predictor is, the higher its weight will be. If it is just guessing randomly, then its weight will be close to zero. However, if it is most often wrong (i.e., less accurate than random guessing), then its weight will be negative.

Next, the AdaBoost algorithm updates the instance weights, using the following equation, which boosts the weights of the misclassified instances:
$$
\begin{aligned}
 & \text{for } i=1,2,\dots ,m \\
 & w^{(i)}=\begin{cases}
w^{(i)} & \text{if } \hat{y}_{j}^{(i)}=y^{(i)} \\
w^{(i)}\exp(\alpha_{j}) & \text{if } \hat{y}_{j}^{(i)}\neq y^{(i)}
\end{cases}
\end{aligned}
$$

Then all the instance weights are normalized (i.e., divided by $\sum_{i=1}^{m}w^{(i)}$).

Finally, a new predictor is trained using the updated weights, and the whole process is repeated: the new predictor’s weight is computed, the instance weights are updated, then another predictor is trained, and so on. The algorithm stops when the desired number of predictors is reached, or when a perfect predictor is found.

To make predictions, AdaBoost simply computes the predictions of all the predictors and weighs them using the predictor weights $\alpha_{j}$. The predicted class is the one that receives the majority of weighted votes.

Scikit-Learn uses a multiclass version of AdaBoost called SAMME (which stands for **Stagewise Additive Modeling using a Multiclass Exponential loss function**). When there are just two classes, SAMME is equivalent to AdaBoost. If the predictors can estimate class probabilities (i.e., if they have a `predict_proba()` method), Scikit-Learn can use a variant of SAMME called SAMME.R (the R stands for “Real”), which relies on class probabilities rather than predictions and generally performs better.

The following code trains an AdaBoost classifier based on 30 **decision stumps** using Scikit-Learn’s `AdaBoostClassifier` class (as you might expect, there is also an `AdaBoostRegressor` class). A decision stump is a decision tree with `max_depth=1` - in other words, a tree composed of a single decision node plus two leaf nodes. This is the default base estimator for the `AdaBoostClassifier` class:

```python
from sklearn.ensemble import AdaBoostClassifier

ada_clf = AdaBoostClassifier(
DecisionTreeClassifier(max_depth=1), n_estimators=30,
learning_rate=0.5, random_state=42)
ada_clf.fit(X_train, y_train)
```
