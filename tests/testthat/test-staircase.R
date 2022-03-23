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
test_that("Can deal with grouping", {
  data <- withr::with_seed(
    1,
    expand_grid(block = 1:3, trial = 1:20) |>
      mutate(
        acc = sample(c(0, 1), n(), replace = TRUE, prob = c(0.2, 0.8)),
        level = .prepare_steps(acc, 150, 5, min = 5)
      )
  )
  expect_snapshot_value(
    staircase(data),
    style = "json2"
  )
})
