set.seed(1)
n_subject <- 5
data <- expand_grid(
  id = seq_len(n_subject),
  n = sample(0:60, n_subject, replace = TRUE)
) |>
  uncount(n, .id = "trial") |>
  mutate(
    type = sample(
      c("incongruent", "congruent"),
      n(),
      replace = TRUE
    ),
    acc = sample(c(0, 1), n(), replace = TRUE),
    rt = rexp(n(), 0.001)
  )
data_miss_cond <- tibble::tibble(
  id = rep(1:2, each = 100),
  type = "incongruent"
) |>
  mutate(
    acc = sample(c(0, 1), n(), replace = TRUE),
    rt = rexp(n(), 0.001)
  )
data_part_miss_cond <- tibble::tibble(
  id = rep(1:2, each = 100),
  type = c(
    rep("incongruent", 100),
    rep("incongruent", 50),
    rep("congruent", 50)
  )
) |>
  mutate(
    acc = sample(c(0, 1), n(), replace = TRUE),
    rt = rexp(n(), 0.001)
  )

test_that("Default behavior works", {
  expect_snapshot_value(
    congeff(data),
    style = "json2",
    tolerance = 1e-5
  )
})

test_that("Works with grouping variables", {
  expect_snapshot_value(
    congeff(data, .by = "id"),
    style = "json2",
    tolerance = 1e-5
  )
})

test_that("All single condition", {
  expect_snapshot_value(
    congeff(data_miss_cond, .by = "id"),
    style = "json2",
    tolerance = 1e-5
  )
})

test_that("Part subject single condition", {
  expect_snapshot_value(
    congeff(data_part_miss_cond, .by = "id"),
    style = "json2",
    tolerance = 1e-5
  )
})
