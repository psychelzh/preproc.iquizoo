#' N Back Paradigm
#'
#' A classical working memory test.
#'
#' @templateVar by low
#' @templateVar vars_input TRUE
#' @template params-template
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{pc}{Percentage of correct responses.}
#'   \item{mrt}{Mean reaction time.}
#'   \item{dprime}{Sensitivity index.}
#'   \item{c}{Bias.}
#' @export
nback <- function(data, by, vars_input) {
  data_cor <- data %>%
    # type of "None" should be ignored
    dplyr::filter(.data[[vars_input[["name_type"]]]] != "None") %>%
    dplyr::mutate(
      # standardize stimuli type
      type_cor = dplyr::if_else(
        .data[[vars_input[["name_type"]]]] == "Change",
        "s", "n"
      ),
      # remove rt of 100 or less and rt from non-signal trials
      rt_cor = ifelse(
        .data[[vars_input[["name_rt"]]]] > 100 & .data[["type_cor"]] == "s",
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
  sdt <- calc_sdt(
    data_cor, by, vars_input[["name_acc"]], "type_cor",
    keep_counts = FALSE
  )
  dplyr::left_join(basics, sdt, by = by)
}
