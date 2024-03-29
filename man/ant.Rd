% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ant.R
\name{ant}
\alias{ant}
\alias{ant_orient}
\alias{ant_alert}
\title{Attention Network Test}
\usage{
ant_orient(data, .by = NULL, .input = NULL, .extra = NULL)

ant_alert(data, .by = NULL, .input = NULL, .extra = NULL)
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

Executive function score (prefix \code{cong_eff}), total orienting scores
(prefix \code{orient}), endogenous orienting scores (prefix \code{orient_endo}),
exogenous orienting scores (prefix \code{orient_exo}), total alerting scores
(prefix \code{alert}), audio alerting scores (prefix \code{alert_aud}) and visual
alerting scores (prefix \code{alert_vis}) for the following performances:

\item{pc}{Percent of correct.}

\item{mrt}{Mean reaction time.}

\item{ies}{Inverse efficiency score.}

\item{rcs}{Rate correct score.}

\item{lisas}{Linear integrated speed-accuracy score.}
}
\description{
The indices for ANT task are calculated.
}
