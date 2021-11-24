set.seed(1)
data <- expand_grid(
  id = seq_len(100),
  n = 20
) |>
  uncount(n) |>
  mutate(
    number = sample(1:99, n(), replace = TRUE),
    resp = sample(1:99, n(), replace = TRUE)
  )

test_that("Default behavior works", {
  expect_snapshot(preproc(data, nle, .by = "id"))
})

test_that("Works with multiple grouping variables", {
  data <- mutate(data, id1 = id + 1)
  expect_snapshot(preproc(data, nle, .by = c("id", "id1")))
})
