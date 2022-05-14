data <- tibble(
  id = rep(1:2, each = 5),
  nhit = rep(10, 10),
  feedback = rep(c(rep(1, 3), rep(0, 2)), 2)
)

test_that("Works as expected", {
  expect_snapshot_value(bart(filter(data, id == 1)), style = "json2")
})

test_that("Works with grouping variable", {
  expect_snapshot_value(bart(data, .by = "id"), style = "json2")
})
