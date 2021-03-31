#' Calculates index scores for complex switch games
#'
#' Complex switch game, just as the name implied, switch cost will be of
#' interest. For its complexity, congruency effect will be calculated, too. In
#' fact it is just a combination of [congeff()] and [switchcost()].
#'
#' @templateVar by low
#' @templateVar vars_input TRUE
#' @template params-template
#' @return A [tibble][tibble::tibble-package] with the following variables:
#'   \item{mrt_con}{Mean reaction time for congruent trials.}
#'   \item{mrt_inc}{Mean reaction time for incogruent trials.}
#'   \item{cong_eff_rt}{Congruency effect of reaction time (RT), i.e., RT
#'     incongruency - RT congruency.}
#'   \item{pc_con}{Percent of correct for congruent trials.}
#'   \item{pc_inc}{Percent of correct for incogruent trials.}
#'   \item{cong_eff_pc}{Congruency effect of percent of correct (PC), i.e., PC
#'     congruency - PC incongruency.}
#'   \item{mrt_pure}{Mean reaction time for non-mixed blocks.}
#'   \item{mrt_repeat}{Mean reaction time for repeat trials.}
#'   \item{mrt_switch}{Mean reaction time for switch trials.}
#'   \item{switch_cost_rt_gen}{General switch cost (based on mean reaction
#'     times).}
#'   \item{switch_cost_rt_spe}{Specific switch cost (based on mean reaction
#'     times).}
#'   \item{pc_pure}{Percent of correct for non-mixed blocks.}
#'   \item{pc_repeat}{Percent of correct for repeat trials.}
#'   \item{mrt_switch}{Percent of correct for switch trials.}
#'   \item{switch_cost_pc_gen}{General switch cost (based on percent of
#'     correct).}
#'   \item{switch_cost_pc_spe}{Specific switch cost (based on percent of
#'     correct).}
#' @export
complexswitch <- function(data, vars_input, by) {
  data_cor <- data %>%
    dplyr::mutate(
      # remove rt of 100 or less
      rt_cor = ifelse(
        .data[[vars_input[["name_rt"]]]] > 100,
        .data[[vars_input[["name_rt"]]]], NA
      ),
      # TODO: fix this using `tidyselect::where()` in future
      r"({vars_input[["name_cong"]]})" := tolower(
        .data[[vars_input[["name_cong"]]]]
      ),
      r"({vars_input[["name_switch"]]})" := tolower(
        .data[[vars_input[["name_switch"]]]]
      ),
      type_block = ifelse(
        .data[[vars_input[["name_switch"]]]] %in% c("", "pure"),
        "pure", "mixed"
      ),
      type_switch = ifelse(
        type_block == "pure",
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
  cong_eff %>%
    dplyr::left_join(switch_cost, by = by)
}
