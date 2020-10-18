#' Calculates index scores for BART game specifically
#'
#' The adjusted and unadjusted BART scores are both returned.
#'
#' @param data Raw data of class `data.frame`.
#' @param ... Other input argument for future expansion.
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{mean_pumps}{Mean of hits for balloons not exploded.}
#'   \item{mean_pumps_raw}{Mean of hits for all balloons.}
#'   \item{num_explosion}{Number of exploded balloons.}
#'   \item{is_normal}{Checking result whether the data is normal.}
#' @export
bart <- function(data, ...) {
  vars_output <- c("mean_pumps", "mean_pumps_raw", "num_explosion")
  vars_required <- tibble::tribble(
    ~field, ~name,
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
      mean_pumps = mean(.data$NHit[.data$Feedback == 1]),
      mean_pumps_raw = mean(.data$NHit),
      num_explosion = sum(.data$Feedback == 0),
      is_normal = !is.na(.data$mean_pumps)
    )
}
