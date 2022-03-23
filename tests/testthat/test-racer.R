test_that("Works as expected", {
  data <- data.frame(
    trialdur = 4000,
    produr = rep(200, 10),
    type = rep(c("target", "non-target"), each = 5),
    acc = c(rep(0, 2), rep(1, 7), 0)
  )
  expect_snapshot_value(racer(data), style = "json2")
})
