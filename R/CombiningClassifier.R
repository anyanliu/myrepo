#' Logistic Regression Implementation
#'
#' Implements logistic regression using iterative optimization (Newton-Raphson method).
#' @param X A matrix or data frame of predictors (independent variables).
#' @param y A binary vector (0/1) of outcomes (dependent variable).
#' @param tol A numeric value specifying the convergence tolerance. Default is 1e-6.
#' @param max_iter An integer specifying the maximum number of iterations. Default is 100.
#' @return A list containing:
#' \describe{
#'   \item{coefficients}{A vector of estimated coefficients, including the intercept.}
#'   \item{fitted.values}{A vector of predicted probabilities for each observation.}
#'   \item{iterations}{The number of iterations taken to converge.}
#'   \item{converged}{Logical, indicating whether the algorithm converged.}
#' }
#' @examples
#' # Example data
#' set.seed(123)
#' X <- data.frame(x1 = rnorm(100), x2 = rnorm(100))
#' y <- sample(c(0, 1), 100, replace = TRUE)
#'
#' # Fit logistic regression
#' result <- my_logistic(X, y)
#' print(result$coefficients)
#' print(result$fitted.values)
#' @export

my_logistic <- function(X, y, max_iter = 100, tol = 1e-6) {

  X <- as.matrix(cbind(Intercept = 1, X))
  y <- as.vector(y)

  beta <- rep(0, ncol(X))

  for (i in 1:max_iter) {

    p <- 1 / (1 + exp(-X %*% beta))

    gradient <- t(X) %*% (y - p)
    W <- diag(as.vector(p * (1 - p)))
    hessian <- -t(X) %*% W %*% X

    beta_new <- beta - solve(hessian) %*% gradient

    if (max(abs(beta_new - beta)) < tol) {
      beta <- beta_new
      break
    }
    beta <- beta_new
  }

  list(
    coefficients = beta,
    fitted.values = as.vector(1 / (1 + exp(-X %*% beta))),
    iterations = i
  )
}
