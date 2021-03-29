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
correct_rt_acc <- function(data,
                           crit_rt = 100,
                           correct_type = c("both", "rt", "acc", "none"),
                           name_rt = "RT",
                           name_acc = "ACC") {
  correct_type <- match.arg(correct_type)
  names_in <- names(data)
  if (correct_type %in% c("both", "rt")) {
    rt_vals <- .subset2(data, name_rt)
    collapse::add_vars(data) <- list(
      rt_cor = ifelse(rt_vals > crit_rt, rt_vals, NA)
    )
  }
  if (correct_type %in% c("both", "acc")) {
    acc_vals <- .subset2(data, name_acc)
    collapse::add_vars(data) <- list(
      acc_cor = ifelse(rt_vals > crit_rt, acc_vals, -1)
    )
  }
  # add corrected name (with uncorrected value) if name found in original data
  if (name_rt %in% names_in & !rlang::has_name(data, "rt_cor")) {
    collapse::add_vars(data) <- list(rt_cor = .subset2(data, name_rt))
  }
  if (name_acc %in% names_in & !rlang::has_name(data, "acc_cor")) {
    collapse::add_vars(data) <- list(rt_cor = .subset2(data, name_acc))
  }
  data
}
