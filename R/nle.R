#' Number Line Estimation
#'
#' A classical test on subject's numerical estimation skills.
#'
#' @templateVar .by low
#' @template params-template
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{mean_abs_err}{Mean absolute error.}
#'   \item{mean_log_err}{Mean log absolute error.}
#' @export
nle <- function(data, .by = NULL) {
  .input <- list(name_number = "number", name_resp = "resp") |>
    update_settings("preproc.input")
  data |>
    mutate(
      err = abs(.data[[.input[["name_number"]]]] -
        .data[[.input[["name_resp"]]]])
    ) |>
    group_by(across(all_of(.by))) |>
    summarise(
      mean_abs_err = mean(.data[["err"]]),
      mean_log_err = mean(log(.data[["err"]] + 1)),
      .groups = "drop"
    )
}
