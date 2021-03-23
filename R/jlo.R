#' Calculates index scores for JLO game.
#'
#' Count of correct responses and other angle deviations indices.
#'
#' @param data Raw data of class `data.frame`.
#' @param ... Other input argument for future expansion.
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{nc}{Count of correct responses.}
#'   \item{ne}{Sum of the angle deviations.}
#'   \item{ne_ln}{Sum of the log of angle deviations.}
#'   \item{ne_sqrt}{Sum of the square root of angle deviations.}
#'   \item{is_normal}{Checking result whether the data is normal.}
#' @export
jlo <- function(data, ...) {
  vars_output <- c("nc", "ne", "ne_ln", "ne_sqrt")
  vars_required <- tibble::tribble(
    ~field, ~name,
    "name_angle", "Angle",
    "name_resp", "Resp",
    "name_acc", "ACC"
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
  nc <- data %>%
    dplyr::summarise(nc = sum(.data[[vars_matched["name_acc"]]] == 1))
  ne <- data %>%
    dplyr::mutate(
      resp_adj = purrr::map_dbl(
        .data[[vars_matched["name_resp"]]],
        ~ strsplit(.x, "-") %>%
          unlist() %>%
          stringr::str_replace_all(c("Left" = "1", "Right" = "-1")) %>%
          as.numeric() %>%
          sum()
      ),
      resp_angle = dplyr::case_when(
        # when rotating larger than a right angle, adjusting it
        .data[["resp_adj"]] > 15 ~ .data[["resp_adj"]] * 6 - 180,
        .data[["resp_adj"]] < -15 ~ .data[["resp_adj"]] * 6 + 180,
        TRUE ~ .data[["resp_adj"]] * 6
      )
    ) %>%
    dplyr::mutate(
      err = abs(.data[[vars_matched["name_angle"]]] - .data[["resp_angle"]])
    ) %>%
    dplyr::summarise(
      ne = sum(.data[["err"]]),
      ne_ln = sum(log(.data[["err"]] + 1)),
      ne_sqrt = sum(sqrt(abs(.data[["err"]])))
    )
  tibble(nc, ne, is_normal = TRUE)
}
