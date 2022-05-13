data <- withr::with_seed(
  1,
  expand_grid(
    id = 1:2,
    status = c("flip", "drag", as.character(0:10), "low", "high")
  ) |>
    mutate(n = sample(seq(10, 20), n(), replace = TRUE)) |>
    uncount(n) |>
    mutate(acc = sample(c(0, 1), n(), prob = c(0.2, 0.8), replace = TRUE))
)

test_that("Default behavior works", {
  expect_snapshot_value(
    synwin(filter(data, id == 1)),
    style = "json2"
  )
})

test_that("Works with grouping variable", {
  expect_snapshot_value(
    synwin(data, .by = "id"),
    style = "json2"
  )
})
