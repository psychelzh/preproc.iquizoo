test_that("Default behavior works", {
  data <- withr::with_seed(
    1,
    tibble::tibble(
      block = 1:2,
      n = c(12, 36)
    ) |>
      uncount(n, .id = "trial") |>
      mutate(
        acc = sample(
          c(-1, 0, 1), n(),
          replace = TRUE,
          prob = c(0.05, 0.15, 0.8)
        )
      )
  )
  expect_snapshot_value(
    rapm(data),
    style = "json2"
  )
})
