
test_that("Can deal with grouping", {
  data <- withr::with_seed(
    1,
    tibble(status = c("flip", "drag", as.character(0:10), "low", "high")) |>
      mutate(n = sample(seq(10, 20), n(), replace = TRUE)) |>
      uncount(n) |>
      mutate(acc = sample(c(0, 1), n(), prob = c(0.2, 0.8), replace = TRUE))
  )
  expect_snapshot_value(
    synwin(data),
    style = "json2"
  )
})
