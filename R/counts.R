#' Count Correct Responses
#'
#' These functions count the number of correct responses. [countcorrect()]
#' counts the correct responses regardless of errors, [countcorrect2()]
#' subtracts the number of errors from number of correct responses,
#' [sumweighted()] counts the correct responses by giving a weight for different
#' responses, [sumscore()] adds up the score for each response.
#'
#' @name counts
#' @templateVar by low
#' @templateVar vars_input TRUE
#' @template params-template
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{nc}{Count of correct responses. For [countcorrect()].}
#'   \item{nc_cor}{Corrected count of correct responses (subtracting number of
#'     errors). For [countcorrect2()].}
#'   \item{nc_weighted}{Count of weighted correct responses. For
#'     [sumweighted()].}
#'   \item{nc_score}{Sum of scores. For [sumscore()].}
NULL

#' @rdname counts
#' @export
countcorrect <- function(data, by, vars_input) {
  if (is.character(data[[vars_input[["name_acc"]]]])) {
    # character input uses "-" to separate individual responses
    data <- data %>%
      dplyr::mutate(
        r"({vars_input[["name_acc"]]})" := parse_char_resp(
          .data[[vars_input[["name_acc"]]]]
        )
      ) %>%
      tidyr::unnest(.data[[vars_input[["name_acc"]]]])
  }
  data %>%
    dplyr::group_by(dplyr::across(dplyr::all_of(by))) %>%
    dplyr::summarise(
      # NA might be produced in parsing characters
      nc = sum(.data[[vars_input[["name_acc"]]]] == 1, na.rm = TRUE),
      .groups = "drop"
    )
}

#' @rdname counts
#' @export
countcorrect2 <- function(data, by, vars_input) {
  data %>%
    dplyr::group_by(dplyr::across(dplyr::all_of(by))) %>%
    dplyr::summarise(
      nc_cor = sum(
        .data[[vars_input[["name_nc"]]]] - .data[[vars_input[["name_ne"]]]]
      ),
      .groups = "drop"
    )
}

#' @rdname counts
#' @export
sumweighted <- function(data, by, vars_input) {
  data %>%
    dplyr::group_by(dplyr::across(dplyr::all_of(by))) %>%
    dplyr::summarise(
      nc_weighted = sum(
        .data[[vars_input[["name_weight"]]]] *
          (.data[[vars_input[["name_acc"]]]] == 1)
      ),
      .groups = "drop"
    )
}

#' @rdname counts
#' @export
sumscore <- function(data, by, vars_input) {
  data %>%
    dplyr::group_by(dplyr::across(dplyr::all_of(by))) %>%
    dplyr::summarise(
      nc_score = sum(as.numeric(.data[[vars_input[["name_score"]]]])),
      .groups = "drop"
    )
}
