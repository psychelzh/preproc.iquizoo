# prepare data
set.seed(1)
n_users <- 5
data <- tibble::tibble(
  id = rep(1:n_users, each = 100),
  nhit = rpois(100 * n_users, 2),
  feedback = round(runif(100 * n_users))
)

test_that("Default behavior works", {
  expect_snapshot_value(
    bart(data, .by = "id"),
    style = "json2"
  )
})

test_that("Works with multiple grouping variables", {
  data <- mutate(data, id1 = id + 1)
  expect_snapshot_value(
    bart(data, .by = c("id", "id1")),
    style = "json2"
  )
})
