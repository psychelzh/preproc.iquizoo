#' Balloon Analogue Risk Task
#'
#' This task is deemed as a measure of impulsivity.
#'
#' @template common
#' @template options
#' @return An object with the same class as `data` contains following values:
#'   \item{mean_pumps}{Mean of hits for balloons not exploded.}
#'   \item{mean_pumps_raw}{Mean of hits for all balloons.}
#'   \item{num_explosion}{Number of exploded balloons.}
#' @export
bart <- function(data, .by = NULL, .input = NULL, .extra = NULL) {
  .input <- list(name_feedback = "feedback", name_nhit = "nhit") |>
    update_settings(.input)
  data |>
    summarise(
      mean_pumps = .data[[.input$name_nhit]] |>
        # keep not exploded trials only
        .subset(.data[[.input$name_feedback]] == 1) |>
        mean(),
      mean_pumps_raw = mean(.data[[.input$name_nhit]]),
      num_explosion = sum(.data[[.input$name_feedback]] == 0),
      .by = all_of(.by)
    ) |>
    vctrs::vec_restore(data)
}
