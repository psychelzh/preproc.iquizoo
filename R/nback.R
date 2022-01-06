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
  data_cor <- data |>
    # type of "None" should be ignored
    filter(!.data[[.input[["name_type"]]]] == .extra$type_filler) |>
    mutate(
      # standardize stimuli type
      type_cor = if_else(
        .data[[.input[["name_type"]]]] == .extra$type_signal,
        "s", "n"
      ),
      # remove rt of 100 or less
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
  sdt <- calc_sdt(
    data_cor, .by, .input[["name_acc"]], "type_cor",
    keep_counts = FALSE
  )
  if (!is.null(.by)) {
    return(left_join(basics, sdt, by = .by))
  } else {
    return(bind_cols(basics, sdt))
  }
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
  .input_trans <- list(
    name_type = "type",
    name_acc = "acc",
    name_rt = "rt"
  )
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
      "{.input_trans$name_rt}" := replace(
        .data[[.input_trans$name_rt]],
        .data[[.input_trans$name_type]] != .extra$type_signal,
        NA
      )
    )
  bind_rows(
    both = data_base,
    each = data_base,
    .id = "set"
  ) |>
    mutate(dual = if_else(set == "both", "both", dual)) |>
    group_by(.data$dual) |>
    group_modify(
      ~ nback(
        .x,
        .by = .by,
        .input = .input_trans,
        .extra = .extra
      )
    ) |>
    ungroup() |>
    pivot_wider(
      names_from = .data$dual,
      values_from = -any_of(c(.by, "dual"))
    )
}
