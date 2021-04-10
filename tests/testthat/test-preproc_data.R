data <- data.frame(NHit = 1, Feedback = 0)

test_that("Default behavior (`by = NULL`) deletes group variables afterward", {
  expect_silent(
    no_grp <- preproc_data(data, bart)
  )
  expect_named(no_grp, .get_output_vars("bart"))
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

test_that("Error when input unused argument", {
  expect_error(
    preproc_data(a = 1),
    "not empty"
  )
})

test_that("Support character function name input", {
  expect_equal(
    preproc_data(data, "bart", character.only = TRUE),
    preproc_data(data, bart)
  )
})

test_that("Can deal with name conflicts", {
  bart <- function() stop("errored")
  expect_silent(preproc_data(data, bart))
  expect_equal(
    preproc_data(data, "bart", character.only = TRUE),
    preproc_data(data, bart)
  )
})
