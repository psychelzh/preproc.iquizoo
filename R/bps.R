#' Behavioral Pattern Separation (BPS) task
#'
#' This function mainly calculates the "*BPS score*" developed by Stark et. al.
#' (2013).
#'
#' @templateVar by low
#' @templateVar vars_input TRUE
#' @template params-template
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{pc}{Percent of correct responses.}
#'   \item{p_sim_foil}{Percent of similar responses for "foil" stimuli.}
#'   \item{p_sim_lure}{Percent of similar responses for "lure" stimuli.}
#'   \item{p_sim_target}{Percent of similar responses for "target" stimuli.}
#'   \item{bps_score}{BPS score.}
#' @export
bps <- function(data, by, vars_input) {
  data_cor <- data %>%
    filter(.data[[vars_input[["name_phase"]]]] == "test")
  pc_all <- data_cor %>%
    group_by(across(all_of(by))) %>%
    summarise(
      pc = mean(.data[[vars_input[["name_acc"]]]] == 1),
      .groups = "drop"
    )
  bps_score <- data_cor %>%
    group_by(across(
      all_of(c(by, vars_input[["name_type"]]))
    )) %>%
    summarise(
      p_sim = mean(.data[[vars_input[["name_resp"]]]] == "similar")
    ) %>%
    pivot_wider(
      names_from = .data[[vars_input[["name_type"]]]],
      names_prefix = "p_sim_",
      values_from = "p_sim"
    ) %>%
    mutate(bps_score = .data[["p_sim_lure"]] - .data[["p_sim_foil"]])
  left_join(pc_all, bps_score, by = by)
}
