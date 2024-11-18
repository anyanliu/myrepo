#' Combining Classifier
#'
#' Combines basic classifiers to predict classification labels.
#' @param train_data A data frame for training the classifiers.
#' @param train_labels A factor vector of labels for the training data.
#' @param test_data A data frame for testing the classifiers.
#' @return A vector of predicted labels based on majority voting.
#' @export

CombiningClassifier <- function(train_data, train_labels, test_data) {
  # 确保标签是因子
  train_labels <- as.factor(train_labels)

  # 加载必要的包
  library(rpart)
  library(randomForest)
  library(e1071)
  library(class)

  # 训练模型
  # Logistic Regression
  log_model <- glm(train_labels ~ ., data = train_data, family = binomial)

  # Decision Tree
  tree_model <- rpart(train_labels ~ ., data = train_data, method = "class")

  # Random Forest
  rf_model <- randomForest(train_data, train_labels, ntree = 100)

  # Support Vector Machine (SVM)
  svm_model <- svm(train_labels ~ ., data = train_data, probability = TRUE)

  # K-Nearest Neighbors (KNN) does not require training, handled during prediction

  # 预测
  log_pred <- ifelse(predict(log_model, test_data, type = "response") > 0.5, 1, 0)
  tree_pred <- as.numeric(as.character(predict(tree_model, test_data, type = "class")))
  rf_pred <- as.numeric(predict(rf_model, test_data, type = "response"))
  svm_pred <- as.numeric(predict(svm_model, test_data))
  knn_pred <- as.numeric(knn(train = train_data, test = test_data, cl = train_labels, k = 5))

  # 合并预测结果
  predictions <- data.frame(
    Logistic = log_pred,
    DecisionTree = tree_pred,
    RandomForest = rf_pred,
    SVM = svm_pred,
    KNN = knn_pred
  )

  # 多数投票
  combined_pred <- apply(predictions, 1, function(row) {
    as.numeric(names(which.max(table(row))))
  })

  return(combined_pred)
}
