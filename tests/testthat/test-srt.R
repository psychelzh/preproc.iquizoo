data <- withr::with_seed(
  1,
  expand_grid(
    id = 1:2,
    trial = 1:10
  ) |>
    mutate(rt = rexp(n(), 0.001))
)

test_that("Default behavior works", {
  expect_snapshot_value(
    srt(filter(data, id == 1)),
    style = "json2"
  )
})

test_that("Works with grouping variable", {
  expect_snapshot_value(
    srt(data, .by = "id"),
    style = "json2"
  )
})
