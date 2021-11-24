#' Deese-Roediger-McDermott (DRM) paradigm
#'
#' This is a classical false memory test. Here calculates the effect size of
#' false memory.
#'
#' @templateVar .by low
#' @templateVar vars_input TRUE
#' @template params-template
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{tm_dprime}{Sensitivity (d') of true memory (against "foil" stimuli).}
#'   \item{tm_bias}{Bias of true memory (against "foil" stimuli).}
#'   \item{fm_dprime}{Sensitivity (d') of false memory.}
#'   \item{fm_bias}{ias of false memory.}
#' @export
drm <- function(data, .by, vars_input) {
  data |>
    filter(.data[[vars_input[["name_type"]]]] != "filler") |>
    group_by(across(
      all_of(c(.by, vars_input[["name_type"]]))
    )) |>
    summarise(
      z_old = stats::qnorm(
        (sum(.data[[vars_input[["name_resp"]]]] == "old") + 0.5) /
          (n() + 1)
      ),
      .groups = "drop_last"
    ) |>
    pivot_wider(
      names_from = .data[[vars_input[["name_type"]]]],
      values_from = "z_old"
    ) |>
    transmute(
      tm_dprime = .data[["old"]] - .data[["foil"]],
      tm_bias = -(.data[["old"]] + .data[["foil"]]) / 2,
      fm_dprime = .data[["lure"]] - .data[["foil"]],
      fm_bias = -(.data[["lure"]] + .data[["foil"]]) / 2
    ) |>
    ungroup()
}
