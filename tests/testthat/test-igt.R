set.seed(1)
data <- tibble(
  id = seq_len(100)
) %>%
  dplyr::mutate(n = sample(50:100, dplyr::n(), replace = TRUE)) %>%
  tidyr::uncount(n) %>%
  dplyr::mutate(
    poolid = sample(LETTERS[1:4], dplyr::n(), replace = TRUE),
    outcome = sample(c(0, 200, 400, 2000, 4000), dplyr::n(), replace = TRUE)
  )

test_that("Default behavior works", {
  expect_snapshot(preproc_data(data, igt, by = "id"))
})

test_that("Works with multiple grouping variables", {
  data <- dplyr::mutate(data, id1 = id + 1)
  expect_snapshot(preproc_data(data, igt, by = c("id", "id1")))
})
