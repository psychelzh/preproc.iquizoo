#' Calculates index scores for Simple Reaction Time game
#'
#' Mean reaction time is returned.
#'
#' @param data Raw data of class `data.frame`.
#' @param ... Other input argument for future expansion.
#' @return A `data.frame` contains following values:
#'   \item{mrt}{Mean reaction time}
#'   \item{is_normal}{Checking result whether the data is normal.}
#' @export
srt <- function(data, ...) {
  vars_output <- "mrt"
  vars_required <- tibble::tribble(
    ~ field, ~ name,
    "name_rt", "RT"
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
  data_valid <- data %>%
    dplyr::filter(.data$RT > 100)
  # do not calculate those with valid response rate less than 80%
  if (nrow(data_valid) / nrow(data) < 0.8) {
    warning("Valid response rate is less than 80%.")
    return(
      data.frame(
        mrt = NA_real_,
        is_normal = FALSE
      )
    )
  }
  data_valid %>%
    dplyr::summarise(
      mrt = mean(.data$RT),
      is_normal = TRUE
    )
}
