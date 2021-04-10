#' Symbolic Number Comparison
#'
#' Several values including percentage of correct responses (pc), mean reaction
#' time (mrt), distance effect (dist_effect) and adjusted distance effect
#' (dist_effect_cor).
#'
#' @templateVar by low
#' @templateVar vars_input TRUE
#' @template params-template
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{pc}{Percentage of correct responses.}
#'   \item{mrt}{Mean reaction time.}
#'   \item{dist_eff}{Distance effect.}
#' @seealso [nsymncmp()] for non-symbolic number comparison.
#' @export
symncmp <- function(data, by, vars_input) {
  data_cor <- data %>%
    dplyr::mutate(
      rt_cor = ifelse(
        .data[[vars_input[["name_rt"]]]] > 100,
        .data[[vars_input[["name_rt"]]]], NA
      )
    )
  basics <- calc_spd_acc(
    data_cor,
    by,
    name_acc = vars_input[["name_acc"]],
    name_rt = "rt_cor",
    rt_rtn = "mean",
    acc_rtn = "percent"
  )
  fit_errproof <- purrr::possibly(
    ~ stats::coef(stats::lm(
      as.formula(
        stringr::str_glue(r"({vars_input[["name_rt"]]} ~ dist)")
      ),
      .x
    ))[["dist"]],
    otherwise = NA_real_
  )
  dist_eff <- data_cor %>%
    dplyr::mutate(
      dist = .data[[vars_input[["name_big"]]]] -
        .data[[vars_input[["name_small"]]]]
    ) %>%
    dplyr::group_nest(dplyr::across(dplyr::all_of(by))) %>%
    dplyr::mutate(
      dist_eff = purrr::map_dbl(
        .data[["data"]],
        ~ .x %>%
          dplyr::filter(
            .data[[vars_input[["name_acc"]]]] == 1
          ) %>%
          fit_errproof()
      ),
      .keep = "unused"
    )
  dplyr::left_join(basics, dist_eff, by = by)
}
