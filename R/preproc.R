#' Calculate Performance Indices
#'
#' Accepts a data frame containing raw data and calculates performance indices
#' using a user-defined function.
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
    warn("No non-empty data found.")
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

calc_indices <- function(data, fn, ..., col_raw_parsed = "raw_parsed") {
  # used as a temporary id for each element
  col_id <- ".id"
  raw_data <- lapply(data[[col_raw_parsed]], convert_lower_case)
  indices <- tryCatch(
    purrr::list_rbind(raw_data, names_to = col_id),
    error = function(cnd) {
      warn(
        c(
          "Failed to rowwise bind raw data:",
          conditionMessage(cnd),
          i = "Will try using data.table package."
        )
      )
      check_installed(
        "data.table",
        "because purrr package fails to rowwise bind raw data."
      )
      data.table::rbindlist(raw_data, use.names = TRUE, idcol = col_id) |>
        utils::type.convert(as.is = TRUE)
    }
  ) |>
    fn(.by = col_id, ...)
  data[[col_id]] <- seq_len(nrow(data))
  out <- merge(data, indices, by = col_id, all.x = TRUE)
  out[, !names(out) %in% c(col_id, col_raw_parsed), drop = FALSE] |>
    vctrs::vec_restore(data)
}

convert_lower_case <- function(data) {
  data |>
    rename_with(tolower) |>
    mutate(across(where(is.character), tolower))
}
