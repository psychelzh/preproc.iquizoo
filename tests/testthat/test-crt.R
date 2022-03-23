test_that("Default behavior works", {
  data <- withr::with_seed(
    1,
    tibble(trial = 1:40) |>
      mutate(
        acc = sample(c(0, 1), n(), replace = TRUE),
        rt = rexp(n(), 0.001)
      )
  )
  expect_snapshot_value(
    crt(data),
    style = "json2"
  )
})
