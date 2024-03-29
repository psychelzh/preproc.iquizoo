% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{calc_sdt}
\alias{calc_sdt}
\title{Signal Detection Theory}
\usage{
calc_sdt(
  data,
  type_signal,
  ...,
  by = NULL,
  name_acc = "acc",
  name_type = "type"
)
}
\arguments{
\item{data}{Raw data of class \code{data.frame}.}

\item{type_signal}{The type of signal stimuli. It should be one of the values
in the \code{name_type} column of \code{data}.}

\item{...}{For future extensions. Should be empty.}

\item{by}{The column name(s) in \code{data} used to be grouped by. If set to
\code{NULL}, all data will be treated as from one subject.}

\item{name_acc}{The column name of the \code{data} input whose values are user's correctness, in which is a \code{numeric} vector so coded that 1 means scoring correct, 0 means scoring incorrect, and that -1 means no response is made.}

\item{name_type}{The column name of the \code{data} input whose values are the
stimuli types. Based on \code{type_signal}, the other types of stimuli will be
treated as non-signal stimuli.}
}
\value{
A \link[tibble:tibble-package]{tibble} contains sensitivity index and
bias (and other counts measures)
}
\description{
Calculate sensitivity index and bias based on signal detection theory. The
correction for extreme proportions of zero and one is the "log-linear" rule
recommended by Hautus (1995).
}
\keyword{internal}
