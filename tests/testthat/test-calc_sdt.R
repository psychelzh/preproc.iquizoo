test_that("Report error if type column is not valid", {
  expect_error(
    calc_sdt(
      data.frame(
        acc = c(0, 1),
        type = c("a", "b")
      ),
      type_signal = "target"
    ),
    "Signal type not found in data"
  )
  expect_error(
    calc_sdt(
      data.frame(
        acc = c(0, 1, 0),
        type = c("a", "b", "c")
      ),
      type_signal = "a"
    ),
    "Data should contain only two types of stimuli"
  )
})
