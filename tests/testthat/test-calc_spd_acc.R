data <- withr::with_seed(
  1,
  data.frame(
    acc = rep(c(0, 1), each = 10),
    rt = c(runif(18), c(10, 10))
  )
)
test_that("`rt_rm_out` works as expected", {
  calc_spd_acc(
    data,
    name_acc = "acc",
    name_rt = "rt",
    rt_rm_out = FALSE,
    rt_unit = "s"
  ) |>
    expect_snapshot_value(style = "json2", tolerance = 1e-5)
})

test_that("No error when acc is perfect", {
  data |>
    filter(acc == 0) |>
    calc_spd_acc(name_acc = "acc", name_rt = "rt", rt_unit = "s") |>
    expect_snapshot_value(style = "json2", tolerance = 1e-5)
  data |>
    filter(acc == 1) |>
    calc_spd_acc(name_acc = "acc", name_rt = "rt", rt_unit = "s") |>
    expect_snapshot_value(style = "json2", tolerance = 1e-5)
})
