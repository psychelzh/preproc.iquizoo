set.seed(1)
n_subject <- 100
data <- tibble::tibble(
  id = seq_len(n_subject),
  n = sample(40:80, n_subject, replace = TRUE)
) %>%
  tidyr::uncount(n) %>%
  dplyr::mutate(
    acc = sample(c(0, 1), dplyr::n(), replace = TRUE),
    rt = rexp(dplyr::n(), 0.001)
  )

test_that("Default behavior works", {
  expect_snapshot(preproc_data(data, crt, by = "id"))
})

test_that("Works with multiple grouping variables", {
  data <- dplyr::mutate(data, id1 = id + 1)
  expect_snapshot(preproc_data(data, crt, by = c("id", "id1")))
})
