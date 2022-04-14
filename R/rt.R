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
#' @return A [tibble][tibble::tibble-package] contains following values:
#'
#'   \item{mrt}{Mean reaction time.}
#'
#'   \item{rtsd}{Standard deviation of reaction times.}
#'
#'   \item{nc}{Count of correct responses. Only for [crt()].}
#'
#'   \item{ies}{Inverse efficiency score. Only for [crt()].}
#'
#'   \item{rcs}{Rate correct score. Only for [crt()].}
#'
#'   \item{lisas}{Linear integrated speed-accuracy score. Only for [crt()].}
#'
#'   \item{v}{Drifting rate of ddm model. Only for [crt()].}
#'
#'   \item{a}{Threshold separation of ddm model. Only for [crt()].}
#'
#'   \item{t0}{Non-decision time of ddm model. Only for [crt()].}
NULL

#' @rdname rt
#' @export
crt <- function(data, .input = NULL, .extra = NULL) {
  .input <- list(name_acc = "acc", name_rt = "rt") |>
    update_settings(.input)
  bind_cols(
    calc_spd_acc(
      data,
      name_acc = .input$name_acc,
      name_rt = .input$name_rt,
      acc_rtn = "count"
    ),
   calc_ddm(
     data,
     name_rt = .input$name_rt,
     name_acc = .input$name_acc,
     rt_unit = "ms"
   )
  )
}

#' @rdname rt
#' @export
srt <- function(data, .input = NULL, .extra = NULL) {
  .input <- list(name_rt = "rt") |>
    update_settings(.input)
  data |>
    mutate(acc_dummy = 1) |>
    calc_spd_acc(
      name_acc = "acc_dummy",
      name_rt = .input$name_rt,
      acc_rtn = "none",
      sat_rtn = "none"
    )
}
