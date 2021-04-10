#' Span (spatial or verbal)
#'
#' There is a bunch of tests measuring working memory span or attention span.
#'
#' @templateVar by low
#' @templateVar vars_input TRUE
#' @template params-template
#' @return A [tibble][tibble::tibble-package] contains following values:]
#'   \item{nc}{Count of correct responses.}
#'   \item{max_span}{Maximal span.}
#'   \item{mean_span}{Mean span.}
#' @export
span <- function(data, by, vars_input) {
  # "nc" is calculated from "Correctness/AccLoc" column, but can be absent
  name_acc_cand <- c("Correctness", "AccLoc")
  name_acc_chk <- rlang::has_name(data, name_acc_cand)
  if (any(name_acc_chk)) {
    name_acc <- name_acc_cand[name_acc_chk]
    nc <- data %>%
      dplyr::mutate(acc = parse_char_resp(.data[[name_acc]])) %>%
      tidyr::unnest(.data[["acc"]]) %>%
      dplyr::group_by(dplyr::across(dplyr::all_of(by))) %>%
      dplyr::summarise(
        nc = sum(.data[["acc"]] == 1),
        .groups = "drop"
      )
  } else {
    nc <- data %>%
      dplyr::group_by(dplyr::across(dplyr::all_of(by))) %>%
      dplyr::summarise(
        nc = NA_integer_,
        .groups = "drop"
      )
  }
  spans <- data %>%
    dplyr::group_by(dplyr::across(
      dplyr::all_of(c(by, vars_input[["name_slen"]]))
    )) %>%
    dplyr::summarise(
      pc = mean(.data[[vars_input[["name_outcome"]]]] == 1),
      .groups = "drop_last"
    ) %>%
    dplyr::summarise(
      max_span = max(.data[[vars_input[["name_slen"]]]]),
      mean_span = sum(.data[["pc"]]) +
        min(.data[[vars_input[["name_slen"]]]]) - .5,
      .groups = "drop"
    )
  dplyr::left_join(nc, spans, by = by)
}
