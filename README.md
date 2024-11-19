# myrepo
testing my setup


# Package: CombiningClassifier

![R-CMD-check](https://github.com/anyanliu/myrepo/actions/workflows/R-CMD-check.yaml/badge.svg)


## 简介

`CombiningClassifier` is a function that implement Logistic function glm(). Because of my initial misunderstanding of the assignment problem, the function name may be ambiguous. But note that it is a function that implements a glm function. `CombiningClassifier` is a simple R package that implements logistic regression using an iterative reweighted least squares (IRLS) approach. The function computes the logistic regression coefficients, predicted probabilities, and the number of iterations required to achieve convergence.

---
##Key feature
1. Custom Implementation: Implements logistic regression from scratch using numerical optimization techniques.
2. Flexibility: Allows users to specify tolerance levels (tol) and the maximum number of iterations (max_iter) for convergence.
3. Outputs: Returns coefficients, fitted values (probabilities), and the total number of iterations.



## Get the package from Github
install.packages("devtools")
devtools::install_github("anyanliu/CombiningClassifier")
---

###### Using Method
library(CombiningClassifier)
set.seed(123)  
X <- data.frame(
  x1 = rnorm(100),  
  x2 = rnorm(100)
)
y <- sample(c(0, 1), 100, replace = TRUE)  

library(CombiningClassifier)

result <- CombiningClassifier(X, y)

print(result)

---
## Example
set.seed(123)
library(CombiningClassifier)
X <- data.frame(x1 = rnorm(100), x2 = rnorm(100))
y <- sample(c(0, 1), 100, replace = TRUE)

result <- CombiningClassifier(X, y)

cat("Estimated Coefficients:\n")
print(result$coefficients)

cat("\nFitted Probabilities (first 10):\n")
print(head(result$fitted.values, 10))

cat("\nNumber of Iterations:\n")
print(result$iterations)


---
# Main function
'CombiningClasssifer' This is the main function of the package.
Description: Fits a logistic regression model using an iterative reweighted least squares algorithm.
Usage: CombiningClassifier(X, y, max_iter = 100, tol = 1e-6)

Arguments:
X: A data frame or matrix of predictor variables.
y: A numeric binary vector (0/1) of response labels.
max_iter: Maximum number of iterations for convergence (default: 100).
tol: Convergence tolerance for coefficient updates (default: 1e-6).

Returns:
coefficients: A vector of logistic regression coefficients.
fitted.values: A vector of predicted probabilities for the input data.
iterations: The number of iterations performed before convergence.

---
# Comparison with glm function
You can compare the results of CombiningClassifier with R's built-in glm function:

set.seed(123)
X <- data.frame(x1 = rnorm(100), x2 = rnorm(100))
y <- sample(c(0, 1), 100, replace = TRUE)
CombiningClassifier_result <- CombiningClassifier(X, y)
glm_result <- glm(y ~ ., data = X, family = binomial)
fitted_mylogistic <- CombiningClassifier_result$fitted.values
fitted_glm <- fitted(glm_result)
all.equal(unname(fitted_mylogistic),unname(fitted_glm))



