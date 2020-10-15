#' Calculates index scores for Driving game.
#'
#' Caculcate the ratio of still duration in yellow light state.
#'
#' @param data Raw data of class `data.frame`.
#' @param ... Other input argument for future expansion.
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{still_ratio}{The ratio of still duration in yellow light state.}
#'   \item{is_normal}{Checking result whether the data is normal.}
#' @export
driving <- function(data, ...) {
  vars_output <- "still_ratio"
  vars_required <- tibble::tribble(
    ~field, ~name,
    "name_yellow_dur", "YellowDur",
    "name_still_dur", "StillDur",
    "name_still_light", "StillLight"
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
  tibble(
    still_dur = data$StillDur %>%
      paste(collapse = "-") %>%
      strsplit("-") %>%
      unlist() %>%
      as.numeric(),
    still_light = data$StillLight %>%
      paste(collapse = "-") %>%
      strsplit("-") %>%
      unlist()
  ) %>%
    dplyr::summarise(
      still_ratio = sum(.data$still_dur[.data$still_light == "Yellow"]) /
        sum(data$YellowDur),
      is_normal = TRUE
    )
}
