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
data_ncorrect <- withr::with_seed(
  1,
  tibble(id = seq_len(n_subject)) |>
    mutate(ncorrect = 10, nerror = 2)
)

test_that("Works for different types of input", {
  expect_snapshot_value(
    countcorrect2(filter(data_acc, id == 1)),
    style = "json2"
  )
  expect_snapshot_value(
    countcorrect2(filter(data_ncorrect, id == 1)),
    style = "json2"
  )
})

test_that("Works with grouping variable", {
  expect_snapshot_value(
    countcorrect2(data_acc, .by = "id"),
    style = "json2"
  )
  expect_snapshot_value(
    countcorrect2(data_ncorrect, .by = "id"),
    style = "json2"
  )
})
