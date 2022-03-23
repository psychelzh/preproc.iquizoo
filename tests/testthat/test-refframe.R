test_that("Default behavior works", {
  data <- withr::with_seed(
    1,
    tibble(
      type = c("Allocentric", "Egocentric"),
      n = 15
    ) |>
      uncount(n) |>
      mutate(dist = runif(n(), 0, 200))
  )
  expect_snapshot_value(
    refframe(data),
    style = "json2"
  )
})
