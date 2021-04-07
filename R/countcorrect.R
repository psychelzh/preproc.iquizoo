#' Count correct responses
#'
#' These functions calculates the number of correct responses. [countcorrect2()]
#' subtracts the count of errors, which is not the case for [countcorrect()].
#'
#' @templateVar by low
#' @templateVar vars_input TRUE
#' @template params-template
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{nc/nc_cor}{Count of correct responses. `nc_cor` means a corrected
#'     count, which is returned by [countcorrect2()].}
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

#' @rdname countcorrect
#' @export
countcorrect2 <- function(data, by, vars_input) {
  data %>%
    dplyr::group_by(dplyr::across(dplyr::all_of(by))) %>%
    dplyr::summarise(
      nc_cor = sum(
        .data[[vars_input[["name_nc"]]]] - .data[[vars_input[["name_ne"]]]]
      )
    )
}
