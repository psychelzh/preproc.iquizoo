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

test_that("`bart()` supports no group", {
  expect_snapshot(preproc_data(data, bart, by = NULL))
})

test_that("`bart()` warns and returns `NULL` when grouping varible errored", {
  expect_warning(
    be_null <- preproc_data(data, bart, by = "g"),
    "grouping variables"
  )
  expect_null(be_null)
})

test_that("`bart()` warns and returns `NULL` when inputing corrupted data", {
  expect_warning(
    be_null <- preproc_data(list(), bart),
    "required input variables"
  )
  expect_null(be_null)
})
