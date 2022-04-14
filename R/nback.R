#' N Back Paradigm
#'
#' A classical working memory test.
#'
#' Note for dual n-back, the returned indices include those for each modal and
#' both modals so they are tripled with additional suffix after each index name.
#'
#' @name nback
#' @template common
#' @template options
#' @return A [tibble][tibble::tibble-package] contains following values (tripled
#'   for dual n-back):
#'
#'   \item{pc}{Percentage of correct responses.}
#'
#'   \item{mrt}{Mean reaction time.}
#'
#'   \item{ies}{Inverse efficiency score.}
#'
#'   \item{rcs}{Rate correct score.}
#'
#'   \item{lisas}{Linear integrated speed-accuracy score.}
#'
#'   \item{dprime}{Sensitivity index.}
#'
#'   \item{v}{Drifting rate of ddm model. Not included in `dualnback()`.}
#'
#'   \item{a}{Threshold separation of ddm model. Not included in `dualnback()`.}
#'
#'   \item{t0}{Non-decision time of ddm model. Not included in `dualnback()`.}
NULL

#' @rdname nback
#' @export
nback <- function(data, .input = NULL, .extra = NULL) {
  .input <- list(
    name_type = "type",
    name_acc = "acc",
    name_rt = "rt"
  ) |>
    update_settings(.input)
  .extra <- list(type_filler = "filler", type_signal = "same") |>
    update_settings(.extra)
  .calc_nback(
    data,
    name_type = .input$name_type,
    name_acc = .input$name_acc,
    name_rt = .input$name_rt,
    type_filler = .extra$type_filler,
    type_signal = .extra$type_signal
  )
}

#' @rdname nback
#' @export
dualnback <- function(data, .input = NULL, .extra = NULL) {
  .input <- list(
    name_type1 = "typevis",
    name_type2 = "typeaud",
    name_acc1 = "accvis",
    name_acc2 = "accaud",
    name_rt1 = "rtvis",
    name_rt2 = "rtaud"
  ) |>
    update_settings(.input)
  .extra <- list(
    type_filler = "filler",
    type_signal = "same",
    dual_names = c("vis", "aud")
  ) |>
    update_settings(.extra)
  data_base <- data |>
    rename(!!!.input) |>
    pivot_longer(
      cols = names(.input),
      names_to = c(".value", "dual"),
      names_pattern = "name_(.*)(\\d)",
      names_transform = list(dual = as.integer)
    ) |>
    mutate(dual = .extra$dual_names[.data$dual])
  bind_rows(
    both = data_base,
    each = data_base,
    .id = "set"
  ) |>
    mutate(dual = if_else(.data$set == "both", "both", .data$dual)) |>
    group_by(.data$dual) |>
    group_modify(
      ~ .calc_nback(
        .x,
        type_filler = .extra$type_filler,
        type_signal = .extra$type_signal,
        calc_ddm = FALSE
      )
    ) |>
    ungroup() |>
    pivot_wider(
      names_from = .data$dual,
      values_from = -.data$dual
    )
}

.calc_nback <- function(data,
                        name_type = "type",
                        name_acc = "acc",
                        name_rt = "rt",
                        type_filler = "filler",
                        type_signal = "same",
                        calc_ddm = TRUE) {
  data_cor <- data |>
    # filler trials should be ignored
    filter(!.data[[name_type]] == type_filler) |>
    mutate(
      # standardize stimuli type
      type_cor = if_else(
        .data[[name_type]] == type_signal,
        "s", "n"
      )
    )
  bind_cols(
    calc_spd_acc(
      data_cor,
      name_acc = name_acc,
      name_rt = name_rt,
      rt_rtn = "mean",
      acc_rtn = "percent",
      sat_rtn = "all"
    ),
    calc_sdt(
      data_cor,
      name_acc = name_acc,
      name_type = "type_cor",
      keep_bias = FALSE,
      keep_counts = FALSE
    ),
    if (calc_ddm) {
      calc_ddm(
        data_cor,
        name_rt = name_rt,
        name_acc = name_acc,
        rt_unit = "ms"
      )
    }
  )
}
