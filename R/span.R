#' Span (spatial or verbal)
#'
#' There is a bunch of tests measuring working memory span or attention span.
#'
#' @template common
#' @template options
#' @return An object with the same class as `data` contains following values:
#'
#'   \item{nc}{Count of correct responses.}
#'
#'   \item{max_span}{Maximal span.}
#'
#'   \item{mean_span_pcu}{Mean span using partial credit unit score.}
#'
#'   \item{mean_span_anu}{Mean span using all-or-nothing unit score.}
#'
#' @export
span <- function(data, .by = NULL, .input = NULL, .extra = NULL) {
  .input <- list(
    name_slen = "slen",
    name_outcome = "outcome",
    name_acc = "correctness"
  ) |>
    update_settings(.input)
  .extra <- list(
    name_stim = "stim",
    name_resp = "resp",
    name_dist = "resplocdist"
  ) |>
    update_settings(.extra)
  # try to restore "name_acc" from data
  if (!has_name(data, .input$name_acc) || any(is.na(data[[.input$name_acc]]))) {
    if (all(has_name(data, c(.extra$name_stim, .extra$name_resp)))) {
      data[[.input$name_acc]] <- purrr::map2_chr(
        parse_char_resp(data[[.extra$name_stim]]),
        parse_char_resp(data[[.extra$name_resp]]),
        ~ paste(as.numeric(.x == .y), collapse = "-")
      )
    } else if (has_name(data, .extra$name_dist)) {
      data[[.input$name_acc]] <- purrr::map_chr(
        parse_char_resp(data[[.extra$name_dist]]),
        ~ paste(as.numeric(.x == 0), collapse = "-")
      )
    } else {
      data[[.input$name_acc]] <- ""
    }
  }
  data |>
    mutate(
      acc = parse_char_resp(.data[[.input$name_acc]]),
      nc = purrr::map_dbl(.data$acc, ~ sum(.x == 1))
    ) |>
    group_by(across(all_of(c(.by, .input$name_slen)))) |>
    summarise(
      nc = sum(.data$nc),
      pcu = sum(.data$nc) / sum(.data[[.input$name_slen]]),
      anu = mean(.data[[.input$name_outcome]] == 1),
      .groups = "drop_last"
    ) |>
    summarise(
      nc = sum(.data$nc),
      max_span = .data[[.input$name_slen]] |>
        .subset(.data$anu != 0) |>
        max(),
      mean_span_pcu = min(.data[[.input$name_slen]]) +
        sum(.data$pcu) - 1,
      mean_span_anu = min(.data[[.input$name_slen]]) +
        sum(.data$anu) - 0.5,
      .groups = "drop"
    ) |>
    vctrs::vec_restore(data)
}
