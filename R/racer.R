#' NeuroRacer Modified
#'
#' This is a modified version of NeuroRacer game.
#'
#' @template common
#' @template options
#' @return A [tibble][tibble::tibble-package] contains following values:
#'
#'   \item{mean_pro_ratio}{Mean protection duration ratio.}
#'
#'   \item{dprime}{Sensitivity index of detection task.}
#'
#' @export
racer <- function(data, .input = NULL, .extra = NULL) {
  .input <- list(
    name_traildur = "trialdur",
    name_produr = "produr",
    name_type = "type",
    name_acc = "acc"
  ) |>
    update_settings(.input)
  .extra <- list(type_signal = "target") |>
    update_settings(.extra)
  bind_cols(
    data |>
      mutate(
        pro_ratio = .data[[.input$name_produr]] /
          .data[[.input$name_traildur]]
      ) |>
      summarise(mean_pro_ratio = mean(.data$pro_ratio)),
    data |>
      mutate(
        type_cor = if_else(
          .data[[.input$name_type]] == .extra$type_signal,
          "s", "n"
        )
      ) |>
      calc_sdt(
        name_acc = .input$name_acc,
        name_type = "type_cor",
        keep_bias = FALSE,
        keep_counts = FALSE
      )
  )
}
