#' Raven's Advanced Progressive Matrices
#'
#' This test contains two sets, namely set I and set II, and set I is a practice
#' set, whereas set II is the test set. So scores for each set and whole set are
#' calculated here.
#'
#' @template common
#' @template options
#' @return A [tibble][tibble::tibble-package] contains following values:
#'
#'   \item{nc_prac}{Number of correct items for set I.}
#'
#'   \item{nc_test}{Number of correct items for set II.}
#'
#'   \item{nc_total}{Number of correct items for whole set.}
#'
#' @export
rapm <- function(data, .input = NULL, .extra = NULL) {
  .input <- list(name_block = "block", name_acc = "acc") |>
    update_settings(.input)
  .extra <- list(block_prac = 1, block_test = 2) |>
    update_settings(.extra)
  data |>
    mutate(
      block = case_when(
        .data[[.input$name_block]] %in% .extra$block_prac ~ "prac",
        .data[[.input$name_block]] %in% .extra$block_test ~ "test"
      )
    ) |>
    group_by(.data$block) |>
    group_modify(~ countcorrect(.x, .input = .input, .extra = .extra)) |>
    ungroup() |>
    pivot_wider(
      names_from = .data$block,
      values_from = .data$nc,
      names_prefix = "nc_"
    ) |>
    mutate(nc_total = .data$nc_prac + .data$nc_test)
}
