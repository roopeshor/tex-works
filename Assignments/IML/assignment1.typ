#set text(font: "New Computer Modern")
#place(center+top, float: true)[
	#text(size: 22pt)[*Assignment 1:*]

	#text(size: 18pt)[*Prediction Using Logistic Regression*]

	_Submitted by Roopesh O R (20323085)_
]
#v(1cm)
The typical setup for logistic regression is as follows: there is an outcome $y$ that falls into one of two categories (0 or 1), and the following equation is used to estimate the probability that $y$ belongs to a particular category given inputs $arrow(x)=[x_1,x_2,...,x_k]$ and bias $arrow(beta) = [beta_1, beta_2, ..., beta_k]$: 
$ P(y=1|X)=sigma(z)=1/(1+e^(-z)) $
where
$ z=β_0 +β_1 x_1+β_2 x_2+...+β_k x_k = arrow(beta) arrow(x_b)^T $

Where $arrow(x_b)$ is parameter matrix with some bias value $b$ inserted in the column:

$ mat(1, x_11, x_12, ..., x_(1k);augment: #1, delim:"[") $

= Learning rule
To estimate coefficients $arrow(beta)$, here I've used gradient descent, which minimized Log Loss $cal(l)$:
$ cal(l) = -sum_(k=1)^N (y_k ln(p_k) + (1-y_k)ln(1-y_k)) $
Where $y_k$ is ground truth and $p_k$ is model prediction for index $k$

And beta can be estimated by computing gradient of $cal(l)$:
$ (partial cal(l))/(partial arrow(beta)) = 1/N X_b^T (arrow(p) - arrow(y)) $
where $arrow(p)$ is predicted value and $arrow(y)$ is ground truth.

where $X_b$ is sample matrix augmented with bias:
$ X_b = mat(1, x_11, x_12, ..., x_(1k); 1, x_21, x_22, ..., x_(2k); dots.v, dots.v, dots.v, dots.down, dots.v; 1, x_(N 1), x_(N 2), ..., x_(N k); augment:#1, delim: "[") $

Then $beta$ is updated by:
$ arrow(beta)_"new" = arrow(beta)_"old" - alpha (partial cal(l))/(partial arrow(beta)) $

where $alpha$ is learning rate.
= Code

```python
import numpy as np

def sigmoid(z):
		return 1 / (1 + np.exp(-z))
def fit_logistic_regression(X, y, learning_rate=0.01, epochs=1000):
    # X shape: (samples, features), y shape: (samples,)
    N, k = X.shape
    
    beta = np.zeros(k + 1)
    X_b = np.c_[np.ones((N, 1)), X]
    for _ in range(epochs):
        z = np.dot(X_b, beta)
        p = sigmoid(z)
        
        gradient = np.dot(X_b.T, (p - y)) / N
        
        # Update weights
        beta -= learning_rate * gradient
        
    return beta
def predict(X, beta):
    X_b = np.c_[np.ones((X.shape[0], 1)), X]
    probabilities = sigmoid(np.dot(X_b, beta))
    return (probabilities >= 0.5).astype(int)

# Data: (Hours, Attendance, Score)
X_train = np.array([
	[5, 80, 70],
	[2, 50, 30],
	[8, 90, 85],
	[1, 40, 25],
])

X_test = np.array([
	[6, 85, 80],
	[3, 60, 55],
])
y_train = np.array([1, 0, 1, 0])
y_test = np.array([1, 0])

weights = fit_logistic_regression(X_train, y_train)
predictions = predict(X_test, weights)
print("prediction:", predictions, "actual:", y_test)
```

== Result
> ``` prediction: [1 1] actual: [1 0]```

It predicted 1 outcome correctly.