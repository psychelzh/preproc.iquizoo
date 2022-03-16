data <- withr::with_seed(
  1,
  expand_grid(
    id = 1:5,
    tibble(
      phase = rep(c("learn", "test"), each = 20),
      cresp = rep(letters[1:2], 20)
    )
  ) |>
    mutate(acc = sample(c(0, 1), n(), replace = TRUE))
)
test_that("Can deal with grouping", {
  expect_snapshot_value(
    reinf(filter(data, id == 1)),
    style = "json2"
  )
  expect_snapshot_value(
    reinf(data, .by = "id"),
    style = "json2"
  )
})
