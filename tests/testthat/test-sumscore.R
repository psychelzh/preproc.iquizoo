set.seed(1)
n_users <- 5
data <- tibble::tibble(id = seq_len(n_users), n = 20) |>
  uncount(n) |>
  mutate(
    score = sample(1:5, n(), replace = TRUE)
  )

test_that("Default behavior works", {
  expect_snapshot_value(
    sumscore(data, .by = "id"),
    style = "json2"
  )
})

test_that("Works with multiple grouping variables", {
  data <- mutate(data, id1 = id + 1)
  expect_snapshot_value(
    sumscore(data, .by = c("id", "id1")),
    style = "json2"
  )
})
