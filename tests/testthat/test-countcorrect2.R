set.seed(1)
data <- tibble(
  id = seq_len(100)
) %>%
  dplyr::mutate(n = sample(1:2, dplyr::n(), replace = TRUE)) %>%
  tidyr::uncount(n) %>%
  dplyr::mutate(
    NCorrect = sample(0:100, dplyr::n(), replace = TRUE),
    NError =  sample(0:100, dplyr::n(), replace = TRUE, prob = (101:1)^3)
  )

test_that("Default behavior works", {
  expect_snapshot(preproc_data(data, countcorrect2))
})

test_that("Works with multiple grouping variables", {
  data <- dplyr::mutate(data, id1 = id + 1)
  expect_snapshot(preproc_data(data, countcorrect2, by = c("id", "id1")))
})
