#' Continuous Performance Test
#'
#' Continuous Performance Test (CPT) is a classical test for attention. There
#' are many methods used to calculate the performance index of this task, and
#' here only includes those common ones.
#'
#' @template common
#' @template options
#' @return An object with the same class as `data` contains following values:
#'
#'   \item{nc}{Count of correct responses.}
#'
#'   \item{mrt}{Mean reaction time of hits.}
#'
#'   \item{rtsd}{Standard deviation of reaction times of hits.}
#'
#'   \item{dprime}{Sensitivity (d').}
#'
#'   \item{commissions}{Number of errors caused by action.}
#'
#'   \item{omissions}{Number of errors caused by inaction.}
#' @export
cpt <- function(data, .by = NULL, .input = NULL, .extra = NULL) {
  .input <- list(name_acc = "acc", name_type = "type", name_rt = "rt") |>
    update_settings(.input)
  .extra <- list(type_signal = "target") |>
    update_settings(.extra)
  data_cor <- data |>
    # some tests records stimuli not presented
    filter(.data[[.input$name_acc]] != -1) |>
    mutate(
      # remove rt from non-signal trials
      rt_cor = if_else(
        .data[[.input$name_type]] == .extra$type_signal,
        .data[[.input$name_rt]], NA
      )
    )
  merge(
    calc_spd_acc(
      data_cor,
      by = .by,
      name_acc = .input$name_acc,
      name_rt = "rt_cor"
    ),
    calc_sdt(
      data_cor,
      .extra$type_signal,
      by = .by,
      name_acc = .input$name_acc,
      name_type = .input$name_type
    ),
    by = .by
  ) |>
    select(
      all_of(
        c(
          .by,
          "nc", "mrt", "rtsd",
          "dprime", "commissions", "omissions"
        )
      )
    ) |>
    vctrs::vec_restore(data)
}
