data <- withr::with_seed(
  1,
  tibble::tibble(
    id = seq_len(5),
    n = sample(80:120, 5, replace = TRUE)
  ) |>
    uncount(n) |>
    mutate(acc = sample(0:1, n(), replace = TRUE))
)

test_that("Can deal with grouping variables", {
  expect_snapshot_value(
    countcorrect2(filter(data, id == 1)),
    style = "json2"
  )
  expect_snapshot_value(
    countcorrect2(data, .by = "id"),
    style = "json2"
  )
})

test_that("Works with pre-calculated ncorrect and nerror input", {
  data_pre <- data |>
    group_by(id) |>
    summarise(ncorrect = sum(acc == 1), nerror = sum(acc == 0))
  expect_identical(
    countcorrect2(data, .by = "id"),
    countcorrect2(data_pre, .by = "id")
  )
})
