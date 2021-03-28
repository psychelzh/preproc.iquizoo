#' Get the matched variables for input data
#'
#' Input data require several variables to be existed, and some variables can
#' have alternatives. Here we check if all the variables exist, and if only one
#' of the alternatives exists for each variable. If the check is passed, the
#' matched result (a character vector) will be returned, or else a `NULL` value
#' will be returned.
#'
#' @param data Required. Raw data, a `data.frame`.
#' @param vars_config Required. A `data.frame` containing the configuration of
#'   required variables. Possible variables are:
#'   * `field`: Required. Name references of all data variable names.
#'   * `name`: Required. Data variable names, in which lists all the possible
#'   names for current data variable.
#'   * `type`: Optional. Can be "required" (must exist) or "optional" (try to
#'     match, if not find, `NA` is returned and it must be handled in another
#'     place). If this variable is not specified, it will default to "required".
#' @keywords internal
match_data_vars <- function(data, vars_config) {
  # set default type to "required"
  if (!utils::hasName(vars_config, "type")) {
    vars_config$type <- "required"
  }
  vars_chk_result <- vars_config %>%
    dplyr::mutate(purrr::map_df(.data$name, ~ .find_matches(data, .x)))
  if (!all(vars_chk_result$is_found[vars_chk_result$type == "required"])) {
    warning("At least one of the required variables are missing.")
    return(NULL)
  }
  if (any(vars_chk_result$is_confused)) {
    warning("At least one of the variables have more than one match.")
    return(NULL)
  }
  return(
    vars_chk_result %>%
      dplyr::select(.data$field, .data$matched) %>%
      tibble::deframe()
  )
}

.find_matches <- function(data, name) {
  match_result <- rlang::has_name(data, name)
  tibble(
    is_found = any(match_result),
    is_confused = sum(match_result) > 1,
    # the match can be of length 0, so use `if` instead of `if_else`
    matched = if (sum(match_result) == 1) name[match_result] else NA
  )
}
