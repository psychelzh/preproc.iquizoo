#' Calculates index scores for Behavioral Pattern Separation (BPS) game
#'
#' The index was developed by Stark et. al. (2013), named as "BPS score".
#'
#' @param data Raw data of class `data.frame`.
#' @param vars_input This is done by other functions, storing the matched
#'   variable names for further processing.
#' @param by The column(s) variable names in `data` used to be grouped by. If
#'   set to `NULL`, all data will be treated as from one subject.
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{pc}{Percent of correct responses.}
#'   \item{p_sim_foil}{Percent of similar responses for "foil" stimuli.}
#'   \item{p_sim_lure}{Percent of similar responses for "lure" stimuli.}
#'   \item{p_sim_target}{Percent of similar responses for "target" stimuli.}
#'   \item{bps_score}{BPS score.}
#'   \item{is_normal}{Checking result whether the data is normal.}
#' @export
bps <- function(data, vars_input, by) {
  data_cor <- data %>%
    collapse::ss(.subset2(data, vars_input[["name_phase"]]) == "test") %>%
    correct_rt_acc(
      name_rt = vars_input[["name_rt"]],
      name_acc = vars_input[["name_acc"]]
    )
  grps_out <- collapse::GRP(data_cor, by)
  pc_all <- collapse::add_vars(
    grps_out$groups,
    list(
      pc = collapse::fmean(
        .subset2(data_cor, "acc_cor") == 1,
        grps_out,
        use.g.names = FALSE
      )
    )
  )
  by_types <- collapse::GRP(data_cor, c(by, vars_input[["name_type"]]))
  bps_score <- collapse::add_vars(
    by_types$groups,
    list(
      p_sim = collapse::fmean(
        .subset2(data_cor, vars_input[["name_resp"]]) == "Similar",
        by_types,
        use.g.names = FALSE
      )
    )
  ) %>%
    tidyr::pivot_wider(
      names_from = .data[[vars_input[["name_type"]]]],
      names_prefix = "p_sim_",
      values_from = "p_sim"
    )
  collapse::add_vars(bps_score) <- list(
    bps_score = .subset2(bps_score, "p_sim_lure") -
      .subset2(bps_score, "p_sim_foil")
  )
  is_normal <- check_resp_metric(
    .subset2(data_cor, "acc_cor"),
    grps_out,
    chance = 1 / 3
  )
  pc_all %>%
    dplyr::left_join(bps_score, by = by) %>%
    dplyr::left_join(is_normal, by = by)
}
