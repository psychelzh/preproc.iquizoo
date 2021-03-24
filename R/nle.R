#' Calculates index scores for Number Line Estimation game.
#'
#' Now the mean absolute error (mean_err) is calculated. Future work will
#' be to do model fitting.
#'
#' @param data Raw data of class `data.frame`.
#' @param ... Other input argument for future expansion.
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{mean_err}{Mean absolute error.}
#'   \item{mean_logerr}{Mean log absolute error.}
#'   \item{mean_sqrterr}{Mean square root of absolute error.}
#'   \item{is_normal}{Checking result whether the data is normal.}
#' @export
nle <- function(data, ...) {
  vars_output <- c("mean_err", "mean_logerr", "mean_sqrterr")
  vars_required <- tibble::tribble(
    ~field, ~name,
    "name_number", "Number",
    "name_resp", "Resp"
  )
  vars_matched <- match_data_vars(data, vars_required)
  if (is.null(vars_matched)) {
    return(
      rlang::set_names(
        rep(NA, length(vars_output)),
        nm = vars_output
      ) %>%
        tibble::as_tibble_row() %>%
        tibble::add_column(is_normal = FALSE)
    )
  }
  tibble(data) %>%
    dplyr::mutate(
      err = abs(.data[[vars_matched["name_number"]]] -
        .data[[vars_matched["name_resp"]]])
    ) %>%
    dplyr::summarise(
      mean_err = mean(.data[["err"]]),
      mean_logerr = mean(log(.data[["err"]] + 1)),
      mean_sqrterr = mean(sqrt(.data[["err"]])),
      is_normal = TRUE
    )
}
