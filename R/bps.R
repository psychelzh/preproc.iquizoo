#' Calculates index scores for Behavioral Pattern Separation (BPS) game
#'
#' The index was developed by Stark et. al. (2013), named as "BPS score".
#'
#' @param data Raw data of class `data.frame`.
#' @param ... Other input argument for future expansion.
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{pc}{Percent of correct responses.}
#'   \item{p_sim_lure}{Percent of similar responses for "lure" stimuli.}
#'   \item{p_sim_foil}{Percent of similar responses for "foil" stimuli.}
#'   \item{p_sim_old}{Percent of similar responses for "target" (i.e., "old") stimuli.}
#'   \item{bps_score}{BPS score.}
#'   \item{is_normal}{Checking result whether the data is normal.}
#' @export
bps <- function(data, ...) {
  vars_output <- c("pc", "p_sim_lure", "p_sim_foil", "p_sim_old", "bps_score")
  vars_required <- tibble::tribble(
    ~field, ~name,
    "name_phase", "Phase",
    "name_type", "Type",
    "name_resp", "Resp",
    "name_acc", "ACC",
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
  pc_all <- data %>%
    dplyr::filter(.data$Phase == "test") %>%
    dplyr::summarise(pc = mean(.data$ACC == 1))
  bps_score <- data %>%
    dplyr::filter(.data$Phase == "test") %>%
    dplyr::group_by(.data$Type) %>%
    dplyr::summarise(p_sim = sum(.data$Resp == "Similar") / dplyr::n()) %>%
    tidyr::pivot_wider(names_from = "Type", values_from = "p_sim") %>%
    dplyr::transmute(
      p_sim_lure = .data$lure,
      p_sim_foil = .data$foil,
      p_sim_old = .data$target,
      bps_score = .data$lure - .data$foil
    )
  is_normal <- data %>%
    dplyr::filter(.data$Phase == "test") %>%
    dplyr::mutate(acc_adj = dplyr::if_else(.data$RT >= 100, .data$ACC, 0L)) %>%
    dplyr::summarise(nt = dplyr::n(), nc = sum(.data$acc_adj == 1)) %>%
    dplyr::transmute(
      is_normal = .data$nc > stats::qbinom(0.95, .data$nt, 1 / 3)
    )
  tibble(pc_all, bps_score, is_normal)
}
