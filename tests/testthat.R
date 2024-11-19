# This file is part of the standard setup for testthat.
# It is recommended that you do not modify it.
#
# Where should you do additional test configuration?
# Learn more about the roles of various files in:
# * https://r-pkgs.org/testing-design.html#sec-tests-files-overview
# * https://testthat.r-lib.org/articles/special-files.html

test_that("CombiningClassifier works correctly", {
  set.seed(123)
  train_data <- data.frame(x1 = rnorm(100), x2 = rnorm(100))
  train_labels <- sample(c(0, 1), 100, replace = TRUE)
  test_data <- data.frame(x1 = rnorm(20), x2 = rnorm(20))

  result <- CombiningClassifier(train_data, train_labels, test_data)

  expect_type(result, "double")

  expect_equal(length(result), nrow(test_data))

  expect_true(all(result %in% c(0, 1)))
})

test_that("CombiningClassifier handles larger datasets", {
  set.seed(123)
  train_data <- data.frame(x1 = rnorm(1000), x2 = rnorm(1000))
  train_labels <- sample(c(0, 1), 1000, replace = TRUE)
  test_data <- data.frame(x1 = rnorm(200), x2 = rnorm(200))

  result <- CombiningClassifier(train_data, train_labels, test_data)

  expect_type(result, "double")
  expect_equal(length(result), nrow(test_data))
  expect_true(all(result %in% c(0, 1)))
})

test_that("CombiningClassifier predictions are consistent", {

  set.seed(123)
  train_data <- data.frame(x1 = rnorm(100), x2 = rnorm(100))
  train_labels <- sample(c(0, 1), 100, replace = TRUE)
  test_data <- data.frame(x1 = rnorm(20), x2 = rnorm(20))


  result1 <- CombiningClassifier(train_data, train_labels, test_data)
  result2 <- CombiningClassifier(train_data, train_labels, test_data)

  expect_equal(result1, result2)
})
