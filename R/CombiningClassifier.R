#' Combined Classifier
#'
#' Combines logistic regression and decision tree classifiers to predict classification labels.
#' @param train_data A data frame for training the classifiers.
#' @param train_labels A factor vector of labels for the training data.
#' @param test_data A data frame for testing the classifiers.
#' @return A vector of predicted labels based on majority voting.
#' @export
CombinedClassifier <- function(train_data, train_labels, test_data) {
  # Ensure labels are factors
  train_labels <- as.factor(train_labels)

  # Train logistic regression model
  log_model <- glm(train_labels ~ ., data = train_data, family = binomial)

  # Train decision tree model
  library(rpart)
  tree_model <- rpart(train_labels ~ ., data = train_data, method = "class")

  # Predictions
  log_pred <- ifelse(predict(log_model, test_data, type = "response") > 0.5, 1, 0)
  tree_pred <- as.numeric(as.character(predict(tree_model, test_data, type = "class")))

  # Combine predictions (majority voting)
  predictions <- data.frame(Logistic = log_pred, DecisionTree = tree_pred)
  combined_pred <- apply(predictions, 1, function(row) {
    as.numeric(names(which.max(table(row))))
  })

  return(combined_pred)
}
