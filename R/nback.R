#' N Back Paradigm
#'
#' A classical working memory test.
#'
#' @templateVar .by low
#' @templateVar .input TRUE
#' @template params-template
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{pc}{Percentage of correct responses.}
#'   \item{mrt}{Mean reaction time.}
#'   \item{dprime}{Sensitivity index.}
#'   \item{c}{Bias.}
#' @export
nback <- function(data, .by, .input) {
  data_cor <- data |>
    # type of "None" should be ignored
    filter(
      !.data[[.input[["name_type"]]]] %in% c("none", "filler")
    ) |>
    mutate(
      # standardize stimuli type
      type_cor = if_else(
        .data[[.input[["name_type"]]]] %in% c("change", "target"),
        "s", "n"
      ),
      # remove rt of 100 or less and rt from non-signal trials
      rt_cor = ifelse(
        .data[[.input[["name_rt"]]]] > 100 & .data[["type_cor"]] == "s",
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
  left_join(basics, sdt, by = .by)
}
