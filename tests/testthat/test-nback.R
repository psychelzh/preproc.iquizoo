test_that("Default behavior works", {
  data <- withr::with_seed(
    1,
    tibble::tibble(
      type = c("filler", "same", "different"),
      n = c(1, 10, 10)
    ) |>
      uncount(n) |>
      mutate(
        acc = sample(c(0, 1), n(), replace = TRUE),
        rt = rexp(n(), 0.001)
      )
  )
  expect_snapshot_value(
    nback(data),
    style = "json2",
    tolerance = 1e-5
  )
})
