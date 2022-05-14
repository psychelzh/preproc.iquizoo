data <- withr::with_seed(
  1,
  expand_grid(
    id = 1:2,
    expand_grid(minmove = 4:7, n = 4)
  ) |>
    uncount(n) |>
    mutate(
      stepsused = minmove + rbinom(n(), minmove, 0.1),
      finished = sample(c(0, 1), n(), replace = TRUE),
      timeinit = rexp(n(), 0.0001)
    )
)

test_that("Default behavior works", {
  expect_snapshot_value(
    london(filter(data, id == 1)),
    style = "json2"
  )
})

test_that("Works with grouping variable", {
  expect_snapshot_value(
    london(data, .by = "id"),
    style = "json2"
  )
})
