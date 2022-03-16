test_that("Correctly find all peaks and valleys", {
  lvls <- c(2:5, 4:1, 2:4)
  expect_equal(calc_staircase_wetherill(lvls), 3)
})

test_that("Return NA if no peaks or valleys", {
  lvls <- c(2:5)
  expect_true(is.na(calc_staircase_wetherill(lvls)))
})
