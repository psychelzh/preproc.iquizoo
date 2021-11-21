set.seed(1)
data <- expand_grid(
  id = seq_len(100),
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
  expect_snapshot(preproc(data, symncmp, by = "id"))
})

test_that("Works with multiple grouping variables", {
  data <- mutate(data, id1 = id + 1)
  expect_snapshot(preproc(data, symncmp, by = c("id", "id1")))
})
