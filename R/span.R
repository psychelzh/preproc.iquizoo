#' Span (spatial or verbal)
#'
#' There is a bunch of tests measuring working memory span or attention span.
#'
#' @template common
#' @template options
#' @return A [tibble][tibble::tibble-package] contains following values:]
#'   \item{nc}{Count of correct responses.}
#'   \item{max_span}{Maximal span.}
#'   \item{mean_span}{Mean span.}
#' @export
span <- function(data, .by = NULL, .input = NULL, .extra = NULL) {
  .input <- list(
    name_slen = "slen",
    name_outcome = "outcome",
    name_acc = "correctness"
  ) |>
    update_settings(.input)
  data |>
    mutate(
      acc = parse_char_resp(.data[[.input[["name_acc"]]]]),
      nc = purrr::map_dbl(.data[["acc"]], ~ sum(.x == 1))
    ) |>
    group_by(across(all_of(c(.by, .input[["name_slen"]])))) |>
    summarise(
      nc = sum(.data[["nc"]]),
      pcu = sum(.data[["nc"]]) / sum(.data[[.input[["name_slen"]]]]),
      anu = mean(.data[[.input[["name_outcome"]]]] == 1),
      .groups = "drop_last"
    ) |>
    summarise(
      nc = sum(.data[["nc"]]),
      max_span = max(.data[[.input[["name_slen"]]]]),
      mean_span_pcu = min(.data[[.input[["name_slen"]]]]) +
        sum(.data[["pcu"]]) - 1,
      mean_span_anu = min(.data[[.input[["name_slen"]]]]) +
        sum(.data[["anu"]]) - 0.5,
      .groups = "drop"
    )
}
