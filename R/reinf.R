#' Probability Reinforcement Learning
#'
#' A classical reinforcement learning test.
#'
#' @template common
#' @template options
#' @return An object with the same class as `data` contains following values:
#'
#'   \item{pc_learn}{The total percent of correct in the learn phase.}
#'
#'   \item{pc_test}{The total percent of correct in the test phase.}
#'
#'   \item{pc_approach}{The percent of correct for approach trials.}
#'
#'   \item{pc_avoid}{The percent of correct for avoid trials.}
#' @export
reinf <- function(data, .by = NULL, .input = NULL, .extra = NULL) {
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
    summarise(
      pc = mean(.data[[.input$name_acc]]),
      .by = all_of(c(.by, "set"))
    ) |>
    pivot_wider(
      id_cols = all_of(.by),
      names_from = "set",
      values_from = "pc",
      names_prefix = "pc_"
    ) |>
    vctrs::vec_restore(data)
}
