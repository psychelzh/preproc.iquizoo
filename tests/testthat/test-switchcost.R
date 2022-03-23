

data_part_miss_cond <- tibble::tibble(
  id = rep(1:2, each = 100),
  type = c(
    c(rep("pure", 20), rep("repeat", 80)),
    c(rep("pure", 20), rep("repeat", 40), rep("switch", 40))
  )
) |>
  mutate(
    task = rep(c("T1", "T2"), n() / 2),
    acc = sample(c(0, 1), n(), replace = TRUE),
    rt = rexp(n(), 0.001)
  )

test_that("Default behavior works", {
  data <- withr::with_seed(
    1,
    expand_grid(
      block = 1:8,
      trial = 1:30
    ) |>
      mutate(
        task = case_when(
          block %in% c(1, 8) ~ "t1",
          block %in% c(2, 7) ~ "t2",
          TRUE ~ sample(c("t1", "t2"), n(), replace = TRUE)
        ),
        acc = sample(c(0, 1), n(), replace = TRUE),
        rt = rexp(n(), 0.001)
      ) |>
      mutate(
        type = case_when(
          block %in% c(1:2, 7:8) ~ "pure",
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
    tibble(type = c(rep("pure", 20), rep("repeat", 80))) |>
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
  data_no_pure <- withr::with_seed(
    1,
    expand_grid(block = 1:2, type = c("repeat", "switch")) |>
      mutate(n = 10) |>
      uncount(n) |>
      mutate(
        acc = sample(c(0, 1), n(), replace = TRUE),
        rt = rexp(n(), 0.001)
      )
  )
  expect_snapshot_value(
    switchcost(data_no_pure),
    style = "json2",
    tolerance = 1e-5
  )
})
