data <- withr::with_seed(
  1,
  expand_grid(
    id = 1:2,
    trial = 1:20
  ) |>
    mutate(
      number = sample(1:99, n(), replace = TRUE),
      resp = sample(1:99, n(), replace = TRUE)
    )
)

test_that("Default behavior works", {
  expect_snapshot_value(
    nle(filter(data, id == 1)),
    style = "json2",
    tolerance = 1e-5
  )
})

test_that("Works with grouping variable", {
  expect_snapshot_value(
    nle(data, .by = "id"),
    style = "json2",
    tolerance = 1e-5
  )
})
