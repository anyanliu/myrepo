#' Combining Classifier
#'
#' Combines basic classifiers to predict classification labels.
#' @param train_data A data frame for training the classifiers.
#' @param train_labels A factor vector of labels for the training data.
#' @param test_data A data frame for testing the classifiers.
#' @return A vector of predicted labels based on majority voting.
#' @export

CombiningClassifier <- function(train_data, train_labels, test_data) {

  train_labels <- as.factor(train_labels)

  library(rpart)
  library(randomForest)
  library(e1071)
  library(class)
  library(xgboost)

  # Logistic Regression
  log_model <- glm(train_labels ~ ., data = train_data, family = binomial)

  # Decision Tree
  tree_model <- rpart(train_labels ~ ., data = train_data, method = "class")

  # Random Forest
  rf_model <- randomForest(train_data, train_labels, ntree = 300, mtry = 2)

  # SVM
  svm_model <- svm(train_labels ~ ., data = train_data, kernel = "radial", cost = 1, gamma = 0.1)

  # XGBoost
  xgb_train <- xgb.DMatrix(data = as.matrix(train_data), label = as.numeric(train_labels) - 1)
  xgb_model <- xgboost(data = xgb_train, max_depth = 3, nrounds = 100, objective = "binary:logistic", verbose = 0)

  # predict
  log_pred <- ifelse(predict(log_model, test_data, type = "response") > 0.5, 1, 0)
  tree_pred <- as.numeric(as.character(predict(tree_model, test_data, type = "class")))
  rf_pred <- as.numeric(predict(rf_model, test_data, type = "response"))
  svm_pred <- as.numeric(predict(svm_model, test_data))
  xgb_pred <- ifelse(predict(xgb_model, as.matrix(test_data)) > 0.5, 1, 0)
  knn_pred <- as.numeric(knn(train = train_data, test = test_data, cl = train_labels, k = 5))

  # integrete
  predictions <- data.frame(
    Logistic = log_pred,
    DecisionTree = tree_pred,
    RandomForest = rf_pred,
    SVM = svm_pred,
    XGBoost = xgb_pred,
    KNN = knn_pred
  )

  # weighted vote to generate result
  weights <- c(0.2, 0.1, 0.4, 0.2, 0.4, 0.1)
  combined_pred <- apply(predictions, 1, function(row) {
    unique_vals <- unique(row)
    weighted_votes <- sapply(unique_vals, function(val) sum(weights[row == val]))
    unique_vals[which.max(weighted_votes)]
  })

  return(as.numeric(combined_pred))
}
