#' Call pre-processing function to get the performances of the given data
#'
#' This is the really "entry point" function that gives a convenient access to
#' all the pre-processing functions. The documentation of each of them can be
#' accessed to know its details of the returned values.
#'
#' @templateVar by high
#' @template params-template
#' @param prep_fun_name The name of a function, given as a [name][base::name] or
#'   literal character string, depending on whether `character.only` is `FALSE`
#'   (default) or `TRUE`. Only functions from this package is supported for now.
#' @param ... These dots are for future extensions and must be empty.
#' @param character.only A logical indicating whether `prep_fun_name` can be
#'   assumed to be character strings.
#' @return A [tibble][tibble::tibble-package] of game performances returned by
#'   low-level functions.
#' @author Liang Zhang <psychelzh@outlook.com>
#' @export
preproc_data <- function(data, prep_fun_name, by = NULL, ...,
                         character.only = FALSE) {
  if (!missing(...)) {
    ellipsis::check_dots_empty()
  }
  # match preprocessing function
  if (!character.only) {
    prep_fun_name <- deparse1(substitute(prep_fun_name))
  }
  prep_fun <- utils::getFromNamespace(prep_fun_name, utils::packageName())
  # validate data variable names
  vars_input <- match_data_vars(data, prep_fun_name)
  if (anyNA(vars_input)) {
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
  prep_fun(data = tibble(data), vars_input = vars_input, by = by) %>%
    dplyr::select(dplyr::all_of(
      # keep grouping variable when required
      c(if (keep.by) by, .get_output_vars(prep_fun_name))
    ))
}
