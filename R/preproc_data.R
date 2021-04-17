#' Call low-level functions given data
#'
#' This is the really "entry point" function that gives a convenient access to
#' all the low-level pre-processing functions. These low-level functions are
#' also exported and documented with the details of the returned values.
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
  # match pre-processing function
  if (!character.only) {
    prep_fun_name <- deparse1(substitute(prep_fun_name))
  }
  prep_fun <- utils::getFromNamespace(prep_fun_name, utils::packageName())
  # validate data variable names
  if (is_empty(data)) {
    warn("Input `data` is empty.", "data_empty")
    return()
  }
  vars_input <- match_data_vars(data, prep_fun_name)
  if (anyNA(vars_input)) {
    warn("Input `data` miss required variable(s).", "data_invalid")
    return()
  }
  # checking grouping variable
  if (is.null(by)) {
    by <- "id"
    data[[by]] <- 1
    keep_by <- FALSE
  } else {
    if (!all(has_name(data, by))) {
      warn("Input `by` does not match any name of `data`.", "by_invalid")
      return()
    }
    keep_by <- TRUE
  }
  # call the pre-processing function
  data %>%
    # transform character values to lowercase
    dplyr::mutate(
      dplyr::across(
        tidyselect::vars_select_helpers$where(is.character),
        tolower
      )
    ) %>%
    prep_fun(vars_input = vars_input, by = by) %>%
    dplyr::select(dplyr::all_of(
      # keep grouping variable when required
      c(if (keep_by) by, .get_output_vars(prep_fun_name))
    )) %>%
    vctrs::vec_restore(data)
}
