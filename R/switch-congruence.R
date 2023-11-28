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
    mutate(
      # https://github.com/tidyverse/dplyr/issues/6623
      switch = case_match(
        .data[[.input$name_switch]],
        !!!purrr::map2(
          .extra[c("task_repeat", "task_switch")],
          c("repeat", "switch"),
          new_formula
        )
      )
    ) |>
    calc_switch_cost(
      by = .by,
      name_switch = "switch",
      name_acc = .input$name_acc,
      name_rt = .input$name_rt
    )
  cong_eff <- data |>
    mutate(
      stim_type = case_match(
        .data[[.input$name_cong]],
        !!!purrr::map2(
          .extra[c("stim_con", "stim_inc")],
          c("con", "inc"),
          new_formula
        )
      )
    ) |>
    calc_cong_eff(
      by = .by,
      name_cong = "stim_type",
      name_acc = .input$name_acc,
      name_rt = .input$name_rt
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
    mutate(
      stim_type = case_match(
        .data[[.input$name_cong]],
        !!!purrr::map2(
          .extra[c("stim_con", "stim_inc")],
          c("con", "inc"),
          new_formula
        )
      )
    ) |>
    calc_cong_eff(
      by = .by,
      name_cong = "stim_type",
      name_acc = .input$name_acc,
      name_rt = .input$name_rt
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
    mutate(
      switch = case_match(
        .data[[.input$name_switch]],
        !!!purrr::map2(
          .extra[c("task_repeat", "task_switch")],
          c("repeat", "switch"),
          new_formula
        )
      )
    ) |>
    calc_switch_cost(
      by = .by,
      name_switch = "switch",
      name_acc = .input$name_acc,
      name_rt = .input$name_rt
    )
  merge(spd_acc, switch_cost, by = .by) |>
    vctrs::vec_restore(data)
}

#' Switch cost
#'
#' Utility function to calculate general and specific switch cost.
#'
#' @template common
#' @param by The column name(s) in `data` used to be grouped by. If set to
#'   `NULL`, all data will be treated as from one subject.
#' @templateVar name_acc TRUE
#' @templateVar name_rt TRUE
#' @template names
#' @param name_switch The column name of the `data` input whose values are
#'   the switch type, in which is a `character` vector with at least `"switch"`
#'   and `"repeat"` values.
#' @keywords internal
calc_switch_cost <- function(data, by, name_switch, name_rt, name_acc) {
  data[[name_switch]] <- factor(data[[name_switch]], c("switch", "repeat"))
  calc_cond_diff(
    data,
    by,
    name_cond = name_switch,
    name_diff_prefix = "switch_cost_",
    name_acc = name_acc,
    name_rt = name_rt
  )
}

#' Congruence effect
#'
#' Utility function to calculate congruence effect sizes.
#'
#' @template common
#' @param by The column name(s) in `data` used to be grouped by. If set to
#'   `NULL`, all data will be treated as from one subject.
#' @templateVar name_acc TRUE
#' @templateVar name_rt TRUE
#' @template names
#' @param name_cong The column name of the `data` input whose values are the
#'   congruence information, in which is a `character` vector with "incongruent
#'   condition" (label: `"inc"`) and "congruent condition" (label: `"con"`). It
#'   will be coerced as a `factor` vector with these two levels.
#' @return A [tibble][tibble::tibble-package] contains congruence effect results
#'   on accuracy and response time.
#' @keywords internal
calc_cong_eff <- function(data, by, name_cong, name_acc, name_rt) {
  data[[name_cong]] <- factor(data[[name_cong]], c("inc", "con"))
  calc_cond_diff(
    data,
    by,
    name_cond = name_cong,
    name_diff_prefix = "cong_eff_",
    name_acc = name_acc,
    name_rt = name_rt
  )
}

calc_cond_diff <- function(data, by, name_acc, name_rt,
                           name_cond, name_diff_prefix) {
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
      names_prefix = name_diff_prefix
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
