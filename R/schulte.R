#' Calculates index scores for Schulte Grid games
#'
#' The net count of correct responses (net_cor) is returned, which is just the
#' difference of the count of correct responses and error responses.
#'
#' @param data Raw data of class `data.frame`.
#' @param ... Other input argument for future expansion.
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{net_cor}{Net correct count.}
#'   \item{is_normal}{Checking result whether the data is normal.}
#' @export
schulte <- function(data, ...) {
  vars_output <- "net_cor"
  vars_required <- tibble::tribble(
    ~field, ~name,
    "name_ncorrect", "NCorrect",
    "name_nerror", "NError"
  )
  vars_matched <- match_data_vars(data, vars_required)
  if (is.null(vars_matched)) {
    return(compose_abnormal_output(vars_output))
  }
  tibble(data) %>%
    dplyr::summarise(
      net_cor = sum(.data[[vars_matched["name_ncorrect"]]]) -
        sum(.data[[vars_matched["name_nerror"]]]),
      is_normal = TRUE
    )
}
