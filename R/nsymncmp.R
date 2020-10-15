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
    return(
      rlang::set_names(
        rep(NA, length(vars_output)),
        nm = vars_output
      ) %>%
        tibble::as_tibble_row() %>%
        tibble::add_column(is_normal = FALSE)
    )
  }
  data_adj <- data %>%
    dplyr::mutate(acc_adj = dplyr::if_else(.data$RT <= 100, 0L, .data$ACC)) %>%
    dplyr::rename(b = .data$BigSetCount, s = .data$SmallSetCount)
  basic <- data_adj %>%
    dplyr::summarise(
      pc = mean(.data$acc_adj == 1),
      mrt = mean(.data$RT[.data$acc_adj == 1])
    )
  fit_errproof <- purrr::possibly(
    ~ stats::nls(
      acc_adj ~ 1 - pnorm(0, b - s, w * sqrt(b^2 + s^2)),
      .,
      start = list(w = 0.5)
    ) %>%
      stats::coef(),
    otherwise = NA_real_
  )
  weber_fraction <- data.frame(w = fit_errproof(data_adj))
  is_normal <- data_adj %>%
    dplyr::summarise(nt = dplyr::n(), nc = sum(.data$acc_adj == 1)) %>%
    dplyr::transmute(is_normal = .data$nc > stats::qbinom(0.95, .data$nt, 0.5))
  tibble(basic, weber_fraction, is_normal)
}
