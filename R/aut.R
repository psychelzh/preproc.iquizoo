#' Alternate Uses Task (AUT)
#'
#' The Alternate Uses Task (AUT) is a test of divergent thinking, which is a
#' component of creativity. The test-taker is given a common object and asked
#' to list as many uses for that object as they can think of. The test is
#' scored based on the number of uses generated, the originality of the uses,
#' the flexibility of the uses, and the fluency of the uses. The originality
#' score is based on the number of participants who generated the same use for
#' the object. The flexibility score is based on the number of categories of
#' uses generated. The fluency score is based on the total number of uses
#' generated.
#'
#' @template common
#' @template options
#' @return An object with the same class as `data` contains following values:
#'
#'   \item{originality}{The originality score.}
#'
#'   \item{flexibility}{The flexibility score.}
#'
#'   \item{fluency}{The fluency score.}
#'
#' @export
aut <- function(data, .by = NULL, .input = NULL, .extra = NULL) {
  .input <- list(
    name_tool = "tool",
    name_use = "use",
    name_use_type = "use_type",
    name_grader = "subj",
    name_score_origin = "score_origin"
  ) |>
    update_settings(.input)
  .extra <- list(
    grade_types = data.frame(),
    grade_scores = data.frame()
  ) |>
    update_settings(.extra)
  data |>
    left_join(
      .extra$grade_types,
      by = c(.input$name_tool, .input$name_use),
      relationship = "many-to-many"
    ) |>
    left_join(
      .extra$grade_scores,
      by = c(.input$name_grader, .input$name_tool, .input$name_use_type),
    ) |>
    filter(.data[[.input$name_use_type]] != "0") |>
    group_by(pick(all_of(c(.by, .input$name_grader, .input$name_tool)))) |>
    summarise(
      originality = sum(.data[[.input$name_score_origin]]),
      flexibility = n_distinct(.data[[.input$name_use_type]]),
      fluency = n(),
      .groups = "drop_last"
    ) |>
    # average across tools
    summarise(
      across(
        c("originality", "flexibility", "fluency"),
        mean
      ),
      .groups = "drop_last"
    ) |>
    # average across graders
    summarise(
      across(
        c("originality", "flexibility", "fluency"),
        mean
      ),
      .groups = "drop"
    )
}
