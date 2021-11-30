#' London Tower
#'
#' A classical test on problem solving.
#'
#' @templateVar .by low
#' @template params-template
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{total_score}{Total score defined .by the game itself.}
#'   \item{mean_level}{Mean level reached.}
#'   \item{level_score}{Sum of mean score (a ratio) for each level.}
#' @export
london <- function(data, .by) {
  .input <- list(
    name_level = "level",
    name_score = "score",
    name_outcome = "outcome",
    name_steps = "stepsused"
  ) |>
    update_settings("preproc.input")
  total_score <- data |>
    group_by(across(all_of(.by))) |>
    summarise(
      total_score = sum(.data[[.input[["name_score"]]]]),
      .groups = "drop"
    )
  level_scores <- data |>
    mutate(
      score_ratio = ifelse(
        .data[[.input[["name_outcome"]]]] == 1,
        .data[[.input[["name_level"]]]] /
          .data[[.input[["name_steps"]]]],
        0
      )
    ) |>
    group_by(across(
      all_of(c(.by, .input[["name_level"]]))
    )) |>
    summarise(
      pc = mean(.data[[.input[["name_outcome"]]]] == 1),
      score = mean(.data[["score_ratio"]]),
      .groups = "drop_last"
    ) |>
    summarise(
      mean_level = sum(.data[["pc"]]) +
        min(.data[[.input[["name_level"]]]]) - 0.5,
      level_score = sum(.data[["score"]]),
      .groups = "drop"
    )
  left_join(total_score, level_scores, by = .by)
}
