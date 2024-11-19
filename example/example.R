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
