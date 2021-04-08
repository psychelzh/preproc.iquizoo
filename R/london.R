#' London Tower
#'
#' A classical test on problem solving.
#'
#' @templateVar by low
#' @templateVar vars_input TRUE
#' @template params-template
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{total_score}{Total score defined by the game itself.}
#'   \item{mean_level}{Mean level reached.}
#'   \item{level_score}{Sum of mean score (a ratio) for each level.}
#' @export
london <- function(data, by, vars_input) {
  total_score <- data %>%
    dplyr::group_by(dplyr::across(dplyr::all_of(by))) %>%
    dplyr::summarise(
      total_score = sum(.data[[vars_input[["name_score"]]]]),
      .groups = "drop"
    )
  level_scores <- data %>%
    dplyr::mutate(
      score_ratio = ifelse(
        .data[[vars_input[["name_outcome"]]]] == 1,
        .data[[vars_input[["name_level"]]]] /
          .data[[vars_input[["name_steps"]]]],
        0
      )
    ) %>%
    dplyr::group_by(dplyr::across(
      dplyr::all_of(c(by, vars_input[["name_level"]]))
    )) %>%
    dplyr::summarise(
      pc = mean(.data[[vars_input[["name_outcome"]]]] == 1),
      score = mean(.data[["score_ratio"]]),
      .groups = "drop_last"
    ) %>%
    dplyr::summarise(
      mean_level = sum(.data[["pc"]]) +
        min(.data[[vars_input[["name_level"]]]]) - 0.5,
      level_score = sum(.data[["score"]]),
      .groups = "drop"
    )
  dplyr::left_join(total_score, level_scores, by = by)
}
