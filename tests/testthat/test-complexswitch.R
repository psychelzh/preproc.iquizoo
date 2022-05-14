data <- withr::with_seed(
  1,
  expand_grid(
    id = 1:2,
    block = 1:4
  ) |>
    mutate(n = sample(0:50, n(), replace = TRUE)) |>
    uncount(n, .id = "trial") |>
    mutate(
      stimtype = sample(
        c("incongruent", "congruent"),
        n(),
        replace = TRUE
      ),
      task = sample(c("T1", "T2"), n(), replace = TRUE),
      acc = sample(c(0, 1), n(), replace = TRUE),
      rt = rexp(n(), 0.001)
    ) |>
    complete(
      block,
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
        trial == 1 ~ "filler",
        task == lag(task) ~ "repeat",
        TRUE ~ "switch"
      )
    )
)

test_that("Default behavior works", {
  expect_snapshot_value(
    complexswitch(filter(data, id == 1)),
    style = "json2",
    tolerance = 1e-5
  )
})

test_that("Works with grouping variable", {
  expect_snapshot_value(
    complexswitch(data, .by = "id"),
    style = "json2",
    tolerance = 1e-5
  )
})

test_that("Works when condition missing", {
  data_miss_cond <- withr::with_seed(
    1,
    tibble::tibble(
      stimtype = "incongruent",
      tasktype = rep("repeat", 80)
    ) |>
      mutate(
        task = rep(c("T1", "T2"), n() / 2),
        acc = sample(c(0, 1), n(), replace = TRUE),
        rt = rexp(n(), 0.001)
      )
  )
  expect_snapshot_value(
    complexswitch(data_miss_cond),
    style = "json2",
    tolerance = 1e-5
  )
})
