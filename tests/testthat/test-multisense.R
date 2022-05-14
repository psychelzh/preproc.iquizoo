data <- withr::with_seed(
  1,
  expand_grid(
    id = 1:2,
    tibble(
      type = c("image", "sound", "mixed"),
      n = 20
    )
  ) |>
    uncount(n) |>
    mutate(rt = rexp(n(), 0.001))
)

test_that("Default behavior works", {
  expect_snapshot_value(
    multisense(filter(data, id == 1)),
    style = "json2",
    tolerance = 1e-5
  )
})

test_that("Works with grouping variable", {
  expect_snapshot_value(
    multisense(data, .by = "id"),
    style = "json2",
    tolerance = 1e-5
  )
})
