test_that("Default behavior works", {
  data <- withr::with_seed(
    1,
    tibble(
      type = c("image", "sound", "mixed"),
      n = 20
    ) |>
      uncount(n) |>
      mutate(rt = rexp(n(), 0.001))
  )
  expect_snapshot_value(
    multisense(data),
    style = "json2",
    tolerance = 1e-5
  )
})
