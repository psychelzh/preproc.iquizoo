test_that("Works as expected", {
  data <- data.frame(
    nhit = rep(10, 5),
    feedback = c(rep(1, 3), rep(0, 2))
  )
  expect_snapshot_value(bart(data), style = "json2")
})
