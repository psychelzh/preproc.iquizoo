#' Task Switch and Stroop-like paradigm
#'
#' There are two types of tasks switching between each other for task swicth
#' paradigms, thus a switch cost can be calculated (using [switchcost()]).
#' Similarly, the stimuli for Stroop-like tasks contain *congruent* and
#' *incongruent* conditions, thus a congruence effect can be calculated (using
#' [congeff()]). There are also special types of tests in which congruence
#' effect and switch cost both exist, and [complexswitch()] calculates both.
#'
#' @name switch-congruence
#' @templateVar by low
#' @templateVar vars_input TRUE
#' @template params-template
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
#' @export
complexswitch <- function(data, by, vars_input) {
  data_cor <- data %>%
    dplyr::mutate(
      # remove rt of 100 or less
      rt_cor = ifelse(
        .data[[vars_input[["name_rt"]]]] > 100,
        .data[[vars_input[["name_rt"]]]], NA
      ),
      dplyr::across(
        tidyselect::vars_select_helpers$where(is.character),
        tolower
      ),
      type_block = ifelse(
        .data[[vars_input[["name_switch"]]]] %in% c("", "pure"),
        "pure", "mixed"
      ),
      type_switch = ifelse(
        .data[["type_block"]] == "pure",
        .data[[vars_input[["name_task"]]]],
        .data[[vars_input[["name_switch"]]]]
      )
    )
  # calculate congruence effect
  cong_eff <- calc_cong_eff(
    data_cor,
    by = by,
    name_cong = vars_input[["name_cong"]],
    name_acc = vars_input[["name_acc"]],
    name_rt = "rt_cor"
  )
  # calculate switch cost
  switch_cost <- calc_switch_cost(
    data_cor,
    by = by,
    name_type_block = "type_block",
    name_type_switch = "type_switch",
    name_acc = vars_input[["name_acc"]],
    name_rt = "rt_cor"
  )
  dplyr::left_join(cong_eff, switch_cost, by = by)
}

#' @rdname switch-congruence
#' @export
congeff <- function(data, by, vars_input) {
  data_cor <- data %>%
    dplyr::mutate(
      # remove rt of 100 or less
      rt_cor = ifelse(
        .data[[vars_input[["name_rt"]]]] > 100,
        .data[[vars_input[["name_rt"]]]], NA
      ),
      dplyr::across(
        tidyselect::vars_select_helpers$where(is.character),
        tolower
      )
    )
  calc_cong_eff(
    data_cor, by = by,
    name_cong = vars_input[["name_cong"]],
    name_acc = vars_input[["name_acc"]],
    name_rt = "rt_cor"
  )
}

#' @rdname switch-congruence
#' @export
switchcost <- function(data, by, vars_input) {
  data_cor <- data %>%
    dplyr::mutate(
      # remove rt of 100 or less
      rt_cor = ifelse(
        .data[[vars_input[["name_rt"]]]] > 100,
        .data[[vars_input[["name_rt"]]]], NA
      ),
      dplyr::across(
        tidyselect::vars_select_helpers$where(is.character),
        tolower
      ),
      type_block = ifelse(
        .data[[vars_input[["name_switch"]]]] %in% c("", "pure"),
        "pure", "mixed"
      ),
      type_switch = ifelse(
        .data[["type_block"]] == "pure",
        .data[[vars_input[["name_task"]]]],
        .data[[vars_input[["name_switch"]]]]
      )
    )
  calc_switch_cost(
    data_cor,
    by = by,
    name_type_block = "type_block",
    name_type_switch = "type_switch",
    name_acc = vars_input[["name_acc"]],
    name_rt = "rt_cor"
  )
}

