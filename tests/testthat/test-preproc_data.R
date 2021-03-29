data <- data.frame(NHit = 1, Feedback = 0)

test_that("Support `group = NULL` by deleting group variable afterward", {
  expect_silent(
    no_grp <- preproc_data(data, bart, by = NULL)
  )
  expect_true(!"id" %in% names(no_grp))
})

test_that("Warns and returns `NULL` when grouping varible errored", {
  expect_warning(
    be_null <- preproc_data(data, bart, by = "g"),
    "grouping variables"
  )
  expect_null(be_null)
})

test_that("Warns and returns `NULL` when inputing corrupted data", {
  expect_warning(
    be_null <- preproc_data(list(), bart),
    "required input variables"
  )
  expect_null(be_null)
})
