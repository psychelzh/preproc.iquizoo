set.seed(1)
data <- tidyr::expand_grid(
  id = seq_len(100),
  tibble::tribble(
    ~Big, ~Small, ~n,
    2, 1, 12,
    3, 1, 12,
    4, 1, 12,
    5, 1, 12,
    6, 1, 12,
    7, 1, 12
  )
) %>%
  tidyr::uncount(n) %>%
  dplyr::mutate(
    ACC = sample(c(0, 1), dplyr::n(), replace = TRUE),
    RT = rexp(dplyr::n(), 0.001)
  )

test_that("Default behavior works", {
  expect_snapshot(preproc_data(data, symncmp, by = "id"))
})

test_that("Works with multiple grouping variables", {
  data <- dplyr::mutate(data, id1 = id + 1)
  expect_snapshot(preproc_data(data, symncmp, by = c("id", "id1")))
})
