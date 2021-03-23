#' Calculates index scores for Choice Reaction Time game
#'
#' Now we majorly consider two indices: mean reaction time and count of correct
#' responses.
#'
#' @param data Raw data of class `data.frame`.
#' @param ... Other input argument for future expansion.
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{mrt}{Mean reaction time}
#'   \item{nc}{Count of correct responses}
#'   \item{is_normal}{Checking result whether the data is normal.}
#' @export
crt <- function(data, ...) {
  vars_output <- c("mrt", "nc")
  vars_required <- tibble::tribble(
    ~field, ~name,
    "name_acc", "ACC",
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
  tibble(data) %>%
    dplyr::mutate(
      rt_adj = dplyr::if_else(
        .data[[vars_matched["name_acc"]]] == 1,
        .data[[vars_matched[["name_rt"]]]], NA_integer_
      )
    ) %>%
    dplyr::summarise(
      mrt = mean(.data[["rt_adj"]], na.rm = TRUE),
      nc = sum(.data[[vars_matched["name_acc"]]] == 1),
      is_normal = TRUE
    )
}
