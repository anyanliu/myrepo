\name{CombiningClassifier}
\alias{CombiningClassifier}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Function to implement glm() function
}
\description{
`CombiningClassifier` is an R function that implete Logistic.The `CombiningClassifier` function is a custom implementation of logistic regression using the iterative reweighted least squares (IRLS) method. This document demonstrates its purpose, usage, and comparison with R's built-in `glm()` function for logistic regression.

}
\usage{
CombiningClassifier(X, y, max_iter = 100, tol = 1e-06)
}

\arguments{
  \item{X}{
A matrix or data frame of predictor variables. Each row represents an observation, and each column represents a feature.
}
  \item{y}{
A binary response vector (0s and 1s) with the same number of rows as \code{X}.
}
  \item{max_iter}{
An integer specifying the maximum number of iterations to perform. Default is \code{100}.
}
  \item{tol}{
A numeric value specifying the convergence tolerance. The algorithm stops if the maximum absolutechange in coefficients between iterations is less than \code{tol}. Default is \code{1e-6}.
}
}


\return {A list with the following components:
   \item{coefficients}{A numeric vector of estimated coefficients, including the intercept.}
   \item{fitted.values}{A numeric vector of predicted probabilities for each observation.}
   \item{iterations}{The number of iterations required to achieve convergence.}
}




\details{
The \code{CombiningClassifier} function uses the IRLS method to estimate logistic regression coefficients.
#' The algorithm iteratively updates the coefficients by solving a Newton-Raphson step using the gradient and Hessian matrix.
#' The stopping criterion is based on the convergence tolerance (\code{tol}) or the maximum number of iterations (\code{max_iter}).
}

\author{
Anyan Liu
}

\seealso{
   \code{\link{glm}} for the built-in implementation of logistic regression.
}
\examples{
set.seed(123)
library(CombiningClassifier)
X <- data.frame(x1 = rnorm(100), x2 = rnorm(100))
y <- sample(c(0, 1), 100, replace = TRUE)

model <- CombiningClassifier(X, y)
print(model$coefficients)
print(head(model$fitted.values))
print(model$iterations)
}


## The function is currently defined as
function (X, y, max_iter = 100, tol = 1e-06)
{
    X <- as.matrix(cbind(Intercept = 1, X))
    y <- as.vector(y)
    beta <- rep(0, ncol(X))
    for (i in 1:max_iter) {
        p <- 1/(1 + exp(-X \%*\% beta))
        gradient <- t(X) \%*\% (y - p)
        W <- diag(as.vector(p * (1 - p)))
        hessian <- -t(X) \%*\% W \%*\% X
        beta_new <- beta - solve(hessian) \%*\% gradient
        if (max(abs(beta_new - beta)) < tol) {
            beta <- beta_new
            break
        }
        beta <- beta_new
    }
    list(coefficients = beta, fitted.values = as.vector(1/(1 +
        exp(-X \%*\% beta))), iterations = i)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory (show via RShowDoc("KEYWORDS")):
% \keyword{ ~kwd1 }
% \keyword{ ~kwd2 }
% Use only one keyword per line.
% For non-standard keywords, use \concept instead of \keyword:
% \concept{ ~cpt1 }
% \concept{ ~cpt2 }
% Use only one concept per line.

