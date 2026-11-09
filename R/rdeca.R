#' Random number generation for the DECA distribution
#'
#' Inverse transform method: uniform values \eqn{U \sim \mathrm{Uniform}(0,1)}
#' are generated with \code{runif()} and the inverse of the CDF (Step 3) is
#' applied,
#' \deqn{X = F^{-1}(U) = \sqrt{\ln\left(1 + U\,(e - 1)\right)},}
#' which has density \eqn{f(x) = 2x e^{x^2}/(e-1)}.
#'
#' @param n Sample size (positive integer).
#' @return Numeric vector of length \code{n} with values in \eqn{[0,1]}.
#' @seealso \code{\link{ddeca}}, \code{\link{pdeca}}, \code{\link{chi2_deca}}
#' @examples
#' set.seed(2024)
#' x <- rdeca(1000)                            # 1000 random values
#' c(mean = mean(x), var = var(x))             # close to 0.7307 and 0.0480
#' hist(x, freq = FALSE)                       # sample histogram
#' curve(ddeca(x), add = TRUE, col = "red")    # theoretical density
#' @export
rdeca <- function(n) {
  u <- runif(n)                     # Step 4: uniform values U(0,1)
  sqrt(log(1 + u * (exp(1) - 1)))   # Step 3: inverse CDF x = F^-1(u)
}
