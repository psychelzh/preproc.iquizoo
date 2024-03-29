test_that("Correctly find all peaks and valleys", {
  lvls <- c(2:5, 4:1, 2:4)
  expect_equal(calc_staircase_wetherill(lvls), 3)
  lvls <- c(2:5, 4:1, 2:4, 3:1)
  expect_equal(calc_staircase_wetherill(lvls), 2.5)
})

test_that("Return NA if no peaks or valleys", {
  is.na(calc_staircase_wetherill(c(2:5))) |>
    expect_true() |>
    expect_warning(class = "no_reversals_found") |>
    expect_warning(class = "no_reversals_found")
})
