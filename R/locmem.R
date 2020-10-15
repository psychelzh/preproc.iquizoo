#' Calculates index scores for Location Memory (so-called Black Hole) games.
#'
#' Mean distance and percentage of correct responses are returned.
#'
#' @param data Raw data of class `data.frame`.
#' @param ... Other input argument for future expansion.
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{mean_dist}{Mean distance.}
#'   \item{pc}{Percentage of correct responses.}
#'   \item{is_normal}{Checking result whether the data is normal.}
#' @export
locmem <- function(data, ...) {
  vars_output <- c("mean_dist", "pc")
  vars_required <- tibble::tribble(
    ~ field, ~ name,
    "name_dist_loc", "RespLocDist"
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
  delim <- "-"
  all_dists <- data %>%
    dplyr::pull("RespLocDist") %>%
    paste(collapse = delim) %>%
    strsplit(delim) %>%
    unlist() %>%
    as.numeric()
  tibble(
    mean_dist = mean(all_dists),
    pc = mean(all_dists == 0),
    is_normal = TRUE
  )
}
