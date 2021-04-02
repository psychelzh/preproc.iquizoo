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
#' @templateVar by low
#' @templateVar name_acc TRUE
#' @templateVar name_rt TRUE
#' @template params-template
#' @param rm.out A logical value. Whether remove outlier or not. Default to
#'   `TRUE.`
#' @param rt_rtn If mean or standard deviation of response times should be
#'   returned.
#' @param acc_rtn If count or percent of correct responses should be returned.
#' @return A [tibble][tibble::tibble-package] contains the required scores.
#' @keywords internal
calc_spd_acc <- function(data, by, name_acc, name_rt,
                         rm.out = TRUE,
                         rt_rtn = c("both", "mean", "sd", "none"),
                         acc_rtn = c("both", "count", "percent", "none")) {
  rt_rtn <- match.arg(rt_rtn)
  acc_rtn <- match.arg(acc_rtn)
  data %>%
    dplyr::group_by(dplyr::across(dplyr::all_of(by))) %>%
    dplyr::mutate(
      "{name_rt}" := ifelse(
        .data[[name_rt]] %in%
          graphics::boxplot(.data[[name_rt]], plot = FALSE)$out &
          rm.out,
        NA, .data[[name_rt]]
      )
    ) %>%
    dplyr::summarise(
      nc = sum(.data[[name_acc]] == 1),
      pc = nc / dplyr::n(),
      mrt = mean(.data[[name_rt]], na.rm = TRUE),
      rtsd = stats::sd(.data[[name_rt]], na.rm = TRUE),
      .groups = "drop"
    ) %>%
    dplyr::select(
      dplyr::all_of(
        c(
          by,
          if (acc_rtn %in% c("both", "count")) "nc",
          if (acc_rtn %in% c("both", "percent")) "pc",
          if (rt_rtn %in% c("both", "mean")) "mrt",
          if (rt_rtn %in% c("both", "sd")) "rtsd"
        )
      )
    )
}
