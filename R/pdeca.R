#' Cumulative distribution function (CDF) of the DECA distribution
#'
#' Computes \eqn{P(X \le q)}:
#' \deqn{F(q) = \frac{e^{q^2} - 1}{e - 1}, \quad 0 \le q \le 1,}
#' with \eqn{F(q) = 0} if \eqn{q < 0} and \eqn{F(q) = 1} if \eqn{q > 1}.
#'
#' @param q Numeric vector of quantiles.
#' @return Numeric vector of cumulative probabilities.
#' @seealso \code{\link{ddeca}}, \code{\link{rdeca}}
#' @examples
#' pdeca(c(0, 0.5, 1))
#' pdeca(0.8) - pdeca(0.2)   # P(0.2 < X <= 0.8)
#' @export
pdeca <- function(q) {
  (exp(pmin(pmax(q, 0), 1)^2) - 1) / (exp(1) - 1)
}
