set.seed(123)
train_data <- data.frame(x1 = rnorm(100), x2 = rnorm(100))
train_labels <- sample(c(0, 1), 100, replace = TRUE)
test_data <- data.frame(x1 = rnorm(20), x2 = rnorm(20))

# Load the required package
library(CombiningClassifier)

# Run the classifier
result <- CombiningClassifier(train_data, train_labels, test_data)

# Display results
print(result)
