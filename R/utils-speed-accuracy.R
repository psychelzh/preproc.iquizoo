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
#'   outlier detection method used here is the "*interquantile range*" rule
#'   suggested by Tukey (1977).
#'
#' @template common
#' @templateVar name_acc TRUE
#' @templateVar name_rt TRUE
#' @template names
#' @param rm.out A logical value. Whether remove outlier or not. Default to
#'   `TRUE.`
#' @param rt_rtn If mean or standard deviation of response times should be
#'   returned.
#' @param acc_rtn If count or percent of correct responses should be returned.
#' @return A [tibble][tibble::tibble-package] contains the required scores.
#' @keywords internal
calc_spd_acc <- function(data, name_acc, name_rt,
                         rm.out = TRUE,
                         rt_rtn = c("both", "mean", "sd", "none"),
                         acc_rtn = c("both", "count", "percent", "none")) {
  rt_rtn <- match.arg(rt_rtn)
  acc_rtn <- match.arg(acc_rtn)
  data |>
    mutate(is_outlier = check_outliers_rt(.data[[name_rt]])) |>
    summarise(
      nc = if (acc_rtn %in% c("both", "count")) sum(.data[[name_acc]] == 1),
      pc = if (acc_rtn %in% c("both", "percent")) {
        sum(.data[[name_acc]] == 1) / n()
      },
      mrt = if (rt_rtn %in% c("both", "mean")) {
        .data[[name_rt]] |>
          .subset(.data[[name_acc]] == 1 & !.data$is_outlier) |>
          mean(na.rm = TRUE)
      },
      rtsd = if (rt_rtn %in% c("both", "sd")) {
        .data[[name_rt]] |>
          .subset(.data[[name_acc]] == 1 & !.data$is_outlier) |>
          stats::sd(na.rm = TRUE)
      }
    )
}

#' Signal Detection Theory
#'
#' Calculate sensitivity index and bias based on signal detection theory. The
#' correction for extreme proportions of zero and one is the "log-linear" rule
#' recommended .by Hautus (1995).
#'
#' @template common
#' @templateVar name_acc TRUE
#' @template names
#' @param name_type The column name of the `data` input whose values are the
#'   stimuli types, in which is a `character` vector with value `"s"` (denoting
#'   "*signal*") and `"n"` (denoting "*non-signal*") only. It will be coerced as
#'   a `factor` vector with these two levels.
#' @param keep_bias A logical value. Whether the bias index be returned. Default
#'   is `TRUE`.
#' @param keep_counts A logical value. Whether the counts of errors (commissions
#'   and omissions) be returned. Default is `TRUE`.
#' @return A [tibble][tibble::tibble-package] contains sensitivity index and
#'   bias (and other counts measures)
#' @keywords internal
calc_sdt <- function(data, name_acc, name_type,
                     keep_bias = TRUE, keep_counts = TRUE) {
  data |>
    mutate(
      type_fac = factor(
        .data[[name_type]],
        c("s", "n")
      )
    ) |>
    group_by(.data$type_fac) |>
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
    transmute(
      dprime = .data$zc_s - .data$ze_n,
      c = if(keep_bias) -(.data$zc_s + .data$ze_n) / 2,
      commissions = if (keep_counts) .data$e_n,
      omissions = if (keep_counts) .data$e_s
    )
}
