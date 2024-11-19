# myrepo
testing my setup


# Package: CombiningClassifier

![R-CMD-check](https://github.com/anyanliu/myrepo/actions/workflows/R-CMD-check.yaml/badge.svg)


## 简介

`CombiningClassifier` combines multiple basic classifiers, such as Logistic Regression, SVM, Random Forest, Decision Tree. And use weighted vote method to get the classification label.


---

## Get the package from Github
install.packages("devtools")
devtools::install_github("your_github_username/CombiningClassifier")
---

###### Using Method
library(CombiningClassifier)
set.seed(123)
train_data <- data.frame(x1 = rnorm(100), x2 = rnorm(100))
train_labels <- sample(c(0, 1), 100, replace = TRUE)
test_data <- data.frame(x1 = rnorm(20), x2 = rnorm(20))

result <- CombiningClassifier(train_data, train_labels, test_data)
print(result)

