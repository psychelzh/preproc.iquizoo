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
calc_spd_acc <- function(data, by = NULL, name_acc = "acc", name_rt = "rt",
                         rt_rm_out = TRUE, rt_unit = c("ms", "s")) {
  rt_unit <- match.arg(rt_unit)
  # set reaction time unit to seconds for better value range
  if (rt_unit == "ms") data[[name_rt]] <- data[[name_rt]] / 1000
  data |>
    # rt of 0 means no response and should be converted as `NA
    mutate(na_if(.data[[name_rt]], 0)) |>
    group_by(pick(all_of(by))) |>
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
      rtsd = if (rt_rm_out) {
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
calc_sdt <- function(data, by = NULL, name_acc = "acc", name_type = "type") {
  data |>
    mutate(
      type_fac = factor(
        .data[[name_type]],
        c("s", "n")
      )
    ) |>
    group_by(pick(all_of(c(by, "type_fac")))) |>
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
      names_from = "type_fac",
      values_from = c("c", "e", "zc", "ze")
    ) |>
    mutate(
      dprime = .data$zc_s - .data$ze_n,
      c = -(.data$zc_s + .data$ze_n) / 2,
      commissions = .data$e_n,
      omissions = .data$e_s
    )
}

#' Calculate threshold by staircase method
#'
#' Here we used the method suggested by Wetherill et al (1966).
#'
#' @param x The levels in data.
#' @return The mean threshold.
#' @keywords internal
calc_staircase_wetherill <- function(x) {
  find_reversals <- function(x) {
    find_peaks_val <- function(x) {
      mat <- pracma::findpeaks(x)
      if (is.null(mat)) {
        warn("Reversals not found from input", "no_reversals_found")
        return(NA_real_)
      }
      mat[, 1]
    }
    list(
      peaks = find_peaks_val(x),
      valleys = -find_peaks_val(-x)
    )
  }
  # remove repetitions in transformed method
  x <- rle(x)$values
  reversals <- find_reversals(x)
  reversals |>
    purrr::map(
      # keep equal number of peaks and valleys
      \(x) utils::tail(x, min(lengths(reversals)))
    ) |>
    purrr::list_c() |>
    mean()
}

#' Convert character responses
#'
#' Simple function converts character correctness to numeric one.
#'
#' @param x The character vector to be parsed.
#' @param delim Delimiter used to join correctness when forming the character.
#'   Usually is hyphen (i.e., `"-"`), which is the default.
#' @param convert_numeric A logical value indicating if the values should be
#'   converted to `numeric` ones.
#' @return A list of the parsed result, the same length as the input vector.
#' @keywords internal
parse_char_resp <- function(x, delim = "-", convert_numeric = TRUE) {
  parsed <- stringr::str_split(x, delim)
  if (convert_numeric) {
    parsed <- purrr::map(parsed, as.numeric)
  }
  parsed
}


#' Update settings with option settings
#'
#' Options are set in list can be tricky to update. This function makes partly
#' adding custom options work.
#'
#' @param origin The original settings.
#' @param updates The updates to settings
#' @return An update list of settings.
#' @keywords internal
update_settings <- function(origin, updates) {
  if (is.null(updates)) {
    return(origin)
  }
  purrr::imap(origin, ~ updates[[.y]] %||% .x)
}

#' Outliers Detection for response time data
#'
#' This method is also called "transform" method, because it does a
#' transformation before applying z-score method.
#'
#' This is based on Cousineau, D., & Chartier, S. (2010), which is said to be
#' suitable for reaction time data.
#'
#' @param x A vector of input reaction time data.
#' @param threshold The threshold for determining whether a value is outlier or
#'   not. Default is set at 2.5, which is best sample size dependent.
#' @return A logical vector of the detected outliers.
#' @keywords internal
check_outliers_rt <- function(x, threshold = 2.5) {
  z_scores <- scale(
    scale(x, min(x, na.rm = TRUE), diff(range(x, na.rm = TRUE)))
  )[, 1]
  abs(z_scores) > threshold
}
