#' Chi-square goodness-of-fit test for the DECA distribution
#'
#' Splits \eqn{[0,1]} into \code{k} intervals of equal width (the first one,
#' \eqn{[0, 1/k]}, includes 0; the others are \eqn{(a_j, b_j]}) and computes
#' the observed frequencies \eqn{O_j}, the expected frequencies
#' \eqn{E_j = n\,(F(b_j) - F(a_j))} and the statistic
#' \deqn{\chi^2 = \sum_{j=1}^{k} \frac{(O_j - E_j)^2}{E_j}, \qquad df = k - 1.}
#' The p-value is \eqn{P(\chi^2_{df} > \chi^2)}, obtained from the upper tail of
#' the chi-square distribution with \code{pchisq(..., lower.tail = FALSE)}.
#' With \eqn{n = 1000} and \eqn{k = 10}, every interval has \eqn{E_j \ge 5}.
#'
#' @param x Numeric vector with the sample, with values in \eqn{[0,1]} (for
#'   example, generated with \code{\link{rdeca}}). \code{NA} values are
#'   ignored; values outside \eqn{[0,1]} produce an error.
#' @param k Number of intervals, an integer greater than or equal to 2.
#'   Defaults to 10. A warning is given if any expected frequency is below 5.
#' @return A list with \code{chi2} (test statistic), \code{gl} (degrees of
#'   freedom, \emph{grados de libertad}), \code{p} (p-value), \code{O}
#'   (observed frequencies) and \code{E} (expected frequencies).
#' @seealso \code{\link{pdeca}}, \code{\link{rdeca}}
#' @examples
#' set.seed(2024)
#' test <- chi2_deca(rdeca(1000))   # sample of size 1000, k = 10 intervals
#' c(chi2 = test$chi2, df = test$gl, p = test$p)
#' data.frame(O = test$O, E = round(test$E, 2))   # observed vs. expected
#' @export
chi2_deca <- function(x, k = 10) {
  stopifnot("x must be in [0, 1]" = all(x >= 0 & x <= 1, na.rm = TRUE),
            "k must be an integer >= 2" = k >= 2 && k == round(k))
  O <- tabulate(pmax(ceiling(x * k), 1), k)        # observed
  E <- sum(!is.na(x)) * diff(pdeca((0:k) / k))     # expected
  if (any(E < 5)) warning("some expected frequencies are below 5")
  chi2 <- sum((O - E)^2 / E)
  list(chi2 = chi2, gl = k - 1, p = pchisq(chi2, k - 1, lower.tail = FALSE), O = O, E = E)
}
