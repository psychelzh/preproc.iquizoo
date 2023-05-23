#' Adaptive Filtering
#'
#' This is an self-adaptive version (item number is adaptive to user's ability)
#' of filtering task. Only two conditions are included, i.e., condition of no
#' distractor and condition of two distractors.
#'
#' @template common
#' @template options
#'
#' @return An object with the same class as `data` contains following values:
#'
#'   \item{capacity0}{The mean number of target in condition of no distractors.}
#'
#'   \item{capacity2}{The mean number of target in condition of 2 distractors.}
#'
#'   \item{capacity}{The mean number of target in both conditions.}
#'
#'   \item{efficiency}{The filtering efficiency, .i.e, difference between
#'   condition of no distractors and two distractors.}
#'
#' @export
condstairs <- function(data, .by = NULL, .input = NULL, .extra = NULL) {
  .input <- list(
    name_cond = "numdist",
    name_level = "numtarget",
    name_acc = "acc"
  ) |>
    update_settings(.input)
  .extra <- list(
    type_base = 0,
    type_filt = 2
  ) |>
    update_settings(.extra)
  data |>
    group_by(pick(all_of(c(.by, .input$name_cond)))) |>
    summarise(
      level = calc_staircase_wetherill(.data[[.input$name_level]]),
      .groups = "drop_last"
    ) |>
    summarise(
      capacity0 = .subset(
        .data$level,
        .data[[.input$name_cond]] == .extra$type_base
      ),
      capacity2 = .subset(
        .data$level,
        .data[[.input$name_cond]] == .extra$type_filt
      ),
      capacity = (.data$capacity0 + .data$capacity2) / 2,
      efficiency = .data$capacity0 - .data$capacity2,
      .groups = "drop"
    ) |>
    vctrs::vec_restore(data)
}
