test_that("Default behavior works", {
  data <- withr::with_seed(
    1,
    expand_grid(trial = 1:20) |>
      mutate(
        type = sample(
          c("nontarget", "target"),
          n(),
          replace = TRUE
        ),
        acc = sample(c(0, 1), n(), replace = TRUE, prob = c(0.1, 0.9)),
        rt = rexp(n(), 0.001)
      )
  )
  expect_snapshot_value(
    cpt(data),
    style = "json2",
    tolerance = 1e-5
  )
})

test_that("Works with grouping variable", {
  data <- withr::with_seed(
    1,
    expand_grid(
      id = 1:2,
      trial = 1:20
    ) |>
      mutate(
        type = sample(
          c("nontarget", "target"),
          n(),
          replace = TRUE
        ),
        acc = sample(c(0, 1), n(), replace = TRUE, prob = c(0.1, 0.9)),
        rt = rexp(n(), 0.001)
      )
  )
  expect_snapshot_value(
    cpt(data, .by = "id"),
    style = "json2",
    tolerance = 1e-5
  )
})
