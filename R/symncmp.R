#' Calculates index scores for Symbolic Number Comparison game.
#'
#' Several values including percentage of correct responses (pc), mean reaction
#' time (mrt), distance effect (dist_effect) and adjusted distance effect
#' (dist_effect_cor).
#'
#' @param data Raw data of class `data.frame`.
#' @param ... Other input argument for future expansion.
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{pc}{Percentage of correct responses.}
#'   \item{mrt}{Mean reaction time.}
#'   \item{dist_eff}{Distance effect.}
#'   \item{dist_eff_adj}{Adjusted distance effect.}
#'   \item{is_normal}{Checking result whether the data is normal.}
#' @export
symncmp <- function(data, ...) {
  vars_output <- c("pc", "mrt", "dist_eff", "dist_eff_adj")
  vars_required <- tibble::tribble(
    ~field, ~name,
    "name_big_digit", "Big",
    "name_small_digit", "Small",
    "name_acc", "ACC",
    "name_rt", "RT"
  )
  vars_matched <- match_data_vars(data, vars_required)
  if (is.null(vars_matched)) {
    return(compose_abnormal_output(vars_output))
  }
  # set as wrong for trials responding too quickly
  data_cor <- correct_rt_acc(data)
  basic <- data_cor %>%
    dplyr::summarise(
      pc = mean(.data[["acc_cor"]] == 1),
      mrt = mean(.data[["rt_cor"]], na.rm = TRUE)
    )
  data_dist_eff <- data_cor %>%
    dplyr::filter(.data[["acc_cor"]] == 1) %>%
    dplyr::mutate(
      dist = .data[[vars_matched["name_big_digit"]]] -
        .data[[vars_matched["name_small_digit"]]]
    )
  dist_eff_orig <- stats::lm(RT ~ dist, data_dist_eff) %>%
    stats::coef() %>%
    `[`("dist")
  dist_eff <- data.frame(
    dist_eff = dist_eff_orig,
    dist_eff_adj = dist_eff_orig / basic$mrt
  )
  is_normal <- data_cor %>%
    dplyr::summarise(nt = dplyr::n(), nc = sum(.data[["acc_cor"]] == 1)) %>%
    dplyr::transmute(
      is_normal = .data[["nc"]] > stats::qbinom(0.95, .data[["nt"]], 0.5)
    )
  tibble(basic, dist_eff, is_normal)
}
