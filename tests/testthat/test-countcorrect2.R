set.seed(1)
data <- tibble::tibble(
  id = seq_len(100)
) |>
  mutate(n = sample(1:2, n(), replace = TRUE)) |>
  uncount(n) |>
  mutate(
    ncorrect = sample(0:100, n(), replace = TRUE),
    nerror = sample(0:100, n(), replace = TRUE, prob = (101:1)^3)
  )

test_that("Default behavior works", {
  expect_snapshot(preproc_data(data, countcorrect2, by = "id"))
})

test_that("Works with multiple grouping variables", {
  data <- mutate(data, id1 = id + 1)
  expect_snapshot(preproc_data(data, countcorrect2, by = c("id", "id1")))
})
