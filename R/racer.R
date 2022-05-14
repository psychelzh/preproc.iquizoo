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
    data |>
      group_by(across(all_of(.by))) |>
      summarise(
        mean_score = sum(
          .data[[.input$name_trialdur]] * .data[[.input$name_score]]
        ) / sum(.data[[.input$name_trialdur]]),
        .groups = "drop"
      ),
    data |>
      mutate(
        type_cor = if_else(
          .data[[.input$name_type]] == .extra$type_signal,
          "s", "n"
        )
      ) |>
      calc_sdt(
        by = .by,
        name_acc = .input$name_acc,
        name_type = "type_cor"
      ),
    by = .by
  ) |>
    select(all_of(c(.by, "mean_score", "dprime"))) |>
    vctrs::vec_restore(data)
}
