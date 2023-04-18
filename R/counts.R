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
#' @return An object with the same class as `data` contains following values:
#'   \item{nc}{Count of correct responses. For [countcorrect()].}
#'   \item{nc_cor}{Corrected count of correct responses (subtracting number of
#'     errors). For [countcorrect2()].}
#'   \item{nc_weighted}{Count of weighted correct responses. For
#'     [sumweighted()].}
#'   \item{nc_score}{Sum of scores. For [sumscore()].}
NULL

#' @rdname counts
#' @export
countcorrect <- function(data, .by = NULL, .input = NULL, .extra = NULL) {
  .input <- list(name_nc = "ncorrect", name_acc = "acc") |>
    update_settings(.input)
  .extra <- list(
    name_check = NULL,
    check_valid = NULL
  ) |>
    update_settings(.extra)
  if (!is.null(.extra$name_check) && !is.null(.extra$check_valid)) {
    if (!has_name(data, .extra$name_check)) {
      warn(
        "Cannot find the specified checking variable. Skip checking.",
        "miss_chk_var"
      )
    } else {
      data <- data |>
        filter(.data[[.extra$name_check]] %in% .extra$check_valid)
    }
  }
  if (!has_name(data, .input$name_nc)) {
    if (is.character(data[[.input$name_acc]])) {
      # character input uses "-" to separate individual responses
      data <- data |>
        mutate(
          "{.input$name_acc}" := parse_char_resp(
            .data[[.input$name_acc]],
            delim = "\\D"
          )
        ) |>
        unnest(all_of(.input$name_acc))
    }
    data <- data |>
      group_by(across(all_of(.by))) |>
      summarise(
        # `NA` might be produced in parsing characters and should be ignored
        "{.input$name_nc}" := sum(.data[[.input$name_acc]] == 1, na.rm = TRUE),
        .groups = "drop"
      )
  }
  data |>
    group_by(across(all_of(.by))) |>
    summarise(nc = sum(.data[[.input$name_nc]]), .groups = "drop") |>
    vctrs::vec_restore(data)
}

#' @rdname counts
#' @export
countcorrect2 <- function(data, .by = NULL, .input = NULL, .extra = NULL) {
  .input <- list(name_nc = "ncorrect", name_ne = "nerror", name_acc = "acc") |>
    update_settings(.input)
  if (!all(has_name(data, .input[c("name_nc", "name_ne")]))) {
    data <- data |>
      group_by(across(all_of(.by))) |>
      summarise(
        "{.input$name_nc}" := sum(.data[[.input$name_acc]] == 1),
        "{.input$name_ne}" := sum(.data[[.input$name_acc]] == 0),
        .groups = "drop"
      )
  }
  data |>
    group_by(across(all_of(.by))) |>
    summarise(
      nc_cor = sum(
        .data[[.input$name_nc]] - .data[[.input$name_ne]]
      ),
      .groups = "drop"
    ) |>
    vctrs::vec_restore(data)
}

#' @rdname counts
#' @export
sumweighted <- function(data, .by = NULL, .input = NULL, .extra = NULL) {
  .input <- list(name_weight = "nstim", name_acc = "acc") |>
    update_settings(.input)
  data |>
    group_by(across(all_of(.by))) |>
    summarise(
      nc_weighted = sum(
        .data[[.input$name_weight]] *
          (.data[[.input$name_acc]] == 1)
      ),
      .groups = "drop"
    ) |>
    vctrs::vec_restore(data)
}

#' @rdname counts
#' @export
sumscore <- function(data, .by = NULL, .input = NULL, .extra = NULL) {
  .input <- list(name_score = "score") |>
    update_settings(.input)
  data |>
    group_by(across(all_of(.by))) |>
    summarise(
      nc_score = sum(as.numeric(.data[[.input$name_score]])),
      .groups = "drop"
    ) |>
    vctrs::vec_restore(data)
}
