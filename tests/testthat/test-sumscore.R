n_subject <- 2
data <- withr::with_seed(
  1,
  expand_grid(
    id = seq_len(n_subject),
    trial = 1:10
  ) |>
    mutate(score = sample(1:5, n(), replace = TRUE))
)

test_that("Default behavior works", {
  expect_snapshot_value(
    sumscore(filter(data, id == 1)),
    style = "json2"
  )
})

test_that("Works with grouping variable", {
  expect_snapshot_value(
    sumscore(data, .by = "id"),
    style = "json2"
  )
})
