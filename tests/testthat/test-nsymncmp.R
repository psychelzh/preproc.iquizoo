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
data <- withr::with_seed(
  1,
  expand_grid(
    id = 1:2,
    config
  ) |>
    group_by(id, bigsetcount, smallsetcount, pc) |>
    summarise(
      tibble(
        n = 10,
        acc = c(rep(1, round(n * pc)), rep(0, round(n * (1 - pc)))),
        rt = rexp(n, 0.001)
      ),
      .groups = "drop"
    )
)

test_that("Default behavior works", {
  expect_snapshot_value(
    nsymncmp(filter(data, id == 1)),
    style = "json2",
    tolerance = 1e-3
  )
})

test_that("Works with grouping variable", {
  expect_snapshot_value(
    nsymncmp(data, .by = "id"),
    style = "json2",
    tolerance = 1e-3
  )
})

test_that("Warning if not converged", {
  mockery::stub(
    nsymncmp,
    "fit_numerosity",
    function(...) list(par = c(w = 1), convergence = -1),
    depth = 2
  )
  nsymncmp(data) |>
    expect_warning(class = "fit_not_converge")
})
