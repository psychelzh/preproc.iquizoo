#' NeuroRacer Modified
#'
#' This is a modified version of NeuroRacer game.
#'
#' @template common
#' @template options
#' @return An object with the same class as `data` contains following values:
#'
#'   \item{mean_score}{Mean overlap score.}
#'
#'   \item{dprime}{Sensitivity index of detection task.}
#'
#' @export
racer <- function(data, .by = NULL, .input = NULL, .extra = NULL) {
  .input <- list(
    name_trialdur = "trialdur",
    name_score = "escortscore",
    name_type = "type",
    name_acc = "acc"
  ) |>
    update_settings(.input)
  .extra <- list(type_signal = "target") |>
    update_settings(.extra)
  merge(
    summarise(
      data,
      mean_score = sum(
        .data[[.input$name_trialdur]] * .data[[.input$name_score]]
      ) / sum(.data[[.input$name_trialdur]]),
      .by = all_of(.by)
    ),
    calc_sdt(
      data,
      .extra$type_signal,
      by = .by,
      name_acc = .input$name_acc,
      name_type = .input$name_type
    ),
    by = .by
  ) |>
    select(all_of(c(.by, "mean_score", "dprime"))) |>
    vctrs::vec_restore(data)
}
