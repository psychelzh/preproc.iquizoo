#' Call pre-processing function to get the performances of the given data
#'
#' This is the really "entry point" function that gives a convenient access to
#' all the pre-processing functions. The documentation of each of them can be
#' accessed to know its details of the returned values.
#'
#' @param data Raw data to be pre-processed. Should be of `data.frame` class.
#' @param prep_fun The function to be called. Currently, it should be a
#'   `symbol`, representing the function.
preproc_data <- function(data, prep_fun, by = "id", ...) {
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
  prep_fun(tibble(data), by, vars_input, keep.by = keep.by, ...)
}
