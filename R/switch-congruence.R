#' Task Switching and Stroop-like paradigm
#'
#' In task switching paradigms, two types of tasks switch between each other, so
#' the "*switch cost*" can be calculated (using [switchcost()]). Similarly, in
#' Stroop-like tasks, stimuli are classified into two conditions (i.e.,
#' "congruent" and "incongruent"), so the "*congruence effect*" can be
#' calculated (using [congeff()]). There are also special types of tests where
#' congruence effect and switch cost both exist, from which [complexswitch()]
#' calculates both.
#'
#' @name switch-congruence
#' @template common
#' @template options
#' @return A [tibble][tibble::tibble-package] with the following variables:
#'
#'   For the total task:
#'
#'   \item{pc}{Percent of correct.}
#'
#'   \item{mrt}{Mean reaction time.}
#'
#'   For congruence effect and switch cost, the following indices will be
#'   included (including diffs and value for each condition):
#'
#'   \item{pc}{Percent of correct.}
#'
#'   \item{mrt}{Mean reaction time.}
#'
#'   \item{ies}{Inverse efficiency score.}
#'
#'   \item{rcs}{Rate correct score.}
#'
#'   \item{lisas}{Linear integrated speed-accuracy score.}
NULL

#' @rdname switch-congruence
#' @export
complexswitch <- function(data, .by = NULL, .input = NULL, .extra = NULL) {
  .input <- list(
    name_cong = "stimtype",
    name_task = "task",
    name_switch = "tasktype",
    name_acc = "acc",
    name_rt = "rt"
  ) |>
    update_settings(.input)
  .extra <- list(
    stim_con = "congruent",
    stim_inc = "incongruent",
    task_filler = "filler",
    task_repeat = "repeat",
    task_switch = "switch"
  ) |>
    update_settings(.extra)
  spd_acc <- calc_spd_acc(
    data,
    by = .by,
    name_acc = .input$name_acc,
    name_rt = .input$name_rt
  ) |>
    select(all_of(c(.by, "pc", "mrt")))
  switch_cost <- data |>
    filter(.data[[.input$name_switch]] != .extra$task_filler) |>
    calc_cond_diff(
      by = .by,
      name_cond = .input$name_switch,
      values_cond = .extra[c("task_switch", "task_repeat")],
      name_acc = .input$name_acc,
      name_rt = .input$name_rt,
      type_effect = "switch"
    )
  cong_eff <- data |>
    calc_cond_diff(
      by = .by,
      name_cond = .input$name_cong,
      values_cond = .extra[c("stim_inc", "stim_con")],
      name_acc = .input$name_acc,
      name_rt = .input$name_rt,
      type_effect = "congruency"
    )
  spd_acc |>
    merge(switch_cost, by = .by) |>
    merge(cong_eff, by = .by) |>
    vctrs::vec_restore(data)
}

#' @rdname switch-congruence
#' @export
congeff <- function(data, .by = NULL, .input = NULL, .extra = NULL) {
  .input <- list(
    name_cong = "type",
    name_acc = "acc",
    name_rt = "rt"
  ) |>
    update_settings(.input)
  .extra <- list(
    stim_con = "congruent",
    stim_inc = "incongruent"
  ) |>
    update_settings(.extra)
  spd_acc <- calc_spd_acc(
    data,
    by = .by,
    name_acc = .input$name_acc,
    name_rt = .input$name_rt
  ) |>
    select(all_of(c(.by, "pc", "mrt")))
  cong_eff <- data |>
    calc_cond_diff(
      by = .by,
      name_cond = .input$name_cong,
      values_cond = .extra[c("stim_inc", "stim_con")],
      name_acc = .input$name_acc,
      name_rt = .input$name_rt,
      type_effect = "congruency"
    )
  merge(spd_acc, cong_eff, by = .by) |>
    vctrs::vec_restore(data)
}

#' @rdname switch-congruence
#' @export
switchcost <- function(data, .by = NULL, .input = NULL, .extra = NULL) {
  .input <- list(
    name_switch = "type",
    name_acc = "acc",
    name_rt = "rt"
  ) |>
    update_settings(.input)
  .extra <- list(
    task_filler = "filler",
    task_repeat = "repeat",
    task_switch = "switch"
  ) |>
    update_settings(.extra)
  spd_acc <- calc_spd_acc(
    data,
    by = .by,
    name_acc = .input$name_acc,
    name_rt = .input$name_rt
  ) |>
    select(all_of(c(.by, "pc", "mrt")))
  switch_cost <- data |>
    filter(.data[[.input$name_switch]] != .extra$task_filler) |>
    calc_cond_diff(
      by = .by,
      name_cond = .input$name_switch,
      values_cond = .extra[c("task_switch", "task_repeat")],
      name_acc = .input$name_acc,
      name_rt = .input$name_rt,
      type_effect = "switch"
    )
  merge(spd_acc, switch_cost, by = .by) |>
    vctrs::vec_restore(data)
}

# helper functions
calc_cond_diff <- function(data, by, name_cond, values_cond, ...,
                           name_acc = "acc", name_rt = "rt",
                           type_effect = c("switch", "congruency")) {
  type_effect <- match.arg(type_effect)
  labels_cond <- switch(type_effect,
    `switch` = c("switch", "repeat"),
    `congruency` = c("inc", "con")
  )
  data[[name_cond]] <- factor(
    data[[name_cond]],
    levels = values_cond,
    labels = labels_cond
  )
  conds <- levels(data[[name_cond]])
  index_each_cond <- data |>
    calc_spd_acc(
      by = c(by, name_cond),
      name_acc = name_acc,
      name_rt = name_rt
    ) |>
    complete(.data[[name_cond]]) |>
    select(all_of(c(by, name_cond, "pc", "mrt", "ies", "rcs", "lisas")))
  index_each_cond |>
    pivot_longer(
      cols = -any_of(c(by, name_cond)),
      names_to = "index_name",
      values_to = "score"
    ) |>
    pivot_wider(
      names_from = all_of(name_cond),
      values_from = "score"
    ) |>
    mutate(
      diff = .data[[conds[[1]]]] - .data[[conds[[2]]]],
      .keep = "unused"
    ) |>
    # make sure larger values correspond to larger switch cost
    mutate(
      diff = if_else(
        .data$index_name %in% c("pc", "rcs"),
        -diff, diff
      )
    ) |>
    pivot_wider(
      names_from = "index_name",
      values_from = "diff",
      names_prefix = switch(type_effect,
        `switch` = "switch_cost_",
        `congruency` = "cong_eff_"
      )
    ) |>
    merge(
      index_each_cond |>
        pivot_wider(
          names_from = all_of(name_cond),
          values_from = -any_of(c(by, name_cond))
        ),
      by = by
    )
}
