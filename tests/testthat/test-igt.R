test_that("Default behavior works", {
  data <- withr::with_seed(
    1,
    tibble(trial = 1:80) |>
      mutate(
        poolid = sample(letters[1:4], n(), replace = TRUE),
        outcome = sample(c(0, 200, 400, 2000, 4000), n(), replace = TRUE)
      )
  )
  expect_snapshot_value(
    igt(data),
    style = "json2"
  )
})
