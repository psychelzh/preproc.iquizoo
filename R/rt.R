#' Reaction Times
#'
#' Choice Reaction Time (CRT) and Simple Reaction Time (SRT) are classical tests
#' of human reaction times. These functions calculates the mean and standard
#' deviation of reaction times. In addition, subjects can commit errors in CRT
#' tests, so the number of correct responses is also calculated in [crt()].
#'
#' @name rt
#' @templateVar .by low
#' @templateVar .input TRUE
#' @template params-template
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{mrt}{Mean reaction time.}
#'   \item{rtsd}{Standard deviation of reaction times.}
#'   \item{nc}{Count of correct responses. Only for [crt()].}
NULL

#' @rdname rt
#' @export
crt <- function(data, .by, .input) {
  data |>
    mutate(
      # remove rt of 100 or less
      rt_cor = ifelse(
        .data[[.input[["name_rt"]]]] > 100,
        .data[[.input[["name_rt"]]]], NA
      )
    ) |>
    calc_spd_acc(
      .by,
      name_acc = .input[["name_acc"]],
      name_rt = "rt_cor",
      acc_rtn = "count"
    )
}

#' @rdname rt
#' @export
srt <- function(data, .by, .input) {
  data |>
    mutate(
      # remove rt of 100 or less
      rt_cor = ifelse(
        .data[[.input[["name_rt"]]]] > 100,
        .data[[.input[["name_rt"]]]], NA
      ),
      acc_dummy = 1
    ) |>
    calc_spd_acc(
      .by,
      name_acc = "acc_dummy",
      name_rt = "rt_cor",
      acc_rtn = "none"
    )
}
