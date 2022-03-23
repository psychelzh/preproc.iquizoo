test_that("Default behavior", {
  data <- withr::with_seed(
    1,
    tibble(trial = 1:20) |>
      mutate(acc = sample(0:1, n(), replace = TRUE))
  )
  expect_snapshot_value(
    countcorrect2(data),
    style = "json2"
  )
})

test_that("Works with pre-calculated ncorrect and nerror input", {
  data <- tibble(ncorrect = 20, nerror = 2)
  expect_snapshot_value(
    countcorrect2(data),
    style = "json2"
  )
})
