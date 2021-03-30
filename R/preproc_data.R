#' Call pre-processing function to get the performances of the given data
#'
#' This is the really "entry point" function that gives a convenient access to
#' all the pre-processing functions. The documentation of each of them can be
#' accessed to know its details of the returned values.
#'
#' @template para-data
#' @param prep_fun The function to be called. Currently, it should be a
#'   `symbol`, representing the function.
#' @param by The column name(s) in `data` used to be grouped by. If set to
#'   `NULL`, all data will be treated as from one subject and there will be no
#'   grouping columns in the value returned.
#' @param ... These dots are for future extensions and must be empty.
#' @return A [tibble][tibble::tibble-package] of game performances returned by
#'   low-level functions.
#' @author Liang Zhang <psychelzh@outlook.com>
preproc_data <- function(data, prep_fun, by = "id", ...) {
  if (!missing(...)) {
    ellipsis::check_dots_empty()
  }
  # validate data variable names
  prep_fun_name <- deparse1(substitute(prep_fun))
  vars_input <- match_data_vars(data, prep_fun_name)
  if (any(purrr::map_lgl(vars_input, is.na))) {
    warning("At least one of the required input variables does not exist.")
    return(NULL)
  }
  # checking grouping variable
  if (is.null(by)) {
    by <- "id"
    data[[by]] <- 1
    keep.by <- FALSE
  } else {
    if (!all(rlang::has_name(data, by))) {
      warning("At least one of the grouping variables does not exist.")
      return(NULL)
    }
    keep.by <- TRUE
  }
  # call the pre-processing function: note the tibble call
  iq_perf <- prep_fun(data = tibble(data), vars_input = vars_input, by = by)
  # delete grouping variable if not keeping
  if (!keep.by) {
    collapse::get_vars(iq_perf, by) <- NULL
  }
  iq_perf
}
