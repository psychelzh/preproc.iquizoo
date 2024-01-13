test_that("Signal if type column is not valid", {
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
        acc = c(0, 1),
        type = c("a", "a")
      ),
      type_signal = "a"
    ),
    "No non-signal stimuli found in data"
  )
  expect_warning(
    calc_sdt(
      data.frame(
        acc = c(0, 1, 0),
        type = c("a", "b", "c")
      ),
      type_signal = "a"
    ),
    "Found more than one types of non-signal stimuli in data"
  )
})
