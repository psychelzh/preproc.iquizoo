.prepare_steps <- function(acc, init, step, max = Inf, min = -Inf, trans = 3) {
  out <- numeric(length(acc))
  for (i in seq_along(acc)) {
    if (i == 1) {
      out[[i]] <- init
    } else {
      if (acc[[i - 1]] == 0) {
        next_out <- out[[i - 1]] + step
        out[[i]] <- if_else(next_out <= max, next_out, out[[i - 1]])
      } else {
        if (i >= 4 &&
            (acc[[i - 2]] == 1 && out[[i - 2]] == out[[i - 1]]) &&
            (acc[[i - 3]] == 1 && out[[i - 3]] == out[[i - 1]])) {
          next_out <- out[[i - 1]] - step
          out[[i]] <- if_else(next_out >= min, next_out, out[[i - 1]])
        } else {
          out[[i]] <- out[[i - 1]]
        }
      }
    }
  }
  out
}
data <- withr::with_seed(
  1,
  expand_grid(
    id = seq_len(5),
    tibble(block = seq_len(3), n_trials = 20)
  ) |>
    uncount(n_trials) |>
    mutate(
      acc = sample(c(0, 1), n(), replace = TRUE, prob = c(0.2, 0.8)),
      xtime = .prepare_steps(acc, 150, 5, min = 5)
    )
)
test_that("Can deal with grouping", {
  expect_snapshot_value(
    staircase(filter(data, id == 1)),
    style = "json2"
  )
  expect_snapshot_value(
    staircase(data, .by = "id"),
    style = "json2"
  )
})

test_that("Can deal with custom input variables", {
  expect_snapshot_value(
    staircase(filter(data, id == 1)),
    style = "json2"
  )
  expect_snapshot_value(
    staircase(
      rename(data, level = xtime), .by = "id",
      .input = list(name_level = "level")
    ),
    style = "json2"
  )
})
