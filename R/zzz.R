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

# https://github.com/r-lib/tidyselect/issues/201
utils::globalVariables("where")
