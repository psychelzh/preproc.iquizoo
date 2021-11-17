set.seed(1)
n_subject <- 100
data <- expand_grid(
  id = seq_len(n_subject),
  n = sample(0:60, n_subject, replace = TRUE)
) |>
  uncount(n, .id = "trial") |>
  mutate(
    type = sample(
      c("Incongruent", "Congruent"),
      n(),
      replace = TRUE
    ),
    acc = sample(c(0, 1), n(), replace = TRUE),
    rt = rexp(n(), 0.001)
  )
data_miss_cond <- tibble::tibble(
  id = rep(1:2, each = 8),
  type = "Incongruent",
  acc = sample(c(0, 1), 16, replace = TRUE),
  rt = rexp(16, 0.001)
)
data_part_miss_cond <- tibble::tibble(
  id = rep(1:2, each = 8),
  type = c(
    rep("Incongruent", 8),
    rep("Incongruent", 4),
    rep("Congruent", 4)
  ),
  acc = sample(c(0, 1), 16, replace = TRUE),
  rt = rexp(16, 0.001)
)

test_that("Default behavior works", {
  expect_snapshot(preproc_data(data, congeff, by = "id"))
})

test_that("All single condition", {
  expect_snapshot(preproc_data(data_miss_cond, congeff, by = "id"))
})

test_that("Part subject single condition", {
  expect_snapshot(preproc_data(data_part_miss_cond, congeff, by = "id"))
})

test_that("Works with multiple grouping variables", {
  data <- mutate(data, id1 = id + 1)
  expect_snapshot(preproc_data(data, congeff, by = c("id", "id1")))
})

test_that("Works when character case is messy", {
  data_case_messy <- data |>
    mutate(
      type = recode(type, Congruent = "congruent")
    )
  expect_silent(
    case_messy <- preproc_data(data_case_messy, congeff, by = "id")
  )
  expect_identical(
    case_messy,
    preproc_data(data, congeff, by = "id")
  )
})
