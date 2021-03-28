#' Get the matched variables for input data
#'
#' Input data require several variables to be existed, and some variables can
#' have alternatives. Here we check if all the variables exist, and if only one
#' of the alternatives exists for each variable. If the check is passed, the
#' matched result (a character vector) will be returned, or else a `NULL` value
#' will be returned.
#'
#' @param data Raw data of class `data.frame`.
#' @param prep_fun_name The name of the called pre-processing function.
#' @return A `list` of the matched variables, using `NA` value to represent not
#'   found, and using the names configured in the internal data.
#' @keywords internal
match_data_vars <- function(data, prep_fun_name) {
  purrr::map(
    .get_input_vars(prep_fun_name),
    ~ .find_matches(data, .x)
  )
}

.find_matches <- function(data, var_name) {
  match_result <- rlang::has_name(data, var_name)
  if (sum(match_result) != 1) {
    return(NA_character_)
  }
  var_name[match_result]
}
