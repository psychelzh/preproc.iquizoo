set.seed(1)
data <- tidyr::expand_grid(
  id = seq_len(100),
  tibble::tribble(
    ~BigSetCount, ~SmallSetCount, ~n,
    12, 6, 10,
    14, 7, 10,
    9, 6, 10,
    12, 8, 10,
    8, 6, 10,
    12, 9, 10,
    7, 6, 10,
    14, 12, 10
  )
) %>%
  tidyr::uncount(n) %>%
  dplyr::mutate(
    ACC = sample(c(0, 1), dplyr::n(), replace = TRUE),
    RT = rexp(dplyr::n(), 0.001)
  )

test_that("Default behavior works", {
  expect_snapshot(preproc_data(data, nsymncmp))
})

test_that("Works with multiple grouping variables", {
  data <- dplyr::mutate(data, id1 = id + 1)
  expect_snapshot(preproc_data(data, nsymncmp, by = c("id", "id1")))
})

