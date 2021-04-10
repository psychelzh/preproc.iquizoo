# prepare data
set.seed(1)
data <- tibble(
  id = rep(1:1000, each = 100),
  NHit = rpois(100 * 1000, 2),
  Feedback = round(runif(100 * 1000))
)

test_that("Default behavior works", {
  expect_snapshot(preproc_data(data, bart, by = "id"))
})

test_that("Works with multiple grouping variables", {
  data <- dplyr::mutate(data, id1 = id + 1)
  expect_snapshot(preproc_data(data, bart, by = c("id", "id1")))
})
