#' Compose output containing `NA`s with names required
#'
#' @param vars_output Variable names in the output
#' @return Use `NA_real` as values. And a variable of `FALSE` value is added.
#' @keywords internal
compose_abnormal_output <- function(vars_output) {
  rlang::set_names(
    rep(NA_real_, length(vars_output)),
    nm = vars_output
  ) %>%
    tibble::as_tibble_row() %>%
    tibble::add_column(is_normal = FALSE)
}
