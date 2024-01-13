n_subject <- 2
data_acc <- withr::with_seed(
  1,
  tibble::tibble(
    id = seq_len(n_subject),
    n = sample(10:20, n_subject, replace = TRUE)
  ) |>
    uncount(n, .id = "trial") |>
    mutate(acc = sample(c(0, 1), n(), replace = TRUE, prob = c(0.1, 0.9)))
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
          sample(c(0, 1, 99), 3, replace = TRUE, prob = c(0.1, 0.85, 0.05)) |>
            stringr::str_c(collapse = "-")
        )
      )
    )
)
data_ncorrect <- withr::with_seed(
  1,
  tibble(id = seq_len(n_subject)) |>
    mutate(ncorrect = 10)
)

test_that("Works for different types of input", {
  expect_snapshot_value(
    countcorrect(filter(data_acc, id == 1)),
    style = "json2"
  )
  expect_snapshot_value(
    countcorrect(filter(data_chr_acc, id == 1)),
    style = "json2"
  )
  expect_snapshot_value(
    countcorrect(filter(data_ncorrect, id == 1)),
    style = "json2"
  )
})

test_that("Works with grouping variable", {
  expect_snapshot_value(
    countcorrect(data_acc, .by = "id"),
    style = "json2"
  )
  expect_snapshot_value(
    countcorrect(data_chr_acc, .by = "id"),
    style = "json2"
  )
  expect_snapshot_value(
    countcorrect(data_ncorrect, .by = "id"),
    style = "json2"
  )
})

test_that("Supports checking variable", {
  withr::local_seed(1)
  data <- tibble(
    check = rep(c("invalid", "valid"), 5),
    acc = sample(c(0, 1), 10, replace = TRUE)
  )
  countcorrect(
    data,
    .extra = list(name_check = "check", check_valid = "valid")
  ) |>
    expect_snapshot_value(style = "json2")
})

test_that("Warning if checking variable not found", {
  withr::local_seed(1)
  data <- tibble(acc = sample(c(0, 1), 10, replace = TRUE))
  countcorrect(
    data,
    .extra = list(name_check = "check", check_valid = "valid")
  ) |>
    expect_warning(class = "miss_chk_var")
})
