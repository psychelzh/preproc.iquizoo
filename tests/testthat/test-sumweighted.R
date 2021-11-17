set.seed(1)
data <- expand_grid(
  id = seq_len(100),
  tibble::tibble(
    nstim = 2:4,
    n = 10
  )
) |>
  uncount(n) |>
  mutate(
    acc = sample(-1:1, n(), replace = TRUE)
  )

test_that("Default behavior works", {
  expect_snapshot(preproc_data(data, sumweighted, by = "id"))
})

test_that("Works with multiple grouping variables", {
  data <- mutate(data, id1 = id + 1)
  expect_snapshot(preproc_data(data, sumweighted, by = c("id", "id1")))
})
