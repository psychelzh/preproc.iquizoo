#' Stop Signal Paradigm
#'
#' A classical test on inhibition skills. The index calculation is now based on
#' https://doi.org/10.7554/eLife.46323.
#'
#' @template common
#' @template options
#' @return A [tibble][tibble::tibble-package] with the following variables:
#'
#'   \item{pc_all}{Percent of correct for all the responses.}
#'
#'   \item{pc_go}{Percent of correct for the go trials only.}
#'
#'   \item{pc_stop}{Percent of correct for the stop trials only.}
#'
#'   \item{rt_nth}{Percentile go reaction time (ms) based on `pc_stop`.}
#'
#'   \item{mean_ssd}{Mean of stop signal delay (ms).}
#'
#'   \item{ssrt}{Stop signal reaction time (ms).}
#' @export
stopsignal <- function(data, .by = NULL, .input = NULL, .extra = NULL) {
  .input <- list(
    name_type = "type",
    name_ssd = "ssd",
    name_acc = "acc",
    name_rt = "rt"
  ) |>
    update_settings(.input)
  .extra <- list(
    type_go = "go",
    rt_max = 1000
  ) |>
    update_settings(.extra)

  merge(
    data |>
      mutate(
        rt_cor = ifelse(
          .data[[.input$name_acc]] == -1,
          .extra$rt_max,
          .data[[.input$name_rt]]
        )
      ) |>
      summarise(
        pc_all = mean(.data[[.input$name_acc]] == 1),
        pc_go = mean(.subset(
          .data[[.input$name_acc]] == 1,
          .data[[.input$name_type]] == .extra$type_go
        )),
        pc_stop = mean(.subset(
          .data[[.input$name_acc]] == 1,
          .data[[.input$name_type]] != .extra$type_go
        )),
        rt_nth = stats::quantile(
          .data$rt_cor,
          1 - .data$pc_stop,
          names = FALSE
        ),
        .by = all_of(.by)
      ),
    data |>
      filter(.data[[.input$name_type]] != .extra$type_go) |>
      group_by(pick(all_of(c(.by, .input$name_type)))) |>
      summarise(
        ssd = calc_staircase_wetherill(.data[[.input$name_ssd]]),
        .groups = "drop_last"
      ) |>
      summarise(mean_ssd = mean(.data$ssd), .groups = "drop"),
    by = .by
  ) |>
    mutate(ssrt = .data$rt_nth - .data$mean_ssd) |>
    vctrs::vec_restore(data)
}
