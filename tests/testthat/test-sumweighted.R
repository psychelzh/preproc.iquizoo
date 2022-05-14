n_subject <- 2
data <- withr::with_seed(
  1,
  expand_grid(
    id = seq_len(n_subject),
    nstim = 2:4,
    trial = 1:10
  ) |>
    mutate(acc = sample(c(0, 1), n(), replace = TRUE, prob = c(0.1, 0.9)))
)

test_that("Works as expect", {
  expect_snapshot_value(
    sumweighted(filter(data, id == 1)),
    style = "json2"
  )
})

test_that("Works with grouping variable", {
  expect_snapshot_value(
    sumweighted(data, .by = "id"),
    style = "json2"
  )
})
