#' SynWin Test
#'
#' This is a multi-task game designed by Elsmore (1994).
#'
#' @template common
#' @template options
#' @return A [tibble][tibble::tibble-package] contains following values:
#'
#'   \item{score_total}{Total score. Sum of the three sub-tests.}
#'
#'   \item{score_mem}{Score in the memory sub-test.}
#'
#'   \item{score_vis}{Score in visual monitoring sub-test.}
#'
#'   \item{score_aud}{Score in auditory monitoring sub-test.}
#'
#' @export
synwin <- function(data, .by = NULL, .input = NULL, .extra = NULL) {
  .input <- list(
    name_status = "status",
    name_acc = "acc"
  ) |>
    update_settings(.input)
  .extra <- list(
    status_mem = c("flip", "drag"),
    status_vis = as.character(0:10),
    status_aud = c("low", "high"),
    aud_target = "high"
  ) |>
    update_settings(.extra)
  data |>
    mutate(
      task = case_when(
        .data[[.input$name_status]] %in% .extra$status_mem ~ "mem",
        .data[[.input$name_status]] %in% .extra$status_vis ~ "vis",
        .data[[.input$name_status]] %in% .extra$status_aud ~ "aud"
      ),
      score = case_when(
        .data$task == "mem" ~ .data[[.input$name_acc]] / 2,
        .data$task == "vis" ~
          if_else(
            .data[[.input$name_acc]] == 1,
            1 - suppressWarnings(as.numeric(.data[[.input$name_status]])) / 10,
            -1
          ),
        .data$task == "aud" ~
          if_else(
            .data[[.input$name_status]] == .extra$aud_target,
            1, 0.25
          ) * (.data[[.input$name_acc]] * 2 - 1)
      )
    ) |>
    group_by(across(all_of(c(.by, "task")))) |>
    summarise(score = sum(.data$score), .groups = "drop_last") |>
    mutate(score_total = sum(.data$score)) |>
    ungroup() |>
    pivot_wider(
      names_from = .data$task,
      names_prefix = "score_",
      values_from = .data$score
    )
}
