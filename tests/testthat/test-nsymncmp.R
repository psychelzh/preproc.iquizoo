set.seed(1)
n_users <- 5
data <- expand_grid(
  id = seq_len(5),
  tibble::tribble(
    ~bigsetcount, ~smallsetcount, ~n,
    12, 6, 10,
    14, 7, 10,
    9, 6, 10,
    12, 8, 10,
    8, 6, 10,
    12, 9, 10,
    7, 6, 10,
    14, 12, 10
  )
) |>
  uncount(n) |>
  mutate(
    acc = sample(c(0, 1), n(), replace = TRUE),
    rt = rexp(n(), 0.001)
  )

test_that("Default behavior works", {
  expect_snapshot_value(
    nsymncmp(data),
    style = "json2"
  )
})

test_that("Works with grouping variables", {
  expect_snapshot_value(
    nsymncmp(data, .by = "id"),
    style = "json2"
  )
})
