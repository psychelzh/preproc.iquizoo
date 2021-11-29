data <- data.frame(nhit = 1, feedback = 0)

test_that("Default behavior (`.by = NULL`) deletes group variables afterward", {
  with_options({
    expect_silent(no_grp <- preproc(data, bart))
    expect_named(no_grp, "mean_pumps")
  }, preproc.output = "mean_pumps"
  )
})

test_that("Warns and returns `NULL` when grouping varible errored", {
  expect_warning(
    be_null <- preproc(data, bart, .by = "g"),
    class = "by_invalid"
  )
  expect_null(be_null)
})

test_that("Signal error for corrupted data", {
  expect_error(preproc(data.frame(), bart), "Column `\\w+` not found")
})

test_that("Error when input unused argument", {
  expect_error(preproc(a = 1), "not empty")
})

test_that("Support character function name input", {
  expect_equal(
    preproc(data, "bart", character.only = TRUE),
    preproc(data, bart)
  )
})

test_that("Can use custom function", {
  my_bart <<- function(...) {
    tibble(mean_pumps = 1, mean_pumps_raw = 1, num_explosion = 1)
  }
  expect_silent(custom <- preproc(data, my_bart))
  expect_equal(preproc(data, "my_bart", character.only = TRUE), custom)
})

test_that("Keep attributes", {
  data_attr <- structure(data, class = c("my_tbl", class(data)), test = "test")
  expect_silent(res_attr <- preproc(data_attr, bart))
  expect_equal(preproc(data, bart), res_attr, ignore_attr = TRUE)
  expect_equal(class(res_attr), class(data_attr))
  expect_equal(attr(res_attr, "test"), attr(data_attr, "test"))
})
