#' Verb Generation
#'
#' This test requires the user to generate a verb that is semantically related
#' to each given noun. The score is the average cosine distance between the
#' generated verb and the given nouns.
#'
#' @template common
#' @template options
#' @return An object with the same class as `data` contains following values:
#'
#'   \item{score}{Average cosine distance between the generated verbs and the
#'     given nouns.}
#' @export
vg <- function(data, .by = NULL, .input = NULL, .extra = NULL) {
  .input <- list(
    name_noun = "noun",
    name_verb = "verb",
    name_dist = "dist_cos"
  ) |>
    update_settings(.input)
  .extra <- list(
    min_prop_miss = 0.2,
    dists = data.frame() # note this must be set by the user
  ) |>
    update_settings(.extra)
  data |>
    left_join(.extra$dists, by = c(.input$name_noun, .input$name_verb)) |>
    filter(mean(!is.na(.data[[.input$name_verb]])) >= .extra$min_prop_miss) |>
    summarise(
      score = mean(.data[[.input$name_dist]], na.rm = TRUE),
      .by = all_of(.by)
    ) |>
    vctrs::vec_restore(data)
}
