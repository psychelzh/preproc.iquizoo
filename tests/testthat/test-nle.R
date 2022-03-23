test_that("Default behavior works", {
  data <- withr::with_seed(
    1,
    tibble(trial = 1:20) |>
      mutate(
        number = sample(1:99, n(), replace = TRUE),
        resp = sample(1:99, n(), replace = TRUE)
      )
  )
  expect_snapshot_value(
    nle(data),
    style = "json2"
  )
})
