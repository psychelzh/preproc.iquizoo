#' Count Correct Responses
#'
#' These functions count the number of correct responses. [countcorrect()]
#' counts the correct responses regardless of errors, [countcorrect2()]
#' subtracts the number of errors from number of correct responses,
#' [sumweighted()] counts the correct responses by giving a weight for different
#' responses, [sumscore()] adds up the score for each response.
#'
#' @name counts
#' @templateVar .by low
#' @template params-template
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{nc}{Count of correct responses. For [countcorrect()].}
#'   \item{nc_cor}{Corrected count of correct responses (subtracting number of
#'     errors). For [countcorrect2()].}
#'   \item{nc_weighted}{Count of weighted correct responses. For
#'     [sumweighted()].}
#'   \item{nc_score}{Sum of scores. For [sumscore()].}
NULL

#' @rdname counts
#' @export
countcorrect <- function(data, .by) {
  .input <- list(name_acc = "acc") |>
    update_settings("preproc.input")
  if (is.character(data[[.input[["name_acc"]]]])) {
    # character input uses "-" to separate individual responses
    data <- data |>
      mutate(
        r"({.input[["name_acc"]]})" := parse_char_resp(
          .data[[.input[["name_acc"]]]]
        )
      ) |>
      unnest(.data[[.input[["name_acc"]]]])
  }
  data |>
    group_by(across(all_of(.by))) |>
    summarise(
      # NA might be produced in parsing characters
      nc = sum(.data[[.input[["name_acc"]]]] == 1, na.rm = TRUE),
      .groups = "drop"
    )
}

#' @rdname counts
#' @export
countcorrect2 <- function(data, .by) {
  .input <- list(name_nc = "ncorrect", name_ne = "nerror") |>
    update_settings("preproc.input")
  data |>
    group_by(across(all_of(.by))) |>
    summarise(
      nc_cor = sum(
        .data[[.input[["name_nc"]]]] - .data[[.input[["name_ne"]]]]
      ),
      .groups = "drop"
    )
}

#' @rdname counts
#' @export
sumweighted <- function(data, .by) {
  .input <- list(name_weight = "nstim", name_acc = "acc") |>
    update_settings("preproc.input")
  data |>
    group_by(across(all_of(.by))) |>
    summarise(
      nc_weighted = sum(
        .data[[.input[["name_weight"]]]] *
          (.data[[.input[["name_acc"]]]] == 1)
      ),
      .groups = "drop"
    )
}

#' @rdname counts
#' @export
sumscore <- function(data, .by) {
  .input <- list(name_score = "score") |>
    update_settings("preproc.input")
  data |>
    group_by(across(all_of(.by))) |>
    summarise(
      nc_score = sum(as.numeric(.data[[.input[["name_score"]]]])),
      .groups = "drop"
    )
}
