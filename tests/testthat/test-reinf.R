test_that("Default behavior", {
  data <- withr::with_seed(
    1,
    tibble(
      phase = rep(c("learn", "test"), each = 20),
      cresp = rep(letters[1:2], 20)
    ) |>
      mutate(acc = sample(c(0, 1), n(), replace = TRUE))
  )
  expect_snapshot_value(
    reinf(data),
    style = "json2"
  )
})
