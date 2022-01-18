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

test_that("Works with grouping variables", {
  expect_snapshot_value(
    countcorrect(filter(data, id == 1)),
    style = "json2"
  )
  expect_snapshot_value(
    countcorrect(data, .by = "id"),
    style = "json2"
  )
})

test_that("Works for character acc input", {
  expect_snapshot_value(
    countcorrect(data_chr_acc, .by = "id"),
    style = "json2"
  )
})

test_that("Works with pre-calculated ncorrect input", {
  data_pre <- data |>
    group_by(id) |>
    summarise(ncorrect = sum(acc == 1))
  expect_identical(
    countcorrect(data, .by = "id"),
    countcorrect(data_pre, .by = "id")
  )
})
