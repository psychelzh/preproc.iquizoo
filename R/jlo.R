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
  .input <- list(
    name_resp = "resp",
    name_angle = "angle",
    name_acc = "acc"
  ) |>
    update_settings(.input)
  .extra <- list(
    resp_anticlock = "left",
    resp_clockwise = "right"
  ) |>
    update_settings(.extra)
  data |>
    mutate(
      resp_err = calc_angle_err(
        .data[[.input$name_resp]],
        .data[[.input$name_angle]],
        resp_anti = .extra$resp_anticlock,
        resp_clock = .extra$resp_clockwise
      )
    ) |>
    summarise(
      nc = sum(.data[[.input$name_acc]] == 1),
      mean_ang_err = mean(.data$resp_err),
      # make sure it is between 0 and 1
      mean_log_err = mean(log2(.data$resp_err / 90 + 1)),
      .by = all_of(.by)
    ) |>
    vctrs::vec_restore(data)
}

# helper function
calc_angle_err <- function(resp, angle, resp_anti, resp_clock) {
  resp_angle <- purrr::map_dbl(
    stringr::str_split(resp, "-"),
    ~ sum(
      case_match(
        .x,
        resp_anti ~ 1,
        resp_clock ~ -1
      ) * 6 # each rotation is 6 degree
    )
  )
  # ignore vector head and tail
  err_raw <- abs(resp_angle - angle) %% 180
  # measure errors as acute angles
  if_else(err_raw > 90, 180 - err_raw, err_raw)
}
