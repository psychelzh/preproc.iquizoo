#' Visual Arrays
#'
#' The visual arrays task is used to measure working memory capacity. Here we
#' calculate the capacity from data. Note this is used when the whole visual
#' arrays are to be detected.
#'
#' @template common
#' @template options
#'
#' @return An object with the same class as `data` contains following values:
#'
#'   \item{k}{The mean capacity in all conditions.}
#'
#'   \item{k3}{The capacity in condition of 3 arrays.}
#'
#'   \item{k5}{The capacity in condition of 5 arrays.}
#'
#'   \item{k7}{The capacity in condition of 7 arrays.}
#'
#'   \item{k9}{The capacity in condition of 9 arrays.}
#'
#' @export
capacity <- function(data, .by = NULL, .input = NULL, .extra = NULL) {
  .input <- list(
    name_target = "numtarget",
    name_cresp = "cresp",
    name_acc = "acc"
  ) |>
    update_settings(.input)
  .extra <- list(
    type_signal = "change"
  ) |>
    update_settings(.extra)
  data |>
    summarise(
      hit = (.data[[.input$name_acc]] == 1) |>
        .subset(.data[[.input$name_cresp]] == .extra$type_signal) |>
        mean.default(),
      fa = (.data[[.input$name_acc]] == 0) |>
        .subset(.data[[.input$name_cresp]] != .extra$type_signal) |>
        mean.default(),
      .by = all_of(c(.by, .input$name_target))
    ) |>
    mutate(
      k_cond = if_else(
        .data$fa == 1,
        NaN,
        .data[[.input$name_target]] * (.data$hit - .data$fa) / (1 - .data$fa)
      )
    ) |>
    mutate(k = mean(.data$k_cond), .by = all_of(.by)) |>
    pivot_wider(
      id_cols = all_of(c(.by, "k")),
      names_from = all_of(.input$name_target),
      names_prefix = "k",
      names_sort = TRUE,
      values_from = "k_cond"
    )
}
