#' Signal Detection Theory
#'
#' Calculate sensitivity index and bias based on signal detection theory. The
#' correction for extreme proportions of zero and one is the "log-linear" rule
#' recommended by Hautus (1995).
#'
#' @param acc,type `acc` is the correctness of each response, and `type` is the
#'   stimuli type of each response. These two inputs should have the same length
#'   (no broadcasting is done!)
#'
#'   * `acc`: should be a `numeric` vector coded as that `1` means scoring
#'   correct, `0` means scoring incorrect, and that `-1` means no response is
#'   made. No other values are allowed.
#'
#'   * `type`: should be a vector of `factor` or `character` class. If a
#'   `factor`, only two levels are allowed, with which the first level
#'   represents the noise (i.e., non-target) type. If a `character`, it must
#'   contain values of "s" (signal, i.e., target) and "n" (noise) only.
#'
#' @param no_resp_to_inc a logical value indicating whether -1 values in `acc`
#'   should be treated as incorrect response or not. This value means the
#'   response is not a valid response. If `TRUE` (default), they will be treated
#'   as 0, i.e, incorrect response. Otherwise they are removed.
#' @return A `numeric` vector containing sensitivity index (named as `"dprime"`)
#'   and bias (named as`"c"`).
#' @keywords internal
calc_sdt <- function(acc, type, no_resp_to_inc = TRUE) {
  # check if acc and type has the length and try to expand
  if (length(acc) != length(type)) {
    stop("Please make sure `acc` and `type` has the same length.")
  }
  # check acc input
  if (!all(acc %in% c(-1, 0, 1))) {
    stop("Please make sure `acc` input contains -1, 0 and 1 only.")
  }
  # check type input
  stopifnot(is.character(type) || is.factor(type))
  if (is.character(type)) {
    if (!all(type %in% c("s", "n")) > 0)
      stop("Please make sure `type` input contains 's' and 'n' only.")
    type <- factor(type, levels = c("n", "s"))
  }
  if (is.factor(type)) {
    if (nlevels(type) != 2)
      stop("Please make sure factor input contains two levels only.")
    levels(type) <- c("n", "s")
  }
  # treat NAs
  if (no_resp_to_inc) {
    acc[acc == -1] <- 0
  } else {
    type <- type[acc != -1]
    acc <- acc[acc != -1]
  }
  # calculate hit rate and false alarm rate
  acc <- factor(acc, levels = c(0, 1), labels = c("i", "c"))
  tbl_freq <- table(type, acc) + 0.5 # corrected is done by adding 0.5
  hit_rate <- tbl_freq["s", "c"] / sum(tbl_freq["s", ])
  fa_rate <- tbl_freq["n", "i"] / sum(tbl_freq["n", ])
  # compose output
  c(
    dprime = stats::qnorm(hit_rate) - stats::qnorm(fa_rate),
    c = - (stats::qnorm(hit_rate) + stats::qnorm(fa_rate)) / 2
  )
}
