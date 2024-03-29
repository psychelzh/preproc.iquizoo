% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/multisense.R
\name{multisense}
\alias{multisense}
\title{Multiple Sensory Integration}
\usage{
multisense(data, .by = NULL, .input = NULL, .extra = NULL)
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

\item{mrt_image}{Mean reaction time of Image stimuli.}

\item{mrt_sound}{Mean reaction time of Sound stimuli.}

\item{mrt_mixed}{Mean reaction time of Mixed stimuli.}

\item{mrt_mixadv}{Mean reaction decrease of Mixed stimuli compared to other
two types of stimuli.}
}
\description{
There will typically be some speed advantage if there are more than one
sensory inputs to be employed. This function calculates this advantage.
}
