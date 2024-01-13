data <- withr::with_seed(
  1,
  expand_grid(
    id = 1:2,
    tibble(
      type = c("allocentric", "egocentric"),
      n = 15
    )
  ) |>
    uncount(n) |>
    mutate(dist = runif(n(), 0, 200))
)

test_that("Default behavior works", {
  expect_snapshot_value(
    refframe(filter(data, id == 1)),
    style = "json2"
  )
})

test_that("Works with grouping variable", {
  expect_snapshot_value(
    refframe(data, .by = "id"),
    style = "json2"
  )
})
