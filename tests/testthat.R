# This file is part of the standard setup for testthat.
# It is recommended that you do not modify it.
#
# Where should you do additional test configuration?
# Learn more about the roles of various files in:
# * https://r-pkgs.org/testing-design.html#sec-tests-files-overview
# * https://testthat.r-lib.org/articles/special-files.html

test_that("CombiningClassifier works correctly", {
  set.seed(123)
  X <- data.frame(x1 = rnorm(100), x2 = rnorm(100))
  y <- sample(c(0, 1), 100, replace = TRUE)

  result <- my_logistic(X, y)

  expect_type(result, "list")

  expect_true(all(c("coefficients", "fitted.values", "iterations", "converged") %in% names(result)))

  expect_equal(length(result$coefficients), ncol(X) + 1)

  expect_type(result$fitted.values, "double")

  expect_equal(length(result$fitted.values), nrow(X))

  expect_true(all(result$fitted.values >= 0 & result$fitted.values <= 1))

  expect_type(result$converged, "logical")
  expect_true(result$converged)
})

test_that("CombiningCLassifier handles invalid inputs gracefully", {
  set.seed(123)
  X <- data.frame(x1 = rnorm(100), x2 = rnorm(100))
  y_invalid <- sample(1:3, 100, replace = TRUE)
  expect_error(my_logistic(X, y_invalid), "y must be binary (0/1)")

  X_mismatch <- data.frame(x1 = rnorm(50), x2 = rnorm(50))
  y <- sample(c(0, 1), 100, replace = TRUE)
  expect_error(my_logistic(X_mismatch, y), "X and y must have the same number of rows")
})

test_that("CombiningClassifier produces consistent results", {
  set.seed(123)
  X <- data.frame(x1 = rnorm(100), x2 = rnorm(100))
  y <- sample(c(0, 1), 100, replace = TRUE)

  result1 <- my_logistic(X, y)
  result2 <- my_logistic(X, y)

  expect_equal(result1$coefficients, result2$coefficients)

  expect_equal(result1$fitted.values, result2$fitted.values)
})
