#' Get the matched variables for input data
#'
#' Input data require several variables to be existed, and some variables can
#' have alternatives. Here we check if all the variables exist, and if only one
#' of the alternatives exists for each variable. If the check is passed, the
#' matched result (a character vector, `NA` means not found) will be returned.
#'
#' @param data Raw data of class `data.frame`.
#' @param prep_fun_name The name of the called pre-processing function.
#' @param config Configuration of data variable names to match
#' @return A `list` of the matched variables, using `NA` value to represent not
#'   found, and using the names configured in `config`.
#' @keywords internal
match_data_vars <- function(data, prep_fun_name, config) {
  purrr::map(
    .get_input_vars(prep_fun_name, config),
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

#' Get variable names of data
#'
#' An internal data-set is used to store data variables, which should not be
#' visited directly by any other functions. Here is two functions to get its
#' "input" and "output" variables.
#'
#' @name get_data_vars
#' @param prep_fun_name The name of the called pre-processing function.
#' @param config Configuration of data variable names to match.
#' @keywords internal
NULL

#' @rdname get_data_vars
.get_input_vars <- function(prep_fun_name, config) {
  stopifnot(rlang::has_name(config, prep_fun_name))
  config[[prep_fun_name]][["input"]]
}

#' @rdname get_data_vars
.get_output_vars <- function(prep_fun_name, config) {
  stopifnot(rlang::has_name(config, prep_fun_name))
  config[[prep_fun_name]][["output"]]
}
