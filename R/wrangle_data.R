#' Wrangle Raw Data
#'
#' Data wrangling is the first step for data analysis.
#'
#' @param data The raw data.
#' @param name_data The column name in the `data` that stores original data. It
#'   is typically of a vector containing `JSON` string.
#' @param name_user The column name in the `data` that stores the identifier of
#'   users.
#' @param name_key The key name used to match meta data. Should be a scalar
#'   character. Default is `".id"`, which is appropriate for most cases.
#' @return A [tibble][tibble::tibble-package] with two pieces of meta data:
#'   `info` and `name_key`. They stores other metadata from input raw data other
#'   than game data from `name_datas`.
#' @export
wrangle_data <- function(data,
                         name_data = "game_data",
                         name_user = "user_id",
                         name_key = ".id") {
  #' @details
  #'
  #' These steps are performed in order:
  #'
  #' 1. Data clean. Remove observations with invalid or empty (i.e., `"[]"` or
  #' `"{}"`) json string data and then remove duplicates from data. If this step
  #' produces data with no observation, following steps are skipped and `NULL`
  #' is returned.
  data_valid <- data |>
    filter(
      purrr::map_lgl(.data[[name_data]], jsonlite::validate),
      !stringr::str_detect(.data[[name_data]], r"(^\s*(\[\s*\]|\{\s*\})\s*$)")
    ) |>
    group_by(.data[[name_user]], .data[[name_data]]) |>
    filter(row_number() == 1) |>
    ungroup() |>
    mutate("{name_key}" := seq_len(n()), .before = 1)
  if (nrow(data_valid) == 0) {
    return()
  }
  #' 1. Data parse. Parse data stored in json string, convert the names to lower
  #' case and stack the parsed data. Stacking have better performances than
  #' [group_nest][group_nest()]ing.
  meta <- select(data_valid, -.data[[name_data]])
  data_parsed <- data_valid |>
    select(.data[[name_key]], .data[[name_data]]) |>
    mutate(
      "{name_data}" := purrr::map(
        .data[[name_data]],
        ~ jsonlite::fromJSON(.x) |>
          rename_with(tolower)
      )
    ) |>
    unnest(.data[[name_data]])
  structure(
    data_parsed,
    class = c("tbl_meta", class(data_parsed)),
    meta = meta,
    name_key = name_key
  )
}

#' @export
print.tbl_meta <- function(x, ...) {
  NextMethod()
  cat("* Name of key: '", attr(x, "name_key"), "'\n", sep = "")
  meta <- attr(x, "meta")
  cat("* Meta of", nrow(meta), "obs and", ncol(meta), "vars")
  invisible(x)
}
