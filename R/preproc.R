#' Call low-level functions given data
#'
#' This is the really "entry point" function that gives a convenient access to
#' all the low-level pre-processing functions. These low-level functions are
#' also exported and documented with the details of the returned values.
#'
#' @templateVar .by high
#' @template params-template
#' @param .fn The name of a function, given as a [name][base::name] or literal
#'   character string, depending on whether `character.only` is `FALSE`
#'   (default) or `TRUE`.
#' @param ... These dots are for future extensions and must be empty.
#' @param character.only A logical indicating whether `.fn` can be assumed to be
#'   character strings.
#' @return A [tibble][tibble::tibble-package] of game performances returned by
#'   low-level functions. Attributes will be the same with `data`.
#' @author Liang Zhang <psychelzh@outlook.com>
#' @export
preproc <- function(data, .fn, .by = NULL, ..., character.only = FALSE) {
  if (!missing(...)) {
    ellipsis::check_dots_empty()
  }
  # match pre-processing function
  if (character.only) {
    .fn_name <- .fn
    .fn <- as_function(.fn)
  } else {
    .fn_name <- as_string(enexpr(.fn))
  }
  # checking grouping variable
  if (is.null(.by)) {
    .by <- ".dummy_id"
    data <- mutate(data, "{ .by }" := .by)
    keep_by <- FALSE
  } else {
    if (!all(rlang::has_name(data, .by))) {
      warn("Input `.by` does not match any name of `data`.", "by_invalid")
      return()
    }
    keep_by <- TRUE
  }
  # call the pre-processing function
  results <- data |>
    # transform character values to lowercase
    mutate(across(where(is.character), tolower)) |>
    .fn(.by)
  # default output all the computed indices
  output_vars <- getOption("preproc.output") %||% setdiff(names(results), .by)
  results |>
    # keep grouping variable when required
    select(all_of(c(if (keep_by) .by, output_vars))) |>
    vctrs::vec_restore(data)
}
