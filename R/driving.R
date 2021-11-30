#' Driving Test
#'
#' A test measuring impulsivity originally developed .by Gardner et. al. (2005).
#'
#' @templateVar .by low
#' @template params-template
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{still_ratio}{The ratio of still duration in yellow light state.}
#' @export
driving <- function(data, .by) {
  .input <- list(
    name_still_dur = "stilldur",
    name_still_light = "stilllight",
    name_yellow_dur = "yellowdur"
  ) |>
    update_settings("preproc.input")
  .extra <- list(light_yellow = "yellow") |>
    update_settings("preproc.extra")
  data |>
    group_by(across(all_of(.by))) |>
    mutate(
      still_dur = parse_char_resp(.data[[.input[["name_still_dur"]]]]),
      still_light = parse_char_resp(
        .data[[.input[["name_still_light"]]]],
        convert_numeric = FALSE
      )
    ) |>
    mutate(
      still_dur_yellow = purrr::map2_dbl(
        .data[["still_dur"]], .data[["still_light"]],
        ~ ifelse(
          length(.x) == length(.y),
          sum(.x[.y == .extra$light_yellow]),
          NA
        )
      )
    ) |>
    summarise(
      still_ratio = sum(.data[["still_dur_yellow"]]) /
        sum(.data[[.input[["name_yellow_dur"]]]]),
      .groups = "drop"
    )
}
