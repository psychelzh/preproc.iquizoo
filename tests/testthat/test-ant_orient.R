test_that("Works without grouping variables", {
  withr::local_seed(1)
  data <- expand_grid(
    cuetype = c("endogenous", "exogenous", "neutral"),
    stimtype = c("congruent", "incongruent"),
    n = 10
  ) |>
    uncount(n) |>
    mutate(
      rt = rexp(n(), 0.001),
      acc = sample(c(0, 1), n(), replace = TRUE)
    )
  ant_orient(data) |>
    expect_snapshot_value(style = "json2", tolerance = 1e-5)
})

test_that("Works with grouping variables", {
  withr::local_seed(1)
  data <- expand_grid(
    id = 1:2,
    expand_grid(
      cuetype = c("endogenous", "exogenous", "neutral"),
      stimtype = c("congruent", "incongruent"),
      n = 10
    ) |>
      uncount(n) |>
      mutate(
        rt = rexp(n(), 0.001),
        acc = sample(c(0, 1), n(), replace = TRUE)
      )
  )
  ant_orient(data, .by = "id") |>
    expect_snapshot_value(style = "json2", tolerance = 1e-5)
})
