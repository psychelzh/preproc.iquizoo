#' London Tower
#'
#' A classical test on problem solving.
#'
#' @template common
#' @template options
#' @return An object with the same class as `data` contains following values:
#'
#'   \item{prop_perfect}{Proportion of responses with minimal moves.}
#'
#'   \item{mrt_init}{Mean initial response time.}
#' @export
london <- function(data, .by = NULL, .input = NULL, .extra = NULL) {
  .input <- list(
    name_minmove = "minmove",
    name_timeinit = "timeinit",
    name_stepsused = "stepsused",
    name_finished = "finished"
  ) |>
    update_settings(.input)
  merge(
    data |>
      summarise(
        prop_perfect = mean(
          .data[[.input$name_stepsused]] == .data[[.input$name_minmove]]
        ),
        .by = all_of(.by)
      ),
    calc_spd_acc(
      data,
      by = .by,
      name_acc = .input$name_finished,
      name_rt = .input$name_timeinit
    ),
    by = .by
  ) |>
    select(all_of(c(.by, "prop_perfect", mrt_init = "mrt"))) |>
    vctrs::vec_restore(data)
}
