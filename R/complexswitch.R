#' Calculates index scores for complex switch games
#'
#' Complex switch game, just as the name implied, switch cost will be of
#' interest. For its complexity, congruency effect will be calculated, too. In
#' fact it is just a combination of [congeff()] and [switchcost()].
#'
#' @param data Raw data of class `data.frame`.
#' @param ... Other input argument for future expansion.
#' @return A [tibble][tibble::tibble-package] with the following variables:
#'   \item{mrt_con}{Mean reaction time for congruent trials.}
#'   \item{mrt_inc}{Mean reaction time for incogruent trials.}
#'   \item{cong_eff_rt}{Congruency effect of reaction time (RT), i.e., RT
#'     incongruency - RT congruency.}
#'   \item{pc_con}{Percent of correct for congruent trials.}
#'   \item{pc_inc}{Percent of correct for incogruent trials.}
#'   \item{cong_eff_pc}{Congruency effect of percent of correct (PC), i.e., PC
#'     congruency - PC incongruency.}
#'   \item{rc_all}{Count of correct responses per minute for all blocks.}
#'   \item{rc_mixed}{Count of correct responses per minute for mixed blocks.}
#'   \item{rc_pure}{Count of correct responses per minute for pure blocks.}
#'   \item{switch_cost_rc_gen}{General switch cost (based on count of correct
#'     responses).}
#'   \item{mrt_pure}{Mean reaction time for non-mixed blocks.}
#'   \item{mrt_repeat}{Mean reaction time for repeat trials.}
#'   \item{mrt_switch}{Mean reaction time for switch trials.}
#'   \item{switch_cost_gen_rt}{General switch cost (based on mean reaction
#'     times).}
#'   \item{switch_cost_spe_rt}{Specific switch cost (based on mean reaction
#'     times).}
#'   \item{is_normal}{Checking result whether the data is normal.}
#' @export
complexswitch <- function(data, ...) {
  vars_output <- c(
    "mrt_con", "mrt_inc", "cong_eff_rt",
    "pc_con", "pc_inc", "cong_eff_pc",
    "rc_all", "rc_mixed", "rc_pure", "switch_cost_rc_gen",
    "mrt_pure", "mrt_repeat", "mrt_switch",
    "switch_cost_rt_gen", "switch_cost_rt_spe"
  )
  vars_required <- tibble::tribble(
    ~field, ~name,
    "name_block", "Block",
    "name_cong", "StimType",
    "name_task", c("Task", "Sex"),
    "name_switch", "TaskType",
    "name_acc", c("Acc", "ACC"),
    "name_rt", "RT"
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
  data_cor <- correct_rt_acc(data, name_acc = vars_matched["name_acc"])
  # calculate congruency effect
  cong_eff <- calc_cong_eff(
    data_cor,
    name_cong = vars_matched["name_cong"],
    name_acc = "acc_cor",
    name_rt = "rt_cor"
  )
  # calculate switch cost
  block_info <- data_cor %>%
    dplyr::mutate(
      n_blocks = dplyr::n_distinct(!!sym(vars_matched["name_block"]))
    ) %>%
    dplyr::group_by(
      .data[["n_blocks"]],
      .data[[vars_matched["name_block"]]]
    ) %>%
    dplyr::summarise(
      has_no_response = all(.data[["acc_cor"]] == -1),
      type_block = ifelse(
        all(.data[[vars_matched["name_switch"]]] %in% c("Pure", "")),
        "pure", "mixed"
      ),
      .groups = "drop"
    ) %>%
    dplyr::mutate(dur = dplyr::if_else(.data[["type_block"]] == "pure", 0.5, 1))
  if (any(block_info[["has_no_response"]])) {
    warning("At least one block has no response.")
    return(
      rlang::set_names(
        rep(NA, length(vars_output)),
        nm = vars_output
      ) %>%
        tibble::as_tibble_row() %>%
        tibble::add_column(is_normal = FALSE)
    )
  }
  switch_cost <- calc_switch_cost(
    data_cor, block_info,
    name_task = vars_matched["name_task"],
    name_switch = vars_matched["name_switch"]
  )
  validation <- data_cor %>%
    dplyr::summarise(nt = dplyr::n(), nc = sum(.data[["acc_cor"]] == 1)) %>%
    dplyr::transmute(
      is_normal = .data[["nc"]] > stats::qbinom(0.95, .data[["nt"]], 0.5) &&
        !any(block_info[["has_no_response"]])
    )
  tibble(cong_eff, switch_cost, validation)
}
