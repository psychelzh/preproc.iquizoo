#' Probability Reinforcement Learning
#'
#' A classical reinforcement learning test.
#'
#' @template common
#' @template options
#' @return A [tibble][tibble::tibble-package] contains following values:
#'
#'   \item{pc_approach}{The percent of correct for approach trials.}
#'
#'   \item{pc_avoid}{The percent of correct for avoid trials.}
#'
#'   \item{pc_learn}{The total percent of correct in the learn phase.}
#'
#'   \item{pc_test}{The total percent of correct in the test phase.}
#' @export
reinf <- function(data, .input = NULL, .extra = NULL) {
  .input <- list(
    name_phase = "phase",
    name_cresp = "cresp",
    name_acc = "acc"
  ) |>
    update_settings(.input)
  .extra <- list(
    phase_learn = "learn",
    phase_test = "test",
    type_approach = "a"
  ) |>
    update_settings(.extra)
  bind_rows(
    learn = filter(data, .data$phase == .extra$phase_learn),
    test = filter(data, .data$phase == .extra$phase_test),
    sep = filter(data, .data$phase == .extra$phase_test),
    .id = "set"
  ) |>
    mutate(
      set = if_else(
        .data$set == "sep",
        if_else(
          .data[[.input$name_cresp]] == .extra$type_approach,
          "approach", "avoid"
        ),
        .data$set
      )
    ) |>
    group_by(.data$set) |>
    summarise(
      pc = mean(.data[[.input$name_acc]]),
      .groups = "drop"
    ) |>
    pivot_wider(
      names_from = "set",
      values_from = "pc",
      names_prefix = "pc_"
    )
}
