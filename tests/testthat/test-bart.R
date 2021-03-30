# prepare data
set.seed(1)
data <- tibble(
  id = rep(1:1000, each = 100),
  NHit = rpois(100*1000, 2),
  Feedback = round(runif(100*1000))
)

test_that("Default behavior works", {
  expect_snapshot(preproc_data(data, bart))
})

test_that("Works with multiple grouping variables", {
  data <- tibble::add_column(data, id1 = rep(1000:1, each = 100))
  expect_snapshot(preproc_data(data, bart, by = c("id", "id1")))
})
