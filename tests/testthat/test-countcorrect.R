set.seed(1)
n_subject <- 100
data_cancellation <- tibble::tibble(
  id = seq_len(n_subject),
  n = sample(100:300, n_subject, replace = TRUE)
) |>
  uncount(n, .id = "trial") |>
  mutate(acc = sample(c(0, 1), n(), replace = TRUE))
data_canteen <- expand_grid(
  id = seq_len(n_subject),
  block = 1:6
) |>
  mutate(n = sample(2 * (1:12), n(), replace = TRUE)) |>
  uncount(n, .id = "trial") |>
  mutate(
    correctness = ifelse(
      trial %% 2 == 0, NA,
      replicate(
        n(),
        stringr::str_c(sample(c(0, 1, 99), 3, replace = TRUE), collapse = "-")
      )
    )
  )
data_fpt <- tibble::tibble(
  id = seq_len(n_subject),
  n = sample(50:100, n_subject, replace = TRUE)
) |>
  uncount(n, .id = "trial") |>
  mutate(repetition = sample(c(0, 1), n(), replace = TRUE))

test_that("Default behavior works on different types of input", {
  expect_snapshot(preproc(data_cancellation, countcorrect, .by = "id"))
  # character input of correctness
  with_options(
    expect_snapshot(preproc(data_canteen, countcorrect, .by = "id")),
    preproc.input = list(name_acc = "correctness")
  )
  with_options(
    expect_snapshot(preproc(data_fpt, countcorrect, .by = "id")),
    preproc.input = list(name_acc = "repetition")
  )
})
test_that("Works with multiple grouping variables", {
  data_cancellation <- mutate(data_cancellation, id1 = id + 1)
  expect_snapshot(
    preproc(data_cancellation, countcorrect, .by = c("id", "id1"))
  )
})
