# prepare data
set.seed(1)
data <- expand_grid(
  id = 1:5,
  block = 1:8
) |>
  mutate(n = sample(0:50, n(), replace = TRUE)) |>
  uncount(n, .id = "trial") |>
  mutate(
    stimtype = sample(
      c("incongruent", "congruent"),
      n(),
      replace = TRUE
    ),
    task = case_when(
      block %in% c(1, 8) ~ "T1",
      block %in% c(2, 7) ~ "T2",
      TRUE ~ sample(c("T1", "T2"), n(), replace = TRUE)
    ),
    acc = sample(c(0, 1), n(), replace = TRUE),
    rt = rexp(n(), 0.001)
  ) |>
  complete(
    block, nesting(id),
    fill = list(
      trial = 1,
      stimtype = "congruent",
      task = "T1",
      acc = -1,
      rt = 0
    )
  ) |>
  mutate(
    tasktype = case_when(
      block %in% c(1:2, 7:8) ~ "pure",
      trial == 1 ~ "filler",
      task == lag(task) ~ "repeat",
      TRUE ~ "switch"
    )
  )
data_miss_cond <- tibble::tibble(
  id = rep(1:2, each = 8),
  block = rep(1:8, 2),
  stimtype = "incongruent",
  task = "T1",
  tasktype = rep(c(rep("pure", 2), rep("repeat", 4), rep("pure", 2)), 2),
  acc = sample(c(0, 1), 16, replace = TRUE),
  rt = rexp(16, 0.001)
)
data_part_miss_cond <- tibble::tibble(
  id = rep(1:2, each = 8),
  block = rep(1:8, 2),
  stimtype = c(
    rep("incongruent", 8),
    rep("incongruent", 4),
    rep("congruent", 4)
  ),
  task = "T1",
  tasktype = c(
    c(rep("pure", 2), rep("repeat", 4), rep("pure", 2)),
    c(rep("pure", 2), rep("repeat", 2), rep("switch", 2), rep("pure", 2))
  ),
  acc = sample(c(0, 1), 16, replace = TRUE),
  rt = rexp(16, 0.001)
)

test_that("Default behavior works", {
  expect_snapshot_value(
    complexswitch(data, .by = "id"),
    style = "json2",
    tolerance = 1e-5
  )
})

test_that("All single condition", {
  expect_snapshot_value(
    complexswitch(data_miss_cond, .by = "id"),
    style = "json2",
    tolerance = 1e-5
  )
})

test_that("Part subject single condition", {
  expect_snapshot_value(
    complexswitch(data_part_miss_cond, .by = "id"),
    style = "json2",
    tolerance = 1e-5
  )
})

test_that("Works with multiple grouping variables", {
  data <- mutate(data, id1 = id + 1)
  expect_snapshot_value(
    complexswitch(data, .by = c("id", "id1")),
    style = "json2",
    tolerance = 1e-5
  )
})
