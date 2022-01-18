#' London Tower
#'
#' A classical test on problem solving.
#'
#' @template common
#' @template options
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{total_score}{Total score defined .by the game itself.}
#'   \item{mean_level}{Mean level reached.}
#'   \item{level_score}{Sum of mean score (a ratio) for each level.}
#' @export
london <- function(data, .by = NULL, .input = NULL, .extra = NULL) {
  .input <- list(
    name_minmove = "minmove",
    name_timeinit = "timeinit",
    name_stepsused = "stepsused",
    name_finished = "finished"
  ) |>
    update_settings(.input)
  prop_perfect <- data |>
    group_by(across(all_of(.by))) |>
    summarise(
      prop_perfect = mean(
        .data[[.input$name_stepsused]] == .data[[.input$name_minmove]]
      )
    )
  speed_score <- calc_spd_acc(
    data,
    .by = .by,
    name_acc = .input$name_finished,
    name_rt = .input$name_timeinit,
    acc_rtn = "none",
    rt_rtn = "mean"
  ) |>
    rename(mrt_init = .data$mrt)
  if (!is.null(.by)) {
    return(left_join(prop_perfect, speed_score, by = .by))
  } else {
    return(bind_cols(prop_perfect, speed_score))
  }
}
