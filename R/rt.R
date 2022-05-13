#' Reaction Times
#'
#' Choice Reaction Time (CRT) and Simple Reaction Time (SRT) are classical tests
#' of human reaction times. These functions calculates the mean and standard
#' deviation of reaction times. In addition, subjects can commit errors in CRT
#' tests, so the number of correct responses is also calculated in [crt()].
#'
#' @name rt
#' @template common
#' @template options
#' @return An object with the same class as `data` contains following values:
#'
#'   \item{nc}{Count of correct responses. Only for [crt()].}
#'
#'   \item{mrt}{Mean reaction time.}
#'
#'   \item{rtsd}{Standard deviation of reaction times.}
#'
#'   \item{ies}{Inverse efficiency score. Only for [crt()].}
#'
#'   \item{rcs}{Rate correct score. Only for [crt()].}
#'
#'   \item{lisas}{Linear integrated speed-accuracy score. Only for [crt()].}
NULL

#' @rdname rt
#' @export
crt <- function(data, .by = NULL, .input = NULL, .extra = NULL) {
  .input <- list(name_acc = "acc", name_rt = "rt") |>
    update_settings(.input)
  calc_spd_acc(
    data,
    by = .by,
    name_acc = .input$name_acc,
    name_rt = .input$name_rt
  ) |>
    select(
      all_of(
        c(
          .by,
          "nc", "mrt", "rtsd",
          "ies", "rcs", "lisas"
        )
      )
    ) |>
    vctrs::vec_restore(data)
}

#' @rdname rt
#' @export
srt <- function(data, .by = NULL, .input = NULL, .extra = NULL) {
  .input <- list(name_rt = "rt") |>
    update_settings(.input)
  data |>
    mutate(acc_dummy = 1) |>
    calc_spd_acc(
      by = .by,
      name_acc = "acc_dummy",
      name_rt = .input$name_rt
    ) |>
    select(all_of(c(.by, "mrt", "rtsd"))) |>
    vctrs::vec_restore(data)
}
