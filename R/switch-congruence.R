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
#'   \item{pc}{Percent of correct}.
#'
#'   \item{mrt}{Mean reaction time.}
#'
#'   For congruence effect and switch cost, the following indices will be
#'   included (including diffs and value for each condition):
#'
#'   \item{pc}{Percent of correct}.
#'
#'   \item{mrt}{Mean reaction time.}
#'
#'   \item{ies}{Inverse efficiency score.}
#'
#'   \item{rcs}{Rate correct score.}
#'
#'   \item{lisas}{Linear integrated speed-accuracy score.}
#'
#'   \item{v}{Drifting rate of ddm model.}
NULL

#' @rdname switch-congruence
#' @export
complexswitch <- function(data, .input = NULL, .extra = NULL) {
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
    name_acc = .input$name_acc,
    name_rt = .input$name_rt,
    acc_rtn = "percent",
    rt_rtn = "mean",
    sat_rtn = "none"
  )
  switch_cost <- data |>
    filter(.data[[.input$name_switch]] != .extra$task_filler) |>
    mutate(
      switch = recode(
        .data[[.input$name_switch]],
        "{.extra$task_repeat}" := "repeat",
        "{.extra$task_switch}" := "switch"
      )
    ) |>
    calc_switch_cost(
      name_switch = "switch",
      name_acc = .input$name_acc,
      name_rt = .input$name_rt
    )
  cong_eff <- data |>
    mutate(
      stim_type = recode(
        .data[[.input$name_cong]],
        "{.extra$stim_con}" := "con",
        "{.extra$stim_inc}" := "inc"
      )
    ) |>
    calc_cong_eff(
      name_cong = "stim_type",
      name_acc = .input$name_acc,
      name_rt = .input$name_rt
    )
  bind_cols(spd_acc, switch_cost, cong_eff)
}

#' @rdname switch-congruence
#' @export
congeff <- function(data, .input = NULL, .extra = NULL) {
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
    name_acc = .input$name_acc,
    name_rt = .input$name_rt,
    acc_rtn = "percent",
    rt_rtn = "mean",
    sat_rtn = "none"
  )
  cong_eff <- data |>
    mutate(
      stim_type = recode(
        .data[[.input$name_cong]],
        "{.extra$stim_con}" := "con",
        "{.extra$stim_inc}" := "inc"
      )
    ) |>
    calc_cong_eff(
      name_cong = "stim_type",
      name_acc = .input$name_acc,
      name_rt = .input$name_rt
    )
  bind_cols(spd_acc, cong_eff)
}

#' @rdname switch-congruence
#' @export
switchcost <- function(data, .input = NULL, .extra = NULL) {
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
    name_acc = .input$name_acc,
    name_rt = .input$name_rt,
    acc_rtn = "percent",
    rt_rtn = "mean",
    sat_rtn = "none"
  )
  switch_cost <- data |>
    filter(.data[[.input$name_switch]] != .extra$task_filler) |>
    mutate(
      switch = recode(
        .data[[.input$name_switch]],
        "{.extra$task_repeat}" := "repeat",
        "{.extra$task_switch}" := "switch"
      )
    ) |>
    calc_switch_cost(
      name_switch = "switch",
      name_acc = .input$name_acc,
      name_rt = .input$name_rt
    )
  bind_cols(spd_acc, switch_cost)
}
