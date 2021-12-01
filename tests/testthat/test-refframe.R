set.seed(1)
n_users <- 5
data <- expand_grid(
  id = seq_len(n_users),
  tibble::tibble(
    type = c("Allocentric", "Egocentric"),
    n = 15
  )
) |>
  uncount(n) |>
  mutate(dist = runif(n(), 0, 200))

test_that("Default behavior works", {
  expect_snapshot_value(
    refframe(data, .by = "id"),
    style = "json2"
  )
})

test_that("Works with multiple grouping variables", {
  data <- mutate(data, id1 = id + 1)
  expect_snapshot_value(
    refframe(data, .by = c("id", "id1")),
    style = "json2"
  )
})
