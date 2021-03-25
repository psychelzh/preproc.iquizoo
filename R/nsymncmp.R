#' Calculates index scores for Nonsymbolic Number Comparison game.
#'
#' Several values including percentage of correct responses (pc), mean reaction
#' time (mrt), weber fraction (w).
#'
#' @param data Raw data of class `data.frame`.
#' @param ... Other input argument for future expansion.
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{pc}{Percentage of correct responses.}
#'   \item{mrt}{Mean reaction time.}
#'   \item{w}{Weber fraction.}
#'   \item{is_normal}{Checking result whether the data is normal.}
#' @export
nsymncmp <- function(data, ...) {
  vars_output <- c("pc", "mrt", "w")
  vars_required <- tibble::tribble(
    ~field, ~name,
    "name_big_count", "BigSetCount",
    "name_small_count", "SmallSetCount",
    "name_acc", "ACC",
    "name_rt", "RT"
  )
  vars_matched <- match_data_vars(data, vars_required)
  if (is.null(vars_matched)) {
    return(compose_abnormal_output(vars_output))
  }
  data_cor <- data %>%
    correct_rt_acc() %>%
    dplyr::rename(
      b = .data[[vars_matched["name_big_count"]]],
      s = .data[[vars_matched["name_small_count"]]]
    )
  basic <- data_cor %>%
    dplyr::summarise(
      pc = mean(.data[["acc_cor"]] == 1),
      mrt = mean(.data[["rt_cor"]], na.rm = TRUE)
    )
  fit_errproof <- purrr::possibly(
    ~ stats::nls(
      acc_cor ~ 1 - pnorm(0, b - s, w * sqrt(b^2 + s^2)),
      .x,
      start = list(w = 0.5)
    ) %>%
      stats::coef(),
    otherwise = NA_real_
  )
  weber_fraction <- data.frame(w = fit_errproof(data_cor))
  is_normal <- check_resp_metric(data_cor)
  tibble(basic, weber_fraction, is_normal)
}
