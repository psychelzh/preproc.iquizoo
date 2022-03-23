test_that("Default behavior works", {
  data <- withr::with_seed(
    1,
    tibble(trial = 1:20) |>
      mutate(score = sample(1:5, n(), replace = TRUE))
  )
  expect_snapshot_value(
    sumscore(data),
    style = "json2"
  )
})
