#' Continuous Performance Test
#'
#' Continuous Performance Test (CPT) is a classical test for attention. There
#' are many methods used to calculate the performance index of this task, and
#' here only includes those common ones.
#'
#' @templateVar .by low
#' @templateVar vars_input TRUE
#' @template params-template
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{nc}{Count of correct responses.}
#'   \item{mrt}{Mean reaction time of hits.}
#'   \item{rtsd}{Standard deviation of reaction times of hits.}
#'   \item{dprime}{Sensitivity (d').}
#'   \item{c}{Bias index.}
#'   \item{commissions}{Number of errors caused by action.}
#'   \item{omissions}{Number of errors caused by inaction.}
#' @export
cpt <- function(data, .by, vars_input) {
  data_cor <- data |>
    # some tests records stimuli not presented
    filter(.data[[vars_input[["name_acc"]]]] != -1) |>
    mutate(
      # standardize stimuli type
      type_cor = if_else(
        .data[[vars_input[["name_type"]]]] %in% c("target", "left"),
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
    .by,
    name_acc = vars_input[["name_acc"]],
    name_rt = "rt_cor",
    acc_rtn = "count"
  )
  sdt <- calc_sdt(data_cor, .by, vars_input[["name_acc"]], "type_cor")
  left_join(basics, sdt, by = .by)
}
