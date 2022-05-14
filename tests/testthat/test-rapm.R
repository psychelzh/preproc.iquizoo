data <- withr::with_seed(
  1,
  expand_grid(
    id = 1:2,
    tibble(
      block = 1:2,
      n = c(12, 36)
    )
  ) |>
    uncount(n, .id = "trial") |>
    mutate(
      acc = sample(
        c(-1, 0, 1), n(),
        replace = TRUE,
        prob = c(0.05, 0.15, 0.8)
      )
    )
)

test_that("Default behavior works", {
  expect_snapshot_value(
    rapm(filter(data, id == 1)),
    style = "json2"
  )
})

test_that("Works with grouping variable", {
  expect_snapshot_value(
    rapm(data, .by = "id"),
    style = "json2"
  )
})
