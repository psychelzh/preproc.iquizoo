data <- withr::with_seed(
  1,
  expand_grid(
    id = 1:2,
    tibble::tribble(
      ~big, ~small, ~n,
      2, 1, 12,
      3, 1, 12,
      4, 1, 12,
      5, 1, 12,
      6, 1, 12,
      7, 1, 12
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
    symncmp(filter(data, id == 1)),
    style = "json2"
  )
})

test_that("Works with grouping variable", {
  expect_snapshot_value(
    symncmp(data, .by = "id"),
    style = "json2"
  )
})
