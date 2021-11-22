set.seed(1)
n_subject <- 100
data <- tibble::tibble(
  id = seq_len(n_subject),
  n = 14
) |>
  uncount(n, .id = "Trial") |>
  mutate(
    outcome = sample(c(0, 1), n(), replace = TRUE, prob = c(0.2, 0.8))
  ) |>
  group_by(id) |>
  group_modify(
    ~ .x |>
      mutate(
        level = .prepare_level(
          outcome,
          init_level = 3,
          max_level = 8,
          min_level = 2
        ),
        score = ifelse(outcome == 1, level * 100, 0) +
          round(runif(n(), max = level * 100)),
        stepsused = ifelse(outcome == 1, level, 0) +
          sample(0:20, n(), replace = TRUE)
      )
  ) |>
  ungroup()

test_that("Default behavior works", {
  expect_snapshot(preproc(data, london, by = "id"))
})

test_that("Works with multiple grouping variables", {
  data <- mutate(data, id1 = id + 1)
  expect_snapshot(preproc(data, london, by = c("id", "id1")))
})
