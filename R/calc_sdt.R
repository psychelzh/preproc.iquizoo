#' Signal Detection Theory
#'
#' Calculate sensitivity index and bias based on signal detection theory. The
#' correction for extreme proportions of zero and one is the "log-linear" rule
#' recommended by Hautus (1995).
#'
#' @templateVar by low
#' @templateVar name_acc TRUE
#' @template params-template
#' @param name_type The column name of the `data` input whose values are the
#'   stimuli types, in which is a `character` vector with value `"s"` (denoting
#'   "*signal*") and `"n"` (denoting "*non-signal*") only. It will be coerced as
#'   a `factor` vector with these two levels.
#' @param keep_counts A logical value. Whether the counts of correct and error
#'   be returned. Default is `TRUE`.
#' @return A [tibble][tibble::tibble-package] contains sensitivity index and
#'   bias (and other counts measures)
#' @keywords internal
calc_sdt <- function(data, by, name_acc, name_type, keep_counts = TRUE) {
  data %>%
    dplyr::mutate(
      "{name_type}" := factor(
        .data[[name_type]],
        c("s", "n")
      )
    ) %>%
    dplyr::group_by(dplyr::across(dplyr::all_of(c(by, name_type)))) %>%
    dplyr::summarise(
      c = sum(.data[[name_acc]] == 1),
      e = dplyr::n() - .data[["c"]],
      .groups = "drop"
    ) %>%
    dplyr::mutate(
      dplyr::across(
        dplyr::all_of(c("c", "e")),
        # log-linear rule of correction extreme proportion
        ~ (.x + 0.5) / (.data[["c"]] + .data[["e"]] + 1),
        .names = "p{.col}"
      )
    ) %>%
    tidyr::pivot_wider(
      names_from = .data[[name_type]],
      values_from = c("c", "e", "pc", "pe")
    ) %>%
    dplyr::mutate(
      hits = .data[["c_s"]],
      commissions = .data[["e_n"]],
      omissions = .data[["e_s"]],
      ne = .data[["e_n"]] + .data[["e_s"]],
      dprime = stats::qnorm(.data[["pc_s"]]) - stats::qnorm(.data[["pe_n"]]),
      c = - (stats::qnorm(.data[["pc_s"]]) + stats::qnorm(.data[["pe_n"]])) / 2
    ) %>%
    dplyr::select(
      dplyr::all_of(
        c(
          by, "dprime", "c",
          if (keep_counts) c("hits", "commissions", "omissions", "ne")
        )
      )
    )
}
