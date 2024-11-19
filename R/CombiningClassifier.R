
CombiningClassifier<- function(X, y, max_iter = 100, tol = 1e-6) {

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
