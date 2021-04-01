set.seed(1)
n_subject <- 100
data_cancellation <- tibble(
  id = seq_len(n_subject),
  n = sample(100:300, n_subject, replace = TRUE)
) %>%
  tidyr::uncount(n, .id = "Trial") %>%
  dplyr::mutate(ACC = sample(c(0, 1), dplyr::n(), replace = TRUE))
data_canteen <- tidyr::expand_grid(
  id = seq_len(n_subject),
  Block = 1:6
) %>%
  dplyr::mutate(n = sample(2*(1:12), dplyr::n(), replace = TRUE)) %>%
  tidyr::uncount(n, .id = "Trial") %>%
  dplyr::mutate(
    Correctness = ifelse(
      Trial %% 2 == 0, NA,
      replicate(
        dplyr::n(),
        stringr::str_c(sample(c(0, 1, 99), 3, replace = TRUE), collapse = "-")
      )
    )
  )
data_fpt <- tibble(
  id = seq_len(n_subject),
  n = sample(50:100, n_subject, replace = TRUE)
) %>%
  tidyr::uncount(n, .id = "Trial") %>%
  dplyr::mutate(Repetition = sample(c(0, 1), dplyr::n(), replace = TRUE))

test_that("Default behavior works on different types of input", {
  expect_snapshot(preproc_data(data_cancellation, countcorrect))
  # character input of correctness
  expect_snapshot(preproc_data(data_canteen, countcorrect))
  expect_snapshot(preproc_data(data_fpt, countcorrect))
})
test_that("Works with multiple grouping variables", {
  data_cancellation <- dplyr::mutate(data_cancellation, id1 = id + 1)
  expect_snapshot(
    preproc_data(data_cancellation, countcorrect, by = c("id", "id1"))
  )
})
