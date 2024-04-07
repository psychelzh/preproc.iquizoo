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
  skip_if_not_installed("data.table")
  data <- tibble::tibble(
    user_id = 1:3,
    raw_parsed = list(
      data.frame(nhit = 1, feedback = 0),
      data.frame(nhit = 2, feedback = 1),
      data.frame(nhit = "3", feedback = 1)
    )
  )
  expect_snapshot_value(
    result <- preproc_data(data, prep_fun),
    style = "json2"
  ) |>
    expect_warning("Failed to rowwise bind raw data")
  data <- tibble::tibble(
    user_id = 1:3,
    raw_parsed = list(
      data.frame(nhit = 1, feedback = 0),
      data.frame(feedback = 1, nhit = 2),
      data.frame(nhit = "3", feedback = 1)
    )
  )
  preproc_data(data, prep_fun) |>
    expect_identical(result) |>
    expect_warning("Failed to rowwise bind raw data")
})
