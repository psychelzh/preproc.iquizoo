set.seed(1)
n_subject <- 100
data <- tibble::tibble(
  id = seq_len(n_subject),
  n = sample(40:80, n_subject, replace = TRUE)
) %>%
  tidyr::uncount(n, .id = "Trial") %>%
  dplyr::mutate(
    rt = rexp(dplyr::n(), 0.001)
  )

test_that("Default behavior works", {
  expect_snapshot(preproc_data(data, srt, by = "id"))
})

test_that("Works with multiple grouping variables", {
  data <- dplyr::mutate(data, id1 = id + 1)
  expect_snapshot(preproc_data(data, srt, by = c("id", "id1")))
})
