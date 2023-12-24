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
#' @template common
#' @param ... Other arguments passed to [check_outliers_rt()].
#' @param by The column name(s) in `data` used to be grouped by. If set to
#'   `NULL`, all data will be treated as from one subject.
#' @templateVar name_acc TRUE
#' @templateVar name_rt TRUE
#' @template names
#' @param rt_rm_out A logical value indicating if outliers should be removed
#'   from reaction time. Default is `TRUE`.
#' @param rt_unit The unit of response time in `data`.
#' @return A [tibble][tibble::tibble-package] contains the required scores.
#' @keywords internal
calc_spd_acc <- function(data, ...,
                         by = NULL, name_acc = "acc", name_rt = "rt",
                         rt_rm_out = TRUE, rt_unit = c("ms", "s")) {
  rt_unit <- match.arg(rt_unit)
  # set reaction time unit to seconds for better value range
  if (rt_unit == "ms") data[[name_rt]] <- data[[name_rt]] / 1000
  if (rt_rm_out) {
    data <- data |>
      mutate(
        "{name_rt}" := if_else(
          check_outliers_rt(.data[[name_rt]], ...),
          NA, .data[[name_rt]]
        ),
        .by = all_of(by)
      )
  }
  data |>
    # rt of 0 means no response and should be converted as `NA
    mutate(na_if(.data[[name_rt]], 0)) |>
    summarise(
      nc = sum(.data[[name_acc]] == 1),
      pc = .data$nc / n(),
      pcsd = stats::sd(.data[[name_acc]] == 1),
      mrt = mean(.data[[name_rt]][.data[[name_acc]] == 1], na.rm = TRUE),
      mrt_all = mean(.data[[name_rt]], na.rm = TRUE),
      rtsd = stats::sd(
        .data[[name_rt]][.data[[name_acc]] == 1],
        na.rm = TRUE
      ),
      ies = .data$mrt / .data$pc,
      rcs = .data$pc / .data$mrt_all,
      lisas = case_when(
        .data$pc == 1 ~ .data$mrt,
        .data$pc == 0 ~ 0,
        TRUE ~ .data$mrt + (1 - .data$pc) / .data$pcsd * .data$rtsd
      ),
      .by = all_of(by)
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
#' @param x A vector of input reaction time data.
#' @param method The method used to detect outliers. If set to `"cutoff"`, any
#'   value out of `threshold` range is considered as outlier. If set to
#'   `"z_score"`, any value with absolute z-score larger than `threshold` is
#'   considered as outlier.
#' @param threshold The threshold for determining whether a value is outlier or
#'   not. For `"cutoff"` method, the default is `c(0.2, Inf)`. For `"z_score"`
#'   method, the default is `2.5`.
#' @return A logical vector of the detected outliers.
#' @keywords internal
check_outliers_rt <- function(x, method = c("z_score", "cutoff"),
                              threshold = NULL) {
  method <- match.arg(method)
  if (is.null(threshold)) {
    threshold <- switch(method,
      cutoff = c(0.2, Inf), # assuming rt is in seconds
      z_score = 2.5
    )
  }
  switch(method,
    cutoff = x < threshold[[1]] | x > threshold[[2]],
    z_score = abs(scale(x)[, 1]) > threshold
  )
}
