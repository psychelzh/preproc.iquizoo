#' Deese-Roediger-McDermott (DRM) paradigm
#'
#' This is a classical false memory test. Here calculates the effect size of
#' false memory.
#'
#' @templateVar .by low
#' @template params-template
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{tm_dprime}{Sensitivity (d') of true memory (against "foil" stimuli).}
#'   \item{tm_bias}{Bias of true memory (against "foil" stimuli).}
#'   \item{fm_dprime}{Sensitivity (d') of false memory.}
#'   \item{fm_bias}{ias of false memory.}
#' @export
drm <- function(data, .by) {
  .input <- list(
    name_type = "type",
    name_resp = "resp",
    name_acc = "acc",
    name_rt = "rt"
  ) |>
    update_settings("preproc.input")
  .extra <- list(
    type_filler = "filler",
    type_old = "old",
    type_foil = "foil",
    type_lure = "lure",
    resp_old = "old"
  ) |>
    update_settings("preproc.extra")
  data |>
    filter(.data[[.input[["name_type"]]]] != .extra$type_filler) |>
    group_by(across(all_of(c(.by, .input[["name_type"]])))) |>
    summarise(
      z_old = stats::qnorm(
        (sum(.data[[.input[["name_resp"]]]] == .extra$resp_old) + 0.5) /
          (n() + 1)
      ),
      .groups = "drop_last"
    ) |>
    pivot_wider(
      names_from = .data[[.input[["name_type"]]]],
      values_from = "z_old"
    ) |>
    transmute(
      tm_dprime = .data[[.extra$type_old]] - .data[[.extra$type_foil]],
      tm_bias = -(.data[[.extra$type_old]] + .data[[.extra$type_foil]]) / 2,
      fm_dprime = .data[[.extra$type_lure]] - .data[[.extra$type_foil]],
      fm_bias = -(.data[[.extra$type_lure]] + .data[[.extra$type_foil]]) / 2
    ) |>
    ungroup()
}
