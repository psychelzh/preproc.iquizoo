#' Count Correct Responses
#'
#' These functions count the number of correct responses. [countcorrect()]
#' counts the correct responses regardless of errors, [countcorrect2()]
#' subtracts the number of errors from number of correct responses,
#' [sumweighted()] counts the correct responses by giving a weight for different
#' responses, [sumscore()] adds up the score for each response.
#'
#' @name counts
#' @template common
#' @template options
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
countcorrect <- function(data, .input = NULL, .extra = NULL) {
  .input <- list(name_nc = "ncorrect", name_acc = "acc") |>
    update_settings(.input)
  if (!has_name(data, .input$name_nc)) {
    if (is.character(data[[.input$name_acc]])) {
      # character input uses "-" to separate individual responses
      data <- data |>
        mutate(
          "{.input$name_acc}" := parse_char_resp(
            .data[[.input$name_acc]]
          )
        ) |>
        unnest(.data[[.input$name_acc]])
    }
    data <- summarise(
      data,
      # `NA` might be produced in parsing characters
      "{.input$name_nc}" := sum(.data[[.input$name_acc]] == 1, na.rm = TRUE)
    )
  }
  summarise(data, nc = sum(.data[[.input$name_nc]]))
}

#' @rdname counts
#' @export
countcorrect2 <- function(data, .input = NULL, .extra = NULL) {
  .input <- list(name_nc = "ncorrect", name_ne = "nerror", name_acc = "acc") |>
    update_settings(.input)
  if (!all(has_name(data, .input[c("name_nc", "name_ne")]))) {
    data <- summarise(
      data,
      "{.input$name_nc}" := sum(.data[[.input$name_acc]] == 1),
      "{.input$name_ne}" := sum(.data[[.input$name_acc]] == 0)
    )
  }
  summarise(
    data,
    nc_cor = sum(
      .data[[.input$name_nc]] - .data[[.input$name_ne]]
    )
  )
}

#' @rdname counts
#' @export
sumweighted <- function(data, .input = NULL, .extra = NULL) {
  .input <- list(name_weight = "nstim", name_acc = "acc") |>
    update_settings(.input)
  summarise(
    data,
    nc_weighted = sum(
      .data[[.input$name_weight]] *
        (.data[[.input$name_acc]] == 1)
    )
  )
}

#' @rdname counts
#' @export
sumscore <- function(data, .input = NULL, .extra = NULL) {
  .input <- list(name_score = "score") |>
    update_settings(.input)
  summarise(
    data,
    nc_score = sum(as.numeric(.data[[.input$name_score]]))
  )
}
