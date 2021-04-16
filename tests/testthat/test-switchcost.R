set.seed(1)
data <- tidyr::expand_grid(
  id = 1:100,
  block = 1:8
) %>%
  dplyr::mutate(n = sample(0:50, dplyr::n(), replace = TRUE)) %>%
  tidyr::uncount(n, .id = "trial") %>%
  dplyr::mutate(
    task = dplyr::case_when(
      block %in% c(1, 8) ~ "T1",
      block %in% c(2, 7) ~ "T2",
      TRUE ~ sample(c("T1", "T2"), dplyr::n(), replace = TRUE)
    ),
    acc = sample(c(0, 1), dplyr::n(), replace = TRUE),
    rt = rexp(dplyr::n(), 0.001)
  ) %>%
  tidyr::complete(
    block, tidyr::nesting(id),
    fill = list(
      trial = 1,
      task = "T1",
      acc = -1,
      rt = 0
    )
  ) %>%
  dplyr::mutate(
    type = dplyr::case_when(
      block %in% c(1:2, 7:8) ~ "Pure",
      trial == 1 ~ "Filler",
      task == dplyr::lag(task) ~ "Repeat",
      TRUE ~ "Switch"
    )
  )
data_miss_cond <- tibble(
  id = rep(1:2, each = 8),
  block = rep(1:8, 2),
  task = "T1",
  type = rep(c(rep("Pure", 2), rep("Repeat", 4), rep("Pure", 2)), 2),
  acc = sample(c(0, 1), 16, replace = TRUE),
  rt = rexp(16, 0.001)
)
data_part_miss_cond <- tibble(
  id = rep(1:2, each = 8),
  block = rep(1:8, 2),
  task = "T1",
  type = c(
    c(rep("Pure", 2), rep("Repeat", 4), rep("Pure", 2)),
    c(rep("Pure", 2), rep("Repeat", 2), rep("Switch", 2), rep("Pure", 2))
  ),
  acc = sample(c(0, 1), 16, replace = TRUE),
  rt = rexp(16, 0.001)
)

test_that("Default behavior works", {
  expect_snapshot(preproc_data(data, switchcost, by = "id"))
})

test_that("All single condition", {
  expect_snapshot(preproc_data(data_miss_cond, switchcost, by = "id"))
})

test_that("Part subject single condition", {
  expect_snapshot(preproc_data(data_part_miss_cond, switchcost, by = "id"))
})

test_that("Works with multiple grouping variables", {
  data <- dplyr::mutate(data, id1 = id + 1)
  expect_snapshot(preproc_data(data, switchcost, by = c("id", "id1")))
})

test_that("Works when character case is messy", {
  data_case_messy <- data %>%
    dplyr::mutate(
      type = dplyr::recode(type, Pure = "pure")
    )
  expect_silent(
    case_messy <- preproc_data(data_case_messy, switchcost, by = "id")
  )
  expect_identical(
    case_messy,
    preproc_data(data, switchcost, by = "id")
  )
})
