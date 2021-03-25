#' Calculates index scores for London Tower game.
#'
#' Two indices are returned: total scores (defined in the game itself), ratio
#' score (defined as the mean of the ratios between best steps and actual steps)
#' and mean level.
#'
#' @param data Raw data of class `data.frame`.
#' @param ... Other input argument for future expansion.
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{total_score}{Total score defined by the game itself.}
#'   \item{ratio_score}{Mean of the ratio between best steps and actual steps.}
#'   \item{mean_level}{Mean level reached.}
#'   \item{is_normal}{Checking result whether the data is normal.}
#' @export
london <- function(data, ...) {
  vars_output <- c("total_score", "ratio_score", "mean_level")
  vars_required <- tibble::tribble(
    ~field, ~name,
    "name_level", c("LeveL", "Level"),
    "name_score", "Score",
    "name_outcome", "Outcome",
    "name_finished", "Finished",
    "name_steps", "StepsUsed"
  )
  vars_matched <- match_data_vars(data, vars_required)
  if (is.null(vars_matched)) {
    return(compose_abnormal_output(vars_output))
  }
  total_score <- data %>%
    dplyr::summarise(total_score = sum(.data[[vars_matched["name_score"]]]))
  ratio_score <- data %>%
    dplyr::mutate(
      ratio = dplyr::if_else(
        .data[[vars_matched["name_finished"]]] == 0 |
          .data[[vars_matched["name_steps"]]] == 0,
        0,
        .data[[vars_matched["name_level"]]] /
          .data[[vars_matched["name_steps"]]]
      )
    ) %>%
    dplyr::summarise(ratio_score = mean(.data[["ratio"]]))
  mean_level <- data %>%
    dplyr::group_by(.data[[vars_matched["name_level"]]]) %>%
    dplyr::summarise(
      pc = mean(.data[[vars_matched["name_outcome"]]] == 1)
    ) %>%
    dplyr::summarise(
      mean_level = min(.data[[vars_matched["name_level"]]]) - 0.5 +
        sum(.data$pc)
    )
  # the response is not normal when user responded to no more than 80% in total
  is_normal <- mean(data[[vars_matched["name_steps"]]] == 0) < 0.2
  tibble(total_score, ratio_score, mean_level, is_normal)
}
