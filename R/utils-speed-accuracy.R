#' Calculate basic speed and accuracy scores
#'
#' This function calculates reaction time and accuracy scores, which are very
#' basic to most tests.
#'
#' A major part of behavior tests is the speed and accuracy metrics, which are
#' actually the only ones that any test collects. Based on these two metrics,
#' two basic groups of scores can be obtained. The first group contains the mean
#' and standard deviations of response times the number, and the second contains
#' the number and percent of correct responses.
#'
#' @section Note:
#'
#'   Outlier removal is recommended and it is set as default in here. The
#'   outlier detection method used here is the one recommended by Cousineau, D.,
#'   & Chartier, S. (2010).
#'
#' @template common
#' @param by The column name(s) in `data` used to be grouped by. If set to
#'   `NULL`, all data will be treated as from one subject.
#' @templateVar name_acc TRUE
#' @templateVar name_rt TRUE
#' @template names
#' @param rt_rm_out A logical value. Whether remove response time outlier or
#'   not. Default to `TRUE.`
#' @param rt_unit The unit of response time in `data`.
#' @return A [tibble][tibble::tibble-package] contains the required scores.
#' @keywords internal
calc_spd_acc <- function(data, by, name_acc, name_rt,
                         rt_rm_out = TRUE, rt_unit = c("ms", "s")) {
  rt_unit <- match.arg(rt_unit)
  # set reaction time unit to seconds for better value range
  if (rt_unit == "ms") data[[name_rt]] <- data[[name_rt]] / 1000
  data |>
    # rt of 0 means no response and should be converted as `NA
    mutate(na_if(.data[[name_rt]], 0)) |>
    group_by(across(all_of(by))) |>
    mutate(is_outlier = check_outliers_rt(.data[[name_rt]])) |>
    summarise(
      nc = sum(.data[[name_acc]] == 1),
      pc = .data$nc / n(),
      pcsd = stats::sd(.data[[name_acc]] == 1),
      mrt = if (rt_rm_out) {
        .data[[name_rt]] |>
          .subset(!.data$is_outlier & .data[[name_acc]] == 1) |>
          mean.default(na.rm = TRUE)
      } else {
        .data[[name_rt]] |>
          .subset(.data[[name_acc]] == 1) |>
          mean.default(na.rm = TRUE)
      },
      mrt_all = if (rt_rm_out) {
        .data[[name_rt]] |>
          .subset(!.data$is_outlier) |>
          mean.default(na.rm = TRUE)
      } else {
        .data[[name_rt]] |>
          mean.default(na.rm = TRUE)
      },
      rtsd  = if (rt_rm_out) {
        .data[[name_rt]] |>
          .subset(!.data$is_outlier & .data[[name_acc]] == 1) |>
          stats::sd(na.rm = TRUE)
      } else {
        .data[[name_rt]] |>
          .subset(.data[[name_acc]] == 1) |>
          stats::sd(na.rm = TRUE)
      },
      ies = .data$mrt / .data$pc,
      rcs = .data$pc / .data$mrt_all,
      lisas = case_when(
        .data$pc == 1 ~ .data$mrt,
        .data$pc == 0 ~ 0,
        TRUE ~ .data$mrt + (1 - .data$pc) / .data$pcsd * .data$rtsd
      ),
      .groups = "drop"
    )
}

#' Signal Detection Theory
#'
#' Calculate sensitivity index and bias based on signal detection theory. The
#' correction for extreme proportions of zero and one is the "log-linear" rule
#' recommended by Hautus (1995).
#'
#' @template common
#' @param by The column name(s) in `data` used to be grouped by. If set to
#'   `NULL`, all data will be treated as from one subject.
#' @templateVar name_acc TRUE
#' @template names
#' @param name_type The column name of the `data` input whose values are the
#'   stimuli types, in which is a `character` vector with value `"s"` (denoting
#'   "*signal*") and `"n"` (denoting "*non-signal*") only. It will be coerced as
#'   a `factor` vector with these two levels.
#' @return A [tibble][tibble::tibble-package] contains sensitivity index and
#'   bias (and other counts measures)
#' @keywords internal
calc_sdt <- function(data, by, name_acc, name_type) {
  data |>
    mutate(
      type_fac = factor(
        .data[[name_type]],
        c("s", "n")
      )
    ) |>
    group_by(across(all_of(c(by, "type_fac")))) |>
    summarise(
      c = sum(.data[[name_acc]] == 1),
      e = n() - .data$c,
      .groups = "drop"
    ) |>
    # TODO: call `complete()` to make sure "s" and "n" both exist
    mutate(
      across(
        all_of(c("c", "e")),
        # log-linear rule of correction extreme proportion
        ~ stats::qnorm((.x + 0.5) / (.data$c + .data$e + 1)),
        .names = "z{.col}"
      )
    ) |>
    pivot_wider(
      names_from = .data$type_fac,
      values_from = c("c", "e", "zc", "ze")
    ) |>
    mutate(
      dprime = .data$zc_s - .data$ze_n,
      c = -(.data$zc_s + .data$ze_n) / 2,
      commissions = .data$e_n,
      omissions = .data$e_s
    )
}
