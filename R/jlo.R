#' Judgment of Line Orientation
#'
#' This test is about visuo-spatial skills. For more details, read [this
#' introduction](https://en.wikipedia.org/wiki/Judgment_of_Line_Orientation).
#'
#' @templateVar by low
#' @templateVar vars_input TRUE
#' @template params-template
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{nc}{Count of correct responses.}
#'   \item{mean_ang_err}{Mean of the response angle errors.}
#'   \item{mean_log_err}{Mean of the log-transformed (of base 2) response angle
#'     errors.}
#' @export
jlo <- function(data, by, vars_input) {
  data |>
    mutate(
      resp_angle = stringr::str_split(
        .data[[vars_input[["name_resp"]]]],
        "-"
      ) |>
        purrr::map_dbl(
          ~ sum(recode(.x, left = 1, right = -1) * 6)
        ),
      resp_err_raw = abs(
        .data[["resp_angle"]] - .data[[vars_input[["name_angle"]]]]
      ) %% 180, # ignore vector head and tail
      resp_err = ifelse(
        .data[["resp_err_raw"]] > 90, # measure errors as acute angles
        180 - .data[["resp_err_raw"]],
        .data[["resp_err_raw"]]
      )
    ) |>
    group_by(across(all_of(by))) |>
    summarise(
      nc = sum(.data[[vars_input[["name_acc"]]]] == 1),
      mean_ang_err = mean(.data[["resp_err"]]),
      # make sure it is between 0 and 1
      mean_log_err = mean(log2(.data[["resp_err"]] / 90 + 1)),
      .groups = "drop"
    )
}
