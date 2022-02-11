#' Probability Reinforcement Learning
#'
#' A classical reinforcement learning test.
#'
#' @template common
#' @template options
#' @return A [tibble][tibble::tibble-package] contains following values:
#'
#'   \item{pc_test}{The total percent of correct in the test phase.}
#'
#'   \item{pc_approach}{The percent of correct for approach trials.}
#'
#'   \item{pc_avoid}{The percent of correct for avoid trials.}
#'
#' @export
reinf <- function(data, .by = NULL, .input = NULL, .extra = NULL) {
  .input <- list(
    name_phase = "phase",
    name_cresp = "cresp",
    name_acc = "acc"
  ) |>
    update_settings(.input)
  .extra <- list(
    phase_test = "test",
    type_approach = "a"
  ) |>
    update_settings(.extra)
  data_cor <- data |>
    filter(.data$phase == .extra$phase_test)
  bind_rows(
    overall = data_cor,
    sep = data_cor,
    .id = "set"
  ) |>
    mutate(
      type = case_when(
        set == "overall" ~ "test",
        .data[[.input$name_cresp]] == .extra$type_approach ~ "approach",
        TRUE ~ "avoid"
      )
    ) |>
    group_by(across(all_of(c(.by, "type")))) |>
    summarise(
      pc = mean(.data[[.input$name_acc]]),
      .groups = "drop"
    ) |>
    pivot_wider(
      names_from = "type",
      values_from = "pc",
      names_prefix = "pc_"
    )
}
