test_that("Default behavior works", {
  data <- withr::with_seed(
    1,
    expand_grid(
      nstim = 2:4,
      trial = 1:10
    ) |>
      mutate(acc = sample(-1:1, n(), replace = TRUE))
  )
  expect_snapshot_value(
    sumweighted(data),
    style = "json2"
  )
})
