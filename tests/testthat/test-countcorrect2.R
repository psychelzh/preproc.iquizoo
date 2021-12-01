set.seed(1)
n_users <- 5
data <- tibble::tibble(id = seq_len(n_users)) |>
  mutate(n = sample(1:2, n(), replace = TRUE)) |>
  uncount(n) |>
  mutate(
    ncorrect = sample(0:100, n(), replace = TRUE),
    nerror = sample(0:100, n(), replace = TRUE, prob = (101:1)^3)
  )

test_that("Default behavior works", {
  expect_snapshot_value(
    countcorrect2(data),
    style = "json2"
  )
})

test_that("Works with grouping variables", {
  expect_snapshot_value(
    countcorrect2(data, .by = "id"),
    style = "json2"
  )
})
