% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/functions.R
\name{mse}
\alias{mse}
\title{Multiple Systems Estimation}
\usage{
mse(
  model,
  dframe,
  lat = NULL,
  nclass = 1,
  crit = 1e-07,
  maxiter = 5000,
  seed = 1
)
}
\arguments{
\item{model}{formula of the model to be fitted. Population registers should be denoted by
a single upper case letter, and covariates by single lower case letter. Latent variables
are denoted by single upper case letters, as specified in \code{lat}.}

\item{dframe}{a data frame with the data, either as individual
records or as a contingency table with the variable \code{Freq} denoting the observed
frequencies of the response patterns. Population registers should be coded 0 if not
observed, and 1 if observed.}

\item{lat}{a character (vector) with the letter(s) denoting the latent variable(s) in
\code{model}. The default \code{NULL} is used to denote absence of latent variables.}

\item{nclass}{a numeric vector with the number of classes of the latent variable(s)
specified in \code{lat}, if present.}

\item{crit}{the convergence criterion of the EM algorithm computed as the difference
of the incomplete data log-likelihood between the current and previous iteration.
Defaults to 1e-7.}

\item{maxiter}{the maximum number of EM iterations. Defaults to 5000.}

\item{seed}{random seed determining the starting values of the EM algorithm. Defaults to 1.}
}
\value{
list with fitted objects, and input for the function \code{\link{boot_mse}}.
\item{model}{the model formula.}
\item{loglike}{the maximized incomplete data log-likelihood.}
\item{pse}{matrix with the observed sample size, the population size estimate, and estimated
frequency of the cells with structural zeros.}
\item{coefs}{matrix with the log-linear parameter estimates, SE's, and t- and p-values.}
\item{probs}{matrix with the fitted population probabilities of the variable levels.}
\item{fitted}{matrix with variables and fitted frequencies.}
\item{hist}{iteration history.}
\item{nclass}{a with the number(s) of classes of the latent variable(s), if any.}
\item{dobsmis}{contingency table excluding structural zeros and including missings.}
\item{dimp}{a matrix used for imputing the missings.}
\item{D}{the design matrix of the log-linear model.}
\item{fxc}{starting values for the bootstrap function.}
}
\description{
\code{mse} fits a loglinear model with the EM algorithm with imputation
of missing values, and the potential inclusion of latent class variables. If population
registers are included in the model, the function classifies the cells that are not
observed as structural zeros and performs multiple sytems estimation.
}
\details{
The Hessian may not be invertible when the model is overparametrized or when the
starting values for the EM algorithm are poorly chosen. In the latter case, changing the seed
may result in better starting values and consequently in an invertible Hessian.
}
\examples{
## Fit the maximal model for registers A and B and covariates a and b
AB <- mse(Freq ~ A*b + B*a + a*b, dframe = NewZealand[, c(1:2, 5:6, 9)])

## Fit a model with two latent classes for a, b, c and d.
mse(Freq ~ A + B + C + D + X*(a + b + c + d), dframe = NewZealand, lat = "X", nclass = 2)
}
