#' Calculates index scores for Multisense games.
#'
#' Three mean reaction times as to Image, Sound and Mixed stimuli are returned.
#'
#' @param data Raw data of class `data.frame`.
#' @param ... Other input argument for future expansion.
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{mrt_image}{Mean reaction time of Image stimuli.}
#'   \item{mrt_sound}{Mean reaction time of Sound stimuli.}
#'   \item{mrt_mixed}{Mean reaction time of Mixed stimuli.}
#'   \item{mrt_mixadv}{Mean reaction decrease of Mixed stimuli compared to other two types of stimuli.}
#'   \item{is_normal}{Checking result whether the data is normal.}
#' @export
multisense <- function(data, ...) {
  vars_output <- c("mrt_image", "mrt_sound", "mrt_mixed", "mrt_mixadv")
  vars_required <- tibble::tribble(
    ~ field, ~ name,
    "name_type", "Type",
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
  data %>%
    dplyr::filter(.data$RT > 100) %>%
    dplyr::group_by(.data$Type) %>%
    dplyr::summarise(mrt = mean(.data$RT)) %>%
    tidyr::pivot_wider(names_from = "Type", values_from = "mrt") %>%
    dplyr::transmute(
      mrt_image = .data$Image,
      mrt_sound = .data$Sound,
      mrt_mixed = .data$Mixed,
      mrt_mixadv = (.data$Image + .data$Sound) / 2 - .data$Mixed,
      is_normal = TRUE
    )
}
