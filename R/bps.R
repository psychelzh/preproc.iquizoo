#' Behavioral Pattern Separation (BPS) task
#'
#' This function mainly calculates the "*BPS score*" developed .by Stark et. al.
#' (2013).
#'
#' @template common
#' @template options
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{pc}{Percent of correct responses.}
#'   \item{p_sim_foil}{Percent of similar responses for "foil" stimuli.}
#'   \item{p_sim_lure}{Percent of similar responses for "lure" stimuli.}
#'   \item{p_sim_target}{Percent of similar responses for "target" stimuli.}
#'   \item{bps_score}{BPS score.}
#' @export
bps <- function(data, .by = NULL, .input = NULL, .extra = NULL) {
  .input <- list(
    name_phase = "phase",
    name_acc = "acc",
    name_type = "type",
    name_resp = "resp"
  ) |>
    update_settings(.input)
  .extra <- list(
    phase_test = "test",
    resp_sim = "similar"
  ) |>
    update_settings(.extra)
  data_cor <- data |>
    filter(.data[[.input$name_phase]] == .extra$phase_test)
  pc_all <- data_cor |>
    group_by(across(all_of(.by))) |>
    summarise(
      pc = mean(.data[[.input$name_acc]] == 1),
      .groups = "drop"
    )
  bps_score <- data_cor |>
    group_by(across(all_of(c(.by, .input$name_type)))) |>
    summarise(
      p_sim = mean(.data[[.input$name_resp]] == .extra$resp_sim),
      .groups = "drop"
    ) |>
    pivot_wider(
      names_from = .data[[.input$name_type]],
      names_prefix = "p_sim_",
      values_from = "p_sim"
    ) |>
    mutate(bps_score = .data[["p_sim_lure"]] - .data[["p_sim_foil"]])
  if (!is.null(.by)) {
    return(left_join(pc_all, bps_score, by = .by))
  } else {
    return(bind_cols(pc_all, bps_score))
  }
}
