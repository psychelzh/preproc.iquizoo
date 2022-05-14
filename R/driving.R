#' Driving Test
#'
#' A test measuring impulsivity originally developed by Gardner et al (2005).
#'
#' @template common
#' @template options
#' @return An object with the same class as `data` contains following values:
#'   \item{still_ratio}{The ratio of still duration in yellow light state.}
#' @export
driving <- function(data, .by = NULL, .input = NULL, .extra = NULL) {
  .input <- list(
    name_still_dur = "stilldur",
    name_still_light = "stilllight",
    name_yellow_dur = "yellowdur"
  ) |>
    update_settings(.input)
  .extra <- list(light_yellow = "yellow") |>
    update_settings(.extra)
  data |>
    mutate(
      still_dur = parse_char_resp(.data[[.input$name_still_dur]]),
      still_light = parse_char_resp(
        .data[[.input$name_still_light]],
        convert_numeric = FALSE
      ),
      still_dur_yellow = purrr::map2_dbl(
        .data$still_dur, .data$still_light,
        ~ ifelse(
          length(.x) == length(.y),
          sum(.x[.y == .extra$light_yellow]),
          NA
        )
      )
    ) |>
    group_by(across(all_of(.by))) |>
    summarise(
      still_ratio = sum(.data$still_dur_yellow) /
        sum(.data[[.input$name_yellow_dur]]),
      .groups = "drop"
    ) |>
    vctrs::vec_restore(data)
}
