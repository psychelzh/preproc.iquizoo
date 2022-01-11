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
    mem_flip = "flip",
    mem_drag = "drag",
    vis_empty = "empty",
    vis_nonempty = "nonempty",
    vis_depletion = "depletion",
    aud_low = "low",
    aud_high = "high"
  ) |>
    update_settings(.extra)
  data |>
    mutate(
      task_status = names(.extra)[match(.data[[.input$name_status]], .extra)]
    ) |>
    separate(.data$task_status, c("task", "status")) |>
    mutate(
      score = case_when(
        .data$task == "mem" ~ .data[[.input$name_acc]] / 2,
        .data$task == "vis" ~ if_else(
          .data[[.input$name_acc]] == 1,
          if_else(
            .data[[.input$name_status]] == .extra$vis_empty,
            2, 1
          ),
          if_else(
            .data[[.input$name_status]] == .extra$vis_depletion,
            -0.25, -0.5
          )
        ),
        .data$task == "aud" ~ if_else(
          .data[[.input$name_status]] == .extra$aud_low,
          0.25, 1
        ) * (.data[[.input$name_acc]] *2 - 1)
      )
    ) |>
    group_by(across(all_of(c(.by, "task")))) |>
    summarise(score = sum(score), .groups = "drop") |>
    mutate(score_scale = scale(score)[, 1]) |>
    group_by(across(all_of(c(.by)))) |>
    mutate(score_total = sum(score_scale)) |>
    ungroup() |>
    select(-score_scale) |>
    pivot_wider(
      names_from = .data$task,
      names_prefix = "score_",
      values_from = .data$score
    )
}
