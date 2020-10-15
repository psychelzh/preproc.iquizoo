#' Calculates index scores for BART game specifically
#'
#' The adjusted and unadjusted BART scores are both returned.
#'
#' @param data Raw data of class `data.frame`.
#' @param ... Other input argument for future expansion.
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{mean_hits}{Mean of hits for balloons not exploded.}
#'   \item{mean_hits_raw}{Mean of hits for all balloons.}
#'   \item{is_normal}{Checking result whether the data is normal.}
#' @export
bart <- function(data, ...) {
  vars_output <- c("mean_hits", "mean_hits_raw")
  vars_required <- tibble::tribble(
    ~ field, ~ name,
    "name_nhit", "NHit",
    "name_feedback", "Feedback"
  )
  vars_matched <- match_data_vars(data, vars_required)
  if (is.null(vars_matched)) {
    return(
      rlang::set_names(
        rep(NA, length(vars_output)),
        nm = vars_output
      ) %>%
        tibble::as_tibble_row() %>%
        tibble::add_column(is_normal = FALSE)
    )
  }
  tibble(data) %>%
    dplyr::summarise(
      mean_hits = mean(.data$NHit[.data$Feedback == 1]),
      mean_hits_raw = mean(.data$NHit),
      is_normal = TRUE
    )
}
