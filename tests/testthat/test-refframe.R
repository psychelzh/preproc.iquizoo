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
    refframe(data),
    style = "json2"
  )
})

test_that("Works with grouping variables", {
  expect_snapshot_value(
    refframe(data, .by = "id"),
    style = "json2"
  )
})
