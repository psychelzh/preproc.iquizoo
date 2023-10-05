#' Judgment of Line Orientation
#'
#' This test is about visuo-spatial skills. For more details, read [this
#' introduction](https://en.wikipedia.org/wiki/Judgment_of_Line_Orientation).
#'
#' @template common
#' @template options
#' @return An object with the same class as `data` contains following values:
#'
#'   \item{nc}{Count of correct responses.}
#'
#'   \item{mean_ang_err}{Mean of the response angle errors.}
#'
#'   \item{mean_log_err}{Mean of the log-transformed (of base 2) response angle
#'     errors.}
#' @export
jlo <- function(data, .by = NULL, .input = NULL, .extra = NULL) {
  .input <- list(name_resp = "resp", name_angle = "angle", name_acc = "acc") |>
    update_settings(.input)
  .extra <- list(resp_anticlock = "left", resp_clockwise = "right") |>
    update_settings(.extra)
  data |>
    mutate(
      resp_angle = stringr::str_split(.data[[.input$name_resp]], "-") |>
        purrr::map_dbl(
          ~ sum(
            case_match(
              .,
              !!!purrr::map2(
                .extra[c("resp_anticlock", "resp_clockwise")],
                c(1, -1),
                new_formula
              )
            ) * 6
          )
        ),
      resp_err_raw = abs(
        .data$resp_angle - .data[[.input$name_angle]]
      ) %% 180, # ignore vector head and tail
      resp_err = ifelse(
        .data$resp_err_raw > 90, # measure errors as acute angles
        180 - .data$resp_err_raw,
        .data$resp_err_raw
      )
    ) |>
    group_by(pick(all_of(.by))) |>
    summarise(
      nc = sum(.data[[.input$name_acc]] == 1),
      mean_ang_err = mean(.data$resp_err),
      # make sure it is between 0 and 1
      mean_log_err = mean(log2(.data$resp_err / 90 + 1)),
      .groups = "drop"
    ) |>
    vctrs::vec_restore(data)
}
