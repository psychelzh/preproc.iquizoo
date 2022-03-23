n_subject <- 5
data <- withr::with_seed(
  1,
  tibble::tibble(
    id = seq_len(n_subject),
    n = sample(100:300, n_subject, replace = TRUE)
  ) |>
    uncount(n, .id = "trial") |>
    mutate(acc = sample(c(0, 1), n(), replace = TRUE))
)
data_chr_acc <- withr::with_seed(
  1,
  expand_grid(
    id = seq_len(n_subject),
    block = 1:6
  ) |>
    mutate(n = sample(2 * (1:12), n(), replace = TRUE)) |>
    uncount(n, .id = "trial") |>
    mutate(
      acc = ifelse(
        trial %% 2 == 0, NA,
        replicate(
          n(),
          sample(c(0, 1, 99), 3, replace = TRUE) |>
            stringr::str_c(collapse = "-")
        )
      )
    )
)

test_that("Default behavior", {
  data <- withr::with_seed(
    1,
    tibble(trial = 1:20) |>
      mutate(acc = sample(c(0, 1), n(), replace = TRUE))
  )
  expect_snapshot_value(
    countcorrect(data),
    style = "json2"
  )
})

test_that("Works for character acc input", {
  data_chr_acc <- withr::with_seed(
    1,
    tibble(trial = 1:20) |>
      mutate(
        acc = if_else(
          trial %% 2 == 0, NA_character_,
          replicate(
            n(),
            sample(c(0, 1, 99), 3, replace = TRUE) |>
              stringr::str_c(collapse = "-")
          )
        )
      )
  )
  expect_snapshot_value(
    countcorrect(data_chr_acc),
    style = "json2"
  )
})

test_that("Works with pre-calculated ncorrect input", {
  data_pre <- withr::with_seed(
    1,
    tibble(ncorrect = 10)
  )
  expect_snapshot_value(countcorrect(data_pre), style = "json2")
})
