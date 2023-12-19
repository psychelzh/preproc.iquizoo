test_that("Basic situation for `wrangle_data()`", {
  js_str <- r"([{"a": 1, "b": 2}])"
  data <- tibble::tibble(game_id = 1, game_data = js_str)
  wrangle_data(data) |>
    expect_silent() |>
    expect_named(c("game_id", "raw_parsed")) |>
    purrr::pluck("raw_parsed", 1) |>
    expect_identical(jsonlite::fromJSON(js_str))
  wrangle_data(data, name_raw_parsed = "parsed") |>
    expect_silent() |>
    expect_named(c("game_id", "parsed"))
})

test_that("Can deal with invalid or empty json", {
  data_case_invalid <- data.frame(game_id = 1, game_data = "[1")
  wrangle_data(data_case_invalid) |>
    purrr::pluck("raw_parsed", 1) |>
    expect_null() |>
    expect_warning("Failed to parse json string")
  data_case_empty <- data.frame(game_id = 1, game_data = c("[]", "{}"))
  wrangle_data(data_case_empty) |>
    purrr::pluck("raw_parsed") |>
    purrr::walk(expect_null)
})

test_that("Change names and values to lowercase", {
  js_str <- r"([{"A": "A"}, {"A": "B"}])"
  data <- tibble::tibble(game_id = 1, game_data = js_str)
  wrangle_data(data) |>
    purrr::pluck("raw_parsed", 1) |>
    expect_identical(data.frame(a = c("a", "b"))) |>
    expect_silent()
})

test_that("Warn when names duplicate after converting", {
  js_str <- r"([{"A": "A", "a": "B"}])"
  data <- tibble::tibble(game_id = 1, game_data = js_str)
  wrangle_data(data) |>
    purrr::pluck("raw_parsed", 1) |>
    expect_identical(data.frame(A = "a", a = "b")) |>
    expect_warning("Failed to convert column names to lowercase:")
})

test_that("Correct checked data names", {
  game_id <- bit64::as.integer64(268008982646874)
  names_valid <- c("block", "trial", "rt", "device")
  names_invalid <- names_valid[3]
  dat <- list(names_valid, names_invalid) |>
    purrr::map_chr(
      ~ tibble::as_tibble_row(
        set_names(rep(0, length(.x)), .x)
      ) |>
        jsonlite::toJSON()
    ) |>
    tibble::as_tibble_col("game_data") |>
    mutate(id = seq_len(n()), game_id, .before = 1)
  expect_identical(nrow(wrangle_data(dat)), 1L)
})
