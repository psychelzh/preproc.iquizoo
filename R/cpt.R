#' Continuous Performance Test
#'
#' Continuous Performance Test (CPT) is a classical test for attention. There
#' are many methods used to calculate the performance index of this task, and
#' here only includes those common ones.
#'
#' @templateVar by low
#' @templateVar vars_input TRUE
#' @template params-template
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{pc}{Percentage of correct responses.}
#'   \item{mrt}{Mean reaction time of hits.}
#'   \item{rtsd}{Standard deviation of reaction times of hits.}
#'   \item{dprime}{Sensitivity (d').}
#'   \item{c}{Bias index.}
#'   \item{hits}{Number of hits.}
#'   \item{commissions}{Number of errors caused by action.}
#'   \item{omissions}{Number of errors caused by inaction.}
#'   \item{count_error}{Count of incorrect responses.}
#' @export
cpt <- function(data, by, vars_input) {
  data_cor <- data %>%
    dplyr::mutate(
      # standardize stimuli type
      type_cor = dplyr::if_else(
        .data[[vars_input[["name_type"]]]] == "Target",
        "s", "n"
      ),
      # remove rt of 100 or less and rt from non-signal trials
      rt_cor = ifelse(
        .data[[vars_input[["name_rt"]]]] > 100 & .data[["type_cor"]] == "s",
        .data[[vars_input[["name_rt"]]]], NA
      )
    )
  basics <- data_cor %>%
    dplyr::group_by(dplyr::across(dplyr::all_of(by))) %>%
    dplyr::summarise(
      pc = mean(.data[[vars_input[["name_acc"]]]]),
      mrt = mean(.data[["rt_cor"]], na.rm = TRUE),
      rtsd = stats::sd(.data[["rt_cor"]], na.rm = TRUE),
      .groups = "drop"
    )
  sdt <- calc_sdt(data_cor, by, vars_input[["name_acc"]], "type_cor")
  basics %>%
    dplyr::left_join(sdt, by = by)
}
