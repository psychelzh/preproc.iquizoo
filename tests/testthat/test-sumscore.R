set.seed(1)
data <- tibble::tibble(
  id = seq_len(100),
  n = 20
) %>%
  uncount(n) %>%
  mutate(
    score = sample(1:5, n(), replace = TRUE)
  )

test_that("Default behavior works", {
  expect_snapshot(preproc_data(data, sumscore, by = "id"))
})

test_that("Works with multiple grouping variables", {
  data <- mutate(data, id1 = id + 1)
  expect_snapshot(preproc_data(data, sumscore, by = c("id", "id1")))
})
