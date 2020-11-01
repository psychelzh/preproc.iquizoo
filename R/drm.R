#' Calculates index scores for DRM paradigm game
#'
#' Two major indices are included: fm_ratio (false memory ratio, i.e.,
#' p(old|lure) - p(old|foil)) and fm_dprime (false memory d', i.e.,
#' z(p(old|lure)) - z(p(old|foil)))
#'
#' @param data Raw data of class `data.frame`.
#' @param ... Other input argument for future expansion.
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{pc}{Percent of correct responses.}
#'   \item{hit_rate}{Hit rate, i.e., percent of "old" responses for "old"
#'     stimuli.}
#'   \item{p_old_lure}{Percent of "old" responses for "lure" stimuli.}
#'   \item{p_old_foil}{Percent of "old" responses for "foil" stimuli.}
#'   \item{fm_ratio}{False memory ratio.}
#'   \item{fm_dprime}{False memory d'.}
#'   \item{is_normal}{Checking result whether the data is normal.}
#' @export
drm <- function(data, ...) {
  vars_output <- c(
    "pc", "hit_rate", "p_old_lure", "p_old_foil",
    "fm_ratio", "fm_dprime"
  )
  vars_required <- tibble::tribble(
    ~field, ~name,
    "name_type", "Type",
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
  data <- data %>%
    dplyr::filter(.data$Type != "Filler")
  pc_all <- data %>%
    dplyr::summarise(pc = mean(.data$ACC == 1))
  fm <- data %>%
    dplyr::group_by(.data$Type) %>%
    dplyr::summarise(
      n = dplyr::n(),
      p_old = sum(.data$Resp == "Old") / .data$n
    ) %>%
    dplyr::mutate(
      p_old_adj = dplyr::case_when(
        .data$p_old == 0 ~ 1 / (2 * .data$n),
        .data$p_old == 1 ~ 1 - 1 / (2 * .data$n),
        TRUE ~ .data$p_old
      )
    ) %>%
    tidyr::pivot_wider(
      names_from = "Type",
      values_from = c("n", "p_old", "p_old_adj")
    ) %>%
    dplyr::transmute(
      hit_rate = .data$p_old_Old,
      p_old_lure = .data$p_old_Lure,
      p_old_foil = .data$p_old_Foil,
      fm_ratio = .data$p_old_Lure - .data$p_old_Foil,
      fm_dprime = stats::qnorm(.data$p_old_adj_Lure) -
        stats::qnorm(.data$p_old_adj_Foil)
    )
  is_normal <- data %>%
    dplyr::mutate(acc_adj = dplyr::if_else(.data$RT >= 100, .data$ACC, 0L)) %>%
    dplyr::summarise(nt = dplyr::n(), nc = sum(.data$acc_adj == 1)) %>%
    dplyr::transmute(is_normal = .data$nc > stats::qbinom(0.95, .data$nt, 0.5))
  tibble(pc_all, fm, is_normal)
}
