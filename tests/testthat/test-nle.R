set.seed(1)
data <- tidyr::expand_grid(
  id = seq_len(100),
  n = 20
) %>%
  tidyr::uncount(n) %>%
  dplyr::mutate(
    Number = sample(1:99, dplyr::n(), replace = TRUE),
    Resp = sample(1:99, dplyr::n(), replace = TRUE)
  )

test_that("Default behavior works", {
  expect_snapshot(preproc_data(data, nle))
})

test_that("Works with multiple grouping variables", {
  data <- dplyr::mutate(data, id1 = id + 1)
  expect_snapshot(preproc_data(data, nle, by = c("id", "id1")))
})
