data <- withr::with_seed(
  1,
  expand_grid(
    id = 1:2,
    tibble(
      type = c("filler", "same", "different"),
      n = c(1, 10, 10)
    )
  ) |>
    uncount(n) |>
    mutate(
      acc = sample(c(0, 1), n(), replace = TRUE),
      rt = rexp(n(), 0.001)
    )
)

test_that("Default behavior works", {
  expect_snapshot_value(
    nback(filter(data, id == 1)),
    style = "json2",
    tolerance = 1e-5
  )
})

test_that("Works with grouping variable", {
  expect_snapshot_value(
    nback(data, .by = "id"),
    style = "json2",
    tolerance = 1e-5
  )
})
