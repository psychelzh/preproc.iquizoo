test_that("Default behavior works", {
  data <- withr::with_seed(
    1,
    tibble(trial = 1:10) |>
      mutate(
        rt = rexp(n(), 0.001)
      )
  )
  expect_snapshot_value(
    srt(data),
    style = "json2"
  )
})
