# This file is part of the standard setup for testthat.
# It is recommended that you do not modify it.
#
# Where should you do additional test configuration?
# Learn more about the roles of various files in:
# * https://r-pkgs.org/testing-design.html#sec-tests-files-overview
# * https://testthat.r-lib.org/articles/special-files.html

test_that("CombiningClassifier works correctly", {
  # 模拟训练数据和测试数据
  set.seed(123)
  train_data <- data.frame(x1 = rnorm(100), x2 = rnorm(100))
  train_labels <- sample(c(0, 1), 100, replace = TRUE)
  test_data <- data.frame(x1 = rnorm(20), x2 = rnorm(20))

  # 运行CombiningClassifier函数
  result <- CombiningClassifier(train_data, train_labels, test_data)

  # 使用all.equal()检查返回值是否为数值
  expect_true(isTRUE(all.equal(typeof(result), "double")))

  # 使用all.equal()检查返回值的长度是否正确
  expect_true(isTRUE(all.equal(length(result), nrow(test_data))))

  # 使用all.equal()检查返回值是否仅包含0或1
  expect_true(isTRUE(all.equal(sort(unique(result)), c(0, 1))))
})

test_that("CombiningClassifier handles larger datasets", {
  # 测试更大的数据集
  set.seed(123)
  train_data <- data.frame(x1 = rnorm(1000), x2 = rnorm(1000))
  train_labels <- sample(c(0, 1), 1000, replace = TRUE)
  test_data <- data.frame(x1 = rnorm(200), x2 = rnorm(200))

  # 运行CombiningClassifier函数
  result <- CombiningClassifier(train_data, train_labels, test_data)

  # 使用all.equal()检查返回值是否为数值
  expect_true(isTRUE(all.equal(typeof(result), "double")))

  # 使用all.equal()检查返回值的长度是否正确
  expect_true(isTRUE(all.equal(length(result), nrow(test_data))))

  # 使用all.equal()检查返回值是否仅包含0或1
  expect_true(isTRUE(all.equal(sort(unique(result)), c(0, 1))))
})

test_that("CombiningClassifier predictions are consistent", {
  # 测试在固定种子下预测结果是否一致
  set.seed(123)
  train_data <- data.frame(x1 = rnorm(100), x2 = rnorm(100))
  train_labels <- sample(c(0, 1), 100, replace = TRUE)
  test_data <- data.frame(x1 = rnorm(20), x2 = rnorm(20))

  # 两次运行结果应该一致
  result1 <- CombiningClassifier(train_data, train_labels, test_data)
  result2 <- CombiningClassifier(train_data, train_labels, test_data)

  # 使用all.equal()检查两次结果是否一致
  expect_true(isTRUE(all.equal(result1, result2)))
})
