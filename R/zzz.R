#' @import rlang
#' @import dplyr
#' @import tidyr
NULL

#' Utility functions for data processing for IQUIZOO games.
#'
#' @section Package options:
#'
#' Preproc.iquizoo uses the following [options()] to configure behaviour:
#'
#' \itemize{
#'   \item `preproc.input`: input variable names, usu. named character.
#'
#'   \item `preproc.output`: output variables names.
#'
#'   \item `preproc.extra`: extra options such as values for certain input.
#'
#' }
#' @docType package
#' @keywords internal
#' @name preproc.iquizoo
"_PACKAGE"

preproc_default_options <- list(
  preproc.input = NULL,
  preproc.output = NULL,
  preproc.extra = NULL
)

.onLoad <- function(libname, pkgname) {
  op <- options()
  toset <- !(names(preproc_default_options) %in% names(op))
  if (any(toset)) options(preproc_default_options[toset])

  invisible()
}

# https://github.com/r-lib/tidyselect/issues/201
utils::globalVariables("where")
