set.seed(1)
n_users <- 5
data <- expand_grid(
  id = seq_len(n_users),
  n = 20
) |>
  uncount(n) |>
  mutate(
    number = sample(1:99, n(), replace = TRUE),
    resp = sample(1:99, n(), replace = TRUE)
  )

test_that("Default behavior works", {
  expect_snapshot_value(
    nle(data, .by = "id"),
    style = "json2"
  )
})

test_that("Works with multiple grouping variables", {
  data <- mutate(data, id1 = id + 1)
  expect_snapshot_value(
    nle(data, c("id", "id1")),
    style = "json2"
  )
})
