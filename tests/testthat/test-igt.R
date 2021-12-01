set.seed(1)
n_users <- 5
data <- tibble::tibble(id = seq_len(n_users)) |>
  mutate(n = sample(50:100, n(), replace = TRUE)) |>
  uncount(n) |>
  mutate(
    poolid = sample(letters[1:4], n(), replace = TRUE),
    outcome = sample(c(0, 200, 400, 2000, 4000), n(), replace = TRUE)
  )

test_that("Default behavior works", {
  expect_snapshot_value(
    igt(data),
    style = "json2"
  )
})

test_that("Works with grouping variables", {
  expect_snapshot_value(
    igt(data, .by = "id"),
    style = "json2"
  )
})
