#' Driving Test
#'
#' A test measuring impulsivity originally developed by Gardner et. al. (2005).
#'
#' @templateVar by low
#' @templateVar vars_input TRUE
#' @template params-template
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{still_ratio}{The ratio of still duration in yellow light state.}
#' @export
driving <- function(data, by, vars_input) {
  data %>%
    dplyr::group_by(dplyr::across(dplyr::all_of(by))) %>%
    dplyr::mutate(
      still_dur = parse_char_resp(.data[[vars_input[["name_still_dur"]]]]),
      still_light = parse_char_resp(
        .data[[vars_input[["name_still_light"]]]],
        convert_numeric = FALSE
      )
    ) %>%
    dplyr::mutate(
      still_dur_yellow = purrr::map2_dbl(
        .data[["still_dur"]], .data[["still_light"]],
        ~ ifelse(length(.x) == length(.y), sum(.x[.y == "Yellow"]), NA)
      )
    ) %>%
    dplyr::summarise(
      still_ratio = ifelse(
        all(is.na(.data[["still_dur_yellow"]])), NA,
        sum(.data[["still_dur_yellow"]], na.rm = TRUE) /
          sum(.data[[vars_input[["name_yellow_dur"]]]])
      ),
      .groups = "drop"
    )
}
