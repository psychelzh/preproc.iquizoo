set.seed(1)
n_users <- 5
data <- expand_grid(
  id = 1:n_users,
  block = 1:8
) |>
  mutate(n = sample(0:50, n(), replace = TRUE)) |>
  uncount(n, .id = "trial") |>
  mutate(
    task = case_when(
      block %in% c(1, 8) ~ "t1",
      block %in% c(2, 7) ~ "t2",
      TRUE ~ sample(c("t1", "t2"), n(), replace = TRUE)
    ),
    acc = sample(c(0, 1), n(), replace = TRUE),
    rt = rexp(n(), 0.001)
  ) |>
  complete(
    block, nesting(id),
    fill = list(
      trial = 1,
      task = "t1",
      acc = -1,
      rt = 0
    )
  ) |>
  mutate(
    type = case_when(
      block %in% c(1:2, 7:8) ~ "pure",
      trial == 1 ~ "filler",
      task == lag(task) ~ "repeat",
      TRUE ~ "switch"
    )
  )
data_miss_cond <- tibble::tibble(
  id = rep(1:2, each = 100),
  type = rep(c(rep("pure", 20), rep("repeat", 80)), 2)
) |>
  mutate(
    task = rep(c("T1", "T2"), n() / 2),
    acc = sample(c(0, 1), n(), replace = TRUE),
    rt = rexp(n(), 0.001)
  )
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
  expect_snapshot_value(
    switchcost(data, .by = "id"),
    style = "json2",
    tolerance = 1e-5
  )
})

test_that("All single condition", {
  expect_snapshot_value(
    switchcost(data_miss_cond, .by = "id"),
    style = "json2",
    tolerance = 1e-5
  )
})

test_that("Works with grouping variables", {
  expect_snapshot_value(
    switchcost(data, .by = "id"),
    style = "json2",
    tolerance = 1e-5
  )
})

test_that("Part subject single condition", {
  expect_snapshot_value(
    switchcost(data_part_miss_cond, .by = "id"),
    style = "json2",
    tolerance = 1e-5
  )
})

test_that("Can deal with data without 'pure' blocks", {
  data_no_pure <- expand_grid(block = 1:2, type = c("repeat", "switch")) |>
    mutate(n = 10) |>
    uncount(n) |>
    mutate(
      acc = sample(c(0, 1), n(), replace = TRUE),
      rt = rexp(n(), 0.001)
    )
  expect_snapshot_value(
    switchcost(data_no_pure),
    style = "json2",
    tolerance = 1e-5
  )
})
