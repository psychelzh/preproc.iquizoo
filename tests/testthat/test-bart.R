# prepare data
set.seed(1)
data <- tibble(
  id = rep(1:1000, each = 100),
  NHit = rpois(100*1000, 2),
  Feedback = round(runif(100*1000))
)

test_that("`bart()` default", {
  expect_snapshot(preproc_data(data, bart))
})
