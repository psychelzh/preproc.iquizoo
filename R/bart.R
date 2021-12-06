#' Balloon Analogue Risk Task
#'
#' This task is deemed as a measure of impulsivity. Read more details on
#' [this website](http://www.impulsivity.org/measurement/BART).
#'
#' @template common
#' @template options
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{mean_pumps}{Mean of hits for balloons not exploded.}
#'   \item{mean_pumps_raw}{Mean of hits for all balloons.}
#'   \item{num_explosion}{Number of exploded balloons.}
#' @export
bart <- function(data, .by = NULL, .input = NULL, .extra = NULL) {
  .input <- list(name_feedback = "feedback", name_nhit = "nhit") |>
    update_settings(.input)
  data |>
    group_by(across(all_of(.by))) |>
    summarise(
      mean_pumps = weighted.mean(
        .data[[.input[["name_nhit"]]]],
        .data[[.input[["name_feedback"]]]] == 1
      ),
      mean_pumps_raw = mean(.data[[.input[["name_nhit"]]]]),
      num_explosion = sum(.data[[.input[["name_feedback"]]]] == 0),
      .groups = "drop"
    )
}
