set.seed(1)
n_users <- 5
data <- expand_grid(
  id = seq_len(n_users),
  tibble::tibble(
    type = c("filler", "same", "different"),
    n = c(1, 10, 10)
  )
) |>
  uncount(n) |>
  mutate(
    acc = sample(c(0, 1), n(), replace = TRUE),
    rt = rexp(n(), 0.001)
  )

test_that("Default behavior works", {
  expect_snapshot_value(
    nback(data),
    style = "json2",
    tolerance = 1e-5
  )
})

test_that("Works with grouping variables", {
  expect_snapshot_value(
    nback(data, .by = "id"),
    style = "json2"
  )
})
