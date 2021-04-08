set.seed(1)
data <- tidyr::expand_grid(
  id = seq_len(100),
  tibble(
    Type = c("Image", "Sound", "Mixed"),
    n = 20
  )
) %>%
  tidyr::uncount(n, .id = "Trial") %>%
  dplyr::mutate(RT = rexp(dplyr::n(), 0.001))

test_that("Default behavior works", {
  expect_snapshot(preproc_data(data, multisense))
})

test_that("Works with multiple grouping variables", {
  data <- dplyr::mutate(data, id1 = id + 1)
  expect_snapshot(preproc_data(data, multisense, by = c("id", "id1")))
})
