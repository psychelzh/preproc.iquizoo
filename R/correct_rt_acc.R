#' Correct reaction time and accuracy values
#'
#' Generally speaking, a response time that is no more than 100 milliseconds is
#' impossible for human beings, which is possibly accompanied by an error
#' operation. This function tried to correct that by setting reaction time to
#' `NA` and accuracy to `-1` (can be opted out) for those trials.
#'
#' @param data Required. Raw data, a `data.frame`.
#' @param crit_rt Minimal reaction time in milliseconds. Reaction times that are
#'   equal or less than this will be treated as illegal.
#' @param correct_type Four types are supported. `"both"` (default) means that
#'   both response time and accuracy are corrected, `"none"` means no
#'   correction, and `"rt"`/`"acc` means correct the corresponding one.
#' @param name_rt The variable name of reaction time in the input `data`.
#' @param name_acc The variable name of accuracy in the input `data`.
#' @return The data is added with two new columns. `rt_cor`: the corrected
#'   reaction time; `acc_cor`: the corrected accuracy. They can both disappear,
#'   because if there is no such correction, the column is added only if the
#'   corresponding variable exists in the original `data`.
#' @keywords internal
correct_rt_acc <- function(data, ...,
                           crit_rt = 100,
                           correct_type = c("both", "rt", "acc", "none"),
                           name_rt = "RT",
                           name_acc = "ACC") {
  correct_type <- match.arg(correct_type)
  data_out <- data
  if (correct_type %in% c("both", "rt")) {
    data_out <- data_out %>%
      dplyr::mutate(
        rt_cor = dplyr::if_else(
          .data[[name_rt]] > crit_rt,
          .data[[name_rt]], NA_integer_
        )
      )
  }
  if (correct_type %in% c("both", "acc")) {
    data_out <- data_out %>%
      dplyr::mutate(
        acc_cor = dplyr::if_else(
          .data[[name_rt]] > crit_rt,
          .data[[name_acc]], -1L
        )
      )
  }
  # add corrected name (with uncorrected value) if name found in original data
  if (rlang::has_name(data, name_rt) & !rlang::has_name(data_out, "rt_cor")) {
    data_out <- data_out %>%
      dplyr::mutate(rt_cor = .data[[name_rt]])
  }
  if (rlang::has_name(data, name_acc) & !rlang::has_name(data_out, "acc_cor")) {
    data_out <- data_out %>%
      dplyr::mutate(acc_cor = .data[[name_acc]])
  }
  data_out
}
