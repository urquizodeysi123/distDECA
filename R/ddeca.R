#' Density of the DECA distribution
#'
#' Evaluates the probability density function
#' \deqn{f(x) = \frac{2x\,e^{x^2}}{e - 1}, \quad 0 \le x \le 1,}
#' with \eqn{f(x) = 0} outside \eqn{[0,1]}.
#'
#' @param x Numeric vector of values.
#' @return Numeric vector with the density at each value of \code{x}.
#' @seealso \code{\link{pdeca}}, \code{\link{rdeca}}
#' @examples
#' ddeca(c(-0.5, 0, 0.5, 1, 1.5))                 # 0 outside [0, 1]
#' curve(ddeca(x), 0, 1, main = "DECA density")   # plot of the density
#' @export
ddeca <- function(x) {
  ifelse(x >= 0 & x <= 1, 2 * x * exp(x^2) / (exp(1) - 1), 0)
}
