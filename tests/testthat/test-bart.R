# prepare data
set.seed(1)
data <- tibble::tibble(
  id = rep(1:1000, each = 100),
  nhit = rpois(100 * 1000, 2),
  feedback = round(runif(100 * 1000))
)

test_that("Default behavior works", {
  expect_snapshot(preproc(data, bart, by = "id"))
})

test_that("Works with multiple grouping variables", {
  data <- mutate(data, id1 = id + 1)
  expect_snapshot(preproc(data, bart, by = c("id", "id1")))
})
