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

#' Calculate threshold by staircase method
#'
#' Here we used the method suggested by Wetherill et al (1966).
#'
#' @param x The levels in data.
#' @return The mean threshold.
#' @keywords internal
calc_staircase_wetherill <- function(x) {
  find_reversals <- function(x, type = c("peaks", "valleys")) {
    type <- match.arg(type)
    if (type == "valleys") x <- -x
    mat <- pracma::findpeaks(x)
    if (is.null(mat)) {
      warn(paste("No", type, "found from input"), "input_not_suitable")
      return()
    }
    if (type == "valleys") {
      -mat[, 1]
    } else {
      mat[, 1]
    }
  }
  # use run length encoding to remove repetitions in transformed method
  x <- rle(x)$values
  reversals <- c("peaks", "valleys") |>
    purrr::map(\(type) find_reversals(x, type))
  reversals |>
    purrr::map(
      \(x) utils::tail(x, min(lengths(reversals)))
    ) |>
    purrr::list_c() |>
    mean()
}
