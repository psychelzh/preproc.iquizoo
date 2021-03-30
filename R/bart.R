#' Calculates index scores for BART game specifically
#'
#' The adjusted and unadjusted BART scores are both returned.
#'
#' @param data Raw data of class `data.frame`.
#' @param vars_input This is done by other functions, storing the matched
#'   variable names for further processing.
#' @param by The column(s) variable names in `data` used to be grouped by. Note,
#'   the check of existence is in the higher level function, so here in this
#'   function does not check them.
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{mean_pumps}{Mean of hits for balloons not exploded.}
#'   \item{mean_pumps_raw}{Mean of hits for all balloons.}
#'   \item{num_explosion}{Number of exploded balloons.}
#'   \item{is_normal}{Checking result whether the data is normal.}
#' @export
bart <- function(data, vars_input, by) {
  data %>%
    dplyr::mutate(
      hit_cor = .data[[vars_input[["name_nhit"]]]] *
        .data[[vars_input[["name_feedback"]]]]
    ) %>%
    dplyr::group_by(dplyr::across(dplyr::all_of(by))) %>%
    dplyr::summarise(
      mean_pumps = mean(.data[["hit_cor"]]),
      mean_pumps_raw = mean(.data[[vars_input[["name_nhit"]]]]),
      num_explosion = sum(.data[[vars_input[["name_feedback"]]]] == 0),
      is_normal = TRUE,
      .groups = "drop"
    )
}
