#' distDECA: the DECA distribution - construction, simulation and validation
#'
#' Package developed for Project 1 of the Simulation course (ESPOCH). It
#' implements the continuous DECA distribution (Densidad Exponencial Cuadratica
#' Acotada, i.e. bounded quadratic exponential density) on \eqn{[0,1]},
#' with density \eqn{f(x) = 2x e^{x^2}/(e-1)}.
#'
#' @section Functions:
#' \itemize{
#'   \item \code{\link{ddeca}}: density \eqn{f(x)} (Step 1).
#'   \item \code{\link{pdeca}}: cumulative distribution function \eqn{F(x)} (Step 2).
#'   \item \code{\link{rdeca}}: random generation by the inverse transform
#'     method (Steps 3 and 4).
#'   \item \code{\link{chi2_deca}}: chi-square goodness-of-fit test.
#' }
#'
#' @section Requirements:
#' Only R (>= 4.0.0) is needed. The package uses \code{runif()} and
#' \code{pchisq()} from \pkg{stats}; the plotting examples use \code{hist()}
#' and \code{curve()} from \pkg{graphics}. Both packages ship with R, so no
#' other packages have to be installed. The package contains only R code, so
#' no compiler (Rtools) is needed.
#'
#' @section Typical use:
#' \preformatted{
#' set.seed(2024)
#' x <- rdeca(1000)
#' chi2_deca(x)
#' }
#'
#' @importFrom stats runif pchisq
#' @keywords internal
"_PACKAGE"
