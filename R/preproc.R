#' Wrangle Raw Data
#'
#' Parse raw json string data as [data.frame()] and store them in a list column.
#'
#' @param data The raw data.
#' @param col_raw_json The column name in which stores user's raw data in format
#'   of json string.
#' @param col_game_id The column name in which stores game id. Used in
#'   [data.iquizoo::check_data_names()] to check if the data names are valid.
#' @param name_raw_parsed The name used to store parsed data.
#' @return A [data.frame] contains the parsed data.
#' @export
wrangle_data <- function(data,
                         col_raw_json = "game_data",
                         col_game_id = "game_id",
                         name_raw_parsed = "raw_parsed") {
  data |>
    mutate(
      "{name_raw_parsed}" := purrr::map(
        .data[[col_raw_json]],
        parse_raw_json
      ),
      .keep = "unused"
    ) |>
    filter(
      purrr::map2_lgl(
        .data[[col_game_id]],
        .data[[name_raw_parsed]],
        data.iquizoo::check_data_names
      )
    )
}

#' Feed Raw Data to Pre-processing
#'
#' Calculate indices using data typically returned by [wrangle_data()].
#'
#' @details
#'
#' Observations with empty raw data (empty vector, e.g. `NULL`, in
#' `col_raw_parsed` column) are removed before calculating indices. If no
#' observations left after removing, a warning is signaled and `NULL` is
#' returned.
#'
#' @param data A [data.frame] contains raw data.
#' @param fn This can be a function or formula. See [rlang::as_function()] for
#'   more details.
#' @param ... Additional arguments passed to `fn`.
#' @param col_raw_parsed The column name in which stores user's raw data in
#'   format of a list of [data.frame]s.
#' @param pivot_results Whether to pivot the calculated indices. If `TRUE`, the
#'   calculated indices are pivoted into long format, with each index name
#'   stored in the column of `pivot_names_to`, and each index value stored in
#'   the column of `pivot_values_to`. If `FALSE`, the calculated indices are
#'   stored in the same format as returned by `fn`.
#' @param pivot_names_to,pivot_values_to The column names used to store index
#'   names and values if `pivot_results` is `TRUE`. See [tidyr::pivot_longer()]
#'   for more details.
#' @return A [data.frame] contains the calculated indices.
#' @export
preproc_data <- function(data, fn, ...,
                         col_raw_parsed = "raw_parsed",
                         pivot_results = TRUE,
                         pivot_names_to = "index_name",
                         pivot_values_to = "score") {
  data <- filter(data, !purrr::map_lgl(.data[[col_raw_parsed]], is_empty))
  if (nrow(data) == 0) {
    warn("No non-empty valid data found.")
    return()
  }
  fn <- as_function(fn)
  results <- calc_indices(data, fn, ..., col_raw_parsed = "raw_parsed")
  if (pivot_results) {
    results <- results |>
      pivot_longer(
        cols = !any_of(names(data)),
        names_to = pivot_names_to,
        values_to = pivot_values_to
      ) |>
      vctrs::vec_restore(data)
  }
  results
}

# helper functions
parse_raw_json <- function(jstr) {
  parsed <- tryCatch(
    jsonlite::fromJSON(jstr),
    error = function(cnd) {
      warn(
        c(
          "Failed to parse json string:",
          conditionMessage(cnd),
          i = "Will parse it as `NULL` instead."
        )
      )
      return()
    }
  )
  if (is_empty(parsed)) {
    return()
  }
  # try converting column names and values to lowercase
  tryCatch(
    parsed |>
      rename_with(tolower),
    error = function(cnd) {
      warn(
        c(
          "Failed to convert column names to lowercase:",
          conditionMessage(cnd),
          i = "Will use the original data instead."
        )
      )
      parsed
    }
  ) |>
    mutate(across(where(is.character), tolower))
}

calc_indices <- function(data, fn, ..., col_raw_parsed = "raw_parsed") {
  # used as a temporary id for each element
  col_id <- ".id"
  data[[col_id]] <- seq_len(nrow(data))
  data_for_indices <- select(data, all_of(c(col_id, col_raw_parsed)))
  indices <- tryCatch(
    unnest(data_for_indices, all_of(col_raw_parsed)),
    error = function(cnd) {
      warn(
        c(
          "Failed to unnest raw data:",
          conditionMessage(cnd),
          i = "Will try using tidytable package."
        )
      )
      check_installed(
        "tidytable",
        "because tidyr package fails to unnest raw data."
      )
      tidytable::unnest(data_for_indices, all_of(col_raw_parsed)) |>
        utils::type.convert(as.is = TRUE)
    }
  ) |>
    fn(.by = col_id, ...)
  data |>
    left_join(indices, by = col_id) |>
    select(!all_of(c(col_id, col_raw_parsed)))
}
