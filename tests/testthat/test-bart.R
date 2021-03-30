# prepare data
set.seed(1)

test_that("`bart()` default", {
  data <- tibble(
    id = rep(1:1000, each = 100),
    NHit = rpois(100*1000, 2),
    Feedback = round(runif(100*1000))
  )
  expect_snapshot(preproc_data(data, bart))
})

test_that("`bart()` works with multiple grouping variables", {
  data <- tibble(
    id1 = rep(1:1000, each = 100),
    id2 = rep(1000:1, each = 100),
    NHit = rpois(100*1000, 2),
    Feedback = round(runif(100*1000))
  )
  expect_snapshot(preproc_data(data, bart, by = c("id1", "id2")))
})
