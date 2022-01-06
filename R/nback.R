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
#'   \item{pc}{Percentage of correct responses.}
#'   \item{mrt}{Mean reaction time.}
#'   \item{dprime}{Sensitivity index.}
#'   \item{c}{Bias.}
NULL

#' @rdname nback
#' @export
nback <- function(data, .by = NULL, .input = NULL, .extra = NULL) {
  .input <- list(
    name_type = "type",
    name_acc = "acc",
    name_rt = "rt"
  ) |>
    update_settings(.input)
  .extra <- list(type_filler = "filler", type_signal = "same") |>
    update_settings(.extra)
  .nback_classical(
    data,
    .by = .by,
    name_type = .input$name_type,
    name_acc = .input$name_acc,
    name_rt = .input$name_rt,
    type_filler = .extra$type_filler,
    type_signal = .extra$type_signal
  )
}

#' @rdname nback
#' @export
dualnback <- function(data, .by = NULL, .input = NULL, .extra = NULL) {
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
    mutate(
      dual = .extra$dual_names[.data$dual],
      # remove rt of non-signal trials
      rt = replace(.data$rt, .data$type != .extra$type_signal, NA)
    )
  bind_rows(
    both = data_base,
    each = data_base,
    .id = "set"
  ) |>
    mutate(dual = if_else(set == "both", "both", dual)) |>
    group_by(.data$dual) |>
    group_modify(
      ~ .nback_classical(
        .x,
        .by = .by,
        type_filler = .extra$type_filler,
        type_signal = .extra$type_signal
      )
    ) |>
    ungroup() |>
    pivot_wider(
      names_from = .data$dual,
      values_from = -any_of(c(.by, "dual"))
    )
}

.nback_classical <- function(data, .by = NULL,
                             name_type = "type",
                             name_acc = "acc",
                             name_rt = "rt",
                             type_filler = "filler",
                             type_signal = "same") {
  data_cor <- data |>
    # filler trials should be ignored
    filter(!.data[[name_type]] == type_filler) |>
    mutate(
      # standardize stimuli type
      type_cor = if_else(
        .data[[name_type]] == type_signal,
        "s", "n"
      ),
      # remove rt of 100 or less
      rt_cor = ifelse(
        .data[[name_rt]] > 100,
        .data[[name_rt]], NA
      )
    )
  basics <- calc_spd_acc(
    data_cor,
    .by,
    name_acc = name_acc,
    name_rt = "rt_cor",
    rt_rtn = "mean",
    acc_rtn = "percent"
  )
  sdt <- calc_sdt(
    data_cor, .by, name_acc, "type_cor",
    keep_counts = FALSE
  )
  if (!is.null(.by)) {
    return(left_join(basics, sdt, by = .by))
  } else {
    return(bind_cols(basics, sdt))
  }
}
