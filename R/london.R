#' Calculates index scores for London Tower game.
#'
#' Two indices are returned: total scores (defined in the game itself), ratio
#' score (defined as the mean of the ratios between best steps and actual steps)
#' and mean level.
#'
#' @param data Raw data of class `data.frame`.
#' @param ... Other input argument for future expansion.
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{tscore}{Total score defined by the game itself.}
#'   \item{ratio_score}{Mean of the ratio between best steps and actual steps.}
#'   \item{mean_level}{Mean level reached.}
#'   \item{is_normal}{Checking result whether the data is normal.}
#' @export
london <- function(data, ...) {
  vars_output <- c("tscore", "ratio_score", "mean_level")
  vars_required <- tibble::tribble(
    ~field, ~name,
    "name_level", c("LeveL", "Level"),
    "name_score", "Score",
    "name_outcome", "Outcome"
  )
  vars_matched <- match_data_vars(data, vars_required)
  if (is.null(vars_matched)) {
    return(
      rlang::set_names(
        rep(NA, length(vars_output)),
        nm = vars_output
      ) %>%
        tibble::as_tibble_row() %>%
        tibble::add_column(is_normal = FALSE)
    )
  }
  tscore <- data %>%
    dplyr::summarise(tscore = sum(.data$Score))
  ratio_score <- data %>%
    dplyr::mutate(
      ratio = dplyr::if_else(
        .data$Finished == 0,
        0, .data$LeveL / .data$StepsUsed
      )
    ) %>%
    dplyr::summarise(ratio_score = mean(.data$ratio))
  mean_level <- data %>%
    dplyr::group_by(.data[[vars_matched[["name_level"]]]]) %>%
    dplyr::summarise(pc = mean(.data$Outcome == 1)) %>%
    dplyr::summarise(mean_level = min(.data$LeveL) - 0.5 + sum(.data$pc))
  tibble(tscore, ratio_score, mean_level, is_normal = TRUE)
}
