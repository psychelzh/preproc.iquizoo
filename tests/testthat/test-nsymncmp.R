config <- tibble::tribble(
  ~bigsetcount, ~smallsetcount, ~pc,
  12, 6, 0.9,
  14, 7, 0.9,
  9, 6, 0.8,
  12, 8, 0.8,
  8, 6, 0.7,
  12, 9, 0.7,
  7, 6, 0.6,
  14, 12, 0.6
)

test_that("Can deal with grouping variables", {
  data <- withr::with_seed(
    1,
    config |>
      group_by(bigsetcount, smallsetcount, pc) |>
      summarise(
        tibble(
          n = 10,
          acc = c(rep(1, round(n * pc)), rep(0, round(n * (1 - pc)))),
          rt = rexp(n, 0.001)
        ),
        .groups = "drop"
      )
  )
  expect_snapshot_value(
    nsymncmp(data),
    style = "json2",
    tolerance = 1e-5
  )
})

test_that("Warning if not converged", {
  data_invalid <- withr::with_seed(
    1,
    config |>
      mutate(n = 10) |>
      uncount(n) |>
      mutate(
        acc = sample(c(0, 1), n(), replace = TRUE),
        rt = rexp(n(), 0.001)
      )
  )
  nsymncmp(data_invalid) |>
    expect_warning(class = "fit_not_converge")
})
