set.seed(1)
data <- tidyr::expand_grid(
  id = seq_len(100),
  tibble(
    Type = c("None", "Change", "Stay"),
    n = c(1, 10, 10)
  )
) %>%
  tidyr::uncount(n) %>%
  dplyr::mutate(
    ACC = sample(c(0, 1), dplyr::n(), replace = TRUE),
    RT = rexp(dplyr::n(), 0.001)
  )

test_that("Default behavior works", {
  expect_snapshot(preproc_data(data, nback, by = "id"))
})

test_that("Works with multiple grouping variables", {
  data <- dplyr::mutate(data, id1 = id + 1)
  expect_snapshot(preproc_data(data, nback, by = c("id", "id1")))
})
