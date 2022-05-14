data <- withr::with_seed(
  1,
  expand_grid(
    id = 1:2,
    block = 1:4,
    trial = 1:30
  ) |>
    mutate(
      task = sample(c("t1", "t2"), n(), replace = TRUE),
      acc = sample(c(0, 1), n(), replace = TRUE),
      rt = rexp(n(), 0.001)
    ) |>
    mutate(
      type = case_when(
        trial == 1 ~ "filler",
        task == lag(task) ~ "repeat",
        TRUE ~ "switch"
      )
    )
)

test_that("Default behavior works", {
  expect_snapshot_value(
    switchcost(filter(data, id == 1)),
    style = "json2",
    tolerance = 1e-5
  )
})

test_that("Works with grouping variable", {
  expect_snapshot_value(
    switchcost(data, .by = "id"),
    style = "json2",
    tolerance = 1e-5
  )
})

test_that("Works when condition missing", {
  data_miss_switch <- withr::with_seed(
    1,
    tibble(type = rep("repeat", 80)) |>
      mutate(
        task = rep(c("t1", "t2"), n() / 2),
        acc = sample(c(0, 1), n(), replace = TRUE),
        rt = rexp(n(), 0.001)
      )
  )
  expect_snapshot_value(
    switchcost(data_miss_switch),
    style = "json2",
    tolerance = 1e-3
  )
})
