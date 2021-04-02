#' Count correct responses
#'
#' This function calculates the number of correct responses.
#'
#' @templateVar by low
#' @templateVar vars_input TRUE
#' @template params-template
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{nc}{Count of correct responses.}
#' @export
countcorrect <- function(data, by, vars_input) {
  if (is.character(data[[vars_input[["name_acc"]]]])) {
    # character input uses "-" to separate individual responses
    data <- data %>%
      dplyr::mutate(
        r"({vars_input[["name_acc"]]})" := purrr::map(
          .data[[vars_input[["name_acc"]]]],
          parse_char_acc
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
