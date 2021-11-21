set.seed(1)
data <- expand_grid(
  id = seq_len(100),
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
  expect_snapshot(preproc(data, nsymncmp, by = "id"))
})

test_that("Works with multiple grouping variables", {
  data <- mutate(data, id1 = id + 1)
  expect_snapshot(preproc(data, nsymncmp, by = c("id", "id1")))
})
