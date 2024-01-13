test_that("Works without grouping variables", {
  withr::local_seed(1)
  data <- expand_grid(
    numtarget = c(3, 5, 7, 9),
    cresp = c("change", "stay"),
    trial = 1:10
  ) |>
    mutate(acc = sample(c(0, 1), n(), replace = TRUE))
  capacity(data) |>
    expect_snapshot_value(style = "json2")
})

test_that("Return nan values when false alarm is 1", {
  data <- expand_grid(
    numtarget = c(3, 5, 7, 9),
    cresp = c("change", "stay"),
    trial = 1:10
  ) |>
    mutate(acc = c(rep(0, 20), rep(1, n() - 20)))
  capacity(data) |>
    purrr::pluck("k") |>
    is.nan() |>
    expect_true()
})

test_that("Works with grouping variables", {
  withr::local_seed(1)
  data <- expand_grid(
    id = 1:2,
    numtarget = c(3, 5, 7, 9),
    cresp = c("change", "stay"),
    trial = 1:10
  ) |>
    mutate(acc = sample(c(0, 1), n(), replace = TRUE))
  capacity(data, .by = "id") |>
    expect_snapshot_value(style = "json2")
})
