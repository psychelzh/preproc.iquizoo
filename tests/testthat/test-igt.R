data <- withr::with_seed(
  1,
  expand_grid(
    id = 1:2,
    trial = 1:80
  ) |>
    mutate(
      poolid = sample(letters[1:4], n(), replace = TRUE),
      outcome = sample(c(0, 200, 400, 2000, 4000), n(), replace = TRUE)
    )
)

test_that("Default behavior works", {
  expect_snapshot_value(
    igt(filter(data, id == 1)),
    style = "json2",
    tolerance = 1e-5
  )
})

test_that("Works with grouping variable", {
  expect_snapshot_value(
    igt(data, .by = "id"),
    style = "json2",
    tolerance = 1e-5
  )
})
