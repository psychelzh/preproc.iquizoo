set.seed(1)
n_users <- 5
data <- expand_grid(
  id = seq_len(n_users),
  tibble::tibble(
    nstim = 2:4,
    n = 10
  )
) |>
  uncount(n) |>
  mutate(
    acc = sample(-1:1, n(), replace = TRUE)
  )

test_that("Default behavior works", {
  expect_snapshot_value(
    sumweighted(data, .by = "id"),
    style = "json2"
  )
})

test_that("Works with multiple grouping variables", {
  data <- mutate(data, id1 = id + 1)
  expect_snapshot_value(
    sumweighted(data, .by = c("id", "id1")),
    style = "json2"
  )
})
