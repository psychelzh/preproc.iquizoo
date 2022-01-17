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
#' For congruence effect:
#'   \item{mrt_con}{Mean reaction time for congruent trials.}
#'   \item{mrt_inc}{Mean reaction time for incogruent trials.}
#'   \item{cong_eff_rt}{Congruence effect of reaction time (RT), i.e.,
#'     incongruent RT - congruent RT.}
#'   \item{pc_con}{Percent of correct for congruent trials.}
#'   \item{pc_inc}{Percent of correct for incogruent trials.}
#'   \item{cong_eff_pc}{Congruency effect of percent of correct (PC), i.e.,
#'     congruent PC - incongruent PC.}
#'
#' For switch cost:
#'   \item{mrt_pure}{Mean reaction time for non-mixed blocks.}
#'   \item{mrt_repeat}{Mean reaction time for repeat trials.}
#'   \item{mrt_switch}{Mean reaction time for switch trials.}
#'   \item{switch_cost_rt_gen}{General switch cost (based on mean reaction
#'     times).}
#'   \item{switch_cost_rt_spe}{Specific switch cost (based on mean reaction
#'     times).}
#'   \item{pc_pure}{Percent of correct for non-mixed blocks.}
#'   \item{pc_repeat}{Percent of correct for repeat trials.}
#'   \item{pc_switch}{Percent of correct for switch trials.}
#'   \item{switch_cost_pc_gen}{General switch cost (based on percent of
#'     correct).}
#'   \item{switch_cost_pc_spe}{Specific switch cost (based on percent of
#'     correct).}
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
    block_pure = "pure",
    stim_con = "congruent",
    stim_inc = "incongruent",
    task_repeat = "repeat",
    task_switch = "switch"
  ) |>
    update_settings(.extra)
  switch_cost <- switchcost(data, .by, .input, .extra)
  cong_eff <- congeff(data, .by, .input, .extra)
  if (!is.null(.by)) {
    return(left_join(cong_eff, switch_cost, by = .by))
  } else {
    return(bind_cols(cong_eff, switch_cost))
  }
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
  data_cor <- data |>
    mutate(
      stim_type = recode(
        .data[[.input[["name_cong"]]]],
        "{.extra$stim_con}" := "con",
        "{.extra$stim_inc}" := "inc"
      )
    )
  calc_cong_eff(
    data_cor,
    .by = .by,
    name_cong = "stim_type",
    name_acc = .input$name_acc,
    name_rt = .input$name_rt
  )
}

#' @rdname switch-congruence
#' @export
switchcost <- function(data, .by = NULL, .input = NULL, .extra = NULL) {
  .input <- list(
    name_task = "task",
    name_switch = "type",
    name_acc = "acc",
    name_rt = "rt"
  ) |>
    update_settings(.input)
  .extra <- list(
    block_pure = "pure",
    task_filler = "filler",
    task_repeat = "repeat",
    task_switch = "switch"
  ) |>
    update_settings(.extra)
  data_cor <- data |>
    # remove all filler trials
    filter(.data[[.input$name_switch]] != .extra$task_filler) |>
    mutate(
      type_block = ifelse(
        .data[[.input$name_switch]] == .extra$block_pure,
        .data[[.input$name_task]], "mixed"
      ),
      type_switch = recode(
        .data[[.input$name_switch]],
        "{.extra$block_pure}" := "pure",
        "{.extra$task_repeat}" := "repeat",
        "{.extra$task_switch}" := "switch"
      )
    )
  calc_switch_cost(
    data_cor,
    .by = .by,
    name_type_block = "type_block",
    name_type_switch = "type_switch",
    name_acc = .input$name_acc,
    name_rt = .input$name_rt
  )
}
