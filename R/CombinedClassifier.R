# existing package
install.packages("caret")
install.packages("e1071")
install.packages("randomForest")
install.packages("rpart")

library(caret)
library(e1071)
library(randomForest)
library(rpart)

# Define Function
CombinedClassifier <- function(train_data, train_labels, test_data) {
  
  train_data <- as.data.frame(train_data)
  test_data <- as.data.frame(test_data)
  
  ## model training
  # Logistic Regression
  log_model <- glm(train_labels ~ ., data = train_data, family = binomial)
  
  # SVM
  svm_model <- svm(train_labels ~ ., data = train_data, probability = TRUE)
  
  # Random Forest
  rf_model <- randomForest(train_data, as.factor(train_labels), ntree = 100)
  
  # Decision Tree
  tree_model <- rpart(train_labels ~ ., data = train_data, method = "class")
  
  ## Prediction
  # Logistic Regression
  log_pred <- ifelse(predict(log_model, test_data, type = "response") > 0.5, 1, 0)
  
  # SVM
  svm_pred <- predict(svm_model, test_data)
  
  # Random Forest
  rf_pred <- predict(rf_model, test_data, type = "response")
  
  # Decision Tree
  tree_pred <- predict(tree_model, test_data, type = "class")
  
  # results matrix
  predictions <- data.frame(
    Logistic = as.numeric(log_pred),
    SVM = as.numeric(svm_pred),
    RandomForest = as.numeric(rf_pred),
    DecisionTree = as.numeric(tree_pred)
  )
  
  # majority vote
  combined_pred <- apply(predictions, 1, function(row) {
    as.numeric(names(which.max(table(row))))
  })
  
  return(combined_pred)
}

library(devtools)
document()
setwd('..')
install('CombinedClassifier')
library(CombinedClassifier)

setwd("path/to/CombinedClassifier")
getwd()
setwd("path/to/CombinedClassifier")
devtools::document()


