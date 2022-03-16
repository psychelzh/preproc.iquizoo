#' Threshold estimation from staircase method
#'
#' A very simple method is used here, i.e., averaging all the levels in the last
#' block.
#'
#' This is under the assumption that the last block is stable enough so that an
#' average of the levels is just the convergence of the threshold.
#'
#' @template common
#' @template options
#' @return A [tibble][tibble::tibble-package] contains following values:
#'
#'   \item{thresh_peak_valley}{The mean threshold of peaks and valleys.}
#'
#'   \item{thresh_last_block}{The mean threshold of the last block.}
#'
#' @export
staircase <- function(data, .by = NULL, .input = NULL, .extra = NULL) {
  .input <- list(
    name_block = "block",
    name_level = "xtime",
    name_acc = "acc"
  ) |>
    update_settings(.input)
  data |>
    group_by(across(all_of(c(.by)))) |>
    summarise(
      thresh_peak_valley = calc_staircase_wetherill(.data[[.input$name_level]]),
      thresh_last_block = mean(
        rle(
          .subset(
            .data[[.input$name_level]],
            .data[[.input$name_block]] == max(.data[[.input$name_block]])
          )
        )$values
      ),
      .groups = "drop"
    )
}
