data <- expand_grid(
  id = 1:2,
  tibble(
    trialdur = 4000,
    escortscore = rep(0.05, 10),
    type = rep(c("target", "non-target"), each = 5),
    acc = c(rep(0, 2), rep(1, 7), 0)
  )
)

test_that("Works as expected", {
  expect_snapshot_value(
    racer(filter(data, id == 1)),
    style = "json2"
  )
})

test_that("Works with grouping variable", {
  expect_snapshot_value(
    racer(data, .by = "id"),
    style = "json2"
  )
})
