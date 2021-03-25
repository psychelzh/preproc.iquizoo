#' Signal Detection Theory
#'
#' Utility function to calculate indices related to signal detection theory,
#' e.g., d', c.
#'
#' @param data Required. A `data.frame` from which the indices are calculated.
#' @param name_type The name of the variable in `data` storing the signal type
#'   info.
#' @param name_acc The name of the variable in `data` storing accuracy data.
#' @param values_type The values of signal type. The first is 'signal', and the
#'   second is 'noise'.
#' @keywords internal
calc_sdt <- function(data,
                     name_type = "Type",
                     name_acc = "ACC",
                     values_type = c("s", "n")) {
  data %>%
    dplyr::group_by(.data[[name_type]]) %>%
    dplyr::summarise(
      n = dplyr::n(),
      pc = mean(.data[[name_acc]] == 1)
    ) %>%
    dplyr::mutate(
      pc_cor = dplyr::case_when(
        .data$pc == 0 ~ 1 / (2 * .data$n),
        .data$pc == 1 ~ 1 - 1 / (2 * .data$n),
        TRUE ~ .data$pc
      )
    ) %>%
    dplyr::select(.data[[name_type]], .data$pc_cor) %>%
    tidyr::pivot_wider(
      names_from = .data[[name_type]],
      values_from = .data[["pc_cor"]]
    ) %>%
    dplyr::transmute(
      dprime = stats::qnorm(.data[[values_type[[1]]]]) +
        stats::qnorm(.data[[values_type[[2]]]]),
      c = -(stats::qnorm(.data[[values_type[[1]]]]) -
        stats::qnorm(.data[[values_type[[2]]]])) / 2
    )
}
