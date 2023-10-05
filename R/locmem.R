#' Location Memory
#'
#' Several tests are based on subject's spatial acuity, so typically a distance
#' error is collected and scores are calculated based on that error. [locmem()]
#' deal with the distance condition only. [locmem2()] deals with a special case
#' when the response order and distance both matter.
#'
#' @template common
#' @template options
#' @return An object with the same class as `data` contains following values:
#'
#'   \item{nc_loc}{Count of correct responses for location.}
#'
#'   \item{mean_dist_err}{Mean of the response distance errors.}
#'
#'   \item{mean_log_err}{Mean of the log-transformed (of base \eqn{e}) response
#'   distance errors.}
#'
#'   \item{nc_order}{Count of correct responses for order. For [locmem2()]
#'   only.}
#' @export
locmem <- function(data, .by = NULL, .input = NULL, .extra = NULL) {
  .input <- list(name_dist = "resplocdist") |>
    update_settings(.input)
  data |>
    mutate(
      dist = parse_char_resp(.data[[.input$name_dist]]),
      .keep = "unused"
    ) |>
    unnest("dist") |>
    group_by(pick(all_of(.by))) |>
    summarise(
      nc_loc = sum(.data$dist == 0),
      mean_dist_err = mean(.data$dist),
      mean_log_err = mean(log(.data$dist + 1)),
      .groups = "drop"
    ) |>
    vctrs::vec_restore(data)
}

#' @rdname locmem
#' @export
locmem2 <- function(data, .by = NULL, .input = NULL, .extra = NULL) {
  .input <- list(
    name_dist = "resplocdist",
    name_acc_order = "respaccorder"
  ) |>
    update_settings(.input)
  merge(
    locmem(data, .by, .input, .extra),
    data |>
      mutate(
        acc_order = parse_char_resp(.data[[.input$name_acc_order]]),
        .keep = "unused"
      ) |>
      unnest("acc_order") |>
      group_by(pick(all_of(.by))) |>
      summarise(
        nc_order = sum(.data$acc_order == 1),
        .groups = "drop"
      ),
    by = .by
  ) |>
    vctrs::vec_restore(data)
}
