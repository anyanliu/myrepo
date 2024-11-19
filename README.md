# myrepo
testing my setup


# Package: CombiningClassifier

![R-CMD-check](https://github.com/anyanliu/myrepo/actions/workflows/R-CMD-check.yaml/badge.svg)


## 简介

`CombiningClassifier` is a function that implete Logistic.


---

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


