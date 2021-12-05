#' Symbolic Number Comparison
#'
#' Several values including percentage of correct responses (pc), mean reaction
#' time (mrt), distance effect (dist_effect) and adjusted distance effect
#' (dist_effect_cor).
#'
#' @template common
#' @template options
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{pc}{Percentage of correct responses.}
#'   \item{mrt}{Mean reaction time.}
#'   \item{dist_eff}{Distance effect.}
#' @seealso [nsymncmp()] for non-symbolic number comparison.
#' @export
symncmp <- function(data, .by = NULL, .input = NULL, .extra = NULL) {
  .input <- list(
    name_big = "big",
    name_small = "small",
    name_acc = "acc",
    name_rt = "rt"
  ) |>
    update_settings(.input)
  data_cor <- data |>
    mutate(
      rt_cor = ifelse(
        .data[[.input[["name_rt"]]]] > 100,
        .data[[.input[["name_rt"]]]], NA
      )
    )
  basics <- calc_spd_acc(
    data_cor,
    .by,
    name_acc = .input[["name_acc"]],
    name_rt = "rt_cor",
    rt_rtn = "mean",
    acc_rtn = "percent"
  )
  fit_errproof <- purrr::possibly(
    ~ stats::coef(stats::lm(
      as.formula(
        stringr::str_glue(r"({.input[["name_rt"]]} ~ dist)")
      ),
      .x
    ))[["dist"]],
    otherwise = NA_real_
  )
  dist_eff <- data_cor |>
    mutate(
      dist = .data[[.input[["name_big"]]]] -
        .data[[.input[["name_small"]]]]
    ) |>
    group_nest(across(all_of(.by))) |>
    mutate(
      dist_eff = purrr::map_dbl(
        .data[["data"]],
        ~ .x |>
          filter(
            .data[[.input[["name_acc"]]]] == 1
          ) |>
          fit_errproof()
      ),
      .keep = "unused"
    )
  if (!is.null(.by)) {
    return(left_join(basics, dist_eff, by = .by))
  } else {
    return(bind_cols(basics, dist_eff))
  }
}
