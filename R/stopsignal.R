#' Stop Signal Paradigm
#'
#' A classical test on inhibition skills. The index calculation is now based on
#' https://doi.org/10.7554/eLife.46323.
#'
#' @template common
#' @template options
#' @return A [tibble][tibble::tibble-package] with the following variables:
#'   \item{pc_all}{Percent of correct for all the responses.}
#'   \item{pc_go}{Percent of correct for the go trials only.}
#'   \item{pc_stop}{Percent of correct for the stop trials only.}
#'   \item{rt_nth}{Percentile go reaction time (ms) based on `pc_stop`.}
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
  data |>
    mutate(
      rt_cor = ifelse(
        .data[[.input$name_acc]] == -1,
        .extra$rt_max,
        .data[[.input$name_rt]]
      )
    ) |>
    group_by(across(all_of(.by))) |>
    group_modify(
      ~ .calc_ssrt(
        .x,
        name_type = .input$name_type,
        name_acc = .input$name_acc,
        name_rt = "rt_cor",
        name_ssd = .input$name_ssd,
        type_go = .extra$type_go
      )
    ) |>
    ungroup()
}

.calc_ssrt <- function(data, name_type, name_acc, name_rt, name_ssd, type_go) {
  pcs <- data |>
    summarise(
      pc_all = mean(.data[[name_acc]] == 1),
      pc_go = mean(.subset(
        .data[[name_acc]] == 1,
        .data[[name_type]] == type_go
      )),
      pc_stop = mean(.subset(
        .data[[name_acc]] == 1,
        .data[[name_type]] != type_go
      ))
    )
  data |>
    filter(.data[[name_type]] != type_go) |>
    group_by(.data[[name_type]]) |>
    summarise(
      ssd = calc_staircase_wetherill(.data[[name_ssd]]),
      .groups = "drop"
    ) |>
    summarise(mean_ssd = mean(.data$ssd)) |>
    transmute(
      rt_nth = stats::quantile(data[[name_rt]], 1 - pcs$pc_stop, names = FALSE),
      ssrt = .data$rt_nth - .data$mean_ssd
    ) |>
    bind_cols(pcs)
}
