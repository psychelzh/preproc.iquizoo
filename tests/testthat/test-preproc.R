test_that("Basic situation for `wrangle_data()`", {
  js_str <- r"([{"a": 1, "b": 2}])"
  data <- tibble::tibble(game_data = js_str)
  wrangle_data(data) |>
    expect_named("raw_parsed") |>
    purrr::pluck("raw_parsed", 1) |>
    expect_identical(jsonlite::fromJSON(js_str))
  wrangle_data(data, name_raw_parsed = "parsed") |>
    expect_named("parsed")
})

test_that("Can deal with invalid or empty json", {
  data_case_invalid <- data.frame(game_data = "[1")
  wrangle_data(data_case_invalid) |>
    purrr::pluck("raw_parsed", 1) |>
    expect_null() |>
    expect_warning("Failed to parse json string")
  data_case_empty <- data.frame(game_data = c("[]", "{}"))
  wrangle_data(data_case_empty) |>
    purrr::pluck("raw_parsed") |>
    purrr::walk(expect_null)
})

test_that("Change names and values to lowercase", {
  js_str <- r"([{"A": "A"}, {"A": "B"}])"
  data <- tibble::tibble(game_data = js_str)
  wrangle_data(data) |>
    purrr::pluck("raw_parsed", 1) |>
    expect_identical(data.frame(a = c("a", "b"))) |>
    expect_silent()
})

test_that("Warn when names duplicate after converting", {
  js_str <- r"([{"A": "A", "a": "B"}])"
  data <- tibble::tibble(game_data = js_str)
  wrangle_data(data) |>
    purrr::pluck("raw_parsed", 1) |>
    expect_identical(data.frame(A = "a", a = "b")) |>
    expect_warning("Failed to convert column names to lowercase:")
})

test_that("Basic situation in `preproc_data()`", {
  data <- tibble::tibble(
    user_id = 1:2,
    raw_parsed = list(
      data.frame(nhit = 1, feedback = 0),
      data.frame(nhit = 1, feedback = 1)
    )
  )
  preproc_data(data, prep_fun) |>
    expect_snapshot_value(style = "json2")
  preproc_data(data, prep_fun, pivot_results = FALSE) |>
    expect_snapshot_value(style = "json2")
})

test_that("Deal with `NULL` in parsed data", {
  tibble::tibble(raw_parsed = list(NULL)) |>
    preproc_data(prep_fun) |>
    expect_null() |>
    expect_warning("No non-empty data found.")
  tibble::tibble(
    user_id = 1:3,
    raw_parsed = list(
      data.frame(nhit = 1, feedback = 0),
      NULL,
      data.frame(nhit = 1, feedback = 1)
    )
  ) |>
    preproc_data(prep_fun) |>
    expect_snapshot_value(style = "json2")
})

test_that("Can deal with mismatch column types in raw data", {
  skip_if_not_installed("tidytable")
  data <- tibble::tibble(
    user_id = 1:3,
    raw_parsed = list(
      data.frame(nhit = 1, feedback = 0),
      data.frame(nhit = 2, feedback = 1),
      data.frame(nhit = "3", feedback = 1)
    )
  )
  preproc_data(data, prep_fun) |>
    expect_snapshot_value(style = "json2") |>
    expect_warning("Failed to unnest raw data")
})
