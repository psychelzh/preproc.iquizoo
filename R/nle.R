#' Number Line Estimation
#'
#' A classical test on subject's numerical estimation skills.
#'
#' @template common
#' @template options
#' @return An object with the same class as `data` contains following values:
#'
#'   \item{mean_abs_err}{Mean absolute error.}
#'
#'   \item{mean_log_err}{Mean log absolute error.}
#' @export
nle <- function(data, .by = NULL, .input = NULL, .extra = NULL) {
  .input <- list(name_number = "number", name_resp = "resp") |>
    update_settings(.input)
  data |>
    mutate(
      err = abs(.data[[.input$name_number]] -
                  .data[[.input$name_resp]])
    ) |>
    summarise(
      mean_abs_err = mean(.data$err),
      mean_log_err = mean(log(.data$err + 1)),
      .by = all_of(.by)
    ) |>
    vctrs::vec_restore(data)
}
