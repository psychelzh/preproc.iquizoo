% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/symncmp.R
\name{symncmp}
\alias{symncmp}
\title{Symbolic Number Comparison}
\usage{
symncmp(data, .by = NULL, .input = NULL, .extra = NULL)
}
\arguments{
\item{data}{Raw data of class \code{data.frame}.}

\item{.by}{The column name(s) in \code{data} used to be grouped by. If set to
\code{NULL} (default), all data will be treated as from one subject and there
will be no grouping columns in the value returned.}

\item{.input, .extra}{Each is a \code{\link[=list]{list()}} containing all the input variable
names and special values for certain variables. See more in the details
section.}
}
\value{
An object with the same class as \code{data} contains following values:

\item{pc}{Percentage of correct responses.}

\item{mrt}{Mean reaction time.}

\item{dist_eff}{Distance effect.}
}
\description{
Several values including percentage of correct responses (pc), mean reaction
time (mrt), distance effect (dist_effect) and adjusted distance effect
(dist_effect_cor).
}
\seealso{
\code{\link[=nsymncmp]{nsymncmp()}} for non-symbolic number comparison.
}
