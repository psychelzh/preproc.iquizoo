test_that("Default behavior works", {
  data <- withr::with_seed(
    1,
    expand_grid(minmove = 4:7, n = 4) |>
      uncount(n) |>
      mutate(
        stepsused = minmove + rbinom(n(), minmove, 0.1),
        finished = sample(c(0, 1), n(), replace = TRUE),
        timeinit = rexp(n(), 0.0001)
      )
  )
  expect_snapshot_value(
    london(data),
    style = "json2"
  )
})
