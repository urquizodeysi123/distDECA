# distDECA

R package for the **construction, simulation and validation of the continuous DECA distribution** (*Densidad Exponencial Cuadrática Acotada*: bounded quadratic exponential density), developed for Project 1 of the Simulation course (Statistics program, Faculty of Sciences, ESPOCH).

**Authors:** Karina Manya, Angie Garzón, Deisy Urquizo and Christian Herrera.

---

## Requirements

| Requirement | Needed? | Notes |
|---|---|---|
| **R ≥ 4.0.0** | Yes | Download it from [CRAN](https://cran.r-project.org/). Check your version with `R.version.string`. |
| RStudio | Recommended | Optional editor, free from [Posit](https://posit.co/download/rstudio-desktop/). |
| `stats` package | Yes | Used by `rdeca()` (`runif`) and `chi2_deca()` (`pchisq`). **Ships with R**: nothing to install. |
| `graphics` package | Only for the plotting examples | Used by `curve()` and `hist()`. **Ships with R**: nothing to install. |
| `devtools` package | Yes, to install | Installs the package from GitHub: `install.packages("devtools")` |
| Rtools (Windows) / Xcode (macOS) | **No** | The package contains only R code (no C/C++), so no compiler is needed. |
| Other CRAN packages | **No** | The package has no other dependencies. |

## Installation

Run these two lines in the R console:

```r
install.packages("devtools")                     # only once
devtools::install_github("urquizodeysi123/distDECA")
```

**Check that it works:**

```r
library(distDECA)
ls("package:distDECA")
#> [1] "chi2_deca" "ddeca"     "pdeca"     "rdeca"
```

## What is the DECA distribution?

It is a continuous probability distribution proposed by the group, defined on the interval $[0,1]$:

$$
f(x) = \begin{cases} 0, & x < 0 \\ \dfrac{2x\,e^{x^2}}{e-1}, & 0 \le x \le 1 \\ 0, & x > 1 \end{cases}
$$

The name describes it: its **density** contains the **quadratic exponential** term $e^{x^2}$ and it is **bounded** to the interval $[0,1]$; the density is increasing.

| Element | Expression |
|---|---|
| Density | $f(x) = 2x\,e^{x^2}/(e-1)$ |
| Cumulative distribution function | $F(x) = (e^{x^2}-1)/(e-1)$ |
| Inverse CDF | $F^{-1}(u) = \sqrt{\ln(1 + u(e-1))}$ |
| Mean | $E[X] \approx 0.7307$ |
| Variance | $\mathrm{Var}(X) \approx 0.0480$ |

The density is valid (non-negative and integrates to 1) and it is curved (increasing and convex). It may be useful for modelling proportions concentrated at high values. If $Y = X^2$, then $Y$ follows a continuous Bernoulli distribution with natural parameter $\theta = 1$; the distribution of $X = \sqrt{Y}$ is not implemented in other R packages, so it is provided here.

## Functions

| Function | What it does | Arguments | Returns |
|---|---|---|---|
| `ddeca(x)` | Density $f(x)$ | `x`: numeric vector | Density values (0 outside $[0,1]$) |
| `pdeca(q)` | Cumulative probability $P(X \le q)$ | `q`: numeric vector | Probabilities (0 if $q<0$, 1 if $q>1$) |
| `rdeca(n)` | Random numbers by the inverse transform method | `n`: sample size | Vector of `n` values in $[0,1]$ |
| `chi2_deca(x, k = 10)` | Chi-square goodness-of-fit test | `x`: sample in $[0,1]$; `k`: integer number of intervals, $\ge 2$ | List with `chi2`, `gl` (degrees of freedom), `p`, `O` (observed) and `E` (expected) |

`chi2_deca()` ignores `NA` values, stops with an error if `x` has values outside $[0,1]$ or if `k` is not an integer $\ge 2$, and warns if any expected frequency is below 5.

Each function has its own help page: `?ddeca`, `?pdeca`, `?rdeca`, `?chi2_deca`, or `help(package = "distDECA")`.

## Short examples

```r
library(distDECA)

# Density
ddeca(c(0, 0.5, 1))
#> [1] 0.0000000 0.7472729 3.1639534

# Cumulative probability
pdeca(0.5)                  # P(X <= 0.5)
#> [1] 0.1652962
pdeca(0.8) - pdeca(0.2)     # P(0.2 < X <= 0.8)
#> [1] 0.4979801

# Random numbers
set.seed(2024)
rdeca(3)
#> [1] 0.9440447 0.6626610 0.8799386

# Goodness-of-fit test
set.seed(2024)
test <- chi2_deca(rdeca(1000))
c(chi2 = test$chi2, df = test$gl, p = test$p)
#>      chi2        df         p
#> 5.1485357 9.0000000 0.8211725
```

With $p = 0.821 > 0.05$, the hypothesis that the sample comes from the DECA distribution is not rejected.

## Complete example (with plots)

```r
library(distDECA)

set.seed(2024)
x <- rdeca(1000)                                   # simulate n = 1000

hist(x, breaks = (0:10) / 10, freq = FALSE,        # histogram of the sample
     col = "lightblue", main = "DECA: sample vs. density")
curve(ddeca(x), add = TRUE, col = "red", lwd = 2)  # theoretical density

test <- chi2_deca(x)                               # chi-square test
data.frame(O = test$O, E = round(test$E, 2))       # observed vs. expected
```

## Troubleshooting

| Message | Cause | Solution |
|---|---|---|
| `there is no package called 'distDECA'` | The package is not installed | Run the installation commands above. |
| `there is no package called 'devtools'` | `devtools` is missing | `install.packages("devtools")` |
| `Permission denied` / `cannot remove prior installation` | An older version is loaded, or the folder is synchronised by OneDrive | *Session → Restart R* and install again; if it persists, move the folder outside OneDrive. |
| `x must be in [0, 1]` | The sample passed to `chi2_deca()` has values outside $[0,1]$ | Use a sample generated with `rdeca()` or check your data. |
| `k must be an integer >= 2` | `k` in `chi2_deca()` is a decimal or smaller than 2 | Use an integer such as `k = 10`. |

## Repository structure

```
distDECA/
├── DESCRIPTION          # package metadata and dependencies
├── NAMESPACE            # exported functions (generated by roxygen2)
├── LICENSE              # MIT license
├── README.md            # this page
├── distDECA.Rproj       # RStudio project
├── R/                   # one script per function
│   ├── ddeca.R
│   ├── pdeca.R
│   ├── rdeca.R
│   ├── chi2_deca.R
│   └── distDECA-package.R
└── man/                 # help pages (generated by roxygen2)
```

## For developers

Only needed if you modify the code. Requires the `roxygen2` package (`install.packages("roxygen2")`).

```r
roxygen2::roxygenise()                                  # updates man/ and NAMESPACE
install.packages(".", repos = NULL, type = "source")    # reinstalls the package
```

## License

MIT © 2026 Karina Manya, Angie Garzón, Deisy Urquizo and Christian Herrera.
