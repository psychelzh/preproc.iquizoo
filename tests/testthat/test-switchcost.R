test_that("Default behavior works", {
  data <- withr::with_seed(
    1,
    expand_grid(
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
  expect_snapshot_value(
    switchcost(data),
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
    tolerance = 1e-5
  )
})
