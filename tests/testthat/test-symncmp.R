set.seed(1)
n_users <- 5
data <- expand_grid(
  id = seq_len(n_users),
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

test_that("Default behavior works", {
  expect_snapshot_value(
    symncmp(data),
    style = "json2"
  )
})

test_that("Works with grouping variables", {
  expect_snapshot_value(
    symncmp(data, .by = "id"),
    style = "json2"
  )
})
